import pyautogui

def init_system():
    """
    游戏辅助初始化
    你以后可以在这里加：
    - 游戏窗口查找
    - 内存读取初始化
    - 显卡占用设置
    - DPI 校准
    - 热键初始化
    """
    try:
        pyautogui.position()  # 测试鼠标可用
        return True, "初始化成功 ✔"
    except Exception as e:
        return False, f"初始化失败：{str(e)}"