# -*- coding: utf-8 -*-

Plugin.create(:mikutter_shinchoku_now) do
  match_shinchoku = /^(?!RT).*(進捗|しんちょく)(ダメ|だめ)です.*$/iu  
  shinchoku_text = <<-"EOS"
♪ヽ〇ﾉ♪ 進捗なーぅ！
　　 ）へ  
　  く 
EOS

  onupdate do |service,message|
    message.each do |m|
      if !m.message.retweet? && match_shinchoku =~ m.message.to_s
	update_text = "@#{m.message.user.idname} \n"
	update_text << shinchoku_text
	Service.primary.post(:message => update_text,
	             :replyto => m.message)
      end
    end
  end
end