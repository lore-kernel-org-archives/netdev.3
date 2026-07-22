Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C43B27E1
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739381; cv=none; b=qK7Z2kS3QtxaQGtRR7x5zkJGeYY85+QiSnOKVKrkzeoJ1ppiRXHj+TMYgpbvo6KPKtXMclB2YRMRby9osRuipa7VD7BcQdHH8uU0CjStff8yB2SDgoyn2QFNG4RXDNFE5EVqPXFONVeOBt2HsrN8dqGHdxxSykuwfT+sxMADRRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739381; c=relaxed/simple;
	bh=T6VI/MjUMTWjR0YmJzrLiiKf7zo+1Zk/2lAOGfSsHHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCJW0GrcL6XNJpa/vLmMAW0p+TaYow6pLXiav35ijFh9I0bgWzUHloHVZpXHb3DE//kkMXxEyxstRAIuC2zpF/rKxaIkK7ePewtmzJFNWdh0OzajZnkAe6iZeCHEifH7NOiG/rh+9zSLjpgYmf0EQsLcNkVvJGWjq0iN4hVfRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbW8SoJY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbW8SoJY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954c08a7c8so84685e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784739377; x=1785344177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRQ5TWPONEvJdayuRFKl7W3Z0rghnTrzVVZ4y0zRgw0=;
        b=CbW8SoJYwIv2U3iTinGx0XjtJKpKPuag9lE3wIo7lGYo2vb3F2GJhutN5YGO4q7lOQ
         AeKJi9t+pXAyRhqWBxLobmGIvkQTtOwyvC0ZAlAAo/flRqB/ipBZBJCE4wTsLG1Rr3cG
         w+Q7hu5Tojxbx8ktzeo90D8NLFcdmib3uuVmVa/JXO9rB+QWfnyTPiiAtssPlUdL1yXL
         3WnSGyf1vjTKxDB7qgSsp+VDiQW8vsADy0DqvblV4FFPPAtvsPUiJ48KaH6LMEJoSw/D
         ibC0TNeB6NrKzmdTR465lGShfhjMGtxBCSMrDaoc6UbxjTX2BqH4JjidznBn0iegMifj
         pmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784739377; x=1785344177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cRQ5TWPONEvJdayuRFKl7W3Z0rghnTrzVVZ4y0zRgw0=;
        b=Ste9FynFwf7REHMnWd27H0p8VmswgFhX1geBfu04yLFPjHZ12kqWYW52Uz8H7bkLeq
         uU+qvovpy/F2yhP/LZqEC4//29BrE2+l5RGlmm6/p0Wh/gzxjqIofel6JAAN1XdzldXl
         RvnUhVsJf+091d6mb1p475pCAWfLcPuXkNixXjFjuhI6XR2YoaRoKNGfZFd0Mrvkrtc0
         CxKOZFmN+la6w1Yninbxg82IY3FTSv48Ye9ce89SfvJ7GVPgZI4bwR4hsZ1bFWZNxTe5
         yfU1hNQ9QxGS6vrc4/5AJuHuI8nuTi4IihfeRInY6bIJ/j75QUJgH4OtxTf70paRRU9+
         ViKQ==
X-Gm-Message-State: AOJu0YzkZvmZNCTuxSved42Tl/g1nkUKFBYAUMpEjJAYC8497B5ZAj3S
	22hYKaM75re2Ewy17QF+Oq3sO9eQRHR74h4ev9Uy3faUqxU5xz918+iXkl2t4DcjUA8=
X-Gm-Gg: AR+sD1051dakdSxchfQPMVbNX5RHZKxz6WstcgipR+QElz8gRwvYrbRPhTaReejScOB
	6B5YI/wIjvtCxOwrxJXm8185uRwdtx7XJ7o3ehigVHT2AbO1WSO1E9bTUpsucBa+BYlqda3pIpH
	kYlVDl3DfBhEKsffC31YFLma4YfQkcwsN5oEfKhUi16FNpZMIHgp/TtdH321XVGZ2Vkdorud9xc
	w33ekhSacjVLUppPOrYIGx0bc6kpwqVj/+JZT5/ZzjRRnh5oRXxGWqfumShqD4l51WFmhhHVbZL
	leH4TE+u4Fsm+7HR7sS7+7IEfD24LgqeIRIyCp8Y3wGBukKPry0NZLxiN45n3TS/TDXlIny5MNr
	5QDwhnL59sf8/8WPLVI1q3vSbnYrOMN8x5s48rqHa5ARoysGsmXyoj9ddO9MZvWsB0iADOtUKft
	TdmGKu7qwEb1bjXZ9LFsZRJWOx8j+DQFicEZpGGK+2VUWAZYdyPGBE64No7Rz9NOBvor1XVHyuz
	V9btRcDxVVk5JYwVpD0LR+/XSFLvAD1o3QNzQ==
X-Received: by 2002:a05:600c:474c:b0:495:6f6a:f48b with SMTP id 5b1f17b1804b1-4956f6af50dmr15751855e9.5.1784739377292;
        Wed, 22 Jul 2026 09:56:17 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-078-051-150-230.78.51.pool.telefonica.de. [78.51.150.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm7288629f8f.22.2026.07.22.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:56:16 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	qingfang.deng@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/4] net: hsr: fix packet drops caused by GRO superpackets
Date: Wed, 22 Jul 2026 18:56:11 +0200
Message-ID: <20260722165614.124-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722165614.124-1-xiexinet@gmail.com>
References: <20260722165614.124-1-xiexinet@gmail.com>
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
index 9981d637f..eba2c26a4 100644
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
index 5933c5dab..a6cf2adc8 100644
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
index 437947dd0..02fb21629 100644
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
index d9af9e65f..cefbbfbd5 100644
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

