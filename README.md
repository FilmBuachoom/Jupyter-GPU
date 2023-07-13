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
  ![image](https://github.com/FilmBuachoom/Jupyter-GPU/assets/109780340/9db096f3-7922-4cd4-8a88-f31ffa780caa)

2. Check CUDA version
  ```
  nvcc -V
  ```
  ![image](https://github.com/FilmBuachoom/Jupyter-GPU/assets/109780340/44b4733b-40ce-4e1c-bbdd-1c436c557f1d)

3. Run TensorFlow with GPU
  ```
  python3 -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
  ```
  ![image](https://github.com/FilmBuachoom/Jupyter-GPU/assets/109780340/23df1983-81a1-491f-b773-694b2ff7d7ec)

## 🛠️ Fixings :
* If can't use your environment
  ```
  ipython kernel install --user --name=$your_env_name
  ```
