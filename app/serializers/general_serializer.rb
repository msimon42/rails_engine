class GeneralSerializer
  def self.render_json(output, attribute)
    {
      data: {
        attributes: {
          attribute => output.to_s
        }
      }
    }
  end
end
