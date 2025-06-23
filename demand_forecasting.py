import pandas as pd
from statsmodels.tsa.seasonal import seasonal_decompose
import matplotlib.pyplot as plt

def forecast_demand_trends(df):
    # Convert 'Date' column to datetime objects
    df["Date"] = pd.to_datetime(df["Date"])

    # Aggregate data by date and product for demand forecasting
    # For simplicity, let's aggregate total units sold per day across all products
    # In a real scenario, you would forecast demand for each product individually
    daily_sales = df.groupby("Date")["Units Sold"].sum().reset_index()
    daily_sales = daily_sales.set_index("Date")

    # Resample to a daily frequency and fill missing values (if any) with 0
    daily_sales = daily_sales.resample("D").sum().fillna(0)

    # Perform seasonal decomposition if enough data points are available (at least 2 full cycles)
    # Assuming a weekly seasonality for now, as typical for retail
    # If data is monthly, use period=12, if quarterly, use period=4
    # The dataset is daily, so a weekly period (7) makes sense for seasonality
    if len(daily_sales) >= 2 * 7: # At least two weeks of data for weekly seasonality
        try:
            decomposition = seasonal_decompose(daily_sales["Units Sold"], model='additive', period=7)
            fig = decomposition.plot()
            fig.set_size_inches(10, 8)
            plt.tight_layout()
            plt.savefig("demand_decomposition.png")
            plt.close()
            print("\n--- Demand Trend Decomposition Plot Saved to demand_decomposition.png ---")
        except Exception as e:
            print(f"Could not perform seasonal decomposition: {e}")
            print("Not enough data points or period is too large for the given data.")
    else:
        print("Not enough data to perform seasonal decomposition with a weekly period.")

    # Simple moving average forecast for the next 7 days
    # This is a very basic forecast. More advanced models (ARIMA, Prophet) would be used in production.
    window_size = 30 # Use last 30 days for moving average
    if len(daily_sales) >= window_size:
        daily_sales["Moving_Average_Demand"] = daily_sales["Units Sold"].rolling(window=window_size).mean()
        last_30_days_avg = daily_sales["Moving_Average_Demand"].iloc[-1]
        print(f"\n--- Simple Moving Average Forecast (Next 7 Days) ---")
        print(f"Estimated daily demand for the next 7 days: {last_30_days_avg:.2f} units")
    else:
        print(f"Not enough data to calculate {window_size}-day moving average.")

    return daily_sales

def main():
    df = pd.read_csv("/home/ubuntu/upload/inventory_forecasting.csv")
    forecast_demand_trends(df)

if __name__ == "__main__":
    main()


