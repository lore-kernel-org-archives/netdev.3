Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107F443C30;
	Mon, 21 Sep 2026 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020896; cv=none; b=ZBe28MRVtvytguip58oVmhWR8ZaRRZuZc8VfemTyNltWnVAVcoBH3CxCS+FLBhwFRRg/M8aUVeTide0V9l22TiV5nj52KdBCXDXADFmHyAjcBPv7YDdzK6coEzACH6N4O2/yEZZD+eQUw1rjMtK0zW5AUoKv8i2UdExHl4p6KjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020896; c=relaxed/simple;
	bh=QkZwVj5suBrZgkE0RrWLgjO4TXrkNcLwYiH5Lqfhn0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8IzRe/AsJvUWbXr+gLkZ5ImpXmAfpr+JWe8qLLu5dFPCcf+Xm9jOP0JUQV1Iew6Txp94LNbhGXypjrUf3jLuVbDZeWi5WP+rQlzO7st2KVFfS85XCbwBzJXBbAeOuKWZxxGxL01kt6XU1lxqbZSKkkXdgse4/NbTvwBPtJqsG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Y9loUF/H; arc=none smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="Y9loUF/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=29686; q=dns/txt;
  s=iport01; t=1790020892; x=1791230492;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qzmf9x2iSPClodO3s3BJBheIgEFou2YsvV4QaaDbBYI=;
  b=Y9loUF/Hz+uMbpDo3IFGg12fMNSsZPLMWVjkREvWjJProG94R4pCUYXD
   WfyF7SlpDXh1RxBqp4zRf6sx9WFQykPklONawjXEasXRqZrQ9iaB+/3Z4
   u1zaoPI4PNBz2UJHo2268mNhoDQC6VXB6yxFM3yP5xY1uotnEx6+kyyb8
   shjCwyyKCx2f+SzHwKbT7fKhmMF73A4gP7gxOR04b4FyU5KUh58ZrIHGs
   mU3Stx4WA7hCO8k94Xitd9D2cWkpt4e3uB+L+hQkezsGN5i73wgQuEBZ5
   Xc/RpTS4VT+pUbqvbW/cLvPUGqTg8jKx+q7967MnWgJp44OmOdzq156eR
   w==;
X-CSE-ConnectionGUID: hYqsXAL0R3KYcdhyRSKong==
X-CSE-MsgGUID: uwaEr0luR2y1TiUcvdUO1g==
X-IPAS-Result: =?us-ascii?q?A0AAAwCvi7Fq/47/Ja1aHgEBCxIMggULghg/gVVDSYRXj?=
 =?us-ascii?q?1KCIZFNjFEUgWoPAQEBD1EEAQGFBQKOBwImNgcOAQIEAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBCgEBBQEBAQIBBwWBDhOGXJATAgEDGgkECwE0EhAlAiYCAkUBEAYBEoMCg?=
 =?us-ascii?q?nUDxXh6fzOBAYR+2UqBaAELFAGBCi6FcYJtAYFwhAg7g0Z7JxuBSUSBFYJYI?=
 =?us-ascii?q?m+EHwuDdIJqBIMcEoJmhzOKQQk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYF?=
 =?us-ascii?q?QIUHRIPBBYyHXAMJxIsFy9YGwYFgR18FAQTghojGTZ6gQlegSspYAEQF4EHg?=
 =?us-ascii?q?ggCglSBfwIBSUMOB0VTCSdBChJHKSIIEgkBExowC4EnGA1IESw3Bg8ZBD0Bb?=
 =?us-ascii?q?gePXh+BZAYBUQ4CCQcBDQgXAg4cATUTCGAELRAJMxsaCSdFA5JgCoN0jkqBN?=
 =?us-ascii?q?Z9ahCiBZqAQM5dnkwaZCCOjSQYPCQFPhGmBbgE1gVkzGggbFTuCZ1MZD44uF?=
 =?us-ascii?q?oEUAQKSBgG8eycyPgEHAgcPAoFzkAAEDRd2YAEB?=
IronPort-Data: A9a23:wEOWm6pR3uaSoq0GnhPNT0K7lxdeBmLKZBIvgKrLsJaIsI4StFCzt
 garIBnSO/beYjCne4x0bY+y90MBv5WHzINrSgI6/nxnRXkX9OPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOWn9T8jhfngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgDNNwJcaDpOtfrS8ko35pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0uZGGHp+3
 NhAEmsuXxuPh/OM+5G8TOY506zPLOGzVG8ekmtrwTecCbMtRorOBv2Xo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LUvrSn8/w7pX7WyZRtFOOpak3y2PS1wd2lrPqNbI5f/TXH5gEwhbC9
 zquE2LRHw4TGcbHzSe/qGP1uu7ylj33ZaVLG+jtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA/+FGuR8vwQzW3p3mLuhNaUN1Ve8U67xuI0YLX7hyfC2xCSSROAPQlqcU/bT8nz
 FmEm5XuHzMHmLSTRWiQ6fSSoC++NDY9KXIEY2kPTWMt+9DprYcypgjCQtZqDOi+ididMTXxx
 S2a6SsznbMeieYV2Kihu1PKmTShot7OVAFdzgPaQm6o8Ctna4O/IY+l817W6bBHNonxc7Wal
 GIPl87b6KUFCouA0XTQBu4MB7quof2CNVUwnGJSInXozBz1k1bLQGyayGsWyJtBWircRQLUX
 Q==
