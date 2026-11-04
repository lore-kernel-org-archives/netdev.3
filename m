Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773973;
	b=PfvPSzpvOID8gimBXqhavb2jBmNHI8mLOaq+Rqs4nmBQWeGvWzZNrhEimsfxKybbk6jk
	 bJ2EUJYhonJeAYY8jptLGhaHX5zOwDbehqDRFjJ0+McLaZbt+6grSdpLC7ShUzw7RHuJA
	 eimalv9GJousLEShs5oR4HMwjZL2N+79qETGmitK40VTSbimENT/EXfxvd/hxtc2YZRbk
	 bG+YARWIIvcq2VEQ41cE/izg7sXtrxjRO776o6Na5GTw1QJw4rbhk1K7Z7jyrBr3Mg13v
	 1urUfMTxW2/ANzjVtgSFrsdtNOpQqjt8edfwMgZ9xNDWl8K5HMYPG1vvU4jb9XK811A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7MtaSYtpxrVvV9gqHJYiTe5lCnL/PoZDYLQmPOd8KEc=;
	b=YXGpSfazmWS2UymqJTN+/KyZcVgeBF0ZqxKZSuUGYV0mwWrJyw76FrEZvptdrYbVQOH2
	 Xa3AAAbZ0hMcvOzfTX42pDpReHO5N1DNe3AafLebbLItxbqBjvnx35cs9YnDZQmkfPWa9
	 1xoAIY0EE/Ip3OgvtMfvwpm5pAY/h7PLDY+RQu2t3QE1IwVsjEnIwCIeC5ZqzDyBs/Ngj
	 NxUMwcWKxqBbMEEVudzNHnFQelD6wEu1X1h3ys1T0B48wB0fKSTVfnSTpADTkWRkOhfDY
	 jOiHLvgijWS/ac6yzcJpTuhphYvP0F5W2EvbtIu8mfLOUT2mkrGJG/4r189+CVnleXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DPSXT4GV;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B9606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 06:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 841B9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DPSXT4GV
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso286332a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 22:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773973; x=1794378773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7MtaSYtpxrVvV9gqHJYiTe5lCnL/PoZDYLQmPOd8KEc=;
        b=DPSXT4GV1NiparnT2PqogtJHUluR1tECN4Xh4xI6p3LagzYXqMm7E1CFgfuF7n0HRE
         mW11plmlvV/enopMNFu3SnMkWhTWRoHH6bOiksfb/LnOJAiO+JvA/TtpqnyfbHt62HW0
         R8XLZUCVQiWo5uhHXBG615QyXjhcchQlFHHai9Crz1le5OcD5iBhVOF9anpal2tfW6HX
         HFEvvwwZRBHYthaJT+MxYT2y0e/gNBtr8YIv5iBVdX9ymDWycr+N+OCWJk9NAP/kOMJ2
         Sq2BhKN9WAXEKRSdDTXHUOtWOSmj4MbBKTKv4ThTA7dqiX8T13RX80oz/bGyBUH2YIXY
         vwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773973; x=1794378773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MtaSYtpxrVvV9gqHJYiTe5lCnL/PoZDYLQmPOd8KEc=;
        b=wt/znt8mAhpvKqU6QogwAwLmGqBQnRDWZnKz5WbeJHkDXvAkIaqUJCKumosu5L4zBb
         Rkgj90mpGvSZXVdqpX0Dd5mT5Vl9mX7gtrwf8tIa/QbRRvURBJ27t3ruMAcg1Wbr2L23
         KJD7Zx3K/GVXCqUpf5uYMFstqGNEChI30WiLt4BQY1hdZt0gNVSzqT1TJU2tOL8mNAY4
         Tsoysg9nVSF3ChBdkI+rnCzXqW4pGQkewRj0xG1QK8AC3IiZg2PaksiWAyMnecgehYLT
         5jUb1Ko37ZteIdAVArS/CP7Bj8f5Ybsz3oKmbWMj3456rv7/cvkNx8mPaYkaLLxrY/Cu
         kX7g==
X-Gm-Message-State: APuU4Z/sJkeKR9Zd07dLfYydZ8w1lDUWJLkuouPdh9gK+NAqeYcNBSCf
	trJK333AQ49cFD7tjSAZvpZIQKTIa0aYnlsUug156j0bRklHtSo8QXA8
