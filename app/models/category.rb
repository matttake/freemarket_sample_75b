class Category < ApplicationRecord
  has_many :items
  # ↑categoryモデルは仮実装。後に正規版と結合する。
end