IronPort-HdrOrdr: A9a23:vP4FIKzJRAd5/GetdEteKrPw2r1zdoMgy1knxilNoNJuA6ilfq
 eV/cjztCWbtN9/YhwdcLy7UpVoBEmsl6KdgrN/AV7dZmnbUQKTRekI0WKh+UyCJ8SUzIJgPM
 lbAs1DIey1IFRkgcP9+QWiV/Qt0LC8gdmVrNab4ntzQQRtcq16qz14BAGSD1FsSGB9dPwE/e
 Knl616jgvlX2gLZcKmAXRAde3Cq9rX0K/CW3c9dmYaAM3kt0LT1FY8eCLopSsjbw==
X-Talos-CUID: 9a23:5ODSWWNTIzjVC+5DWBh+7349PpgfKV7sx3vQMnWDKmFvR+jA
X-Talos-MUID: 9a23:xtw04wVIsfTafF/q/CLzjRx4bMN12f6/UXwMrJ4Yt/SjbCMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,115,1787011200"; 
   d="scan'208";a="525948290"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Sep 2026 20:00:23 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPS id F3CE818000236;
	Mon, 21 Sep 2026 20:00:22 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 21 Sep 2026 12:59:46 -0700
Subject: [PATCH net-next 3/6] enic: recover V2 VF mailbox when PF state is
 unknown
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-3-67a0a6e08d43@cisco.com>
References: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
In-Reply-To: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790020820; l=30660;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=QkZwVj5suBrZgkE0RrWLgjO4TXrkNcLwYiH5Lqfhn0g=;
 b=JsUkwbCagJsJtVJXme/JN/zh1cQKleejtnfdnrdvJ3/7mXQwz7Iqa6Q1Z6mGswCMKkJ1BWO7+
 J+ojYVFEzuCCRPe+opCYJ8jztXs5nYRZVr/XjsqgREGqEaZUxXPyBVQ
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-05.cisco.com

A mailbox send can complete and still lose its reply. In that case the VF
cannot know whether the PF changed its address or receive-filter state. A
send-completion timeout is different because the admin-WQ descriptor may
still belong to the device.

Reconnect the V2 VF mailbox after the first case. After a hardware send
timeout, stop using the channel and leave the timed-out DMA mapping for
admin-channel teardown to reclaim safely.

Stop V2 VF receive traffic when the VF can no longer trust that its state
matches the PF. Rebuild and register the admin channel again at a safe
open/reset boundary, then restore receive traffic after the station address
and filters have been replayed. Defer notification acknowledgments so
receive dispatch cannot block behind a VF request.

Reinitialize non-dynamic vNICs after a successful soft reset before
programming queue resources. This restores the initialization sequence used
during probe and ensures that reset recovery rebuilds the vNIC before
reopening the datapath.

