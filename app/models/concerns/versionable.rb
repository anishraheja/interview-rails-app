module Versionable
  extend ActiveSupport::Concern

  included do
    has_many :versions, as: :versionable, dependent: :destroy
  end

  def create_version(changed_values = nil, object)
    if changed_values.nil?
      Version.create(
        versionable_id: object.id,
        versionable_type: object.class.name
      )
    else
      Version.create(
        khanges: changed_values,
        versionable_id: object.id,
        versionable_type: object.class.name
      )
    end
  end

  def revert_to_version(version_id)
    version = versions.find_by(id: version_id)
    return unless version

    version.khanges.each do |attribute|
      self.send("#{attribute.keys.first}=", attribute.values.first.last) if self.respond_to?("#{attribute.keys.first}=")
    end

    save!
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error { "Error reverting to version #{version_id}: " + e.message }
    false
  end
end
