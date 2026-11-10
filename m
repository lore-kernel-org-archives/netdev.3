Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348408;
	b=btIgzHw7AjCwkXLwZPUqTH4hC295CWdENHtF4MuBza/g/kYpgzQD9YfWiC3B6zBAuSRK
	 4xNzEK2IQ4bB+mE+42cdXOWvetq2S0wRlqcAJLi7uRNStCu9M9xcG+wmk2oUSuqWLqZQU
	 Tn01q5SVVIhO+DkUOE0zPv03n2KwYJL6ha/JcJuIcBfjnPhgybpsJrkXpzxq3ayWzVcZ+
	 gBlWi3hjbUeNRHSRmUUh+Y/gzqO3qKOEQSSpTPDeWSGuXLAO3Lp6Zt+eocWb/FzhS8AhG
	 XNdUsmSEQ3bEuiQVD01c+/2AT5K07U4PGVKZwiFNCM/Ww+ai8GRjLFxC8GAkQNym2YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=q+x0UCrqDyrT1Jj1zb5uFSfr382adKOKvNJsBuNz0ss=;
	b=XLbE1TXaUGRDobajBB7sUA1x1bsv3g0QY8wYvN5k1B4MU+MW5jotRXxLO8M1pqf2w1dS
	 IozEUi3RGoffsnwonmny4KgOX3Rf85dHCilWzNj9pDMeu0Pyd2QwbsKe4WSr9Err5UgKH
	 bqiDCgYiG8cu1dGUvns7VpYzcj+uClXGHGcr/sZ7HDc3YbaJQHkNcix4K0+IvS7Arv5FG
	 eQdDVZsuwE8sABHdcm9/qdTvQBXeLem7txfL1JFqUUFTytsyQygaKZCfXu1he9ClJcD18
	 zjD4750d2GPVMH/RgTAZJJKZvgOOMrXprO0dbgKf2Wh9UmP3gUtpd3kabaneT0hJe9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uUf/Ysrw";
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8960A2601
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B8960A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uUf/Ysrw
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67be9601f31so2532340d50.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794348407; x=1794953207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+x0UCrqDyrT1Jj1zb5uFSfr382adKOKvNJsBuNz0ss=;
        b=uUf/YsrwbHZ4Z4bz3qsSb8IBvpo819V7JYyzAGUJ12Ck7XfUHzJ0hkJ86smW4QeOZZ
         Z9A/4BBslGyinBaX5rw/VFthrXzjMMGUL1fhuJfWH+P4Xhx5om1m3nLa+b4v6c0dY0KY
         cfa6MvpsbyRX7vsOr/2usgorTvXY8giwhfl+K8+iaZeaC7hHuraQfNAK6srIQwpR7w3p
         36WDWqJv2gU/cZngm+smlxH0qlsFxUZPdOX4qGDX0ut7bVbhVu9v7RKtywQeKmJKkyPc
         WRyiSEB//8+mlJZFXgW2nICcSld3DIFAcBpWggwW/ENNR7RsiBiqrTE67dGGhU0pMDJz
         SNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348407; x=1794953207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+x0UCrqDyrT1Jj1zb5uFSfr382adKOKvNJsBuNz0ss=;
        b=gHdV4wPQ7306R8mimcQ0QFYHrckkLGHqzhBIdltBOZq7bzVBi7QgtwEaOzQ/nJ76ov
         Oci1DlGztSLN5MSbgGQe7rETPnbzGPeBNX6qbhissrSoiDqOAX0tbWgggS3fupiUbGCV
         Rg3X4dAFHGDONd3e1OyZyVQl3wGTU2yf57HHYK6AzVts8LYelygyz5+JVzCWHSTHB3Wo
         o9wOfY/3ylckmnL/9KNhAlVpHSN4W+DmGqb0lXIL4dZOmDDaclUhg6QQV+zGqeWlFapf
         GFkILVQoxAP51HbgSUVtVkrktw+aZRLh3HBdZA35v+zPmAj5SNNA74TJJCVHpgnHN9X2
         1rdg==
