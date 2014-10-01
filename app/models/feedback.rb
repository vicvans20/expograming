class Feedback < ActiveRecord::Base
	has_no_table

	column :name, :string
	column :content, :string
	column :email, :string


	validates_presence_of :name
	validates_presence_of :content
	validates_presence_of :email
	validates_format_of :email,
		:with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
	validates_length_of :content, :maximum => 600

	def store_feedback
		connection = GoogleDrive.login(ENV["GMAIL_USR"],ENV["GMAIL_PASSWD"])
		ss = connection.spreadsheet_by_title('Expograming_feedbacks')
		ss = connection.create_spreadsheet('Expograming_feedbacks') if ss.nil?
		table = ss.worksheets[0]
		last_row = 1 + table.num_rows #Go to the last actual row
		table[last_row,1] = Time.new
		table[last_row,2] = self.name
		table[last_row,3] = self.email
		table[last_row,4] = self.content
		table.save
	end

end