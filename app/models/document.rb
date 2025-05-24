class Document < ApplicationRecord
  include Versionable

  belongs_to :user

  def track_version(changed_values = nil)
    create_version(changed_values, self)
  end
end


=begin
Task Description:

doc = Document.create(title: "Initial", content: "Hello world")
# Version 1
doc.update(content: "Hello Ruby", user_id: 5)
# => Version 2: content changed from "Hello world" to "Hello Ruby"

doc.update(title: "Updated Title", user_id: 7)
# => Version 3: title changed from "Initial" to "Updated Title"

# Query history
doc.version_history
# => [
#   { version: 1, changes: nil },
#   { version: 2, changes: { content: ["Hello world", "Hello Ruby"], title: ['old value', 'current value'] }, user_id: 5, timestamp: ... },
#   { version: 3, changes: { title: ["Initial", "Updated Title"] }, user_id: 7, timestamp: ... }
# ]

# Revert to version 2
doc.revert_to_version(2)
# => doc is now back to title: "Initial", content: "Hello Ruby"
=end
