Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49C43F0A6;
	Wed, 12 Aug 2026 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539005; cv=none; b=pz/LBkgIoQh+dLHD5JsQuNuooDqi6vNTcUdlH5osLM7v2xA1/Zc1vwbyBEoFsB4Wt8J1/49qv9XQnGcvG5zSXDzlc037HW7jBfvL7Sb6CuXxCji/JybCCuTngjbRUddUWnXmndPDAYNlWe26TtmDxjAb3vb6zh823aXB0450aNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539005; c=relaxed/simple;
	bh=eneO6A7qeEO9gz/pxpyQex+tyhFxzcTcoo+gsh71FVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sURZAoiWljS0hbWHo8dGjYWehZgD39Y8pLit82wIPHWTee/qUDQNyQtjajNXu/oSUkpveoo0rjHV5is8/FG1AZboVO9EcgxhxtDNcytHkHnTONnj7Xvn/9U8k+hvBwCS5b/aCBlUbmKf/wI04UEQoQCm5F53pbN7KGFktse59/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=O0m0OfU9; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="O0m0OfU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=18101; q=dns/txt;
  s=iport01; t=1786539000; x=1787748600;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DEAQ+LgUKYuSzU0grklcoNBzWFzXC3FUuNYbl11lpag=;
  b=O0m0OfU9q24Em6NqsFOEPlgdWI4vCPs94QlAQk3LBYUZn2+vqK/pyWp1
   4giSqUqwkXQawsnChxXfh0Fnrjd/TguRUFJB/h4b3gOqDik9IIM7xdjLa
   sxCIw1P4L6lj3O7lsPBerJkHH8C7y6e9QYgx0kGAZHhcGHwqw4I7iCjzm
   qnR7XZDZri2o6tHoGVdaZ4qfvfOnFXteuE/gHKytLorn8qSaKpYSlMHgg
   R78Etv3ZcPuae3IxGLV8pe4e2YnuT7lFk1Bm0nuxXdkTyXnVIBOSCyTrg
   1xyEjFHncEhhwGwezzp58i5qh+w/Fn4CMthKaUhRUUiG+vttqgLWsbiz8
   Q==;
X-CSE-ConnectionGUID: Lp4RCK1WQcagg/PzArSsIw==
X-CSE-MsgGUID: wcmG6rYVTwapUWhsXZOowQ==
X-IPAS-Result: =?us-ascii?q?A0ADAADWanxq/5EQJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQGBfQMBAQEBAQsBglaBUkNJhFePUoIhgRaQN4xRgX4PA?=
 =?us-ascii?q?QEBD1EEAQGFBQKNZwImNQgOAQIEAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHB?=
 =?us-ascii?q?YEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoMCgnUDwyt6fzOBAd5GgWYBCxQBg?=
 =?us-ascii?q?QouAYVwgmwBgXCECDuDRnsnG4FJRIEUAYJYG3aIHoJqBIIiehKBDYF8cYdqh?=
 =?us-ascii?q?xwJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PBBYyHXAMJxIsFzVYG?=
 =?us-ascii?q?wYFgR19FAQThDYjGTZ8gQlhgSsqZQESF4EJgiQCgnaBKmECAR4LGA1IESw3B?=
 =?us-ascii?q?g4ZBD0BbgeOCCCBVHEBPBwbBxQKgSYMCE8dFBkcKQOSYBsCg2GMKYE2a4E1g?=
 =?us-ascii?q?RmIJZYchCiBZqAPATKEBJNjNJJRmQgjo0keAQFOhGmBaQE6gVkzGggbFTuCZ?=
 =?us-ascii?q?1MZD4h3hTMDFhzPfScyPQIHAgcOAwuRaASBegEB?=
IronPort-Data: A9a23:NdaYU6D+iIPyrRVW//viw5YqxClBgxIJ4kV8jS/XYbTApGgi3mdUz
 WIaDT2FPvzcMGqked0kPIu2oB9TuMLdzt4xOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYA/8gWYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE5+0yNmoVZLIh8e94DiZ25
 9UCEysscUXW7w626OrTpuhEj8AnKozveYgYoHwllWGfBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxANWcHgBfoO3WjPn8MAY4/h+erhlH0ciZTrxSeoq9fD237nFQtjeW2YIGMEjCMbdpem2nGv
 FP4w3vwGiwlNMev+x2C7Uv504cjmgu+Aur+DoaQ+vd0jVi7ymUNBRgSUlWn5/+0liaWX99eN
 0UT0iYjp6k78gqsVNaVdxC0vXuNrBMAc9VXFOI+5UeGza+8ywWEDGEsTTNbbtEi8sgsSlQC3
 1mFhd72RjpirLGYV1qZ67GS6ziyUQANJGUPYy4sVwYJ49D/5oo0i3rnStdlDb7wjdDvHzz06
 y6FoTJ4hLgJi8MPkaKh8jjvhT+wqpXXZhA66x+RXW+/6A59Iom/aOSVBUPz5PJEKsOdC1KGp
 nVBw5jY5+EVBpbLnyuIKAkQIIyUCz++GGW0qTZS81MJqVxBJ1bLkVhs3QxD
