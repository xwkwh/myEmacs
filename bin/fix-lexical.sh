#!/bin/bash
# 安全批量添加lexical-binding声明（无备份文件版）
# 执行命令：bash fix-emacs-lexical.sh

# 配置目录路径（修改为您实际的路径）
CONFIG_DIR="$HOME/.emacs.d/conf"

# 计数器
fixed_count=0
skipped_count=0

find "$CONFIG_DIR" -name "*.el" -print0 | while IFS= read -r -d '' file; do
  # 检查文件是否可写
  if [ ! -w "$file" ]; then
    echo "⚠️  Skipped (read-only): $file"
    ((skipped_count++))
    continue
  fi

  # 检查是否已包含lexical-binding声明（精确匹配）
  if grep -q '^;;; -\*- lexical-binding: [tf]; -\*-$' "$file" ||
     grep -q '^# -\*- lexical-binding: [tf]; -\*-$' "$file"; then
    echo "✓ Skipped (already declared): $file"
    ((skipped_count++))
    continue
  fi

  # 临时文件处理
  temp_file="${file}.temp"
  added=false

  # 处理带Shebang的文件
  if head -1 "$file" | grep -q '^#!'; then
    {
      head -1 "$file"
      echo ";;; -*- lexical-binding: t; -*-"
      tail -n +2 "$file"
    } > "$temp_file" && added=true
  else
    # 直接添加在文件开头
    {
      echo ";;; -*- lexical-binding: t; -*-"
      cat "$file"
    } > "$temp_file" && added=true
  fi

  # 原子操作替换原文件
  if $added; then
    if mv -f "$temp_file" "$file"; then
      echo "✅ Fixed: $file"
      ((fixed_count++))
    else
      echo "❌ Failed to update: $file" >&2
      rm -f "$temp_file"
      ((skipped_count++))
    fi
  fi
done

# 输出统计结果
echo "======================================"
echo "修复完成!"
echo "已处理文件: $((fixed_count + skipped_count))"
echo "成功添加声明: $fixed_count"
echo "已跳过文件: $skipped_count"