Also use this recovery after malformed or dropped admin receive traffic,
and track whether the V2 datapath is open so a failed internal reset cannot
stop it twice.

Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |  23 ++-
 drivers/net/ethernet/cisco/enic/enic_admin.c |  27 +++-
 drivers/net/ethernet/cisco/enic/enic_main.c  | 208 ++++++++++++++++++++++-----
 drivers/net/ethernet/cisco/enic/enic_mbox.c  | 171 ++++++++++++++++++++--
 drivers/net/ethernet/cisco/enic/enic_mbox.h  |   2 +
 drivers/net/ethernet/cisco/enic/enic_rq.c    |  11 +-
 6 files changed, 392 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 3945fe28f199..782b8b1843ab 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -303,8 +303,21 @@ struct enic {
 	 * left the resources freed.
 	 */
 	bool admin_chan_up;
-	/* set on send timeout; cleared on channel re-open */
+	/* Blocks sends while the channel is closed or awaiting recovery. */
 	bool mbox_send_disabled;
+	/* A send timeout leaves a descriptor hardware-owned.  Do not reopen the
+	 * channel during this device lifetime until reset/DMA fencing is proven.
+	 */
+	bool mbox_tx_poisoned;
+	/* After a lost or inconsistent reply, the VF cannot know whether the PF
+	 * applied the request. Reconnect during the next open or reset.
+	 */
+	bool vf_mbox_reconnect_required;
+	u32 vf_mbox_fault_generation;
+	/* One slow-path-owned predicate keeps the RX hot path fail-closed while
+	 * VF registration is lost or receive state may not match the PF.
+	 */
+	bool vf_rx_quarantined;
 	struct vnic_wq admin_wq;
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
@@ -325,6 +338,10 @@ struct enic {
 	spinlock_t vf_link_state_lock;
 	enum enic_vf_link_state vf_link_state;
 	bool vf_link_running;
+	/* Tracks a completely opened V2 VF datapath.  An internal reset can stop
+	 * it while netif_running() remains true, then fail before reopen.
+	 */
+	bool vf_datapath_open;
 
 	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
 	struct mutex mbox_lock;
@@ -337,6 +354,10 @@ struct enic {
 	struct completion mbox_comp;
 	struct mutex vf_mbox_request_lock; /* serializes VF request lifetimes */
 	spinlock_t mbox_state_lock;	/* protects expected reply state */
+	spinlock_t vf_ack_lock;		/* protects vf_ack_list */
+	struct list_head vf_ack_list;
+	struct work_struct vf_ack_work;
+	unsigned int vf_ack_count;
 	u64 mbox_expected_msg_num;
 	u8 mbox_expected_reply;
 	bool mbox_initialized;
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 61c82b48044d..30c0a5c89a2d 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -132,14 +132,22 @@ unsigned int enic_admin_wq_cq_service(struct enic *enic)
  */
 #define ENIC_ADMIN_MSG_MAX	256
 
+static void enic_admin_rx_lost(struct enic *enic)
+{
+	if (enic_is_sriov_vf_v2(enic))
+		enic_mbox_vf_require_reconnect(enic);
+}
+
 static void enic_admin_msg_enqueue(struct enic *enic, void *buf,
 				   unsigned int len)
 {
 	struct enic_admin_msg *msg;
 
 	msg = kmalloc_flex(*msg, data, len);
-	if (!msg)
+	if (!msg) {
+		enic_admin_rx_lost(enic);
 		return;
+	}
 
 	msg->len = len;
 	memcpy(msg->data, buf, len);
@@ -152,6 +160,7 @@ static void enic_admin_msg_enqueue(struct enic *enic, void *buf,
 			netdev_warn(enic->netdev,
 				    "admin msg backlog full (%u); dropping\n",
 				    ENIC_ADMIN_MSG_MAX);
+		enic_admin_rx_lost(enic);
 		return;
 	}
 	list_add_tail(&msg->list, &enic->admin_msg_list);
@@ -194,8 +203,10 @@ unsigned int enic_admin_rq_cq_service(struct enic *enic)
 		rq_desc = desc;
 		bwf = le16_to_cpu(rq_desc->bytes_written_flags);
 		bytes_written = bwf & CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK;
-		if (bytes_written > buf->len)
+		if (bytes_written > buf->len) {
+			enic_admin_rx_lost(enic);
 			goto next_desc;
+		}
 
 		dma_sync_single_for_cpu(&enic->pdev->dev,
 					buf->dma_addr, buf->len,
@@ -210,11 +221,13 @@ unsigned int enic_admin_rq_cq_service(struct enic *enic)
 		if (bwf & CQ_ENET_RQ_DESC_FLAGS_TRUNCATED) {
 			netdev_warn_once(enic->netdev,
 					 "admin RQ: truncated message dropped\n");
+			enic_admin_rx_lost(enic);
 			goto next_desc;
 		}
 		if (!(rq_desc->flags & CQ_ENET_RQ_DESC_FLAGS_FCS_OK)) {
 			netdev_warn_once(enic->netdev,
 					 "admin RQ: bad FCS, dropping message\n");
+			enic_admin_rx_lost(enic);
 			goto next_desc;
 		}
 
@@ -534,6 +547,11 @@ int enic_admin_channel_open(struct enic *enic)
 
 	if (!enic->has_admin_channel)
 		return -ENODEV;
+	if (READ_ONCE(enic->mbox_tx_poisoned)) {
+		netdev_err(enic->netdev,
+			   "Refusing to reopen admin channel after send timeout\n");
+		return -EIO;
+	}
 
 	/* Keep MBOX sends disabled for the entire open sequence.  It is
 	 * cleared only after every resource is allocated and enabled below,
@@ -641,6 +659,11 @@ void enic_admin_channel_close(struct enic *enic)
 	enic_admin_teardown_intr(enic);
 	cancel_work_sync(&enic->link_notify_work);
 	cancel_work_sync(&enic->admin_msg_work);
+	/* admin_msg_work is the sole VF ACK producer.  Drain it before the ACK
+	 * worker so an enqueue cannot race the final cancel and queue purge.
+	 */
+	if (enic_is_sriov_vf_v2(enic))
+		enic_mbox_vf_ack_cancel(enic);
 	enic_admin_msg_drain(enic);
 
 	enic_admin_qp_type_set(enic, QP_DISABLE);
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 9086e6dd558a..1c60e7a666ae 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -71,6 +71,8 @@
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2   0x02b7  /* enet SRIOV V2 VF */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF_USNIC 0x00cf /* enet USNIC VF */
 
+static int __enic_stop(struct net_device *netdev, bool remove_vf_station);
+
 /* Supported devices */
 static const struct pci_device_id enic_id_table[] = {
 	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET) },
@@ -1718,6 +1720,8 @@ static void enic_notify_timer_start(struct enic *enic)
 	}
 }
 
+static int enic_admin_chan_reopen(struct enic *enic);
+
 /* rtnl lock is held, process context */
 static int enic_open(struct net_device *netdev)
 {
@@ -1736,6 +1740,30 @@ static int enic_open(struct net_device *netdev)
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 	};
 
+	/* A reply timeout invalidates the current request generation.  Rebuild
+	 * and re-register the channel before allocating datapath resources so a
+	 * later userspace down/up can recover a failed open or reset handshake.
+	 * A send timeout is intentionally not recoverable here because its WQ
+	 * descriptor may still be hardware-owned.
+	 */
+	if (enic_is_sriov_vf_v2(enic) &&
+	    READ_ONCE(enic->mbox_tx_poisoned))
+		return -EIO;
+	if (enic_is_sriov_vf_v2(enic) &&
+	    (!enic->admin_chan_up || !READ_ONCE(enic->vf_registered) ||
+	     READ_ONCE(enic->vf_mbox_reconnect_required))) {
+		/* Re-registration makes the PF discard the old VF-requested
+		 * filters.  Clear the netdev-core synchronization state so the
+		 * receive-mode callback replays the current address lists.
+		 */
+		enic_reset_addr_lists(enic);
+		if (enic->admin_chan_up)
+			enic_admin_channel_close(enic);
+		err = enic_admin_chan_reopen(enic);
+		if (err)
+			return err;
+	}
+
 	err = enic_request_intr(enic);
 	if (err) {
 		netdev_err(netdev, "Unable to request irq.\n");
@@ -1794,17 +1822,41 @@ static int enic_open(struct net_device *netdev)
 		netdev_err(netdev, "Failed to enable device: %d\n", err);
 		goto err_out_dev_enable;
 	}
+	if (enic_is_sriov_vf_v2(enic)) {
+		/* Commit the replay only if no mailbox fault arrived while station
+		 * and receive policy were being programmed.  Keep the state lock
+		 * through the carrier transition so a later fault necessarily wins
+		 * and turns carrier back off.
+		 */
+		spin_lock_bh(&enic->mbox_state_lock);
+		if (!READ_ONCE(enic->vf_registered) ||
+		    READ_ONCE(enic->mbox_send_disabled) ||
+		    READ_ONCE(enic->mbox_tx_poisoned) ||
+		    READ_ONCE(enic->vf_mbox_reconnect_required)) {
+			err = -EIO;
+		} else {
+			WRITE_ONCE(enic->vf_rx_quarantined, false);
+			enic_mbox_vf_link_state_set_running(enic, true);
+		}
+		spin_unlock_bh(&enic->mbox_state_lock);
+		if (err) {
+			netdev_err(netdev,
+				   "MBOX state changed during VF datapath open\n");
+			goto err_out_dev_disable;
+		}
+	}
 
 	for (i = 0; i < enic->intr_count; i++)
 		vnic_intr_unmask(&enic->intr[i]);
-
 	enic_notify_timer_start(enic);
 	enic_rfs_timer_start(enic);
 	if (enic_is_sriov_vf_v2(enic))
-		enic_mbox_vf_link_state_set_running(enic, true);
+		enic->vf_datapath_open = true;
 
 	return 0;
 
+err_out_dev_disable:
+	enic_dev_disable(enic);
 err_out_dev_enable:
 	for (i = 0; i < enic->rq_count; i++)
 		napi_disable(&enic->napi[i]);
@@ -1834,12 +1886,20 @@ static int enic_open(struct net_device *netdev)
 }
 
 /* rtnl lock is held, process context */
-static int enic_stop(struct net_device *netdev)
+static int __enic_stop(struct net_device *netdev, bool remove_vf_station)
 {
 	struct enic *enic = netdev_priv(netdev);
 	unsigned int i;
 	int err;
 
+	/* Internal reset leaves netif_running() set while the datapath is down.
+	 * If re-registration or reopen then fails, a later administrative close
+	 * must not disable NAPI a second time.
+	 */
+	if (enic_is_sriov_vf_v2(enic) && !enic->vf_datapath_open)
+		return 0;
+	(void)remove_vf_station;
+
 	for (i = 0; i < enic->intr_count; i++) {
 		vnic_intr_mask(&enic->intr[i]);
 		(void)vnic_intr_masked(&enic->intr[i]); /* flush write */
@@ -1893,10 +1953,17 @@ static int enic_stop(struct net_device *netdev)
 		vnic_cq_clean(&enic->cq[i]);
 	for (i = 0; i < enic->intr_count; i++)
 		vnic_intr_clean(&enic->intr[i]);
+	if (enic_is_sriov_vf_v2(enic))
+		enic->vf_datapath_open = false;
 
 	return 0;
 }
 
+static int enic_stop(struct net_device *netdev)
+{
+	return __enic_stop(netdev, true);
+}
+
 static int _enic_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	bool running = netif_running(netdev);
@@ -2196,14 +2263,15 @@ static bool enic_has_admin_chan(struct enic *enic)
 	       (enic_sriov_enabled(enic) && enic->vf_type == ENIC_VF_TYPE_V2);
 }
 
-/* Re-establish the admin/MBOX channel after a reset has re-created the data
- * path.  Mirrors the relevant part of the probe / SR-IOV-enable sequence:
+/* Re-establish the admin/MBOX channel after a reset has re-created the vNIC
+ * resources.  Mirrors the relevant part of the probe / SR-IOV-enable sequence:
  * reinitialise MBOX and reopen the channel, then for a VF re-run the PF
  * handshake (the reset wiped the VF's admin QP, so the VF must register
  * again), or for a PF re-push the current link state to registered VFs.
  */
-static void enic_admin_chan_reopen(struct enic *enic)
+static int enic_admin_chan_reopen(struct enic *enic)
 {
+	u32 recovery_generation = 0;
 	int err;
 
 	/* Install the MBOX receive handler and clear pending reply state before
@@ -2222,12 +2290,17 @@ static void enic_admin_chan_reopen(struct enic *enic)
 	 */
 	if (enic_is_sriov_vf_v2(enic))
 		WRITE_ONCE(enic->vf_registered, false);
+	if (enic_is_sriov_vf_v2(enic)) {
+		spin_lock_bh(&enic->mbox_state_lock);
+		recovery_generation = enic->vf_mbox_fault_generation;
+		spin_unlock_bh(&enic->mbox_state_lock);
+	}
 
 	err = enic_admin_channel_open(enic);
 	if (err) {
 		netdev_err(enic->netdev,
 			   "admin channel reopen after reset failed: %d\n", err);
-		return;
+		return err;
 	}
 
 	if (enic_is_sriov_vf_v2(enic)) {
@@ -2237,7 +2310,7 @@ static void enic_admin_chan_reopen(struct enic *enic)
 				   "MBOX capability check after reset failed: %d\n",
 				   err);
 			enic_admin_channel_close(enic);
-			return;
+			return err;
 		}
 		err = enic_mbox_vf_register(enic);
 		if (err) {
@@ -2245,6 +2318,26 @@ static void enic_admin_chan_reopen(struct enic *enic)
 				   "MBOX VF re-registration after reset failed: %d\n",
 				   err);
 			enic_admin_channel_close(enic);
+			return err;
+		}
+		enic_reset_addr_lists(enic);
+		/* Capability negotiation and registration establish a new protocol
+		 * generation. RX remains quarantined until enic_open() replays the
+		 * station and receive policy.
+		 */
+		spin_lock_bh(&enic->mbox_state_lock);
+		if (enic->vf_mbox_fault_generation != recovery_generation ||
+		    READ_ONCE(enic->mbox_tx_poisoned)) {
+			err = -EAGAIN;
+		} else {
+			WRITE_ONCE(enic->vf_mbox_reconnect_required, false);
+		}
+		spin_unlock_bh(&enic->mbox_state_lock);
+		if (err) {
+			netdev_warn(enic->netdev,
+				    "MBOX state changed during VF re-registration\n");
+			enic_admin_channel_close(enic);
+			return err;
 		}
 	} else {
 		/* The link came back up during enic_open() above while MBOX
@@ -2253,79 +2346,119 @@ static void enic_admin_chan_reopen(struct enic *enic)
 		 */
 		schedule_work(&enic->link_notify_work);
 	}
