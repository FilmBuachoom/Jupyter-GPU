## 📝 Note :
This Dockerfile enables the execution of TensorFlow with GPU support within a Jupyter Notebook environment.

## ⚙ Setting :
| Package name | Version |
| --- | --- |
| Nvidia-driver | base on your device |
| CUDA | 11.2.2 |
| cuDNN | 8.1.1 |
| TensorRT | 7.2.3 |
| TensorFlow | 2.11 |
| Python | 3.8 |

## 🔥 Testing :
1. Check Nvidia-driver version
  ```
  nvidia-smi
  ```
  ![image](https://github.com/FilmBuachoom/Jupyter-GPU/assets/109780340/32f90c55-cc87-450b-802f-11a07ab601cf)

2. Check CUDA version
  ```
  nvcc -V
  ```
  ![image](https://github.com/FilmBuachoom/Jupyter-GPU/assets/109780340/b78ac894-3dd5-4e01-b0f3-356b0f6f791c)

3. Run TensorFlow with GPU
  ```
  python3 -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
  ```
  ![image](https://github.com/FilmBuachoom/Jupyter-GPU/assets/109780340/d47dee79-5c59-437c-8293-b0c5188f8b12)

## 🛠️ Fixings :
* If can't use your environment
  ```
  ipython kernel install --user --name=$your_env_name
  ```
