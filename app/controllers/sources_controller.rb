require 'digest'

URL_LENGTH = 5
ALPHABET = ("0".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a

class SourcesController < ApplicationController
  def index
    @all_sources = Source.all
  end

  def show
    @source = Source.find_by(shortened_url: params[:shortened_url])
    unless @source.nil?
      redirect_to @source.original_url
    end
  end

  def create
    original_url = params.require(:original_url)

    # Using hashing:
    # shortcode = Digest::SHA2.hexdigest original_url
    @shortcode = ""

    # Check if this URL already exists, if so, do nothing.
    existing_source = Source.find_by(original_url: original_url)
    unless existing_source.nil?
      logger.debug "Site #{original_url} already exists."
      @shortcode = existing_source.shortened_url
      render :index
      return
    end

    # Using @shortcodes:
    # NOTE! This possibly will never terminate if our database is full.
    # TOOD: Possibly this is insecure to do a string interpolation of user input?
    loop do
      @shortcode = Array.new(URL_LENGTH) { ALPHABET.sample }.join('')
      logger.debug "Shortcode #{@shortcode} generated for #{original_url}"
      exists = Source.find_by(shortened_url: @shortcode)
      break if exists.nil?
      logger.debug "Shortcode #{@shortcode} already exists, generating a new one."
    end

    @source = Source.new(original_url: original_url, shortened_url: @shortcode)

    if @source.save
      render :index
    else
      render :index
    end
  end
end
