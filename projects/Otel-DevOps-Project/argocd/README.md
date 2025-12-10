created image in CI part deployed on k8s cluster.

CD has multiple tools like ansible. best way is the Gitops methadology

target platform is not always a k8s.
using git vcs for deployment is gitops.

features
1. automatic deployment
2. recocilation of state becuase vcs is source of truth which means whout CI no one should deploy any manual change is overwritten
3. its continuos like crosn