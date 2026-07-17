Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1222ACEB
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314427; cv=none; b=pD87Opj9WMlh4tfPvPEjQLHD+DrV6v1yOf81MqEu2k/SpS0a2+NhvE3WOLDUrpj8UzsEEI/k7k/+igT19NdNPYzkxWvk5wk06jPCU6/j/ISdCcpU01rwejHPQJHELSAkJuBi0KnMnse8uWIUhiLsd8DZAk+Km2/BYt4Gu6N2Abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314427; c=relaxed/simple;
	bh=c4uF1yFryARTgMA+sYP9OZqs/Q1xYuZorFjGiRALKXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZa9uBNPgvHDKLDXxTZpVkvUyanOm+P36YEcISpQ4iHZNyeH2wFPFbBV5GF2FI+MCcYObcqCbsSmUsF1qBxfY48TZwLfPbDuXNYZRDOPkfQWc7ZBSiuVKDcxqFnb7W2PJz2NFCU6VBC7bMG5tEixrmgPA4if5toAhEoRRAdMGUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2M6CAlh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2M6CAlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314426; x=1815850426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c4uF1yFryARTgMA+sYP9OZqs/Q1xYuZorFjGiRALKXs=;
  b=j2M6CAlhxHf/zuzPI/JP/P240JXN7Z6uvbxn3hzN0Ex+St6o37qxBVH0
   vs/5yy4mxrCMsfk9GGh1yD7TkD518AcXdD9vc2KZ/ZPEeo8VuRmEUkHQY
   MgNSLda+dquENrbck615sudZnmmC1KtbYfcNQsGlRorAKXW+/eIAyxK/1
   IZZ5Nwr8nffxdBQeYSBKJu1TY5N/wkPheRt8XwjVJHyJmzCx+Pe4RQl53
   vuRzNhJF6aUairPUqDQ/LDHANCnYg37CJhvEqarpAh/TzZf3LsuPcXDhF
   Fb8XK8aGr7q8wcf94/Kly5E84V8QVq7vUYFqDABiVffXKRVBjD2+10pGt
   w==;
X-CSE-ConnectionGUID: SXFlXo3kQtanlPKE9jFNhQ==
X-CSE-MsgGUID: Z9XGSRyhSyeIJZZDcVzTPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347584"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347584"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:45 -0700
X-CSE-ConnectionGUID: tMlDBM6MTbancAxG+4ZmyQ==
X-CSE-MsgGUID: FTFF46laRHyIABtbfslV7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827223"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:44 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vincent Chen <vincent.chen@sifive.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 01/13] ice: allow creating VFs when !CONFIG_ICE_SWITCHDEV
Date: Fri, 17 Jul 2026 11:53:23 -0700
Message-ID: <20260717185340.3595286-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Chen <vincent.chen@sifive.com>

Currently ice_eswitch_attach_vf() is called unconditionally in
ice_start_vfs(), which causes VF creation to fail when CONFIG_ICE_SWITCHDEV
is not defined.

Fix this by adding switchdev mode checks at the call sites before
calling ice_eswitch_attach_vf(), consistent with how
ice_eswitch_attach_sf() is already handled in ice_devlink_port_new().
This is similar to commit aacca7a83b97 ("ice: allow creating VFs for
!CONFIG_NET_SWITCHDEV") which fixed the same issue for the previous
ice_eswitch_configure() API.

Fixes: 415db8399d06 ("ice: make representor code generic")
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c  | 14 ++++++++------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e091756d..e04de0215596 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -484,12 +484,14 @@ static int ice_start_vfs(struct ice_pf *pf)
 			goto teardown;
 		}
 
-		retval = ice_eswitch_attach_vf(pf, vf);
-		if (retval) {
-			dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
-				vf->vf_id, retval);
-			ice_vf_vsi_release(vf);
-			goto teardown;
+		if (ice_is_eswitch_mode_switchdev(pf)) {
+			retval = ice_eswitch_attach_vf(pf, vf);
+			if (retval) {
+				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
+					vf->vf_id, retval);
+				ice_vf_vsi_release(vf);
+				goto teardown;
+			}
 		}
 
 		set_bit(ICE_VF_STATE_INIT, vf->vf_states);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 27e4acb1620f..9052e71e9c99 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -812,7 +812,8 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 		}
 		ice_vf_post_vsi_rebuild(vf);
 
-		ice_eswitch_attach_vf(pf, vf);
+		if (ice_is_eswitch_mode_switchdev(pf))
+			ice_eswitch_attach_vf(pf, vf);
 
 		mutex_unlock(&vf->cfg_lock);
 	}
-- 
2.47.1

