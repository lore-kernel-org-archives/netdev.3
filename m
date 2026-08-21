Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB3E2853E0
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345145; cv=none; b=ljDYIrQA7MqPw3WrHZuNMN4CUC4tCh+tgOXzl+AZ0Iajpn8aoFWDg9IrvgcK/K+hTcHapx33MqohAgqWe0OVRV6tJeswo5JLpMDpCEt/AiOdPap9gb+fgbAJnHhZ07c32tMdQ8qNIhKKgPY91ClvtJXQN7Kr0LOAgsv/df+fnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345145; c=relaxed/simple;
	bh=wG3YbvlaS9ph6jlxQ7R4ibbEe4AbjoR1lMzAaFq/eps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dam73YwtoJzJbaUIDbQrNsumIzP9IHrPswMFvgwSbCsmK88Qnd/qXn7LRsHIndYLjwKgTefdP9YPQgd7j/YXbxZLcnlexLivaxJm2RVgbqnw5lTJCSLS6Siafhc9Jnc+l4xFnTrQerddprQxyspQP8MyDP/7yUajC1ieqNSp62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6tSHF14; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6tSHF14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787345144; x=1818881144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wG3YbvlaS9ph6jlxQ7R4ibbEe4AbjoR1lMzAaFq/eps=;
  b=Y6tSHF14KNh3nrP03d1oHyC0gSc4odc3wL3/z3h935JxOR8rXvHTbx+y
   VaTRTRDmhkJLtArRBskg9pUXHPhUQpMCpkW1HFe7yyRXtIN+gQ0fJ2X5d
   udiSZd2F+Ut6mNlOnuyGEw9fEJEZllnF8zzjaJiykh0zYovd2TGK07oSy
   5YI+xNSUO3Pu2a9+sHYpkH9Ou5Z8btyoqZ39h4uTqAlz54L8FoHuXAPLu
   otulmvHKpDPILm9hN2np2Q8lJAjlQjnM52FvnYB0XEuGR+Kn9wcAtGs47
   rmo+cdYJuuYTMleRFFDBpj3X//bMXlniQ9s7qo8r6mTcrvwGo2zTkNEwP
   Q==;
X-CSE-ConnectionGUID: 8hf+irVASiWXAf4Ekyhc5g==
X-CSE-MsgGUID: nLmSwvKOTYy9wvtp02/3IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88027606"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88027606"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 13:45:43 -0700
X-CSE-ConnectionGUID: jlvmiXxYRL2SKUhU3VIqXA==
X-CSE-MsgGUID: fqdQoBy7SPqPYTVtpDGltQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="268400228"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2026 13:45:42 -0700
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
Subject: [PATCH net 2/4] i40e: skip unnecessary VF reset when setting trust
Date: Fri, 21 Aug 2026 13:45:34 -0700
Message-ID: <20260821204537.2189112-3-anthony.l.nguyen@intel.com>
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