X-Gm-Gg: AYBFou19dv/WwISw61dvunYSCSBZOc6UezlNsicxh+3AG2f/b351PAzJGe0ER4bxDTe
	HsnYJL68WGPlZBkBGtPTafpMU4hOZXwz2orPIaogKrh4QwoLbk/FjZYtnhH4ONxTKsYXcw0uCRi
	YhIA7VLgMLCt5OFKbS+2JD83YmY0yVOvc5rlu85ymCFknV6mPvWL6K6wgCNes+VIUJr1MP1x2sO
	HF1IwaJe1mCJdgeZM9WJKsF5L/swNicoC7Pvl6ITvqevqLe6pM0beHgiVnE/GWN+iM/mCqyU6nT
	nLmjhWMlf4Wk5ur0XjPJ/A021jsT92S6jrGVynvQYl7lcENWeTplwHmZaYlfvvOsU4durc3jhT1
	kk54ElC1FpU2MblD/d4XUmq31d/20xFexS8cbQW33TT0Q/Hcj9FKhruKyxjQZvNssA4fJmD6fib
	RoshiCA3akWP/NacvgnnD7I8dVohf0kPPt0FIccMby9MQe5Anob0jx0aI1uvlgw3iwrkdBiN0gD
	kx+6u3ysN55xX1RF2wbWENKMLKVi9QiFX4UlbtH7J6lx2uUatxC3761cO86hp8QSkC4KzLmC+5P
	1h8gAj2XfiYlssntZSu6Cu+0xg/4CollGLk=
X-Received: by 2002:a17:90b:44:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3ae896f8546mr13356308a91.13.1793773972828;
        Tue, 03 Nov 2026 22:32:52 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0945104dasm2583207a91.17.2026.11.03.22.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:32:52 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: ethernet: disable async work before teardown
Date: Wed,  4 Nov 2026 14:32:42 +0800
Message-ID: <20261104063245.23402-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three Ethernet drivers free the netdev while an asynchronously queued
work item can still dereference it.  The queue sites and the handlers
differ, but the lifetime rule is the same: stop the producer, drain the
work, then free the object.

Patch 1 fixes atl1.  reset_dev_task is queued from the interrupt handler
for link-down and DMA errors and from ndo_tx_timeout(); link_chg_task is
queued from the interrupt handler when ISR_GPHY reports a link event.
Both works are disabled and the PHY configuration timer is deleted
before unregister_netdev().

Patch 2 fixes enc28j60.  tx_work is queued from ndo_start_xmit(),
setrx_work from ndo_set_rx_mode(), and restart_work from ndo_tx_timeout().
The interface is unregistered first, then the three works are disabled
before free_irq() and free_netdev().

Patch 3 fixes xgmac.  tx_timeout_work is queued from ndo_tx_timeout()
and from the DMA error interrupt.  The work starts disabled in probe,
is enabled by xgmac_open()/xgmac_resume(), disabled in xgmac_stop()
before the DMA rings are freed and in xgmac_suspend() before NAPI and
interrupts are torn down, and disabled in xgmac_remove() before the
IRQs and MMIO are released.  The patch does not reorder the existing
free_irq()/unregister_netdev() calls in xgmac_remove().

The works are disabled with disable_work_sync() rather than cancelled:
it drains a pending or running instance and also rejects later
queue_work() calls from interrupts or timers that are still in flight.
This API was added in v6.10, so the stable tag is 6.10+; older trees
need the cancel_work_sync() form of the same change.

The three patches are independent and can be applied separately.  They
are grouped only because they fix the same teardown pattern.

Testing: the in-tree driver code was run under KASAN on QEMU/KVM (x86-64,
2 vCPUs).  A SCHED_FIFO task on one CPU queues the work and keeps the
per-CPU system workqueue from running while a second CPU unbinds the
device; the vulnerable kernels report a slab-use-after-free in
assign_work() and the fixed kernels complete with the work still
pending at remove entry.  The three patched drivers also build as
modules with W=1.  There is no physical hardware in the test setup: the
platform/SPI teardown paths are exercised with test devices, and the
atl1 probe path is not exercised.

BeaCox (3):
  net: atl1: disable work before freeing the netdev
  net: enc28j60: disable work before freeing the netdev
  net: xgmac: disable timeout work before teardown

 drivers/net/ethernet/atheros/atlx/atl1.c  | 12 +++++++++
 drivers/net/ethernet/calxeda/xgmac.c      | 30 +++++++++++++++++++++++
 drivers/net/ethernet/microchip/enc28j60.c |  9 +++++++
 3 files changed, 51 insertions(+)

-- 
2.43.0
