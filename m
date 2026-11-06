Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964637;
	b=4NL8y4f+q0k9LAT1ynFGFn2cBjWgkpP1ATWPzZF2fqY+id51Qm81CHcRlACL01ZZE0F5
	 7vFIMf/R6fdnHowmFM89ZnQtc7gDYpeGDJN9XkaG/xDonYLcJcqv8ujEm7M9CxwLPUKF6
	 Pwpz1GGDYu+nVuBLhZFWMiceB49dY7kEuolb97GV3oa0rIGR5fn2lXuf8TuctsogA4110
	 KIhPRNTAskKIlrdK6Bd7CwZUmyH85+UDlue0ydMgBNVL20VRTn5e9NDVHy7Ps1Dnc8f8q
	 FmsCNlG7jQE9uukQkwhLN1gU1uEed/gmJUXd+1yUK5ySDjovkPNBx11LUsyyzxvFxRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=RC9Pe+eO6mtOtCV0fI2oluTBYnJ6OIMUcQL8LFPX5s8=;
	b=R4afPleOocW4uOI4BaygSzSS+UZZ+4TvUlFAOOjVhnIZGI1XYMqmxihhQpxTqy6pk/EZ
	 LOwBCwTRfebjznMqCiJia8PT6aJVGiXJRIssufpxSvgBqqTZe0a1tosSsr2477jxKUW8d
	 qvZjhy3+6FX2MNnDRszdodJ8n58fFJh6FIf4MqgG7IxhrOwzMkReCTt8OYOqNZO+Rk9F+
	 b3oIUXfjiBUMSqm6mgzg070zxr+S2LfKtX2WzUpSAAULKphda8C4lbpGZF8C1Dd0FqEcw
	 9lwP25P+OtUMwWsBI10K/M7x5N63rL/zUigh9wsnFdbD8trYxlEosFiFV0tcG1ZxSLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TQZSdGLi;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211876082BF3
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 11:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 211876082BF3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TQZSdGLi
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b32b2e691aso14605447b3.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 03:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964636; x=1794569436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RC9Pe+eO6mtOtCV0fI2oluTBYnJ6OIMUcQL8LFPX5s8=;
        b=TQZSdGLiBAcuueHUoK3qvdFdK5+CBL0c9IhBUxRhU0wG4QpVpiJAWFlTuxHc61fn3S
         pyhe3C3Q0ohZM7rC7kQAPyT92N6Iz8UE7dc/2sMUW+89cIrQ719Qcu7X931uLANA7Q9O
         VyCS043wSNLJmFrMtcc5EknJ0asFS8x+Cmb+eJYl2MMrFI5ZMuwp8FC/xRdSu6ODhB6s
         nIOxcGfcOrKgv1WyTbEhzprwaxbM55l7IS4QequTsIEGJq77NzPGFM0gjsFU/nqqCNU8
         dvbuKmrHeGeuySarhCfatIiXZUbumITu+7VFeYtdXx9aQmQgsKFYKl5l6tn/9+X/hM5j
         IWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964636; x=1794569436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RC9Pe+eO6mtOtCV0fI2oluTBYnJ6OIMUcQL8LFPX5s8=;
        b=SkvQZ9jW+dcWauP1WpR+nwKvXGyrO3tn5Qiq/WaW2Z3r06Y+8Ha7Hkk2nPs4K9/t19
         teXtEL/5YKnIYgt2CvuqHC8K6GKpUnGTUaeVZ1zjw47SC8GEJ5TlfiVImezYw9G7N3L+
         mMRx+vKYOJwzA9hY/Iw/rqdmnGUh/taaBvDXupXxHYxUrK6KSWaBDrbHnQvSTc1Xsn0i
         H72jG89PWZBFJJvfSKv8x0IwP7PSTJ1su+/iuqbT59i22/pYGtoMtW+lJ8vyrdWNs5HY
         wga8ztBPEIPno7Bt77oAMMdyQauqa0jQckAlDMPeuucwNmi31H5HzOtrv6Y1W3y3ylLY
         agJQ==
