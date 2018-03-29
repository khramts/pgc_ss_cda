import numpy as np
from assocplots.qqplot import *
from assocplots.manhattan import *

datf=np.genfromtxt('OCD_ADHD_female.META.CHR.POS', dtype=None, skip_header=1)
datm=np.genfromtxt('OCD_ADHD_male.META.CHR.POS', dtype=None, skip_header=1)

##### QQ plot
import matplotlib as mpl
mpl.rcParams['figure.dpi']=150
mpl.rcParams['savefig.dpi']=150
mpl.rcParams['figure.figsize']=6.375, 6.375

plt.clf()
qqplot([datf['f2'], datm['f2']], ['Female $\lambda=1.104$', 'Male $\lambda=1.150$'], color=['r','b'], fill_dens=[0.2,0.2], error_type='theoretical', distribution='beta', title='')
plt.ylim([0,8])
#plt.show()
plt.savefig('OCD_ADHD_mal_fem_QQ.png', dpi=300)

get_lambda(datf['f2'], definition = 'median')
#1.1038305474906456
get_lambda(datm['f2'], definition = 'median')
#1.1502208100009044

##### Manhattan Plot

import matplotlib as mpl
mpl.rcParams['figure.dpi']=150
mpl.rcParams['savefig.dpi']=150
mpl.rcParams['figure.figsize']=[12.375, 6.375]

chrs = [str(i) for i in range(1,23)]
chrs_names = np.array([str(i) for i in range(1,23)])
chrs_names[18::2] = ''

cmap = plt.get_cmap('Greys')
colors = [cmap(i) for i in [1.0,0.6,1.0,0.6]]

plt.clf()
manhattan(     datf['f2'], datf['f21'], datf['f20'], 'OCD-ADHD Female Meta',
               p2=datm['f2'], pos2=datm['f21'], chr2=datm['f20'], label2='OCD-ADHD Male Meta',
               type='inverted',
               chrs_plot=[str(i) for i in range(1,23)],
               chrs_names=chrs_names,
               cut = 0,
               title='',
               xlabel='chromosome',
               ylabel='-log10(p-value)',
               lines= [7.3],
               top1 = 10,
               top2 = 10,
               colors = colors)
plt.savefig('OCD_ADHD_mal_fem_Manhattan.png', dpi=300)