+
+	return 0;
 }
 
 static void enic_reset(struct work_struct *work)
 {
 	struct enic *enic = container_of(work, struct enic, reset);
+	int err;
 
 	if (!netif_running(enic->netdev))
 		return;
 
 	rtnl_lock();
+	/* V2 protocol recovery can be queued immediately before ndo_stop()
+	 * acquires RTNL.  Recheck under RTNL so that new recovery path cannot
+	 * reopen a device userspace just closed.  Preserve the existing reset
+	 * behavior for every other ENIC device.
+	 */
+	if (enic_is_sriov_vf_v2(enic) && !netif_running(enic->netdev))
+		goto unlock;
 
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
 
-	/* Fully tear down the V2 admin/MBOX channel before the soft reset.
-	 * The reset wipes all hardware queues including the admin WQ/RQ;
-	 * closing first tells firmware to stop the admin QP (so it no longer
-	 * DMAs from the about-to-be-reset rings) and frees the admin resources
-	 * so they are cleanly re-allocated afterwards.
+	/* Stop the datapath and existing admin/MBOX channel before the soft
+	 * reset. Do not send DEL_MAC from this path: a timeout would poison the
+	 * channel while reset and fresh registration already discard the old
+	 * VF-requested protocol state before the station address is replayed.
+	 * Reopen allocates fresh admin resources after reset recreates the vNIC.
 	 */
+	__enic_stop(enic->netdev, false);
 	if (enic_has_admin_chan(enic))
 		enic_admin_channel_close(enic);
 
-	enic_stop(enic->netdev);
 	if (enic_is_sriov_vf_v2(enic))
 		enic_mbox_vf_link_state_reset(enic);
+	err = enic_dev_soft_reset(enic);
+	if (err)
+		goto reset_out;
+
+	if (!enic_is_dynamic(enic)) {
+		err = vnic_dev_init(enic->vdev, 0);
+		if (err) {
+			netdev_err(enic->netdev,
+				   "vNIC init after soft reset failed: %d\n",
+				   err);
+			goto reset_out;
+		}
+	}
 
-	enic_dev_soft_reset(enic);
 	enic_reset_addr_lists(enic);
 	enic_init_vnic_resources(enic);
 	enic_set_rss_nic_cfg(enic);
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
 
-	enic_open(enic->netdev);
+	/* A V2 VF needs PF registration before enic_open() can install its
+	 * station address.  A V2 PF reopens afterwards and replays carrier.
+	 */
+	if (enic_is_sriov_vf_v2(enic)) {
+		err = enic_admin_chan_reopen(enic);
+		if (err)
+			goto reset_out;
+	}
 
-	/* Re-establish the admin/MBOX channel after the data path is back up.
-	 * It was fully torn down by enic_admin_channel_close() above;
-	 * enic_admin_chan_reopen() reopens it and, for a PF re-pushes link
-	 * state, or for a VF re-runs the probe-time PF handshake.
+	err = enic_open(enic->netdev);
+	if (err)
+		netdev_err(enic->netdev,
+			   "Failed to reopen datapath after reset: %d\n", err);
+
+	/* A PF reopens its admin channel after the datapath and re-pushes link
+	 * state.  The VF handshake, which open depends on, completed above.
 	 */
-	if (enic_has_admin_chan(enic))
+	if (enic_has_admin_chan(enic) && !enic_is_sriov_vf_v2(enic))
 		enic_admin_chan_reopen(enic);
 
+reset_out:
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
 
 	call_netdevice_notifiers(NETDEV_REBOOT, enic->netdev);
 
+unlock:
 	rtnl_unlock();
 }
 
 static void enic_tx_hang_reset(struct work_struct *work)
 {
 	struct enic *enic = container_of(work, struct enic, tx_hang_reset);
+	int err;
 
 	rtnl_lock();
+	/* The V2 changes below add admin-channel recovery to this worker.  Do not
+	 * let that new path reopen a VF after userspace completed ndo_stop();
+	 * leave the existing behavior for other ENIC devices unchanged.
+	 */
+	if (enic_is_sriov_vf_v2(enic) && !netif_running(enic->netdev))
+		goto unlock;
 
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
 
-	/* Fully tear down the V2 admin/MBOX channel before the hang reset, for
-	 * the same reason as the soft reset path: stop the admin QP and free
-	 * the admin resources before the hardware queues are wiped.
+	/* Preserve the firmware hang-notification contract by reporting the hung
+	 * queue before stopping and cleaning it. As in the soft-reset path, skip
+	 * DEL_MAC because reset and fresh registration are the cleanup boundary.
 	 */
+	enic_dev_hang_notify(enic);
+	__enic_stop(enic->netdev, false);
 	if (enic_has_admin_chan(enic))
 		enic_admin_channel_close(enic);
 
-	enic_dev_hang_notify(enic);
-	enic_stop(enic->netdev);
 	if (enic_is_sriov_vf_v2(enic))
 		enic_mbox_vf_link_state_reset(enic);
-
 	enic_dev_hang_reset(enic);
 	enic_reset_addr_lists(enic);
 	enic_init_vnic_resources(enic);
@@ -2333,21 +2466,30 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
 
-	enic_open(enic->netdev);
+	if (enic_is_sriov_vf_v2(enic)) {
+		err = enic_admin_chan_reopen(enic);
+		if (err)
+			goto hang_reset_out;
+	}
 
-	/* Re-establish the admin/MBOX channel after the data path is back up.
-	 * It was fully torn down by enic_admin_channel_close() above;
-	 * enic_admin_chan_reopen() reopens it and, for a PF re-pushes link
-	 * state, or for a VF re-runs the probe-time PF handshake.
+	err = enic_open(enic->netdev);
+	if (err)
+		netdev_err(enic->netdev,
+			   "Failed to reopen datapath after hang reset: %d\n", err);
+
+	/* A PF reopens its admin channel after the datapath and re-pushes link
+	 * state.  The VF handshake, which open depends on, completed above.
 	 */
-	if (enic_has_admin_chan(enic))
+	if (enic_has_admin_chan(enic) && !enic_is_sriov_vf_v2(enic))
 		enic_admin_chan_reopen(enic);
 
+hang_reset_out:
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
 
 	call_netdevice_notifiers(NETDEV_REBOOT, enic->netdev);
 
+unlock:
 	rtnl_unlock();
 }
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index b8a18d9682b2..2d77d41577a3 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -149,7 +149,20 @@ static int enic_mbox_send_msg_id(struct enic *enic, u8 msg_type,
 		 * or free the buffer: the device may still DMA from dma_addr.
 		 * Mark the channel unusable so no further sends are attempted.
 		 */
+		spin_lock_bh(&enic->mbox_state_lock);
 		WRITE_ONCE(enic->mbox_send_disabled, true);
+		WRITE_ONCE(enic->mbox_tx_poisoned, true);
+		if (enic_is_sriov_vf_v2(enic)) {
+			/* The request may have changed PF receive policy even though
+			 * local descriptor ownership is still uncertain. Fail the VF
+			 * closed and do not turn this into an ordinary protocol
+			 * reconnect; the admin-channel lifecycle owns final reclamation.
+			 */
+			WRITE_ONCE(enic->vf_rx_quarantined, true);
+		}
+		spin_unlock_bh(&enic->mbox_state_lock);
+		if (enic_is_sriov_vf_v2(enic))
+			enic_mbox_vf_link_state_set_running(enic, false);
 	}
 
 	netdev_dbg(enic->netdev,
@@ -184,6 +197,105 @@ static int enic_mbox_send_reply(struct enic *enic, u8 msg_type,
 				     payload_len, msg_num, true, 0);
 }
 
