import pandas as pd

def analyze_products(df):
    # Calculate total units sold for each product
    product_sales = df.groupby('Product ID')['Units Sold'].sum().reset_index()
    product_sales = product_sales.sort_values(by='Units Sold', ascending=False)

    # Categorize products as fast-selling or slow-moving (example threshold)
    # This threshold can be adjusted based on business needs
    sales_threshold = product_sales['Units Sold'].quantile(0.75) # Top 25% as fast-selling

    fast_selling_products = product_sales[product_sales['Units Sold'] >= sales_threshold]
    slow_moving_products = product_sales[product_sales['Units Sold'] < sales_threshold]

    print("\n--- Fast-Selling Products ---")
    print(fast_selling_products.head())

    print("\n--- Slow-Moving Products ---")
    print(slow_moving_products.head())

    return fast_selling_products, slow_moving_products

def main():
    df = pd.read_csv('/home/ubuntu/upload/inventory_forecasting.csv')
    fast_selling, slow_moving = analyze_products(df)

if __name__ == '__main__':
    main()


