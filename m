Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEBC346784
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296541; cv=none; b=N2Y2TZbJuLu2HpCz6JcIBEAwNUfNAiYfGkpjJkK1gsXCDUac+IJo6DZLN4GLK/6zjeP22uoIke/KJ9qHwWIK5HcdYSCJI98+jcwGZTM076HcxixiOt3OZaCyLlZf0IVeWkSXrf2nGp6MBsbmbyl7ckiGVtXEYwZwipa1hLel6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296541; c=relaxed/simple;
	bh=bzqNfi561s0BJ4LfBSLN2zd3ALNfbVtHk/fUDRsw0tE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJX4no4hh2qRreRbkWFuTz5NveHdt8lropGnaSUNFdmXQCfZUvh+djHKqmMBA4aMNE2w16Gt+z1UlAGH4MWBQleBdusUjbxaEeABkA9Pl+vyCTZPAbOVIMttvLpLA6CakwMBAVoTVF56QwKD8Wos5ydU4cXkypcEEOWrSMK0jiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikGcsDq1; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikGcsDq1"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6c8f6a53fabso1278060eaf.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790296538; x=1790901338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGBFSMzdJP6cPF9I9BzpE8J32MmjM8M7XG4nj9H+phQ=;
        b=ikGcsDq1EHdJhEDEtWcVsC4CTIWFD7tp4OMBsyQAdKCiwnHGdhe49p6GTG/gUNQNA5
         pMG6ygsgJz1Ju8BXIf1XkiXEQS25E/HKE0JdclLls6DdCkCfAdgfUDlsxDGeW5Lm2JIV
         dwG5J9OoL99ttLXHxCxO9nt1gJud5y42Yk7XIvFTpzFEZ87ctoJPIaHOCLaNIYFvFPYh
         qoJAS/a141BKvF6spd1nYly9HVBAEH4WTksLfNT7Mk0Yczg9DQ+hHtTx40KyHo7OdePG
         HD0DFr6XGdPJRADiU/K82pvW4IHbL1ejk1BUuGpNsH9kfbLiI5s+Jfg/4LFrCEQRWbkS
         XN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296538; x=1790901338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGBFSMzdJP6cPF9I9BzpE8J32MmjM8M7XG4nj9H+phQ=;
        b=ZD6TUh+eBNDSM0avC3gM/HuZ+WBpY0Bm2VrJmjh+xi1bcr2IYmIsB67jeztfu4/+++
         WjwzEagSULlrkoinJZrIcUdnDmojWtS4KzDPw/HKB2OCSZQ+biKJ2jzaFMwRxuM4E2Q4
         5ex8EQpY/geYq9jupp0gHu/uUo0rAm0It9a3mPXjl5BbVtYoQiokom4UhH7YeOrlBKCU
         BDb5hwCJ77Rrrlegm7T9uoECugQ1e5VgIUftY8aLd8t/vTO4IRrm21zHG3T3eablVMAO
         jEYWIvYZi0ItEh8x04yl4n72oQTaM7+aYut0GM3t7Q6bzlUIU9idjANt5vzBzhlfHU/I
         Jg8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxyZgkbYGfzXdjWccupC1GsPbsX7/0PyXuZ0RPZ+9BCZdJp0PcIQj77gxbbilKuN651pk7nrTs=@vger.kernel.org
X-Gm-Message-State: AFuF++nyPUdRxDGQJFfseAHM/NDX2evGrLM1gBJAaYlpkSgRrI1ObJvG
	GyZRVmaHTUHFEGnNteVyWBTH6yxaVgsAMFHmFfzWZXHawpBJ6fIM/bXlWsA0v8Lm
