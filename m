Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F944161B;
	Wed, 12 Aug 2026 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539008; cv=none; b=cWNbCtFMD9xsjlxO+QaEX6wquoH6vcmGWcbRqAu84GlUBpPbq7BdGm9Wqyg+4AIfdfvMvP9WSiGiGMd5EV62LYmhvLWG3tVELd25EHNEOalvxpAEMmM5RNOC9gsLz3Znsw28RxSzdpQ9hicE6VCbJBeiNBs7CpZeDyqWbQfd104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539008; c=relaxed/simple;
	bh=W0RDmqYm8j6zDHKhvibdu2xaxaLSkQtQIvs1kCgm5Lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PuWvnPN75hh90HcvPDyaN9n7iaGnGPV7VObWdPxX0liMediaPvbdmPkblmlTCdx0OkG5H5yp0QRdslhO1smnwV6pUFl1LdSdCJ7JAxcd2z6M2HJMwWOVeDQemm9Alc2iIxsZ/ifmi7BMFZpknS75dRlXsB9u0cesd/PAxBBSnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=So1b2Kij; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="So1b2Kij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11548; q=dns/txt;
  s=iport01; t=1786539005; x=1787748605;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0QeqpoTuOySguWgV3Dgs0Cxs2AvCjk/5QB7hqxwB53k=;
  b=So1b2KijhZJaAR1no0i0P3P3/XmJfSyjjh16E+xqQ1Iko2jcveJnKVH/
   2DHKISA/6y5fyyT9/aDhDPHyWQLyS1WKFUVGQszeSw2iigXbvjyE1XIKr
   MZIQYJqUgGxJzNWOW7bqKCVDckb614a1bEXy8u0OqXCJRF3pIHW087esI
   6UAQ6b9UluRSSnl76f7icYZh/xF4oqOmta9yt6ZCqBrV6sD0BYHC0fe01
   /sMGAIAE7+wzK1D8Nc4eoUX3GHYpDTRtfyCYROB6RYIZlpjfArFAnxGRt
   cNxqJtF/JivQ0LYcUWDoBcSo1FNJ4VnkdO4K60TGEtJmaC3iyBcXY9cV5
   A==;
X-CSE-ConnectionGUID: 8edDMxMPSWS9wJEZy62ucQ==
X-CSE-MsgGUID: OdPH4K6VQzKoQllwx5pGVQ==
X-IPAS-Result: =?us-ascii?q?A0AyAADWanxq/5EQJK1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBTgRDSYRXiBuHN4Ihnh4UgWoPAQEBD1EEAQGFBQKNZwImNAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBE?=
 =?us-ascii?q?oMCgnUDwyt6fzOBAYR92UmBZgELFAGBCi4BhXCCbAGBcIQIO4RBJxuBSUSBF?=
 =?us-ascii?q?AGDaYQFAQQVC4N0gmoEgxwSgXiRCAk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLE?=
 =?us-ascii?q?hIYFQIULw8EFjIdcAwnEiwXNVgbBgWBHX0UBBOENiMZNnyBCWGBKyplARIXg?=
 =?us-ascii?q?QmCJAKCdoEqYQIBHgsYDUgRLDcGDhkEPQFuB44IIIE9F3FZNQFNb4EhHCySY?=
 =?us-ascii?q?AiDdo1fa4E1n1qEKIFmoA8BMpdnkwWZCCOjSW6EaYFoPIFZMxoIGxWDIlMZD?=
 =?us-ascii?q?44qAxbQGScyPQEBBwIHDgMLgWiQABEXgVYBAQ?=
