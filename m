Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA9D442FA5
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909586; cv=none; b=BBxLR0CjJWgTm5Iga3ntTybK5Q+i+SH2in51eUJ2qgUYJ/J91G4518Q0Dq0nWsD5njNPCg7Yb5K6qpcuiB0UXP9h26w+n5uT8IdU7xrobt9rIvpKPCDOD1/Z4qCMivOcEo5XrhyB84DYTE3rsNqUbRfa0ro+RxFs0jTQVNEXUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909586; c=relaxed/simple;
	bh=LKbFUDhj3VWhwQaESnH2NVyncH+CR8IBlzH7bYjPfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtOlAnohofqgbhc0GIw2gDiqr5dHuEoHEUqhIWte99wBxG14gjCvkyzt6XKnndX/f8vWcVjBBl9Cdo0ALs2JkIDvq3+FfhMBhkNQ2Ej0L6UR6CP5zchNiOMYqwC8EcKlaYWy/OYezqvfM4pMF+2rwGkhxUxj7N7YMxPnRma9A84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgx2Y+bE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgx2Y+bE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954a2dba6cso639045e9.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784909577; x=1785514377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g5QCk+t6gnqXj6DEKChexCyjlhSd215AVJ6Z8sL7eXs=;
        b=sgx2Y+bETIngYbB+KU9LklzffUhbsct07z/XF3f/xANDZQCdTxDRC9BOFhIDdjqIHK
         OPj0SfWwW8jgQYIN9aS43y+OZMwmV/HjibOICRkzOxFXvV80ot46bdyLLy5/79L2DeeS
         Edxn4G2zKcTp88DNABmGweRJNo6CSGwP2n2curwbP9tjaiqj0+L+slzJn7l/S1RAHtzJ
         Jp1ZHhGMCiqr8R+mP08g0ymDyzN8b2YTiS8fWdbdrgbE/U7C8dm7u74SoKayJ0kFP3bo
         GWhMi/GM23JG1cAEjgtc+KK4Oz00ntFfFZHl2EDDNDEDfsstaidgz/KUPXOaZPQEQPK1
         6XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909577; x=1785514377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g5QCk+t6gnqXj6DEKChexCyjlhSd215AVJ6Z8sL7eXs=;
        b=FEJVCArrt+Tbhj3c+72S7tiHdMDXTaJ9g4iab6bctdcxcBBiuHQ/txrlr8imRFo6T7
         sYbXhfMaqGZwLARZKxxO0GctuEi0RjF4hPUdI+HO1QsmvrtBiBWBgXNSKUo37rcgJHPq
         N8iswl8SNaeRx1xn/I4FhIh/pgCfV9jxHu3Xv8eopQ1Hi+I2Mzaa9+iJKLQA10f9SP9i
         a4U3/CCR5cWTZkwpLLdWXfQofQk/gBH0Z7i6NLaD+spIy9JpF8KkiNkUq4boJ+bW4Lzr
         M+7R42bCjNlzW/H/WMQwS7saZDtPdemea08JGnrGItuoMcQam+BXktMlI/bQfxsvDfCi
         yrCA==
X-Gm-Message-State: AOJu0YyGFlVZqxZjDvjihPaFOSEZHXSaLUbsIBR+xTG4PnI+WgOY4wMo
	MRy7oCIbXQH3wSHlOWlR+ZnsCF9CDIBb8w1XjTRjGZhf7iyAanhShJObkYJbbsxISUA=
X-Gm-Gg: AR+sD12nYMEdIps4H03ldLu6Sb9kMFKupfWi2kWAkYSJdMRJM2EiEYh4DdVX1UrDezg
	N5FwDwUZ/ToWSTSV26OKeA+POw9lxnI730ohs0gat1UnpjZTjYFYFa4vH/PMpyxhxr/6fGdOUZJ
	EqKc+YsAG/HJsJBS7bhteDBSEa/qVIKIOzz3LNR0Rc74UpMxwtz2f1QTWupRrarHvjoGk9y6UAA
	/NOERVdIKiqywJgngONSy768Lew4vAEfFqyyY0/GYRYX05YfBe4uMlQpMUl3WGCd1XsNr1+l3zn
	If4+AEssNiCxax7tcJC7WG3cahxY8/wDv0hVDeTBIcXoUJFVXxBXa05ZELX/QVHGJtq1NOkqyZL
	uDMkpzwqmDopxHePILaMVuwbwoYu6YcZBDuEw57Is5Sk0nd14CPy9jwVv4SmIE2FLR+QTENPa+F
	K8iAx412gMIXIcmcddbSxPYWPYpAP6zkl5zZwDo3hbAibyILdru6/nju5qO01Wd9zbutmVu2Fne
	WTHByuBAIdGVho2Npmt0gBz7y0h5n9o0KFwvJU=
