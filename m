Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320163;
	b=1+4DunnT9cbMd+W/dUvGDgtSK60IK9ps0GNAaHlDpzSyydLr0JSKniH/ZYFqzmPzBSd1
	 TNHA0Evs2Hg42eUkEdjzOgW5N9uibdp9YXSmWP+itV5MfehZkhbO9z7D0SF/2S/Y1X8DC
	 Righ55fBwfVkgEOXN5tyRUckMYNnohsS0cDSGcXqALN2hESBW7R43CRYCnqrd6sC+2g7P
	 gQzfIPWbnoo7SWC/W9YsPNTAP+HHpDG0tRHrtgHsR18PCOtdgDAl2hX0+49H2+RE/oF13
	 WYVEmhrcH90Y6tGKsI5Dvh23Fn0QEIWfXrlh3kl7RzeJ3HJLzKFDUxn5oUH8NmC/KfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320163;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UUrWzpVSa94G7XScAfG3PfAnrYmSHteR8sZp8cTWZGI=;
	b=X5Ud7rngkR97t45CF4tuyeP225MDVwpBfYcdQgvgh6rUiJYRV+z0Och2sySm326ECunq
	 VHzb96PgcCnmDs98uc9kn9kYGJs4rSblE7uzxwHrb5jnp04BGYE6OSFBbxrkHY2KCwucd
	 HDCZeJdwSBXqmbBygQOb0DLaVfOX4Q3t5GQeUNopsy17oiosRLGtvNKkGgDURCCCF2jbR
	 9K7wT3UcZrJPAvR4hUNU81JqS8N1Sjn5NKRg1tVvKFgvRQ9TR0kwOJyCP4M2qxxNsvCir
	 /4/m6HvwkznPNO5UwgJWfVUOZAZEBHL7HOYT89oZwUUHLMtLD+Orfz48S699UTn+xSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EIapUUjs;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A116606A338
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A116606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EIapUUjs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320162; x=1825856162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yjlh5cA1Q/w4HkcAT2LEu5Ty0CqXWQYQIzpiGQoa5hQ=;
  b=EIapUUjsPMgk2K+y5Swk5w7kfUzgeiN8QmMzclkh+dBCD25NfNHvUGCN
   i81UMuL+aWaeTnerMXlNxK8yai0kiKc6oWbXrnRB692QD+2p3YCjHKOxn
   1wcuLTgwtv88F14GijBShMGA7d0Rv9fqVTq0NnWhzCipcHuggMVo4STPc
   8LRxiNfj4EM4dVtfOWXnJ81KQCIAaH1fJQ6QyAxxVIVKuQifjOjuNNnMR
   H3reIoxYKMcEPulyELWmJi1qNWVNum6wiaEckcE0GJXNay5V3wrwJbiLC
   JazRCvKxFlWCcnik1cgW4uy8GxZfo6Yi6bH7i6FXUoxwfHedif65Ra2zB
   Q==;
X-CSE-ConnectionGUID: IGc2Qe/CRfe+zr55JCtoYw==
X-CSE-MsgGUID: wPIsHM3vQF+W5X3Ifw/K9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3091136"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3091136"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:16:02 -0800
X-CSE-ConnectionGUID: wnB2Lb1aQo2Y+ScWM93kUA==
X-CSE-MsgGUID: 8kgLUEOXRxqUqJTmTRyUHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8327629"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 06:15:56 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.251])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 205102FC5A;
	Tue, 10 Nov 2026 14:15:54 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jiri Pirko <jiri@resnulli.us>,
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
	ohartoov@nvidia.com,
	Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 07/15] iavf: extend iavf_configure_queues() to support more queues
Date: Tue, 10 Nov 2026 15:07:16 +0100
Message-ID: <20261110141534.95614-8-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend iavf_configure_queues() to support more queue pairs than fit
into a single virtchnl message (62).
Virtchnl opcode used was already generic, but we have just not needed
more than one message before.

Send one message per call, and keep IAVF_FLAG_AQ_CONFIGURE_QUEUES set
until all queue pairs are sent, similar to what iavf_add_ether_addrs()
does for MAC filters. The next message goes out on a later watchdog
run, once the reply to the previous one has cleared current_op, as for
any other op. Stop sending on a PF NACK.

