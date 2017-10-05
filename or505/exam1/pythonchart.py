import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt
 
objects = ('(50, 60]', '(60, 70]', '(70, 80]', '(80, 90]', '(90, 100]', '>100')

grades = (90,65,82,76,84,90,78,94,66,92,82,92,94,67,76,84,71,85,80,90,53,72,91,97,75,103,83,66,80,86,63,83)
print(grades)
print (len(grades))
y_pos = np.arange(len(objects))
performance = [10,8,6,4,2,1]
 
plt.bar(y_pos, performance, align='center', alpha=0.5)
plt.xticks(y_pos, objects)
plt.ylabel('Usage')
plt.title('Programming language usage')
 
plt.show()