X-Gm-Message-State: APuU4Z/M1gtX1Znk4POHwPpIWnE+E6bMtmnZJ2a48qHN5O/nrZpNB4cX
	t2wLoE8xDe635mbf2FsXlGdGtsTpiwpZFSqyX6VdynwoDXVoAG2+uXaG
X-Gm-Gg: AYBFou173bQak6pQbuEtJ7sJdGR00cZ6+IHVZhJo9Dx5Uqo4HgM/8anQr14CU9J05CA
	g9M9JLRLn5cuzIv7X/8CATQTXQsKtiOlu9JM7LAjufGGs+PkF4NGZlNpNMl/1pr3PtulSGb7tE8
	1A5/PkiS4YqWKYswfOe3hfwEAiWZGaAgfINF3kbbClHGNAjwS38xE+8Ja6kcuIM7K5wjm/iuxeL
	dJ42oIkuTZpUyAyVg3Rw8yNfNg1SRk3C9syqlB7aGJENkcYwrSZpQlXm6TQay1rLnyR4YJaGcFy
	SqHbhTMcVxEH/XrRwihjgPLAUw+aQzacWYBhEZvNBIiq2hmesvsNkJDpKCrRxuUpCkht39XmYSn
	bWEICAZdYC9i9nW9b9ZA0DM0SmWa/wiU0yywItSVwzAr+F6tS94JI3fh4mRBBWl4ETPQ0mX6rM+
	lE7UxBvHygn/MHnAHobJ+z0+jNvweZliRfxElqVAYnalFbvrnVLacMOgoBJNpGXUBiP5MlOSIJq
	l133mmJiRvAekeAM3wBKLs1IKJY24UNHSrzKKh3kDok1/KoShvAo1FDMsT9UIg5kekaDL5uGcAo
	OaZHX9tT4fv8Q+boO/8225TypA==
X-Received: by 2002:a05:690c:c4f1:b0:8b3:b01:74c3 with SMTP id 00721157ae682-8b328e5ed18mr34273117b3.23.1793964635988;
        Fri, 06 Nov 2026 03:30:35 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f7721aesm16680357b3.14.2026.11.06.03.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:30:35 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 06 Nov 2026 03:30:05 -0800
Subject: [PATCH net-next 1/6] eth: mpnic: Tx checksum offload
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
Message-Id: <20261106-mpnic-lso-v1-1-e943ff1493e4@gmail.com>
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

Support generic Tx checksum offload per NETIF_F_HW_CSUM.

Add mpnic_features_check() to ensure that skb metadata can be mapped
into Tx descriptor fields. The headers and offsets used have units of
2B. The device also requires any headers modified to be in the first
256B of the packet.

Zero checksums are inverted by HW, matching the behavior of
skb_checksum_help().

Count CSO frames and report them via netdev qstats API.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  6 +++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c   |  2 +
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 10 ++++-
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  1 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 60 ++++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  4 ++
 6 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index d6ab9df58168..62304be203e6 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -13,6 +13,10 @@
 #define DESC_GENMASK(h, l)	GENMASK_ULL(h, l)
 
 /* Transmit Work Descriptor Format */
+#define MPNIC_TWD_L2_HLEN		DESC_GENMASK(5, 0)
+#define MPNIC_TWD_L3_IHLEN		DESC_GENMASK(23, 16)
+#define MPNIC_TWD_CSUM_OFFSET		DESC_GENMASK(27, 24)
+#define MPNIC_TWD_FLAG_REQ_CSO		DESC_BIT(36)
 #define MPNIC_TWD_FLAG_REQ_COMPLETION	DESC_BIT(37)
 #define MPNIC_TWD_FLAG_DEST_MAC		DESC_BIT(43)
 #define MPNIC_TWD_TYPE			DESC_GENMASK(47, 46)
