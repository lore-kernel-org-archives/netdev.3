Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF8362137
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626705; cv=none; b=eAosgWCV5prs3I2lwauRjEnPEL4uDlxh3+3a8o0dnQGi5sGUz3KwAQknam9g+HCptjAkGAovuAiWbnNWhSZ1waoxIIPCgFstUG/yPJqZzCv2PkoGdxF5dHhBYfXjmQoj5sHmdZnsacYhzViU3+Bi3nfdc+Rl0aJ1bLZ7c22J9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626705; c=relaxed/simple;
	bh=iKTSP+z8uHFhHPa1hDiywwuXNGo8/AketX4jF7ZnNeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dpkr7NIZhFPaPVzC56Oj3w5lzJ107DBIWF8/MCpn/gAinNTFyZKdWWsFrT9HB7DQn9Rgik/yNDZDbbyeOiz77dRDdS2m55VMqiU8/PQ2S63z6mgMP5xTrYYJj8WXQ3uDR82vMTPUuiM4ISvaJO4qD9m5vAmjpdrnmUh4f9DV70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S8QsD3BD; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S8QsD3BD"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so655258a12.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626703; x=1791231503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P8TaPtS1LOY2hnKOlC49/CctDbqTJ8s0rwZaj0FcvtE=;
        b=v++ngMGG1tG4cL2fbImSTOgyhz/hqWtt3LkW9JuQqaovnIiokhqQMEPBKudQjd2BgS
         SDZK78ur8NKIe8eTYnxI4Nlugjeh2I+N6rEWHsxfsrBt5V5tBKGHSjZdhq/YZzvk6UGY
         BmjZoMo/TG5zN9sZKjHSbWgdbpsbPmLiX+2L4XhXd/rcGsX4ZSP6wJumGJ2sMehnXTas
         dQi61M54lVzqFY82Q6ki7Iy1ga70EQK11EO5jIHPn2TFr0jYhi+CbAU33W6IUMTNZiX+
         Y2tLvROEVU+mtx88s/5QxBvbcBlhYC7ot1To4CAbWqTggJoH/aS8XQwhOHXM3nIbsrUt
         bHcw==
X-Gm-Message-State: AFuF++kv13BQ4DIJXB5OS8V5D8VcujMpzgqxsMcPvjfPygBFJkrhBgTb
	9CkW5YHK+JXHGeh3bsHAx7RBoxyUG5dQlQW+Bj+a1OotFWHFCv4v/ZVGLbKOuaoTY8zObxpik3z
	oEl7XWvkObwmycbXThZkPKpVPjKHh6Qacyhwzj8Jgv8KzPCT0qywAdKG6vHEnLpXlLi5beIvu64
	2gx3I4dcJ7R2aLCc1SyatCeiUPflbt3Ag1HBniLfjfX5QavwAtrL7R1J9IE7qr1TmVx12bOiWVJ
	RSZHF1Eew==
X-Gm-Gg: AYBFou1mRC9lkrxYXHReWYf9/p6jgNNw42IiAOBYWM3khgLcSWROQDqH/JiC0pD7SMB
	iF+kr78nqX1s+jHCzz4uepCLgx7upAKsopctSbI9P7YZ2rHt+epvzAbl8zUoxrf1JfFTjWdmVGL
	ixikSUipQTBNAO414MWgEGE/vuWRva2x3MipXbWl0DiZUWNPXqSVJ7+1NmX2FU8DHittfq6AYW5
	4HRCdMYJ4cZAo5YxXD0Pn0fg9Smebt8qd/zy/wgAlJemQ08dmwdLcPubL+Dka4F1Y3oPjAATJNM
	+Yy2cF/2mvGhfZ7NvPAj+jV6d5/fg1I0vehv65Nfc4sk4BfiUmYXUq5rpU1gRW8b/PULKAz4K09
	fkXrnGOgWeASJBcpWEQFferULDG28Im3DGgkS6kiS95Ywk9RUJ/1YM4SXXLgFNqVAx98JQhUuFL
	oPchxAnUL/gUmc4SuZB8I+pmybbKq6bzJvRUWg