X-Gm-Message-State: APuU4Z/+fkmKHdrCGDyLXnshyXQY2EUnPCqur09uLWrwbHJ52IO8YBib
	HX3YC3avjD9Oh9uoV6BYnLHw2urfaX5C19QXH5kIH1PeUQYn9cdAvNxy
X-Gm-Gg: AYBFou0h6s9IfHCfjBOy/b3L/nm5z55nZ2oCRye52LZZsOXVXE0Lt2oYUf0LDiwtQCk
	NBh8Fq1O0I1KGeWvGTVp9IwZ3H84icD5uku7iD9fVyzyvPA4LakjdT0BWF0KJhN6j3a+1rjZbhW
	j7Iq5VaHBRy+vzjfIj4YKrvheJsjpgqrujFQGRT+gfsXlzkegiy8HTG5kcPq4FYdAF7mmZehjyV
	dxvElhdrY+iHhBM4tZ2EQy9h+1Ta7aGVE4BN+Tw3HgGo3z520XTu1Ynj73hgvW4icEUthQhqr9D
	etDpKGeFzoV5vxpL9FM6Ge+Y85QuuO4aMjn+6u3QkRFouwcpVUXUplH3aXQIOSXtyePUthMU3/R
	fo80fuC8smlGEUcbW0Xq4eFnJ2Caqjv25VionVszj+1BhDtsJlfAOCvWnuyHZLQdEGfN78vcSVk
	N481TOZ5Xk5lf4xpL65pkpwlrV1UC6QomhQdQxRj3Aoex3AHAZv7uCavIVvQpTAsbJLy/SyPhsX
	H+BPGF+DilwfTryWwU4aoaCcHaoyxUsn/trMcW9/newqwuxzk9qdEelh8VtcgnCYB7JYyhGlgRR
	14zT+duU4mzj9RseYzmhmFGWmk8=
X-Received: by 2002:a53:ad4f:0:b0:67a:8c43:753 with SMTP id 956f58d0204a3-67c6802e579mr269100d50.97.1794348406850;
        Tue, 10 Nov 2026 14:06:46 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c6f24sm2938112d50.12.2026.11.10.14.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:06:46 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 10 Nov 2026 14:06:34 -0800
Subject: [PATCH net-next v2 1/6] eth: mpnic: Tx checksum offload
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
Message-Id: <20261110-mpnic-lso-v2-1-ccd37b051d08@gmail.com>
References: <20261110-mpnic-lso-v2-0-ccd37b051d08@gmail.com>
In-Reply-To: <20261110-mpnic-lso-v2-0-ccd37b051d08@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

Support generic Tx checksum offload per NETIF_F_HW_CSUM. Propagate all
netdev features to hw_enc_features, so CSO also works on encapsulated
skbs.

Add mpnic_features_check() to ensure that skb metadata can be mapped
into Tx descriptor fields. The headers and offsets used have units of
2B. The device also requires any headers modified to be in the first
256B of the packet.

Zero checksums are inverted by HW, matching the behavior of
skb_checksum_help().

Count CSO frames and report them via netdev qstats API.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v2:
- use skb_network_offset() for the L2 header length in
  mpnic_features_check(), since the mac header is not yet set when
  called from the IP GSO slow path
- also enable Tx checksum offload for encapsulated packets via
  hw_enc_features (moved from the IPv4 and IPv6 in IPv6 patch)
---
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  6 +++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c   |  2 +
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 11 ++++-
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  1 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 60 ++++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  4 ++
 6 files changed, 83 insertions(+), 1 deletion(-)

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
index 7fdf57f70151..d386672738fc 100644
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
 
@@ -303,9 +308,13 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 	mpn->num_rx_queues = queues;
 	mpn->num_napi = queues;
 
-	netdev->features |= NETIF_F_SG;
+	netdev->features |=
+		NETIF_F_SG |
+		NETIF_F_HW_CSUM;
+
 	netdev->hw_features |= netdev->features;
 	netdev->vlan_features |= netdev->features;
+	netdev->hw_enc_features |= netdev->features;
 
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = MPNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
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
index 93abdec44642..65de6d999d54 100644
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
+	l2len = skb_network_offset(skb);
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

