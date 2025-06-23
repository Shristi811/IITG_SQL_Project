import pandas as pd

def recommend_stock_adjustments(df):
    # Calculate average inventory level and average units sold for each product
    product_summary = df.groupby(
        ["Product ID", "Category"]
    ).agg(
        average_inventory_level=("Inventory Level", "mean"),
        total_units_sold=("Units Sold", "sum"),
    ).reset_index()

    # Calculate a simple inventory turnover proxy (total units sold / average inventory level)
    # Add a small epsilon to avoid division by zero
    epsilon = 1e-6
    product_summary["inventory_turnover_proxy"] = product_summary["total_units_sold"] / (product_summary["average_inventory_level"] + epsilon)

    # Identify fast-moving and slow-moving products based on inventory turnover proxy
    # Products with higher turnover are fast-moving, lower turnover are slow-moving
    turnover_threshold_fast = product_summary["inventory_turnover_proxy"].quantile(0.75)
    turnover_threshold_slow = product_summary["inventory_turnover_proxy"].quantile(0.25)

    fast_moving = product_summary[product_summary["inventory_turnover_proxy"] >= turnover_threshold_fast]
    slow_moving = product_summary[product_summary["inventory_turnover_proxy"] <= turnover_threshold_slow]

    print("\n--- Stock Adjustment Recommendations ---")

    print("\nFast-Moving Products (Consider increasing stock to avoid stockouts and meet demand):")
    print(fast_moving.sort_values(by="inventory_turnover_proxy", ascending=False).head())

    print("\nSlow-Moving Products (Consider reducing stock to lower holding costs and free up capital):")
    print(slow_moving.sort_values(by="inventory_turnover_proxy", ascending=True).head())

    return fast_moving, slow_moving

def main():
    df = pd.read_csv("/home/ubuntu/upload/inventory_forecasting.csv")
    recommend_stock_adjustments(df)

if __name__ == "__main__":
    main()


