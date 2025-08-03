# Properties

1. Should never transfer tokens to the target if he is above the minimum threshold
2. The Admin should be able to withdraw any amount equal or lesser than the contract balance.
3. Contract balance should only decrease after a call to `topUp()` or `withdraw()`.