IronPort-HdrOrdr: A9a23:O+mY9Kpmx/SYq+b26vK+cHMaV5rdeYIsimQD101hICG9vPbo8/
 xG+8576faUslgssR4b9OxoVJPrfZqYz+8W3WBzB9iftXfd2FdARbsKheDfKn/bak7DH4VmuZ
 uIHZIObeHYPBxWgdn35Q+gH81l4tWWmZrY/Nv2/jNBQR5nbqd44xw8MAaUFUVqWBJLbKBJcq
 Z0nvA3wAaISDAwctmxAGUDUqzoot3Gk4+jXDs9biRXkDVnSViTmcTH+9/y5GZkbw9y
X-Talos-CUID: 9a23:Wi8M524WO7rwBDMyXdss0FZIIOsGK0Lkx37fLAiAG09zc6a0VgrF
X-Talos-MUID: 9a23:QAFsoAluNWYpjgDO/VKbdnp9P8JHvb6fNnwSmI07hMmfBR5XPCik2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="804553831"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 12:48:33 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 6074918000752;
	Wed, 12 Aug 2026 12:48:32 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 12 Aug 2026 05:48:04 -0700
Subject: [PATCH net-next v13 04/11] enic: add admin CQ service with MSI-X
 interrupt and workqueue polling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-enic-sriov-v2-admin-channel-v2-v13-4-b3809e448aba@cisco.com>
References: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
In-Reply-To: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786538908; l=18629;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=eneO6A7qeEO9gz/pxpyQex+tyhFxzcTcoo+gsh71FVQ=;
 b=sxDFftci8sRJbzfz4QAL/xyb2rhdTOvTX5TD0N0DhXqAIL4PE2syN6k61KXF1qlfniZvJr/8H
 jqm5xdPG8MwC6ua9mgkjd/ryGgikecDZKTltoAm13o0qBOIdIa4m/Oi
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-08.cisco.com

Add completion queue (CQ) service for the admin channel work queue
(WQ) and receive queue (RQ), driven by a dedicated MSI-X interrupt
and a workqueue-based CQ poller.

The admin WQ CQ service advances the completion ring and returns the
number of descriptors consumed.  The admin RQ CQ service does the
same for receive completions and copies each received message out of
its pre-posted DMA buffer into a dynamically allocated queue entry.
The pending queue is bounded to ENIC_ADMIN_MSG_MAX (256) entries so a
buggy or hostile VF cannot drive the host out of memory; messages are
enqueued for deferred dispatch by a separate work_struct so the CQ
poller stays short.

When the MSI-X interrupt fires, the ISR schedules the CQ poll work.
The work handler drains all pending completions, kicks message
dispatch if work was done, and returns credits to unmask the
interrupt.  The admin vector is kept masked from the time the IRQ is
requested until the rings are initialised and filled during channel
open, so an early or spurious interrupt cannot run the poll handler
against uninitialised rings.

The poll handler snapshots the pending credit count before draining
the CQ so it acknowledges exactly what the hardware reported for this
interrupt; any credits that accrue during draining are serviced by the
next interrupt.  The credit write also sets the mask bit to re-arm the
vector, and that unmask is applied independently of the credit count,
so the vector is re-armed even when zero credits are returned -- which
matters here because the admin channel is not re-polled like the NAPI
data path.

