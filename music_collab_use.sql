-- creating a view that shows the total amount every user has spent(will spend)
CREATE VIEW user_invoice AS
    SELECT 
        username, CONCAT(SUM(amount), ' ', currency) AS total_amount
    FROM
        user AS u,
        workspace AS w,
        invoice AS i
    WHERE
        u.user_id = w.owner_id
            AND w.workspace_id = i.workspace_id
    GROUP BY username;

-- accessing the created view
SELECT 
    *
FROM
    user_invoice;
    
-- select the best user :)
SELECT 
    username, total_amount
FROM
    user_invoice
WHERE
    total_amount = (SELECT 
            MAX(total_amount)
        FROM
            user_invoice);

-- select top 3 users 
SELECT 
    username, total_amount
FROM
    user_invoice
ORDER BY total_amount DESC
LIMIT 3;
 
-- drop the view
drop view user_invoice;

-- creating a view that counts the number of users with each subscription 
CREATE VIEW subscription_count AS
    SELECT 
        s.plan, COUNT(w.subscription_id) AS count_of_subscriptions
    FROM
        subscription AS s
            JOIN
        workspace AS w ON s.subscription_id = w.subscription_id
    GROUP BY s.plan;

-- accessing the created view
SELECT 
    *
FROM
    subscription_count;
    
-- function that counts the workspaces of a user with a given username
DELIMITER $$

CREATE FUNCTION count_user_workspaces(username VARCHAR(50)) RETURNS INT
BEGIN
    DECLARE user_id INT;
    DECLARE workspace_count INT;

    SELECT u.user_id INTO user_id
    FROM user u
    WHERE u.username = username;

    SELECT COUNT(*) INTO workspace_count
    FROM user_workspace_mapping as uwm
    WHERE uwm.user_id = user_id;

    RETURN workspace_count;
END$$

DELIMITER ;


-- users and the number of their workspaces
SELECT 
    username, COUNT_USER_WORKSPACES(username) AS num_workspaces
FROM
    user;

-- if there were large number of usernames the query would be faster since I created an index on username
SELECT 
    *
FROM
    user
WHERE
    username = 'eminem';

-- trigger that unpublishes the track when the album containing the track gets unpublished(also changes the unpublished at)


DELIMITER $$

CREATE TRIGGER album_status_trigger
AFTER UPDATE ON album
FOR EACH ROW
BEGIN
    IF NEW.published_status = 'unpublished' AND OLD.published_status != 'unpublished' THEN
        UPDATE track
        SET published_status = 'unpublished',
            unpublished_at = NOW()
        WHERE album_id = NEW.album_id;
    END IF;
END$$

DELIMITER ;


drop trigger album_status_trigger;

-- to ensure that they are published
UPDATE album
SET published_status = 'published'
WHERE album_id = 1;

SELECT * FROM album WHERE album_id = 1;

UPDATE track
SET published_status = 'published'
WHERE album_id = 1;

-- before trigger
SELECT * FROM track WHERE album_id = 1;

-- unpublish album to trigger the trigger :)
UPDATE album
SET published_status = 'unpublished'
WHERE album_id = 1;

-- Check the tracks associated with the updated album to see if their status and unpublished_at have changed
SELECT * FROM track WHERE album_id = 1;

-- Find all projects that have at least one associated recording.
SELECT p.*
FROM project p
WHERE EXISTS (
    SELECT 1
    FROM recording r
    WHERE r.project_id = p.project_id
);

-- Get all invoices for workspaces that are subscribed to a specific subscription plan.
SELECT i.*
FROM invoice i
WHERE i.workspace_id IN (
    SELECT w.workspace_id
    FROM workspace w
    JOIN subscription s ON w.subscription_id = s.subscription_id
    WHERE s.plan = 'Premium'
);

-- Find the names of all users who joined a workspace before a certain date.
SELECT u.username
FROM user u
WHERE u.user_id IN (
    SELECT uwm.user_id
    FROM user_workspace_mapping uwm
    WHERE uwm.joined_at < '2023-01-01'
);

-- finds users who have not created any workspaces.
SELECT u.user_id, u.username
FROM user u
LEFT JOIN workspace w ON u.user_id = w.owner_id
WHERE w.workspace_id IS NULL;

-- usernames and tracks of users
SELECT 
    u.username,
    t.track_name
FROM 
    user u
JOIN album_user_mapping aum ON u.user_id = aum.user_id
JOIN album a ON aum.album_id = a.album_id
JOIN track t ON a.album_id = t.album_id
ORDER BY 
    u.username, t.track_name;

-- lists the workspaces of the given username
DELIMITER //
CREATE PROCEDURE get_user_workspaces(IN p_username VARCHAR(50))
BEGIN
    SELECT u.username, w.workspace_name
    FROM user u
    INNER JOIN user_workspace_mapping uwm ON u.user_id = uwm.user_id
    INNER JOIN workspace w ON uwm.workspace_id = w.workspace_id
    WHERE u.username = p_username;
END //
DELIMITER ;

CALL get_user_workspaces('mobbdeep');

