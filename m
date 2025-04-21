Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589322B8AC
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274527; cv=none; b=mKmVdWB2GkuzcT9RCif/KJtYvYRaT9QrjUsUfViybRX9A2910v++j2oHX37uFfQMn945U8xMTiBfBlP4k1wG0NiSf3WftxsvZJrfzuk8I8enZaJBLRZLeJWfJI26XPjOOHGaLAqhx0FD8ixieSa6GMUKyelk3ouMQcbVl2Bjgek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274527; c=relaxed/simple;
	bh=lx+QMp/TRQSk9uFLKln9p5MhcjTZS9vdFGsVWZ/Auo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKGbOwnruI0fwRTlvVKoGtvO4UHiyv8rZWGV91Q5Az7xdOl501eTl9fwc3mEbLWG7730P8uViCOB9ebbjXU3eTL1fdyxcbrWAhrF0DWyiyQruo0kra2XMScdejJAZLtWKAbT23fe0s72CmxG0YSO0KCHD5A8tqYM06ZFyZHq0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeGE0QzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeGE0QzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103E8C4CEEC;
	Mon, 21 Apr 2025 22:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274525;
	bh=lx+QMp/TRQSk9uFLKln9p5MhcjTZS9vdFGsVWZ/Auo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IeGE0QzOB0nocvkhtk7DwHrY69AG3qAcrAqNVsQGbSwyZLLKJiktVlcVco2FTr0GB
	 gxR9l1bZnAINOB001f+aDNqLQ2IsEbalV8JlpBcYZ2HeukwU0xFUg6jr7ZX7bmLRPS
	 NPwve8EY3M+WHXgaR7VKAT6t0O3l8jJ3LJXsL+WkjZgb11FRHfR03RbH4N5udkzsd2
	 N1GVHniKyW/L6ShfbmGKQ3YB5RMYweZ04WF0MjT87gZiD9lZvRrPz0852Zicnf6f9F
	 9tVslz6+bWqeZL+OO1t5yJluGJWqEE6FqUTRe9+wvc808SykogP5nMP6JVB6KFeEWB
	 sqm0JPkMujk3A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 18/22] net: wipe the setting of deactived queues
Date: Mon, 21 Apr 2025 15:28:23 -0700
Message-ID: <20250421222827.283737-19-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear out all settings of deactived queues when user changes
the number of channels. We already perform similar cleanup
for shapers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.h           |  2 ++
 net/core/dev.c           |  5 +++++
 net/core/netdev_config.c | 13 +++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/net/core/dev.h b/net/core/dev.h
index e0d433fb6325..4cdd8ac7df4f 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -101,6 +101,8 @@ void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending);
 int netdev_queue_config_revalidate(struct net_device *dev,
 				   struct netlink_ext_ack *extack);
+void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
+				    unsigned int rxq);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/net/core/dev.c b/net/core/dev.c
index 7930b57d1767..c1f9b6ce6500 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3188,6 +3188,8 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 		if (dev->num_tc)
 			netif_setup_tc(dev, txq);
 
+		netdev_queue_config_update_cnt(dev, txq,
+					       dev->real_num_rx_queues);
 		net_shaper_set_real_num_tx_queues(dev, txq);
 
 		dev_qdisc_change_real_num_tx(dev, txq);
@@ -3234,6 +3236,9 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 						  rxq);
 		if (rc)
 			return rc;
+
+		netdev_queue_config_update_cnt(dev, dev->real_num_tx_queues,
+					       rxq);
 	}
 
 	dev->real_num_rx_queues = rxq;
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index ede02b77470e..c5ae39e76f40 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -64,6 +64,19 @@ int netdev_reconfig_start(struct net_device *dev)
 	return -ENOMEM;
 }
 
+void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
+				    unsigned int rxq)
+{
+	size_t len;
+
+	if (rxq < dev->real_num_rx_queues) {
+		len = (dev->real_num_rx_queues - rxq) * sizeof(*dev->cfg->qcfg);
+
+		memset(&dev->cfg->qcfg[rxq], 0, len);
+		memset(&dev->cfg_pending->qcfg[rxq], 0, len);
+	}
+}
+
 void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending)
 {
-- 
2.49.0

