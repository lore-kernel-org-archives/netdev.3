Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2434C141
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714050; cv=none; b=TomcDHnu17b+m3u0xyz58TX07qjzF/Cu/f/SN4EBJh3VroZXXxPWp36wa4lb/1+47bw8e7lavl5HKBgl5YUW3s30hQvG3scvBZZM1us0envkGWZ+6VlUt/Og+Ayt0TroRP36R7U4/OvL9KHPknjCznsz8SL1ZkgQsUOOJnF9jp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714050; c=relaxed/simple;
	bh=De7eltRwalqiQrn7lBxC0mddwix6DUieUyY3KsO6L4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RuljZRg26sLMXr2V/0+OJtZ/HPOLQOoQgbz6VTNcPvMzXySPXHumt9iFIf4/woQYd+LBKXCSh54fO1RGqm7ynkjfo2iymK7lXadYzNOZwCdWb8jZhfCXviZy5jXkJqtz/ePdolGYtljNVMkaY5lqv9cY1JXwJ6gzC4yRc7DCUQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JjORaoXR; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JjORaoXR"
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-8ab395abf79so3912287b3.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790714048; x=1791318848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mpa0hpSv14UQyMwgqtztOn5RksbysXc/NSBWcCnzeNM=;
        b=JBrby3hJUfU0PhzTHvUFtDkTgmQEc/Ww7LYeHqPs2WZFk2MOIWe0SH25OGqqiWa4xG
         Vueq4tOxV5ueYPnwJI0xEWQ15R5L/AiXfoMcOY0iEKgp7vUQlFfiHKgdK+a15uyi+WLD
         HnxGZqlVbXWga78sJQCFLzhvO8xIwV4f4eGkRgJEfE4QGPJ/NbwfUMiKo4Umk5KfSMvJ
         bUwRjs2GmjUuya8zKa/249TDEqrW370a5sPCkxmhX11/KXPxfm3iA4t8jUnC2TYw1K9y
         F0tSndDCAMTwOcv6r0stIHWnAQ87/PCAJKfs7ajLSqF4qu4AmgnXb9HCutfwQrCBH2kB
         nFfA==
X-Gm-Message-State: AFq9FYKD9Mxy7EWP0tVgbNMuXFvTpZwkPlgZD/5zXz3ZQxTq6swlJ1VR
	sPPBaLgT7W5PNEOdZIjgu4vc8VwgaTIbEq8F3uSu+Q37iZJJjx2b9UFgdBV+W5VL4y9NXsMpsJw
	KgmKEqs8FdhgIrPzyA/oDK9rjpPZ7Bqj8u3Iks4ZMHGVe4SkrMW1B/ZbUvAssi+f/AgeMSoLdla
	ujUS2uMLrqaORCUagdXoCEFkHmwPUlOkK9h4ZjtCNqpPiV3X0lGDyFkOwc2NmMYWl7k72dyEDTL
	a89YWQaRw==
X-Gm-Gg: AYBFou3x3+SLXJTlsJgLXUY6EawauSnQevPOp48GtJ1JefDfA8fUIctK+otWne2VtIO
	tRXLMXLdrAPid5UcrBcnobXHwYSCRTzSFR742Qt9mPzw1P0Zi5zH+W6sBCcu4DYzLTe24C0+NM4
	e7kAm5MjiJrsJ7GfJLODIot5M2QKKotF9Kz+pALEy5Q4DF/Yj3iGcQZA6cRFkHUhplth34Q6pK1
	wYdwe6TJxD9W+DGYfV1Cycn0ONT+U9qGI1gU1aUWl+rzDCP1zCiAY+IPqSOyIH+09/0mp8n8qFD
	YK0QTcKE3Yxy6USGihg3FUjEH+Sbkn1gZoBiXqGnmM5dVbRt6dMAKSMZzUHSuwRl1cz2+25Hgd2
	0D+0WitO9wl+XEbdJi3ryxzt8DY/7vbuD73T5TrrQOOZsMxMID55E2vqIB/q2S5daY+DjowMhtJ
	M4GW2PDWJBSOxreNgFsuYwiJnOn4ganHB8JQ==
X-Received: by 2002:a05:690e:43d9:b0:671:471d:c3b8 with SMTP id 956f58d0204a3-676440493cdmr136038d50.17.1790714047860;
        Tue, 29 Sep 2026 13:34:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-675b2800376sm287897d50.7.2026.09.29.13.34.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2026 13:34:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1384427c3efso6805591c88.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790714046; x=1791318846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mpa0hpSv14UQyMwgqtztOn5RksbysXc/NSBWcCnzeNM=;
        b=JjORaoXRiSGSYg28YaBiBwdGQYHN3+X/tL1j/9aW8L+XvJIsz1yDkWebVJJxtC73+0
         AOFZcdB7m1Mv9+TGiSfbd3zt/fJhUiHEfXE/Ebn/Np+2b2sotZ/NedUZf55KukKtZ8IG
         ueW1EJ/FBIpB+qhtcTkeCUhzhDaQU3riAuCrc=
