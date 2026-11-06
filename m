Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964639;
	b=iqsfGPhqykjUS8mEbNCkjfoWQSnmyA2m58ClKhlmYnEP9Tm+vWljdP42GAjmbEjtTejH
	 L7UC1JzSqZVXM92UBz3saKlidugOEPJWz9v0NqJ41pVwbZw1D9JpfP4IJD0PCydfSJu9T
	 A4f5WJPrViKOV160/BQfaYT+U3MYtyXPhMzaNE460Smdvf6NUNn4maQEbLzGwu2aI0UJ+
	 XjTg6f9MsvMXXCDMeEjkwA5dAtO8L6NiZEu/vSoq89PT95AnIj+6TLmaLebo0vLu19vvQ
	 ryd5G6EW/ly5OU3Q3oM9MgtwGHXQmBzmO5j31skenzf1hvyRtjJUmHzoMfcV6OYW7ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=TKghWzau878d+P/3ACxwFCi2OTeMRAfi/WpTSl8a68c=;
	b=nckIpbqVFgLae+lochkMFBAVy6PmfjxppYv/nMgaqItcxy2eSqFW17cHIy5nFJN66LBg
	 yaldbHjwJElRTxa7WIEQPvD6Em3bRPbPDeIzALJbRAhE/s9zqm1yELzEoySSODdA9Kz73
	 fr1GeaOxFSsCq4g0otc4A0iRRfR5jrflhoM2yoq9ITbU0qs3pNMC9i5p2hJVgkhk3hBWb
	 5PmWTzqTa4FgQ7ugk8fpke+wpAWF3Nj9AF0NKEJTR/BohHUI3Go0t+N7zPyWowOg5gKll
	 HdyZWb+MWN+jF8VxxW7t4myCWFIQpiGlb4k7cqlfaspaoWC3nYtMFXimEdKf2i52KXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cn4xkMTt;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDAF606D803
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 11:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EDAF606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cn4xkMTt
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0d63f60bcso5583907b3.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 03:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964638; x=1794569438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKghWzau878d+P/3ACxwFCi2OTeMRAfi/WpTSl8a68c=;
        b=cn4xkMTtVGWAfQQu1ylH8slNz4eaRFMrXtFIQfBp8HAUI3Rd5bbWJ21DOT8zgT6S6w
         Aadr2PBtBwwAaexojDStXMWFIf2ZawjcOFLQkjuVOAUUM0HZ8HLh5Vrd4a5OyqgCAg+i
         XwCHHIlaGJzL2IcVE/oOyid6ed2IadfVryMHuNLiPBvhr8YZiX/czi6qpdDhe1Oaof0X
         JQU9ozv5JD5y8PHHrRsf1W6vQIi9DtoE+VnqjOg9Ma7zWtEouhQbnwezTZpQpgqeQkvp
         /Jfvc1Lt1/UxVsFsHsaG9Lsqgi5A8mA2fze59n+MyNHH2oJgJoARCQZ02v3adZ6zTWdc
         ch5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964638; x=1794569438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TKghWzau878d+P/3ACxwFCi2OTeMRAfi/WpTSl8a68c=;
        b=e+aj8+Ba2/r0sRtNoVAFL6CcrZrndNlZQqLBthEweEtSneHvL20Qp4USgrARM/QOU3
         6QsealoEDaPV+sPupXMhMMissBIHjLNqXNIqu3gTiJe0y84pITdJnSoLcHeB2Wackjk3
         OojIf+3XNXPb7qgOnLe7CyAzTBPujIa8HgV8yZfZDB3JpxOKbuUX4OSUH1mrAPaCw99o
         EoASgeHo7mAOU8Y0zqxxgke1PWnE6M6+fF+yhfi7T+nfEnJ58W1KUcYv/f4HLUe89GfE
         Kc6OcnoH8JBEZIFMh12QM6qQeRKPw5AMoHQ3t3VvPN2xlbnYcYKcYXWMWgI5FTarq0Sl
         7N1g==
X-Gm-Message-State: APuU4Z+AVvBquWXIkiQzVnAJuNtyqStx18VEGJn5PwrAiqBWR+CSf0pd
	UUSrWJiWbc/8a1GiFYe/vdezEt1zRI9fgabtAE8NK63QLUCeJwfg94xh
