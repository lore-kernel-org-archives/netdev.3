Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22E22ACFA
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493370; cv=none; b=b8/tb8cnTVlWYf1yXkbI+k7um6dwZmP6SBci6/EmqepPbrNillwE9b1nmGrEJ+NHYl//ZUkg+/AEtWZm8sne069QfT0TUoFnORjT2x/pzqaaQvvHPYiIBoCJn52wT0SD1X140ZnYGVHAGhCKCS/CySXabtln7FK0SuubRLn5OpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493370; c=relaxed/simple;
	bh=kdcRbptRClZCH/Wl0r/1Q8atWsl2hUWzhYjQmabKy98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lV3h0NbN3ENiIXei4TuJeR5FfirpiOJN6y2Li7V485mgJoJvG2LVLvnYVaVhXKt3mXu5JLM2REf3gnVSBcUaa9ncCHWzsVpBSm4VpZi/dBFtWZp+Mx2/cEwb3NpIYAscq/fhtsV7O7Rek0/qMR8/CCfUa6OWS2v2ShmwhYPF24s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WceZaMfy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WceZaMfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786493368; x=1818029368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kdcRbptRClZCH/Wl0r/1Q8atWsl2hUWzhYjQmabKy98=;
  b=WceZaMfyZrvfL9uQflxjq9exc+Tria1AcPi6WQ50q+jpNlxsjxBYHTCp
   zDkzWYgzKgZQ4PgaeUfV0BfsrHsdyARE/kkTOjpByX/w8t28Jdx1Ntq/s
   NSYSZC/rlK0X+SGVHNd2Dq6fDksB6uE21hOkIEnvCaTS4iLC7FHTWXImK
   HEvGAaDGn3iOrliW6Ax/EZETjdpQooh7eg8XmZZkS6/IZ4JPMwXaFLTyK
   SPkZGVjPi8lVjtcntspD8wGBIIjst4MH8/WwfLzgdKE1KIKyufQD9Vs+U
   Z1gL/ewQeR/dVzvp/eCxSFH14m4iCEdIVqy8gKAQnm3l02P0ASROW0FGH
   w==;
X-CSE-ConnectionGUID: Qhd6unjhSvWg871BOz/kHQ==
X-CSE-MsgGUID: Fuuxo9AzS4i1w8OWzyNcZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87110559"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87110559"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 17:09:25 -0700
X-CSE-ConnectionGUID: ztYXr6t+RoS79XIy38DpUw==
X-CSE-MsgGUID: 6I7gndz0ShGa99WXGMypiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="263522978"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 11 Aug 2026 17:09:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	konstantin.ilichev@intel.com,
	richardcochran@gmail.com,
	przemyslaw.korba@intel.com,
	przemyslaw.kitszel@intel.com,
	robert.malz@canonical.com,
	willemb@google.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/4] ice: clear the default forwarding VSI rule when releasing a VSI
Date: Tue, 11 Aug 2026 17:09:15 -0700
Message-ID: <20260812000918.220714-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260812000918.220714-1-anthony.l.nguyen@intel.com>
References: <20260812000918.220714-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Oros <poros@redhat.com>

When a VSI is configured as the switch's default forwarding VSI
(ICE_SW_LKUP_DFLT) and is then torn down, the rule is left behind in
the switch. ice_vsi_release() no longer removes it, and the SR-IOV VF
free path (ice_free_vfs() -> ice_free_vf_res() -> ice_vf_vsi_release()
-> ice_vsi_release()) does not disable promiscuous mode either, which
only happens on VF reset in ice_vf_clear_all_promisc_modes().

A trusted VF that enters unicast promiscuous mode becomes the default
forwarding VSI (this is the default mode, when the PF does not have VF
true-promiscuous mode enabled). If the VFs are then destroyed without
the VF first leaving promiscuous mode, the ICE_SW_LKUP_DFLT rule for
the now-freed VSI is leaked. When VFs are recreated, a VSI reuses the
freed hw_vsi_id. If it is assigned a different VSI handle than the
leaked rule holds, ice_set_dflt_vsi() does not recognize it as
already-default, and ice_add_update_vsi_list() folds the dangling
(freed) handle into a VSI list, which the firmware rejects. The VSI
handle assigned on re-creation varies, so the failure is intermittent
rather than every cycle.

Reproduce by repeatedly running the cycle below on the two ports of the
same card, where $VF0 and $VF1 are the netdevs of vf 15 once they
appear. The VF must be brought up so iavf actually pushes the unicast
promiscuous request, and the rule must settle before the VFs are torn
down again:

  echo 16 > /sys/class/net/$PF0/device/sriov_numvfs
  echo 16 > /sys/class/net/$PF1/device/sriov_numvfs
  ip link set $PF0 vf 15 trust on
  ip link set $PF1 vf 15 trust on
  ip link set $VF0 up
  ip link set $VF1 up
  ip link set $VF0 promisc on
  ip link set $VF1 promisc on
  sleep 1
  echo 0 > /sys/class/net/$PF0/device/sriov_numvfs
  echo 0 > /sys/class/net/$PF1/device/sriov_numvfs

Within a few cycles the ice PF and iavf VF log:

  Failed to set VSI 25 as the default forwarding VSI, error -22
  Turning on/off promiscuous mode for VF 63 failed, error: -22
  PF returned error -53 (IAVF_ERR_ADMIN_QUEUE_ERROR) to our request 14

This cleanup used to live in ice_vsi_release() but was dropped by the
referenced refactor. Restore it. Clear the default forwarding VSI rule
in ice_vsi_release() when this VSI owns it, which covers every teardown
path.

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8cdc4fda89e9..9e08db376d3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2871,6 +2871,9 @@ int ice_vsi_release(struct ice_vsi *vsi)
 		return -ENODEV;
 	pf = vsi->back;
 
+	if (ice_is_vsi_dflt_vsi(vsi))
+		ice_clear_dflt_vsi(vsi);
+
 	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
 		ice_rss_clean(vsi);
 
-- 
2.47.1

