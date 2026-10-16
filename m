Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2E42A178;
	Fri, 16 Oct 2026 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137561; cv=none; b=iiYBchhQmNWgWDMahE6yv4uX2OI/qIUp3uVostGw+RDljQFPq09D6XhQ6YCiVznn4G9USsfyOaVHJF8xkrQkAmvtrScJM+DAl8OBZ6b8cjKgzMFurQHlHgX1sEGzaKmtoIiTEymRsNR1GUlecixLfTLbJMmTIZ/6/1KyT0CnuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137561; c=relaxed/simple;
	bh=jqi3bWLCIAOaU5UUZhSfexkypBeKf2WukXYWukGyEHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNqMGaHoqN1ncU9Ek8z56cXI6KWV6ovK7YXQ4aqIwNJRaoEnOxy3VXSvE4m85DWoFVkibgBfz/YaiW6QtMd6muT99K7OXnP/IePJIlHwDMkgHi/tShxqpjphdBOKDYZvgNmE1qN6KTGEeIlTNA0y6Tht7NjsEJEEr8feS8gy3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=UMLJZgCm; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="UMLJZgCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=26239; q=dns/txt;
  s=iport01; t=1792137559; x=1793347159;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GRlQlSeYrnT3zoHelSb6Rxk8KQaviioq42jtO1KNiik=;
  b=UMLJZgCmlgIMeWaenlf61BCPfCS8oWkeS93NCjCfNxbAOma9PS5/sg7d
   ALqvJ9YoyFg/hYGoNYR/NvDfetjyqJ0Sx2SVEB7c++EKkGim2PgvzuT/A
   v1HKlhGyhj1KttWSE2XnJNcY0E9mNI7B0Dp7bn0ujUgl/6CyQi/SrEhvG
   G3g8bGmrZNKkgPag/MeI2jYeoUhZWXL9XZ67LUMRJ37+/Irc1CoXWghWc
   CRs0XJpMTDahRI9Q+Wgec2jqA+Jbntf6PL8kirnLObr7UlZqioN40FLfy
   7j+fJvIuN5HQ9J6NzQoiBANNjB1EP+9kHQ35gHf97gSMctKdRJZB409rH
   A==;
X-CSE-ConnectionGUID: Q4mpzuvHS4OHRzEHh5QSuA==
X-CSE-MsgGUID: HVwdKbD4SVuXJyz6NAMX+g==
X-IPAS-Result: =?us-ascii?q?A0AnAAAR2NFq/4z/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBVUNJhFeIG4c3giGBFpA3jFIUgWoPAQEBD1EEAQGCEoJzAo4VAiY0CQ4BA?=
 =?us-ascii?q?gQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZckBMCAQMaCQRSECUCJ?=
 =?us-ascii?q?gICRhAGARKDAoJ1A70zen8zgQGEftlKgWgBCxQBgQouAYVxgm0BgXGECDuEQ?=
 =?us-ascii?q?ScbgUlEgRWCc3aEHwuDdIJqBIINFXoShmiDK4cUhXoJP4ECHANZLAFVEw0KC?=
 =?us-ascii?q?wcFY1IzAyAKCxISGBUCFB0SDwQWMh1wDCcSLBcvWBsGBYEddRQEE4IWIxk2e?=
 =?us-ascii?q?oEJXoErKWABEBeBCYIHAoJUggACAUlBDgdFUwklQxJHJiIIEgkBExowC4EbO?=
 =?us-ascii?q?DwJKEEXDHECCQMdBU4CIggCDQkHKRgNSBEsNwYPGQQ9AW4HkhQegW0HLCUQE?=
 =?us-ascii?q?AEFCAgJDisBASEJCxM4AS8zDggBFBUXDhUHEB4JPJJjg36NXmuBNZ9ahCiBZ?=
 =?us-ascii?q?qAQM5dnkwiZCCOjTg8MTYRpgWg8gVkzGggbFYMiUxkPji4Wkx0BvxwnMj4BB?=
 =?us-ascii?q?wIHDwKBc5AABA0XgVYBAQ?=
