Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964641;
	b=UkLMki9zUybQJOdDpX6/CfeLtB1EhOWIKLndNUqllpWlTfp3US0T7dWN2Yx0XAfpSoSl
	 Z7ONgM1FUKF0JroYxU7MDQJkSN8uWT+KMmajQFg5shQJh/xJLo3Q/AR3z+T3uwhgMLw+9
	 2ak2IoBDxs0fZecOqvPOAxuuoM/w/2nrFNxu2rHNkcNYpO6TuRzJo8YWMdulYuQkQS8z/
	 RFBiYVIye+ECJdP0ggtD1Ljx0kSFq4RMFf4YiRKKGbkdBW4ybWvYoMYoxtlHMy92lpY/G
	 hicyBkmg/dy554KFGzBL390mgsMQQRhqbHTj+50VycUEpuZSN/zQ7FY0nz27tdByKog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=CrfElRZRo9uRmTb7XK5N8Eb8N2McRpUcg6jI1fD/RGM=;
	b=IlNATnzad7Nn9ctRn3Va256WZrHC04tHw/58MCg9VK3UezgCGQWjyMpIZPiPttYw/jDN
	 Ufcbr2XQC2uHC/lD3EQXHpulFZBWL6gkw43qBNjS3L/OMOWr4b2cQobChldRHKbpIifxd
	 vKs7BzsZSoyHgvxCbcuIzt9cOlOTGEff4usLFpvNm9w+9vMEgdq2CJdpwwQ9Lf5tItu7V
	 syUlCRE1pduGZw20+gM3wsKeqs1j11Lbjf3PJHPYQe8988Q2Y7Tg1gPLCyskG5KQFtS76
	 zfGlL40XR09+lX5p+vHxz592znZHxmQrMZ9qVGnnEIGlo2YXhM/5F4IUkeoha3PvuBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZAISUl/z";
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631066083632
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 11:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 631066083632
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZAISUl/z
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67583c777abso613818d50.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964640; x=1794569440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CrfElRZRo9uRmTb7XK5N8Eb8N2McRpUcg6jI1fD/RGM=;
        b=ZAISUl/zH6+1G1tVfiYRtTSQnJScjdFb4Nd7LBW0uQWlM4InA6Q3dbLiwZmqNGgaoL
         0KFJBy9vyojh9ld9kOoljSYtd3BDrp8LoDy1CSOtTQRvTL4Q8JksX8QLKUrARw/RgMw1
         xlAj6sSLlQtMP7JzEO+TZwoT1lGJrZBt51NLinmCFVwXeXcWo7GsITtUOLz5Th12k16/
         LG0i7fHkij2xsr9A6hsNZcjzZADEphtegvynYmOGREBgHWWWqkNr2jBPhyrtkfOb2uBz
         xXxTDqlUhlE8pueoIzzX3PWL2UXhGC6i+sG004x+w+0l8oA6BG1SNhJ0uXOe5BmiDx3d
         O2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964640; x=1794569440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CrfElRZRo9uRmTb7XK5N8Eb8N2McRpUcg6jI1fD/RGM=;
        b=2GGpuzj3taSirVPT8ywPyykiuNJpBjBEXnwD0wu+Lx9IcXSOSOAjPsyi/oGaFp3+BI
         tAR4GUp2gGCwQpKZKc/y482p4zGs28kdd6VgHXYLoX3EMB4trYz89n4NzXk8o0wq+LYq
         hIEqZw2AlnqxlMLC//ojmzv87BDRyo2g1HrlFoqHSxd9X5dUg7e5lV1HOrLXEIBjBWbf
         EXNgDL8/lYPRGr3tgE+HUW7EglrTzFDayJdxbgMHb04GEkjHzJzp2fELZ2wiEUmlt2I/
         G3WspxEyeO2QEszKCP7THvxLxfUL9vwdqvgf5+LZ5aGk5jTtCPuPzfOizz+EHamsYNe8
         0scQ==
X-Gm-Message-State: APuU4Z9zdrJ40R9567maMOapAKpfONV52VD7QWeewblnlxXrrPm2vljs
	6YcpUqqoZcYYephRy5jlf6fRSJJ5Nh/vsL4iEtNYPYkuxc2a/fID9Pyq
