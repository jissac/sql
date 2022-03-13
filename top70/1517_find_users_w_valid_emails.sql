# https://leetcode.com/problems/find-users-with-valid-e-mails/

SELECT 
    *
    FROM Users
    WHERE mail
    regexp('^[A-Za-z]+[A-Za-z0-9\_\.\-]*@leetcode[.]com')
    

-- KEY INSIGHT: REGEXP concepts
-- https://leetcode.com/problems/find-users-with-valid-e-mails/discuss/1362794/MySQL%3A-easy-to-understand-usage-of-REGEXP-with-detailed-explanation-and-documentation
-- https://leetcode.com/problems/find-users-with-valid-e-mails/discuss/746476/A-character-by-character-explanation-of-regular-expression
