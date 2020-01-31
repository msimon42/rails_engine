class GeneralSerializer
  def self.render_json(output, attribute)
    {
      data: {
        attribute => output
      }
    }
  end
end