IronPort-Data: A9a23:U+xxqqsVBAu9A7QCVzKJ+GoMVOfnVIRfMUV32f8akzHdYApBsoF/q
 tZmKWzTPamJYTSmed8gb96+p0sF75aDz4M1HAE++3xkE3wQgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZTdJ5xYuajhKs/La8ks21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIwqut7LURe0
 MQjFwtccTKutfPomq+wc7w57igjBJGD0II3s3Vky3TdSP0hW52GG/WM7t5D1zB2jcdLdRrcT
 5NGMnw0MlKZPVsWZgp/5JEWxI9EglHkeiFZs1KWpYI84nPYy0p6172F3N/9KoTWGJgOwRfEz
 o7A10P1OjFGF4Kh8Cim9UuogvDfwDvUZrtHQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGqaUz6EWsZtXwVRyxpjiDpBF0c9dcDugz+gyR4qXT5AmdCy4PSTspQN87vsYeRjEw0
 FKN2dTzClRHubuZU3+CtbGZsT+/JwARMGkEIyQEJSMd6tPupoAblB/DTt9/VqWyi7XdHTD23
 iDPryUkgbgXpdAE2r/9/l3dhT+o4J/TQWYd4AjLUm+7xh12aZTjZIGy71Xfq/FaI+6kokKpt
 XwAnY2aqesJF5zIzHzLS+QWF7bv7PGAWNHBvWNS81Aa32zF0xaekUp4u1mS+G8B3h44RALU
IronPort-HdrOrdr: A9a23:z9HESKsoH0Qe9zpYIQuMkRnE7skDgNV00zEX/kB9WHVpmwKj5q
 STdZMgtCMc6Qx+ZJhOo7290cW7K080sKQFg7X5Xo3MYOCZgguVxehZhOOI/9SjIVycygc378
 tdmsZFebjNJGk/oMrk7Ay/Cto6hPuK4MmT9J7j5kYoYA10Z6Rn9gtjTjyaHEp/WRVcCfMCZf
 yhD7J81l2dUEVSSNinDX8YWOWGjdjKmJX6JSMiPXccmXGzZffC0s+BL/BetS1uKA9y/Q==
X-Talos-CUID: 9a23:lapodmxKajggxzVTx5dNBgVEF8wJV2349EzvGB6nK0tbWePPVFSprfY=
X-Talos-MUID: 9a23:AywjtAUzb8SgUkzq/BjgvBE+F5lW2raND3kJlYoW5tGrCxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="804553794"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 12:48:31 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id A0A9C18000770;
	Wed, 12 Aug 2026 12:48:30 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 12 Aug 2026 05:48:02 -0700
Subject: [PATCH net-next v13 02/11] enic: add admin channel open and close
 for SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-enic-sriov-v2-admin-channel-v2-v13-2-b3809e448aba@cisco.com>
References: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
In-Reply-To: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786538908; l=11943;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=W0RDmqYm8j6zDHKhvibdu2xaxaLSkQtQIvs1kCgm5Lk=;
 b=f9Mw54ALatNrDvyIesGV/Fy7sI9x/7/ym1A+9u6BXh/brrGrQgY6/kvkksYyVW9MYPXqDSan9
 Dv8ylBkDsrbBbj9u9MJHRe9E0evfDM7Hv5xobv/mgeoNy7Qy4BosDkL
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-08.cisco.com

The V2 SR-IOV design uses a dedicated admin channel (WQ/RQ/CQ
resources plus an MSI-X interrupt) for PF-VF mailbox communication rather
than firmware-proxied devcmds.

Introduce enic_admin_channel_open() and enic_admin_channel_close().
Open allocates and initialises the admin WQ, RQ, and two CQs (one per
direction), then issues CMD_QP_TYPE_SET to tell firmware the queues are
admin-type. Close reverses the sequence.

enic_admin_wq_buf_clean() unmaps and frees any WQ buffers still held
at close time, fixing a DMA mapping leak when a send times out.

Add CMD_QP_TYPE_SET (97), QP_TYPE_ADMIN/DATA, and QP_ENABLE/QP_DISABLE
defines to vnic_devcmd.h. Add VNIC_CQ_* named constants to vnic_cq.h
so CQ initialisation parameters are self-documenting from their first
introduction.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic.h        |   5 +
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 227 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  15 ++
 drivers/net/ethernet/cisco/enic/vnic_cq.h     |   9 +
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  11 ++
 6 files changed, 269 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/Makefile b/drivers/net/ethernet/cisco/enic/Makefile
