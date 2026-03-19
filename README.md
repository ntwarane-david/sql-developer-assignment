## Approach

For this assignment, I ntwarane david used a hands-on approach by practicing each concept directly in Oracle. so I started with simple tasks like variables and printing, then gradually moved to more advanced topics such as conditions, loops, and cursors. Whenever I faced errors, I took time to debug and understand the problem instead of skipping it. This helped me clearly understand how Oracle behaves.

## Lessons Learned

-IN Task 1.1: Variables & Printing
I learned that Oracle does not display BOOLEAN values directly. To show TRUE or FALSE, I need to use a CASE expression or an IF statement to convert the result into readable text.

-IN Task 1.2: SELECT INTO Basics
I realized that SELECT INTO can fail if no record is found. To avoid this, I now use specific WHERE conditions and handle errors using EXCEPTION blocks.

-TN Task 1.3: Understanding %TYPE
Using %TYPE helped me avoid hardcoding data types. It allows variables to automatically match the table column type, making the code easier to maintain.

-IN Task 2.1: Math & Formatting
I learned how to use TO_CHAR to format numbers properly, especially for financial values. This makes outputs clean and readable.

- IN Task 2.2: IF/ELSIF Logic
I understood that the order of conditions is important. Starting with the highest condition ensures correct results.

- IN Task 2.3: Enabling Output
I learned that I must use SET SERVEROUTPUT ON to see output from my code.

- IN Task 3.1: Compound Conditions (AND/OR)
I learned to use parentheses to group conditions correctly and avoid logical mistakes.

- IN Task 3.2: Handling NULLs
I discovered that NULL cannot be compared using =. Instead, I must use IS NULL or IS NOT NULL.

-IN Task 3.3: Simple CASE Statements
I learned that Simple CASE works only for exact matches, while conditions and ranges require a searched CASE.

- IN Task 4.1: Searched CASE & Inline Logic
I learned that inline CASE statements can replace long IF/ELSE blocks, making code shorter and cleaner.

- IN Task 4.2: Basic LOOP & Exit Conditions
I understood the importance of EXIT WHEN to prevent infinite loops.

-IN Task 4.3: WHILE Loops & Cursors
I learned to use %FOUND in WHILE loops to control when to stop fetching records.

-IN Task 5: Nested FOR Loops
I learned that nested loops are efficient when used with simple ranges, but heavy operations inside inner loops should be avoided.

## Challenges Faced

-SELECT INTO errors when no data is found

-Confusion when working with NULL values

-Writing correct logical conditions using AND and OR

-Managing cursors (open, fetch, close)

-Avoiding infinite loops

-Formatting output correctly

## Conclusion

-This assignment helped me improve my understanding of Oracle SQL and PL/SQL. I became better at debugging errors, writing logical conditions, and structuring clean and efficient code.
