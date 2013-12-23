class NoSubdomainRoute

  def self.matches?(request)
    !request.subdomain.present? || request.subdomain == "bbrainbox"
  end

end