X-Gm-Gg: AYBFou2yTeRFGvxCmeVnJ34cUfPEj0z2BKwZtgoYgV1gdthAeO9XBRDMkcmEnfRIBDs
	0ctrQRxR99zcLW83IFVHqMGRIvW8vn75SlsV2lHUzoUTC8EsV51b8JBSXOO+qTrX8LzPIAd41Uo
	MskiMQ2UhUTflUSxXXFYW7XHU/3ZaqKpRiFgk2iDfUj6bEpttIQxcrPlLHx6mHONevh/AuZcxZz
	d6n2GBLb4aKAohcVgaKNN7O+zvX+12zQ4z9QEKU2N4XqF/q1LiVjnDDzHPoVvpWfNEy2CfOCaAm
	ssY0DiDPINNlFaIzU+u+qcBvaz+9bdaM5uNcTWQ5W8q1oJObWtN33/KDXE4Kp0nLuNUQL62Q9MG
	Ys+nmsUD3cSDz7Izp+cAT4yXt34Ggj/c4b7Py6Spjm+NGIdCjGZr5b4XPHI53vPU2eLaq/qpd82
	rT9cPNioe4g/dDGFt6tULQtDhe6PVKUcMQX5pERGxECSA7BIF2Tu6axQug8kTga9F0hfX9jM8+l
	jY4ItBds9u4dworr/bkqINvFG7iUtss28RPeK5QyUlZoSKQlwBXMTGdw1qASKW0AIH0pxZn3EKd
	spPPIq79hVOrYjOuSBowMpXLZQ==
X-Received: by 2002:a53:eb82:0:b0:67b:f56b:4a4f with SMTP id 956f58d0204a3-67c143bf089mr1059355d50.26.1793964640219;
        Fri, 06 Nov 2026 03:30:40 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c13540451sm1703178d50.10.2026.11.06.03.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:30:39 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 06 Nov 2026 03:30:07 -0800
Subject: [PATCH net-next 3/6] eth: mpnic: TCP segmentation offload
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-mpnic-lso-v1-3-e943ff1493e4@gmail.com>
References: <20261106-mpnic-lso-v1-0-e943ff1493e4@gmail.com>
In-Reply-To: <20261106-mpnic-lso-v1-0-e943ff1493e4@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

Support segmentation of non-encapsulated tcp4/tcp6 packets. When doing
segmentation the device expects the l4 checksum to be seeded with 0
length.

IPv4 header and TCP checksums that compute to zero are sent as 0 rather
than 0xffff when the HW segments packets. IPv4 IDs are incrementing
starting from the value that is in the skb's IPv4 header.

Count gso super and wire packets and report via the netdev qstats API.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    | 27 ++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c   | 11 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 17 ++++--
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  2 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 85 ++++++++++++++++++++++----
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  2 +
 6 files changed, 129 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index 1c86f114ab0c..672ce0a98c22 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -16,8 +16,21 @@
 #define MPNIC_TWD_L2_HLEN		DESC_GENMASK(5, 0)
 #define MPNIC_TWD_L3_IHLEN		DESC_GENMASK(23, 16)
 #define MPNIC_TWD_CSUM_OFFSET		DESC_GENMASK(27, 24)
+#define MPNIC_TWD_L4_HLEN		DESC_GENMASK(31, 28)
+#define MPNIC_TWD_L4_TYPE		DESC_GENMASK(33, 32)
+enum {
+	MPNIC_TWD_L4_TYPE_TCP	= 1,
+};
+
+#define MPNIC_TWD_FLAG_REQ_LSO		DESC_BIT(35)
 #define MPNIC_TWD_FLAG_REQ_CSO		DESC_BIT(36)
 #define MPNIC_TWD_FLAG_REQ_COMPLETION	DESC_BIT(37)
