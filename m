Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348413;
	b=JY7mdT8kArwUd4+dOkCAv+WxQTYswCKVAjELI51eMtxSfliCGgGa8pOZ/767bhXCVetn
	 ShR806IpA6MWh/LihT64cSakQ/FNaoBdsNbICA8j3NHcGN0/Xl7xccSvYAm8jB+kJ9h+K
	 JBddeI8THkcsnTB9vzVsu+bekeVrJQ9laNx/WMfGTFijYOCwVCLiyTxthEVS61oY+2STj
	 kmhsK5ENFybF7R7TBO5hspIS4urK9/Wcf5VCzh1dZzVoDwyzo64YjvsE6dL6EgYPCqq+J
	 7TCaIx1PQaT/7fyOhrTHHgCj8rZCRWdtddHM+UpI9i/nXpw5dA5Q7YW4DCleQqil6Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=fmbuOZzD+BaFyRyYGcDZqWrVRMkVzZsldzoQsSJcGGs=;
	b=W4Gzc5xFmCKU2+3cJeMHKlXglNHHS64/AqBXkjjOA8lKXls+9JgsZYuXF1+5dfM9oK1E
	 jVtO1u1u+aygVK6QdPqtMJ+hHIHSDFfewjrT3+VokRGMMzxXkblLgWbHApDu39QdjPt3L
	 OL4dPQGlvSI6fn8mXec99NSTxLQLujnmzLqbNlxog8I+6wd4PxnxRFblSIcg1WvSmJxko
	 awaGlQutDqcZbXYDftdUKVsKvTagc+n+gBWW/ZF+Qil/P04yy9Nb+gJMo3P9UWpQnqBBs
	 P9EQQqlUJwLulviZO0YUmYIZDnXhUcit7pr67FzN2LeOWkA1mpspjQ1ky5Mf7kcr+bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pLY5ZFQx;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09660A2627
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C09660A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pLY5ZFQx
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b336de3d38so20273727b3.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794348411; x=1794953211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fmbuOZzD+BaFyRyYGcDZqWrVRMkVzZsldzoQsSJcGGs=;
        b=pLY5ZFQxAx/pw+HzLwLrocU8KSStJAFB/CVSpHSzbR5Bg76SKnEkbSTA5lmr66XwJF
         EpLR3bdsuL/w3h903Lyg/IyZKZCgKWc9AZEh8PmtGVg19HbJA4kZdj4IAI/5RB7GjBGh
         +MyyN7tlxTd3t+pcDhZX3lF4sD1t5ltXT+QoxHZ4OWhf2xMVNj0YpJvLfrxam5qebqQf
         SRYbbpwokwJ5g1AIY++i1CoO2vgL62Gn12kRYFJ0y/9zlqhrSSwJYU6kHsImbKVX/ZVy
         aFUe7KCSQ2SGkTMFVgHf8H6AQsZ+F/Dxt7Bu2oygyYrNSqu4NhDmUDcMu9WrudwcSCXN
         LFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348411; x=1794953211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fmbuOZzD+BaFyRyYGcDZqWrVRMkVzZsldzoQsSJcGGs=;
        b=D+spvJlfzV/x6VLAZFF9uB44X/5CaK84V7QjDsN+dzcj+srJbXALqD0rnKtBtZgYop
         b9bpSuYOTrFE/Bo6knFcLR3KGILkf2hFgYbqa9ptcYAiBOJNjmS3lBgkxhNb1biBdJsW
         8btpN72shysNf8Zc93Ak6iCPXcE0cQ5UBO2B5NJ6GEFmYOFuWXZnp25MzucE/KMpTau+
         Z2ZwNBk9SWDFQcMDk3l6VU0ouolyacBWtkaUrwDHrcuuAyyvJYM3KB3o7cQAQ+IjZ6oC
         e511m5PDwUpLw6pyoD1AIY34zTQXa2p6NbVacbseNgi9YvFMF96GSEBV9jG/3dBW5CGl
         frzQ==
X-Gm-Message-State: APuU4Z8lgdouWLeu2n6E/Qa8+6yS6X4VG64aXXZQ0h6Lqy2RqxPcI+Z0
	BdL4GIHMKDK87I4xEfFv9+eIgMXzrHFr0TBF43EklT79oOT0TyjhHsBZYkA3mOQq