X-Received: by 2002:a05:7022:296:20b0:148:aef3:a2a7 with SMTP id a92af1059eb24-14c9f30f810mr342185c88.24.1790714046097;
        Tue, 29 Sep 2026 13:34:06 -0700 (PDT)
X-Received: by 2002:a05:7022:296:20b0:148:aef3:a2a7 with SMTP id a92af1059eb24-14c9f30f810mr342142c88.24.1790714045199;
        Tue, 29 Sep 2026 13:34:05 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c350c0a51sm1301315eec.2.2026.09.29.13.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 13:34:04 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	nb@tipi-net.de,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net v2] net: bcmasp: fix lost TX wakeup race with lockless queue API
Date: Tue, 29 Sep 2026 13:34:00 -0700
Message-Id: <20260929203400.1588868-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

netif_stop_queue() in bcmasp_xmit() raced with netif_wake_queue() in
bcmasp_tx_poll(): a reclaim landing between the ring-full check and
the stop call left the queue stopped despite free descriptors,
hanging TX until timeout.

Switch to netif_txq_maybe_stop()/netif_txq_completed_wake() (the
lockless TX queue API, which also brings in BQL), replace
tx_spb_ring_full() with a live bcmasp_tx_avail() count.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Assisted-by: Claude:claude-sonnet-5
---
v2
	- replaced netif_tx_stop_queue() with netif_txq_try_stop()

 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 69 +++++++++++--------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index f2176ef3a127..3369c45b49d5 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -15,11 +15,15 @@
 #include <linux/platform_device.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <net/netdev_queues.h>
 #include <net/page_pool/helpers.h>
 
 #include "bcmasp.h"
 #include "bcmasp_intf_defs.h"
 
+#define BCMASP_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
+#define BCMASP_TX_START_THRS	(2 * MAX_SKB_FRAGS)
+
 static int incr_ring(int index, int ring_count)
 {
 	index++;
@@ -143,19 +147,13 @@ static void bcmasp_clean_txcb(struct bcmasp_intf *intf, int index)
 	txcb->last = false;
 }
 
-static int tx_spb_ring_full(struct bcmasp_intf *intf, int cnt)
+static int bcmasp_tx_avail(struct bcmasp_intf *intf)
 {
-	int next_index, i;
-
-	/* Check if we have enough room for cnt descriptors */
-	next_index = intf->tx_spb_index;
-	for (i = 0; i < cnt; i++) {
-		next_index = incr_ring(next_index, DESC_RING_COUNT);
-		if (next_index == intf->tx_spb_clean_index)
-			return 1;
-	}
+	int used = (READ_ONCE(intf->tx_spb_index) -
+		    READ_ONCE(intf->tx_spb_clean_index) + DESC_RING_COUNT) %
+		   DESC_RING_COUNT;
 
-	return 0;
+	return DESC_RING_COUNT - used - 1;
 }
 
 static struct sk_buff *bcmasp_csum_offload(struct net_device *dev,
@@ -241,16 +239,19 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct bcmasp_tx_cb *txcb;
 	dma_addr_t mapping, valid;
 	struct bcmasp_desc *desc;
+	struct netdev_queue *txq;
 	bool csum_hw = false;
 	struct device *kdev;
 	skb_frag_t *frag;
 
 	kdev = &intf->parent->pdev->dev;
+	txq = netdev_get_tx_queue(dev, 0);
 
 	nr_frags = skb_shinfo(skb)->nr_frags;
 
-	if (tx_spb_ring_full(intf, nr_frags + 1)) {
-		netif_stop_queue(dev);
+	if (unlikely(bcmasp_tx_avail(intf) < nr_frags + 1)) {
+		netif_txq_try_stop(txq, bcmasp_tx_avail(intf),
+				   BCMASP_TX_START_THRS);
 		if (net_ratelimit())
 			netdev_err(dev, "Tx Ring Full!\n");
 		return NETDEV_TX_BUSY;
@@ -333,15 +334,17 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 	 */
 	wmb();
 
-	intf->tx_spb_index = spb_index;
+	WRITE_ONCE(intf->tx_spb_index, spb_index);
 	intf->tx_spb_dma_valid = valid;
 
+	netdev_tx_sent_queue(txq, total_bytes);
+
 	skb_tx_timestamp(skb);
 
 	tx_spb_dma_wq(intf, intf->tx_spb_dma_valid, TX_SPB_DMA_VALID);
 
-	if (tx_spb_ring_full(intf, MAX_SKB_FRAGS + 1))
-		netif_stop_queue(dev);
+	netif_txq_maybe_stop(txq, bcmasp_tx_avail(intf),
+			     BCMASP_TX_STOP_THRS, BCMASP_TX_START_THRS);
 
 	return NETDEV_TX_OK;
 }
@@ -398,14 +401,16 @@ static void umac_enable_set(struct bcmasp_intf *intf, u32 mask,
 		usleep_range(1000, 2000);
 }
 
-static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)
+static int bcmasp_tx_reclaim(struct bcmasp_intf *intf, unsigned int *bytes_out)
 {
 	struct bcmasp_intf_stats64 *stats = &intf->stats64;
 	struct device *kdev = &intf->parent->pdev->dev;
-	unsigned long read, released = 0;
+	unsigned int bytes_compl = 0;
 	struct bcmasp_tx_cb *txcb;
 	struct bcmasp_desc *desc;
+	unsigned long read;
 	dma_addr_t mapping;
+	int packets = 0;
 
 	read = tx_spb_dma_rq(intf, TX_SPB_DMA_READ);
 	while (intf->tx_spb_dma_read != read) {
@@ -423,6 +428,9 @@ static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)
 			u64_stats_inc(&stats->tx_packets);
 			u64_stats_add(&stats->tx_bytes, txcb->bytes_sent);
 			u64_stats_update_end(&stats->syncp);
+
+			bytes_compl += txcb->bytes_sent;
+			packets++;
 		}
 
 		desc = &intf->tx_spb_cpu[intf->tx_spb_clean_index];
@@ -433,33 +441,37 @@ static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)
 			  intf->tx_spb_clean_index);
 
 		bcmasp_clean_txcb(intf, intf->tx_spb_clean_index);
