Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906237C907;
	Sun, 19 Jul 2026 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450607; cv=none; b=b6fxpMqUI6/pSzOVOdvmxmNTUoND4lokliGPw5xQURuBRJ2tR2FfsCUCcsGjBfAOeKcTeRPHExxZvYQdg8xOXZgvKsxPnSq7hIckQ2X8KdhPh2oeYo6W5Iijyi+hDHTFsuL8OXdUnchW5LEb6t0RRLdZKJJcb4qnvghIuUzFX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450607; c=relaxed/simple;
	bh=h679FWNX5JWhmI+AdkjjNzoyMT3GuJrF5NUktANDUZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhJQXDtiwFJcadF/IGrCyomG4LaNH8OEg3RSApK5R1oJIlINdYAYmMFiRMMMY4+0qeWNQCc/paIyy/DsrwC1CQ7z378fYGtVdef+5aHs9Q5NuC6IJ7nxcmcrOHHIptcfG8cafytn6JY8ju2b53s6EH1+HbHs4bDlwfaQyHgMg0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=VCDJmMov; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="VCDJmMov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11529; q=dns/txt;
  s=iport01; t=1784450598; x=1785660198;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=klUP5oBGUK0xklo5eiWu1C2QTKAqLmCED3ntsvsqB9I=;
  b=VCDJmMov0e570hixNmGZ2yY8oFA0vm1NhRjsuJXtQffQ7+onQPCDqMJT
   XCcQKjNmjPULHA1B9tVxpXHdjVXgEAu29R1ulSHOuDodUJnnVOYH2+ALM
   x+S7jbHPeoHosZ4ym1H5H4H5OV1+yStSlhWgvZOveqCwzGdFb86neHE5m
   CitC/EtCRlQTChmiLOdQZrnrtIRhGkRV3pAfMdLOr5Prby3q6cLz2O6yO
   /MR3YhfrrGY3qL2YWBfKgD/L/w6WGCwudNOgM79UWYLJwMMstEOmHKu6q
   PavIxEoCmV46ORT3rtVpT6jAJGvqORJ+Uy0qtoteKXa4dAfCKog7pyGLq
   w==;
X-CSE-ConnectionGUID: ZUKX7/UvR8SqFGdCSfH6SQ==
X-CSE-MsgGUID: 0il6axXPReaXyOpchkdOwA==
X-IPAS-Result: =?us-ascii?q?A0BHAgAEjVxq/5H/Ja1QCh4BAQsSDIIFC4JXgVJDSYRXj?=
 =?us-ascii?q?1KCIYEWnQgUgWoPAQEBD1EEAQGFBQKNUwImNAkOAQIEAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QELAQEFAQEBAgEHBYEOE4ZchlsCAQMjBAsBRhAlAiYCAkUBEAYBEoMCgnUDv?=
 =?us-ascii?q?Qt6fzOBAYR92UiBZgELFAGBCi6FcYJrAYFwhAc7hEEnG4FJRIEUAYJzdoQFA?=
 =?us-ascii?q?RAJC4N0gmoEgxwSgVggj3QJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCF?=
 =?us-ascii?q?BwTDwQWMh1wDCcSLBc0WBsHBYEdfxYEIYEChHYjHwM5f4EwdUp3LWkBEheBL?=
 =?us-ascii?q?4IUgToCBwMLGA1IESw3Bg4ZBD0BbgeNQCOBTmoHATwdIQkKARNoMw4jMAQxG?=
 =?us-ascii?q?SwXApZhjkqhD4QngWaMW5M0ATKXZ5MFmQgjo0kGaIRpgWg8gVkzGggbFYMiU?=
 =?us-ascii?q?xkPji0WHNIeJzI9AgcCBw4DC5FqDxcHgU8BAQ?=
IronPort-Data: A9a23:X776I6BA8Ti1axVW//Tiw5YqxClBgxIJ4kV8jS/XYbTApD1x12BWx
 mMbCGrQa/zcZWP0et0gOoqwo0oPu5WBz99jOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYAD8imYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE8chNPB5xAJMiqt1uL05C3
 scWCG42V0XW7w626OrTpuhEnM8vKozveYgYoHwllWGfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGYyBPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FEoieSwboCJI7RmQ+0Nn0LGr
 3L2x170CyELE8SUyTmJ1W2F07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc9ZSK
 lAd/QIioKIz/UrtScPyNzW1rGOBtwwRR/JfFOo17AzLwa3Riy6aG2INZj1MctorsIkxXzNC/
 laPk8nkGn9pvaGZRGy18qqSq3W5OUA9NWYIaCkFZREI79nqvMc4iRenZtJiFrOly974Azf9x
 xiUoyUkwbYel8gG0+O851+vqzShupTEUCYr6QjNGGGo9AV0YMiifYPA1LTAxexLIIDcShyKu
 2IJ3pDOqusPFpqK0ieKRY3hAY2U2hpMCxWE6XYHInXr323FF6KLFWyI3AxDGQ==
