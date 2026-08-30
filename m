Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034B392C34
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076703; cv=none; b=ZtL8k8StrwFdzuS8b22grIEXCowTE9TOHcj66KFGtebFsVhXCqZkv3u1Pm5aAbZHiNbzYchDJ19ZbVfEseIw0KKFYZDpWSqZInNfVgiWr77/9wCHzuC3QaGNW37snIEy6AtTVW93fqmyl99/sMqTUDUkBi+56u6rREFYDSGZDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076703; c=relaxed/simple;
	bh=u2Q45OOdAmGx3TrPjohDXloU8EdNrjaZU3VoBzuVIkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unpU27OhsjB8lwUEinFHW8YbHIEMq2S3UgG33q29DGVucDcBR2ufc2T3ZPcN4RDqIIdPIqUCQgwJgx3bU67jdE3Ey5n9a0PfzZ9pC5UMZPH5INyhiSqiGsjPxMOEvdKDrKLXJvRw/+6kXxroEJeclJ6ldLsHn836NooxI+lWwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfRwptkM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfRwptkM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so24191425e9.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788076691; x=1788681491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAJxRQQXvVgRQc+qrTy5F1Tifzrj9A/VOza63N0XwI4=;
        b=jfRwptkMjcY6631c6cZ5RiIyDyRz8PK2laaurQLBAx8/kKmf//53eNX1sN1zUq+8OM
         SjrpURF0h6bVGqotw7eAiC00NG+TZ+i9JaoZqctWABd1801qxQ5tWQPsQYds+fEBgy7G
         L79+ji4JJxe0jUz6zvBfhcw5clQK7Hum9J+v/e7FmW9m5gOCzZh7H6iCpfIexUlLxy3m
         lWHS8ni4FxZlsf40jvlXcInVT2U8RuCYrKuoff6xs1IYxCMCkE1SKWtLh0+iC/8m5/9c
         j9XpzOdDPNnSaCZGJ6K+Ay43RAcu4MgTYJx8ahauCI+rWa4tIXA5i1qW/hWpLYtpCpp7
         Wzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788076691; x=1788681491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cAJxRQQXvVgRQc+qrTy5F1Tifzrj9A/VOza63N0XwI4=;
        b=mkVfrEy69tvCehy9z6Rv6etoh0gYgGUz2SffA+5A/fNddR5T9LtOp87BGV7NaPDOeC
         No10QJsuccKtraVRTadV56pNIrcFJzkLHH43pW14yb1jSVNowWuqe/fhd29nbX12SeMl
         dOCeIsMnwW6eVXW/GfAdSukhrcvbAcasFKCk2BOfP+SwWeqnCo7aZdhCN81uvzL7U0ur
         AofRHU/xDhcRnkgL+6bRPU+vglknXQjx7EUybO/f7W27Ju04p7O/Cgps37SbAr8YMTBR
         5TzvHUufDb0PfbEHQu2+YdH2gVWLf4yYPS8o1IE8CwFRBSXpNZNsV3IvGFYzTkPLaniR
         Isyw==
X-Forwarded-Encrypted: i=1; AHgh+RqYOohezAvUuYWEVi3gBdAgPjLlk/bMKSTBdTtnCIpW83bzuCqXGy98a0j1LQvdLLp6ekzNYyk=@vger.kernel.org
X-Gm-Message-State: AFuF++mj+qqfqDz0jldW383qeKBpnULKNxuPXDJpxcZB1Rn73b6OAxdp
	ZY/DTtSA1uVuVsXY3gXxAfaVHLT/9u02R4FX3EYpKckBdj8rpOtZpDsT7jkvlQI=
X-Gm-Gg: AR+sD12tWRIEMD8BYFYLgGIqSidJkOxR2K5v0ifl0PlCoAMH/DeRHYEaec3yWuwBqwq
	PocmvLJhlH1JoDsy7V521TsPjbn/DbPS4GNamxlaeiha1XNj6UP6l5y0Nr6Nw8cvC8Z9vn/IT2z
	PLghHFgP/38tiRnSgkoum/zc2oE4M/eFYr0uFzRAyj273qlYx8whQGvQjVdO7gKhqf937Uyb15x
	1IHkkhi1UB9hHxRF5rsduGN8l2uR/WCC+WOhyBL8pCPg/QYxGy0D7pD0KUoJLmH/aMfO3VZn5/2
	cNbGPWBrDnnnM+YoeYBBPxk/HOFBfDSFPqud8YxcL9BT58Rzs7+NRlnEyF9C1ohqY3dVHpOVrVt
	0X07tMdXsTeVyeh1JjwA/e3G9M3CCf9geoLvhVZtVdkXiwqHBl8OeZFZKSIhorM1nUdu4yMcPoU
	FXSpE8+SzvNk3RHEvCarv9PQxKo1lpbafT3rPSSsWRguh9/gjOWUw=