IronPort-Data: A9a23:YveC5qu0SMSelNSjslNWdq9x1efnVIRfMUV32f8akzHdYApBsoF/q
 tZmKW7Qa6zbZDGmKNh/bYq28U4GsJGHmtRlTVM+/n0wRiNAgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrb/656yYsjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZzdJ5xYuajhKsvra9ks21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIww7pyGXNT6
 9wjdBctVAKup+Lr+YmmY7w57igjBJGD0II3oHpsy3TdSP0hW52GG/6M7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtPYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUoHRG50FxxjH+
 woq+UzZPA4WF9azlQG770KOl/2RuwreaMEdQejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdx61uniJulgbQdU4O+098gSW4qnZ+QCUAi4DVDEpQN87vsYeRjEw0
 FKN2dTzClRHubuZU3+CtbGZsT+/JwARMGkEIyQEJSMd6tPupoAblB/DTt9/VqWyi7XdHTD23
 iDPryUkgbgXpdAE2r/9/l3dhT+o4J/TQWYd4AjLUm+7xh12aZTjZIGy71Xfq/FaI+6kokKpp
 nMInY2aqesJF5zIzHfLS+QWF7bv7PGAWNHBvWNS81Aa32zF0xaekUp4uVmS+G8B3h44RALU
IronPort-HdrOrdr: A9a23:y7N8PK9MvIhfSme5Ujtuk+AuI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rOoB1773HJYVkqNU3I9errBEDEewK/yXcX2+Ys1MmZPDUO0VHAROpfBMnZsl7d8kbFmtK1u5
 0QFpRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DsgfZvln6HZWkdaNi9Cz0uWujOoMCOqbfdCCR2fyLOLGK1/EmVAHmQKWni4isj
X-Talos-CUID: 9a23:XdFqVG638N0GLJjtudsszRIRAtI4bF3mkFDwGV2VKWY0cYaIYArF
X-Talos-MUID: 9a23:A0dt5QqvS9Zi7THmArwezxFcK8tL6YjyM34QobcXqZeiHAlAeDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,161,1787011200"; 
   d="scan'208";a="536081675"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 16 Oct 2026 07:58:10 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 6BB13180005B9;
	Fri, 16 Oct 2026 07:58:09 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 16 Oct 2026 00:57:52 -0700
Subject: [PATCH net 2/3] enic: retain admin-channel DMA until queues stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-2-d27b55f69883@cisco.com>
References: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883@cisco.com>
In-Reply-To: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792137487; l=27059;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=jqi3bWLCIAOaU5UUZhSfexkypBeKf2WukXYWukGyEHk=;
 b=M7uV7X/LFPjpP1fYGR/Whqub1Z26Ab/Q2Dfc//f2p20DEowbARlIthkXuOLSWHqc/ppTCdo/Y
 D8dUuCBCDA8AjlIhO9Gk/MMx2IQakExgPfFtgoHZWQgc7YfB3yfUcom
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-03.cisco.com

A timed-out admin WQ send leaves ownership of its descriptor and mapped
message unresolved. Independently, an admin RQ disable can time out
without observing RUNNING == 0, leaving DMA ownership of its posted
receive buffers and associated completion state unresolved. Channel close
currently logs WQ and RQ disable failures, then cleans and frees the full
WQ/RQ/CQ allocation graph.

Track the admin channel as DOWN, LIVE, or QUARANTINED. Block new
mailbox sends, stop its CPU callbacks, and take mbox_lock to wait for any
in-flight sender before disabling the queues. Release the graph only after
the WQ disable succeeds and both passes of the RQ disable succeed. The
preceding datapath fix gives every RUNNING poll a driver-chosen 500 ms
bound and preserves the two RQ passes required for its mini-cache. Run
each queue's complete disable helper once, then retry once only a helper
that timed out. Quarantine the graph if either retry still times out.

A mailbox send timeout alone is not terminal. Its mapping remains
attached to the live WQ, and a later clean WQ/RQ stop supplies
the ownership proof needed to release the graph. Only failure of a
queue-disable RUNNING check makes the admin graph quarantined.

Keep the admin and generic datapath ownership graphs independent. If
the admin graph is quarantined, stop the generic datapath and release
its queue resources only if all of its work and receive queues stop.
Likewise, a quarantined datapath does not prevent release of an admin
graph whose queues both stop. Do not partially release an individual graph
when only some of its queues stop. Retain the shared netdev, vnic_dev, BAR
mappings, PCI reservations, and any unresolved vNIC DMA target whenever
either complete graph remains quarantined.

Soft reset, hang reset, and PCI function reset do not provide an
independent ownership fence for a queue whose stop could not be
confirmed. Clear bus mastering to contain the function, detach software
entry points, and retain each quarantined graph during runtime. Clearing
bus mastering does not cancel DMA already in progress or prevent the final
remove-time
RUNNING recheck from observing a queue which subsequently drains.

Apply the ownership rules to partial open, reset, SR-IOV disable,
probe unwind, and remove. A reset worker encountering terminal admin
quarantine only converges the independent datapath to a stopped state;
it does not issue a firmware reset or reopen either graph.