X-Gm-Gg: AYBFou3qbO58JxkTboOP+wnoQhVBOrsA4BHmJJjCIP6i+N/5TC3E4Jw5IIqX2hqSt7b
	+Wfdn94gVH4//Qv7xwiP0CkH3ErVF1iZBk2uV82NLOrE4g0/VCibu9AFnIAj/hnvyxESSdCnul7
	qQ7GHeG/OImvD+07+OK4O8bs48M4TQ8kH7eX1OYH6TePZE0GBrxKHq8/KJdgWSqYyJYqkUZ+XbM
	a/rqxdtNHnDV07SllcjWMvpP7zJkGV7fKBgNggG7IthQ29Fkq2QxSac17wUWeLObZS/17fh+Nx0
	vHakdyfa5GJbW5m9N1fUzA5Lv1oG9zmYg0EYlG1BtxgqMTsgSA9LI+inoz9x6M0Y73CokFxWTAq
	+bUUFRkSfYwAG0f5IKXBAe39IXayLpoDVIq3ju+tSW1FSDPi8snRdNcB6UNVroKEBAyhsaKvADt
	FkV1RYsyMOJjr/7jC1d8QEJyuBzNQzL9a1hI48ZcUyU9//QSkR20MuOxXNLwEONiQl8CGOvynWq
	RunkbpqIxbkXapdLxsCSciBA6/FySy2smJVlti6+JlLKeA3ADf5+IzfEWX55OpfeGt5yTsRBpuA
	GIprPBPp78FgPmOmxPQNj1S5W3U=
X-Received: by 2002:a05:690c:9c0a:b0:8b0:d438:a024 with SMTP id 00721157ae682-8b341966129mr11571477b3.37.1793964638115;
        Fri, 06 Nov 2026 03:30:38 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:44::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f8880d2sm16574347b3.42.2026.11.06.03.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:30:37 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 06 Nov 2026 03:30:06 -0800
Subject: [PATCH net-next 2/6] eth: mpnic: Rx checksum offload
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
Message-Id: <20261106-mpnic-lso-v1-2-e943ff1493e4@gmail.com>
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

The device reports two Rx completion fields to the driver related to
checksums: l2_csum and l4_csum_unnecessary. l2_csum is the ones'
complement sum of the frame starting from the end of the ethernet
header. l4_csum_unnecessary means the device validated the l4 checksum of
the packet. This is only supported for tcp or udp in
ipv4/ipv6/4-in-6/6-in-6.