X-Received: by 2002:a05:600c:3546:b0:499:dbc0:370d with SMTP id 5b1f17b1804b1-49b91c1dad9mr266282045e9.2.1788076691084;
        Sun, 30 Aug 2026 00:58:11 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd53a4678sm14757875e9.13.2026.08.30.00.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 00:58:10 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH net-next 3/4] net: airoha: add rx_stall_recover ethtool counter
Date: Sun, 30 Aug 2026 10:57:16 +0100
Message-ID: <20260830095717.37218-4-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830095717.37218-1-sochnev.v.74@gmail.com>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the RX-ring hw-stall recovery added by the previous commit
observable without grepping dmesg for its dev_warn_ratelimited():
add a custom ethtool -S statistic, rx_stall_recover, incremented once
per completed recovery.

It's tracked per-QDMA-instance rather than per-netdev, since the
stalled ring can carry traffic for more than one netdev at once (VIP
classification shares ring 4 across several protocols/ports on this
hardware) - there's no single netdev to attribute an individual event
to, so all netdevs behind the same QDMA instance report the same
aggregate count.

Kept separate from the actual recovery fix since this adds new
ethtool ABI and has no bearing on correctness; happy to have it queued
independently if that's preferred.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 44 ++++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_eth.h |  5 +++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index b53fe5b17653..efb1dd69cc16 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1000,6 +1000,7 @@ static void airoha_qdma_rx_recover_work(struct work_struct *work)
 		napi_enable(&q->napi);
 		napi_schedule(&q->napi);
 
+		qdma->rx_recover_count++;
 		dev_warn_ratelimited(qdma->eth->dev,
 				     "qid=%d RX ring recovered after hw stall (RX DMA paused for %lld us on this QDMA instance)\n",
 				     qid, rx_dma_off_us);
@@ -2600,6 +2601,46 @@ static void airoha_ethtool_get_drvinfo(struct net_device *netdev,
 	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
 }
 
+static const char airoha_ethtool_stats_str[][ETH_GSTRING_LEN] = {
+	"rx_stall_recover",
+};
+
+static void airoha_ethtool_get_strings(struct net_device *netdev, u32 sset,
+				       u8 *data)
+{
+	int i;
+
+	if (sset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(airoha_ethtool_stats_str); i++)
+		ethtool_puts(&data, airoha_ethtool_stats_str[i]);
+}
+
+static int airoha_ethtool_get_sset_count(struct net_device *netdev, int sset)
+{
+	return sset == ETH_SS_STATS ?
+	       ARRAY_SIZE(airoha_ethtool_stats_str) : -EOPNOTSUPP;
+}
+
+static void airoha_ethtool_get_ethtool_stats(struct net_device *netdev,
+					     struct ethtool_stats *stats,
+					     u64 *data)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_qdma *qdma;
+
+	rcu_read_lock();
+	qdma = rcu_dereference(dev->qdma);
+	/* aggregate recovery count for the whole qdma instance: the
+	 * stalled ring can carry traffic for more than one netdev (VIP
+	 * classification shares ring 4 across several protocols/ports),
+	 * so there's no single netdev to attribute an individual event to
+	 */
+	data[0] = qdma ? qdma->rx_recover_count : 0;
+	rcu_read_unlock();
+}
+
 static void airoha_ethtool_get_mac_stats(struct net_device *netdev,
 					 struct ethtool_eth_mac_stats *stats)
 {
@@ -3502,6 +3543,9 @@ static const struct net_device_ops airoha_netdev_ops = {
 
 static const struct ethtool_ops airoha_ethtool_ops = {
 	.get_drvinfo		= airoha_ethtool_get_drvinfo,
+	.get_strings		= airoha_ethtool_get_strings,
+	.get_sset_count		= airoha_ethtool_get_sset_count,
+	.get_ethtool_stats	= airoha_ethtool_get_ethtool_stats,
 	.get_eth_mac_stats      = airoha_ethtool_get_mac_stats,
 	.get_rmon_stats		= airoha_ethtool_get_rmon_stats,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 483d6b59c351..d6591a779743 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -582,6 +582,11 @@ struct airoha_qdma {
 	 */
 	struct work_struct rx_recover_work;
 	DECLARE_BITMAP(rx_recover_mask, AIROHA_NUM_RX_RING);
+	/* count of completed hw-stall recoveries, exposed via ethtool -S
+	 * so a recovery event (and the packets it drops) is observable
+	 * without grepping dmesg for the dev_warn_ratelimited() above
+	 */
+	u32 rx_recover_count;
 
 	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
 };
-- 
2.55.0

