Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B55867F9
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988277; cv=none; b=EiJDw/Oxo1Cle2TzPcCQc6reA3JwVdT9vecgm+4bcb+vNZ7IuS075tjjIqO8PwWnyCOQvwOCFCs4Q1Ll6lsTbz/T6VZL4uJ19pVSeB6jXeszdnnzvOv/p2CTlc7A5m7zbjSmq3FhSjD0X1yv/vB0NdLPE/LVOOYpcQiqcDJIFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988277; c=relaxed/simple;
	bh=UKnihgiAuPQXPPJioE6SvhhYBfglRLZXJw8M3IQMHtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBWTr/Nd0h3EG1SlzYvqnIjeSH884uAoLCEmuqwNnsAegN84CJ7rWe7cD4yTxwHHjC5DJk2gIjDozdm8L1K5T6SsLLFdJHO+XKLDYWDaYyLfYHAjeIUzM6w3Rl1pzw2v/64bXi1909Bg0aOeRDSOaXeeuMiveLQg60z+J2tuxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv75ZmMe; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv75ZmMe"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae716867so897636eaf.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988274; x=1789593074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=py4YEh9hWqdGRZUiPURWIvgQvv5wyof4ZUI4d1FrZlM=;
        b=bv75ZmMegg1U+9WCCI7CV70SliRH2re8ogb3r4ZNZwt8jAz/5VjUv4YV2LYPn/MmEG
         v+Wb6N1tgAX1M16XkSrnDwYirWNDRVblAKlvwM0KDCfuVM5wQJW3kDRU7PdXIkGmBB9G
         r0566KXqFyo3SAFqEPdnZGZLMJoqojpqWi0zVcBFRHiioKfMHPDiFt4xiTwEsTvHeaDT
         HB9EE6RxT+Kln5BgxhjUo3gG+sEYFx9/c9HQ+wV73d3m56hsqC+jHXsR6EvYnLfxCAfG
         8oR90UV1MpUeQGZGhMt4rvCqfsoStkKHUD1JiHO98T3Ep1GzkeXh4d65lxMT0BSYKQDs
         3C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988274; x=1789593074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=py4YEh9hWqdGRZUiPURWIvgQvv5wyof4ZUI4d1FrZlM=;
        b=bP5nYyZ6LR1F6MWkDJdRmDQpU8y/+jU+WW6K5Cy3F0/a4WHikh+A9yBRR7JXYc1kxg
         sCaI/7sAWHhfBi9UY/mkjv1WJVywG2X155/MWGsUAdcB7F9/jgIXKL/pxMYLuymiwodr
         jFoua+xUzsowWlUw/DN+2iZuM0FPoKmQ3UOHxWJd2wxFhi+ValNZWXv3eWscWRHhcFnD
         t62b7iSgjRw9ewd+/I81nCRuXZIRT4DeFSRxBw0Vu8NXmJ1KeRhJTKdHs2gL90ko42RN
         F09GHpxG6fhkgNzzYS1Opb3aokTh5x5zbQPe2ZRNs+mHhNBRZQCJYO3hcCTE22goZnak
         mZ9w==
X-Gm-Message-State: AFuF++myePUDuvjfadMVnfmLo2MIkOnPJ9smOkZsMpargftp6pn85XoC
	WCTFinwAFWA+z9bfCZtbHbntcI/hryMcMWwpLLSLKF16AWER/ONqYYNiZ1sFBw==
X-Gm-Gg: AYBFou3Ap8dlatpkzqR8LWBZEzQbrYuvTuSjLZi2U5+Ku5ahyDgmMAQ9x0VrL7QGthH
	qNc/QEvBmHjaA8lxBrcDY6bo2FUicBZcNsuF2Mh+2Th3ukxUp1EVoOk83eNzWpFI4+Emro2XkSp
	IJJGPzaX4H7hQY7+to8D9WjkUaSZdj3XfxRi0alyGUsLsOWPWztnS8sFT32C+z77+7kkgXkTnH2
	/CjfRhy9ipYksmF3qZ3E7oN1c0n9XME2urdtjQSwkixlyXwbd8wbUD52Ogo57sCTsRnmpW3PBMV
	/dk825BCLNoYjPWlKGfeZ9qJO1EZ26WtcJJfeEy6v/OM4wKlDhmYU5zTLMyFKA2IVlVj5plGYGM
	272nMNd1X6gXgNlwl4CfMzbLwZq72WdHCQFNxvwl8s/xs/ZlmJFksuhh/7i1LNyXUaL4UUcQd1H
	FSH5rT/J5dI1uRZDgb1CbQ8rdi/OasNYb8NzUiFuItYD56Vb4Ui/peXSpLs1GHY4CpZ8r3