Add helper, iavf_max_vc_entries(), that determines how many entries we
could fit into virtchnl message (ending by flex array member). Will be
also used on another op later in this series.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v4:
 * send one message per watchdog run, instead of polling for the reply
   to each one with a 1s timeout, which could resend the whole config
   after a late ACK or NACK, and could take a stale reply for the
   awaited one (Sashiko)
 * stop sending the rest on a PF NACK, in iavf_virtchnl_completion()

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
 drivers/net/ethernet/intel/iavf/iavf.h        |  2 ++
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  1 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 25 ++++++++++++++-----
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 8c45536fd502..a41d2726ebd8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -269,6 +269,8 @@ struct iavf_adapter {
 	u8 rxdid;
 	int num_active_queues;
 	int num_req_queues;
+	/* queue pairs sent so far, for ops that take more than one message */
+	int cfg_qps_sent;
 
 	/* TX */
 	struct iavf_ring *tx_rings;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2f8a80a11336..d39737dcd425 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1258,6 +1258,7 @@ static void iavf_configure(struct iavf_adapter *adapter)
 
 	iavf_configure_tx(adapter);
 	iavf_configure_rx(adapter);
+	adapter->cfg_qps_sent = 0;
 	adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_QUEUES;
 
 	for (i = 0; i < adapter->num_active_queues; i++) {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index e6b7e8f82c7c..356565aa41c8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -8,6 +8,11 @@
 #include "iavf_ptp.h"
 #include "iavf_prototype.h"
 
+/* how many Flex Array Member entries do fit into VC message of type *ptr */
+#define iavf_max_vc_entries(ptr, flex_member) \
+	((IAVF_MAX_AQ_BUF_SIZE - virtchnl_struct_size(ptr, flex_member, 1)) / \
+	 sizeof(ptr->flex_member[0]) + 1)
+
 /**
  * iavf_send_pf_msg
  * @adapter: adapter structure
@@ -375,11 +380,12 @@ int iavf_get_vf_ptp_caps(struct iavf_adapter *adapter)
 void iavf_configure_queues(struct iavf_adapter *adapter)
 {
 	struct virtchnl_vsi_queue_config_info *vqci;
-	int pairs = adapter->num_active_queues;
 	struct virtchnl_queue_pair_info *vqpi;
+	int first = adapter->cfg_qps_sent;
 	u32 i, max_frame;
 	u8 rx_flags = 0;
 	size_t len;
+	int pairs;
 
 	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
 	max_frame = min_not_zero(adapter->vf_res->max_mtu, max_frame);
@@ -391,6 +397,8 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
+	pairs = min_t(int, adapter->num_active_queues - first,
+		      iavf_max_vc_entries(vqci, qpair));
 	len = virtchnl_struct_size(vqci, qpair, pairs);
 	vqci = kzalloc(len, GFP_KERNEL);
 	if (!vqci)
@@ -402,10 +410,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	vqci->vsi_id = adapter->vsi_res->vsi_id;
 	vqci->num_queue_pairs = pairs;
 	vqpi = vqci->qpair;
-	/* Size check is not needed here - HW max is 16 queue pairs, and we
-	 * can fit info for 31 of them into the AQ buffer before it overflows.
-	 */
-	for (i = 0; i < pairs; i++) {
+	for (i = first; i < first + pairs; i++) {
 		vqpi->txq.vsi_id = vqci->vsi_id;
 		vqpi->txq.queue_id = i;
 		vqpi->txq.ring_len = adapter->tx_rings[i].count;
@@ -425,7 +430,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		vqpi++;
 	}
 
-	adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
+	adapter->cfg_qps_sent += pairs;
+	if (adapter->cfg_qps_sent == adapter->num_active_queues)
+		adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
 	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
 			 (u8 *)vqci, len);
 	kfree(vqci);
@@ -2551,6 +2558,12 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			dev_warn(&adapter->pdev->dev, "Failed to Config Queue BW, error %s\n",
 				 iavf_stat_str(&adapter->hw, v_retval));
 			break;
+		case VIRTCHNL_OP_CONFIG_VSI_QUEUES:
+			dev_err(&adapter->pdev->dev, "Failed to configure queues, error %s\n",
+				iavf_stat_str(&adapter->hw, v_retval));
+			/* don't send the remaining queue pairs */
+			adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
+			break;
 		default:
 			dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
 				v_retval, iavf_stat_str(&adapter->hw, v_retval),
-- 
2.51.1

