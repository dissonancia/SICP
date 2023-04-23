Let $P(n)$ be the affirmative: $$fib(n) = \frac{\phi^n - \psi^n}{\sqrt{5}}$$

Where $\phi = \frac{1+\sqrt{5}}{2}$ and $\psi = \frac{1-\sqrt{5}}{2}$

$$P(1): fib(1) = \frac{\phi^1 - \psi^1}{\sqrt{5}}$$ \
$$P(1): 1 = \frac{\frac{1+\sqrt{5}}{2} - \frac{1-\sqrt{5}}{2}}{\sqrt{5}} = \frac{\frac{2\sqrt{5}}{2}}{\sqrt{5}} = \frac{\sqrt{5}}{\sqrt{5}} = 1$$ \

$$P(2): fib(2) = \frac{\phi^2 - \psi^2}{\sqrt{5}}$$ \
$$P(2): 1 = \frac{(\frac{1+\sqrt{5}}{2})^2 - (\frac{1-\sqrt{5}}{2})^2}{\sqrt{5}} = \frac{\frac{3+\sqrt{5}}{2} - \frac{3-\sqrt{5}}{2}}{\sqrt{5}} = \frac{\frac{2\sqrt{5}}{2}}{\sqrt{5}} = \frac{\sqrt{5}}{\sqrt{5}} = 1$$ \

$P(1)$ and $P(2)$ are true. Let $k \ge 2$ and supose $P(m)$ is true for all natural $m$, $1 \le m \le k$. We need to prove that $P(k+1)$ is true, i.e, $fib(k+1) = \frac{\phi^{k+1} - \psi^{k+1}}{\sqrt{5}}$ \

As $fib(k+1) = fib(k-1) + fib(k)$ and, by the induction hypothesis, $fib(k-1) = \frac{\phi^{k-1} - \psi^{k-1}}{\sqrt{5}}$ and $fib(k) = \frac{\phi^k - \psi^k}{\sqrt{5}}, then:$ \

$$fib(k+1) = fib(k-1) + fib(k)$$ \
$$fib(k+1) = \frac{\phi^{k-1} - \psi^{k-1}}{\sqrt{5}} + \frac{\phi^k - \psi^k}{\sqrt{5}}$$ \
$$fib(k+1) = \frac{1}{\sqrt{5}}(\phi^{k-1} - \psi^{k-1} + \phi^k - \psi^k)$$ \
$$fib(k+1) = \frac{1}{\sqrt{5}}(\phi^{k-1} (\phi + 1) - \psi^{k-1} (\psi + 1))$$ \

$$\phi + 1 = \frac{3+\sqrt{5}}{2} = \phi^2$$ \
$$\psi + 1 = \frac{3-\sqrt{5}}{2} = \psi^2$$ \

$$fib(k+1) = \frac{1}{\sqrt{5}}(\phi^{k-1}\phi^2 - \psi^{k-1}\psi^2)$$ \
$$fib(k+1) = \frac{1}{\sqrt{5}}(\phi^{k+1} - \psi^{k+1})$$ \
$$fib(k+1) = \frac{\phi^{k+1} - \psi^{k+1}}{\sqrt{5}}$$ \

As demonstrated, $P(n)$ is true for all natural n.
