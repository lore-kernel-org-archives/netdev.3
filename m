Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5054037268D;
	Sun, 19 Jul 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450631; cv=none; b=Eu8yA1wwbdPxK7gQvQPF2aKs0S6xD+c8KJ5IrQtuZscFkhbyDAihHo3ayKGdRoTb8+mgs8mPqrZnK7N8lv42lCvnnjeEXAZcTQBx3zenoyN9InmErR6aZDWX2nAVvX8X7e1vDxIztDb6npmjDPQmUtOs5/5lH2y+bwfej3TYAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450631; c=relaxed/simple;
	bh=DpeyC/QKzuqGDLhmM459SNgSjk8jVLI5AEWQcRFITRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpAYJHCL2nn5PIK5hNztIMeclB2I9rfSomZcobkop3tQrsYwDcHrizQ3ICPK5t5/u7VYaV/mhubohV6uZuuhCyTG0XUs1u9guKsNSDdckxTNr9pAb2fnFX75oM93lR2f1lkRrqrpysPGSQFrzVsZToJCprfyT0GS9VUuHp7eo/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=HUset5S5; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="HUset5S5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=16063; q=dns/txt;
  s=iport01; t=1784450615; x=1785660215;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=u5iMhBaCmpfHDvxcs9EMzRkm97Zdus8V2phYi33ryn8=;
  b=HUset5S5IYCDA1mG8MGTxzOv6QfWLD9NOqqjkGUgv2eRcMCdzm1DIBBN
   DRiwqzyu6PBw8RB963oGpZ4LLZ20GVeBZvd9sOflLjohfXDNc5fl/WA3B
   9jnILhtl+mkU1PXLAAhB8nGSpJxSDjBuCPuXXqQWWyY8fJSeuKDp99k1b
   mcA19WdcXa08BUW9cCs7LrGORWsXvZB32BkyhaJkWdkC3KU8Q0u92FHD9
   KC0x7i687e1MMp+VrHvHAsi8U6QM/M3VUn7Yu5viWXYhkgmDSaFYPyHtw
   foWdN2qRN/sszT3OB1AUlpAy9F/f5I1XgLIPgLLm+qDXNgHoFqiOLcWcp
   w==;
X-CSE-ConnectionGUID: OQcqZKFQTcGIGBgq7R7hlw==
X-CSE-MsgGUID: s4Up05r0SNSWnLMP6XK28A==
X-IPAS-Result: =?us-ascii?q?A0ADAACSjVxq/5H/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgXwFAQEBAQsBglaBUkNJhFeIG4c3giGBFpA3jFGBfg8BAQEPU?=
 =?us-ascii?q?QQBAYUFAo1TAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Th?=
 =?us-ascii?q?lyGWwIBAyMEQBIQJQImAgJGEAYBEoMCgnUDvHl6fzOBAd5FgWYBCxQBgQouA?=
 =?us-ascii?q?YVwgmsBgXCEBzuEQScbgUlEgRQBgnN2hBqEBIJqBIIiehKDdX2Megk/gQIcA?=
 =?us-ascii?q?1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIULw8EFjIdcAwnEiwXNFgbBwWBHX8WB?=
 =?us-ascii?q?CGBAoR2Ix8DOX+BMHVKdy1pARIXgS+CFIE6AgcDCxgNSBEsNwYOGQQ9AW4Hj?=
 =?us-ascii?q?UAjgU5xATwcGwcUCnA2DFcdFBkcKQOSYBsCg2GMKYE2a4E1gRmIJZYchCeBZ?=
 =?us-ascii?q?qAPATKEBJNjNJJRmQgjo2cBGDeEaYFoPIFZMxoIGxU7gmdTGQ+Id4UzAxYc0?=
 =?us-ascii?q?h4nMj0CBwIHDgMLkWgEgXoBAQ?=
