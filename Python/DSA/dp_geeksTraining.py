class Solution:
    def solve(self, arr, lastChoice, summ, n, ans):
        if n==0:
            ans[0] = max(ans[0], summ)
            return

        for i in range(3):
            if lastChoice != -1:
                if lastChoice == i:
                    continue
            self.solve(arr, i, summ + arr[n-1][i], n-1, ans) 

    def maximumPoints(self, arr, n):
        ans = [0] # result
        self.solve(arr, -1, 0, n, ans) 
        return ans[0]

