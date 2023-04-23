Let $P(n)$ be the statement: fib(n)=ϕn−ψn5,fib(n)=5

​ϕn−ψn​, where $\phi = \frac{1+\sqrt{5}}{2}$ and $\psi = \frac{1-\sqrt{5}}{2}$.

We have:
\begin{align*}
P(1): \quad & fib(1) = \frac{\phi^1 - \psi^1}{\sqrt{5}} \
&= \frac{\frac{1+\sqrt{5}}{2} - \frac{1-\sqrt{5}}{2}}{\sqrt{5}} \
&= \frac{\frac{2\sqrt{5}}{2}}{\sqrt{5}} \
&= \frac{\sqrt{5}}{\sqrt{5}} \
&= 1.
\end{align*}

Similarly, for $P(2)$:
\begin{align*}
P(2): \quad & fib(2) = \frac{\phi^2 - \psi^2}{\sqrt{5}} \
&= \frac{\left(\frac{1+\sqrt{5}}{2}\right)^2 - \left(\frac{1-\sqrt{5}}{2}\right)^2}{\sqrt{5}} \
&= \frac{\frac{3+\sqrt{5}}{2} - \frac{3-\sqrt{5}}{2}}{\sqrt{5}} \
&= \frac{\frac{2\sqrt{5}}{2}}{\sqrt{5}} \
&= \frac{\sqrt{5}}{\sqrt{5}} \
&= 1.
\end{align*}

Therefore, $P(1)$ and $P(2)$ are true. Now, assume that $P(m)$ is true for all natural numbers $m$ such that $1 \le m \le k$ for some $k \ge 2$. We need to prove that $P(k+1)$ is also true, i.e., $fib(k+1) = \frac{\phi^{k+1} - \psi^{k+1}}{\sqrt{5}}$.

Since $fib(k+1) = fib(k-1) + fib(k)$ and by the induction hypothesis, $fib(k-1) = \frac{\phi^{k-1} - \psi^{k-1}}{\sqrt{5}}$ and $fib(k) = \frac{\phi^k - \psi^k}{\sqrt{5}}$, we have:
\begin{align*}
fib(k+1) &= fib(k-1) + fib(k) \
&= \frac{\phi^{k-1} - \psi^{k-1}}{\sqrt{5}} + \frac{\phi^k - \psi^k}{\sqrt{5}} \
&= \frac{1}{\sqrt{5}}(\phi^{k-1} - \psi^{k-1} + \phi^k - \psi^k) \
&= \frac{1}{\sqrt{5}}(\phi^{k-1} (\phi + 1) - \psi^{k-1} (\psi + 1)).
\end{align*}

Using $\phi + 1 = \frac{3+\sqrt{5}}{2} = \phi^2$ and $\psi + 1 = \frac{3-\sqrt{5}}{2} = \psi^2$, we can simplify the expression as follows:

15(ϕk−1(ϕ+1)−ψk−1(ψ+1))=15(ϕk−1ϕ2−ψk−1ψ2)=15(ϕk+1−ψk+1)5
​1​(ϕk−1(ϕ+1)−ψk−1(ψ+1))​=5
​1​(ϕk−1ϕ2−ψk−1ψ2)=5

​1​(ϕk+1−ψk+1)​

Therefore, we have shown that $P(k+1)$ is true. By induction, we can conclude that $P(n)$ is true for all natural numbers $n$. This completes the proof that $fib(n) = \frac{\phi^n - \psi^n}{\sqrt{5}}$ for all natural numbers $n$.