IronPort-HdrOrdr: A9a23:KHt8LqmuHxTrbY3hvDpLuqz/alvpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: 9a23:E4/FPW2//NJMjX9V1//vXLxfKP0GQiKa8Wnqc3ShJ0llY4abaQGrwfYx
X-Talos-MUID: 9a23:+ulwMwXbC6YfV1Xq/GftgG9rJPdQ2amnOFEqiZ4GuMWjKgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; 
   d="scan'208";a="511456241"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jul 2026 08:42:10 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id 52B9418000595;
	Sun, 19 Jul 2026 08:42:09 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 19 Jul 2026 01:41:51 -0700
Subject: [PATCH net-next v12 07/12] enic: add MBOX core send and receive
 for admin channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260719-enic-sriov-v2-admin-channel-v2-v12-7-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784450523; l=11981;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=h679FWNX5JWhmI+AdkjjNzoyMT3GuJrF5NUktANDUZI=;
 b=kuB/TA7/OHwRyHGb84bsHphmRQN0LQbI/XyHzqgrrZX1yFbN3YcH2sNWOCwFV2pD4s7aMMBUx
 FKNtd4DW+KkD8eXx1e6fyc2H8ldVcYXH29lx/mXMqytA2Alj/rKhy4i
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-08.cisco.com

Implement the mailbox protocol engine used for PF-VF communication
over the admin channel.

The send path (enic_mbox_send_msg) builds a message with a common
header, DMA-maps it, posts a single WQ descriptor with the
destination vnic ID encoded in the VLAN tag field, and polls
the WQ CQ for completion.

MBOX sends are gated by enic->mbox_send_disabled: enic_mbox_send_msg()
returns early while it is set.  It is set at the very start of both
enic_admin_channel_open() and enic_admin_channel_close(), and is
cleared in enic_admin_channel_open() only once the admin WQ/RQ/CQ and
interrupt are fully allocated, programmed and enabled.  Keeping it set
for the whole open sequence means an early failure that returns before
the channel is ready (as well as a not-yet-ready or torn-down channel)
leaves sends disabled, so a concurrent sender can never race an MBOX
send against a half-open or freed admin_wq.

The receive path (enic_mbox_recv_handler) is installed as the admin
RQ callback and validates incoming message headers. PF/VF-specific
dispatch will be added in subsequent commits.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile     |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h       |   6 +
 drivers/net/ethernet/cisco/enic/enic_admin.c |  42 ++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c  | 170 +++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h  |   8 ++
 5 files changed, 225 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/Makefile b/drivers/net/ethernet/cisco/enic/Makefile
index 7ae72fefc99a..e38aaf34c148 100644
--- a/drivers/net/ethernet/cisco/enic/Makefile
+++ b/drivers/net/ethernet/cisco/enic/Makefile
@@ -4,5 +4,5 @@ obj-$(CONFIG_ENIC) := enic.o
 enic-y := enic_main.o vnic_cq.o vnic_intr.o vnic_wq.o \
 	enic_res.o enic_dev.o enic_pp.o vnic_dev.o vnic_rq.o vnic_vic.o \
 	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o enic_wq.o \
-	enic_admin.o
+	enic_admin.o enic_mbox.o
 
diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 401123e6df1d..b009d87da4bd 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -297,6 +297,8 @@ struct enic {
 	 * left the resources freed.
 	 */
 	bool admin_chan_up;
+	/* set on send timeout; cleared on channel re-open */
+	bool mbox_send_disabled;
 	struct vnic_wq admin_wq;
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
@@ -309,6 +311,10 @@ struct enic {
 	unsigned int admin_msg_count;	/* current depth of admin_msg_list */
 	void (*admin_rq_handler)(struct enic *enic, void *buf,
 				 unsigned int len);
+
+	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
+	struct mutex mbox_lock;
+	u64 mbox_msg_num;
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 9358165263d9..3e7103f2afc1 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -19,6 +19,7 @@
 #include "cq_enet_desc.h"
 #include "wq_enet_desc.h"
 #include "rq_enet_desc.h"
+#include "enic_mbox.h"
 
 /* Clean up any admin WQ buffers still held by hardware at close time.
  * Normally buffers are freed inline after send completion, but a timed-out
@@ -213,7 +214,26 @@ unsigned int enic_admin_rq_cq_service(struct enic *enic)
 			goto next_desc;
 		}
 
-		enic_admin_msg_enqueue(enic, buf->os_buf, bytes_written);
+		if (enic->admin_rq_handler) {
+			u16 sender_vlan;
+
+			/* Firmware sets the CQ VLAN field to identify the
+			 * sender: 0 = PF, 1-based = VF index.  Overwrite
+			 * the untrusted src_vnic_id in the MBOX header with
+			 * the hardware-verified value.
+			 */
+			sender_vlan = le16_to_cpu(rq_desc->vlan);
+			if (bytes_written >= sizeof(struct enic_mbox_hdr)) {
+				struct enic_mbox_hdr *hdr = buf->os_buf;
+
+				hdr->src_vnic_id = (sender_vlan == 0) ?
+					cpu_to_le16(ENIC_MBOX_DST_PF) :
+					cpu_to_le16(sender_vlan - 1);
+			}
+
+			enic_admin_msg_enqueue(enic, buf->os_buf,
+					       bytes_written);
+		}
 
 next_desc:
 		enic_admin_rq_buf_clean(rq, rq->to_clean);
@@ -468,8 +488,9 @@ static void enic_admin_init_resources(struct enic *enic)
 		     VNIC_CQ_MSG_DISABLE,
 		     intr_offset,
 		     0 /* cq_message_addr */);
