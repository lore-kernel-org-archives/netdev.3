Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541511;
	b=BjrPXmGO+5zaZ/NXNKkuAVQjzWMzrMNWZ9CbIdESZ+orTHnhnzWltALcxmRiXTDdnMmk
	 tm5hqbiG40szKAxLqy4dRuuEAF8TZG9jSiK37s3Wezp1P+HQNO4aE/uqcxpGuZv2IryZe
	 YLNL3RCD73rpDF60b/Mxk2+9I3CC97ThJE+pZGcgwyMI1e3QtIfoLjmvhiN9EIBpR4xdQ
	 6cuLgW3hmBUvhLBVjtUG1CuZCTH/DV1Ob9IDOGl+JpCuDEk5oVzIyTf3R7LhsJ30sP5ot
	 oVDhVCZFbjNfWDM93kSUUnR4ud9qSBuJopNZBLdEGz7UGaqE6K+dyIApaWkPgaRhNuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0N5nUgx8ZMLxJqfyvYD6hcQNRPzT9h9VL4zQ6alvcP0=;
	b=DJbEGBamf8dMWuolJ3LQfIsO4W59ZZg94sBfM3o0kvg37+KDyGh6DiXwXvDahd/TiAjS
	 E85DEcDhRxc2Ylt1ZgVcxUjTDOQF8qeC8oITbQtWnBItFy/oUPzf6KZ9ogSRl2j1zb5Sv
	 kGWXSkTo4NJho/UVl/pH9Y6D7GfAQBcW4GnZRpNA5EhJuG7LKQELZYsrqBO5O4kKwO8OY
	 QutP9KdTC+gVDzfCItw8O0ija1RjFbZShET4j5DhvDiDn4qlgLZUJq058ZHegzuID7uR6
	 aosOHEOe/gn1dVGmuZ6+MKp5RxOLePgPnC1m75lg3M0QiPeXmZ7UgL36XN9oxy4bMJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BlkcUtDn;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D5606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 13:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC9D5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BlkcUtDn
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so276611a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 05:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793541510; x=1794146310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0N5nUgx8ZMLxJqfyvYD6hcQNRPzT9h9VL4zQ6alvcP0=;
        b=BlkcUtDnQWw4+c3UyQKCqUQ36H4KdrG0vbQBpOUE8bQMOcK1l2v7e+ai434uK+glT3
         MIT1zuB1Z2p9GA/+03nkFP2tweBZU71D46he/bVjzOca28p8wVmFHjDRh05/EtHxR31g
         hv0JE3xyilWlBvfz4T8CxTDTOaP+e6Ohbwc4pUvjnVYFFVmGQwAe6oDoFrGe+e+K8Qlk
         UIrXSJFNlf7HrgKjpW6n+SAj7Pn7l6+5eQ/QPynAGEdC+Yu5sEWKeZbeNZeLjgYcqfXj
         1hJC3zl1SKVF8bVO9PDqXwx3Q3j+uYsVIFlVujDE5ypCNiiGRNq0576hocA3Y0d2oCTi
         T5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793541510; x=1794146310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0N5nUgx8ZMLxJqfyvYD6hcQNRPzT9h9VL4zQ6alvcP0=;
        b=bUL2sYtB0GB5QEyqvcIV5jVWj/bcqJZOA9hnNO26LiR3abDiBgR7u0FAkoEAj7udAt
         mPA8cc0YPfuc3GcViPBHPuxdzrJuy4gQ2iN0P7fRYuQjidwVnCIAfDoeaIpGC4yAOEgg
         KdwZY7DnyPoUto5PUiR2QLzvjeLIlM+4T2nhuS+0G56HPDO6BDoOH5AOjhlzlNl3sK28
         9FZJ80hBZt0BDf9xF3Wn2NA8kgTJtrUeG2gnSQxpXq6V6hcF20ZJHfC9Oz003xl5YoRC
         eqtBL+Q2xSz2c7qf3yGLB5fQ6mi7MD1rJfXIOY3fP+DWj0ipA024rxv8mNiGczQEVu5s
         NXpg==
X-Gm-Message-State: APuU4Z+0ystkOLiNC33CcbBYQ9E+qwBT5/KxjDTyqXPpmmAusvJiOol5
	a2hRjPpeXO9/2dYYZ7B7nTlEC3Fxjk0y0OfPXSUEpapCy6/yuAd3z1KQ