If an admin RQ buffer refill fails under transient memory pressure,
reschedule the CQ poll work itself after a short delay to retry the
refill and re-arm the RQ, so the admin channel cannot stall when the
ring would otherwise be left empty with no completion to drive the
next refill.  The poll work is a delayed_work for this reason; routing
the retry through it keeps the admin RQ ring owned by a single context
so refills never run concurrently.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |   8 +
 drivers/net/ethernet/cisco/enic/enic_admin.c | 345 ++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_admin.h |  12 +
 3 files changed, 361 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 398227448b37..0f08de228b36 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -301,6 +301,14 @@ struct enic {
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
 	struct vnic_intr admin_intr;
+	struct delayed_work admin_poll_work;
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
index edd0a2d3994b..65aec9651a6f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -15,9 +16,15 @@
 #include "enic.h"
 #include "enic_admin.h"
 #include "cq_desc.h"
+#include "cq_enet_desc.h"
 #include "wq_enet_desc.h"
 #include "rq_enet_desc.h"
 
+/* Retry interval for a failed admin RQ refill.  Short so the control
+ * channel recovers quickly once memory is available again.
+ */
+#define ENIC_ADMIN_RQ_REFILL_RETRY_MS	100
+
 /* Clean up any admin WQ buffers still held by hardware at close time.
  * Normally buffers are freed inline after send completion, but a timed-out
  * send intentionally leaves the buffer live until the queue is stopped.
@@ -94,6 +101,283 @@ static void enic_admin_rq_drain(struct enic *enic)
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
+		 * (ENIC_ADMIN_BUF_SIZE); copying that many bytes would read
+		 * beyond the actual DMA payload.  bytes_written_flags is at
+		 * the same offset in every cq_enet_rq_desc[_32|_64] variant.
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
+	if (enic_admin_rq_fill(enic, GFP_KERNEL)) {
+		/* Some RX buffers could not be reposted (transient memory
+		 * pressure).  If the ring is left empty the channel would stall
+		 * with no completion to drive the next refill, so arm a delayed
+		 * re-run of this poll work (the sole owner of the admin RQ ring)
+		 * to repost buffers and re-arm the RQ from a single context.
+		 */
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "admin RQ refill failed; scheduling retry\n");
+		schedule_delayed_work(&enic->admin_poll_work,
+				      msecs_to_jiffies(ENIC_ADMIN_RQ_REFILL_RETRY_MS));
+	}
+
+	return work;
+}
+
+static irqreturn_t enic_admin_isr_msix(int irq, void *data)
+{
+	struct enic *enic = data;
+
+	schedule_delayed_work(&enic->admin_poll_work, 0);
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
+	struct enic *enic = container_of(to_delayed_work(work), struct enic,
+					 admin_poll_work);
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
+	/* Mask the admin vector before requesting the IRQ so an early or
+	 * spurious completion cannot run the poll handler against the
+	 * not-yet-initialised admin rings.  enic_admin_channel_open() unmasks
+	 * it only after the rings are initialised and filled.
+	 */
+	vnic_intr_mask(&enic->admin_intr);
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
+	cancel_delayed_work_sync(&enic->admin_poll_work);
+	enic->msix[intr_index].requested = 0;
+}
+
 static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
 {
 	u64 a0 = QP_TYPE_ADMIN, a1 = enable;
@@ -173,6 +457,7 @@ static int enic_admin_alloc_resources(struct enic *enic)
 
 static void enic_admin_free_resources(struct enic *enic)
 {
+	vnic_intr_free(&enic->admin_intr);
 	vnic_cq_free(&enic->admin_cq[1]);
 	vnic_cq_free(&enic->admin_cq[0]);
 	vnic_rq_free(&enic->admin_rq);
@@ -181,6 +466,8 @@ static void enic_admin_free_resources(struct enic *enic)
 
 static void enic_admin_init_resources(struct enic *enic)
 {
+	unsigned int intr_offset = enic->admin_intr_index;
+
 	vnic_wq_init(&enic->admin_wq,
 		     0, 0, 0); /* cq_index, err_intr_enable, err_intr_offset */
 	vnic_rq_init(&enic->admin_rq,
@@ -189,20 +476,35 @@ static void enic_admin_init_resources(struct enic *enic)
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
@@ -220,6 +522,19 @@ int enic_admin_channel_open(struct enic *enic)
 		return err;
 	}
 
+	spin_lock_init(&enic->admin_msg_lock);
+	INIT_LIST_HEAD(&enic->admin_msg_list);
+	INIT_WORK(&enic->admin_msg_work, enic_admin_msg_work_handler);
+	INIT_DELAYED_WORK(&enic->admin_poll_work, enic_admin_poll_work_handler);
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
@@ -239,17 +554,31 @@ int enic_admin_channel_open(struct enic *enic)
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
@@ -268,6 +597,13 @@ void enic_admin_channel_close(struct enic *enic)
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
@@ -283,6 +619,7 @@ void enic_admin_channel_close(struct enic *enic)
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

