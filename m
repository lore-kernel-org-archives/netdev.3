Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56C2C0294
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368694; cv=none; b=rcatFIY+Ns7LZa5n4OGh3EkBV29PbjNYVu1tvVlnEAepU7oJZdEdOc1xt27On7SxOH1XoXGdcseA0+OcXCPuiibRrIXRNMcMTw7RkPMawSAVrJA5FzSM1kTl1s+RPpeLcrW1VR7LVGewAk+Yc8qigEOFTiD542dk1zqABC6nb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368694; c=relaxed/simple;
	bh=RM/YxQY456kcmYEcHSeOs3p3taT/I9NV7N68DWW7lIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fe7r1+/Qy12tGU1fKu46Lhj8E7V17lbhcdR++pIq5fxSILMWKTp+3kSIlalMN+xByWZ3SQgbhd1vbuNtHoLmovuAt6yjKwRKv345AwEv3WAM1nZyUwOiiicQIzxVlwSE+tZV/WB0tIBY45fMaymT9T0ZLoz0jvq0h5cMIYCiy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGRvA1mL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGRvA1mL"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso2188286a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786368691; x=1786973491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TOePn93cV2ug+wSXgzsoigDXykI/2Vl/iaRlUy5tOD0=;
        b=jGRvA1mLer/yGp3RpNo8hRx3xE8blIsfLQlctahWprV30dKF8qPsvsqqfcbtieab6u
         Kb2lFp9/Z1E44mCvIhf9+Eh4YwKTmZmmP0hOe+OBO0+0EyK+4t9VH4pYbX7yDert7yfg
         I0Clh+q4x4ua8q0qgjFW4ykq7ob5P0+Vf4bGxoiYyeYNczwY/X0s38kMw8ZlfQEHtr+v
         oCNvVXr7MXBM5jhFIQfVQAMJpxKhK9T+O3QKsbu5ig4jZR+bBsomtVl0WJM6R3AzaoAR
         Ztfi9wRU57NmAgdj160mrJ9zLrDY06OqZ+mxh0mmglaBK9aU0usOXSxLyfxDMVNx2wd3
         aXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368691; x=1786973491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TOePn93cV2ug+wSXgzsoigDXykI/2Vl/iaRlUy5tOD0=;
        b=tGlPPY3ditLcxqhTcVOPg0KDk+cYBUjsqVzRkoXIQRKAZ1VxIOLdOosUEwznYYf7Lr
         G0L7fJar0swDLzBYaWOeIHxxrWbsxxGzJ2gO9abmM1BGucV55VW6tItfIS2BzwN1LLGV
         79W8enm5p9JPHNj1wZuCGFz5eMHbWGvVuU2TWjMTTAethQrxo5Qq1L9QRfdyRYCZmsRV
         oCC6yN6pn3JMNUzxmjztcM0iP7AaAD9AJU7xWNAJKl8bFjMWJ+z5XXySNvFNgGyP8roB
         e1OhEleRn7AJB1k7E2mxPmRdatyqn8Tf1V7a8oCuLNJqkdrzKI9FBvZRCN7XzKKv8z1a
         22uQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXQ0/P5uL3ary2b/d7G286dB9rjl/WBXOyw9psUAY2J/6zQKPka/u1kV/aC0l6JbWO6CB1HrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylcCE9Ju5K/eOiuAeVI6gukKWhzwRvmpzEat4AuLIDVpDJfIv2
	USTguNlhXOpe6n327/FtdDr4sWY7mX4ggygCsjpxNkUhl/1v2MfeC/oX