+#define MPNIC_TWD_L3_TYPE		DESC_GENMASK(42, 40)
+enum {
+	MPNIC_TWD_L3_TYPE_IPV4	= 1,
+	MPNIC_TWD_L3_TYPE_IPV6	= 2,
+};
+
 #define MPNIC_TWD_FLAG_DEST_MAC		DESC_BIT(43)
 #define MPNIC_TWD_TYPE			DESC_GENMASK(47, 46)
 enum {
@@ -26,6 +39,8 @@ enum {
 	MPNIC_TWD_TYPE_LAST_AL	= 3,
 };
 
+#define MPNIC_TWD_MSS			DESC_GENMASK(61, 48)
+
 #define MPNIC_TWD_ADDR			DESC_GENMASK(45, 0)
 #define MPNIC_TWD_LEN			DESC_GENMASK(63, 48)
 
@@ -312,7 +327,19 @@ enum {
 /* NIC_CORE_TOF */
 #define MPNIC_TOF_TCAM_DEST_REMAP	0x7e3022		/* 0x1f8c088 */
 #define MPNIC_TOF_MODE			0x7e302e		/* 0x1f8c0b8 */
+#define MPNIC_TOF_MODE_IPV4_ID_MODE		CSR_GENMASK(0, 0)
+enum {
+	MPNIC_IPV4_ID_MODE_FIXED	= 0,
+	MPNIC_IPV4_ID_MODE_INCREMENT	= 1,
+};
+
+#define MPNIC_TOF_MODE_IPV4_ZERO_CSUM		CSR_BIT(1)
+#define MPNIC_TOF_MODE_TCP_ZERO_CSUM		CSR_BIT(2)
 #define MPNIC_TOF_MODE_L4_ZERO_CSUM		CSR_BIT(4)
+#define MPNIC_TOF_TCP_FLAG_CLR		0x7e3030		/* 0x1f8c0c0 */
+#define MPNIC_TOF_TCP_FLAG_CLR_FIRST_SEGMENT	CSR_GENMASK(8, 0)
+#define MPNIC_TOF_TCP_FLAG_CLR_MIDDLE_SEGMENT	CSR_GENMASK(24, 16)
+#define MPNIC_TOF_TCP_FLAG_CLR_LAST_SEGMENT	CSR_GENMASK(40, 32)
 
 /* PEMO_WRAPPER */
 #define MPNIC_OB_ATTR_RO			CSR_BIT(1)
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_init.c b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
index 71d13bec7ec4..b9a41656f8f7 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_init.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
@@ -8,6 +8,7 @@
 #include <linux/iopoll.h>
 #include <linux/log2.h>
 #include <linux/sizes.h>
+#include <net/tcp.h>
 
 #include "mpnic.h"
 #include "mpnic_txrx.h"
@@ -299,7 +300,17 @@ static void mpnic_txglb_init(struct mpnic_dev *mpd)
 	 */
 	mpnic_wr64(mpd, MPNIC_TOF_TCAM_DEST_REMAP, 0);
 	mpnic_wr64(mpd, MPNIC_TOF_MODE,
+		   FIELD_PREP(MPNIC_TOF_MODE_IPV4_ID_MODE,
+			      MPNIC_IPV4_ID_MODE_INCREMENT) |
+		   FIELD_PREP(MPNIC_TOF_MODE_IPV4_ZERO_CSUM, 1) |
+		   FIELD_PREP(MPNIC_TOF_MODE_TCP_ZERO_CSUM, 1) |
 		   FIELD_PREP(MPNIC_TOF_MODE_L4_ZERO_CSUM, 0));
+	mpnic_wr64(mpd, MPNIC_TOF_TCP_FLAG_CLR,
+		   FIELD_PREP(MPNIC_TOF_TCP_FLAG_CLR_FIRST_SEGMENT,
+			      TCPHDR_PSH | TCPHDR_FIN) |
+		   FIELD_PREP(MPNIC_TOF_TCP_FLAG_CLR_MIDDLE_SEGMENT,
+			      TCPHDR_PSH | TCPHDR_CWR | TCPHDR_FIN) |
+		   FIELD_PREP(MPNIC_TOF_TCP_FLAG_CLR_LAST_SEGMENT, TCPHDR_CWR));
 
 	mpnic_wr64(mpd, MPNIC_TCM_MEM_INIT_REQ, MPNIC_MEM_INIT_TCM_VAL);
 	mpnic_wr64(mpd, MPNIC_TDE_MEM_INIT_REQ, MPNIC_MEM_INIT_TDE_VAL);
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index 91b70fe8483c..3a4aa5be57a1 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -205,11 +205,11 @@ static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
 {
 	struct mpnic_net *mpn = netdev_priv(dev);
 	struct mpnic_ring *txr = mpn->tx[idx];
+	u64 csum_partial, hw_gso, hw_gso_wire;
 	struct mpnic_queue_stats *stats;
 	u64 bytes, packets, stop, wake;
 	struct mpnic_q_triad *qt;
 	unsigned int start;
-	u64 csum_partial;
 
 	if (!txr)
 		return;
@@ -228,12 +228,16 @@ static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	do {
 		start = u64_stats_fetch_begin(&stats->syncp);
 		csum_partial = u64_stats_read(&stats->twq.csum_partial);
+		hw_gso = u64_stats_read(&stats->twq.hw_gso);
+		hw_gso_wire = u64_stats_read(&stats->twq.hw_gso_wire);
 		stop = u64_stats_read(&stats->twq.stop);
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 	tx->bytes = bytes;
 	tx->packets = packets;
-	tx->needs_csum = csum_partial;
+	tx->needs_csum = csum_partial + hw_gso_wire;
+	tx->hw_gso_packets = hw_gso;
+	tx->hw_gso_wire_packets = hw_gso_wire;
 	tx->stop = stop;
 	tx->wake = wake;
 }
@@ -249,7 +253,9 @@ static void mpnic_get_base_stats(struct net_device *dev,
 
 	tx->bytes = base->tx.bytes;
 	tx->packets = base->tx.packets;
-	tx->needs_csum = base->tx.csum_partial;
+	tx->needs_csum = base->tx.csum_partial + base->tx.hw_gso_wire;
+	tx->hw_gso_packets = base->tx.hw_gso;
+	tx->hw_gso_wire_packets = base->tx.hw_gso_wire;
 	tx->stop = base->tx.stop;
 	tx->wake = base->tx.wake;
 
@@ -322,7 +328,10 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 	netdev->features |=
 		NETIF_F_SG |
 		NETIF_F_HW_CSUM |
-		NETIF_F_RXCSUM;
+		NETIF_F_RXCSUM |
+		NETIF_F_TSO |
+		NETIF_F_TSO_ECN |
+		NETIF_F_TSO6;
 
 	netdev->hw_features |= netdev->features;
 	netdev->vlan_features |= netdev->features;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
index 76ec9811e79e..567a52d0b33d 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
@@ -17,6 +17,8 @@ struct mpnic_base_stats {
 		u64 bytes;
 		u64 dropped;
 		u64 csum_partial;
+		u64 hw_gso;
+		u64 hw_gso_wire;
 		u64 stop;
 		u64 wake;
 	} tx;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 680625810ec0..e2e6ab6d3c59 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -16,11 +16,14 @@
 
 struct mpnic_xmit_cb {
 	u32 bytecount;
+	u16 gso_segs;
 	u8 desc_count;
 };
 
 struct mpnic_tx_hdrs {
 	unsigned int i3len;
+	unsigned int l3_type;
+	unsigned int l4_type;
 };
 
 #define MPNIC_XMIT_CB(__skb) ((struct mpnic_xmit_cb *)((__skb)->cb))
@@ -215,30 +218,82 @@ mpnic_tx_map(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 
 static void mpnic_tx_fill_hdrs(struct sk_buff *skb, struct mpnic_tx_hdrs *hdrs)
 {
-	hdrs->i3len = skb_checksum_start(skb) - skb_network_header(skb);
+	if (!skb_is_gso(skb)) {
+		hdrs->i3len = skb_checksum_start(skb) - skb_network_header(skb);
+		return;
+	}
+
+	hdrs->l4_type = MPNIC_TWD_L4_TYPE_TCP;
+	hdrs->i3len = skb_transport_offset(skb) - skb_network_offset(skb);
+	hdrs->l3_type = ip_hdr(skb)->version == 4 ?
+			MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
 }
 
-static void
+static bool
+mpnic_tx_lso(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
+{
+	struct skb_shared_info *shinfo;
+	unsigned int l4len, hdrlen;
+	struct tcphdr *tcph;
+	__be16 payload_len;
+
+	if (skb_cow_head(skb, 0))
+		return true;
+
+	shinfo = skb_shinfo(skb);
+
+	tcph = (struct tcphdr *)skb_checksum_start(skb);
+	l4len = __tcp_hdrlen(tcph);
+	payload_len = cpu_to_be16(skb->len - skb_checksum_start_offset(skb));
+	csum_replace_by_diff(&tcph->check, (__force __wsum)payload_len);
+
+	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_L4_HLEN, l4len / 4) |
+			     FIELD_PREP(MPNIC_TWD_MSS, shinfo->gso_size) |
+			     MPNIC_TWD_FLAG_REQ_LSO);
+
+	hdrlen = skb_checksum_start_offset(skb) + l4len;
+	MPNIC_XMIT_CB(skb)->bytecount += (shinfo->gso_segs - 1) * hdrlen;
+	MPNIC_XMIT_CB(skb)->gso_segs = shinfo->gso_segs;
+
+	u64_stats_update_begin(&ring->stats.syncp);
+	u64_stats_inc(&ring->stats.twq.hw_gso);
+	u64_stats_add(&ring->stats.twq.hw_gso_wire, shinfo->gso_segs);
+	u64_stats_update_end(&ring->stats.syncp);
+
+	return false;
+}
+
+static bool
 mpnic_tx_offloads(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 {
 	struct mpnic_tx_hdrs hdrs = {};
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
-		return;
+		return false;
 
 	mpnic_tx_fill_hdrs(skb, &hdrs);
 
 	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_CSUM_OFFSET,
-					skb->csum_offset / 2) |
-			     MPNIC_TWD_FLAG_REQ_CSO);
+					skb->csum_offset / 2));
 
-	u64_stats_update_begin(&ring->stats.syncp);
-	u64_stats_inc(&ring->stats.twq.csum_partial);
-	u64_stats_update_end(&ring->stats.syncp);
+	if (skb_is_gso(skb)) {
+		if (mpnic_tx_lso(ring, skb, meta))
+			return true;
+	} else {
+		*meta |= cpu_to_le64(MPNIC_TWD_FLAG_REQ_CSO);
+
+		u64_stats_update_begin(&ring->stats.syncp);
+		u64_stats_inc(&ring->stats.twq.csum_partial);
+		u64_stats_update_end(&ring->stats.syncp);
+	}
 
 	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_L2_HLEN,
 					skb_mac_header_len(skb) / 2) |
-			     FIELD_PREP(MPNIC_TWD_L3_IHLEN, hdrs.i3len / 2));
+			     FIELD_PREP(MPNIC_TWD_L3_IHLEN, hdrs.i3len / 2) |
+			     FIELD_PREP(MPNIC_TWD_L3_TYPE, hdrs.l3_type) |
+			     FIELD_PREP(MPNIC_TWD_L4_TYPE, hdrs.l4_type));
+
+	return false;
 }
 
 #define MPNIC_MIN_FRAME_LEN	60