X-Gm-Gg: AYBFou0bUE906ChWm38tY+8TmAhEyWW5rGScetUxsfsa0NQa7JM641vkmurPoYbIDIR
	T5Z7vsrJt1pl/E+l6hnVC/1pZgLBRK3K+rSHfaO7EjOJ0gERUys27ORW3UpbOWQ35yJFRFgaxDZ
	medpd1hQguY1DIz7bo/PQUIDQ+H7oVHFqrzA1PKTTZudUh4govFZmzlXJOWqs9kpUcWnkPCkqOy
	SURIrzbyzxyqQvvo3C9uSxdld4NtryiqBOnwTSCkN3DeQhHTyb6VBmshBHbywU8ExktGZOLEToF
	1jslntTmz9YYUp8O/VRO2OOZz7iMS3//e6iz74fraCd/XB8s6f5ZjiTXbKvZWxP9DSS35SODFYw
	PB9IjeaS2DcSlP/H/QeYUa3DAcbx0r22BXhGXVuPfV7P1H/jI/B3Dt97BdyLCzCgpi8thgdwiQv
	70InzaeGn6ap8gqLy5BfkUApltpFrxfIDKnXj6HCHRIsbdUv47FpY00COHL8kYuBaWz15bxu3uz
	t2OZdAFH65Y8/te08PmomIxOS49fH9jw+eSLJg1eBM5AwNnhfzT6xB67rtM/Z+pfEN4EYVLhGsY
	EfdisrS1YBdby59oJDPxZWNjp7HolYM=
X-Received: by 2002:a17:90a:e7d2:b0:3ad:a270:a623 with SMTP id 98e67ed59e1d1-3ae8957452cmr6332189a91.4.1793541510205;
        Sun, 01 Nov 2026 05:58:30 -0800 (PST)
Received: from thangnn-ASUS.. ([2a09:bac5:d459:2e1e::498:63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm9887771a91.11.2026.11.01.05.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 05:58:29 -0800 (PST)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH net] netdevsim: check the driver is bound in new_port/del_port
Date: Sun,  1 Nov 2026 20:58:24 +0700
Message-ID: <20261101135824.24484-1-ngocthang2710.1999@gmail.com>
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

new_port and del_port are attributes of the bus device, so they stay
reachable after the driver is unbound. nsim_drv_remove() clears
drvdata, yet both handlers pass it straight to priv_to_devlink() and
devl_lock(), which faults on a small negative pointer:

  BUG: unable to handle page fault for address: fffffffffffffeb0
  RIP: 0010:__lock_acquire+0x41/0x2de0 kernel/locking/lockdep.c:5140
  Call Trace:
   lock_acquire+0x115/0x350
   mutex_lock_nested+0x55/0x1d0
   nsim_drv_port_add+0x5a/0x140 drivers/net/netdevsim/dev.c:1760
   new_port_store+0x1a5/0x280 drivers/net/netdevsim/bus.c:96
   kernfs_fop_write_iter+0x3a5/0x540

The nsim_bus_dev->init check does not help: it is only cleared when
the whole device is deleted, not on unbind.

Do what sriov_numvfs already does: take device_lock() so the driver
cannot be unbound underneath us, and return -ENOENT if drvdata is
NULL.

Fixes: 794b2c05ca1c ("netdevsim: extend device attrs to support port addition and deletion")
Reported-by: syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b3fca27eb4005f0111f4
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Reproduced in QEMU (x86_64, KASAN + lockdep) with the syzbot C repro:
the unpatched kernel oopses in nsim_drv_port_add() right after unbind.
With the patch, the write to new_port returns -ENOENT, a 40s stress of
bind/unbind + new_device/del_device racing with new_port/del_port/
sriov_numvfs runs clean (no splat, no lockdep report, no hung task),
and new_port/del_port still work as before on a bound device.
 drivers/net/netdevsim/bus.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 5c55c308487b..d843b3c985cf 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -93,8 +93,13 @@ new_port_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index,
-				addr_set ? eth_addr : NULL);
+	device_lock(dev);
+	ret = -ENOENT;
+	if (dev_get_drvdata(dev))
+		ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
+					port_index, addr_set ? eth_addr : NULL);
+	device_unlock(dev);
+
 	return ret ? ret : count;
 }
 
@@ -115,7 +120,13 @@ del_port_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index);
+	device_lock(dev);
+	ret = -ENOENT;
+	if (dev_get_drvdata(dev))
+		ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
+					port_index);
+	device_unlock(dev);
+
 	return ret ? ret : count;
 }
 
-- 
2.43.0

