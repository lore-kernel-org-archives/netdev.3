Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CC2773EC
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 02:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933879; cv=none; b=Dd0dThNu5omXSSmDHrroqU6rFOjKp+2awN4K9yQLwS3PKaGQBYRAEwD3X65vRKtHgraozrGCNMxUYEueIeIT52zwEN4sW5EYxhqdOnDwxWrVbIQJcKBr/CoMXitOKuK3I2BOZ+y1BeyE8QwRsZ6I6XIsTaaw9ZI8Vv/t/PEouAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933879; c=relaxed/simple;
	bh=RIdT78GVIOU79dvwJtmny4FuRS/G6OQEjs1Q0z+8uD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vfx7PXloGpsXfXz4G1znZvEW6K/gr7de/u7AHiuMNzCAdGlVZyZVDjEdpnP/go4YVSgU4/ETarlEYK8xCPUgymBGJ7oWjtwFJ/NmtUIVqnhrVcm3HiKcns3Lz846U1yzvMfjeSUiqY48GIVkez+Iqc3FOY/weYViHzQ4B2xi4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajUo7GjO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajUo7GjO"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2349223a91.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 19:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786933877; x=1787538677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5/OtHgevkIAK5SI9bRivZoT+Oh1LU2NNLDc67pJhOs=;
        b=ajUo7GjOvOZ1qLkEoFucBCOlTSFPEndsQsry9GpVZW/QutTJmD9iCpeLvcVMSJEzED
         z3+h2RH+QpJCAppya786mVZD7PKJQaOhKNXtfPDUyjyg3BUJJkwK8kBmqv50FnBfiTVQ
         WTCkMEO/S0mRLmTagFPM5Vu2DhsIRQi9g7OlEPllJshpvhQntQ+po9o1s9zbRaSmeVI6
         6zBFpHZwLVK9GZgaGVuZOrbT2bb9y1dUqvP3tLUSJ6xx65malB7gOFbNh30JzHvcyHe/
         TLZb+b+tBqhbZJopAvqraRo1P8V+PTTwm/xwdgCm/FfRjGE0+SGLpeWso/0CBorUuO5h
         z2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786933877; x=1787538677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5/OtHgevkIAK5SI9bRivZoT+Oh1LU2NNLDc67pJhOs=;
        b=XrrRSjHLyu1QBBacMqTV3FdWu3lnxMYmNrvPHN3xCGSQNhZWoMBfXtuD+xE3GUcRea
         IpgHEfdX5UOtiIdwTkWJ1/TsyiG2lhZE5XT++e87oDDoCjblXe0oMxcvcKGS43ey3u6n
         i9UuRI48hdRPjDMNwWdVIVg/ymXU5J9JmqINpWwrfn8JKYEJ8IFHq/3ixbQXuu1TV+hO
         fTH9m8ObrxWiHoevocsbaK1V0atYcooSFDq2XfoXKsVZbofjte7+vNZC9J9wVxr+wlqZ
         wtO4XU1+7HsFhWajC+WZiHKYxqigPaXao1jhEIRGsViPtKPfCHuZJr585KfBk4x+CLSS
         5TqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoPqm4Fjlw4qJWyvhUHhkl4MUYgy5eDqzudZXUgGUUhIzBXIPEBWtBfykN3JKUDyziN7t+miGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+1ZB7PSmoEJFxYwrOrnzlINxzMoSrtbzELUBHzQ6HmB9ACxBt
	tgaBzJdkAwAFEUNGzvg6rRxHJD3Sn2gcHmE2kpBc7Hg8Z18O20lATvJ1
