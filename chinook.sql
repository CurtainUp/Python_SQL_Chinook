-- 1. non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT c.CustomerId, c.FirstName, c.LastName, c.Country
FROM Customer c
WHERE c.Country != "USA"

-- 2. brazil_customers.sql: Provide a query only showing the Customers from Brazil.
SELECT c.CustomerId, c.FirstName, c.LastName, c.Country
FROM Customer c
WHERE c.Country = "Brazil"

-- 3. brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT c.FirstName, c.LastName, i.InvoiceId, i.InvoiceDate, i.BillingCountry
FROM Customer c
JOIN Invoice i on c.CustomerId = i.CustomerId
WHERE c.Country = "Brazil"

-- 4. sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.
SELECT e.firstname, e.lastname, e.title
FROM Employee e
WHERE e.title LIKE "%Sales%Agent%"

-- 5. unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT i.BillingCountry
FROM Invoice i

-- 6. sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT e.FirstName, e.LastName, i.InvoiceId
FROM Employee e, Invoice i
JOIN Customer c ON e.EmployeeId = c.SupportRepId
WHERE i.CustomerId = c.CustomerId
ORDER By e.LastName asc

-- 7. invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT i.InvoiceId, i.Total, c.FirstName, c.LastName, c.Country, e.FirstName, e.LastName
FROM Invoice i
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId
LEFT JOIN Employee e ON c.SupportRepId = e.EmployeeId

-- 8. total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?
  -- 2009
  SELECT COUNT(*) as 2009Invoices
  FROM Invoice i
  WHERE i.InvoiceDate LIKE "2009%"

  -- 2011
  SELECT COUNT(*) as 2011Invoices
  FROM Invoice i
  WHERE i.InvoiceDate LIKE "2011%"

-- 9. total_sales_{year}.sql: What are the respective total sales for each of those years?
  -- 2009
  SELECT SUM(i.Total)
  FROM Invoice i
  WHERE i.InvoiceDate LIKE "2009%"

  -- 2011
  SELECT SUM(i.Total)
  FROM Invoice i
  WHERE i.InvoiceDate LIKE "2011%"

-- 10. invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT COUNT(i.InvoiceId) as NumOfLineItems
FROM InvoiceLine i
WHERE i.InvoiceId = 37

-- 11. line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
SELECT i.InvoiceId, COUNT(i.InvoiceId) as NumOfLineItems
FROM InvoiceLine i
GROUP BY i.InvoiceId

-- 12. line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.
SELECT i.InvoiceLineId, t.Name
FROM InvoiceLine i
LEFT JOIN Track t ON i.TrackId = t.TrackId

-- 13. line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT i.InvoiceLineId, t.Name as "Track Name", ar.Name as "Artist Name"
FROM InvoiceLine i
LEFT JOIN Track t ON i.TrackId = t.TrackId
LEFT JOIN Album al ON t.AlbumId = al.AlbumId
LEFT JOIN Artist ar ON al.ArtistId = ar.ArtistId
ORDER BY i.InvoiceLineId

-- 14. country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT i.BillingCountry, COUNT(i.BillingCountry) as InvoicesPerCountry
FROM Invoice i
GROUP BY i.BillingCountry

-- 15. playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be included on the resulant table.
SELECT p.PlaylistId, p.Name, COUNT(pt.TrackId) as TotalTracks
FROM Playlist p
JOIN PlaylistTrack pt ON p.PlaylistId = pt.PlaylistId
GROUP BY pt.PlaylistId

-- 16. tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
SELECT t.Name, al.Title, mt.Name, g.Name
FROM Track t
LEFT JOIN Album al ON t.AlbumId = al.AlbumId
LEFT JOIN MediaType mt ON t.MediaTypeId = mt.MediaTypeId
LEFT JOIN Genre g ON t.GenreId = g.GenreId

