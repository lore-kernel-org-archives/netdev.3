Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423739DBDB
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199811; cv=none; b=e432IWT/rkM6gueutofW8L7PJkkn5HsuS6WuZ77O1FsZNxAED1dG+JYEht7+er83ptdTInoNF0k/YxJXtPAdxLlBaMdT1kVUqnyaZftGDswby7pq2dtBx+cN/kCsYIsMsn031MwzDaJyfpVyjw21ftBVbd7BB+6T1ysmJdQ9Cv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199811; c=relaxed/simple;
	bh=fAzFXr7QclcpE0D6XBc41/1tf7GsPHZBgP6i4rwO7jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKQvsAmxra8sqq6dyiGX/zmY4DmcqSgBc2qaDMeoItbpBNN+G1o+VVLyKrI0hrUxWzD50cCKdXayJm71Km3oaqKPlBl9YJoC80JpkM4jJbaHbH61vBgceRNL1xTX6lYA8edUkPj22jrk4Pz94i/5nj1kC7EFyXUov9/ZVugfg5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYSloIK0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYSloIK0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c169ae1cb26so24386866b.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788199808; x=1788804608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ab3N2XZDk+KVNr1QDSMytkdAxt1gkHtn2AyrmPIO2uo=;
        b=KYSloIK0DR+tyA1ZN74oYbVTbdHrxGvNnjWLCZwqC8x9BlzS3GZZheW+wccIHChOKr
         HUUP3AsiHzVLYPXHeiv+tln5rN6qrCyx7LPxivrihXHPMVueh5h1KUUgNlYBBd6NJxL4
         zilYyxlJav8+y0cUDeD6raTroIMcFdLClqyUCDwmGuL9puaut4568lfh515rjqWeOfaz
         XAy/HWOLK4JjgeN+C4YXqoIgG+lBE0HWLs5tS0gu6AdoHe5Py8JCmT2SFHFozjRxHE6o
         YALY1LE3Y002QUGCNUPGR9Iw0c2cth2REMNcm2PQJRqiIUfxHx5Flti6iTyZRcQBcWGt
         OtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199808; x=1788804608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ab3N2XZDk+KVNr1QDSMytkdAxt1gkHtn2AyrmPIO2uo=;
        b=aKJD+MhpjaLJKyR2yf68ib3kxr1trAj0usoORvoZjTG1xd25Vr0jiXoia0UQS9MIH+
         ZgRex6T/SRHzZI0FzO5hND2yryzgthTrrF7rjs53K76c2f6XSTpr9UPMNkqUYJ7M7ATA
         vS+7LWDTmH/zsxtdrfI9OP2w7qIT3wWTyn1B0tSOwgfR+A5fUokrxY4RgqpYqx+XPtG8
         TwYI7qpRxrbu8rEC1To3ibffXFKpGNyXbDBoGo7NioZMKfr2cx0aFsRsi+mfaYeVs6dL
         NbM0nysLSiYLRKxStIHRZ3BhlD/6QaUN/NM5f3x459gKj8Izrf49SbWHrUpBm5BWEjkP
         ziLA==
X-Forwarded-Encrypted: i=1; AKwUvBwKqGuWz2PWNP8soBDe9pg+GzgxZ8eNS0URgMyHqZZb6sgrMHTqQnIFINj8gsLAS9cQVWb0GyA=@vger.kernel.org
X-Gm-Message-State: AFuF++lLpC74D6axxVkIUqDxO8sDlQL1lG+Qu73AmXBYzCffBcL209op
	HuD5Sqfo2ekhZsGfFtohFcohG02SNAqaVCV22zEFGpZzFAHOC1c1+OoA5dbPXY6o4WzExg==