X-Gm-Gg: AYBFou0KbK3k6niGPUcDpkzYQwpqD/NwRSWZg3Y83XfwErIIiJclGWnxD1yRo+PF8Kh
	BmfWe56PAnUokqHJVNHs7YDGrbN9v1NXY9TXU0Ai+WiUiELaTZtfPHoC+15/+6Jp6YsVaCmuYmQ
	Ip0TwQYw6pF5KqJC0umG795JbgvM5SbdeICXmBkDhlRrYR1T+gNpH9E2Cqy7/GCH/r6NAXvYrcN
	x2ncOL46G0VI3X47c5ZfTU7Ny85xUtlMxvlxa1lCA5dazQTT57lFTepbgMtN/NJ5lARFUMBO5ar
	/p9hX7HauPWG/6fUXLFn+7I2kPYFw9RHWNqC9aAnnyfGTz1nz1YcV02hlk5yMmOIlaqSFaf0LcL
	TCqks972hcj9yhqbZTvXVkvgC3gNQZp0G3Wmx+6LMKXDpI8TOmsF7s8xoYm7ljbmcrObGADHHWO
	AHP27eVDdW4KkVlv7VKABrfYAp6tDgVydxFOXq4rIy5Cj54Qx0bZmF2kUAwS8BaGDeq0PEZcP1r
	i5g/l8=
X-Received: by 2002:a05:6820:c90:b0:6b5:ec2f:3571 with SMTP id 006d021491bc7-6d440df28cfmr3316317eaf.34.1790296537586;
        Thu, 24 Sep 2026 17:35:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493364b4711sm789985fac.16.2026.09.24.17.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:35:36 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 24 Sep 2026 17:35:17 -0700
Subject: [PATCH net-next v2 4/8] eth: mpnic: implement Tx queue allocation
 and cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-linux-mpnic-v2-4-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
In-Reply-To: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Queues come in triads of two work queues and one completion queue. The
Tx triad only uses the first work queue for now, the second one will be
used for the XDP ring later.

Add the ring structures, the per NAPI vector allocation of triads,
descriptor memory and interrupts, and the completion processing. The
completion queue does not report one entry per packet, it reports a
work queue head, so a single completion can release many packets.

Nothing enables the queues in hardware or submits anything to them yet,
that comes with the next two changes.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v2:
- add mpnic_nv_irq_trigger()
---
 drivers/net/ethernet/meta/mpnic/Makefile       |   1 +
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  23 ++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  26 ++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 495 +++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  80 ++++
 5 files changed, 625 insertions(+)

diff --git a/drivers/net/ethernet/meta/mpnic/Makefile b/drivers/net/ethernet/meta/mpnic/Makefile
index 3aa7c6a5ab5e..67d617f49a8a 100644
--- a/drivers/net/ethernet/meta/mpnic/Makefile
+++ b/drivers/net/ethernet/meta/mpnic/Makefile
@@ -11,4 +11,5 @@ mpnic-y := \
 	mpnic_init.o \
 	mpnic_irq.o \
 	mpnic_pci.o \
+	mpnic_txrx.o \
 # End of mpnic-y
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index 3ddd6acea085..adf81b5ef49c 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -15,6 +15,13 @@
 /* Transmit Work Descriptor Format */
 #define MPNIC_TWD_FLAG_REQ_COMPLETION	DESC_BIT(37)
 
+#define MPNIC_TWD_ADDR			DESC_GENMASK(45, 0)
+#define MPNIC_TWD_LEN			DESC_GENMASK(63, 48)
+
+/* Tx Completion Descriptor Format */
+#define MPNIC_TCD_TYPE0_HEAD0		DESC_GENMASK(15, 0)
+#define MPNIC_TCD_DONE			DESC_BIT(63)
+
 /* Common fields for all DESC_CFG CSRs */
 #define MPNIC_DESC_CFG_NUM_DESCS	CSR_GENMASK(2, 0)
 #define MPNIC_DESC_CFG_START_ADDR	CSR_GENMASK(19, 8)
@@ -28,6 +35,22 @@
  *	Name				Index			Address
  *****************************************************************************/
 
