Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076DF4D596C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548131; cv=none; b=kV/Wpx+B5XEIedYTAhf5jBXDrNkVsAA61g1dy3OQGYNOxmMtIUMVFxZCU32adFezyx9MkNZ+2kK/lqIEKE8AkICYvStqGH8n/yDibzcfnb62ME6LyhnZfWlK44BkV7pEvHhTMvdzUC8p0NgKURLL9WY7ErmFa/Q2oS0HLaTuTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548131; c=relaxed/simple;
	bh=8JXCopxtTF1q9Xw7IB1+0wJjahNlsCb7468ZOLHhaEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQDJJj03L+VR4NoVGdc1SDNUf7KSJOkt89+TWOwRp4eRjCOyz72HRobxDXDohSs1DpuAH9Pkqe5pKg6/qrarQddX9Iup8a4ym2yWJMRyg30t7oT+QWAgVZZePYEqpkNTMCqFLdgl67e3TPOPeg3dTrBO9Az1+0O6TEi2FphYLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/hHYlxL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/hHYlxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791548119; x=1823084119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8JXCopxtTF1q9Xw7IB1+0wJjahNlsCb7468ZOLHhaEU=;
  b=m/hHYlxLsLHQnONuEANlI0E9qbyJGWyuU1u2AkU93de2zvUuqCE+l+AB
   eSPKwLB8YF5VKM74xf2caLakpcAJ8e3pkg1y16B1IZFJoRS5IDtQ56uXl
   Trs/rzy2YaBRU8STQAW0VXv1zwZJQhRDcNwUJoNLGNiM/G7Z7i+T0WKW6
   moe8ZP8pEeVXEHnqh88xbQrey1XmASbvCMjEdn5L5q4pY0VZQbjjmDr6d
   tYYLkQBw4rTP87YTeiigdyy62L8sYNpj+KpfGUDBlON8e+3sH61OgdYzc
   WylYrkE+4OwqxXxzNfu720AGXDDRmzFYEmd4VmiA+mBjsqOYNBWWfmJCm
   w==;
X-CSE-ConnectionGUID: eNOwya0RTX2Smq5fYJzeUQ==
X-CSE-MsgGUID: co248IlBQRqsyqv/Y7plqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251168"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251168"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:14:59 -0700
X-CSE-ConnectionGUID: Yniz8Aj6Sau+pB7Wq9RSNQ==
X-CSE-MsgGUID: dLnNs6+bQGa5a4DPvkN1zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420446"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:14:54 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E3CC42FC47;
	Fri,  9 Oct 2026 13:14:51 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jonathan Corbet <corbet@lwn.net>,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	anzaki@gmail.com,
	brett.creeley@amd.com,
	jtornosm@redhat.com,
	ohartoov@nvidia.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 07/14] iavf: extend iavf_configure_queues() to support more queues
Date: Fri,  9 Oct 2026 14:04:18 +0200
Message-ID: <20261009121433.30347-8-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend iavf_configure_queues() to support more queue pairs than fit
into a single virtchnl message (62).
Virtchnl opcode used was already generic, but we have just not needed
more than one message before.

Send the messages one by one, waiting for the PF reply to each of them
with iavf_poll_virtchnl_response(), similar to iavf_set_mac_sync().
That keeps only one virtchnl op in flight, without the need to track
across watchdog runs what was already sent (as iavf_add_ether_addrs()
does for MAC filters). So the op becomes synchronous also for the
single message case: the watchdog, holding netdev_lock, waits up to 1s
for each reply.

Stop at the first PF NACK, without a retry, as before. On timeout keep
the op pending, as PF may still reply; once it does, the whole
configuration is resent.

Add helper, iavf_max_vc_entries(), that determines how many entries we
could fit into virtchnl message (ending by flex array member). Will be
also used on another op later in this series.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
 * fix typo (Sashiko)
 * abort iavf_configure_queues() at error (Sashiko)
 * report send and poll failures with dev_err(), they are not
   recoverable here (me)
 * cast via uintptr_t in iavf_match_vc_op_cb(), for clang W=1
   -Wpointer-to-enum-cast
 * commit message: the limit is the number of queue pairs that fit
   into a single virtchnl message (62), not 31
 * commit message: describe the switch to a synchronous op (Sashiko)
 * stop at PF NACK (Sashiko)
 * on timeout keep current_op and IAVF_FLAG_AQ_CONFIGURE_QUEUES set
   until the late reply arrives, instead of resending right away;
   clear both on other errors (no retry) (Sashiko)
 * fix dev_err() continuation alignment (Sashiko)