IronPort-Data: A9a23:S2et6KsVwulV/IvlkCkTUkkfmOfnVItfMUV32f8akzHdYApBsoF/q
 tZmKWHUPP3cZDH8eogja4u/9RxX6JbWnNZmSwpsqXpnQyoXgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZTdJ5xYuajhKs/3a+Us21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw3d98GFNt2
 8UkIx8sQTqMnr2Mn7K/Vbw57igjBJGD0II3oHpsy3TdSP0hW52GG/WM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtKYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUoHTH54IzxrJ+
 Qoq+UziXiwCbIGFkQGjyU2qosr3wxPYAtI7QejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaw/9VCiSfHxUhe5qXjCuQQTM/JdH/A/4ROA1oLb5AGWAmVCRTlEAPQlqcU/bT8nz
 FmEm5XuHzMHmLSTRWiQ6fSSoC++NDY9KXIEY2kPTWMt+9DprYcypgjCQtZqDOi+ididMTXxx
 S2a6SsznbMeieYV2Kihu1PKmTShot7OVAFdzgPaQm6o8Ctna4O/IY+l817W6bBHNonxc7Wal
 GIPl87b6KUFCouA0XTdBu4MB7quof2CNVUwnGJSInXozBz1k1bLQGyayGsWyJtBWircRQLUX
 Q==
IronPort-HdrOrdr: A9a23:45EBy6FFeXw7b93gpLqEHseALOsnbusQ8zAXPo5KOHhom6uj9v
 xG/c506faaslsssR0b8+xofZPwI080lqQb3WBuB9eftWDd0QPCEGgh1/qA/9SKIUHDH4BmpM
 JdWpk7JdHuAV19lMrgpCu1A78bsaC62ZHtqOvAw3JqVA1wL5th4QBwFxqBHiRNNW977OICZf
 2hz/sCgSa8cnIKacn+LHwEU+/f4+DvrvvdEGY779pN0nj1sdtug4SKaCSl4g==
X-Talos-CUID: =?us-ascii?q?9a23=3AL1MUQGkhW+F+X4Actz3fQVJao2HXOVrkx27iAGG?=
 =?us-ascii?q?BNW1GaZK/RkbPwvxkl9U7zg=3D=3D?=
X-Talos-MUID: 9a23:LdlyAQTm9IdP4EvVRXT32Ax6bJpyu5+IM38LtbA+5fmnb3xZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; 
   d="scan'208";a="512359497"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jul 2026 08:42:08 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id C17EB180005B7;
	Sun, 19 Jul 2026 08:42:07 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 19 Jul 2026 01:41:49 -0700
Subject: [PATCH net-next v12 05/12] enic: add admin CQ service with MSI-X
 interrupt and workqueue polling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-enic-sriov-v2-admin-channel-v2-v12-5-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784450523; l=16555;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=DpeyC/QKzuqGDLhmM459SNgSjk8jVLI5AEWQcRFITRY=;
 b=dO+a7+uUrf3eQ6oCHq8Kkutt2PC6haKwdYNOl/L0KKbV+H2eMDu8HihhEaVVc8IEgPoApR/W2
 PzB2J7O86ofBGPuDnwOSi+wX0BZOfYU+UHgmIz+HTmp0QZqhUgaanI6
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-08.cisco.com

Add completion queue (CQ) service for the admin channel work queue
(WQ) and receive queue (RQ), driven by a dedicated MSI-X interrupt
and a workqueue-based CQ poller.

The admin WQ CQ service advances the completion ring and returns the
number of descriptors consumed.  The admin RQ CQ service does the
same for receive completions and copies each received message into a
preallocated buffer.  Received messages are enqueued for deferred
dispatch by a separate work_struct so the CQ poller stays short.

When the MSI-X interrupt fires, the ISR schedules the CQ poll
work_struct.  The work handler drains all pending completions, kicks
message dispatch if work was done, and returns credits to unmask the
interrupt.

The poll handler snapshots the pending credit count before draining
the CQ so it acknowledges exactly what the hardware reported for this
interrupt; any credits that accrue during draining are serviced by the
next interrupt.  At least one credit is returned so the write always
carries a non-zero acknowledgment and re-arms the vector, since the
admin channel is not re-polled like the NAPI data path.

Log a rate-limited warning when admin RQ buffer refill fails so that
transient memory pressure is visible without flooding the log.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |   8 +
 drivers/net/ethernet/cisco/enic/enic_admin.c | 323 ++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_admin.h |  12 +
 3 files changed, 339 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 398227448b37..401123e6df1d 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -301,6 +301,14 @@ struct enic {
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
 	struct vnic_intr admin_intr;
+	struct work_struct admin_poll_work;
+	unsigned int admin_intr_index;
+	struct work_struct admin_msg_work;
+	spinlock_t admin_msg_lock;	/* protects admin_msg_list */
+	struct list_head admin_msg_list;
+	unsigned int admin_msg_count;	/* current depth of admin_msg_list */
+	void (*admin_rq_handler)(struct enic *enic, void *buf,
+				 unsigned int len);
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index b2be42092106..9358165263d9 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -15,6 +16,7 @@
 #include "enic.h"
 #include "enic_admin.h"
 #include "cq_desc.h"
+#include "cq_enet_desc.h"
 #include "wq_enet_desc.h"
 #include "rq_enet_desc.h"
 
@@ -94,6 +96,266 @@ static void enic_admin_rq_drain(struct enic *enic)
 	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
 }
 