X-Gm-Gg: AR+sD12yZ4uH+Odwg6CzHFLERvjFRT/GsIAC8Rxrjn0Fl0yoJ5VP0Dq2WJSJQ5QAQc4
	8otsNfGIZdjTFF8AzwrzIR6SJ71uis4Xtt5oTNEsstYoyimq/Dy1B5WhtuIW5bCku3UV1fIE5OD
	9MXmdUhC2Fvnhrj/8YH/5Waq7ymqtz6Yho/EQimTcXxEBHZP3buPALms5bTjHEl9th0MBCFyGwM
	4Gy37sah/klygUe0Eg2Lntym/tIry8mzUIKa1Kj6vgp0U1ysv9AKauJKP8AVsWnTgoJkbq0jAZ8
	HB1ZEyWzB+mEVVfSNQgdeh9aFMhrwBOgGSoPIzkdr7Gzyz6XpSt5HS9yw+O1PJQtb/Pd9sV4Mvn
	AC+wTLVeFyMbvFXhalMf60t00Gr9/qvpjnRSynnXqknzDIo/kbFzmwQbxQ+xC5pnFze39lScGRw
	gIQZky2hAo2smcg/x3THg2QG7lJb0c1QWQnJHdvp082cx85u55a5t2EcaUte1d8bPA8r3B5gg+
X-Received: by 2002:a17:90b:5606:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-3933b81d0aemr21565647a91.5.1786933877299;
        Sun, 16 Aug 2026 19:31:17 -0700 (PDT)
