class ChatGptService
  require "openai"

  def initialize
    @client = OpenAI::Client.new(
      access_token: Rails.application.credentials.dig(:openai, :api_key)
    )
  end

  def get_city_category(prefecture, city)

    prompt = <<-TEXT
      #{prefecture}、#{city}に関する情報を答えてください。

      回答形式は以下の通りにしてください:

      ・人口：（人口数及びそのデータの基準時点）
      ・都市区分：上記の人口をもとに（大都市/中都市/小都市A/小都市B）を以下の条件から選択。
        大都市：政令指定都市および東京都区部
        中都市：大都市を除く人口15万以上の市
        小都市A：人口5万以上15万未満の市
        小都市B：人口5万未満の市
      
      都市区分を判別した理由を日本語でシンプルに回答してください。
      回答形式に関する内容と関係がないことは回答しないでください。

    TEXT

    response = @client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "user", content: prompt }
        ],
        temperature: 0.2,
      }
    )
    response.dig("choices", 0, "message", "content")
  end
end