At remove, after all CPU entry points have been detached, make one final
direct disable/RUNNING check of the quarantined admin WQ and RQ. Release
the complete admin graph if both queues have now stopped. Otherwise
retain it with the shared owner objects until reboot.

The issue was found while reviewing the V2 VF receive-control series
after its mailbox timeout path deliberately retained a DMA mapping. The
audit showed that admin-channel close could nevertheless free its owner
graph after an unconfirmed queue stop.

Fixes: 3258931d4052 ("enic: add admin channel open and close for SR-IOV")
Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Reviewed-by: Aravind Dhanasekaran <aradhana@cisco.com>
Reviewed-by: Reese Faucette <rfaucett@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |  13 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c | 171 +++++++++++++++++++-------
 drivers/net/ethernet/cisco/enic/enic_admin.h |   4 +-
 drivers/net/ethernet/cisco/enic/enic_main.c  | 175 ++++++++++++++++++++-------
 drivers/net/ethernet/cisco/enic/enic_mbox.c  |   1 +
 5 files changed, 274 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 992ac43d1b0a..cf2dee8fa78f 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -306,13 +306,16 @@ struct enic {
 
 	/* Admin channel resources for SR-IOV MBOX */
 	bool has_admin_channel;
-	/* true only while the admin WQ/RQ/CQ are allocated and enabled; gates
-	 * enic_admin_channel_close() so it is a no-op after a failed (re)open
-	 * left the resources freed.
+	/* DOWN has no allocated admin DMA resources. QUARANTINED retains the
+	 * complete graph after a WQ or RQ failed to stop.
 	 */
-	bool admin_chan_up;
-	/* set on send timeout; cleared on channel re-open */
+	enum enic_dma_state admin_chan_state;
+	/* Blocks sends while the channel is closed or awaiting recovery. */
 	bool mbox_send_disabled;
+	/* A send timeout leaves a descriptor hardware-owned until both queues
+	 * report RUNNING == 0.
+	 */
+	bool mbox_tx_poisoned;
 	struct vnic_wq admin_wq;
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 61c82b48044d..a5c08cbcb339 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -530,11 +530,22 @@ static void enic_admin_msg_drain(struct enic *enic)
 
 int enic_admin_channel_open(struct enic *enic)
 {
+	int close_err;
 	int err;
 
 	if (!enic->has_admin_channel)
 		return -ENODEV;
-
+	if (READ_ONCE(enic->admin_chan_state) != ENIC_DMA_DOWN) {
+		netdev_err(enic->netdev,
+			   "Refusing to open non-down admin channel (%u)\n",
+			   READ_ONCE(enic->admin_chan_state));
+		return -EBUSY;
+	}
+	if (READ_ONCE(enic->mbox_tx_poisoned)) {
+		netdev_err(enic->netdev,
+			   "Refusing to reopen poisoned admin channel\n");
+		return -EIO;
+	}
 	/* Keep MBOX sends disabled for the entire open sequence.  It is
 	 * cleared only after every resource is allocated and enabled below,
 	 * so any early error return here leaves sends disabled and a
@@ -567,6 +578,7 @@ int enic_admin_channel_open(struct enic *enic)
 
 	vnic_wq_enable(&enic->admin_wq);
 	vnic_rq_enable(&enic->admin_rq);
+	WRITE_ONCE(enic->admin_chan_state, ENIC_DMA_LIVE);
 
 	err = enic_admin_rq_fill(enic, GFP_KERNEL);
 	if (err) {
@@ -600,68 +612,141 @@ int enic_admin_channel_open(struct enic *enic)
 		   enic->admin_cq[0].last_color,
 		   enic->admin_cq[1].last_color);
 
-	enic->admin_chan_up = true;
-
 	return 0;
 
 disable_queues:
-	enic_admin_teardown_intr(enic);
-	enic_admin_qp_type_set(enic, QP_DISABLE);
-	if (vnic_wq_disable(&enic->admin_wq))
-		netdev_warn(enic->netdev, "Failed to disable admin WQ\n");
-	if (vnic_rq_disable(&enic->admin_rq))
-		netdev_warn(enic->netdev, "Failed to disable admin RQ\n");
-	cancel_work_sync(&enic->admin_msg_work);
-	enic_admin_msg_drain(enic);
-	enic_admin_rq_drain(enic);
+	close_err = enic_admin_channel_close(enic);
+	if (close_err)
+		netdev_err(enic->netdev,
+			   "Failed to close partial admin channel: %d\n",
+			   close_err);
+	return err;
 free_resources:
 	enic_admin_free_resources(enic);
 	return err;
 }
 
-void enic_admin_channel_close(struct enic *enic)
+static void enic_admin_channel_release(struct enic *enic)
 {
-	int err;
+	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
+	enic_admin_rq_drain(enic);
+	vnic_cq_clean(&enic->admin_cq[0]);
+	vnic_cq_clean(&enic->admin_cq[1]);
+	vnic_intr_clean(&enic->admin_intr);
 
-	if (!enic->has_admin_channel)
-		return;
+	enic->admin_rq_handler = NULL;
+	enic_admin_free_resources(enic);
+	WRITE_ONCE(enic->admin_chan_state, ENIC_DMA_DOWN);
+}
 
-	/* Nothing to tear down if the channel was never (re)opened, e.g. a
-	 * failed enic_admin_channel_open() in probe or in the reset path;
-	 * otherwise the disable/clean calls below dereference freed resources.
-	 */
-	if (!enic->admin_chan_up)
-		return;
+int enic_admin_channel_close(struct enic *enic)
+{
+	int qp_err;
+	int rq_err;
+	int wq_err;
+
+	if (!enic->has_admin_channel)
+		return 0;
+	if (READ_ONCE(enic->admin_chan_state) == ENIC_DMA_DOWN)
+		return 0;
+	if (READ_ONCE(enic->admin_chan_state) == ENIC_DMA_QUARANTINED)
+		return -EBUSY;
 
 	WRITE_ONCE(enic->mbox_send_disabled, true);
 
-	netdev_dbg(enic->netdev, "admin channel close\n");
+	if (READ_ONCE(enic->admin_chan_state) == ENIC_DMA_LIVE) {
+		netdev_dbg(enic->netdev, "admin channel quiesce\n");
 
-	vnic_intr_mask(&enic->admin_intr);
-	enic_admin_teardown_intr(enic);
-	cancel_work_sync(&enic->link_notify_work);
-	cancel_work_sync(&enic->admin_msg_work);
-	enic_admin_msg_drain(enic);
+		vnic_intr_mask(&enic->admin_intr);
+		enic_admin_teardown_intr(enic);
+		cancel_work_sync(&enic->link_notify_work);
+		cancel_work_sync(&enic->admin_msg_work);
+		enic_admin_msg_drain(enic);
+	}
 
-	enic_admin_qp_type_set(enic, QP_DISABLE);
+	/* A sender may have passed the gate before it was raised.  Wait only
+	 * after cancelling workers which can themselves wait for mbox_lock.
+	 */
+	mutex_lock(&enic->mbox_lock);
+	qp_err = enic_admin_qp_type_set(enic, QP_DISABLE);
+	if (qp_err)
+		netdev_warn(enic->netdev,
+			    "Failed to disable admin QP type: %d\n", qp_err);
 
-	err = vnic_wq_disable(&enic->admin_wq);
-	if (err)
+	wq_err = vnic_wq_disable(&enic->admin_wq);
+	rq_err = vnic_rq_disable(&enic->admin_rq);
+
+	/* Run both complete disable helpers once before retrying only a helper
+	 * which timed out.
+	 */
+	if (wq_err)
+		wq_err = vnic_wq_disable(&enic->admin_wq);
+	if (rq_err)
+		rq_err = vnic_rq_disable(&enic->admin_rq);
+
+	if (wq_err)
 		netdev_warn(enic->netdev,
-			    "Failed to disable admin WQ: %d\n", err);
-	err = vnic_rq_disable(&enic->admin_rq);
-	if (err)
+			    "Failed to disable admin WQ after retry: %d\n",
+			    wq_err);
+	if (rq_err)
 		netdev_warn(enic->netdev,
-			    "Failed to disable admin RQ: %d\n", err);
+			    "Failed to disable admin RQ after retry: %d\n",
+			    rq_err);
 
-	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
-	enic_admin_rq_drain(enic);
-	vnic_cq_clean(&enic->admin_cq[0]);
-	vnic_cq_clean(&enic->admin_cq[1]);
-	vnic_intr_clean(&enic->admin_intr);
+	/* QP_DISABLE does not report every low-level stop failure.  The direct
+	 * WQ/RQ RUNNING observations own the admin allocation graph.
+	 */
+	if (wq_err || rq_err) {
+		WRITE_ONCE(enic->admin_chan_state, ENIC_DMA_QUARANTINED);
+		WRITE_ONCE(enic->mbox_tx_poisoned, true);
+		mutex_unlock(&enic->mbox_lock);
+		netif_device_detach(enic->netdev);
+		netif_carrier_off(enic->netdev);
+		/* Stop new PCIe requests without treating bus-master disable as
+		 * proof that already-issued DMA has completed.
+		 */
+		pci_clear_master(enic->pdev);
+		return wq_err ?: rq_err;
+	}
 
-	enic->admin_rq_handler = NULL;
-	enic_admin_free_resources(enic);
+	enic_admin_channel_release(enic);
+	WRITE_ONCE(enic->mbox_tx_poisoned, false);
+	mutex_unlock(&enic->mbox_lock);
+
+	/* Firmware rejection does not undermine the WQ/RQ proof. */
+	return qp_err;
+}
+
+int enic_admin_channel_recheck_on_remove(struct enic *enic)
+{
+	int rq_err;
+	int wq_err;
+
+	if (READ_ONCE(enic->admin_chan_state) != ENIC_DMA_QUARANTINED)
+		return 0;
+
+	/* Channel close already detached every CPU entry point and attempted
+	 * QP_DISABLE.  Removal is the last direct check of queue ownership.
+	 */
+	mutex_lock(&enic->mbox_lock);
+	wq_err = vnic_wq_disable(&enic->admin_wq);
+	rq_err = vnic_rq_disable(&enic->admin_rq);
+	if (wq_err || rq_err) {
+		mutex_unlock(&enic->mbox_lock);
+		return wq_err ?: rq_err;
+	}
 
-	enic->admin_chan_up = false;
+	enic_admin_channel_release(enic);
+	WRITE_ONCE(enic->mbox_tx_poisoned, false);
+	mutex_unlock(&enic->mbox_lock);
+	netdev_info(enic->netdev,
+		    "Admin queues stopped at remove; releasing DMA graph\n");
+
+	return 0;
+}
+
+bool enic_admin_channel_is_quarantined(const struct enic *enic)
+{
+	return READ_ONCE(enic->admin_chan_state) ==
+		ENIC_DMA_QUARANTINED;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.h b/drivers/net/ethernet/cisco/enic/enic_admin.h
index 62c80220b0ca..5945bbb2e6d4 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.h
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.h
@@ -20,7 +20,9 @@ struct enic_admin_msg {
 };
 
 int enic_admin_channel_open(struct enic *enic);
-void enic_admin_channel_close(struct enic *enic);
+int enic_admin_channel_close(struct enic *enic);
+int enic_admin_channel_recheck_on_remove(struct enic *enic);
+bool enic_admin_channel_is_quarantined(const struct enic *enic);
 unsigned int enic_admin_wq_cq_service(struct enic *enic);
 unsigned int enic_admin_rq_cq_service(struct enic *enic);
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 5a205ea3031b..06d76648b420 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -71,6 +71,7 @@
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2   0x02b7  /* enet SRIOV V2 VF */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF_USNIC 0x00cf /* enet USNIC VF */
 
+static bool enic_dma_quarantined(struct enic *enic);
 static void enic_terminal_dma_quarantine(struct enic *enic);
 
 /* Supported devices */
@@ -1729,11 +1730,15 @@ static void enic_notify_timer_start(struct enic *enic)
 	}
 }
 
