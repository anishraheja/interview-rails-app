class DocumentsController < ApplicationController
  before_action :find_document, only: [ :update ]

  def create
    document = Document.create!(document_params)
    document.track_version

    render json: document, status: :created
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error { "Error creating document: " + e.message }
    render json: { error: e.message }, status: :bad_request
  end

  def update
    old_values = {}
    changed_columns = document_params.keys
    changed_columns.each do |column|
      old_values["#{column}"] = @document.send(column)
    end

    if @document.update(document_params)
      changed_values = changed_columns.map do |column|
        {
          "#{column}" => [ old_values[column],
                  document_params[column.to_sym] ]
        }
      end

      @document.track_version(changed_values)

      render json: { document: @document,
                    message: "Document updated successfully" }, status: :ok
    else
      render json: { error: @document.errors.full_messages }, status: :bad_request
    end
  end

  private

  def document_params
    params.require(:document).permit(:title, :content, :user_id, :author_id)
  end

  def find_document
    @document = Document.find_by(id: params[:id])
    render json: { error: "Document not found" }, status: :not_found unless @document
  end
end
