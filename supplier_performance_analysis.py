import pandas as pd

def analyze_supplier_performance(df):
    # Group by Product ID and analyze units ordered vs. units sold
    # This is a simplified approach. In a real scenario, you would need supplier information
    # and potentially lead times, order fill rates, etc.
    supplier_performance = df.groupby(
        ["Product ID", "Category"]
    ).agg(
        total_units_ordered=("Units Ordered", "sum"),
        total_units_sold=("Units Sold", "sum"),
    ).reset_index()

    # Calculate the difference between units ordered and units sold
    supplier_performance["order_fulfillment_discrepancy"] = supplier_performance["total_units_ordered"] - supplier_performance["total_units_sold"]

    # Identify products with significant discrepancies (e.g., more ordered than sold, or vice versa)
    # A positive discrepancy means more was ordered than sold (potential overstock/slow sales or delayed delivery)
    # A negative discrepancy means more was sold than ordered (potential stockout/under-ordering)
    print("\n--- Supplier Performance Inconsistencies (Simplified) ---")
    print("\nProducts with significant positive discrepancy (Ordered > Sold - potential overstock or delayed delivery):")
    print(supplier_performance[supplier_performance["order_fulfillment_discrepancy"] > 0].sort_values(by="order_fulfillment_discrepancy", ascending=False).head())

    print("\nProducts with significant negative discrepancy (Sold > Ordered - potential stockout or under-ordering):")
    print(supplier_performance[supplier_performance["order_fulfillment_discrepancy"] < 0].sort_values(by="order_fulfillment_discrepancy", ascending=True).head())

    return supplier_performance

def main():
    df = pd.read_csv("/home/ubuntu/upload/inventory_forecasting.csv")
    analyze_supplier_performance(df)

if __name__ == "__main__":
    main()