-static void enic_datapath_release(struct enic *enic)
+static void enic_datapath_release(struct enic *enic, bool release_notify)
 {
 	unsigned int i;
 
-	enic_dev_notify_unset(enic);
+	/* The notification allocation is a separate vNIC DMA target.  Keep it
+	 * with the shared lifetime envelope if another DMA graph is quarantined.
+	 */
+	if (release_notify)
+		enic_dev_notify_unset(enic);
 
 	enic_unset_affinity_hint(enic);
 	enic_free_intr(enic);
@@ -1899,7 +1904,7 @@ static int enic_open(struct net_device *netdev)
 		enic_datapath_quarantine(enic);
 		return err;
 	}
-	enic_datapath_release(enic);
+	enic_datapath_release(enic, true);
 
 	return err;
 
@@ -1974,7 +1979,8 @@ static int enic_stop(struct net_device *netdev)
 		return disable_err;
 	}
 
-	enic_datapath_release(enic);
+	enic_datapath_release(enic,
+			      !enic_admin_channel_is_quarantined(enic));
 
 	return 0;
 }
@@ -2328,18 +2334,30 @@ static void enic_admin_chan_reopen(struct enic *enic)
 	if (enic_is_sriov_vf_v2(enic)) {
 		err = enic_mbox_vf_capability_check(enic);
 		if (err) {
+			int close_err;
+
 			netdev_err(enic->netdev,
 				   "MBOX capability check after reset failed: %d\n",
 				   err);
-			enic_admin_channel_close(enic);
+			close_err = enic_admin_channel_close(enic);
+			if (close_err)
+				netdev_err(enic->netdev,
+					   "Admin close after capability failure failed: %d\n",
+					   close_err);
 			return;
 		}
 		err = enic_mbox_vf_register(enic);
 		if (err) {
+			int close_err;
+
 			netdev_err(enic->netdev,
 				   "MBOX VF re-registration after reset failed: %d\n",
 				   err);
-			enic_admin_channel_close(enic);
+			close_err = enic_admin_channel_close(enic);
+			if (close_err)
+				netdev_err(enic->netdev,
+					   "Admin close after registration failure failed: %d\n",
+					   close_err);
 		}
 	} else {
 		/* The link came back up during enic_open() above while MBOX
@@ -2355,9 +2373,14 @@ static void enic_reset(struct work_struct *work)
 	struct enic *enic = container_of(work, struct enic, reset);
 	int stop_err = 0;
 	bool reopen;
+	int err;
 
-	if (enic_datapath_is_quarantined(enic) ||
-	    !netif_running(enic->netdev))
+	if (enic_datapath_is_quarantined(enic))
+		return;
+	if (enic_admin_channel_is_quarantined(enic) &&
+	    READ_ONCE(enic->datapath_state) != ENIC_DMA_LIVE)
+		return;
+	if (!netif_running(enic->netdev))
 		return;
 
 	rtnl_lock();
@@ -2368,22 +2391,27 @@ static void enic_reset(struct work_struct *work)
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
 
-	/* Fully tear down the V2 admin/MBOX channel before the soft reset.
-	 * The reset wipes all hardware queues including the admin WQ/RQ;
-	 * closing first tells firmware to stop the admin QP (so it no longer
-	 * DMAs from the about-to-be-reset rings) and frees the admin resources
-	 * so they are cleanly re-allocated afterwards.
+	/* Stop the V2 admin/MBOX graph before the soft reset.  A queue timeout
+	 * quarantines that graph permanently; continue only far enough to stop
+	 * and, when possible, release the independent datapath graph.
 	 */
-	if (enic_has_admin_chan(enic))
-		enic_admin_channel_close(enic);
+	if (enic_has_admin_chan(enic)) {
+		err = enic_admin_channel_close(enic);
+		if (err && enic_admin_channel_is_quarantined(enic))
+			netdev_err(enic->netdev,
+				   "Admin queue did not stop: %d\n", err);
+		else if (err)
+			netdev_warn(enic->netdev,
+				    "Admin QP disable returned: %d\n", err);
+	}
 
 	if (reopen)
 		stop_err = enic_stop(enic->netdev);
 	if (enic_is_sriov_vf_v2(enic))
 		enic_mbox_vf_link_state_reset(enic);
-	if (enic_datapath_is_quarantined(enic)) {
+	if (enic_dma_quarantined(enic)) {
 		netdev_err(enic->netdev,
-			   "Datapath queue did not stop: %d; DMA resources retained until reboot\n",
+			   "Queue DMA ownership unresolved (datapath stop %d); resources retained until reboot\n",
 			   stop_err);
 		goto reset_out;
 	}
@@ -2398,13 +2426,17 @@ static void enic_reset(struct work_struct *work)
 	if (reopen)
 		enic_open(enic->netdev);
 
-	/* Re-establish the admin/MBOX channel after the data path is back up.
-	 * It was fully torn down by enic_admin_channel_close() above;
-	 * enic_admin_chan_reopen() reopens it and, for a PF re-pushes link
-	 * state, or for a VF re-runs the probe-time PF handshake.
+	/* Re-establish the admin/MBOX channel after its clean stop.  For a PF,
+	 * re-push link state; for a VF, rerun the probe-time PF handshake.
 	 */
 	if (enic_has_admin_chan(enic))
 		enic_admin_chan_reopen(enic);
+	if (enic_admin_channel_is_quarantined(enic)) {
+		stop_err = enic_stop(enic->netdev);
+		netdev_err(enic->netdev,
+			   "Admin queue did not stop after reopen failure (datapath stop %d); resources retained until reboot\n",
+			   stop_err);
+	}
 
 reset_out:
 	/* Allow infiniband to fiddle with the device again */
@@ -2422,30 +2454,39 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	struct enic *enic = container_of(work, struct enic, tx_hang_reset);
 	int stop_err = 0;
 	bool reopen;
+	int err;
 
 	rtnl_lock();
 	reopen = netif_running(enic->netdev);
-	if (!reopen || enic_datapath_is_quarantined(enic))
+	if (enic_datapath_is_quarantined(enic) ||
+	    (enic_admin_channel_is_quarantined(enic) &&
+	     READ_ONCE(enic->datapath_state) != ENIC_DMA_LIVE) || !reopen)
 		goto unlock;
 
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
 
-	/* Fully tear down the V2 admin/MBOX channel before the hang reset, for
-	 * the same reason as the soft reset path: stop the admin QP and free
-	 * the admin resources before the hardware queues are wiped.
+	/* Stop the V2 admin/MBOX graph before the hang reset.  As in the soft
+	 * reset path, a queue timeout is terminal for that graph.
 	 */
-	if (enic_has_admin_chan(enic))
-		enic_admin_channel_close(enic);
+	if (enic_has_admin_chan(enic)) {
+		err = enic_admin_channel_close(enic);
+		if (err && enic_admin_channel_is_quarantined(enic))
+			netdev_err(enic->netdev,
+				   "Admin queue did not stop: %d\n", err);
+		else if (err)
+			netdev_warn(enic->netdev,
+				    "Admin QP disable returned: %d\n", err);
+	}
 
 	enic_dev_hang_notify(enic);
 	if (reopen)
 		stop_err = enic_stop(enic->netdev);
 	if (enic_is_sriov_vf_v2(enic))
 		enic_mbox_vf_link_state_reset(enic);
-	if (enic_datapath_is_quarantined(enic)) {
+	if (enic_dma_quarantined(enic)) {
 		netdev_err(enic->netdev,
-			   "Datapath queue did not stop: %d; DMA resources retained until reboot\n",
+			   "Queue DMA ownership unresolved (datapath stop %d); resources retained until reboot\n",
 			   stop_err);
 		goto hang_reset_out;
 	}
@@ -2460,13 +2501,17 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	if (reopen)
 		enic_open(enic->netdev);
 
-	/* Re-establish the admin/MBOX channel after the data path is back up.
-	 * It was fully torn down by enic_admin_channel_close() above;
-	 * enic_admin_chan_reopen() reopens it and, for a PF re-pushes link
-	 * state, or for a VF re-runs the probe-time PF handshake.
+	/* Re-establish the admin/MBOX channel after its clean stop.  For a PF,
+	 * re-push link state; for a VF, rerun the probe-time PF handshake.
 	 */
 	if (enic_has_admin_chan(enic))
 		enic_admin_chan_reopen(enic);
+	if (enic_admin_channel_is_quarantined(enic)) {
+		stop_err = enic_stop(enic->netdev);
+		netdev_err(enic->netdev,
+			   "Admin queue did not stop after reopen failure (datapath stop %d); resources retained until reboot\n",
+			   stop_err);
+	}
 
 hang_reset_out:
 	/* Allow infiniband to fiddle with the device again */
@@ -2998,6 +3043,7 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 static int __maybe_unused
 enic_sriov_v2_enable(struct enic *enic, int num_vfs)
 {
+	int close_err;
 	int err;
 
 	if (!enic->has_admin_channel) {
@@ -3037,15 +3083,26 @@ enic_sriov_v2_enable(struct enic *enic, int num_vfs)
 
 close_admin:
 	enic->num_vfs = 0;
-	enic_admin_channel_close(enic);
+	close_err = enic_admin_channel_close(enic);
+	if (close_err)
+		netdev_err(enic->netdev,
+			   "Failed to close admin channel: %d\n", close_err);
 free_vf_state:
 	kfree(enic->vf_state);
 	enic->vf_state = NULL;
+	/* The reset worker only converges the independent datapath to a stopped
+	 * state after terminal admin-queue failure; it does not issue a reset.
+	 */
+	if (enic_admin_channel_is_quarantined(enic) &&
+	    netif_running(enic->netdev))
+		schedule_work(&enic->reset);
 	return err;
 }
 
 static void enic_sriov_v2_disable(struct enic *enic)
 {
+	int close_err;
+
 	/* Stop new VF link-state broadcasts before tearing down vf_state.
 	 * Clearing ENIC_SRIOV_ENABLED makes enic_link_check() (called from
 	 * the notify timer/ISR) skip the VF notify path, and cancelling
@@ -3056,10 +3113,16 @@ static void enic_sriov_v2_disable(struct enic *enic)
 	cancel_work_sync(&enic->link_notify_work);
 
 	pci_disable_sriov(enic->pdev);
-	enic_admin_channel_close(enic);
+	close_err = enic_admin_channel_close(enic);
+	if (close_err)
+		netdev_err(enic->netdev,
+			   "Failed to close admin channel: %d\n", close_err);
 	kfree(enic->vf_state);
 	enic->vf_state = NULL;
 	enic->num_vfs = 0;
+	if (enic_admin_channel_is_quarantined(enic) &&
+	    netif_running(enic->netdev))
+		schedule_work(&enic->reset);
 }
 
 /*
@@ -3346,7 +3409,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (err) {
 			dev_err(dev,
 				"Failed to open admin channel: %d\n", err);
-			goto err_out_dev_deinit;
+			goto err_out_admin_fence;
 		}
 		err = enic_mbox_vf_capability_check(enic);
 		if (err) {
@@ -3491,6 +3554,8 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_out_admin_close:
 	if (enic_is_sriov_vf_v2(enic)) {
+		int close_err;
+
 		if (READ_ONCE(enic->vf_registered)) {
 			int unreg_err = enic_mbox_vf_unregister(enic);
 
@@ -3499,12 +3564,24 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 					    "Failed to unregister from PF: %d\n",
 					    unreg_err);
 		}
-		enic_admin_channel_close(enic);
+		close_err = enic_admin_channel_close(enic);
+		if (close_err)
+			netdev_err(netdev,
+				   "Failed to close admin channel: %d\n",
+				   close_err);
+	}
+err_out_admin_fence:
+	if (enic_dma_quarantined(enic)) {
+		dev_err(dev,
+			"Queue DMA ownership unresolved; retaining probe resources until reboot\n");
+		enic_terminal_dma_quarantine(enic);
+		pci_disable_device(pdev);
+		return err;
 	}
-err_out_dev_deinit:
 	enic_dev_deinit(enic);
 err_out_dev_close:
 	vnic_dev_close(enic->vdev);
+	goto err_out_disable_sriov;
 err_out_disable_sriov:
 	kfree(enic->pp);
 err_out_disable_sriov_pp:
@@ -3528,6 +3605,12 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return err;
 }
 
+static bool enic_dma_quarantined(struct enic *enic)
+{
+	return enic_datapath_is_quarantined(enic) ||
+	       enic_admin_channel_is_quarantined(enic);
+}
+
 static int enic_datapath_recheck_on_remove(struct enic *enic)
 {
 	int disable_err = 0;
@@ -3555,7 +3638,8 @@ static int enic_datapath_recheck_on_remove(struct enic *enic)
 
 	dev_info(&enic->pdev->dev,
 		 "All datapath queues stopped at remove; releasing DMA graph\n");
-	enic_datapath_release(enic);
+	enic_datapath_release(enic,
+			      !enic_admin_channel_is_quarantined(enic));
 
 	return 0;
 }
@@ -3568,6 +3652,7 @@ static void enic_terminal_dma_quarantine(struct enic *enic)
 	 * ordinary stop path can return before freeing IRQs when a queue does
 	 * not stop, so each ownership-aware operation must be idempotent.
 	 */
+	WRITE_ONCE(enic->mbox_send_disabled, true);
 	for (i = 0; i < enic->intr_count; i++) {
 		vnic_intr_mask(&enic->intr[i]);
 		(void)vnic_intr_masked(&enic->intr[i]);
@@ -3604,6 +3689,8 @@ static void enic_remove(struct pci_dev *pdev)
 		 * touching a netdev that is being torn down.
 		 */
 		if (enic_is_sriov_vf_v2(enic)) {
+			int close_err;
+
 			if (READ_ONCE(enic->vf_registered)) {
 				int unreg_err = enic_mbox_vf_unregister(enic);
 
@@ -3612,7 +3699,11 @@ static void enic_remove(struct pci_dev *pdev)
 						    "Failed to unregister from PF: %d\n",
 						    unreg_err);
 			}
-			enic_admin_channel_close(enic);
+			close_err = enic_admin_channel_close(enic);
+			if (close_err)
+				netdev_warn(netdev,
+					    "Admin close returned: %d\n",
+					    close_err);
 		}
 
 		unregister_netdev(netdev);
@@ -3630,9 +3721,11 @@ static void enic_remove(struct pci_dev *pdev)
 				pci_disable_sriov(pdev);
 		}
 #endif
+		if (enic_admin_channel_is_quarantined(enic))
+			enic_admin_channel_recheck_on_remove(enic);
 		if (enic_datapath_is_quarantined(enic))
 			enic_datapath_recheck_on_remove(enic);
-		if (enic_datapath_is_quarantined(enic)) {
+		if (enic_dma_quarantined(enic)) {
 			dev_err(&pdev->dev,
 				"Queue DMA ownership unresolved; retaining resources until reboot\n");
 			enic_terminal_dma_quarantine(enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 5c93ca49552a..e106ee7d411d 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -150,6 +150,7 @@ static int enic_mbox_send_msg_id(struct enic *enic, u8 msg_type,
 		 * Mark the channel unusable so no further sends are attempted.
 		 */
 		WRITE_ONCE(enic->mbox_send_disabled, true);
+		WRITE_ONCE(enic->mbox_tx_poisoned, true);
 	}
 
 	netdev_dbg(enic->netdev,

-- 
2.43.0