X-Gm-Gg: AYBFou2HbIEkKEOZ6pPmOZ70k4UXwcS0tsl87OtfldHVTgHVJmdr7b11e7KyRBxnuBE
	SsG35s3YfkO9CjS4iOm2NdoR6JTVbSTXueUK8uWz3HP2T7A1B/5/3q8tmoKzv0DKvp0M1k1miSk
	tlysQYkUXgN1+t8w6Mdtj50MK0c0RgvCF2Bpcy9mdJlbj+6cWX/rVvEwIlqRStT+w7eEFX+Fb+P
	Og0s491BEj7vdAplPAkQU8r8WvAd0LRkP/+GVsiQ27kQOiwX0ztxUq/rug21kEWgHqq2VxtBLsE
	kMdiSY7h7yp2KGyok+aNAGhAfloZG04VM04tNPdXqqaEJofwJZmpcOtEzp1hrY3yEsLFZ2mLlYK
	IMsbBPTmMWD83juLbzh+6GvqDLevt53rwTQNomXSq0n9/w7tix9yeLOvNkK4t94WTHt6L4HQ64h
	3N3bs+MlkH3SFs6oJ+N4Hn9RsnRvkCZY7V++ewVjaSlPTSZQGrD7HxP5AjUCrsAxh6VSvL8oX+R
	XGaVYiJ8M4FIJtzXyLw3F3sW+iUK4nWGa6pNFd162IM4qOkz7jrlhYbReA24Lhg5tZu7CjED2TM
	mAlKhaiKw4/tUYBVpNcIi0WesQ==
X-Received: by 2002:a05:690c:dc6:b0:8b0:a8cf:f442 with SMTP id 00721157ae682-8b3a81bf5fbmr3984607b3.64.1794348411377;
        Tue, 10 Nov 2026 14:06:51 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39341d660sm29758877b3.31.2026.11.10.14.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:06:50 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 10 Nov 2026 14:06:36 -0800
Subject: [PATCH net-next v2 3/6] eth: mpnic: TCP segmentation offload
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
Message-Id: <20261110-mpnic-lso-v2-3-ccd37b051d08@gmail.com>
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

Support segmentation of non-encapsulated tcp4/tcp6 packets. When doing
segmentation the device expects the l4 checksum to be seeded with 0
length.

IPv4 header and TCP checksums that compute to zero are sent as 0 rather
than 0xffff when the HW segments packets. IPv4 IDs are incrementing
starting from the value that is in the skb's IPv4 header.

Count gso wire packets and report via the netdev qstats API.

Completions are counted in wire packets, but dropped TSO skbs are still
counted once per super packet, matching the core's per skb tx_dropped
accounting that gets summed into the same counter.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v2:
- count discarded skbs rather than segments in twq.dropped, matching
  the xmit error path and the core's tx_dropped
- report only hw_gso_wire_packets; drop the super-packet counter
---
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    | 27 ++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c   | 11 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 14 ++--
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  1 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 88 ++++++++++++++++++++++----
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  1 +
 6 files changed, 125 insertions(+), 17 deletions(-)

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
index 35173f8999cb..bde327ad3154 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -207,9 +207,9 @@ static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	struct mpnic_ring *txr = mpn->tx[idx];
 	struct mpnic_queue_stats *stats;
 	u64 bytes, packets, stop, wake;
+	u64 csum_partial, hw_gso_wire;
 	struct mpnic_q_triad *qt;
 	unsigned int start;
-	u64 csum_partial;
 
 	if (!txr)
 		return;
@@ -228,12 +228,14 @@ static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	do {
 		start = u64_stats_fetch_begin(&stats->syncp);
 		csum_partial = u64_stats_read(&stats->twq.csum_partial);
+		hw_gso_wire = u64_stats_read(&stats->twq.hw_gso_wire);
 		stop = u64_stats_read(&stats->twq.stop);
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 	tx->bytes = bytes;
 	tx->packets = packets;
-	tx->needs_csum = csum_partial;
+	tx->needs_csum = csum_partial + hw_gso_wire;
+	tx->hw_gso_wire_packets = hw_gso_wire;
 	tx->stop = stop;
 	tx->wake = wake;
 }