X-Received: by 2002:a05:6820:169f:b0:6a1:77ce:1b09 with SMTP id 006d021491bc7-6bdc949e1f0mr8369021eaf.6.1788988274282;
        Wed, 09 Sep 2026 14:11:14 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:53::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47950af018csm9566414fac.15.2026.09.09.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:11:13 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	kernel-team@meta.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	mike.marciniszyn@gmail.com,
	lee@trager.us,
	jacob.e.keller@intel.com,
	leitao@debian.org,
	vadim.fedorenko@linux.dev,
	daskald@meta.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next] eth: fbnic: Make Rx completion coalescing configurable
Date: Wed,  9 Sep 2026 14:11:11 -0700
Message-ID: <20260909211111.1795726-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <hmohsin@meta.com>

The Rx completion queue writeback coalescing window controls how long
the queue manager may defer writing completions to host memory.

Expose this window through the standard rx-cqe-nsecs ethtool
parameter. Preserve the existing 2000 ns default and accept values
from 1000 ns through the device maximum (~109 us).

Hardware expresses COAL_WAIT in 600 MHz core clock cycles, or 1.667 ns
per cycle. Programming rounds the configured value to the nearest clock
cycle, resulting in an error of less than 1 ns. Retain the requested
value for get_coalesce() because this error is below the one-nanosecond
resolution of the ethtool interface.

Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h         |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 15 ++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |  9 +--------
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    | 17 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h    | 10 ++++++++++
 6 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index d0715695c43e..0e7ae1def5bf 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -57,6 +57,7 @@ struct fbnic_dev {
 	u64 dsn;
 	u32 mps;
 	u32 readrq;
+	u32 rx_cqe_nsecs;
 	u8 relaxed_ord;
 
 	/* Local copy of the devices TCAM */
@@ -250,6 +251,7 @@ int fbnic_csr_regs_len(struct fbnic_dev *fbd);
 
 void fbnic_config_txrx_usecs(struct fbnic_napi_vector *nv, u32 arm);
 void fbnic_config_rx_frames(struct fbnic_napi_vector *nv);
+void fbnic_config_rx_cqe_nsecs(struct fbnic_dev *fbd);
 
 enum fbnic_boards {
 	fbnic_board_asic
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index 546e1c12d287..0b653c4c20a7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -10,6 +10,7 @@
 #include "fbnic.h"
 #include "fbnic_fw.h"
 #include "fbnic_tlv.h"
+#include "fbnic_txrx.h"
 
 #define FBNIC_SN_STR_LEN	24
 
@@ -648,6 +649,7 @@ struct fbnic_dev *fbnic_devlink_alloc(struct pci_dev *pdev)
 	fbd->mps = pcie_get_mps(pdev);
 	fbd->readrq = pcie_get_readrq(pdev);
 	fbd->relaxed_ord = pcie_relaxed_ordering_enabled(pdev);
+	fbd->rx_cqe_nsecs = FBNIC_RX_CQE_NSECS_DEFAULT;
 
 	fbd->mac_addr_boundary = FBNIC_RPC_TCAM_MACDA_DEFAULT_BOUNDARY;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 0e47088ec44b..e84a97ca5452 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -246,6 +246,7 @@ static int fbnic_get_coalesce(struct net_device *netdev,
 	ec->tx_coalesce_usecs = fbn->tx_usecs;
 	ec->rx_coalesce_usecs = fbn->rx_usecs;
 	ec->rx_max_coalesced_frames = fbn->rx_max_frames;
+	kernel_coal->rx_cqe_nsecs = fbn->fbd->rx_cqe_nsecs;
 
 	return 0;
 }
@@ -256,6 +257,7 @@ static int fbnic_set_coalesce(struct net_device *netdev,
 			      struct netlink_ext_ack *extack)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
 
 	/* Verify against hardware limits */
 	if (ec->rx_coalesce_usecs > FIELD_MAX(FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT)) {
@@ -272,10 +274,20 @@ static int fbnic_set_coalesce(struct net_device *netdev,
 		NL_SET_ERR_MSG_MOD(extack, "rx_frames is above device max");
 		return -EINVAL;
 	}
+	if (kernel_coal->rx_cqe_nsecs < FBNIC_RX_CQE_NSECS_MIN ||
+	    kernel_coal->rx_cqe_nsecs > FBNIC_RX_CQE_NSECS_MAX) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "rx-cqe-nsecs must be between %u and %u",
+				       FBNIC_RX_CQE_NSECS_MIN,
+				       FBNIC_RX_CQE_NSECS_MAX);
+		return -EINVAL;
+	}
 
 	fbn->tx_usecs = ec->tx_coalesce_usecs;
 	fbn->rx_usecs = ec->rx_coalesce_usecs;
 	fbn->rx_max_frames = ec->rx_max_coalesced_frames;
+	fbd->rx_cqe_nsecs = kernel_coal->rx_cqe_nsecs;
+	fbnic_config_rx_cqe_nsecs(fbd);
 
 	if (netif_running(netdev)) {
 		int i;
@@ -2016,7 +2028,8 @@ static void fbnic_get_link_ext_stats(struct net_device *netdev,
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.cap_link_lanes_supported	= true,
 	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
-					  ETHTOOL_COALESCE_RX_MAX_FRAMES,
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES |
+					  ETHTOOL_COALESCE_RX_CQE_NSECS,
 	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 					  ETHTOOL_RING_USE_HDS_THRS,
 	.rxfh_max_num_contexts		= FBNIC_RPC_RSS_TBL_COUNT,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 53b7a938b4c2..16271c717a5a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -125,14 +125,7 @@ static void fbnic_mac_init_qm(struct fbnic_dev *fbd)
 	     FIELD_PREP(FBNIC_QM_TCQ_CTL0_COAL_WAIT,
 			clock_freq / 12500));
 
-	/* We will have the interrupt threshold timer tick once every
-	 * 1 usec and coalesce writes for up to 2 usecs.
-	 */
-	wr32(fbd, FBNIC_QM_RCQ_CTL0,
-	     FIELD_PREP(FBNIC_QM_RCQ_CTL0_TICK_CYCLES,
-			clock_freq / 1000000) |
-	     FIELD_PREP(FBNIC_QM_RCQ_CTL0_COAL_WAIT,
-			clock_freq / 500000));
+	fbnic_config_rx_cqe_nsecs(fbd);
 
 	/* Configure spacer control to 64 beats. */
 	wr32(fbd, FBNIC_FAB_AXI4_AR_SPACER_2_CFG,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 401f8b8ae1ca..4cf87b39829d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -6,6 +6,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/iopoll.h>
 #include <linux/pci.h>
+#include <linux/time64.h>
 #include <net/netdev_queues.h>
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
@@ -2643,6 +2644,22 @@ static void fbnic_config_rim_threshold(struct fbnic_ring *rcq, u16 nv_idx, u32 r
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_THRESHOLD, threshold);
 }
 
+void fbnic_config_rx_cqe_nsecs(struct fbnic_dev *fbd)
+{
+	u32 coal_wait;
+
+	coal_wait = DIV_ROUND_CLOSEST_ULL((u64)fbd->rx_cqe_nsecs *
+					  FBNIC_CLOCK_FREQ, NSEC_PER_SEC);
+
+	/* TICK_CYCLES controls the interrupt threshold timer. COAL_WAIT is
+	 * independent and measured in core clock cycles.
+	 */
+	wr32(fbd, FBNIC_QM_RCQ_CTL0,
+	     FIELD_PREP(FBNIC_QM_RCQ_CTL0_TICK_CYCLES,
+			FBNIC_CLOCK_FREQ / USEC_PER_SEC) |
+	     FIELD_PREP(FBNIC_QM_RCQ_CTL0_COAL_WAIT, coal_wait));
+}
+
 void fbnic_config_txrx_usecs(struct fbnic_napi_vector *nv, u32 arm)
 {
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index e03c9d2c38dc..98bb73765587 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -4,12 +4,16 @@
 #ifndef _FBNIC_TXRX_H_
 #define _FBNIC_TXRX_H_
 
+#include <linux/bitfield.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/u64_stats_sync.h>
 #include <net/xdp.h>
 
+#include "fbnic_csr.h"
+
 struct fbnic_net;
 
 /* Guarantee we have space needed for storing the buffer
@@ -49,6 +53,12 @@ struct fbnic_net;
 #define FBNIC_RX_USECS_DEFAULT		30
 #define FBNIC_RX_FRAMES_DEFAULT		0
 
+#define FBNIC_RX_CQE_NSECS_MIN		1000
+#define FBNIC_RX_CQE_NSECS_DEFAULT	2000
+#define FBNIC_RX_CQE_NSECS_MAX \
+	((u32)(((u64)FIELD_MAX(FBNIC_QM_RCQ_CTL0_COAL_WAIT) * NSEC_PER_SEC) / \
+	       FBNIC_CLOCK_FREQ))
+
 #define FBNIC_RX_TROOM \
 	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
 #define FBNIC_RX_HROOM_PAD		128
-- 
2.53.0-Meta