X-Gm-Gg: AR+sD118K89XGsjFFh+ct3fTkJlRun3p+fHoWZc82mmMl0axxGy6FTqHnVy7HZVNSYF
	RFzmkNTAC8csSQkeqqt4AujRui7/GSQnFifJzZVlTEbsaSs8NfXrgQduaLS5AV4Q/d7iKKpkBFg
	rI/noLUHctb6U7/u3UzjVMvxUWER0RTbIcEN7ZMvXo16iNNa5IgD+D6AszNpYzfbh15MrkKE2Au
	k/Qt9GwAJxOwwPS3tqjAUOw4fFJOOvzkei17aCZPn5Ej1kodzakdA0o9LFTuV+KemgWMWpxJJ8S
	JQSAp0kCczLvWJgmAIrmgEzrQ/UX/Wqm6npZ1EqDkEntSpovUMmb+8+eDbmGzN1s0FOfRWZA6l9
	qIjdqOYkRPoOo+9I6Irag8cdahKtOOqU9w1UoD6wpRRFkY5erPUwo+GCVuC0vxJYww/PBmZc5gD
	mtI2nfSRUlRM2Slb/6j0AK0y6Kof9dA2tscdgjN5xOb7a+qoKzlas9TcRMsjWghbtygxYyjN0hD
	7rYCgS0jSFMACY=
X-Received: by 2002:a17:907:6d0b:b0:c25:4ca3:dfd8 with SMTP id a640c23a62f3a-c25b90d496fmr5311966b.2.1788199807884;
        Mon, 31 Aug 2026 11:10:07 -0700 (PDT)
Received: from localhost (83-131-188-88.adsl.net.t-com.hr. [83.131.188.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee2872dsm484759766b.15.2026.08.31.11.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:10:07 -0700 (PDT)
From: Dmitry Sinyavin <sinyavin@gmail.com>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Dmitry Sinyavin <sinyavin@gmail.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: wwan: qcom_bam_dmux: account network packets
Date: Mon, 31 Aug 2026 20:10:06 +0200
Message-ID: <20260831181006.1382372-1-sinyavin@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BAM-DMUX data path does not update the network device packet and byte
counters. As a result, userspace sees zero traffic even while packets are
being transferred.

Use the standard per-CPU software statistics helpers. Account transmitted
packets after their DMA completion and received packets after removing the
BAM-DMUX header and padding.

Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
Signed-off-by: Dmitry Sinyavin <sinyavin@gmail.com>
---
v2:
- Read the TX payload length after unmapping the DMA buffer and combine the
  network-device checks.

v1: https://lore.kernel.org/netdev/20260830085400.2542956-1-sinyavin@gmail.com/

Build-tested for ARM with Clang and W=1 using allmodconfig and allyesconfig.
Hardware-tested on Qualcomm MDM9607: three 32-byte IPv4 probes completed
without loss and added three packets and 180 bytes in each direction.

 drivers/net/wwan/qcom_bam_dmux.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index cc6ace8d6437..5bcac2ccaabd 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -177,8 +177,12 @@ static void bam_dmux_tx_callback(void *data)
 {
 	struct bam_dmux_skb_dma *skb_dma = data;
 	struct sk_buff *skb = skb_dma->skb;
+	struct net_device *netdev = skb->dev;
 
 	bam_dmux_tx_done(skb_dma);
+	if (netdev)
+		dev_sw_netstats_tx_add(netdev, 1,
+				       ((struct bam_dmux_hdr *)skb->data)->len);
 	dev_consume_skb_any(skb);
 }
 
@@ -402,6 +406,7 @@ static const struct net_device_ops bam_dmux_ops = {
 	.ndo_open	= bam_dmux_netdev_open,
 	.ndo_stop	= bam_dmux_netdev_stop,
 	.ndo_start_xmit	= bam_dmux_netdev_start_xmit,
+	.ndo_get_stats64	= dev_get_tstats64,
 };
 
 static const struct device_type wwan_type = {
@@ -421,6 +426,7 @@ static void bam_dmux_netdev_setup(struct net_device *dev)
 	dev->needed_headroom = sizeof(struct bam_dmux_hdr);
 	dev->needed_tailroom = sizeof(u32); /* word-aligned */
 	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	/* This perm addr will be used as interface identifier by IPv6 */
 	dev->addr_assign_type = NET_ADDR_RANDOM;
@@ -533,6 +539,7 @@ static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
 		break;
 	}
 
+	dev_sw_netstats_rx_add(netdev, skb->len);
 	netif_receive_skb(skb);
 }
 

base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
-- 
2.53.0
