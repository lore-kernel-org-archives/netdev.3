Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC532B99F;
	Sun, 19 Jul 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450721; cv=none; b=t33N5N49e6MkihEXni6KTth+Q++ahRWIJXwkcglZH8cXhT3fo2cy0lVdbVStkLcNgctiezepPdlbupUUGoASXFL70D5UhuFoNbhQsZsLSR0u4eAfRqdMSW34pi31Azf2rnkvgwDs/iN8BefkLREQIGpqKd51cINKJuDOeAxlaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450721; c=relaxed/simple;
	bh=CNyyNpBKXvdWxQ+JKqXEuJWhIy34HxDBjCH+Kpt0yts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atcNo5U/sROGzRZn4ogXkO8RMCpV6luM2gKZA4qv8afi40ib6EsMHIbrAIMdUW3nviDNQerCGovwr/AQKmhkUfZs7tte6v30jkmtWS/KMmm/s3K+f+RJ7aEXoMxZX8e656YxRkCZfo386mFJNzji/TbGbJvQO8oTKoy6qtVk37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Bl9oV5Ek; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="Bl9oV5Ek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11545; q=dns/txt;
  s=iport01; t=1784450718; x=1785660318;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Sorf0jTZuFVvTbMwN7h92xT9arsCuGLeYoqT+B2G15s=;
  b=Bl9oV5EkK8s8CjA+gdf3SMCvled+n+1w7iDIlnZIhoAbSMy4vY1HMcRs
   8JsaVpYzpLLSTeOSPC//K/P32ypRIyNPqKUa+gfmtLCX4Rb1AkgShWdWt
   HKZl8TROUKyefjHxRH20svzqp/CID8iNN0gYYBSpa+S+Hz835JMdgcOte
   HL/OYXP47ZK9gRwmdYlRNaZppjZd+1aH/EuVfQOPxYfxhWptie/T5u7IH
   8k4SJmcA5tXYWPBfMBWDOBsfD7ys1MD3UYd1IkroJH1k2prK06miLoCQ7
   X1XE+2PsG+xZ27myDxOjrJn0ZjrFnJrQFMkoi0HlUDWJrIyI4imWzdInx
   g==;
X-CSE-ConnectionGUID: 1SmOphp+T16gD0/a33vQng==
X-CSE-MsgGUID: 0Woiw2zASuOcK2VPwI8g9Q==
X-IPAS-Result: =?us-ascii?q?A0CrAAAEjVxq/5H/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBTgRDSYRXiBuHN4Ihnh4UgWoPAQEBD1EEAQGFBQKNUwImNAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBE?=
 =?us-ascii?q?oMCgnUDvQt6fzOBAYR92UiBZgELFAGBCi4BhXCCawGBcIQHO4RBJxuBSUSBF?=
 =?us-ascii?q?AGDaYQFAQQVC4N0gmoEgxwSgXiPdAk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLE?=
 =?us-ascii?q?hIYFQIULw8EFjIdcAwnEiwXNFgbBwWBHX8WBCGBAoR2Ix8DOX+BMHVKdy1pA?=
 =?us-ascii?q?RIXgS+CFIE6AgcDCxgNSBEsNwYOGQQ9AW4HjUAjgTcXcVk1AU1vgSEcLJJgC?=
 =?us-ascii?q?IN2jV9rgTWfWoQngWagDwEyl2eTBZkII6NJboRpgWg8gVkzGggbFYMiUxkPj?=
 =?us-ascii?q?ioDFtI6JzI9AgcCBw4DC5FoEReBVgEB?=
IronPort-Data: A9a23:35FFd6KsYo3ONrwRFE+RDJQlxSXFcZb7ZxGr2PjKsXjdYENS1GcEn
 zEdXm2AbquKYmCjfox3bd+y90tT7ZaHnIdnHVEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnQ0
 T/Oi5eHYgH9hGclajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN03N0QRJY0AudouX25ir
 bsRc2sTVxaM0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBXbAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEmojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZjeG3aICIK4bVLSlTth6no
 WPZpXbQOQw9P//F9wKa0yKj19aayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3L
 0EV5iMphaQ//k2iSJ/6RRLQiHOIoxsVSddMO+I97w6Jx+zf5APxLmsZRDdpa9E8ssIyAzsw2
 TehltXlHzFw87uYVX6Q6J+QsDW0fyMVRUcabCUJSwot+dTvoIgvyBnIS75LFK+zk82wGjzqx
 T2OhDYxiq9VjsMR0ai/u1fdjFqEoJXVQgMrzhvYU3jj7Q5jYoOhIYuy5jDmAe1oNo2VSByF+
 XMDgcXbtLBIBpCWnyvLS+IIdF2028u43PTnqQYHN/EcG/6FoRZPoag4DOlCGXpU
IronPort-HdrOrdr: A9a23:lPgDEK1PDDyhE6ZceuRv+AqjBEQkLtp133Aq2lEZdPWaSL39qy
 nIppUmPH7P5gr5N0tMpTntAsO9qDbnhPxICOoqUotKIjOHhILAFugLhrcKgQeQeBEWndQw6U
 4PSdkaNPTASXV3ksr+5hC1CJIDzMnvytHQuc7ui1pgUg1ubbht9ENCCgidGlBrXwUuP+teKH
 Pl3LshmxOQPVIKc8+8Gn4JG8LHp9HNidbaRCRuPW9e1OFL5gnYkoIT1HOjr2wjbw8=
X-Talos-CUID: 9a23:E4MXcm0+fqRK0jl9XjCw2LxfQ/sgVWXd1DTsehG3JT4uQebOV2aW9/Yx
X-Talos-MUID: 9a23:UtXzjwidTeRJG489h1lgfMMpbPhv4rv0Gmk2jLINmJO6DTNRazjMtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; 
   d="scan'208";a="512025927"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jul 2026 08:42:07 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id 398AF180005B7;
	Sun, 19 Jul 2026 08:42:06 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 19 Jul 2026 01:41:47 -0700
Subject: [PATCH net-next v12 03/12] enic: add admin channel open and close
 for SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-enic-sriov-v2-admin-channel-v2-v12-3-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784450523; l=11940;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=CNyyNpBKXvdWxQ+JKqXEuJWhIy34HxDBjCH+Kpt0yts=;
 b=4pRiEpZftbK4bwa2nsnKgl0SiDqpr6hhZdpvsyaceBnaA0lflru/RrEN/rHf+7hWb/+mvl9Aq
 2oOYTQ8DUP3BWcmvX8Syi3HJBkN+5bnEY377mC0oJEZnbj8T7MFRt/d
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-08.cisco.com

The V2 SR-IOV design uses a dedicated admin channel (WQ/RQ/CQ/INTR
on separate BAR resources) for PF-VF mailbox communication rather
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

