Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809C3C81AD
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882141; cv=none; b=dJSmEZf38olflkmKAnG+qDJ90xjczGEiJ1E1Im2UvFujucGIiCNRwnhOK84Yf1kdoPvjliJodE8JVNdr3UY9n8REOgRHZ6AO/pszhoRB+gl5Vvl14SGu90fYMpmXaj3CuQ/MIU3M4v8hosgl5Er2ZHA3GmGVxJnqwDN5A+gigs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882141; c=relaxed/simple;
	bh=wG3YbvlaS9ph6jlxQ7R4ibbEe4AbjoR1lMzAaFq/eps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeNdrNZH5nNPURMWi615zE7Qh81Kg+d+qduU1fgG/UW8fvUypnGaA5cw3dLo8t8v7QCHwgSwJcyFHxL7Xg9lj78qYwWbmn7lLwVt2/IzUGXhEaOBmE+b/miNlqD1eSej5eJGxva96X2Pr0DLnAYDdPn5Ydkply9xj77QnEznaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoYc7WeJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoYc7WeJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785882139; x=1817418139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wG3YbvlaS9ph6jlxQ7R4ibbEe4AbjoR1lMzAaFq/eps=;
  b=eoYc7WeJd+2VL3m27E/PxJBJ+zEKW+eM3Tff2U8+n0apCeMh5N1S4G+3
   33WhzdSFP+x9YHrxurVoLIjiQgIxl/xZXHI+zmY4pBN+h9RaRq+ipzWt9
   Bn8Et0rbr8V7qXLtXRjhAZm+97BzwprLGKsuyssiSwT5fWJap5qOdF1Z0
   xwDUw8v0VD45LAFz2tzX2kLiE3je0GmVsOAAjbgHY4o4AZur0SWqQDoCK
   kHqbugdxNlSYv/cDr8w6xGTAlAsOQzepgHknWPok70mLIO5W3K1Va9Lbc
   Nv30E2m6arVKXo7y7PZ/5mw0Eq1rI/TTeoaxQRkhrgM98Z0VFeb7XCKaz
   g==;
X-CSE-ConnectionGUID: +/guJVWFSOKxCIFAfxO7bA==
X-CSE-MsgGUID: eOkOc0NBS9CQRKIkDyYjCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96803411"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="96803411"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:22:18 -0700
X-CSE-ConnectionGUID: VFZIdxF8R4iJtDRgvhdHNw==
X-CSE-MsgGUID: a8g3/8iATwy5xgGh1/PeAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257307962"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 15:22:17 -0700
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
	rafal.romanowski@intel.com,
	horms@kernel.org
Subject: [PATCH net 02/10] i40e: skip unnecessary VF reset when setting trust
Date: Tue,  4 Aug 2026 15:21:55 -0700
Message-ID: <20260804222205.1580328-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

The current implementation triggers a VF reset when changing the trust
setting, causing a ~10 second delay during bonding setup.

In all the cases, the reset causes a ~10 second delay during which:
- VF must reinitialize completely
- Any in-progress operations (like bonding enslave) fail with timeouts
- VF is unavailable

When granting trust, no reset is needed - we can just set the capability
flag to allow privileged operations.

When revoking trust, we only need to reset (conservative approach) if
the VF has actually configured advanced features that require cleanup
(ADQ/cloud filters, promiscuous mode). For VFs in a clean state, we can
safely change the trust setting without the disruptive reset.

When we don't reset, we manually handle capability flag via helper
function, eliminating the delay.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 38 ++++++++++++++-----
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a26c3d47ec15..0cc434b26eb8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4943,6 +4943,23 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
 	return ret;
 }
 
+/**
+ * i40e_setup_vf_trust - Enable/disable VF trust mode without reset
+ * @vf: VF to configure
+ * @setting: trust setting
+ *
+ * Update VF flags when changing trust without performing a VF reset.
+ * This is only called when it's safe to skip the reset (VF has no advanced
+ * features configured that need cleanup).
+ */
+static void i40e_setup_vf_trust(struct i40e_vf *vf, bool setting)
+{
+	if (setting)
+		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	else
+		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+}
+
 /**
  * i40e_ndo_set_vf_trust
  * @netdev: network interface device structure of the pf
@@ -4987,19 +5004,20 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
 	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
 
-	i40e_vc_reset_vf(vf, true);
+	/* Reset only if revoking trust and VF has advanced features configured */
+	if (!setting &&
+	    (vf->adq_enabled || vf->num_cloud_filters > 0 ||
+	     test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states) ||
+	     test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))) {
+		i40e_vc_reset_vf(vf, true);
+		i40e_del_all_cloud_filters(vf);
+	} else {
+		i40e_setup_vf_trust(vf, setting);
+	}
+
 	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
 		 vf_id, setting ? "" : "un");
 
-	if (vf->adq_enabled) {
-		if (!vf->trusted) {
-			dev_info(&pf->pdev->dev,
-				 "VF %u no longer Trusted, deleting all cloud filters\n",
-				 vf_id);
-			i40e_del_all_cloud_filters(vf);
-		}
-	}
-
 out:
 	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
 	return ret;
-- 
2.47.1