@@ -305,6 +309,8 @@ enum {
 
 /* NIC_CORE_TOF */
 #define MPNIC_TOF_TCAM_DEST_REMAP	0x7e3022		/* 0x1f8c088 */
+#define MPNIC_TOF_MODE			0x7e302e		/* 0x1f8c0b8 */
+#define MPNIC_TOF_MODE_L4_ZERO_CSUM		CSR_BIT(4)
 
 /* PEMO_WRAPPER */
 #define MPNIC_OB_ATTR_RO			CSR_BIT(1)
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_init.c b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
index ace4124158fb..71d13bec7ec4 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_init.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
@@ -298,6 +298,8 @@ static void mpnic_txglb_init(struct mpnic_dev *mpd)
 	 * programmed with its addresses.
 	 */
 	mpnic_wr64(mpd, MPNIC_TOF_TCAM_DEST_REMAP, 0);
+	mpnic_wr64(mpd, MPNIC_TOF_MODE,
+		   FIELD_PREP(MPNIC_TOF_MODE_L4_ZERO_CSUM, 0));
 
 	mpnic_wr64(mpd, MPNIC_TCM_MEM_INIT_REQ, MPNIC_MEM_INIT_TCM_VAL);
 	mpnic_wr64(mpd, MPNIC_TDE_MEM_INIT_REQ, MPNIC_MEM_INIT_TDE_VAL);
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index 7fdf57f70151..3de5abc20f9a 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -144,6 +144,7 @@ static const struct net_device_ops mpnic_netdev_ops = {
 	.ndo_stop		= mpnic_stop,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_start_xmit		= mpnic_xmit_frame,
+	.ndo_features_check	= mpnic_features_check,
 	.ndo_get_stats64	= mpnic_get_stats64,
 };
 
@@ -200,6 +201,7 @@ static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	u64 bytes, packets, stop, wake;
 	struct mpnic_q_triad *qt;
 	unsigned int start;
+	u64 csum_partial;
 
 	if (!txr)
 		return;
@@ -217,11 +219,13 @@ static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	stats = &txr->stats;
 	do {
 		start = u64_stats_fetch_begin(&stats->syncp);
+		csum_partial = u64_stats_read(&stats->twq.csum_partial);
 		stop = u64_stats_read(&stats->twq.stop);
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 	tx->bytes = bytes;
 	tx->packets = packets;
+	tx->needs_csum = csum_partial;
 	tx->stop = stop;
 	tx->wake = wake;
 }
@@ -237,6 +241,7 @@ static void mpnic_get_base_stats(struct net_device *dev,
 
 	tx->bytes = base->tx.bytes;
 	tx->packets = base->tx.packets;
+	tx->needs_csum = base->tx.csum_partial;
 	tx->stop = base->tx.stop;
 	tx->wake = base->tx.wake;
 
@@ -303,7 +308,10 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 	mpn->num_rx_queues = queues;
 	mpn->num_napi = queues;
 
-	netdev->features |= NETIF_F_SG;
+	netdev->features |=
+		NETIF_F_SG |
+		NETIF_F_HW_CSUM;
+
 	netdev->hw_features |= netdev->features;
 	netdev->vlan_features |= netdev->features;
 
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
index 6711766ebc3c..94f7a3355c5c 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
@@ -16,6 +16,7 @@ struct mpnic_base_stats {
 		u64 packets;
 		u64 bytes;
 		u64 dropped;
+		u64 csum_partial;
 		u64 stop;
 		u64 wake;
 	} tx;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 93abdec44642..edb087b12a1e 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <net/netdev_lock.h>
 #include <net/page_pool/helpers.h>
+#include <net/tcp.h>
 
 #include "mpnic.h"
 #include "mpnic_netdev.h"
@@ -18,6 +19,10 @@ struct mpnic_xmit_cb {
 	u8 desc_count;
 };
 
+struct mpnic_tx_hdrs {
+	unsigned int i3len;
+};
+
 #define MPNIC_XMIT_CB(__skb) ((struct mpnic_xmit_cb *)((__skb)->cb))
 #define MPNIC_TWD_TYPE_MASK(_type) \
 	cpu_to_le64(FIELD_PREP(MPNIC_TWD_TYPE, MPNIC_TWD_TYPE_##_type))
@@ -208,6 +213,34 @@ mpnic_tx_map(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 	return true;
 }
 
+static void mpnic_tx_fill_hdrs(struct sk_buff *skb, struct mpnic_tx_hdrs *hdrs)
+{
+	hdrs->i3len = skb_checksum_start(skb) - skb_network_header(skb);
+}
+
+static void
+mpnic_tx_offloads(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
+{
+	struct mpnic_tx_hdrs hdrs = {};
+
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return;
+
+	mpnic_tx_fill_hdrs(skb, &hdrs);
+
+	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_CSUM_OFFSET,
+					skb->csum_offset / 2) |
+			     MPNIC_TWD_FLAG_REQ_CSO);
+
+	u64_stats_update_begin(&ring->stats.syncp);
+	u64_stats_inc(&ring->stats.twq.csum_partial);
+	u64_stats_update_end(&ring->stats.syncp);
+
+	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_L2_HLEN,
+					skb_mac_header_len(skb) / 2) |
+			     FIELD_PREP(MPNIC_TWD_L3_IHLEN, hdrs.i3len / 2));
+}
+
 #define MPNIC_MIN_FRAME_LEN	60
 
 static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
@@ -230,6 +263,8 @@ static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
 	MPNIC_XMIT_CB(skb)->bytecount = skb->len;
 	MPNIC_XMIT_CB(skb)->desc_count = 0;
 
+	mpnic_tx_offloads(ring, skb, meta);
+
 	if (mpnic_tx_map(ring, skb, meta))
 		goto err_free;
 
@@ -256,6 +291,30 @@ netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 	return mpnic_xmit_frame_ring(skb, mpn->tx[skb_get_queue_mapping(skb)]);
 }
 
