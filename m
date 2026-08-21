Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB8356741
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345146; cv=none; b=nMFE0DBZ4eVy97UIv1i/X4kR+pbdRtZA0v2LXA5+/4eCrTMurMCLKQkuXtqHhlXfVhDLsZDThAmmC+IgJegkN8wzhVtjHvzssC+Fk7Cswms1QXiRTKOEu6fW1pB9hGjZcUxNAnq9gtRmSEJ82rLgfkcdCoDgLKs14H4xIWQgRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345146; c=relaxed/simple;
	bh=lAmyylgTaplrXErO3JoI+CUuN7jVp5MO2V9fTadVOL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ma3+YnvH/CHx3Ax4yZlPSrmqrq7v+eYWj/OuA3whoLRLgsiOwHV/EVQQbGu6OOQgHk0gLxxeyS4E7p+GAytZckGjQVCsf2p8GJ7Gfa0WyUrNaH3a9R66Tc3XZCvLEMOSnBvz8ZpyliSyq/YOL3TCrcHHoiHzA20ZwSvL/kbI4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNR80lUn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNR80lUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787345145; x=1818881145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lAmyylgTaplrXErO3JoI+CUuN7jVp5MO2V9fTadVOL8=;
  b=VNR80lUnRsAz42qVzeUwwcR+H6t0NyQuRjCsllTO9U+ViQSWOCVH0/Ae
   H7McxacekFN5GAEW5akwT7mIphA7ZHxargHDbfskQobulnt2Sztnad5AZ
   yoPT1dIpAjdtpOQky9xdXiyYMeVzb9YA3Ka9Mkmbmi1YPT8G9H+1kLWDl
   nXNFGDR2GvOaKTmVgPiGYtpvoaTcdFHym1odaGOv/RO/sO9UxRKdBzbXu
   4F1FAe3MrnxEOgnb7o2DbQnPZSmSgnMFi6FHApa3R0nTRFQmUnfHk8gUJ
   FenUIMzdI1y2pBeiHrL7fPDwj0VcnJzPTujsVtJWbr8RrzfIECedxs8Q1
   Q==;
X-CSE-ConnectionGUID: hOAWPW7zRsW3JH7IpPtMog==
X-CSE-MsgGUID: PFSOqO1iTs2UqXZTax6fsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88027620"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88027620"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 13:45:44 -0700
X-CSE-ConnectionGUID: zYSAbA9NQEKgfYADQy/HZw==
X-CSE-MsgGUID: HgzFQRFRSwSSiE2x0h42qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="268400237"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2026 13:45:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/4] ice: skip unnecessary VF reset when setting trust
Date: Fri, 21 Aug 2026 13:45:36 -0700
Message-ID: <20260821204537.2189112-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260821204537.2189112-1-anthony.l.nguyen@intel.com>
References: <20260821204537.2189112-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
ice_reset_vf() when the trust setting changes. While the delay is smaller
than i40e, this reset is still unnecessary in most cases.

When granting trust, no reset is needed - we can just set the capability
flag to allow privileged operations.

When revoking trust, we only need to reset (conservative approach) if
the VF has actually configured advanced features that require cleanup
(MAC LLDP filters, promiscuous mode). For VFs in a clean state, we can
safely change the trust setting without the disruptive reset.

When we do reset, we maintain the original ice pattern that has been
reliable in production: cleanup LLDP filters first, then set vf->trusted,
then reset. This ensures the privilege capability bit is handled correctly
during reset rebuild.

When we don't reset, we manually handle the capability flag via helper
function, eliminating the delay.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 35 ++++++++++++++++++----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..558937899818 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1366,6 +1366,23 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);
 }
 
+/**
+ * ice_setup_vf_trust - Enable/disable VF trust mode without reset
+ * @vf: VF to configure
+ * @setting: trust setting
+ *
+ * Update VF flags when changing trust without performing a VF reset.
+ * This is only called when it's safe to skip the reset (VF has no advanced
+ * features configured that need cleanup).
+ */
+static void ice_setup_vf_trust(struct ice_vf *vf, bool setting)
+{
+	if (setting)
+		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	else
+		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+}
+
 /**
  * ice_set_vf_trust
  * @netdev: network interface device structure
@@ -1401,11 +1418,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	mutex_lock(&vf->cfg_lock);
 
-	while (!trusted && vf->num_mac_lldp)
-		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
-
-	vf->trusted = trusted;
-	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+	/* Reset only if revoking trust and VF has advanced features configured */
+	if (!trusted &&
+	    (vf->num_mac_lldp > 0 ||
+	     test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
+	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))) {
+		while (vf->num_mac_lldp)
+			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
+		vf->trusted = trusted;
+		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+	} else {
+		vf->trusted = trusted;
+		ice_setup_vf_trust(vf, trusted);
+	}
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
-- 
2.47.1