+static unsigned int enic_admin_cq_color(void *cq_desc, unsigned int desc_size)
+{
+	u8 type_color = *((u8 *)cq_desc + desc_size - 1);
+
+	return (type_color >> CQ_DESC_COLOR_SHIFT) & CQ_DESC_COLOR_MASK;
+}
+
+unsigned int enic_admin_wq_cq_service(struct enic *enic)
+{
+	struct vnic_cq *cq = &enic->admin_cq[0];
+	unsigned int work = 0;
+	void *desc;
+
+	desc = vnic_cq_to_clean(cq);
+	while (enic_admin_cq_color(desc, cq->ring.desc_size) !=
+	       cq->last_color) {
+		vnic_cq_inc_to_clean(cq);
+		work++;
+		desc = vnic_cq_to_clean(cq);
+	}
+
+	return work;
+}
+
+/* Upper bound on pending admin messages.  A buggy or hostile VF could flood
+ * the PF admin channel faster than admin_msg_work drains it; cap the backlog
+ * so a guest cannot drive the host out of memory.
+ */
+#define ENIC_ADMIN_MSG_MAX	256
+
+static void enic_admin_msg_enqueue(struct enic *enic, void *buf,
+				   unsigned int len)
+{
+	struct enic_admin_msg *msg;
+
+	msg = kmalloc(struct_size(msg, data, len), GFP_KERNEL);
+	if (!msg)
+		return;
+
+	msg->len = len;
+	memcpy(msg->data, buf, len);
+
+	spin_lock(&enic->admin_msg_lock);
+	if (enic->admin_msg_count >= ENIC_ADMIN_MSG_MAX) {
+		spin_unlock(&enic->admin_msg_lock);
+		kfree(msg);
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "admin msg backlog full (%u); dropping\n",
+				    ENIC_ADMIN_MSG_MAX);
+		return;
+	}
+	list_add_tail(&msg->list, &enic->admin_msg_list);
+	enic->admin_msg_count++;
+	spin_unlock(&enic->admin_msg_lock);
+}
+
+unsigned int enic_admin_rq_cq_service(struct enic *enic)
+{
+	struct vnic_cq *cq = &enic->admin_cq[1];
+	struct vnic_rq *rq = &enic->admin_rq;
+	struct cq_enet_rq_desc *rq_desc;
+	struct vnic_rq_buf *buf;
+	u16 bwf, bytes_written;
+	unsigned int work = 0;
+	void *desc;
+
+	/* The admin RQ and its CQ form a single in-order channel: firmware
+	 * posts exactly one CQE per consumed RQ descriptor, in submission
+	 * order.  Each CQE therefore pairs with rq->to_clean below without a
+	 * completed_index cross-check, mirroring the in-order assumption of
+	 * the main enic RX path.
+	 */
+	desc = vnic_cq_to_clean(cq);
+	while (enic_admin_cq_color(desc, cq->ring.desc_size) !=
+	       cq->last_color) {
+		/* Ensure DMA descriptor fields are read after
+		 * the color/valid check.  dma_rmb() is the
+		 * correct barrier for DMA-written descriptors.
+		 */
+		dma_rmb();
+		buf = rq->to_clean;
+
+		/* Decode the actual number of bytes hardware wrote into
+		 * the RX buffer.  buf->len is the static allocation size
+		 * (ENIC_ADMIN_BUF_SIZE) and would expose uninitialised
+		 * heap memory beyond the real payload.  bytes_written_flags
+		 * is at the same offset in every cq_enet_rq_desc[_32|_64]
+		 * variant.
+		 */
+		rq_desc = desc;
+		bwf = le16_to_cpu(rq_desc->bytes_written_flags);
+		bytes_written = bwf & CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK;
+		if (bytes_written > buf->len)
+			goto next_desc;
+
+		dma_sync_single_for_cpu(&enic->pdev->dev,
+					buf->dma_addr, buf->len,
+					DMA_FROM_DEVICE);
+
+		/* Drop on hardware error indications.  Admin messages
+		 * are internal to the VIC, not received over the wire.
+		 * Firmware sets TRUNCATED when the message does not fit
+		 * in the posted buffer, and FCS_OK is always set on
+		 * healthy admin completions.
+		 */
+		if (bwf & CQ_ENET_RQ_DESC_FLAGS_TRUNCATED) {
+			netdev_warn_once(enic->netdev,
+					 "admin RQ: truncated message dropped\n");
+			goto next_desc;
+		}
+		if (!(rq_desc->flags & CQ_ENET_RQ_DESC_FLAGS_FCS_OK)) {
+			netdev_warn_once(enic->netdev,
+					 "admin RQ: bad FCS, dropping message\n");
+			goto next_desc;
+		}
+
+		enic_admin_msg_enqueue(enic, buf->os_buf, bytes_written);
+
+next_desc:
+		enic_admin_rq_buf_clean(rq, rq->to_clean);
+		rq->to_clean = rq->to_clean->next;
+		rq->ring.desc_avail++;
+
+		vnic_cq_inc_to_clean(cq);
+		work++;
+		desc = vnic_cq_to_clean(cq);
+	}
+
+	if (enic_admin_rq_fill(enic, GFP_KERNEL) && net_ratelimit())
+		netdev_warn(enic->netdev,
+			    "admin RQ refill failed\n");
+
+	return work;
+}
+
+static irqreturn_t enic_admin_isr_msix(int irq, void *data)
+{
+	struct enic *enic = data;
+
+	schedule_work(&enic->admin_poll_work);
+
+	return IRQ_HANDLED;
+}
+
+static void enic_admin_msg_work_handler(struct work_struct *work)
+{
+	struct enic *enic = container_of(work, struct enic, admin_msg_work);
+	struct enic_admin_msg *msg, *tmp;
+	LIST_HEAD(local_list);
+
+	spin_lock_bh(&enic->admin_msg_lock);
+	list_splice_init(&enic->admin_msg_list, &local_list);
+	enic->admin_msg_count = 0;
+	spin_unlock_bh(&enic->admin_msg_lock);
+
+	list_for_each_entry_safe(msg, tmp, &local_list, list) {
+		if (enic->admin_rq_handler)
+			enic->admin_rq_handler(enic, msg->data, msg->len);
+		list_del(&msg->list);
+		kfree(msg);
+	}
+}
+
+static void enic_admin_poll_work_handler(struct work_struct *work)
+{
+	struct enic *enic = container_of(work, struct enic, admin_poll_work);
+	unsigned int credits;
+	unsigned int rq_work;
+
+	/* Snapshot the pending credit count before draining so we acknowledge
+	 * exactly what the hardware reported for this interrupt.  Credits that
+	 * accrue while enic_admin_rq_cq_service() runs are left for the next
+	 * interrupt, which is harmless on this low-rate control path.
+	 */
+	credits = vnic_intr_credits(&enic->admin_intr);
+
+	rq_work = enic_admin_rq_cq_service(enic);
+
+	if (rq_work > 0)
+		schedule_work(&enic->admin_msg_work);
+
+	/* Acknowledge the snapshotted credits and unmask the vector.  Unlike
+	 * the NAPI data path, the admin channel is not re-polled, so the vector
+	 * must be re-armed here to receive the next completion.  The unmask is
+	 * applied through the interrupt mask register independently of the
+	 * credit count, so returning zero credits on a spurious wakeup still
+	 * re-arms the vector.
+	 */
+	vnic_intr_return_credits(&enic->admin_intr,
+				 credits,
+				 1 /* unmask */, 0);
+}
+
+static int enic_admin_setup_intr(struct enic *enic)
+{
+	unsigned int intr_index = enic->intr_count;
+	int err;
+
+	if (vnic_dev_get_intr_mode(enic->vdev) != VNIC_DEV_INTR_MODE_MSIX ||
+	    intr_index >= enic->intr_avail)
+		return -ENODEV;
+
+	/* The admin INTR uses a slot in the same RES_TYPE_INTR_CTRL
+	 * strided array of per-vector control blocks (mask, coalescing
+	 * timer, credit return) that the data-path IRQs occupy in BAR0.
+	 * vnic_intr_alloc() defaults to RES_TYPE_INTR_CTRL, which is what
+	 * we want here.
+	 */
+	err = vnic_intr_alloc(enic->vdev, &enic->admin_intr, intr_index);
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "Failed to alloc admin intr at index %u: %d\n",
+			    intr_index, err);
+		return err;
+	}
+
+	enic->admin_intr_index = intr_index;
+
+	/* A V2 VF opens the admin channel during probe, before
+	 * register_netdev() resolves the "eth%d" name template, so using
+	 * netdev->name here would register the literal "eth%d-admin" in
+	 * /proc/interrupts.  Use the already-stable PCI device name instead.
+	 */
+	snprintf(enic->msix[intr_index].devname,
+		 sizeof(enic->msix[intr_index].devname),
+		 "%s-admin", pci_name(enic->pdev));
+	enic->msix[intr_index].isr = enic_admin_isr_msix;
+	enic->msix[intr_index].devid = enic;
+
+	err = request_irq(enic->msix_entry[intr_index].vector,
+			  enic->msix[intr_index].isr, 0,
+			  enic->msix[intr_index].devname,
+			  enic->msix[intr_index].devid);
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "Failed to request admin MSI-X irq: %d\n", err);
+		vnic_intr_free(&enic->admin_intr);
+		return err;
+	}
+
+	enic->msix[intr_index].requested = 1;
+
+	netdev_dbg(enic->netdev,
+		   "admin channel using MSI-X interrupt (index %u)\n",
+		   intr_index);
+
+	return 0;
+}
+
+static void enic_admin_teardown_intr(struct enic *enic)
+{
+	unsigned int intr_index = enic->admin_intr_index;
+
+	free_irq(enic->msix_entry[intr_index].vector,
+		 enic->msix[intr_index].devid);
+	cancel_work_sync(&enic->admin_poll_work);
+	enic->msix[intr_index].requested = 0;
+}
+
 static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
 {
 	u64 a0 = QP_TYPE_ADMIN, a1 = enable;
@@ -173,6 +435,7 @@ static int enic_admin_alloc_resources(struct enic *enic)
 
 static void enic_admin_free_resources(struct enic *enic)
 {
+	vnic_intr_free(&enic->admin_intr);
 	vnic_cq_free(&enic->admin_cq[1]);
 	vnic_cq_free(&enic->admin_cq[0]);
 	vnic_rq_free(&enic->admin_rq);
@@ -181,6 +444,8 @@ static void enic_admin_free_resources(struct enic *enic)
 
 static void enic_admin_init_resources(struct enic *enic)
 {
+	unsigned int intr_offset = enic->admin_intr_index;
+
 	vnic_wq_init(&enic->admin_wq,
 		     0, 0, 0); /* cq_index, err_intr_enable, err_intr_offset */
 	vnic_rq_init(&enic->admin_rq,
@@ -189,20 +454,35 @@ static void enic_admin_init_resources(struct enic *enic)
 		     VNIC_CQ_FC_DISABLE,
 		     VNIC_CQ_COLOR_ENABLE,
 		     0, 0, 1, /* cq_head, cq_tail, cq_tail_color */
-		     VNIC_CQ_INTR_DISABLE,
+		     VNIC_CQ_INTR_DISABLE, /* polled synchronously by mbox send */
 		     VNIC_CQ_ENTRY_ENABLE,
 		     VNIC_CQ_MSG_DISABLE,
-		     0, /* interrupt_offset */
+		     intr_offset,
 		     0 /* cq_message_addr */);
 	vnic_cq_init(&enic->admin_cq[1],
 		     VNIC_CQ_FC_DISABLE,
 		     VNIC_CQ_COLOR_ENABLE,
 		     0, 0, 1, /* cq_head, cq_tail, cq_tail_color */
-		     VNIC_CQ_INTR_DISABLE,
+		     VNIC_CQ_INTR_ENABLE,
 		     VNIC_CQ_ENTRY_ENABLE,
 		     VNIC_CQ_MSG_DISABLE,
-		     0, /* interrupt_offset */
+		     intr_offset,
 		     0 /* cq_message_addr */);
+	vnic_intr_init(&enic->admin_intr,
+		       0, 0, 1); /* coalescing_timer, coalescing_type, mask_on_assertion */
+}
+
+static void enic_admin_msg_drain(struct enic *enic)
+{
+	struct enic_admin_msg *msg, *tmp;
+
+	spin_lock_bh(&enic->admin_msg_lock);
+	list_for_each_entry_safe(msg, tmp, &enic->admin_msg_list, list) {
+		list_del(&msg->list);
+		kfree(msg);
+	}
+	enic->admin_msg_count = 0;
+	spin_unlock_bh(&enic->admin_msg_lock);
 }
 
 int enic_admin_channel_open(struct enic *enic)
@@ -220,6 +500,19 @@ int enic_admin_channel_open(struct enic *enic)
 		return err;
 	}
 
+	spin_lock_init(&enic->admin_msg_lock);
+	INIT_LIST_HEAD(&enic->admin_msg_list);
+	INIT_WORK(&enic->admin_msg_work, enic_admin_msg_work_handler);
+	INIT_WORK(&enic->admin_poll_work, enic_admin_poll_work_handler);
+
+	err = enic_admin_setup_intr(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Admin channel requires MSI-X, SR-IOV unavailable: %d\n",
+			   err);
+		goto free_resources;
+	}
+
 	enic_admin_init_resources(enic);
 
 	vnic_wq_enable(&enic->admin_wq);
