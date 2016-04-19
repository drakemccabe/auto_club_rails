class AddPaymentFields < ActiveRecord::Migration
  def change
    add_column :drivers, :cost_paid, :float
    add_column :drivers, :payment_method, :string
    add_column :drivers, :ref_code, :string
  end
end