X-Received: by 2002:a05:6a20:d70b:b0:3dd:a196:69e2 with SMTP id adf61e73a8af0-3de26f2927emr9937035637.61.1790626702939;
        Mon, 28 Sep 2026 13:18:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc787795663sm6877533a12.8.2026.09.28.13.18.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 13:18:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so2264022eec.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790626701; x=1791231501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8TaPtS1LOY2hnKOlC49/CctDbqTJ8s0rwZaj0FcvtE=;
        b=S8QsD3BD0DnGWCdZTq5GQwtblLYe3h243w0NjtXl5YHHDkdn7msaoRbQ31Y8mUwFbl
         LsRDe3OnCIE6t31OYdBodVnLWFayhPW7E5kaOInQPjwhpk/Bu2BkdokyB6P3IkC5IeBK
         /LO0IisdxhKsJpxwFDX9D8Dp0/9zVGjotOLpA=
X-Received: by 2002:a05:7301:dd81:b0:341:4553:a529 with SMTP id 5a478bee46e88-34271d8d31emr10361599eec.20.1790626700933;
        Mon, 28 Sep 2026 13:18:20 -0700 (PDT)
X-Received: by 2002:a05:7301:dd81:b0:341:4553:a529 with SMTP id 5a478bee46e88-34271d8d31emr10361557eec.20.1790626700094;
        Mon, 28 Sep 2026 13:18:20 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm48779594eec.9.2026.09.28.13.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:18:19 -0700 (PDT)
From: justin.chen@broadcom.com
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net] net: bcmasp: fix lost TX wakeup race with lockless queue API
Date: Mon, 28 Sep 2026 13:18:16 -0700
Message-Id: <20260928201816.3935530-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Justin Chen <justin.chen@broadcom.com>

netif_stop_queue() in bcmasp_xmit() raced with netif_wake_queue() in
bcmasp_tx_poll(): a reclaim landing between the ring-full check and
the stop call left the queue stopped despite free descriptors,
hanging TX until timeout.

Switch to netif_txq_maybe_stop()/netif_txq_completed_wake() (the
lockless TX queue API, which also brings in BQL), replace
tx_spb_ring_full() with a live bcmasp_tx_avail() count.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Assisted-by: Claude:claude-sonnet-5
---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 68 +++++++++++--------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index f2176ef3a127..00e39a230676 100644
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
@@ -241,16 +239,18 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
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
+		netif_tx_stop_queue(txq);
 		if (net_ratelimit())
 			netdev_err(dev, "Tx Ring Full!\n");
 		return NETDEV_TX_BUSY;
@@ -333,15 +333,17 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -398,14 +400,16 @@ static void umac_enable_set(struct bcmasp_intf *intf, u32 mask,
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
@@ -423,6 +427,9 @@ static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)
 			u64_stats_inc(&stats->tx_packets);
 			u64_stats_add(&stats->tx_bytes, txcb->bytes_sent);
 			u64_stats_update_end(&stats->syncp);
+
+			bytes_compl += txcb->bytes_sent;
+			packets++;
 		}
 
 		desc = &intf->tx_spb_cpu[intf->tx_spb_clean_index];
@@ -433,33 +440,37 @@ static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)
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
 
@@ -847,6 +858,7 @@ static void bcmasp_init_tx(struct bcmasp_intf *intf)
 	intf->tx_spb_index = 0;
 	intf->tx_spb_clean_index = 0;
 	memset(intf->tx_cbs, 0, sizeof(struct bcmasp_tx_cb) * DESC_RING_COUNT);
+	netdev_tx_reset_queue(netdev_get_tx_queue(intf->ndev, 0));
 
 	/* Make sure channels are disabled */
 	tx_spb_ctrl_wl(intf, 0x0, TX_SPB_CTRL_ENABLE);
@@ -944,7 +956,7 @@ static void bcmasp_netif_deinit(struct net_device *dev, bool stop_phy)
 	} while (timeout-- > 0);
 	tx_spb_dma_wl(intf, 0x0, TX_SPB_DMA_FIFO_CTRL);
 
-	bcmasp_tx_reclaim(intf);
+	bcmasp_tx_reclaim(intf, NULL);
 
 	umac_enable_set(intf, UMC_CMD_TX_EN, 0);
 
-- 
2.34.1

