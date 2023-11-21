# frozen_string_literal: true

module ApplicationHelper
  def page_title(title = '')
    base_title = 'illumi-diary'
    title.blank? ? base_title : "#{title} | #{base_title}"
  end

  def default_meta_tags
    {
      site: 'illumi-diary',
      description: 'illumi-diaryは、その日あったポジティブな出来事を3つ記録するための日記アプリです。',
      keywords: 'ポジティブ,日記,記録,アプリ',
      separator: '|',   #Webサイト名とページタイトルを区切るために使用されるテキスト
      og: {
        site_name: :site,
        description: :description,
        type: 'website',
        image: image_url('ogp.webp'),
      },
      twitter: {
        card: 'summary_large_image', # 大きな画像付きのサマリーカード
        image: image_url('ogp.webp'),
      }
    }
  end
end
