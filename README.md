# Overview 
Bright Coffee Shop has a new CEO whose mission is to grow revenue and improve product performance. This case study analyses six months of daily till transactions (149,116 transactions across three New York stores) to show which products earn the most, when the store performs best, how sales are trending, and what the business should do next.

The project follows a complete analytics workflow: planning in Miro (data-flow diagram) with a project Gantt chart, data processing with SQL in Databricks, analysis in Excel with pivot tables and charts, an interactive sales dashboard, and a CEO presentation in PowerPoint with recommendations. Headline result: revenue of $698,812, doubling from January to June, driven by Coffee and Tea and by a very strong morning rush.

# Objectives
1.	Identify which products and categories generate the most revenue, and which perform poorly.
2.	Find what time of day the store performs best.
3.	Analyse sales trends across products, time intervals, months, days and stores.
4.	Provide actionable recommendations to improve sales performance and a roadmap of next steps.

# Data
The dataset “Bright Coffee Shop Sales” contains one row per transaction line. It was supplied as an Excel workbook and converted to CSV 
Field	Description
1. transaction_id: Unique ID of the transaction
2. transaction_date: Date of sale (2023-01-01 to 2023-06-30)
3. transaction_time: Time of sale (06:00 – 20:59)
4. transaction_qty: Number of units sold (1 – 8)
5. store_id / store_location: Store identifier and name (Astoria, Lower Manhattan, Hell’s Kitchen)
6. product_id: Product identifier
7. unit_price: Price per unit (0.80 – 45.00); stored with a decimal comma, e.g. 3,1
8. product_category: 9 categories (e.g. Coffee, Tea, Bakery)
9. product_type: 29 product types (e.g. Barista Espresso, Scone)
10. product_detail: 80 specific products, many with a size suffix (Sm / Rg / Lg)

# Summary Statistics
Headline KPIs -Metric	Value
1. Total revenue: $698,812.33
2. Total units sold: 214,470
3. Transactions: 149,116
4. Trading days: 181
5. Average revenue per day: R3,860.84
6. Average transaction value: R4.69
7. Units per transaction: 1.44
8. Single-item transactions: 58.5%

# Methodology
1.	Plan (Miro): designed the data-flow and architecture diagram, listed the key insights and calculations, and built a project Gantt chart.
2.	Prepare: converted the Excel file to CSV and loaded it unchanged into Databricks as a Bronze table (all columns as text).
3.	Clean and transform (Silver): replaced decimal commas in unit_price and cast it to a decimal; cast dates and quantities; checked for nulls and duplicates; created total_amount = unit_price × transaction_qty, transaction_time_bucket (30-minute intervals), a 3-hour time slot, month, weekday and cup-size columns.
4.	Analyse (Gold): used SQL to group by category, product type, product detail, time bucket, month, weekday and store; ranked products; calculated shares and month-on-month growth.
5.	Visualise: exported the processed table to Excel and built pivot tables and charts, plus a dashboard in Power BI.
6.	Communicate: prepared a CEO presentation with insights, recommendations and next steps

# Key Insights 
1. Coffee and Tea drive the business: together 66.7% of revenue (Coffee R270.0k, Tea R196.4k). Bakery and Drinking Chocolate add another 22%.
2. Best-selling product types: Barista Espresso (R91.4k), Brewed Chai tea (R77.1k), Hot chocolate (R72.4k) and Gourmet brewed coffee ($70.0k).
3. Low performers: Packaged Chocolate, Loose Tea, Branded and Flavours together make up only 5.4% of revenue. Flavours sells many units (10,511) at R0.80 each, while Coffee beans earn R40.1k from only 1,828 units.
4. Morning peak: 08:00–10:59 produces 36.7% of revenue; the best 30-minute interval is 10:30 (R44,967).
5. Flat afternoon: after 11:00 revenue per interval falls by about half to roughly R20k and stays there until closing. This 11:00–18:29 plateau is worth R310.7k (44.5% of revenue) and is the biggest opportunity. Trading from 20:00 is almost negligible (0.4%).
6. Strong growth: monthly revenue rose 104% from January (R81.7k) to June (R166.5k), driven by more customers; growth slowed in June (+6.2%).
7. Stores and days are balanced: the three stores are within 2.8% of each other and no weekday is weak, so the opportunity lies in time of day, not location or day.
8. Small baskets: 58.5% of transactions contain one item and the average ticket is R4.69. Large cups earn the most revenue (R238.0k) from fewer units than Regular.

# Recommendations
1. Fill the afternoon: coffee-or-tea plus bakery bundles, off-peak offers and a 15:00–17:00 happy hour to lift the flat 11:00–18:00 plateau.
2. Power the morning rush: raise par levels for the top four product types before 08:00, staff to the 08:00–11:00 peak and add mobile pre-ordering.
3. Promote slow sellers: add-on prompts for syrups, take-home beans and tea at the till, and review the weakest items (Green beans, Green tea, Organic Chocolate), tested for eight weeks.
4. Grow basket size: meal deals and upsizing to Large, aiming to lift the $4.69 average ticket towards $5.
5. Store-specific playbooks: Lower Manhattan – test evening offers or shorter hours; Astoria – trial a 06:00 opening; Hell’s Kitchen – grow coffee-beans retail and review trading after 20:00 against staffing costs.
6. Next steps: automate daily sales reporting, track performance across locations, and launch a loyalty programme built around peak time slots.

# Tools Used
1. Miro: Data-flow and architecture diagram, key insights and calculation plan, project Gantt chart
2. Microsoft Excel: Excel-to-CSV conversion, pivot tables and charts, Excel dashboard
3. Databricks (Delta Lake): Storage of Bronze, Silver and Gold tables
4. SQL (Databricks SQL): Data cleaning, transformation, aggregation and ranking
5. HTML/JavaScript: Interactive dashboard
6. Microsoft PowerPoint : CEO presentation
7. Microsoft Word: Methodology and project documentation
8. GitHub: Version control and project submission

# Repository Contents
1. Project Description & Raw Data: Bright_Coffee_Shop___Case_Study_Description.pdf and Bright_Coffee_Shop_Sales_Database_raw_data.csv
2. Project Planning: Bright_Coffee_Shop_Miro_Flowchart_Planning_and_Data_Processing.pdf and Bright_Coffee_Shop_Gantt_Chart.xlsx
3. Data Processing: Bright_Coffee_Shop_Case_Study.SQL_File.sql, Bright_Coffee_Shop_Excel_Analysis.xlsx (pivot tables and graphs) and Bright_Coffee_Shop_Processed_Data.csv
4. Project Presentation: Bright_Coffee_Shop_CEO_Presentation.pptx and Bright_Coffee_Shop_Sales_Dashboard.html (download, then open in a web browser)








