Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE8502783
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635505; cv=none; b=O8k0S8n/mEttQF9yyW2WaOpMipPqVYz27xDJQ8u8YwGZ2tbBMi8/lkzvwCcs8KF+YwlchO/gPhLYNx4pupiElSR3B/QSYM9AQHFZKNiBQbPMpeb9wl/CJKfw0SughQim+CkRUrq0N5FBlGQUotLsySNdcWgN6FJvc/tksrqS/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635505; c=relaxed/simple;
	bh=dSDxQoYfUJGLZL0fVNwsbA82jLoJetc1PBa3VsE/ikU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmB7LmzBVGlwwAQhVTL/CQ6Z0AiPm7DGq+ItelpjE5+P4KhhnGpXvYdS5wuLEl+LNBjXbZceJq8BP2ulPW28lhZhp9mlVBPGe0W3Fw2X30Q8WOr6FuKt6bOKWLzuo2q7MEa0i9J1dIFoAsbmGS9MrTT3FOV/MPtd9SM+ZZLqXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdK1q5O9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdK1q5O9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790635503; x=1822171503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dSDxQoYfUJGLZL0fVNwsbA82jLoJetc1PBa3VsE/ikU=;
  b=XdK1q5O9dwIFoPXOKjMa3fVXIeq2UjrEWwvTG2DMn7IA/YpkUwhxykcU
   NTpxoYIZGU6AgyEx8KYP/9aow4LTVTm8HNoUwgRVFpSyzcQyUgTejqBz4
   /KQFe7SkL7xGM8Oply63lewzyNhGZGwYnGa6iYTMB9EvPQ5CDRl+it/A0
   LZw+4rg5HNEq4K++yH8zDgZtGSFRhftpu2BgVf4I3xMqEhxUW/DnSqvkg
   XhocI2bs8eWcROHuWx1FgveqfKM20QyV+VRTbAcmbYx0HTwNlm47MAp5C
   hiadRPErPFqHFLIJWAnjptXUmyii517okM+IE03PQVa9SM1HdePLojg/7
   A==;
