---
marp: true
size: 4:3
math: katex
theme: beam
header: 排序
footer: 算法设计与分析
---

<!-- _class: title -->
# 排序

---

# 推荐网站
以下为推荐阅读的网站，本ppt大量引用了这些网站的内容：  \\
- [https://www.hello-algo.com/chapter_sorting/](https://www.hello-algo.com/chapter\_sorting/)
- [https://oi-wiki.org/basic/sort-intro/](https://oi-wiki.org/basic/sort-intro/)

---

# 什么是排序
排序算法（Sorting algorithm）是一种将一组特定的数据按某种顺序进行排列的算法。

---

# 排序的几个基本指标
- 时间复杂度  
即对于输入规模n来说，排序需要多久可以完成。
- 空间复杂度  
即对于输入规模n来说，排序需要耗费多少内存空间。
- 稳定性  
当排序完成后，原本相同的元素顺序是否会发生变化。

---

# 排序算法的分类
<div style="font-size: 24px">

从是否需要进行元素间的比较来看，分为：
- 基于比较的排序  
选择排序、冒泡排序、插入排序、归并排序、快速排序等
- 不基于比较的排序  
计数排序、基数排序、*桶排序
<br>

从是否在内存中完成排序，即是否借助硬盘等外部存储完成排序来看，分为：
- 内部排序  
排序的流程全部在内存中完成
- 外部排序  
排序的流程需要借助外部的存储设备，通常用在数据量较大的情况

</div>

---

# 选择排序
选择排序的核心思想是基于查找序列中的最小/最大值的。  <br>
每次找到序列中最小/最大的值，将其放在开头或者末尾。之后在排除这个数的序列中，继续查找最小/最大的值，将其放在这个子序列的开头或者末尾，依次类推，直到子序列长度为1即可。

---

# 选择排序
```python
def selection_sort(nums: list[int]):
    """选择排序"""
    n = len(nums)
    # 外循环：未排序区间为 [i, n-1]
    for i in range(n - 1):
        # 内循环：找到未排序区间内的最小元素
        k = i
        for j in range(i + 1, n):
            if nums[j] < nums[k]:
                k = j  # 记录最小元素的索引
        # 将该最小元素与未排序区间的首个元素交换
        nums[i], nums[k] = nums[k], nums[i]
```
<div style="text-align:center; font-size: 48px; color: blue;">
时间复杂度？空间复杂度？
</div>

---

# 选择排序
<br>

```python
def selection_sort(nums: list[int]):
    """选择排序"""
    n = len(nums)
    # 外循环：未排序区间为 [i, n-1]
    for i in range(n - 1):
        # 内循环：找到未排序区间内的最小元素
        k = i
        for j in range(i + 1, n):
            if nums[j] < nums[k]:
                k = j  # 记录最小元素的索引
        # 将该最小元素与未排序区间的首个元素交换
        nums[i], nums[k] = nums[k], nums[i]
```
<div style="text-align:center; font-size: 48px; color: blue;">

时间复杂度：$O(n^2)$  
空间复杂度$O(1)$（不包含输入空间）
</div>

---

# 冒泡排序
冒泡排序的核心思想是通过不断进行相邻两个元素的比较，每次都将最小的元素放到序列的末端。  <br>
假如有序列 $[a_1, a_2, a_3, ...,a_n]$  
先比较 $a_1$, $a_2$，那么较小的数字会放在 $a_2$ 的位置，之后再比较 $a_2$, $a_3$，那么较小的数字会被放在 $a_3$ 的位置，依次类推，最后较小的数会被放在 $a_n$ 的位置，即 $a_n$ 的位置为最小的元素。  
之后再对序列 $[a_1, a_2, a_3, ..., a_{n-1}]$ 做如上处理，以此类推，进行 $n-1$ 次即可完成排序。

---

# 冒泡排序
```python
def bubble_sort(nums: list[int]):
    """冒泡排序"""
    n = len(nums)
    # 外循环：未排序区间为 [0, i]
    for i in range(n - 1, 0, -1):
        # 内循环：将未排序区间 [0, i] 中的最大元素交换至该区间的最右端
        for j in range(i):
            if nums[j] > nums[j + 1]:
                # 交换 nums[j] 与 nums[j + 1]
                nums[j], nums[j + 1] = nums[j + 1], nums[j]
```
<div style="text-align:center; font-size: 48px; color: blue;">
时间复杂度？空间复杂度？
</div>

---

# 冒泡排序
```python
def bubble_sort(nums: list[int]):
    """冒泡排序"""
    n = len(nums)
    # 外循环：未排序区间为 [0, i]
    for i in range(n - 1, 0, -1):
        # 内循环：将未排序区间 [0, i] 中的最大元素交换至该区间的最右端
        for j in range(i):
            if nums[j] > nums[j + 1]:
                # 交换 nums[j] 与 nums[j + 1]
                nums[j], nums[j + 1] = nums[j + 1], nums[j]
```
<div style="text-align:center; font-size: 32px; color: blue;">

时间复杂度：$O(n^2)$  空间复杂度$O(1)$（不包含输入空间）
</div>
<div style="text-align:center; font-size: 48px; color: red;">
优化？
</div>

---

# 冒泡排序
```python
def bubble_sort_with_flag(nums: list[int]):
    """冒泡排序（标志优化）"""
    n = len(nums)
    # 外循环：未排序区间为 [0, i]
    for i in range(n - 1, 0, -1):
        flag = False  # 初始化标志位
        # 内循环：将未排序区间 [0, i] 中的最大元素交换至该区间的最右端
        for j in range(i):
            if nums[j] > nums[j + 1]:
                # 交换 nums[j] 与 nums[j + 1]
                nums[j], nums[j + 1] = nums[j + 1], nums[j]
                flag = True  # 记录交换元素
        if not flag:
            break  # 此轮“冒泡”未交换任何元素，直接跳出
```
<div style="text-align:center; font-size: 32px; color: blue;">
如果内循环没有发生交换，说明序列已经有序
</div>

---

# 插入排序
插入排序的核心思想是假设原本已经有一个有序的数列，那么在该序列中插入一个元素，使其依旧有序。  
即原有序列 $[a_1, a_2, a_3, ...,a_n]$，现插入一个数 $x$，使原数列依旧有序。  
将 $[a_1]$ 看作有序序列，依次插入 $a_2$， $a_3$，...， $a_n$即可。

---

# 插入排序
```python
def insertion_sort(nums: list[int]):
    """插入排序"""
    # 外循环：已排序区间为 [0, i-1]
    for i in range(1, len(nums)):
        base = nums[i]
        j = i - 1
        # 内循环：将 base 插入到已排序区间 [0, i-1] 中的正确位置
        while j >= 0 and nums[j] > base:
            nums[j + 1] = nums[j]  # 将 nums[j] 向右移动一位
            j -= 1
        nums[j + 1] = base  # 将 base 赋值到正确位置
```
<div style="text-align:center; font-size: 48px; color: blue;">
时间复杂度？空间复杂度？
</div>

---

# 插入排序
<br>

```python
def insertion_sort(nums: list[int]):
    """插入排序"""
    # 外循环：已排序区间为 [0, i-1]
    for i in range(1, len(nums)):
        base = nums[i]
        j = i - 1
        # 内循环：将 base 插入到已排序区间 [0, i-1] 中的正确位置
        while j >= 0 and nums[j] > base:
            nums[j + 1] = nums[j]  # 将 nums[j] 向右移动一位
            j -= 1
        nums[j + 1] = base  # 将 base 赋值到正确位置
```
<div style="text-align:center; font-size: 48px; color: blue;">

时间复杂度：$O(n^2)$  
空间复杂度$O(1)$（不包含输入空间）
</div>

---

# 基于分治的排序
- 快速排序
- 归并排序

---

# 快速排序
快速排序的核心思想是选定一个元素（哨兵），把所有比它小的数放在左边，所有比它大的数放在右边，再对左右两边继续执行相同的操作，直到序列有序。

---

# 快速排序 - 哨兵划分
```python
def partition(self, nums: list[int], left: int, right: int) -> int:
    """哨兵划分"""
    # 以 nums[left] 为基准数
    i, j = left, right
    while i < j:
        while i < j and nums[j] >= nums[left]:
            j -= 1  # 从右向左找首个小于基准数的元素
        while i < j and nums[i] <= nums[left]:
            i += 1  # 从左向右找首个大于基准数的元素
        # 元素交换
        nums[i], nums[j] = nums[j], nums[i]
    # 将基准数交换至两子数组的分界线
    nums[i], nums[left] = nums[left], nums[i]
    return i  # 返回基准数的索引
```

---

# 快速排序
```python
def quick_sort(self, nums: list[int], left: int, right: int):
    """快速排序"""
    # 子数组长度为 1 时终止递归
    if left >= right:
        return
    # 哨兵划分
    pivot = self.partition(nums, left, right)
    # 递归左子数组、右子数组
    self.quick_sort(nums, left, pivot - 1)
    self.quick_sort(nums, pivot + 1, right)

```
<div style="text-align:center; font-size: 48px; color: blue;">
时间复杂度？空间复杂度？
</div>

---

# 快速排序 - 时间复杂度分析

<div style="column-count: 2">

$$
\begin{align*}
    T(n) &= 2T(\frac{n}{2})+O(n)  \\
         &= 2 \left( 2T(\frac{n}{4}+O(\frac{n}{2}) \right) +O(n)  \\
         &= 4T(\frac{n}{4})+2O(\frac{n}{2})+O(n)  \\
         &= 4T(\frac{n}{4})+2O(n)  \\
         &= 4 \left( 2T(\frac{n}{8})+O(\frac{n}{4}) \right) +2O(n)  \\
         &= 8T(\frac{n}{8})+3O(n)  \\
         &= 2^3T(\frac{n}{2^3})+3O(n)  \\
         &= 2^kT(\frac{n}{2^k})+kO(n)
\end{align*}
$$

因为 $T(\frac{n}{2^k})=T(1)$，  
所以 $2^k=n$，即 $k=log_2n$  
因此，

$$
\begin{align*}
 & T(n)  \\
=& 2^{log_2n}T(1)+log_2nO(n)  \\
=& O(n) + O(nlog_2n)  \\
=& O(nlogn)
\end{align*}
$$
</div>

---

# 快速排序 - 复杂度
- 时间复杂度： $O(nlogn)$
- 空间复杂度： $O(logn)$

---

# *补充内容：简化版主定理
如果 $T(n)=aT(\frac{n}{b})+O(n^d)$（其中 $a>0$, $b>1$, $d \ge 0$），则： [$^{source}$](https://www.luogu.com.cn/article/w3avh1ku)

$$
T(n)=
\begin{cases}
    O(n^d)        & \text{if } d>log_ba, a<b^d  \\
    O(n^dlogn)    & \text{if } d=log_ba, a=b^d  \\
    O(n^{log_ba}) & \text{if } d<log_ba, a>b^d
\end{cases}
$$

---

# 归并排序
归并排序的核心思想是合并两个有序序列成为一个有序序列。通过递归，可以将序列一分为二，二分为四，直到序列都为一个元素，再进行合并，一合并为二，二合并为四，直到合并整个序列。

---

# 归并排序 - 归并
<br>

```python
def merge(nums: list[int], left: int, mid: int, right: int):
    """合并左子数组和右子数组"""
    # 左子数组区间为 [left, mid], 右子数组区间为 [mid+1, right]
    # 创建一个临时数组 tmp ，用于存放合并后的结果
    tmp = [0] * (right - left + 1)
    # 初始化左子数组和右子数组的起始索引
    i, j, k = left, mid + 1, 0
    # 当左右子数组都还有元素时，进行比较并将较小的元素复制到临时数组中
    while i <= mid and j <= right:
        if nums[i] <= nums[j]:
            tmp[k] = nums[i]
            i += 1
        else:
            tmp[k] = nums[j]
            j += 1
        k += 1
    # 将左子数组和右子数组的剩余元素复制到临时数组中
    while i <= mid:
        tmp[k] = nums[i]
        i += 1
        k += 1
    while j <= right:
        tmp[k] = nums[j]
        j += 1
        k += 1
    # 将临时数组 tmp 中的元素复制回原数组 nums 的对应区间
    for k in range(0, len(tmp)):
        nums[left + k] = tmp[k]
```

---

# 归并排序
```python
def merge_sort(nums: list[int], left: int, right: int):
    """归并排序"""
    # 终止条件
    if left >= right:
        return  # 当子数组长度为 1 时终止递归
    # 划分阶段
    mid = (left + right) // 2 # 计算中点
    merge_sort(nums, left, mid)  # 递归左子数组
    merge_sort(nums, mid + 1, right)  # 递归右子数组
    # 合并阶段
    merge(nums, left, mid, right)
```
<div style="text-align:center; font-size: 48px; color: blue;">
时间复杂度？空间复杂度？
</div>

---

# 归并排序 - 复杂度
- 时间复杂度： $O(nlogn)$
- 空间复杂度： $O(logn)$

---

# 排序策略对比
基于比较的排序中影响时间复杂度的因素通常是比较次数和交换次数。
不比较排序通常不需要进行比较，并通过对空间的利用达成更好的时间复杂度。

---

# 不基于比较的排序

- 桶排序
将数据按照数据的大小范围分配到$n$个桶中，再对这n个桶中的数据进行分别排序，最后进行合并。
- 计数排序
创建数据范围大小的数组，统计每个数字出现的次数，最后进行输出。
- 基数排序
先对个位进行排序，再对十位进行排序，再对百位进行排序，依次类推，直到排序完成。对每一位的排序采用计数排序。

---

# 外部排序
外部排序采用多路归并排序，将外存中的数据进行分组，分批读入内存进行多路归并，再写回外存。