Report checksum none/complete/unnecessary counts via netdev qstats API.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  2 ++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 14 ++++++++++-
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  3 +++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 34 ++++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  3 +++
 5 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index 62304be203e6..1c86f114ab0c 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -60,6 +60,8 @@ enum {
 #define MPNIC_RCD_AL_PAGE_FIN		DESC_BIT(53)
 
 /* Metadata Completion Descriptors */
+#define MPNIC_RCD_META_L2_CSUM			DESC_GENMASK(47, 32)
+#define MPNIC_RCD_META_L4_CSUM_UNNECESSARY	DESC_BIT(52)
 #define MPNIC_RCD_META_ERR_MAC_EOP		DESC_BIT(53)
 #define MPNIC_RCD_META_ERR_TRUNCATED_FRAME	DESC_BIT(54)
 #define MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK	\
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index 3de5abc20f9a..91b70fe8483c 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -167,10 +167,12 @@ static void mpnic_get_queue_stats_rx(struct net_device *dev, int idx,
 {
 	struct mpnic_net *mpn = netdev_priv(dev);
 	struct mpnic_ring *rxr = mpn->rx[idx];
+	u64 csum_unnecessary, csum_complete;
 	u64 bytes, packets, alloc_failed;
 	struct mpnic_queue_stats *stats;
 	struct mpnic_q_triad *qt;
 	unsigned int start;
+	u64 csum_none;
 
 	if (!rxr)
 		return;
@@ -181,6 +183,9 @@ static void mpnic_get_queue_stats_rx(struct net_device *dev, int idx,
 		bytes = u64_stats_read(&stats->rcq.bytes);
 		packets = u64_stats_read(&stats->rcq.packets);
 		alloc_failed = u64_stats_read(&stats->rcq.alloc_failed);
+		csum_complete = u64_stats_read(&stats->rcq.csum_complete);
+		csum_unnecessary = u64_stats_read(&stats->rcq.csum_unnecessary);
+		csum_none = u64_stats_read(&stats->rcq.csum_none);
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 	qt = container_of(rxr, struct mpnic_q_triad, cmpl);
@@ -190,6 +195,9 @@ static void mpnic_get_queue_stats_rx(struct net_device *dev, int idx,
 	rx->bytes = bytes;
 	rx->packets = packets;
 	rx->alloc_fail = alloc_failed;
+	rx->csum_complete = csum_complete;
+	rx->csum_unnecessary = csum_unnecessary;
+	rx->csum_none = csum_none;
 }
 
 static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
@@ -248,6 +256,9 @@ static void mpnic_get_base_stats(struct net_device *dev,
 	rx->bytes = base->rx.bytes;
 	rx->packets = base->rx.packets;
 	rx->alloc_fail = base->rx.alloc_failed;
+	rx->csum_complete = base->rx.csum_complete;
+	rx->csum_unnecessary = base->rx.csum_unnecessary;
+	rx->csum_none = base->rx.csum_none;
 }
 
 static const struct netdev_stat_ops mpnic_stat_ops = {
@@ -310,7 +321,8 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 
 	netdev->features |=
 		NETIF_F_SG |
-		NETIF_F_HW_CSUM;
+		NETIF_F_HW_CSUM |
+		NETIF_F_RXCSUM;
 
 	netdev->hw_features |= netdev->features;
 	netdev->vlan_features |= netdev->features;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
index 94f7a3355c5c..76ec9811e79e 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
@@ -26,6 +26,9 @@ struct mpnic_base_stats {
 		u64 dropped;
 		u64 alloc_failed;
 		u64 errors;
+		u64 csum_complete;
+		u64 csum_unnecessary;
+		u64 csum_none;
 	} rx;
 
 	unsigned int num_tx_queues;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index edb087b12a1e..680625810ec0 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -655,9 +655,34 @@ static void mpnic_put_pkt_buff(struct mpnic_pkt_ctxt *ctxt, bool napi)
 	page_pool_put_full_page(page->pp, page, napi);
 }
 
+static void mpnic_rx_csum(u64 rcd, struct sk_buff *skb,
+			  unsigned int *csum_complete,
+			  unsigned int *csum_unnecessary,
+			  unsigned int *csum_none)
+{
+	skb_checksum_none_assert(skb);
+
+	if (!(skb->dev->features & NETIF_F_RXCSUM)) {
+		(*csum_none)++;
+		return;
+	}
+
+	if (FIELD_GET(MPNIC_RCD_META_L4_CSUM_UNNECESSARY, rcd)) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		(*csum_unnecessary)++;
+	} else {
+		u16 csum = FIELD_GET(MPNIC_RCD_META_L2_CSUM, rcd);
+
+		skb->ip_summed = CHECKSUM_COMPLETE;
+		skb->csum = (__force __wsum)csum;
+		(*csum_complete)++;
+	}
+}
+
 static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 			   struct mpnic_q_triad *qt, int budget)
 {
+	unsigned int csum_complete = 0, csum_unnecessary = 0, csum_none = 0;
 	unsigned int packets = 0, bytes = 0, dropped = 0, errors = 0;
 	struct mpnic_ring *rcq = &qt->cmpl;
 	struct mpnic_rcq_state *state;
@@ -700,6 +725,8 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 			}
 
 			if (likely(skb)) {
+				mpnic_rx_csum(rcd, skb, &csum_complete,
+					      &csum_unnecessary, &csum_none);
 				napi_gro_receive(&nv->napi, skb);
 			} else {
 				mpnic_put_pkt_buff(&state->pkt, true);
@@ -732,6 +759,9 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 	u64_stats_add(&rcq->stats.rcq.dropped, dropped);
 	u64_stats_add(&rcq->stats.rcq.alloc_failed, alloc_failed);
 	u64_stats_add(&rcq->stats.rcq.errors, errors);
+	u64_stats_add(&rcq->stats.rcq.csum_complete, csum_complete);
+	u64_stats_add(&rcq->stats.rcq.csum_unnecessary, csum_unnecessary);
+	u64_stats_add(&rcq->stats.rcq.csum_none, csum_none);
 	u64_stats_update_end(&rcq->stats.syncp);
 
 	/* Allocate buffers, force dma_wmb(), and then start writing tails */
@@ -806,6 +836,10 @@ static void mpnic_aggregate_ring_rcq_counters(struct mpnic_base_stats *base,
 	base->rx.dropped += u64_stats_read(&rcq->stats.rcq.dropped);
 	base->rx.alloc_failed += u64_stats_read(&rcq->stats.rcq.alloc_failed);
 	base->rx.errors += u64_stats_read(&rcq->stats.rcq.errors);
+	base->rx.csum_complete += u64_stats_read(&rcq->stats.rcq.csum_complete);
+	base->rx.csum_unnecessary +=
+		u64_stats_read(&rcq->stats.rcq.csum_unnecessary);
+	base->rx.csum_none += u64_stats_read(&rcq->stats.rcq.csum_none);
 }
 
 static struct mpnic_base_stats *mpnic_base_stats_prepare(struct mpnic_net *mpn)
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index a6dff9dc32d6..714f09f4160e 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -103,6 +103,9 @@ struct mpnic_queue_stats {
 			u64_stats_t dropped;
 			u64_stats_t alloc_failed;
 			u64_stats_t errors;
+			u64_stats_t csum_complete;
+			u64_stats_t csum_unnecessary;
+			u64_stats_t csum_none;
 		} rcq;
 		struct {
 			u64_stats_t alloc_failed;

-- 
2.52.0