-- 17. invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT *, COUNT(il.InvoiceLineId) as NumOfLineItems
FROM Invoice i
LEFT JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId

-- 18. sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.
SELECT e.FirstName || " " || e.LastName as "Sales Agent", ROUND(SUM(i.Total), 2) as "Total Sales"
FROM Invoice i
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId
LEFT JOIN Employee e ON e.EmployeeId = c.SupportRepId
GROUP BY e.EmployeeId

-- 19. top_2009_agent.sql: Which sales agent made the most in sales in 2009?
SELECT e.FirstName || " " || e.LastName as "Sales Agent", ROUND(SUM(i.Total), 2) as "Total Sales 2009"
FROM Invoice i
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId
LEFT JOIN Employee e ON e.EmployeeId = c.SupportRepId
WHERE i.InvoiceDate LIKE "2009%"
GROUP BY e.EmployeeId
ORDER BY "Total Sales 2009" desc
LIMIT 1

-- 20. top_agent.sql: Which sales agent made the most in sales over all?
SELECT e.FirstName || " " || e.LastName as "Sales Agent", ROUND(SUM(i.Total), 2) as "Total Sales"
FROM Invoice i
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId
LEFT JOIN Employee e ON e.EmployeeId = c.SupportRepId
GROUP BY e.EmployeeId
ORDER BY "Total Sales" desc
LIMIT 1

-- 21. sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.
SELECT e.FirstName || " " || e.LastName as "Sales Agent", COUNT(c.SupportRepId) as "Number of Customers"
FROM Customer c, Employee e
WHERE c.SupportRepId = e.EmployeeId
GROUP BY e.EmployeeId


-- 22. sales_per_country.sql: Provide a query that shows the total sales per country.
SELECT i.BillingCountry, SUM(i.Total) as "Total Sales"
FROM Invoice i
GROUP BY i.BillingCountry

-- 23. top_country.sql: Which country's customers spent the most?
SELECT i.BillingCountry, SUM(i.Total) as "Total Sales"
FROM Invoice i
GROUP BY i.BillingCountry
ORDER BY "Total Sales" desc
LIMIT 1

-- 24. top_2013_track.sql: Provide a query that shows the most purchased track of 2013.
SELECT t.Name, COUNT(il.TrackId) as "Times Purchased 2013"
FROM InvoiceLine il
LEFT JOIN Track t ON il.TrackId = t.TrackId
LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId
WHERE i.InvoiceDate LIKE "2013%"
GROUP BY il.TrackId
ORDER BY "Times Purchased" desc
LIMIT 1

-- 25. top_5_tracks.sql: Provide a query that shows the top 5 most purchased tracks over all.
SELECT t.Name, COUNT(il.TrackId) as "Times Purchased"
FROM InvoiceLine il
LEFT JOIN Track t ON il.TrackId = t.TrackId
LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId
GROUP BY il.TrackId
ORDER BY "Times Purchased" desc
LIMIT 5

-- 26. top_3_artists.sql: Provide a query that shows the top 3 best selling artists.
SELECT a.Name, ROUND(SUM(il.UnitPrice), 2) as "Total Sales"
FROM InvoiceLine il
LEFT JOIN Track t ON il.TrackId = t.TrackId
LEFT JOIN Album al ON t.AlbumId = al.AlbumId
LEFT JOIN Artist a ON al.ArtistID = a.ArtistId
GROUP BY a.ArtistId
ORDER BY "Total Sales" desc
LIMIT 3

-- 27. top_media_type.sql: Provide a query that shows the most purchased Media Type.
SELECT mt.Name, COUNT(t.MediaTypeId) as "Times Purchased"
FROM Track t
JOIN InvoiceLine il ON t.TrackId = il.TrackId
LEFT JOIN MediaType mt ON t.MediaTypeId = mt.MediaTypeId
GROUP BY mt.MediaTypeId
ORDER BY "Times Purchased" desc
LIMIT 1
