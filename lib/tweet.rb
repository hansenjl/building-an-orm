class Tweet
    attr_accessor :content, :author
    attr_reader :id

    def initialize(attr_hash = {})
        @id = attr_hash['id']
        @content = attr_hash['content']
        @author = attr_hash['author']
    end


    def self.create(attr_hash = {})
       instance =  self.new(attr_hash)
       instance.save
       instance
    end

    def self.all # array on objects
       sql = <<-SQL
            SELECT * FROM tweets;
       SQL
       data = DB.execute(sql)
       data.map do |tweet_hash|
            self.new(tweet_hash)
       end
    end

    def self.last
        sql = <<-SQL
                SELECT * FROM tweets;
        SQL
        data = DB.execute(sql)
        data.map do |tweet_hash|
            self.new(tweet_hash)
        end
    end


    def save
        # check if it is already saved
        if !!self.id   # && Tweet.find(self.id)
            sql = <<-SQL
                UPDATE tweets
                SET content = ?, author = ?
                WHERE id = ?;
            SQL
            DB.execute(sql,self.content, self.author, self.id)
            #update the value
        else
            # insert new entries into the db
            sql = <<-SQL
                INSERT INTO tweets (content, author) VALUES (?,?)
            SQL
            DB.execute(sql, self.content, self.author)
            @id = DB.last_insert_row_id
            # @id = DB.execute('SELECT id FROM tweets')[-1][0]
        end
        self
    end

    def self.create_table
        sql = <<-SQL
            CREATE TABLE IF NOT EXISTS tweets (
                id INTEGER PRIMARY KEY,
                content TEXT,
                author TEXT
            );
        SQL
        DB.execute(sql)
    end

end