+struct enic_mbox_vf_ack {
+	struct list_head list;
+	u64 msg_num;
+	u16 ret_major;
+	u8 msg_type;
+};
+
+static void enic_mbox_vf_ack_work(struct work_struct *work)
+{
+	struct enic *enic = container_of(work, struct enic, vf_ack_work);
+	struct enic_mbox_vf_ack *pending;
+
+	for (;;) {
+		struct enic_mbox_generic_reply ack = {};
+		u8 msg_type;
+		int err;
+
+		spin_lock_bh(&enic->vf_ack_lock);
+		if (list_empty(&enic->vf_ack_list)) {
+			spin_unlock_bh(&enic->vf_ack_lock);
+			break;
+		}
+		pending = list_first_entry(&enic->vf_ack_list,
+					   struct enic_mbox_vf_ack, list);
+		list_del(&pending->list);
+		enic->vf_ack_count--;
+		spin_unlock_bh(&enic->vf_ack_lock);
+
+		if (READ_ONCE(enic->mbox_send_disabled)) {
+			kfree(pending);
+			continue;
+		}
+
+		msg_type = pending->msg_type;
+		ack.ret_major = cpu_to_le16(pending->ret_major);
+		err = enic_mbox_send_reply(enic, msg_type, ENIC_MBOX_DST_PF,
+					   &ack, sizeof(ack), pending->msg_num);
+		kfree(pending);
+		if (err && net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: failed to send ACK type %u: %d\n",
+				    msg_type, err);
+	}
+}
+
+static void enic_mbox_vf_queue_ack(struct enic *enic, u8 msg_type,
+				   u64 msg_num, u16 ret_major)
+{
+	struct enic_mbox_vf_ack *pending;
+
+	if (READ_ONCE(enic->mbox_send_disabled))
+		return;
+	pending = kmalloc_obj(*pending, GFP_ATOMIC);
+	if (!pending) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: dropping ACK type %u: no memory\n",
+				    msg_type);
+		return;
+	}
+	pending->msg_num = msg_num;
+	pending->ret_major = ret_major;
+	pending->msg_type = msg_type;
+
+	spin_lock_bh(&enic->vf_ack_lock);
+	if (READ_ONCE(enic->mbox_send_disabled) ||
+	    enic->vf_ack_count >= ENIC_ADMIN_DESC_COUNT) {
+		spin_unlock_bh(&enic->vf_ack_lock);
+		kfree(pending);
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: dropping ACK type %u: queue unavailable\n",
+				    msg_type);
+		return;
+	}
+	list_add_tail(&pending->list, &enic->vf_ack_list);
+	enic->vf_ack_count++;
+	spin_unlock_bh(&enic->vf_ack_lock);
+	schedule_work(&enic->vf_ack_work);
+}
+
+void enic_mbox_vf_ack_cancel(struct enic *enic)
+{
+	struct enic_mbox_vf_ack *pending, *tmp;
+	LIST_HEAD(discard);
+
+	if (!enic->mbox_initialized)
+		return;
+	cancel_work_sync(&enic->vf_ack_work);
+	spin_lock_bh(&enic->vf_ack_lock);
+	list_splice_init(&enic->vf_ack_list, &discard);
+	enic->vf_ack_count = 0;
+	spin_unlock_bh(&enic->vf_ack_lock);
+	list_for_each_entry_safe(pending, tmp, &discard, list) {
+		list_del(&pending->list);
+		kfree(pending);
+	}
+}
+
 static int enic_mbox_vf_send_request(struct enic *enic, u8 request_type,
 				     u8 expected_reply, void *payload,
 				     u16 payload_len)