Received: from localhost.localdomain ([120.236.7.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531ff679fsm2916875a91.14.2026.08.16.19.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 19:31:16 -0700 (PDT)
From: Cheng Liu <chengliu480@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Cheng Liu <chengliu480@gmail.com>
Subject: Re: [PATCH can] can: rockchip: rk3576: fix rtnl_lock deadlock during interface down under bus traffic
Date: Mon, 17 Aug 2026 10:31:08 +0800
Message-Id: <20260817023108.1854647-1-chengliu480@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817013750.1836064-1-chengliu480@gmail.com>
References: <20260817013750.1836064-1-chengliu480@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Marc, Elaine, and linux-can community,

To help anyone easily reproduce and verify this deadlock scenario on
RV1126B / RK3576, below is the full standalone Python SocketCAN test
script used to trigger the race condition:

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
reproduce_can_deadlock.py

Constructs a concurrent kernel-level deadlock scenario:
1. Blocking sender threads: deep sleep wait in can_send() waiting for TX FIFO.
2. Error frame receiver: setsockopt(CAN_RAW_ERR_FILTER) to receive all error frames.
3. Socket churn: rapid open/bind/send/close.
4. Down/up interrupt loop: calls `ip link set can0 down` during active traffic.
"""

import os
import sys
import time
import socket
import struct
import threading
import subprocess

AF_CAN = getattr(socket, "AF_CAN", 29)
PF_CAN = AF_CAN
CAN_RAW = getattr(socket, "CAN_RAW", 1)
SOL_CAN_BASE = 100
CAN_RAW_FILTER = 1
CAN_RAW_ERR_FILTER = 2
CAN_RAW_LOOPBACK = 3
CAN_RAW_RECV_OWN_MSGS = 4
CAN_RAW_FD_FRAMES = 5

CAN_ERR_MASK = 0x1FFFFFFF

INTERFACE = "can0"
STOP_EVENT = threading.Event()
DEADLOCK_DETECTED = threading.Event()

def build_can_frame(can_id, data):
    can_dlc = len(data)
    data = data.ljust(8, b'\x00')
    return struct.pack("=IB3x8s", can_id, can_dlc, data)

def build_canfd_frame(can_id, data, flags=0):
    length = len(data)
    data = data.ljust(64, b'\x00')
    return struct.pack("=IBB2x64s", can_id, length, flags, data)

def sender_thread(thread_id, is_fd=False):
    sock = socket.socket(PF_CAN, socket.SOCK_RAW, CAN_RAW)
    try:
        if is_fd:
            try:
                sock.setsockopt(SOL_CAN_BASE, CAN_RAW_FD_FRAMES, 1)
            except Exception:
                pass
        sock.bind((INTERFACE,))
        sock.setblocking(True)
    except Exception:
        sock.close()
        return

    frame_data = b'\x11\x22\x33\x44\x55\x66\x77\x88'
    can_id = 0x100 + thread_id
    frame = build_can_frame(can_id, frame_data)

    while not STOP_EVENT.is_set():
        try:
            sock.send(frame)
        except socket.error:
            time.sleep(0.001)
        except Exception:
            break
    sock.close()

def receiver_thread():
    try:
        sock = socket.socket(PF_CAN, socket.SOCK_RAW, CAN_RAW)
        sock.setsockopt(SOL_CAN_BASE, CAN_RAW_ERR_FILTER, CAN_ERR_MASK)
        sock.bind((INTERFACE,))
        sock.settimeout(0.1)
    except Exception:
        return

    while not STOP_EVENT.is_set():
        try:
            _ = sock.recv(72)
        except socket.timeout:
            continue
        except Exception:
            time.sleep(0.01)
    sock.close()

def socket_churn_thread():
    while not STOP_EVENT.is_set():
        try:
            s = socket.socket(PF_CAN, socket.SOCK_RAW, CAN_RAW)
            s.bind((INTERFACE,))
            s.setblocking(False)
            frame = build_can_frame(0x200, b'\xaa\xbb\xcc\xdd')
            try:
                s.send(frame)
            except Exception:
                pass
            s.close()
        except Exception:
            pass
        time.sleep(0.002)

def main():
    if os.geteuid() != 0:
        print("[-] Please run as root: sudo python3 reproduce_can_deadlock.py")
        sys.exit(1)

    print("=" * 65)
    print("Starting SocketCAN deadlock reproduction tool")
    print("=" * 65)

    subprocess.run(["ip", "link", "set", INTERFACE, "down"], stderr=subprocess.DEVNULL)
    time.sleep(0.3)
    subprocess.run(["ip", "link", "set", INTERFACE, "txqueuelen", "1"], check=False)
    subprocess.run([
        "ip", "link", "set", INTERFACE, "up", "type", "can",
        "bitrate", "500000", "dbitrate", "500000", "fd", "on", "restart-ms", "100"
    ], check=False)

    threads = []
    for i in range(3):
        t = threading.Thread(target=sender_thread, args=(i, i % 2 == 0), daemon=True)
        t.start()
        threads.append(t)

    t_recv = threading.Thread(target=receiver_thread, daemon=True)
    t_recv.start()
    threads.append(t_recv)

    t_churn = threading.Thread(target=socket_churn_thread, daemon=True)
    t_churn.start()
    threads.append(t_churn)

    loop_count = 0
    try:
        while True:
            loop_count += 1
            now_str = time.strftime("%H:%M:%S")
            sys.stdout.write(f"[{now_str}] Loop {loop_count:5d}: Bringing can0 down... ")
            sys.stdout.flush()

            t0 = time.time()
            p_down = subprocess.Popen(["ip", "link", "set", INTERFACE, "down"],
                                      stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            try:
                p_down.communicate(timeout=4.0)
                down_cost = time.time() - t0
                sys.stdout.write(f"Done ({down_cost*1000:.1f}ms) -> Bringing can0 up... ")
                sys.stdout.flush()
            except subprocess.TimeoutExpired:
                print("\n" + "!" * 65)
                print("Captured deadlock! `ip link set can0 down` hung > 4s!")
                print("Kernel rtnl_lock is deadlocked!")
                print("!" * 65)
                DEADLOCK_DETECTED.set()
                break

            t1 = time.time()
            p_up = subprocess.Popen(["ip", "link", "set", INTERFACE, "up"],
                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            try:
                p_up.communicate(timeout=4.0)
                up_cost = time.time() - t1
                sys.stdout.write(f"Done ({up_cost*1000:.1f}ms)\n")
                sys.stdout.flush()
            except subprocess.TimeoutExpired:
                print("\n" + "!" * 65)
                print("Captured deadlock! `ip link set can0 up` hung > 4s!")
                print("!" * 65)
                DEADLOCK_DETECTED.set()
                break

            time.sleep(0.005)

    except KeyboardInterrupt:
        print("\n[*] Exiting test...")
    finally:
        STOP_EVENT.set()
        if not DEADLOCK_DETECTED.is_set():
            subprocess.run(["ip", "link", "set", INTERFACE, "down"], stderr=subprocess.DEVNULL)
        print(f"[*] Completed {loop_count} loops.")

if __name__ == "__main__":
    main()
```

Also, if maintainers prefer this fix to be split into separate smaller
atomic patches (e.g. 1. close deadlock fix, 2. NAPI budget handling, 3. error
handling NULL check), please let me know and I will gladly send a v2 patch series!

Best regards,
Cheng Liu