+	/* coalescing_timer, coalescing_type, mask_on_assertion */
 	vnic_intr_init(&enic->admin_intr,
-		       0, 0, 1); /* coalescing_timer, coalescing_type, mask_on_assertion */
+		       0, 0, 1);
 }
 
 static void enic_admin_msg_drain(struct enic *enic)
@@ -492,6 +513,13 @@ int enic_admin_channel_open(struct enic *enic)
 	if (!enic->has_admin_channel)
 		return -ENODEV;
 
+	/* Keep MBOX sends disabled for the entire open sequence.  It is
+	 * cleared only after every resource is allocated and enabled below,
+	 * so any early error return here leaves sends disabled and a
+	 * concurrent sender cannot touch a half-open or freed admin_wq.
+	 */
+	WRITE_ONCE(enic->mbox_send_disabled, true);
+
 	err = enic_admin_alloc_resources(enic);
 	if (err) {
 		netdev_err(enic->netdev,
@@ -534,6 +562,14 @@ int enic_admin_channel_open(struct enic *enic)
 
 	vnic_intr_unmask(&enic->admin_intr);
 
+	/* Only now that the admin WQ/RQ/CQ and interrupt are fully allocated,
+	 * programmed and enabled is it safe to allow MBOX sends.  Clearing this
+	 * earlier opened a window where a concurrent sender (e.g. link-notify
+	 * work scheduled by a post-reset link-up) could call enic_mbox_send_msg()
+	 * against a not-yet-allocated admin_wq and crash.
+	 */
+	WRITE_ONCE(enic->mbox_send_disabled, false);
+
 	netdev_dbg(enic->netdev,
 		   "admin channel open: intr=%u wq_avail=%u rq_avail=%u cq0_color=%u cq1_color=%u\n",
 		   enic->admin_intr_index,
@@ -575,6 +611,8 @@ void enic_admin_channel_close(struct enic *enic)
 	if (!enic->admin_chan_up)
 		return;
 
+	WRITE_ONCE(enic->mbox_send_disabled, true);
+
 	netdev_dbg(enic->netdev, "admin channel close\n");
 
 	vnic_intr_mask(&enic->admin_intr);
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
new file mode 100644
index 000000000000..3709704bee02
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2025 Cisco Systems, Inc.  All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+
+#include "vnic_dev.h"
+#include "vnic_wq.h"
+#include "vnic_cq.h"
+#include "enic.h"
+#include "enic_admin.h"
+#include "enic_mbox.h"
+#include "wq_enet_desc.h"
+
+#define ENIC_MBOX_POLL_TIMEOUT_US	5000000
+#define ENIC_MBOX_POLL_INTERVAL_US	100
+
+static void enic_mbox_fill_hdr(struct enic *enic, struct enic_mbox_hdr *hdr,
+			       u8 msg_type, u16 dst_vnic_id, u16 msg_len)
+{
+	memset(hdr, 0, sizeof(*hdr));
+	hdr->dst_vnic_id = cpu_to_le16(dst_vnic_id);
+	hdr->msg_type = msg_type;
+	hdr->msg_len = cpu_to_le16(msg_len);
+	hdr->msg_num = cpu_to_le64(++enic->mbox_msg_num);
+}
+
+int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
+		       void *payload, u16 payload_len)
+{
+	u16 total_len = sizeof(struct enic_mbox_hdr) + payload_len;
+	struct vnic_wq *wq = &enic->admin_wq;
+	struct wq_enet_desc *desc;
+	unsigned long timeout;
+	dma_addr_t dma_addr;
+	u16 vlan_tag;
+	void *buf;
+	int err;
+
+	/* Serialize MBOX sends. The admin channel is a low-frequency
+	 * control path; holding the mutex across the poll is acceptable.
+	 */
+	mutex_lock(&enic->mbox_lock);
+
+	if (!enic->has_admin_channel || READ_ONCE(enic->mbox_send_disabled)) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	if (vnic_wq_desc_avail(wq) == 0) {
+		err = -ENOSPC;
+		goto unlock;
+	}
+
+	buf = kmalloc(total_len, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	enic_mbox_fill_hdr(enic, buf, msg_type, dst_vnic_id, total_len);
+	if (payload_len) {
+		void *dst = buf + sizeof(struct enic_mbox_hdr);
+
+		memcpy(dst, payload, payload_len);
+	}
+
+	dma_addr = dma_map_single(&enic->pdev->dev, buf, total_len,
+				  DMA_TO_DEVICE);
+	if (dma_mapping_error(&enic->pdev->dev, dma_addr)) {
+		kfree(buf);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	/* Firmware uses vlan field for routing: 0 = PF, 1-based = VF index */
+	if (dst_vnic_id == ENIC_MBOX_DST_PF)
+		vlan_tag = 0;
+	else
+		vlan_tag = dst_vnic_id + 1;
+
+	desc = vnic_wq_next_desc(wq);
+	wq_enet_desc_enc(desc, (u64)dma_addr | VNIC_PADDR_TARGET,
+			 total_len,
+			 0, 0, 0,       /* mss, hdr_len, offload_mode */
+			 1, 1,          /* eop, cq_entry */
+			 0,             /* fcoe_encap */
+			 1, vlan_tag,   /* vlan_tag_insert, vlan_tag */
+			 0);            /* loopback */
+	vnic_wq_post(wq, buf, dma_addr, total_len,
+		     1, 1,              /* sop, eop */
+		     1, 1,              /* desc_skip_cnt, cq_entry */
+		     0, 0);             /* compressed_send, wrid */
+	vnic_wq_doorbell(wq);
+
+	timeout = jiffies + usecs_to_jiffies(ENIC_MBOX_POLL_TIMEOUT_US);
+	err = -ETIMEDOUT;
+	while (time_before(jiffies, timeout)) {
+		if (enic_admin_wq_cq_service(enic)) {
+			err = 0;
+			break;
+		}
+		usleep_range(ENIC_MBOX_POLL_INTERVAL_US,
+			     ENIC_MBOX_POLL_INTERVAL_US + 50);
+	}
+	/* Final check in case completion arrived during the last sleep */
+	if (err && enic_admin_wq_cq_service(enic))
+		err = 0;
+
+	if (!err) {
+		wq->to_clean = wq->to_clean->next;
+		wq->ring.desc_avail++;
+		dma_unmap_single(&enic->pdev->dev, dma_addr, total_len,
+				 DMA_TO_DEVICE);
+		kfree(buf);
+	} else {
+		netdev_err(enic->netdev,
+			   "MBOX send timed out (type %u dst %u), disabling channel\n",
+			   msg_type, dst_vnic_id);
+		/*
+		 * The WQ descriptor is still live in hardware. Do not unmap
+		 * or free the buffer: the device may still DMA from dma_addr.
+		 * Mark the channel unusable so no further sends are attempted.
+		 */
+		WRITE_ONCE(enic->mbox_send_disabled, true);
+	}
+
+	netdev_dbg(enic->netdev,
+		   "MBOX send msg_type %u dst %u vlan %u err %d\n",
+		   msg_type, dst_vnic_id, vlan_tag, err);
+unlock:
+	mutex_unlock(&enic->mbox_lock);
+	return err;
+}
+
+static void enic_mbox_recv_handler(struct enic *enic, void *buf,
+				   unsigned int len)
+{
+	struct enic_mbox_hdr *hdr = buf;
+
+	if (len < sizeof(*hdr)) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: truncated message (len %u < %zu)\n",
+				    len, sizeof(*hdr));
+		return;
+	}
+
+	if (hdr->msg_type >= ENIC_MBOX_MAX) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: unknown msg type %u\n",
+				    hdr->msg_type);
+		return;
+	}
+
+	netdev_dbg(enic->netdev,
+		   "MBOX recv: type %u from vnic %u len %u\n",
+		   hdr->msg_type, le16_to_cpu(hdr->src_vnic_id),
+		   le16_to_cpu(hdr->msg_len));
+}
+
+void enic_mbox_init(struct enic *enic)
+{
+	enic->mbox_msg_num = 0;
+	mutex_init(&enic->mbox_lock);
+	enic->admin_rq_handler = enic_mbox_recv_handler;
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index a52f1d25cb21..73fd7f783ee2 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -80,4 +80,12 @@ struct enic_mbox_pf_link_state_ack_msg {
 	struct enic_mbox_generic_reply ack;
 };
 
+#define ENIC_MBOX_DST_PF	0xFFFF
+
+struct enic;
+
+void enic_mbox_init(struct enic *enic);
+int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
+		       void *payload, u16 payload_len);
+
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0