@@ -193,6 +305,26 @@ static int enic_mbox_vf_send_request(struct enic *enic, u8 request_type,
 				     expected_reply);
 }
 
+static void enic_mbox_vf_mark_reconnect_locked(struct enic *enic,
+					       bool registration_lost)
+{
+	lockdep_assert_held(&enic->mbox_state_lock);
+
+	if (registration_lost)
+		WRITE_ONCE(enic->vf_registered, false);
+	enic->vf_mbox_fault_generation++;
+	WRITE_ONCE(enic->vf_mbox_reconnect_required, true);
+	WRITE_ONCE(enic->mbox_send_disabled, true);
+	WRITE_ONCE(enic->vf_rx_quarantined, true);
+}
+
+static void enic_mbox_vf_kick_recovery(struct enic *enic)
+{
+	enic_mbox_vf_link_state_set_running(enic, false);
+	if (netif_running(enic->netdev))
+		schedule_work(&enic->reset);
+}
+
 static int enic_mbox_wait_reply(struct enic *enic, unsigned long timeout_ms)
 {
 	unsigned long left;
@@ -203,9 +335,9 @@ static int enic_mbox_wait_reply(struct enic *enic, unsigned long timeout_ms)
 	if (left)
 		return 0;
 
-	/* Invalidate a request that the handler has not already accepted.  A
-	 * delayed reply cannot match a later request because message numbers are
-	 * monotonic across channel reopen.
+	/* Invalidate a request that the handler has not already accepted. Whether
+	 * losing the reply invalidates the current protocol generation is an
+	 * operation-specific decision made by the caller.
 	 */
 	spin_lock_bh(&enic->mbox_state_lock);
 	if (enic->mbox_expected_reply) {
@@ -468,9 +600,8 @@ static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload,
 					   u64 msg_num)
 {
 	struct enic_mbox_pf_link_state_notif_msg *notif = payload;
-	struct enic_mbox_pf_link_state_ack_msg ack = {};
 	u32 link_state = le32_to_cpu(notif->link_state);
-	int err;
+	u16 ret_major = 0;
 
 	spin_lock_bh(&enic->vf_link_state_lock);
 	switch (link_state) {
@@ -491,16 +622,16 @@ static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload,
 	default:
 		netdev_warn(enic->netdev, "MBOX: unknown link state %u\n",
 			    link_state);
-		ack.ack.ret_major = cpu_to_le16(ENIC_MBOX_ERR_GENERIC);
+		ret_major = ENIC_MBOX_ERR_GENERIC;
 		break;
 	}
 	spin_unlock_bh(&enic->vf_link_state_lock);
 
-	err = enic_mbox_send_reply(enic, ENIC_MBOX_PF_LINK_STATE_ACK,
-				   ENIC_MBOX_DST_PF, &ack, sizeof(ack), msg_num);
-	if (err && net_ratelimit())
-		netdev_warn(enic->netdev,
-			    "MBOX: failed to send link state ACK: %d\n", err);
+	/* Notification dispatch must not wait behind a synchronous request send:
+	 * its matching reply may be queued behind this notification.
+	 */
+	enic_mbox_vf_queue_ack(enic, ENIC_MBOX_PF_LINK_STATE_ACK, msg_num,
+			       ret_major);
 }
 
 void enic_mbox_vf_link_state_reset(struct enic *enic)
@@ -525,6 +656,17 @@ void enic_mbox_vf_link_state_set_running(struct enic *enic, bool running)
 	spin_unlock_bh(&enic->vf_link_state_lock);
 }
 
