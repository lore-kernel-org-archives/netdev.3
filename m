Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2B3BED2D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596225; cv=none; b=O0hyybJh+vcNZIX0w6pU0eylOgq+kAyVGt1Ve/zWvuLnW44rcbcNFhz3f9vSOvz/ImJFZTrIKBZjZPzFUbPon0cKqpvHsL2Fz2CDxY1Tq2/2bPukN/lJuvVparvIJSwuM9Q6ojT+ujb5HXwRWVPgHoP/oWRxxvk2uazFyREDaek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596225; c=relaxed/simple;
	bh=Cb0iRpw8DUrofh4A8Mn5ZEEHKUREiiFVzuMgPY67uok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdCZuc85p9OEQby3kgzby/vimiGyUxHmEKcD837gL5ZGU8SG0OfzAdLDyri8hX32TTs1/hSrnsudVS5WgKndJaMA4ZB/bTt8TRpCxER2dn3DngUZvJ8D3/BpiD6bcROwZEaeoZ2lZPs5u1QoxMYTq530nr3Fz/if7zYIbbVjevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlQ3ZLbz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlQ3ZLbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596219; x=1806132219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cb0iRpw8DUrofh4A8Mn5ZEEHKUREiiFVzuMgPY67uok=;
  b=AlQ3ZLbzoKUPMxPoGZLRxH58D7GhOyQN0rWKuZPIt0RPUs9mgGX3xnaH
   t2HZL02HdjrMGQDeUI6n8p6fO1LGWMVCLVcmv9IqV5YMzcRmd/1SZUOt8
   X9GwWlHflP1ISnyX0/toKes2hR2NSuXVQJ5aUheTVGHG+fqIKoJIEUt63
   izMiH8/wn6oMyuMNCw2tsmxo/R2DUHw61+6myHWBZuqfoOo3NWi1AAumb
   rmoMmUX4r7tr4cqjlDxSx6SFWzx2t0HCHpl4WV1JI5aTkMbYajzR0HOfD
   l/Mcus7fzUFekMuFWuV3qimNxzh0bPVaIuYIqeh84y1vclOYvtsMErOFv
   Q==;
X-CSE-ConnectionGUID: t2rlz+yeTrOMSXpeAL6CRA==
X-CSE-MsgGUID: ukr/bYYdRTixIUyWiiqGkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733968"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75733968"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:23:38 -0700
X-CSE-ConnectionGUID: n75L8qjOTGu0+SKFP1n+1g==
X-CSE-MsgGUID: piRAxftQSTGygULDgvOr3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255739090"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:37 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH net] ice: fix PTP Call Trace during PTP release
Date: Fri, 27 Mar 2026 08:23:26 +0100
Message-ID: <20260327072332.130320-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

If a PF reset occurs when the PTP state is ICE_PTP_UNINIT, then
ice_ptp_rebuild() will update the state to ICE_PTP_ERROR. This will
result in the following PTP release call trace during driver unload:

    kernel BUG at lib/list_debug.c:52!
    ice_ptp_release+0x332/0x3c0 [ice]
    ice_deinit_features.part.0+0x10e/0x120 [ice]
    ice_remove+0x100/0x220 [ice]

This was observed when passing PF1 through to a VM. ice_ptp_init()
fails because ctrl_pf is NULL and sets the state to ICE_PTP_UNINIT.

Fix by detecting the ICE_PTP_UNINIT state in ice_ptp_rebuild() and
returning without error, preventing the invalid state transition to
ICE_PTP_ERROR. The only valid path to ICE_PTP_ERROR is from
ICE_PTP_RESETTING after a failed rebuild.

Fixes: 8293e4cb2ff5 ("ice: introduce PTP state machine")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 094e962..6848b1c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3041,6 +3041,11 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	struct ice_ptp *ptp = &pf->ptp;
 	int err;
 
+	if (ptp->state == ICE_PTP_UNINIT) {
+		dev_dbg(ice_pf_to_dev(pf), "PTP was not initialized, skipping rebuild\n");
+		return;
+	}
+
 	if (ptp->state == ICE_PTP_READY) {
 		ice_ptp_prepare_for_reset(pf, reset_type);
 	} else if (ptp->state != ICE_PTP_RESETTING) {
-- 
2.52.0