---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 86 ++++++++++++++++---
 1 file changed, 75 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index e6b7e8f82c7c..67d797a1003f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -8,6 +8,19 @@
 #include "iavf_ptp.h"
 #include "iavf_prototype.h"
 
+/* how many Flex Array Member entries do fit into VC message of type *ptr */
+#define iavf_max_vc_entries(ptr, flex_member) \
+	((IAVF_MAX_AQ_BUF_SIZE - virtchnl_struct_size(ptr, flex_member, 1)) / \
+	 sizeof(ptr->flex_member[0]) + 1)
+
+static bool iavf_match_vc_op_cb(struct iavf_adapter *adapter, const void *data,
+				enum virtchnl_ops recv_op)
+{
+	enum virtchnl_ops wanted_op = (enum virtchnl_ops)(uintptr_t)data;
+
+	return recv_op == wanted_op;
+}
+
 /**
  * iavf_send_pf_msg
  * @adapter: adapter structure
@@ -377,8 +390,10 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	struct virtchnl_vsi_queue_config_info *vqci;
 	int pairs = adapter->num_active_queues;
 	struct virtchnl_queue_pair_info *vqpi;
-	u32 i, max_frame;
+	struct iavf_arq_event_info event;
+	int max_pairs, err = 0;
 	u8 rx_flags = 0;
+	u32 max_frame;
 	size_t len;
 
 	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
@@ -390,22 +405,30 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
-	adapter->current_op = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
-	len = virtchnl_struct_size(vqci, qpair, pairs);
+
+	max_pairs = iavf_max_vc_entries(vqci, qpair);
+	len = virtchnl_struct_size(vqci, qpair, min(pairs, max_pairs));
 	vqci = kzalloc(len, GFP_KERNEL);
 	if (!vqci)
 		return;
 
+	/* any message may arrive while polling, not only the awaited one */
+	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
+	event.msg_buf = kzalloc(IAVF_MAX_AQ_BUF_SIZE, GFP_KERNEL);
+	if (!event.msg_buf) {
+		kfree(vqci);
+		return;
+	}
+
 	if (iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_RX_TSTAMP))
 		rx_flags |= VIRTCHNL_PTP_RX_TSTAMP;
 
 	vqci->vsi_id = adapter->vsi_res->vsi_id;
-	vqci->num_queue_pairs = pairs;
 	vqpi = vqci->qpair;
-	/* Size check is not needed here - HW max is 16 queue pairs, and we
-	 * can fit info for 31 of them into the AQ buffer before it overflows.
-	 */
-	for (i = 0; i < pairs; i++) {
+
+	for (int i = 0, in_msg = 0; i < pairs; i++) {
+		const bool last = i + 1 == pairs;
+
 		vqpi->txq.vsi_id = vqci->vsi_id;
 		vqpi->txq.queue_id = i;
 		vqpi->txq.ring_len = adapter->tx_rings[i].count;
@@ -423,11 +446,52 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 						   NETIF_F_RXFCS);
 		vqpi->rxq.flags = rx_flags;
 		vqpi++;
+		in_msg++;
+		if (last || in_msg == max_pairs) {
+			adapter->current_op = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
+			vqci->num_queue_pairs = in_msg;
+
+			err = iavf_send_pf_msg(adapter,
+					       VIRTCHNL_OP_CONFIG_VSI_QUEUES,
+					       (u8 *)vqci,
+					       virtchnl_struct_size(vqci, qpair, in_msg));
+			if (err) {
+				dev_err(&adapter->pdev->dev,
+					"sending VC msg to PF failed, err: %d\n",
+					err);
+				break;
+			}
+
+			err = iavf_poll_virtchnl_response(adapter, &event,
+							  iavf_match_vc_op_cb,
+							  (void *)VIRTCHNL_OP_CONFIG_VSI_QUEUES,
+							  1000);
+			if (err) {
+				dev_err(&adapter->pdev->dev,
+					"config queues poll failed, err: %d\n",
+					err);
+				break;
+			}
+
+			/* PF NACK, iavf_virtchnl_completion() has logged it */
+			if (event.desc.cookie_low) {
+				err = -EIO;
+				break;
+			}
+
+			vqpi = vqci->qpair;
+			in_msg = 0;
+		}
 	}
 
-	adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
-			 (u8 *)vqci, len);
+	/* keep the op pending on timeout, as PF may still reply, the whole
+	 * config is resent once it does
+	 */
+	if (err != -EAGAIN) {
+		adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+	}
+	kfree(event.msg_buf);
 	kfree(vqci);
 }
 
-- 
2.51.1