X-CSE-ConnectionGUID: na8lcGCHTTiBKCoC0L7wjg==
X-CSE-MsgGUID: JSEhBLZXQb6YTMEgdbzqpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91209065"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="91209065"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:44:59 -0700
X-CSE-ConnectionGUID: ukFu1lM4QhqU92RFwUgcVg==
X-CSE-MsgGUID: EsV3fU2wQIWW93SREucU9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="278392127"
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
Subject: [PATCH net v2 1/3] i40e: skip unnecessary VF reset when setting trust
Date: Mon, 28 Sep 2026 15:44:49 -0700
Message-ID: <20260928224454.483072-2-anthony.l.nguyen@intel.com>
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
Notes:
    All the comments below fall into pre-existing issues, concerns already
    addressed in previous versions and comments, out-of-scope items, or extreme
    edge cases. No code changes are considered necessary for a new version.
    Details for each comment:

    > [Severity: Medium]
    > This helper writes I40E_VIRTCHNL_VF_CAP_PRIVILEGE from the ndo (rtnl)
    > context. i40e_alloc_vf_res() derives the same bit from an unsynchronized
    > read of vf->trusted.
    >
    > If that path reads vf->trusted and is preempted before the
    > set_bit()/clear_bit(), can i40e_ndo_set_vf_trust() update vf->trusted and
    > call i40e_setup_vf_trust() in between, so the stale write lands last? That
    > would leave vf->trusted true with the capability bit clear, or vf->trusted
    > false with the bit still set.
    >
    > Before this patch the ndo always followed the vf->trusted update with
    > i40e_vc_reset_vf(), so the bit was recomputed from the final value of
    > vf->trusted. With the reset skipped, is anything left that reconciles the
    > two?

    Pre-existing race. The original code writes vf->trusted before calling
    i40e_vc_reset_vf() without synchronization against VFLR-initiated resets
    from the service task. This patch does not change the synchronization
    model and the race window is the same order of magnitude (a few
    instructions). The scenario requires a guest-initiated VFLR at the exact
    moment of the trust change, extremely difficult to reproduce in practice.

    > [Severity: High]
    > Does this condition need to consider the MAC and VLAN filters that the VF
    > was only allowed to install because it was trusted?
    >
    > Trust is checked at add time only. Nothing revalidates filters that are
    > already installed when the privilege bit is dropped.
    >
    > Can the __I40E_MACVLAN_SYNC_PENDING work repair this instead? Looking at
    > i40e_correct_vf_mac_vlan_filters() it only recomputes the VLAN id of
    > existing entries, so no MAC filter is deleted on trust loss.
    >
    > There is also a functional side effect: mac_add_max drops back to 18 while
    > i40e_count_active_filters(vsi) still reflects the trusted-era filters, so
    > every later VIRTCHNL_OP_ADD_ETH_ADDR from that VF fails with -EPERM,
    > including a re-add of its primary MAC after a guest link down/up.

    Same concern addressed in previous comments. Over-limit filters configured
    while trusted remain after trust revocation, but this is acceptable because
    untrusted VFs can freely delete their own MAC and VLAN filters, there are
    no trust checks in i40e_vc_del_mac_addr_msg() or i40e_vc_remove_vlan_msg().
    The VF simply cannot add more over-limit filters.

    The permission check uses i40e_count_active_filters(vsi) which counts live
    filters, deletions reduce the count immediately. The "primary MAC re-add
    after link down/up" scenario does not apply: existing filters remain in
    place across link events. A guest-initiated VF reset cleans up everything
    via i40e_free_vf_res().

    > [Severity: Medium]
    > Can this sample of VF-controlled state race with the virtchnl handlers that
    > write it? i40e_vc_process_vf_msg() is called from
    > i40e_clean_adminq_subtask() in service task context without rtnl_lock() and
    > without taking __I40E_VIRTCHNL_OP_PENDING, so it does not exclude this ndo.
    >
    > Does that leave an untrusted VF promiscuous indefinitely? The same ordering
    > appears in i40e_vc_add_cloud_filter() and i40e_vc_add_qch_msg().

    Same concern addressed in previous comments. This race condition exists in
    the original code as well, vf->trusted is set before i40e_vc_reset_vf(),
    creating the same window where the VF can install privileged state while
    the capability bit is still set. This patch does not introduce this race,
    it inherits the same synchronization model. Extremely difficult to
    reproduce in practice.

    Fixing this requires changing the broader synchronization between ndo
    callbacks and virtchnl processing, which is beyond the scope of this patch.

    > [Severity: Medium]
    > This is a pre-existing issue and not introduced by this patch, but
    > i40e_vc_reset_vf() is void and can return having done nothing.
    >
    > Would calling i40e_setup_vf_trust(vf, setting) unconditionally, before the
    > branch, make both artifacts deterministic?

    Pre-existing issue not introduced by this patch, as the reviewer correctly
    identifies. The current structure keeps the logic clear: the else branch
    handles the no-reset case, the if branch delegates everything to the reset
    path.

    > [Severity: Medium]
    > The reset releases the ADQ channel VSIs and i40e_alloc_vf_res() re-creates
    > them with newly assigned seids. i40e_del_all_cloud_filters() then looks
    > the VSI up by the recorded seid. If the seid changed, the teardown takes
    > the error path and the hlist_del(), kfree(cfilter) and
    > vf->num_cloud_filters decrement are all skipped. Does this leak the
    > struct i40e_cloud_filter allocations?

    Pre-existing issue, the same ordering (reset before cloud filter deletion)
    existed in the original code. This patch restructures the control flow
    but preserves the same sequence.

 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 35 +++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a26c3d47ec15..c6732a24b640 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4943,6 +4943,20 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
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
+	assign_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps, setting);
+}
+
 /**
  * i40e_ndo_set_vf_trust
  * @netdev: network interface device structure of the pf
@@ -4987,19 +5001,20 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
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

