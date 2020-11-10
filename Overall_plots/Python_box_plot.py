from __future__ import print_function
import time
import numpy as np
import pandas as pd
from sklearn.decomposition import PCA
from sklearn.manifold import TSNE
#get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import seaborn as sns



init=pd.read_csv('derived_data/Overall.csv',encoding='latin1')





initStart = init[init.StartMo1 >= 0]







x=initStart.StartMo1




min(initStart.AbsDiffDeathsImp)
tester = initStart[initStart.AbsDiffDeathsImp == -374775]
tester





y_abs=initStart.RelDiffDeathsImp
max(y_abs)








plt.figure()
sns.violinplot(x='StartMo1', y='AbsDiffDeathsImp', data=initStart, scale='width', inner='quartile')

g=plt.annotate('Russian \nCivil War\n1917-1920', xy=(11, -440000), xytext=(11.5, -420000),
             bbox=dict(boxstyle='square', fc='firebrick'),
             arrowprops=dict(facecolor='steelblue', shrink=0.05), fontsize=7, color='white')

g
# Decoration
plt.title('Violin Plot of absolute difference in initiator deaths by war starting month', fontsize=12)
plt.xlabel("Starting Month of War")
plt.savefig('Overall_plots/Python_proj_violin.png') 

# Decoration
#plt.title('Density Plot of Total deaths by Month', fontsize=22)
#plt.legend()
#plt.show()