@@ -249,7 +251,8 @@ static void mpnic_get_base_stats(struct net_device *dev,
 
 	tx->bytes = base->tx.bytes;
 	tx->packets = base->tx.packets;
-	tx->needs_csum = base->tx.csum_partial;
+	tx->needs_csum = base->tx.csum_partial + base->tx.hw_gso_wire;
+	tx->hw_gso_wire_packets = base->tx.hw_gso_wire;
 	tx->stop = base->tx.stop;
 	tx->wake = base->tx.wake;
 
@@ -322,7 +325,10 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
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
index 76ec9811e79e..697b3ebb74b9 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
@@ -17,6 +17,7 @@ struct mpnic_base_stats {
 		u64 bytes;
 		u64 dropped;
 		u64 csum_partial;
+		u64 hw_gso_wire;
 		u64 stop;
 		u64 wake;
 	} tx;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index a35ce8998409..b78f8599bbe8 100644
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
@@ -215,30 +218,81 @@ mpnic_tx_map(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 
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
@@ -261,9 +315,11 @@ static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
 	*meta = cpu_to_le64(MPNIC_TWD_FLAG_DEST_MAC);
 
 	MPNIC_XMIT_CB(skb)->bytecount = skb->len;
+	MPNIC_XMIT_CB(skb)->gso_segs = 1;
 	MPNIC_XMIT_CB(skb)->desc_count = 0;
 
-	mpnic_tx_offloads(ring, skb, meta);
+	if (mpnic_tx_offloads(ring, skb, meta))
+		goto err_free;
 
 	if (mpnic_tx_map(ring, skb, meta))
 		goto err_free;
@@ -312,6 +368,10 @@ netdev_features_t mpnic_features_check(struct sk_buff *skb,
 	    l2len + i3len + sizeof(struct tcphdr) + MAX_TCP_OPTION_SPACE > 256)
 		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
 
+	if (skb_is_gso(skb) &&
+	    !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size))
+		return features & ~NETIF_F_GSO_MASK;
+
 	return features;
 }
 
@@ -319,7 +379,7 @@ static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
 			     struct mpnic_q_triad *qt, bool discard,
 			     unsigned int hw_head)
 {
-	u64 total_bytes = 0, total_packets = 0;
+	u64 total_bytes = 0, total_packets = 0, total_skbs = 0;
 	struct mpnic_ring *ring = &qt->sub0;
 	struct mpnic_ring *cmpl = &qt->cmpl;
 	unsigned int head = ring->head;
@@ -357,7 +417,8 @@ static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
 		}
 
 		total_bytes += MPNIC_XMIT_CB(skb)->bytecount;
-		total_packets++;
+		total_packets += MPNIC_XMIT_CB(skb)->gso_segs;
+		total_skbs++;
 
 		napi_consume_skb(skb, napi_budget);
 	}
@@ -370,7 +431,7 @@ static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
 	if (discard) {
 		local_bh_disable();
 		u64_stats_update_begin(&ring->stats.syncp);
-		u64_stats_add(&ring->stats.twq.dropped, total_packets);
+		u64_stats_add(&ring->stats.twq.dropped, total_skbs);
 		u64_stats_update_end(&ring->stats.syncp);
 		local_bh_enable();
 		return;
@@ -811,6 +872,7 @@ static void mpnic_aggregate_ring_twq_counters(struct mpnic_base_stats *base,
 {
 	base->tx.dropped += u64_stats_read(&twq->stats.twq.dropped);
 	base->tx.csum_partial += u64_stats_read(&twq->stats.twq.csum_partial);
+	base->tx.hw_gso_wire += u64_stats_read(&twq->stats.twq.hw_gso_wire);
 	base->tx.stop += u64_stats_read(&twq->stats.twq.stop);
 }
 
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 714f09f4160e..0d732ac4dde9 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -90,6 +90,7 @@ struct mpnic_queue_stats {
 		struct {
 			u64_stats_t dropped;
 			u64_stats_t csum_partial;
+			u64_stats_t hw_gso_wire;
 			u64_stats_t stop;
 		} twq;
 		struct {

-- 
2.52.0

