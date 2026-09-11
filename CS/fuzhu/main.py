# -*- coding: utf-8 -*-
import tkinter as tk
from tkinter import ttk, scrolledtext
import threading
import time

from init import init_system
from mouse_move import HumanMouse

class AimAssistGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("单机游戏辅助瞄准工具 v1.0")
        self.root.geometry("580x500")

        self.inited = False
        self.mouse = HumanMouse(speed=280, jitter=2.0, angle=0)

        self.create_widgets()

    def create_widgets(self):
        tk.Label(self.root, text="单机游戏辅助瞄准工具", font=("Arial", 16)).pack(pady=10)

        self.status_label = tk.Label(self.root, text="等待初始化...", font=("Arial", 12), fg="gray")
        self.status_label.pack()

        frame = tk.Frame(self.root)
        frame.pack(pady=10)

        self.btn_init = tk.Button(frame, text="初始化", width=12, command=self.do_init, bg="#4CAF50", fg="white")
        self.btn_init.grid(row=0, column=0, padx=5)

        self.btn_standby = tk.Button(frame, text="进入待命", width=12, command=self.standby_mode, state=tk.DISABLED)
        self.btn_standby.grid(row=0, column=1, padx=5)

        self.btn_stop = tk.Button(frame, text="停止所有", width=12, command=self.stop_all, bg="#f44336", fg="white")
        self.btn_stop.grid(row=0, column=2, padx=5)

        param_frame = tk.LabelFrame(self.root, text="鼠标参数")
        param_frame.pack(pady=10, fill=tk.X, padx=20)

        tk.Label(param_frame, text="速度：").grid(row=0, column=0)
        self.speed_var = tk.DoubleVar(value=280)
        self.speed_slider = ttk.Scale(param_frame, from_=50, to=800, variable=self.speed_var, length=200)
        self.speed_slider.grid(row=0, column=1, padx=10)

        tk.Label(param_frame, text="抖动：").grid(row=0, column=2)
        self.jitter_var = tk.DoubleVar(value=2.0)
        self.jitter_slider = ttk.Scale(param_frame, from_=0, to=8, variable=self.jitter_var, length=200)
        self.jitter_slider.grid(row=0, column=3, padx=10)

        tk.Label(self.root, text="运行日志").pack()
        self.log = scrolledtext.ScrolledText(self.root, height=12)
        self.log.pack(fill=tk.BOTH, padx=20, pady=5)

    def log_print(self, msg):
        self.log.insert(tk.END, f"[{time.strftime('%H:%M:%S')}] {msg}\n")
        self.log.see(tk.END)

    def do_init(self):
        self.log_print("开始初始化...")
        ok, msg = init_system()
        self.log_print(msg)

        if ok:
            self.inited = True
            self.status_label.config(text="初始化完成", fg="green")
            self.btn_standby.config(state=tk.NORMAL)
            self.btn_init.config(state=tk.DISABLED)
        else:
            self.status_label.config(text="初始化失败", fg="red")

    def standby_mode(self):
        self.log_print("进入待命模式")
        self.status_label.config(text="待命模式", fg="blue")

        def test_aim():
            self.mouse.set_speed(self.speed_var.get())
            self.mouse.set_jitter(self.jitter_var.get())
            self.mouse.set_angle(45)
            self.log_print("测试移动 45 度方向")
            self.mouse.start_move()

        threading.Thread(target=test_aim, daemon=True).start()

    def stop_all(self):
        self.mouse.stop()
        self.status_label.config(text="已停止", fg="orange")
        self.log_print("已停止所有功能")

if __name__ == "__main__":
    root = tk.Tk()
    app = AimAssistGUI(root)
    root.mainloop()