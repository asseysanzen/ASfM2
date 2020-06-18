class Batch::DataReset
    def self.data_reset
        Purchase.where(buying_status: "カート").delete_all
        p "カートを全て削除しました"
    end
end