@@ -239,17 +532,31 @@ int enic_admin_channel_open(struct enic *enic)
 		goto disable_queues;
 	}
 
+	vnic_intr_unmask(&enic->admin_intr);
+
+	netdev_dbg(enic->netdev,
+		   "admin channel open: intr=%u wq_avail=%u rq_avail=%u cq0_color=%u cq1_color=%u\n",
+		   enic->admin_intr_index,
+		   vnic_wq_desc_avail(&enic->admin_wq),
+		   vnic_rq_desc_avail(&enic->admin_rq),
+		   enic->admin_cq[0].last_color,
+		   enic->admin_cq[1].last_color);
+
 	enic->admin_chan_up = true;
 
 	return 0;
 
 disable_queues:
+	enic_admin_teardown_intr(enic);
 	enic_admin_qp_type_set(enic, QP_DISABLE);
 	if (vnic_wq_disable(&enic->admin_wq))
 		netdev_warn(enic->netdev, "Failed to disable admin WQ\n");
 	if (vnic_rq_disable(&enic->admin_rq))
 		netdev_warn(enic->netdev, "Failed to disable admin RQ\n");
+	cancel_work_sync(&enic->admin_msg_work);
+	enic_admin_msg_drain(enic);
 	enic_admin_rq_drain(enic);
