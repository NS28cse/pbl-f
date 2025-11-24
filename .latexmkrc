#!/usr/bin/env perl

# LuaLaTeX を使用
$pdf_mode = 4;

# 出力ディレクトリ
$out_dir = 'out';

# 注意: %O (自動オプション) は意図的に残していません。
# 一部のフロントエンド（例: VS Code / latex-workshop）が
# 未知のオプション（--max-print-line など）を渡す問題を回避するため、
# 必要なオプションを明示的に指定します。
#
# オプション解説:
#  - -synctex=1       : SyncTeX を有効化（エディタの逆引き/順引き用）
#  - -interaction=nonstopmode : プレビュー中に対話を止めない
#  - -file-line-error  : file:line:error 形式のエラーメッセージ
#  - -recorder         : .fls/.log に依存関係情報を出力
#  - -output-directory : 出力先を統一
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error -recorder -output-directory=' . $out_dir . ' %S';

# プレビュー監視は VS Code 側に任せるため OFF
$preview_continuous_mode = 0;

# 便利なクリーン対象を追加（必要に応じて拡張してください）
$clean_ext .= ' synctex.gz fls fdb_latexmk';