+netdev_features_t mpnic_features_check(struct sk_buff *skb,
+				       struct net_device *dev,
+				       netdev_features_t features)
+{
+	unsigned int l2len, i3len;
+
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return features;
+
+	l2len = skb_mac_header_len(skb);
+	if (skb_vlan_tag_present(skb))
+		l2len += VLAN_HLEN;
+	i3len = skb_checksum_start(skb) - skb_network_header(skb);
+
+	if ((l2len | i3len | skb->csum_offset) % 2 ||
+	    !FIELD_FIT(MPNIC_TWD_L2_HLEN, l2len / 2) ||
+	    !FIELD_FIT(MPNIC_TWD_L3_IHLEN, i3len / 2) ||
+	    !FIELD_FIT(MPNIC_TWD_CSUM_OFFSET, skb->csum_offset / 2) ||
+	    l2len + i3len + sizeof(struct tcphdr) + MAX_TCP_OPTION_SPACE > 256)
+		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+
+	return features;
+}
+
 static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
 			     struct mpnic_q_triad *qt, bool discard,
 			     unsigned int hw_head)
@@ -721,6 +780,7 @@ static void mpnic_aggregate_ring_twq_counters(struct mpnic_base_stats *base,
 					      struct mpnic_ring *twq)
 {
 	base->tx.dropped += u64_stats_read(&twq->stats.twq.dropped);
+	base->tx.csum_partial += u64_stats_read(&twq->stats.twq.csum_partial);
 	base->tx.stop += u64_stats_read(&twq->stats.twq.stop);
 }
 
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 52492e3f484f..a6dff9dc32d6 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -89,6 +89,7 @@ struct mpnic_queue_stats {
 	union {
 		struct {
 			u64_stats_t dropped;
+			u64_stats_t csum_partial;
 			u64_stats_t stop;
 		} twq;
 		struct {
@@ -168,6 +169,9 @@ struct mpnic_napi_vector {
 };
 
 netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, struct net_device *dev);
+netdev_features_t mpnic_features_check(struct sk_buff *skb,
+				       struct net_device *dev,
+				       netdev_features_t features);
 int mpnic_alloc_napi_vectors(struct mpnic_net *mpn);
 void mpnic_free_napi_vectors(struct mpnic_net *mpn);
 void mpnic_stats_attach_rings(struct mpnic_net *mpn);

-- 
2.52.0

