Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75E63E1CE5
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245189; cv=none; b=ph3dVDeSF3ovEFn9k52JmiQMff3zfOULqYtiy1RWsL3vdGMS592iRhzUzgjc1uWiScvewsb6I3dO6nEuA+CCmHmXbzRmjtz7vijcrg9XAvoo7UAZ5HL7oyzWtfTV4epCnkyVlylyN0PFTHX0SvzD18oS7maODo8Bbgoojg5RZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245189; c=relaxed/simple;
	bh=xp8id5hWkxewY8R4U5e0ecSa2Lz1SpyuPfR7qie2fB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iHTrF2AHuuOsfvpQsVnYUzDmR/uXxQeTBh5pcuF87zRw8he7M06mHzp9Y66uTqfb6vRLKVKrNT1uqH7MNYH+rsfBQewG6zEMW8WlInSx84JAjjWwV/O7cNieiGAdJAVRzRRMfJmMsoPKP1lBHtGHWLfVV8hX4ueSnQpwiK558C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=By6Fp8s/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By6Fp8s/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778245188; x=1809781188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xp8id5hWkxewY8R4U5e0ecSa2Lz1SpyuPfR7qie2fB0=;
  b=By6Fp8s/SBGpZkBx3MCt7toON5IrHyWtK1IsElIeeOue7rqE9vldVj86
   IE0T5NcnJRRbMEaDNz8KGtD/sADh+BVG765/JgZLJiBBHcamUFcDo12Ky
   h2SN4MDcXESi5cJsCYxuEn/gV0GptIBdDtYhI8YAwU/AZZeeg6v9K6IwY
   3X+MyVKhPmzqC3vUzotFLicSpGkfnvXZH2pRZsE/TQe3fe5FB6eL+cUGL
   brr+sJZqi/p/NObMwCQ98EvoZUT9SdUdWJGnKat5TVBv7RQGa34kgBtYH
   RabcGrO4IqH2356wmsTYn2YRI6SR9/m5dkRWd/fl+uFQwh+sjan5Pey2v
   Q==;
X-CSE-ConnectionGUID: sImNkH5wRMCmSMKYRc4r6Q==
X-CSE-MsgGUID: VoKkBC9TT1ilcj0FsPSWcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79199873"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79199873"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 05:59:46 -0700
X-CSE-ConnectionGUID: GMTYscFKSFW/eeqijkQXYA==
X-CSE-MsgGUID: YZKUQNZPQ46TNr2j45qvUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241730099"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 05:59:41 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 56A4B2879A;
	Fri,  8 May 2026 13:59:39 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
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
Subject: [PATCH iwl-next v1 03/15] ice: simplify ice_vc_dis_qs_msg() a little
Date: Fri,  8 May 2026 14:41:56 +0200
Message-Id: <20260508124208.11622-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove special case logic for disabling all queues in ice_vc_dis_qs_msg().
There were no actual speedup from it, the only difference was in saved
bitmap checks, but the HW operations take the majority of time anyway.
ice_vsi_stop_all_rx_rings() used (in the removed code) loops over rings
anyway.

With a message added just before removed code, in the "remove VF" scenario
there were no noticeable difference with the "speedup" and without, and it
takes ~0.06s on my machine from this point to the whole iavf removed, so
really no big deal anyway.

Next commit would otherwise need to complicate the "speedup possible"
check, so it's another reason to simplify here.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/queues.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 31be2f76181c..6e4ec681fd07 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -357,6 +357,8 @@ int ice_vf_vsi_dis_single_txq(struct ice_vf *vf, struct ice_vsi *vsi, u16 q_id)
  * @msg: pointer to the msg buffer
  *
  * called from the VF to disable all or specific queue(s)
+ *
+ * Return: exit code of sending the virtchnl response.
  */
 int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 {
@@ -406,18 +408,7 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 	}
 
 	q_map = vqs->rx_queues;
-	/* speed up Rx queue disable by batching them if possible */
-	if (q_map &&
-	    bitmap_equal(&q_map, vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF)) {
-		if (ice_vsi_stop_all_rx_rings(vsi)) {
-			dev_err(ice_pf_to_dev(vsi->back), "Failed to stop all Rx rings on VSI %d\n",
-				vsi->vsi_num);
-			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-			goto error_param;
-		}
-
-		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
-	} else if (q_map) {
+	if (q_map) {
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
 			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-- 
2.39.3

