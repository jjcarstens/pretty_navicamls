module PrettyNavicamls
  module Error
    class UnsupportedURL < StandardError
      def message
        "Non-NavicaMLS provided"
      end
    end
  end
end