X-Received: by 2002:a05:600c:190b:b0:495:4840:c6b with SMTP id 5b1f17b1804b1-4957a7e9131mr33384715e9.1.1784909576912;
        Fri, 24 Jul 2026 09:12:56 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-181-161-038.77.181.pool.telefonica.de. [77.181.161.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm40969655e9.1.2026.07.24.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:12:56 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	Xin Xie <xiexinet@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/4] net: hsr: fix packet drops caused by GRO superpackets
Date: Fri, 24 Jul 2026 18:12:50 +0200
Message-ID: <20260724161253.79-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724161253.79-1-xiexinet@gmail.com>
References: <20260724161253.79-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR/PRP append a 6-byte tag/RCT to every forwarded frame and process
each frame individually (sequence numbering, duplicate discard). When
a lower device aggregates received frames into a GRO super-packet --
in software, or in hardware on GRO_HW-capable NICs -- the HSR
receive/forward path mishandles it: frames are dropped and, on
memory-constrained devices, processing super-skbs in softirq context
can also pressure atomic memory allocation.

The HSR/PRP stack already disables LRO on enslaved devices for the
same reason. Extend that treatment to GRO: add netif_disable_gro()
and dev_disable_gro() mirroring netif_disable_lro()/dev_disable_lro(),
and call dev_disable_gro() from hsr_portdev_setup() so enslavement to
an HSR/PRP master automatically strips NETIF_F_GRO and NETIF_F_GRO_HW
on the lower device (recursively on its own lowers, as with LRO).

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Cc: stable@vger.kernel.org
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 18 ++++++++++++++++++
 net/core/dev_api.c        | 16 ++++++++++++++++
 net/hsr/hsr_slave.c       |  1 +
 4 files changed, 37 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b..eba2c26a49b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3434,6 +3434,8 @@ void dev_close(struct net_device *dev);
 void netif_close_many(struct list_head *head, bool unlink);
 void netif_disable_lro(struct net_device *dev);
 void dev_disable_lro(struct net_device *dev);
+void netif_disable_gro(struct net_device *dev);
+void dev_disable_gro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 5933c5dab09..a6cf2adc862 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1840,6 +1840,24 @@ void netif_disable_lro(struct net_device *dev)
 	}
 }
 
+void netif_disable_gro(struct net_device *dev)
+{
+	struct net_device *lower_dev;
+	struct list_head *iter;
+
+	dev->wanted_features &= ~(NETIF_F_GRO | NETIF_F_GRO_HW);
+	netdev_update_features(dev);
+
+	if (unlikely(dev->features & (NETIF_F_GRO | NETIF_F_GRO_HW)))
+		netdev_WARN(dev, "failed to disable GRO!\n");
+
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		netdev_lock_ops(lower_dev);
+		netif_disable_gro(lower_dev);
+		netdev_unlock_ops(lower_dev);
+	}
+}
+
 /**
  *	dev_disable_gro_hw - disable HW Generic Receive Offload on a device
  *	@dev: device
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 437947dd08e..02fb2162951 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -269,6 +269,22 @@ void dev_disable_lro(struct net_device *dev)
 }
 EXPORT_SYMBOL(dev_disable_lro);
 
+/**
+ * dev_disable_gro() - disable Generic Receive Offload on a device
+ * @dev: device
+ *
+ * Disable Generic Receive Offload (GRO) on a net device.  Must be
+ * called under RTNL.  This is needed if received packets may be
+ * forwarded to another interface.
+ */
+void dev_disable_gro(struct net_device *dev)
+{
+	netdev_lock_ops(dev);
+	netif_disable_gro(dev);
+	netdev_unlock_ops(dev);
+}
+EXPORT_SYMBOL(dev_disable_gro);
+
 /**
  * dev_set_promiscuity() - update promiscuity count on a device
  * @dev: device
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d9af9e65f72..cefbbfbd5ef 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -170,6 +170,7 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	if (res)
 		goto fail_rx_handler;
 	dev_disable_lro(dev);
+	dev_disable_gro(dev);
 
 	return 0;
 
-- 
2.43.0

