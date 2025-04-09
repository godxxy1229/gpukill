# 🧹 gpukill - GPU Memory Management Script

A shell script to monitor and manage GPU memory usage. It identifies idle GPUs and helps you terminate the process that is consuming the most GPU memory.

> 🔗 Inspired by: https://godxxy1229.tistory.com/100

---

## 📌 Overview

`gpukill` is designed to help efficiently manage shared GPU resources on Linux servers (e.g., research labs, academic environments). It detects idle GPU states and assists in freeing up GPU memory by terminating heavy usage processes with user confirmation.

---

## ✅ Features

- Detects GPU idleness based on:
  - Power draw
  - Utilization
  - Memory usage
- Identifies the process using the most GPU memory
- Shows:
  - Username
  - Process name
  - Memory usage (in MiB)
- Asks for user confirmation before terminating the process

---

## 💻 Requirements

- NVIDIA GPU with drivers installed
- Linux environment (Tested on **Rocky9**)
- Basic shell commands: `ps`, `awk`, `sort`, `sed`, `bash`

---

## ⚙️ Installation

1. **Copy the script to system path**:
   ```bash
   sudo cp gpukill /usr/local/bin/gpukill
   ```

2. **Make it executable**:
   ```bash
   sudo chmod +x /usr/local/bin/gpukill
   ```

3. **Add sudo permission (no password)**:
   Edit the `/etc/sudoers` file and add:
   ```plaintext
   ALL ALL=(ALL) NOPASSWD: /usr/local/bin/gpukill
   ```

4. **(Optional) Add alias for easy usage**:
   Append this to `/etc/bashrc` or `/etc/profile`:
   ```bash
   alias gpukill="sudo /usr/local/bin/gpukill"
   ```

---

## 🚀 Usage

```bash
gpukill
```

---

## 🖥️ Example Output

```
GPU 0 is detected as idle.
Process using the most GPU memory:
User: testuser1
PID: 124113
Process Name: /bin/python
GPU Memory Usage: 5422 MiB
Do you want to terminate this process? [y/N]: y
Terminating process 124113 (User: testuser1)...
Process 124113 has been terminated.
```

---

## 🛠 Troubleshooting

- **Script doesn't execute?**
  ```bash
  sudo chmod +x /usr/local/bin/gpukill
  ```

- **Alias doesn't work?** Try using `sh`:
  ```bash
  alias gpukill="sh /usr/local/bin/gpukill"
  ```

---

## 📄 License

This project is open-source and available under the MIT License.
```