+void enic_mbox_vf_require_reconnect(struct enic *enic)
+{
+	/* A fresh REGISTER transaction lets the PF discard any VF-requested
+	 * configuration whose final state became uncertain.
+	 */
+	spin_lock_bh(&enic->mbox_state_lock);
+	enic_mbox_vf_mark_reconnect_locked(enic, false);
+	spin_unlock_bh(&enic->mbox_state_lock);
+	enic_mbox_vf_kick_recovery(enic);
+}
+
 static bool enic_mbox_vf_payload_ok(struct enic *enic, u8 msg_type,
 				    u16 payload_len, size_t min_len)
 {
@@ -600,6 +742,8 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 			netdev_warn(enic->netdev,
 				    "MBOX: truncated message (len %u < %zu)\n",
 				    len, sizeof(*hdr));
+		if (!enic->vf_state)
+			enic_mbox_vf_require_reconnect(enic);
 		return;
 	}
 
@@ -756,7 +900,12 @@ void enic_mbox_init(struct enic *enic)
 		mutex_init(&enic->vf_mbox_request_lock);
 		init_completion(&enic->mbox_comp);
 		spin_lock_init(&enic->mbox_state_lock);
+		spin_lock_init(&enic->vf_ack_lock);
+		INIT_LIST_HEAD(&enic->vf_ack_list);
+		INIT_WORK(&enic->vf_ack_work, enic_mbox_vf_ack_work);
 		enic->mbox_msg_num = 0;
