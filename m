Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716801;
	b=JpP+WctEP/n+4gSRTvsiElw2r4EU9IHRVRw8gYzNyILKslJ4YtN1b49B+isefoL0WRi8
	 DjSNz08uQm5Vry84jvA6az4qmD9EO327HGmgo0EEhVlJD8w9jbE3lBGrYVUF3vj51CNkX
	 nONNqMXeK+7ESysRYy84FlcF3s3z0/S+NSUulDEgkF83PsIiP5Xar1r3fz4jFg7FTPS5y
	 GAIODvu0frly0aNJKsVWb4eQ0RmZObJwYgEVkxFjxcu+gxVdgdKXIEsxgjftE6HW0DrOG
	 BFoB3DA2TV8jeiKYJcCEBTicPdHI9EynU3Vs6cynNvslHUb1TCZGM93qaEDMUUPEXZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716801;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OfXi3+MFIaMgDpofgoIZClSjmjJvsfSXCqwfqJEoROs=;
	b=4rqbYhUb8z/zspl5yfd7USW/aVkZ/WFVj/7/MZcQuznGu0OD20tI4HHGfklnX0xlmzF0
	 ivapFjwX3sFdS25VUXV8gZa3nAz22CwFRJEDahnIT154mdm3E+AmNTZX2+BSx0Sdiz/Bi
	 Qq+0hhEZg0vdYBlZYFFPRG8Ik0S2O++JtFYlTRhAzd3ZRGtO3IWwb7eMxAXr1yO2SacgP
	 QcDGRQa1Tl5DOJfxJ+9VCRCcWTXbbQcN0MoxiG55BhHdHXyHHKrcpM+wdLIbqFl5oQ2XL
	 Lk4S7u88upmBJt6WI4raSJ1JFZKXNe/QLXX3n8NfiFCMZmVrwcC/JNeNSvo7ohqg2DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nG9ZtcSM;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2D606D804
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B2D606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nG9ZtcSM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793716796; x=1825252796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/TnIHRq/W5sKXEetYjPiZDzUwmDPtVSF8P8FQxAJqfI=;
  b=nG9ZtcSMb0D8DWmRijSiEJXPC3ZfnMFsV9x5KTHcin2o1jOllLLzxB5P
   n8/DIR6PoYVmyhxH0Du/CRQNrCNhPLkeci+VdLVQSuUQYLB1YO+kAweX/
   w8SKxej7XnV6LHdskKYcOCReC5Nz/hQCqIZ9P5dDsTUNzs1N93+JhopCu
   WkV1kD0KEQyzQVKChVKdq82zWFcU2u87JAPkbqh2TEy28BfJSXw8DapZA
   X9lPqTVmFEoxfISUyPdHdANQXwJet49cjBdBscTXdb8x1WScuM4kgVsFj
   y4ZM9owWOHwU3PVKHOVIxkRTSdlPaGHL3ldMafHEKQN9GKV749rbrbzjk
   w==;
X-CSE-ConnectionGUID: aDCLClXbSFiTFREy9QGK2w==
X-CSE-MsgGUID: ti7+8TCESdKuBxapnBdJDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324041"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324041"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:39:55 -0800
X-CSE-ConnectionGUID: I3+CryFSQb2tdSHDutWYVg==
X-CSE-MsgGUID: IyzJtfKCRJK27iV6tsNoww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289915"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:50 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4499A312F1;
	Tue,  3 Nov 2026 14:39:48 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org,
	Simon Horman <horms@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	bruce.richardson@intel.com,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	padraig.j.connolly@intel.com,
	ananth.s@intel.com,
	timothy.miskell@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 07/15] iavf: extend iavf_configure_queues() to support more queues
Date: Tue,  3 Nov 2026 15:14:48 +0100
Message-ID: <20261103141646.303620-8-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
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
2.54.0

