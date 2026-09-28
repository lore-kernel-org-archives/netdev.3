Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63805495AF7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635507; cv=none; b=UyTci2/qostt5JzvHZqSK5zlM44Uk/H4U6vlkgoryWw3ebB0lIgtY2JPKKWENOLSAiMiPelAuSyG+Q8uEb0dEVWEzfnQ9xLm5RQB+U3emSOffXvW/yXFppQdQWzYyDPntSLYj76Cmpfj0D/sXc2pJWcgHfQSGSk8pUAu6Scqs/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635507; c=relaxed/simple;
	bh=7Y6a4efe+tgNGznPWkprVmhAGJKP8pz4247SVXDDIIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCwAhAg1IVpo4xnqWokEtA0C26Vx/eD5bj3H7JuasibmQhR81BysK22yJPTNeJpjXuZ32gHbu8sv7RNFyMIy5N5TzF3upSvZQD8yYXhiN7QJqY8WAy0xt5ftz8gShG5Uzj54TLvQOUgXIW66AqzNNRBuGYDarcXKUiWf6gZViqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTVq+UMR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTVq+UMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790635506; x=1822171506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Y6a4efe+tgNGznPWkprVmhAGJKP8pz4247SVXDDIIM=;
  b=dTVq+UMRaBV54EYZiWA+HkJhD9na2yl1bfZNWvimgO1pCjLmeiKWa7KF
   lW9XDxI/Q5P62FsI3psJzGbofyjnPuaBeV1SeXE4GAm1kZihSzegwm3Mw
   W444pJFXbB8iDep0iCXcDm0DfV7RlgLAVlhb2EdMAtP7fymUbkOPS2QWa
   WULtAKX0UOgBPJBFtyt2HfJHcIKgElsnbkrk30VO2CZA7YyGaDx8o9ShE
   wPypmAplK9UtER/KfKbdKrmtkFwaKGBs5aydpbsGpwowP5bkqKdRkoKFY
   zLklylAnBM0YTJlUKsVSeRkHsqbfVvX87PZb/0ZmqVyrB89sPiSgcUUUP
   Q==;
X-CSE-ConnectionGUID: tB7mwP0ISy6bmrB9ZPCkeg==
X-CSE-MsgGUID: hrO3oiUoSmCkmTGdnDiJAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91209081"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="91209081"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:45:00 -0700
X-CSE-ConnectionGUID: 7ckFVHixTBytwe9h4PkiIg==
X-CSE-MsgGUID: NXbnrCR/QAGfa8YYcbcgLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="278392134"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 28 Sep 2026 15:44:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	horms@kernel.org,
	sdf@fomichev.me,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net v2 3/3] ice: skip unnecessary VF reset when setting trust
Date: Mon, 28 Sep 2026 15:44:51 -0700
Message-ID: <20260928224454.483072-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260928224454.483072-1-anthony.l.nguyen@intel.com>
References: <20260928224454.483072-1-anthony.l.nguyen@intel.com>
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
Notes:
    All the comments below fall into pre-existing issues, concerns already
    addressed in previous versions and comments, out-of-scope items, or extreme
    edge cases. No code changes are considered necessary for a new version.
    Details for each comment:

    > [Severity: Low]
    > This isn't a bug, but doesn't ice_vf_lib.c already have a helper with
    > exactly these semantics?
    >
    > drivers/net/ethernet/intel/ice/ice_vf_lib.c:
    > static void ice_vf_set_host_trust_cfg(struct ice_vf *vf)
    >
    > Would it be preferable to export that one rather than carry a second copy?

    ice_vf_set_host_trust_cfg() derives the capability bit from vf->trusted,
    which must already be set before calling it. ice_setup_vf_trust() takes
    the setting as an explicit parameter, matching the i40e helper and the
    call site where vf->trusted and the capability bit are set together.
    Different interfaces for different purposes. Not a functional issue.

    > [Severity: High]
    > Is this predicate complete with respect to everything trust gates in ice?
    > Besides LLDP filters and promiscuous mode, vf->trusted also gates the MAC
    > and VLAN filter quotas and the administratively assigned MAC.
    >
    > Do those hardware filters then stay programmed after the log prints "VF N is
    > now untrusted"?
    >
    > Can vf->num_mac therefore remain above ICE_MAX_MACADDR_PER_VF after trust is
    > revoked, so that later legitimate MAC adds from the now-untrusted VF are
    > rejected until some unrelated reset happens?

    Same concern addressed in previous comments for both i40e and ice.
    Over-limit filters configured while trusted remain after trust revocation,
    but this is acceptable because untrusted VFs can freely delete their own
    MAC and VLAN filters, there are no trust checks in the deletion path
    (ice_vc_handle_mac_addr_msg() only checks trust when set == true). The VF
    simply cannot add more over-limit filters.

    ice_vc_handle_mac_addr_msg() decrements vf->num_mac on delete, so the
    counter reflects actual state after deletions. The no-reset path is only
    reached for VFs with no LLDP or promiscuous mode, having excess
    MAC/VLAN filters in this state is extremely unlikely.

    > [Severity: High]
    > What happens to the negotiated VLAN V2 capabilities when trust changes
    > without a reset?  The advertised limit is derived from vf->trusted once,
    > at negotiation time, and then cached on the PF.
    >
    > If the VF negotiated VIRTCHNL_VF_OFFLOAD_VLAN_V2 while trusted, does the
    > else branch leave max_filters at VLAN_N_VID, allowing the now-untrusted VF
    > to keep programming VLAN filters well beyond ICE_MAX_VLAN_PER_VF?

    The VLAN_V2 caps cache invalidation is part of the reset/rebuild path
    by design (ice_vf_set_initialized()). This patch does not change that
    architecture, it only adds a conditional to skip the reset when no
    advanced features are configured. The cache behavior is inherited from
    the existing design and is beyond the scope of this fix.

    > [Severity: Medium]
    > This isn't a bug introduced by this patch, but while ice_set_vf_trust() is
    > being touched: the switchdev check earlier in this same function returns
    > without releasing the VF reference taken by ice_get_vf_by_id().
    >
    > Would it make sense to convert that return into "goto out_put_vf;" here?

    Pre-existing reference leak, not introduced by this patch.

 drivers/net/ethernet/intel/ice/ice_sriov.c | 32 ++++++++++++++++++----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..f893dff39aac 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1366,6 +1366,20 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
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
+	assign_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps, setting);
+}
+
 /**
  * ice_set_vf_trust
  * @netdev: network interface device structure
@@ -1401,11 +1415,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
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