+		if (enic_is_sriov_vf_v2(enic))
+			WRITE_ONCE(enic->vf_rx_quarantined, true);
 		enic->mbox_initialized = true;
 	} else {
 		reinit_completion(&enic->mbox_comp);
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index 60409bad2f28..37bc41a900f4 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -90,6 +90,8 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state);
 void enic_mbox_vf_link_state_reset(struct enic *enic);
 void enic_mbox_vf_link_state_set_running(struct enic *enic, bool running);
+void enic_mbox_vf_ack_cancel(struct enic *enic);
+void enic_mbox_vf_require_reconnect(struct enic *enic);
 int enic_mbox_vf_capability_check(struct enic *enic);
 int enic_mbox_vf_register(struct enic *enic);
 int enic_mbox_vf_unregister(struct enic *enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
index ccbf5c9a21d0..80fe7e819c37 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -330,8 +330,6 @@ static void enic_rq_indicate_buf(struct enic *enic, struct vnic_rq *rq,
 	u16 bytes_written, vlan_tci, checksum;
 	u32 rss_hash;
 
-	rqstats->packets++;
-
 	cq_enet_rq_desc_dec((struct cq_enet_rq_desc *)cq_desc, &ingress_port,
 			    &fcoe, &eop, &sop, &rss_type, &csum_not_calc,
 			    &rss_hash, &bytes_written, &packet_error,
@@ -340,8 +338,15 @@ static void enic_rq_indicate_buf(struct enic *enic, struct vnic_rq *rq,
 			    &tcp_udp_csum_ok, &udp, &tcp, &ipv4_csum_ok, &ipv6,
 			    &ipv4, &ipv4_fragment, &fcs_ok);
 
-	if (enic_rq_pkt_error(rq, packet_error, fcs_ok, bytes_written))
+	if (enic_rq_pkt_error(rq, packet_error, fcs_ok, bytes_written)) {
+		rqstats->packets++;
+		return;
+	}
+	if (unlikely(READ_ONCE(enic->vf_rx_quarantined))) {
+		dev_core_stats_rx_dropped_inc(enic->netdev);
 		return;
+	}
+	rqstats->packets++;
 
 	if (eop && bytes_written > 0) {
 		/* Good receive

-- 
2.43.0