+/* NIC_CORE_TDF */
+#define MPNIC_TWQ_TAIL(i, j)		(0x4 + 1024 * (i) + 2 * (j))
+								/* 0x10 */
+
+/* NIC_CORE_TCM */
+#define MPNIC_TCQ_HEAD(i)		(0x8e + 1024 * (i))	/* 0x238 */
+
+/* NIC_CORE_TIM */
+#define MPNIC_TIM_CTL1(i)		(0xc0 + 1024 * (i))	/* 0x300 */
+#define MPNIC_TIM_CTL1_UPD_IGN_LONG_EVENT_CNT	CSR_BIT(48)
+#define MPNIC_TIM_CTL1_UPD_IGN_LONG_TIME_CNT	CSR_BIT(49)
+#define MPNIC_TIM_CTL1_UPD_IGN_SHORT_TIME_CNT	CSR_BIT(50)
+#define MPNIC_TIM_CTL1_MASK			CSR_BIT(51)
+#define MPNIC_TIM_CTL1_MASK_EN			CSR_BIT(52)
+#define MPNIC_TIM_CTL1_TRIGGER			CSR_BIT(53)
+
 /* NIC_CORE_RBP_HP_GLBL */
 #define MPNIC_BDQ_GLBL_CTL0		0x420080		/* 0x1080200 */
 #define MPNIC_BDQ_GLBL_CTL0_MAX_REQ_SIZE	CSR_GENMASK(26, 18)
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
new file mode 100644
index 000000000000..f98adf209b45
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _MPNIC_NETDEV_H_
+#define _MPNIC_NETDEV_H_
+
+#include <linux/types.h>
+
+#include "mpnic.h"
+#include "mpnic_txrx.h"
+
+struct mpnic_net {
+	struct mpnic_ring *tx[MPNIC_MAX_TXQS];
+
+	struct mpnic_napi_vector *napi[MPNIC_MAX_NAPI_VECTORS];
+
+	struct net_device *netdev;
+	struct mpnic_dev *mpd;
+
+	u32 txq_size;
+
+	u16 num_napi;
+	u16 num_tx_queues;
+};
+
+#endif /* _MPNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
new file mode 100644
index 000000000000..853976e11b03
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bitfield.h>
+#include <linux/dma-mapping.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include "mpnic.h"
+#include "mpnic_netdev.h"
+#include "mpnic_txrx.h"
+
+struct mpnic_xmit_cb {
+	u32 bytecount;
+	u8 desc_count;
+};
+
+#define MPNIC_XMIT_CB(__skb) ((struct mpnic_xmit_cb *)((__skb)->cb))
+
+/* Leave the interrupt moderation counters alone when arming or masking */
+#define MPNIC_TIM_PARAM_CFG_PRESERVE_MASK \
+	(MPNIC_TIM_CTL1_UPD_IGN_LONG_EVENT_CNT | \
+	 MPNIC_TIM_CTL1_UPD_IGN_LONG_TIME_CNT | \
+	 MPNIC_TIM_CTL1_UPD_IGN_SHORT_TIME_CNT)
+
+static void mpnic_nv_irq_disable(struct mpnic_napi_vector *nv)
+{
+	mpnic_wr64(nv->mpd, MPNIC_TIM_CTL1(nv->qt[0].cmpl.q_idx),
+		   MPNIC_TIM_PARAM_CFG_PRESERVE_MASK |
+		   MPNIC_TIM_CTL1_MASK_EN | MPNIC_TIM_CTL1_MASK);
+}
+
+static void mpnic_nv_irq_rearm(struct mpnic_napi_vector *nv)
+{
+	/* Rearming a single queue on a given IRQ rearms all the other
+	 * queues mapped to the same IRQ.
+	 */
+	mpnic_wr64(nv->mpd, MPNIC_TIM_CTL1(nv->qt[0].cmpl.q_idx),
+		   MPNIC_TIM_PARAM_CFG_PRESERVE_MASK | MPNIC_TIM_CTL1_MASK_EN);
+}
+
+static void mpnic_nv_irq_trigger(struct mpnic_napi_vector *nv)
+{
+	mpnic_wr64(nv->mpd, MPNIC_TIM_CTL1(nv->qt[0].cmpl.q_idx),
+		   MPNIC_TIM_PARAM_CFG_PRESERVE_MASK |
+		   MPNIC_TIM_CTL1_MASK_EN | MPNIC_TIM_CTL1_TRIGGER);
+}
+
+static unsigned int mpnic_desc_unused(struct mpnic_ring *ring)
+{
+	return (ring->head - ring->tail - 1) & ring->size_mask;
+}
+
+static struct netdev_queue *mpnic_txring_txq(const struct net_device *dev,
+					     const struct mpnic_ring *ring)
+{
+	return netdev_get_tx_queue(dev, ring->q_idx);
+}
+
+static void mpnic_unmap_single_twd(struct device *dev, __le64 *twd)
+{
+	u64 raw_twd = le64_to_cpu(*twd);
+
+	dma_unmap_single(dev, FIELD_GET(MPNIC_TWD_ADDR, raw_twd),
+			 FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
+}
+
+static void mpnic_unmap_page_twd(struct device *dev, __le64 *twd)
+{
+	u64 raw_twd = le64_to_cpu(*twd);
+
+	dma_unmap_page(dev, FIELD_GET(MPNIC_TWD_ADDR, raw_twd),
+		       FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
+}
+
+static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
+			     struct mpnic_ring *ring, bool discard,
+			     unsigned int hw_head)
+{
+	u64 total_bytes = 0, total_packets = 0;
+	unsigned int head = ring->head;
+	struct netdev_queue *txq;
+	unsigned int clean_desc;
+
+	clean_desc = (hw_head - head) & ring->size_mask;
+
+	while (clean_desc) {
+		struct sk_buff *skb = ring->tx_buf[head];
+		unsigned int desc_cnt;
+
+		desc_cnt = MPNIC_XMIT_CB(skb)->desc_count;
+		if (desc_cnt > clean_desc)
+			break;
+
+		ring->tx_buf[head] = NULL;
+
+		clean_desc -= desc_cnt;
+
+		/* Step over the metadata descriptor */
+		head++;
+		head &= ring->size_mask;
+		desc_cnt--;
+
+		mpnic_unmap_single_twd(nv->dev, &ring->desc[head]);
+		head++;
+		head &= ring->size_mask;
+		desc_cnt--;
+
+		while (desc_cnt--) {
+			mpnic_unmap_page_twd(nv->dev, &ring->desc[head]);
+			head++;
+			head &= ring->size_mask;
+		}
+
+		total_bytes += MPNIC_XMIT_CB(skb)->bytecount;
+		total_packets++;
+
+		napi_consume_skb(skb, napi_budget);
+	}
+
+	if (!total_bytes)
+		return;
+
+	ring->head = head;
+
+	if (discard)
+		return;
+
+	txq = mpnic_txring_txq(nv->napi.dev, ring);
+	netif_txq_completed_wake(txq, total_packets, total_bytes,
+				 mpnic_desc_unused(ring),
+				 MPNIC_TX_DESC_WAKEUP);
+}
+
+static void mpnic_commit_cq_head(struct mpnic_ring *cmpl)
+{
+	u32 head = cmpl->head;
+
+	/* The tail shadows the last value written to the doorbell, so a
+	 * completion queue which has not moved costs no MMIO write.
+	 */
+	if (cmpl->tail != head) {
+		cmpl->tail = head;
+		writeq(head & cmpl->size_mask, cmpl->doorbell);
+	}
+}
+
+static void mpnic_clean_tcq(struct mpnic_napi_vector *nv,
+			    struct mpnic_q_triad *qt, int napi_budget)
+{
+	struct mpnic_ring *cmpl = &qt->cmpl;
+	__le64 *raw_tcd, done;
+	u32 head = cmpl->head;
+	s32 head0 = -1;
+
+	done = (head & (cmpl->size_mask + 1)) ? 0 : cpu_to_le64(MPNIC_TCD_DONE);
+	raw_tcd = &cmpl->desc[head & cmpl->size_mask];
+
+	/* Walk the completion queue collecting the heads reported by NIC.
+	 * Only the first work queue is enabled and no packet asks for a
+	 * timestamp, so every completion is a plain head update and the
+	 * descriptor type does not have to be decoded.
+	 */
+	while ((*raw_tcd & cpu_to_le64(MPNIC_TCD_DONE)) == done) {
+		u64 tcd;
+
+		dma_rmb();
+
+		tcd = le64_to_cpu(*raw_tcd);
+		head0 = FIELD_GET(MPNIC_TCD_TYPE0_HEAD0, tcd);
+
+		raw_tcd++;
+		head++;
+
+		if (unlikely(!(head & cmpl->size_mask))) {
+			done ^= cpu_to_le64(MPNIC_TCD_DONE);
+			raw_tcd = &cmpl->desc[0];
+		}
+	}
+
+	cmpl->head = head;
+
+	if (head0 >= 0)
+		mpnic_clean_twq0(nv, napi_budget, &qt->sub0, false, head0);
+}
+
+static int mpnic_poll(struct napi_struct *napi, int budget)
+{
+	struct mpnic_napi_vector *nv = container_of(napi,
+						    struct mpnic_napi_vector,
+						    napi);
+	int i;
+
+	for (i = 0; i < nv->txt_count; i++)
+		mpnic_clean_tcq(nv, &nv->qt[i], budget);
+
+	for (i = 0; i < nv->txt_count; i++)
+		mpnic_commit_cq_head(&nv->qt[i].cmpl);
+
+	if (likely(napi_complete_done(napi, 0)))
+		mpnic_nv_irq_rearm(nv);
+
+	return 0;
+}
+
+static irqreturn_t mpnic_msix_clean_rings(int __always_unused irq, void *data)
+{
+	struct mpnic_napi_vector *nv = data;
+
+	napi_schedule_irqoff(&nv->napi);
+
+	return IRQ_HANDLED;
+}
+
+static void mpnic_free_napi_vector(struct mpnic_net *mpn,
+				   struct mpnic_napi_vector *nv)
+{
+	int i;
+
+	for (i = 0; i < nv->txt_count; i++)
+		mpn->tx[nv->qt[i].sub0.q_idx] = NULL;
+
+	mpnic_free_irq(nv->mpd, nv->v_idx, nv);
+	netif_napi_del_locked(&nv->napi);
+	mpn->napi[nv->v_idx - MPNIC_NON_NAPI_VECTORS] = NULL;
+	kfree(nv);
+}
+
+void mpnic_free_napi_vectors(struct mpnic_net *mpn)
+{
+	int i;
+
+	for (i = 0; i < mpn->num_napi; i++)
+		if (mpn->napi[i])
+			mpnic_free_napi_vector(mpn, mpn->napi[i]);
+}
+
+static void mpnic_ring_init(struct mpnic_ring *ring, u32 __iomem *doorbell,
+			    int q_idx)
+{
+	ring->doorbell = doorbell;
+	ring->q_idx = q_idx;
+}
+
+static int mpnic_alloc_napi_vector(struct mpnic_dev *mpd,
+				   struct mpnic_net *mpn, unsigned int idx)
+{
+	u32 __iomem *uc_addr = READ_ONCE(mpd->uc_addr0);
+	struct mpnic_napi_vector *nv;
+	int err;
+
+	/* Doorbells are plain pointers into the register window, they have
+	 * no way of noticing that it went away.
+	 */
+	if (!uc_addr)
+		return -EIO;
+
+	nv = kzalloc_flex(*nv, qt, 1);
+	if (!nv)
+		return -ENOMEM;
+
+	nv->txt_count = 1;
+	nv->mpd = mpd;
+	nv->dev = mpd->dev;
+	nv->v_idx = idx + MPNIC_NON_NAPI_VECTORS;
+
+	mpn->napi[idx] = nv;
+	netif_napi_add_config_locked(mpn->netdev, &nv->napi, mpnic_poll, idx);
+	netif_napi_set_irq_locked(&nv->napi,
+				  pci_irq_vector(to_pci_dev(mpd->dev),
+						 nv->v_idx));
+
+	snprintf(nv->name, sizeof(nv->name), "%s-TxRx-%u",
+		 mpn->netdev->name, idx);
+
+	err = mpnic_request_irq(mpd, nv->v_idx, mpnic_msix_clean_rings, 0,
+				nv->name, nv);
+	if (err)
+		goto err_napi_del;
+
+	mpnic_ring_init(&nv->qt[0].sub0, &uc_addr[MPNIC_TWQ_TAIL(idx, 0)], idx);
+	mpnic_ring_init(&nv->qt[0].cmpl, &uc_addr[MPNIC_TCQ_HEAD(idx)], idx);
+	mpn->tx[idx] = &nv->qt[0].sub0;
+
+	return 0;
+
+err_napi_del:
+	netif_napi_del_locked(&nv->napi);
+	mpn->napi[idx] = NULL;
+	kfree(nv);
+	return err;
+}
+
+int mpnic_alloc_napi_vectors(struct mpnic_net *mpn)
+{
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		err = mpnic_alloc_napi_vector(mpn->mpd, mpn, i);
+		if (err)
+			goto err_free_vectors;
+	}
+
+	return 0;
+
+err_free_vectors:
+	mpnic_free_napi_vectors(mpn);
+
+	return err;
+}
+
+static void mpnic_free_ring_resources(struct device *dev,
+				      struct mpnic_ring *ring)
+{
+	kvfree(ring->tx_buf);
+	ring->tx_buf = NULL;
+
+	/* If size is not set there are no descriptors present */
+	if (!ring->size)
+		return;
+
+	dma_free_coherent(dev, ring->size, ring->desc, ring->dma);
+	ring->size_mask = 0;
+	ring->size = 0;
+}
+
+static int mpnic_alloc_ring_desc(struct mpnic_net *mpn,
+				 struct mpnic_ring *ring, u32 count)
+{
+	struct device *dev = mpn->netdev->dev.parent;
+	size_t size;
+
+	size = ALIGN(array_size(sizeof(*ring->desc), count), 4096);
+
+	ring->desc = dma_alloc_coherent(dev, size, &ring->dma,
+					GFP_KERNEL | __GFP_NOWARN);
+	if (!ring->desc)
+		return -ENOMEM;
+
+	ring->size_mask = count - 1;
+	ring->size = size;
+
+	return 0;
+}
+
+static void mpnic_free_tx_qt_resources(struct mpnic_net *mpn,
+				       struct mpnic_q_triad *qt)
+{
+	struct device *dev = mpn->netdev->dev.parent;
+
+	mpnic_free_ring_resources(dev, &qt->cmpl);
+	mpnic_free_ring_resources(dev, &qt->sub0);
+}
+
+static int mpnic_alloc_tx_qt_resources(struct mpnic_net *mpn,
+				       struct mpnic_q_triad *qt)
+{
+	int err;
+
+	err = mpnic_alloc_ring_desc(mpn, &qt->sub0, mpn->txq_size);
+	if (err)
+		return err;
+
+	qt->sub0.tx_buf = kvzalloc_objs(*qt->sub0.tx_buf, mpn->txq_size,
+					GFP_KERNEL | __GFP_NOWARN);
+	if (!qt->sub0.tx_buf) {
+		err = -ENOMEM;
+		goto err_free_qt;
+	}
+
+	err = mpnic_alloc_ring_desc(mpn, &qt->cmpl, mpn->txq_size);
+	if (err)
+		goto err_free_qt;
+
+	return 0;
+
+err_free_qt:
+	mpnic_free_tx_qt_resources(mpn, qt);
+	return err;
+}
+
+static void mpnic_free_nv_resources(struct mpnic_net *mpn,
+				    struct mpnic_napi_vector *nv)
+{
+	int i;
+
+	for (i = 0; i < nv->txt_count; i++)
+		mpnic_free_tx_qt_resources(mpn, &nv->qt[i]);
+}
+
+static int mpnic_alloc_nv_resources(struct mpnic_net *mpn,
+				    struct mpnic_napi_vector *nv)
+{
+	int i, err;
+
+	for (i = 0; i < nv->txt_count; i++) {
+		err = mpnic_alloc_tx_qt_resources(mpn, &nv->qt[i]);
+		if (err)
+			goto err_free_qt_resources;
+	}
+
+	return 0;
+
+err_free_qt_resources:
+	while (i--)
+		mpnic_free_tx_qt_resources(mpn, &nv->qt[i]);
+	return err;
+}
+
+void mpnic_free_resources(struct mpnic_net *mpn)
+{
+	int i;
+
+	for (i = 0; i < mpn->num_napi; i++)
+		mpnic_free_nv_resources(mpn, mpn->napi[i]);
+}
+
+int mpnic_alloc_resources(struct mpnic_net *mpn)
+{
+	int i, err;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		err = mpnic_alloc_nv_resources(mpn, mpn->napi[i]);
+		if (err)
+			goto err_free_resources;
+	}
+
+	return 0;
+
+err_free_resources:
+	while (i--)
+		mpnic_free_nv_resources(mpn, mpn->napi[i]);
+
+	return err;
+}
+
+int mpnic_set_netif_queues(struct mpnic_net *mpn)
+{
+	int i, j, err;
+
+	err = netif_set_real_num_tx_queues(mpn->netdev, mpn->num_tx_queues);
+	if (err)
+		return err;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		struct mpnic_napi_vector *nv = mpn->napi[i];
+
+		for (j = 0; j < nv->txt_count; j++)
+			netif_queue_set_napi(mpn->netdev, nv->qt[j].sub0.q_idx,
+					     NETDEV_QUEUE_TYPE_TX, &nv->napi);
+	}
+
+	return 0;
+}
+
+void mpnic_reset_netif_queues(struct mpnic_net *mpn)
+{
+	int i, j;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		struct mpnic_napi_vector *nv = mpn->napi[i];
+
+		for (j = 0; j < nv->txt_count; j++)
+			netif_queue_set_napi(mpn->netdev, nv->qt[j].sub0.q_idx,
+					     NETDEV_QUEUE_TYPE_TX, NULL);
+	}
+}
+
+void mpnic_napi_disable(struct mpnic_net *mpn)
+{
+	int i;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		napi_disable_locked(&mpn->napi[i]->napi);
+
+		mpnic_nv_irq_disable(mpn->napi[i]);
+	}
+}
+
+void mpnic_napi_enable(struct mpnic_net *mpn)
+{
+	int i;
+
+	for (i = 0; i < mpn->num_napi; i++)
+		napi_enable_locked(&mpn->napi[i]->napi);
+
+	/* Force the first interrupt on each vector to guarantee that any
+	 * completions posted during bringup are processed.
+	 */
+	for (i = 0; i < mpn->num_napi; i++)
+		mpnic_nv_irq_trigger(mpn->napi[i]);
+
+	mpnic_wrfl(mpn->mpd);
+}
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
new file mode 100644
index 000000000000..0d4667666b5b
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _MPNIC_TXRX_H_
+#define _MPNIC_TXRX_H_
+
+#include <linux/if_ether.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+#include <net/netdev_queues.h>
+
+#include "mpnic.h"
+
+struct mpnic_net;
+
+/* Space we have to have available in a work queue to take a packet:
+ *	1 descriptor per page
+ *	+ 1 descriptor for the skb head
+ *	+ 1 descriptor for the metadata
+ *	+ 7 descriptors to keep the tail out of the head's cacheline
+ * If we cannot guarantee that we return NETDEV_TX_BUSY.
+ */
+#define MPNIC_MAX_SKB_DESC		(MAX_SKB_FRAGS + 9)
+#define MPNIC_TX_DESC_WAKEUP		(MPNIC_MAX_SKB_DESC * 2)
+
+#define MPNIC_MAX_NAPI_VECTORS		1024u
+
+struct mpnic_ring {
+	void **tx_buf;			/* Packets outstanding in a TWQ */
+
+	u32 __iomem *doorbell;		/* Pointer to CSR space for ring */
+	__le64 *desc;			/* Descriptor ring memory */
+	u16 size_mask;			/* Size of ring in descriptors - 1 */
+	u16 q_idx;			/* Hardware queue index */
+
+	u32 head, tail;			/* Head/Tail of ring */
+
+	/* TWQ only, index of the metadata descriptor of the last packet
+	 * placed in the ring without ringing the doorbell, -1 if the
+	 * doorbell is in sync with the tail.
+	 */
+	s32 deferred_meta;
+
+	/* Slow path fields follow */
+	dma_addr_t dma;			/* Phys addr of descriptor memory */
+	size_t size;			/* Size of descriptor ring in memory */
+};
+
+/* The device pairs two work queues with one completion queue. On the Tx
+ * side only the first work queue is used for now, the second one becomes
+ * the XDP ring.
+ */
+struct mpnic_q_triad {
+	struct mpnic_ring sub0, sub1, cmpl;
+};
+
+struct mpnic_napi_vector {
+	struct napi_struct napi;
+	struct device *dev;		/* Device for DMA unmapping */
+	struct mpnic_dev *mpd;
+
+	u16 v_idx;
+	u16 txt_count;
+
+	char name[IFNAMSIZ + 11];
+
+	struct mpnic_q_triad qt[];
+};
+
+int mpnic_alloc_napi_vectors(struct mpnic_net *mpn);
+void mpnic_free_napi_vectors(struct mpnic_net *mpn);
+int mpnic_alloc_resources(struct mpnic_net *mpn);
+void mpnic_free_resources(struct mpnic_net *mpn);
+int mpnic_set_netif_queues(struct mpnic_net *mpn);
+void mpnic_reset_netif_queues(struct mpnic_net *mpn);
+void mpnic_napi_enable(struct mpnic_net *mpn);
+void mpnic_napi_disable(struct mpnic_net *mpn);
+
+#endif /* _MPNIC_TXRX_H_ */

-- 
2.52.0

