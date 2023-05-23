# ARフォルダをデータベースとして指定した組の平均、標準偏差、MAX、MINを計算

ARフォルダ内の違うフォルダ同士のデータの演算ができるため、例えば以下のようなことができます。
* 時間ごとに全ての装置全てのデータの平均を取って時間影響を見る
* 日付ごとに全ての装置全てのデータの平均を取って日差影響を見る
* 温度環境ごとに全ての装置全てのデータの平均を取って温度影響を見る
* 同じ条件での装置間の標準偏差を見る
 
# 実行例

パラメータ設定

![cap_param](https://raw.githubusercontent.com/ShiraoTakuya/Ruby_Repositories/main/HyperDimensionalArray/cap_param.PNG)

実行結果

![cap_results](https://raw.githubusercontent.com/ShiraoTakuya/Ruby_Repositories/main/HyperDimensionalArray/cap_results.PNG)
 
# Requirement
 
RubyXLが必要です。

```bash
gem install rubyXL -v 3.3.29
```
 
# Usage

以下の手順を行う
* ARフォルダ内を自由に階層分けをして自由にデータ(.txt)を入れる
* SET_PARAM.xlsxに平均したい組み合わせを入れる
* Run.cmdを実行する
 
# Author
  
* ShiraoTakuya
