### Example of test progress

So while testing, I've made here are [some screenshots](TestInsight-Session-Example.md) to fix my CalculatorUnit tests example at

1. At first, no tests are visible.
  ![1. TestInsight never ran](TestInsight-00-never-ran.png)

2. After pressing `Run all`, the registered tests become visible:
  ![2. TestInsight after first](TestInsight-01-after-first-run.png)

3. Enabling all tests is just one click in the [Virtual TreeView](https://github.com/virtual-treeview/virtual-treeview):
  ![TestInsight-02-enable-all.png](TestInsight-02-enable-all.png)

4. After running all tests, you see which fail almost all!
   Especially watch the first failure: why does it fail that way?
  ![TestInsight-03-run-all.png](TestInsight-03-run-all.png)

5. Grouping by text fixture often makes the view easier when fixing logic or tests:
  ![TestInsight-04-run-all-by-fixture.png](TestInsight-04-run-all-by-fixture.png)

6. Always returning 3 fixes two tests:
  ![TestInsight-05-first-fix.png](TestInsight-05-first-fix.png)

7. A simple fix: simple if statement returning 2 values fixes one more test:
  ![TestInsight-06-second-so-called-fix.png](TestInsight-06-second-so-called-fix.png)

8. After refactoring the fix into the wrong algorithm, more tests fail:
  ![8. TestInsight after implementing the  wrong algorithm](TestInsight-07-wrong-algorithm.png)

9. The algorithm is now correct: all tests succeed!
  ![9. TestInsight choosing the correct algorithm.png](TestInsight-08-correct-algorithm.png)