-		released++;
 
-		intf->tx_spb_clean_index = incr_ring(intf->tx_spb_clean_index,
-						     DESC_RING_COUNT);
+		WRITE_ONCE(intf->tx_spb_clean_index,
+			   incr_ring(intf->tx_spb_clean_index, DESC_RING_COUNT));
 		intf->tx_spb_dma_read = incr_first_byte(intf->tx_spb_dma_read,
 							intf->tx_spb_dma_addr,
 							DESC_RING_COUNT);
 	}
 
-	return released;
+	if (bytes_out)
+		*bytes_out = bytes_compl;
+
+	return packets;
 }
 
 static int bcmasp_tx_poll(struct napi_struct *napi, int budget)
 {
 	struct bcmasp_intf *intf =
 		container_of(napi, struct bcmasp_intf, tx_napi);
-	int released = 0;
+	struct netdev_queue *txq = netdev_get_tx_queue(intf->ndev, 0);
+	unsigned int bytes = 0;
+	int packets;
 
-	released = bcmasp_tx_reclaim(intf);
+	packets = bcmasp_tx_reclaim(intf, &bytes);
+
+	netif_txq_completed_wake(txq, packets, bytes,
+				 bcmasp_tx_avail(intf), BCMASP_TX_START_THRS);
 
 	napi_complete(&intf->tx_napi);
 
 	bcmasp_enable_tx_irq(intf, 1);
 
-	if (released)
-		netif_wake_queue(intf->ndev);
-
 	return 0;
 }
 
@@ -847,6 +859,7 @@ static void bcmasp_init_tx(struct bcmasp_intf *intf)
 	intf->tx_spb_index = 0;
 	intf->tx_spb_clean_index = 0;
 	memset(intf->tx_cbs, 0, sizeof(struct bcmasp_tx_cb) * DESC_RING_COUNT);
+	netdev_tx_reset_queue(netdev_get_tx_queue(intf->ndev, 0));
 
 	/* Make sure channels are disabled */
 	tx_spb_ctrl_wl(intf, 0x0, TX_SPB_CTRL_ENABLE);
@@ -944,7 +957,7 @@ static void bcmasp_netif_deinit(struct net_device *dev, bool stop_phy)
 	} while (timeout-- > 0);
 	tx_spb_dma_wl(intf, 0x0, TX_SPB_DMA_FIFO_CTRL);
 
-	bcmasp_tx_reclaim(intf);
+	bcmasp_tx_reclaim(intf, NULL);
 
 	umac_enable_set(intf, UMC_CMD_TX_EN, 0);
 
-- 
2.34.1

