-- https://platform.stratascratch.com/coding/9608-exclusive-amazon-products

select
    product_name,
    brand_name,
    price,
    rating
from innerwear_amazon_com
where (product_name, mrp) not in
    (
        select
            product_name,
            mrp
        from innerwear_macys_com
        union
        select
            product_name,
            mrp
        from innerwear_topshop_com
    )
