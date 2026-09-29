Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9F4F85D6
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721733; cv=none; b=m98Ilh2UgnsxNoB2nbo+9FMU2QnjF/ZvGnCWYrrFZIUYr1kp0WoWSYYur3AId77U3Bj8bsFH0d08tgH/oRi9MMolDrzRg9HfXb3DDvAb54rspy7al5kpoPTscSH8Wg/Rge/Wy3oxAj6Ms9veV5Lt1UrkpaegxvaXlxY3b9IA88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721733; c=relaxed/simple;
	bh=9VUaxhqnxZgzTJAccs7bYcI5zzo1HE7lI+xMK1+fykY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Akp4KSutjArI5/q8ABeGWXfFl8TYjGRlFXwOD8IwP6Pw241MW5KXjMYOT6TDjSnDOBqmOhvD2A2/1hJhrfHX4wd30cop6bjYx6Ei3mAGi97Mw443W1K27qPXzbGKDi4B1/Cj3UYVhInwpXu9xcBiZEbSuHS9yrGIwKIXbU/JjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAoF5wcK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAoF5wcK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721731; x=1822257731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9VUaxhqnxZgzTJAccs7bYcI5zzo1HE7lI+xMK1+fykY=;
  b=cAoF5wcKy3hchiJshkRBR6qKNL3CJYb+0V4eMkDbNuYnFgTVh8pjLqVG
   MEsvcY+d7F5ornUmlT98+gg25L7aSak3jXupfIFZiIS5VC0IW8Kao1mC/
   YhbXGXzPXFjj4/oyBWz3Nj9bBhKsf+vkB6iVQwU9V5wvDMR/75+DEmHP/
   cnEBAU0Y4uGDdvr03+U4oR+2KHjqtORRXyUy79XR7TQeabDYXLCA2ijgk
   z37mvIr7nIwJh0ESiBnb5rqM6R4b09PpijOE3KBdQvDZiy50fvSpN/EnD
   rCecYUD3xzFyugxbHIkNO8SSIWdNLTP9xQwYXQGrpl7LMn4lDFk11/Nj0
   A==;
X-CSE-ConnectionGUID: aFOn5z85SBiskgklnQy8pQ==
X-CSE-MsgGUID: woeNc7dVSsqgD40f0juRpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548914"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548914"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:02 -0700
X-CSE-ConnectionGUID: WitteZfPQU2p9VHuUuSC5w==
X-CSE-MsgGUID: taYc6vsVTP2NoE7imv6bFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452351"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	aleksandr.loktionov@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	xiongwm2026@163.com,
	ynorov@nvidia.com,
	horms@kernel.org
Subject: [PATCH net-next 10/10] ice: simplify ice_vc_dis_qs_msg() a little
Date: Tue, 29 Sep 2026 15:41:50 -0700
Message-ID: <20260929224153.1455466-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Remove special case logic for disabling all queues in ice_vc_dis_qs_msg().
There were no actual speedup from it, the only difference was in saved
bitmap checks, but the HW operations take the majority of time anyway.
ice_vsi_stop_all_rx_rings() used (in the removed code) loops over rings
anyway.

With a message added just before removed code, in the "remove VF" scenario
there were no noticeable difference with the "speedup" and without, and it
takes ~0.06s on my machine from this point to the whole iavf removed, so
really no big deal anyway.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/queues.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 431c9c546b04..ac7f98479b13 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -375,6 +375,8 @@ int ice_vf_vsi_dis_single_txq(struct ice_vf *vf, struct ice_vsi *vsi, u16 q_id)
  * @msg: pointer to the msg buffer
  *
  * called from the VF to disable all or specific queue(s)
+ *
+ * Return: exit code of sending the virtchnl response.
  */
 int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 {
@@ -424,20 +426,7 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
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
-		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF)
-			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
-		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
-	} else if (q_map) {
+	if (q_map) {
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
 			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-- 
2.47.1