+free_resources:
 	enic_admin_free_resources(enic);
 	return err;
 }
@@ -268,6 +575,13 @@ void enic_admin_channel_close(struct enic *enic)
 	if (!enic->admin_chan_up)
 		return;
 
+	netdev_dbg(enic->netdev, "admin channel close\n");
+
+	vnic_intr_mask(&enic->admin_intr);
+	enic_admin_teardown_intr(enic);
+	cancel_work_sync(&enic->admin_msg_work);
+	enic_admin_msg_drain(enic);
+
 	enic_admin_qp_type_set(enic, QP_DISABLE);
 
 	err = vnic_wq_disable(&enic->admin_wq);
@@ -283,6 +597,7 @@ void enic_admin_channel_close(struct enic *enic)
 	enic_admin_rq_drain(enic);
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
+	vnic_intr_clean(&enic->admin_intr);
 	enic_admin_free_resources(enic);
 
 	enic->admin_chan_up = false;
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.h b/drivers/net/ethernet/cisco/enic/enic_admin.h
index 569aadeb9312..62c80220b0ca 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.h
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.h
@@ -9,7 +9,19 @@
 
 struct enic;
 
+/* Wrapper for received admin messages queued for deferred processing.
+ * The admin CQ poll work handler enqueues these; a separate work handler
+ * processes them where sleeping (mutex, GFP_KERNEL) is safe.
+ */
+struct enic_admin_msg {
+	struct list_head list;
+	unsigned int len;
+	u8 data[] __aligned(8);
+};
+
 int enic_admin_channel_open(struct enic *enic);
 void enic_admin_channel_close(struct enic *enic);
+unsigned int enic_admin_wq_cq_service(struct enic *enic);
+unsigned int enic_admin_rq_cq_service(struct enic *enic);
 
 #endif /* _ENIC_ADMIN_H_ */

-- 
2.43.0

