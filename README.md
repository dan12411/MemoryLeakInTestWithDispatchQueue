# MemoryLeakInTestWithDispatchQueue

## Reference Article
[Testing code that uses DispatchQueue.main.async | iOS Lead Essentials Community Q&A](https://www.essentialdeveloper.com/articles/testing-code-that-uses-dispatchqueue-main-async-ios-lead-essentials-community-qa)

[Thread in course](https://academy.essentialdeveloper.com/courses/447455/lectures/23874028/comments/10584221)

### Question
> "How can I test code that dispatches work to the main DispatchQueue asynchronously? If I remove the thread handling code, my test succeeds."

### Root Cause
1. Because the assertion runs before the `main.async` block.
2. The `DispatchQueue` will hold a reference to `self` until it calls the given closure. After that, it'll release the reference.

### Insight
1. The memory leak test helper *indicates* potential retain cycles -  The assertion fails when the instance under observation is not released within the test method scope.
2. The problem in the project you sent is that the `DispatchQueue` is holding a reference after the test method returns - which can be considered a "test leak."
3. A test leak can affect the result of other tests, so it's essential to clean the memory within the test context. A reliable test suite runs each test in a clean state.

### Solution
1. One way is to weakify `self` within the closure:

```
DispatchQueue.main.async { [weal self] in
 self?.doSomething()
}
```

2. Or not use `DispatchQueue` at all, as explained in above video
3. Use `guarenteeMainThread` method, as explained in above video

```
func guarenteeMainThread(_ work: @escaping () -> Void) {
  if Thread.isMainThread {
    work()
  } else {
    DispatchQueue.main.async(execute: work)
  }
}
```
