require "csv" # CSVファイルを扱うためのライブラリを読み込んでいます

loop do
  puts "（以下より選択）1 または 2 を入力してください\n1 → 新規でメモを作成する / 2 → 既存のメモを編集する"
  memo_type = gets.to_i 
  # if文を使用して続きを作成していきましょう。
  # 「memo_type」の値（1 or 2）によって処理を分岐させていきましょう。
  if memo_type == 1
    puts "拡張子を除いたファイル名を入力してください"
    memo_name = gets.chomp
    puts "メモの内容を記入してください\n複数行入力できます。入力後、Ctrl+Dで保存します。"
    memo_content = $stdin.readlines
  
    CSV.open("#{memo_name}.csv",'w') do |csv|
      csv << [memo_content]
    end
  
    puts "メモが保存されました！"
    break
  elsif memo_type == 2
    loop do
      puts "どのメモを編集しますか？\n拡張子を除いたファイル名を入力してください。"
      puts Dir.glob('*.csv')
      memo_name = gets.chomp
      if File.exist?("#{memo_name}.csv")
        break
      else
        puts "【エラー】該当する既存のファイルがありません"
      end
    end
    puts "メモの内容を記入してください\n複数行入力できます。入力後、Ctrl+Dで保存します。"
    memo_content = $stdin.readlines
  
    CSV.open("#{memo_name}.csv",'a') do |csv|
      csv << [memo_content]
    end
  
    puts "メモが追記されました！"
    break
  else
    puts "【エラー】不正な値です"
  end
end