@@ -261,9 +316,11 @@ static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
 	*meta = cpu_to_le64(MPNIC_TWD_FLAG_DEST_MAC);
 
 	MPNIC_XMIT_CB(skb)->bytecount = skb->len;
+	MPNIC_XMIT_CB(skb)->gso_segs = 1;
 	MPNIC_XMIT_CB(skb)->desc_count = 0;
 
-	mpnic_tx_offloads(ring, skb, meta);
+	if (mpnic_tx_offloads(ring, skb, meta))
+		goto err_free;
 
 	if (mpnic_tx_map(ring, skb, meta))
 		goto err_free;
@@ -312,6 +369,10 @@ netdev_features_t mpnic_features_check(struct sk_buff *skb,
 	    l2len + i3len + sizeof(struct tcphdr) + MAX_TCP_OPTION_SPACE > 256)
 		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
 
+	if (skb_is_gso(skb) &&
+	    !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size))
+		return features & ~NETIF_F_GSO_MASK;
+
 	return features;
 }
 
@@ -357,7 +418,7 @@ static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
 		}
 
 		total_bytes += MPNIC_XMIT_CB(skb)->bytecount;
-		total_packets++;
+		total_packets += MPNIC_XMIT_CB(skb)->gso_segs;
 
 		napi_consume_skb(skb, napi_budget);
 	}
@@ -811,6 +872,8 @@ static void mpnic_aggregate_ring_twq_counters(struct mpnic_base_stats *base,
 {
 	base->tx.dropped += u64_stats_read(&twq->stats.twq.dropped);
 	base->tx.csum_partial += u64_stats_read(&twq->stats.twq.csum_partial);
+	base->tx.hw_gso += u64_stats_read(&twq->stats.twq.hw_gso);
+	base->tx.hw_gso_wire += u64_stats_read(&twq->stats.twq.hw_gso_wire);
 	base->tx.stop += u64_stats_read(&twq->stats.twq.stop);
 }
 
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 714f09f4160e..70f321ac4368 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -90,6 +90,8 @@ struct mpnic_queue_stats {
 		struct {
 			u64_stats_t dropped;
 			u64_stats_t csum_partial;
+			u64_stats_t hw_gso;
+			u64_stats_t hw_gso_wire;
 			u64_stats_t stop;
 		} twq;
 		struct {

-- 
2.52.0

