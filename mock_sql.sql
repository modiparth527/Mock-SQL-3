WITH CTE AS(
SELECT o.seller_id,
      o.item_id,
      i.item_brand,
      DENSE_RANK() OVER( PARTITION BY o.seller_id ORDER BY o.order_date) AS rnk
      FROM Orders o
      JOIN
      Items i
      ON o.item_id = i.item_id
)
SELECT u.user_id as 'seller_id',
    CASE
        WHEN c.item_brand = u.favorite_brand THEN 'yes'
        ELSE 'no'
    END as 2nd_item_fav_brand
    FROM Users as u
    LEFT JOIN
    CTE as c
    ON c.seller_id = u.user_id AND c.rnk = 2;
-- SELECT * FROM CTE;