X-Gm-Gg: AR+sD10w2p8GPHFzqytshiyh7WzQgAQsJZ3thbv0bhr1lUAjsxEF2KtskyYUmV8yHpP
	RjB6/bw1+RZrZFPGCi1NDU/lfTyKcCvHLgoS6SF6psKs0yDRU5zRXmZjGbVNS6ldMN6jvsPcF8W
	pKfw3Te+aoygIyD6a6APzeMBQWa5njaSGxRrKQJdC3vJneQNlX+9Ugci3L8bPtZv1ppuT0ABHvS
	WRNo800ptwCH8hpO9c3CY9cfkaVsD6Dgqm6qGmTsMgpVt4AgXCA8+znp6pPTsg9wCJUPg4rzXTF
	sTyS4+7ox5Tu046eyLkh/wnzYwNu9Y+yDOnk4IoCRJoko4/Zz+dY4gGGR0uG9jqWGatexvolQ10
	jrJ6yyuwMnS5nIpsI5m44x9+cW3D2ySANTf3VKoccBYKJmCf5sTRe8nDzL52vEj5wPjQYkziNvj
	w56Z/EN3G3ASnB7c48xZG3/G8/nptKud2ozHnWxHbJqoxWcF/JZNqz0HNDkgMiLRtSi94F/lIFX
	Phb+dfNNyoqVV9+anScEBJlSy2n/THkL1g+zyKGbROj8DxER3Kmx3yE/ObH1K5Kolf843PFmxzP
	O45ARbSuJ54TTi0Acyy3Y4wfQvs5+KIDWyqC4Q==
X-Received: by 2002:a05:6402:350b:b0:698:e595:a5c with SMTP id 4fb4d7f45d1cf-6a355d8abb9mr1045288a12.6.1786368690814;
        Mon, 10 Aug 2026 06:31:30 -0700 (PDT)
Received: from Ubuntu.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d48f8dsm4198679a12.17.2026.08.10.06.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:31:29 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: [PATCH net v3] RDMA/core: Reject unregistering netdevs in ib_get_eth_speed
Date: Mon, 10 Aug 2026 15:31:20 +0200
Message-ID: <20260810133124.44513-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ib_device_get_netdev() intentionally returns a referenced net_device even
when it is unregistering, so matching and cleanup callers can still find
the association. The reference keeps struct net_device allocated, but does
not guarantee that the device remains operational.

ib_get_eth_speed() uses the returned device operationally by invoking its
ethtool callback. Although that call is made under RTNL, the function does
not verify the registration state first. An asynchronous RDMA port query
can therefore call into a netdev after NETDEV_UNREGISTER and ndo_uninit
have completed.

Check for NETREG_REGISTERED while holding RTNL and return -ENODEV for a
device which is being unregistered. Keeping RTNL across the check and the
ethtool operation prevents unregister from starting between them.

Also copy the device name before dropping the reference, since the warning
path currently dereferences netdev after dev_put().

Fixes: d41861942fc5 ("IB/core: Add generic function to extract IB speed from netdev")
Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v3:
  - Reworked the fix following Jakub Kicinski's review: a netdev
    reference protects the allocation, not the operational lifetime.
  - Moved the fix from ipvlan to the operational RDMA caller.
  - Check NETREG_REGISTERED under RTNL before invoking ethtool.
  - Avoid dereferencing netdev after dev_put() in the warning path.
  - Added the RDMA maintainers and mailing list.
v2: https://lore.kernel.org/all/20260803121140.261329-1-krystianmkaniewski@gmail.com/

 drivers/infiniband/core/verbs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 86811d31092c..d50e761be4c8 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2040,6 +2040,7 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 	u32 netdev_speed;
 	struct net_device *netdev;
 	struct ethtool_link_ksettings lksettings = {};
+	char name[IFNAMSIZ];
 
 	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
 		return -EINVAL;
@@ -2049,7 +2050,15 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 		return -ENODEV;
 
 	rtnl_lock();
+	if (READ_ONCE(netdev->reg_state) != NETREG_REGISTERED) {
+		dev_put(netdev);
+		rtnl_unlock();
+		return -ENODEV;
+	}
+
 	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
+	if (rc)
+		strscpy(name, netdev->name, sizeof(name));
 	rtnl_unlock();
 
 	dev_put(netdev);
@@ -2060,7 +2069,7 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 		netdev_speed = SPEED_1000;
 		if (rc)
 			pr_warn("%s speed is unknown, defaulting to %u\n",
-				netdev->name, netdev_speed);
+				name, netdev_speed);
 	}
 
 	ib_get_width_and_speed(netdev_speed, lksettings.lanes,
-- 
2.53.0
