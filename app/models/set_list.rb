class SetList < ActiveRecord::Base
  belongs_to :artist
  has_many :set_list_items, -> { order("position ASC") }
  has_many :songs, through: :set_list_items

  alias_method :items, :set_list_items

  validates_presence_of :name

  def pp
    ret = name + "\n"
    set_list_items(true).each do |item|
      ret += "#{item.position}. #{item.song.title}".ljust(25)
      ret += "Tags: #{item.song.tag_list.join(', ')}\n"
    end
    print ret
  end

  # smart_sort should make the following decisions:
  # 1. Shuffle the list of songs
  # 2. Find an opener and move it to the top
  # 3. Find a closer and move to the bottom
  # 4. Group tuning tags together
  def smart_sort
    raise ArtistMissingException, "An artist is required to generate a SetList!" unless artist_id
    song_pool = songs.empty? ? artist.songs(true).to_a : songs(true).to_a
    shuffle!

    opener = take_song_by_tag('opener', song_pool)
    if opener.present?
      set_list_items.find_by_song_id(opener.id).move_to_top
    else
      # TODO: ensure number 1 spot isn't taken by !opener
    end

    closer = take_song_by_tag('closer', song_pool)
    if closer.present?
      set_list_items.find_by_song_id(closer.id).move_to_bottom
    else
      # TODO: ensure closing spot isn't taken by !closer
    end
    pp
  end

  def shuffle!
    sql = ''
    ordered_positions = set_list_items.pluck(:position).sort
    set_list_items.pluck(:id).shuffle.each_with_index do |id, index|
      sql += "when (id=#{id}) then #{ordered_positions[index]} "
    end
    SetListItem.update_all(['position=case', sql, 'end'].join(' '))
    items.reload
  end

  # Search for songs that have a given tag *and* do not have that tag's complement
  # and return a random one.
  def take_song_by_tag(tag, song_pool=nil)
    song_pool ||= self.songs
    neg_tag = (tag =~ /^!/) == 0 ? tag[1..-1] : '!'+tag
    candidates = song_pool.select{ |s| s.tagged_with?(tag) && !s.tagged_with?(neg_tag) }
    if candidates.empty?
      nil
    else
      candidates[rand(candidates.size)]
    end
  end

  private

  # WIP
  # Idea is to be leveraged the other find_[tag] methods
  def filter_song_pool_by_tag(song_pool, tag)
    song_pool.select{ |s| s.tagged_with?(tag) }
  end

  def fresh_bank
    songs(true)
  end
end

class ArtistMissingException < StandardError
end