index a96b8332e6e2..7ae72fefc99a 100644
--- a/drivers/net/ethernet/cisco/enic/Makefile
+++ b/drivers/net/ethernet/cisco/enic/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_ENIC) := enic.o
 
 enic-y := enic_main.o vnic_cq.o vnic_intr.o vnic_wq.o \
 	enic_res.o enic_dev.o enic_pp.o vnic_dev.o vnic_rq.o vnic_vic.o \
-	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o enic_wq.o
+	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o enic_wq.o \
+	enic_admin.o
 
diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 08472420f3a1..398227448b37 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -292,6 +292,11 @@ struct enic {
 
 	/* Admin channel resources for SR-IOV MBOX */
 	bool has_admin_channel;
+	/* true only while the admin WQ/RQ/CQ are allocated and enabled; gates
+	 * enic_admin_channel_close() so it is a no-op after a failed (re)open
+	 * left the resources freed.
+	 */
+	bool admin_chan_up;
 	struct vnic_wq admin_wq;
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
new file mode 100644
index 000000000000..50b46b92c88f
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2025 Cisco Systems, Inc.  All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+
+#include "vnic_dev.h"
+#include "vnic_wq.h"
+#include "vnic_rq.h"
+#include "vnic_cq.h"
+#include "vnic_intr.h"
+#include "vnic_resource.h"
+#include "vnic_devcmd.h"
+#include "enic.h"
+#include "enic_admin.h"
+#include "cq_desc.h"
+#include "wq_enet_desc.h"
+#include "rq_enet_desc.h"
+
+/* Clean up any admin WQ buffers still held by hardware at close time.
+ * Normally buffers are freed inline after send completion, but a timed-out
+ * send intentionally leaves the buffer live until the queue is stopped.
+ */
+static void enic_admin_wq_buf_clean(struct vnic_wq *wq,
+				    struct vnic_wq_buf *buf)
+{
+	struct enic *enic = vnic_dev_priv(wq->vdev);
+
+	if (buf->os_buf) {
+		dma_unmap_single(&enic->pdev->dev, buf->dma_addr,
+				 buf->len, DMA_TO_DEVICE);
+		kfree(buf->os_buf);
+		buf->os_buf = NULL;
+	}
+}
+
+/* No-op: admin RQ buffer teardown is handled in enic_admin_channel_close */
+static void enic_admin_rq_buf_clean(struct vnic_rq *rq,
+				    struct vnic_rq_buf *buf)
+{
+}
+
+static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
+{
+	u64 a0 = QP_TYPE_ADMIN, a1 = enable;
+	int wait = 1000;
+	int err;
+
+	spin_lock_bh(&enic->devcmd_lock);
+	err = vnic_dev_cmd(enic->vdev, CMD_QP_TYPE_SET, &a0, &a1, wait);
+	spin_unlock_bh(&enic->devcmd_lock);
+
+	return err;
+}
+
+static int enic_admin_alloc_resources(struct enic *enic)
+{
+	int err;
+
+	err = vnic_wq_alloc_with_type(enic->vdev, &enic->admin_wq, 0,
+				      ENIC_ADMIN_DESC_COUNT,
+				      sizeof(struct wq_enet_desc),
+				      RES_TYPE_ADMIN_WQ);
+	if (err)
+		return err;
+
+	err = vnic_rq_alloc_with_type(enic->vdev, &enic->admin_rq, 0,
+				      ENIC_ADMIN_DESC_COUNT,
+				      sizeof(struct rq_enet_desc),
+				      RES_TYPE_ADMIN_RQ);
+	if (err)
+		goto free_wq;
+
+	/* admin_cq[0] is the WQ completion queue.  WQ CQEs are always
+	 * 16 bytes wide; firmware always writes 16-byte CQEs for WQ
+	 * completions on every WQ, including the admin channel WQ.
+	 * Use sizeof(struct cq_desc) accordingly.
+	 */
+	err = vnic_cq_alloc_with_type(enic->vdev, &enic->admin_cq[0], 0,
+				      ENIC_ADMIN_DESC_COUNT,
+				      sizeof(struct cq_desc),
+				      RES_TYPE_ADMIN_CQ);
+	if (err)
+		goto free_rq;
+
+	/* admin_cq[1] is the RQ completion queue.  Its descriptor size
+	 * must match what firmware writes.  enic_ext_cq() called earlier
+	 * in probe issues CMD_CQ_ENTRY_SIZE_SET for VNIC_RQ_ALL,
+	 * programming firmware to write CQ entries of (16 << enic->ext_cq)
+	 * bytes for every RQ CQ on the vNIC, including the admin RQ CQ.
+	 * Allocating with the same size keeps the host poller and
+	 * firmware in lockstep:
+	 *
+	 *   - The color/valid bit lives at byte (desc_size - 1) of every
+	 *     cq_enet_rq_desc[_32|_64] variant, so enic_admin_cq_color()
+	 *     reads it from the correct offset.
+	 *   - Only the first 15 bytes of the descriptor (vlan,
+	 *     bytes_written_flags, ...) are accessed by the admin path;
+	 *     these fields are identical across all three variants (see
+	 *     comment in enic_rq.c above cq_enet_rq_desc_dec()).
+	 */
+	err = vnic_cq_alloc_with_type(enic->vdev, &enic->admin_cq[1], 1,
+				      ENIC_ADMIN_DESC_COUNT,
+				      16 << enic->ext_cq,
+				      RES_TYPE_ADMIN_CQ);
+	if (err)
+		goto free_cq0;
+
+	return 0;
+
+free_cq0:
+	vnic_cq_free(&enic->admin_cq[0]);
+free_rq:
+	vnic_rq_free(&enic->admin_rq);
+free_wq:
+	vnic_wq_free(&enic->admin_wq);
+	return err;
+}
+
+static void enic_admin_free_resources(struct enic *enic)
+{
+	vnic_cq_free(&enic->admin_cq[1]);
+	vnic_cq_free(&enic->admin_cq[0]);
+	vnic_rq_free(&enic->admin_rq);
+	vnic_wq_free(&enic->admin_wq);
+}
+
+static void enic_admin_init_resources(struct enic *enic)
+{
+	vnic_wq_init(&enic->admin_wq,
+		     0, 0, 0); /* cq_index, err_intr_enable, err_intr_offset */
+	vnic_rq_init(&enic->admin_rq,
+		     1, 0, 0); /* cq_index, err_intr_enable, err_intr_offset */
+	vnic_cq_init(&enic->admin_cq[0],
+		     VNIC_CQ_FC_DISABLE,
+		     VNIC_CQ_COLOR_ENABLE,
+		     0, 0, 1, /* cq_head, cq_tail, cq_tail_color */
+		     VNIC_CQ_INTR_DISABLE,
+		     VNIC_CQ_ENTRY_ENABLE,
+		     VNIC_CQ_MSG_DISABLE,
+		     0, /* interrupt_offset */
+		     0 /* cq_message_addr */);
+	vnic_cq_init(&enic->admin_cq[1],
+		     VNIC_CQ_FC_DISABLE,
+		     VNIC_CQ_COLOR_ENABLE,
+		     0, 0, 1, /* cq_head, cq_tail, cq_tail_color */
+		     VNIC_CQ_INTR_DISABLE,
+		     VNIC_CQ_ENTRY_ENABLE,
+		     VNIC_CQ_MSG_DISABLE,
+		     0, /* interrupt_offset */
+		     0 /* cq_message_addr */);
+}
+
+int enic_admin_channel_open(struct enic *enic)
+{
+	int err;
+
+	if (!enic->has_admin_channel)
+		return -ENODEV;
+
+	err = enic_admin_alloc_resources(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to alloc admin channel resources: %d\n",
+			   err);
+		return err;
+	}
+
+	enic_admin_init_resources(enic);
+
+	vnic_wq_enable(&enic->admin_wq);
+	vnic_rq_enable(&enic->admin_rq);
+
+	err = enic_admin_qp_type_set(enic, QP_ENABLE);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to set admin QP type: %d\n", err);
+		goto disable_queues;
+	}
+
+	enic->admin_chan_up = true;
+
+	return 0;
+
+disable_queues:
+	enic_admin_qp_type_set(enic, QP_DISABLE);
+	if (vnic_wq_disable(&enic->admin_wq))
+		netdev_warn(enic->netdev, "Failed to disable admin WQ\n");
+	if (vnic_rq_disable(&enic->admin_rq))
+		netdev_warn(enic->netdev, "Failed to disable admin RQ\n");
+	enic_admin_free_resources(enic);
+	return err;
+}
+
+void enic_admin_channel_close(struct enic *enic)
+{
+	int err;
+
+	if (!enic->has_admin_channel)
+		return;
+
+	/* Nothing to tear down if the channel was never (re)opened, e.g. a
+	 * failed enic_admin_channel_open() in probe or in the reset path;
+	 * otherwise the disable/clean calls below dereference freed resources.
+	 */
+	if (!enic->admin_chan_up)
+		return;
+
+	enic_admin_qp_type_set(enic, QP_DISABLE);
+
+	err = vnic_wq_disable(&enic->admin_wq);
+	if (err)
+		netdev_warn(enic->netdev,
+			    "Failed to disable admin WQ: %d\n", err);
+	err = vnic_rq_disable(&enic->admin_rq);
+	if (err)
+		netdev_warn(enic->netdev,
+			    "Failed to disable admin RQ: %d\n", err);
+
+	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
+	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
+	vnic_cq_clean(&enic->admin_cq[0]);
+	vnic_cq_clean(&enic->admin_cq[1]);
+	enic_admin_free_resources(enic);
+
+	enic->admin_chan_up = false;
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.h b/drivers/net/ethernet/cisco/enic/enic_admin.h
new file mode 100644
index 000000000000..569aadeb9312
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2025 Cisco Systems, Inc.  All rights reserved. */
+
+#ifndef _ENIC_ADMIN_H_
+#define _ENIC_ADMIN_H_
+
+#define ENIC_ADMIN_DESC_COUNT	64
+#define ENIC_ADMIN_BUF_SIZE	2048
+
+struct enic;
+
+int enic_admin_channel_open(struct enic *enic);
+void enic_admin_channel_close(struct enic *enic);
+
+#endif /* _ENIC_ADMIN_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/vnic_cq.h b/drivers/net/ethernet/cisco/enic/vnic_cq.h
index d46d4d2ef6bb..35ffa3230713 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_cq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_cq.h
@@ -76,6 +76,15 @@ int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
 int vnic_cq_alloc_with_type(struct vnic_dev *vdev, struct vnic_cq *cq,
 			    unsigned int index, unsigned int desc_count,
 			    unsigned int desc_size, unsigned int res_type);
+#define VNIC_CQ_FC_ENABLE	1
+#define VNIC_CQ_FC_DISABLE	0
+#define VNIC_CQ_COLOR_ENABLE	1
+#define VNIC_CQ_INTR_ENABLE	1
+#define VNIC_CQ_INTR_DISABLE	0
+#define VNIC_CQ_ENTRY_ENABLE	1
+#define VNIC_CQ_MSG_ENABLE	1
+#define VNIC_CQ_MSG_DISABLE	0
+
 void vnic_cq_init(struct vnic_cq *cq, unsigned int flow_control_enable,
 	unsigned int color_enable, unsigned int cq_head, unsigned int cq_tail,
 	unsigned int cq_tail_color, unsigned int interrupt_enable,
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index 3b6efa743dba..90ca06691ebd 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -455,8 +455,19 @@ enum vnic_devcmd_cmd {
 	 */
 	CMD_CQ_ENTRY_SIZE_SET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 90),
 
+	/*
+	 * Set queue pair type (admin or data)
+	 * in: (u32) a0 = queue pair type (0 = admin, 1 = data)
+	 * in: (u32) a1 = enable (1) / disable (0)
+	 */
+	CMD_QP_TYPE_SET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 97),
 };
 
+#define QP_TYPE_ADMIN	0
+#define QP_TYPE_DATA	1
+#define QP_ENABLE	1
+#define QP_DISABLE	0
+
 /* CMD_ENABLE2 flags */
 #define CMD_ENABLE2_STANDBY 0x0
 #define CMD_ENABLE2_ACTIVE  0x1

-- 
2.43.0

