Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFB318EE2
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488551; cv=none; b=mFkHw9PL9KHwrSbYs9DifYyZqNn5WPeTYHldUUTZ/6S103avdMd0NTT5hSnCwu2lSUd2oWOHdvZqHjApW21xtdfLE3SoZnKXHUDhl0ICmhli/YeuVwTHZUwJa/DExaKc/zlUr/jDnac7BW5R+yPi+9P9StpWAfp2npQpPIRAA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488551; c=relaxed/simple;
	bh=0rflTe54TijjzunwMIYxkwBCoYwbcmj+eJ/5a8rrMtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE4CA/gfe8Wn60WXrlqtdhyoQnLX9QZtpyzHvOxeVNoXBa5+/oVqVoPJPXqKQcLtATLp0vgTPAZC3n/pk/AzipqrtEdSjVpVD3NYNkDziB9kaai0T9+FfNFUSWzTe0WWTtedSjEdMfjSAjvMHDYxs28QviuF0R0RCcEJ1HRXUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaJCrdRf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaJCrdRf"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69fdfd98eb8so108924a12.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785488548; x=1786093348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l1mYauMG9GINwFO5wrxlpL/vPzaA4PT/FlWkWnobmqU=;
        b=EaJCrdRfaotcSsuVX/jCAW+VvhsKtLvkQ8y4Gyyaus19YJGVbfPuw47KiTaQNoe55k
         YAHVgFRSazuMRJd6NPsX8j+llqye4Fj6I+Bv7GJEqzxs4uDmhQ2de5VVjIptgksYK6r4
         Z1p5ap+dNTOj6i3rzyBtHPSgzmWRlLSn85H6QG3wX638lhOD534LtyPitN+CMtBP6T6z
         XXgSKVG3XfPopMMUq7xqAyMOMSsq5WgA5IyhNLyzH7cIFI5kf3R9OGRzHG8F+W6m92In
         BY4VVFS2tbiibLfCL8xhblfy7nbsus09K7n1Mlgd4vLTS3lTlbp0cV3C6BZFJBuPkkjL
         9arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785488548; x=1786093348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l1mYauMG9GINwFO5wrxlpL/vPzaA4PT/FlWkWnobmqU=;
        b=K8+8ir3INCnUopdD7h/d2B5ynvdIMlf4D6qHfkEFsG+H5RUsxVMqo9YFFv7x+smClC
         n8NpaVzlC5GnC2Tu1v4fEB4WtRgByox6O8RVEkZXSCJ7gC+1K80xa/DbdooxWms0V7rd
         Wq5QzHQUazMZEV4uCeWcS50jjSsnmf3jhqN/iYtKuhW/TeYXO15CoLxcQGTc3Kkw94Bw
         6qMKWyZLLBvb7JXWIEahDse6rdTl/CKOn7QSgoTB1Dmya7xWv9IkVPZMIvogrpC1Qyjd
         AnZxJ7PymyRpcPcrcGOdZzHjzWMPvm9doZCltLy96LOafAuJ+csIk+wHRSpgqUNgXfWs
         LYBg==
X-Gm-Message-State: AOJu0YxoUzKIjsOHVYkkEzwV//NysQ92snCG9/u4bywzsOIqRZqWu3n8
	66I7Z4YE675dVGaWHmIWpcz65BDrm868TxXz+3vgHD6VCTUgXVw+kxRjfR1ouYUfKXU=
X-Gm-Gg: AR+sD12e8GdPw5WWarOKWNgt+dZG1oWy/HCY0ue1ukmhreC1sG3cpxWYXGCXwd/g/rH
	hz87wPFKYhJJV8ymarux142MoV1W5/60vF25pz0at79GZXnalUL6h4XOjYSMyfb9D4UuRUJQyVK
	zzP9xVpAjT5nvJEkWpo5dQbZCYhgaEW11kOs2QToRJrrweBbGc8ig43Ol70ZqWrAhTUAi9M6l+g
	OsRXc4nTqers0UbEuzqYMl7wyPQ0Xp/7+sA96l3CwiTe/oYKfTLrH/BLhZZnFBWs88yOma+bH5E
	XZ/tDsx5UmgaQe5uW/e9XTtL3u7yLMyiB6FV0/zi50OwXu/2w2/rQUsI4sja0rSrODTTHqq4BtA
	eSd9yEkjRR4ypVZ0aHxFf73dJ+3YaWOGaVynn0qzanQKow5sOZCji+cnNyKlQbGw8/UpyHEVrzA
	EzH1rXkG+e7fGB3rKa7Q0dJPCSZ/RQg64tcGd2Dege4F4UyW4UUdcwVodkxoOHYgAcWClKxZQ5R
	YhKGdpJ4JEOAUTKmNR1upuy474QCc0wm9eEXbCdrw/3BJfmwaNf+c1oqv7hokp+1S18zH2nFHZY
	4e6/EpKCy4HCe9R1hC4BNA==
X-Received: by 2002:a05:6402:2424:b0:67d:4eea:a29d with SMTP id 4fb4d7f45d1cf-6a098f25f0emr740566a12.4.1785488547476;
        Fri, 31 Jul 2026 02:02:27 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-184-219-058.77.184.pool.telefonica.de. [77.184.219.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1a58sm2965051f8f.7.2026.07.31.02.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:02:27 -0700 (PDT)
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
	stable@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v3 1/4] net: hsr: fix packet drops caused by GRO superpackets
Date: Fri, 31 Jul 2026 11:02:20 +0200
Message-ID: <20260731090224.18-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731090224.18-1-xiexinet@gmail.com>
References: <20260731090224.18-1-xiexinet@gmail.com>
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
receive/forward path sees a single skb instead of the individual
frames. Depending on the lower device, that super-skb is then either
rejected outright (for example when it exceeds the lower MTU at
egress), or forwarded without valid per-wire-frame HSR/PRP
processing: its single trailing tag/RCT cannot represent the
per-frame trailers and sequence numbers of the aggregated frames. On
memory-constrained devices, processing super-skbs in softirq context
can also pressure atomic memory allocation.

The HSR/PRP stack already disables LRO on enslaved devices for the
same reason. Extend that treatment to GRO: add netif_disable_gro()
and dev_disable_gro() mirroring netif_disable_lro()/dev_disable_lro(),
and call dev_disable_gro() from hsr_portdev_setup() so enslavement to
an HSR/PRP master automatically strips NETIF_F_GRO and NETIF_F_GRO_HW
on the lower device (recursively on its own lowers, as with LRO).

This is a setup-time default, not an immutable feature policy: a
later privileged feature override, or a lower newly attached below a
stacked slave, can re-enable GRO without re-walking the HSR
enslavement path. Patch 3 is the fail-safe for that case: a GSO skb
that nevertheless reaches the forward entry is segmented on the
plain master/interlink paths or rejected on the LAN/tagged paths, so
invalid aggregates are never forwarded as-is -- though a later
override can still cost traffic on a LAN ingress.

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
index 9981d637f8b5..eba2c26a49ba 100644
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
index 5933c5dab09e..a6cf2adc8625 100644
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
index 437947dd08ed..02fb21629512 100644
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
index 01c73b4b50dd..da06b21cdf51 100644
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

