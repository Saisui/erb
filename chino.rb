# BY: saisui@github.com
# PLZ GIME MONEY! I'M POOR
# LIVE IN NO FOOD & NO WARM
# MAY I ALIVE IN LIGHT?
def chino(ss, trim = false, buf: "_buf",
  block: ['{%','%}'], embed: ['{{','}}'], comment: ['{#','#}']
)
  sz_blk_0 = block[0].size
  sz_blk_1 = block[1].size
  sz_emb_0 = embed[0].size
  sz_emb_1 = embed[1].size
  
  rpa = -> (arr) { arr.map { |s| s.gsub(/[\{\[\(\)\]\}]/) { "\\"+_1 } } }
  block = rpa.call block
  embed = rpa.call embed
  comment = rpa.call comment

  ret = ''

  r = trim ? /(?:^\s*)?(#{block[0]}(?:.|\s)*?#{block[1]})\s*\n?|(#{embed[0]}(?:.|\s)*?#{embed[1]})|(?:^\s*)?(#{comment[0]}(?:.|\s)*?#{comment[1]})\s*\n?/
           : /(#{block[0]}(?:.|\s)*?#{block[1]})|(#{embed[0]}(?:.|\s)*?#{embed[1]})|(#{comment[0]}(?:.|\s)*?#{comment[1]})/

  r_cmt = /^#{comment[0]}(?:.|\s)*#{comment[1]}$/
  r_emb = /^#{embed[0]}(?:.|\s)*#{embed[1]}$/
  r_blk = /^#{block[0]}(?:.|\s)*#{block[1]}$/

  ss.split(r).each do |s|
    case s
    when r_emb
      ret << "#{buf} << (#{s[sz_emb_0...-sz_emb_1]}).to_s;\n"
    when r_cmt
    when r_blk
      ret << s[sz_blk_0...-sz_blk_1] << ";\n"
    else
      ret << "#{buf} << #{s.inspect};\n"
    end
  end
  "# encoding: UTF-8\n#{buf} = '';\n" + ret + buf
end
