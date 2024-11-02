#Secure Image Compression: Employing EZW Algorithm with Symmetric Key Cryptography using Fast Fibonacci Transform

Project Overview

This project implements a secure image compression system using the Embedded Zerotree Wavelet (EZW) algorithm for efficient compression, combined with symmetric key cryptography leveraging the Fast Fibonacci Transform (FFT) for encryption. This approach enables both effective data compression and strong security, ideal for applications needing efficient and secure image transmission.

Features

	•	EZW Image Compression: Compresses images by encoding wavelet coefficients, achieving high compression without significant loss in quality.
	•	Symmetric Key Cryptography: Encrypts the compressed image with a symmetric key to ensure confidentiality.
	•	Fast Fibonacci Transform (FFT): Utilizes FFT based PRNG for generating random bits that will be used in the encryption process.
	•	Secure Transmission: Combines compression and encryption, enabling secure and bandwidth-efficient image transmission.

System Workflow

	1.	Discrete Wavelet Transform (DWT): Decomposes the image into frequency components, setting up for effective EZW compression.
	2.	EZW Encoding: Encodes wavelet coefficients, prioritizing significant data.
	3.	Huffman Encoding: Further compresses EZW-encoded data, minimizing redundancy.
	4.	Encryption with FFT: Applies FFT-based symmetric encryption using XOR operations.
	5.	Decryption and Decompression: Reverses encryption and compression steps to reconstruct the original image.

Requirements

	•	MATLAB (R2021a or later recommended)
	•	Image Processing Toolbox
	•	Wavelet Toolbox

 Installation

 	1.	Clone this repository:
```
 git clone https://github.com/yourusername/Secure-Image-Compression.git
 cd Secure-Image-Compression
```

	2.	Open MATLAB and add the repository folder to your MATLAB path:
 ```
addpath(genpath('path_to_repository'));
```

Usage

	1.	Place the image file in the images/ folder.
	2.	Run the main script in MATLAB to compress and encrypt the image:
  3.  The main files are Paper_main_EZW_enc.m to encode and compress the image, Then run encryption_decryption_algo_paper.m to encryption and decryption process, then finally run Paper_main_ezw_dec.m for decoding and decryption of the obtained decrypted data.

The system achieves effective image compression with minimal quality loss and strong security measures. Key performance metrics and tests include:

	•	Structural Similarity Index (SSIM): Evaluates image quality after reconstruction, indicating high visual similarity to the original.
	•	Peak Signal-to-Noise Ratio (PSNR): Measures the accuracy of the reconstructed image, showing low levels of distortion.
	•	Compression Ratio: Demonstrates significant data reduction while preserving essential details.
	•	Cryptographic Tests:
	•	Histogram Analysis: Ensures that pixel value distributions in the encrypted image are uniform, reducing vulnerability to statistical attacks.
	•	Correlation Coefficient Analysis: Checks for low correlation among adjacent pixels in the encrypted image, indicating strong diffusion and resistance to pattern recognition.
	•	Entropy Test: Measures the randomness of the encrypted image data. High entropy (close to 8 for grayscale images) indicates a high degree of unpredictability.
	•	NPCR (Number of Pixels Change Rate) and UACI (Unified Average Changing Intensity): Evaluate the sensitivity of the encryption to small changes in the input image, ensuring that minor modifications result in significant differences in encrypted output.
	•	Key Sensitivity Test: Verifies that small changes in the encryption key lead to vastly different encrypted outputs, ensuring that even minor key discrepancies prevent successful decryption.

License

This project is licensed under the MIT License.

