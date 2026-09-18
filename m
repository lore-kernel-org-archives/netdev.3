Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447285172CB
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738376; cv=none; b=W/VdSL24prq0GsOSMJXJiVjVwBT/k/KrVhR5HAWnhxOIa6rcOWrjitRqBSPPVsdV2Vv9nJPy6z0Z9D6CvMXtLF3G+PEKcb/ZtIOLMfYOIFqAWtAojbG/rFz6OTCUpBrNrBKlCkeEu50Cj0Si9De3mdToYArMnTmKyfJSDGVdH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738376; c=relaxed/simple;
	bh=BrpjM1qFUlCr7XSqLaq155Sox0UuelYL+wjy9hCmh4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SMGRB1xQlVGuoIhi9yftKf8AEj49O1kZyrlpUqhsVmf8H17qW5ozfRnvwfWyiWzRjyTkdxRY0JkzppqYT1D56yvPfMMqz+vcXq1kVQewJO11RLZeXw4VTHloXso7FK+w5R8fPF1QBREhrz0mluKafJsUaCjSMcwagoz9lnL4oWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XI6s1W88; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XI6s1W88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738375; x=1821274375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BrpjM1qFUlCr7XSqLaq155Sox0UuelYL+wjy9hCmh4A=;
  b=XI6s1W88+lMllvnw+bwmpIWvwttNh5nke65fjeZXD1iHwJOfk2zE4IdM
   f1auKRdQ29L/XSGCkbxNWlCARN8eU1LHGAdHryidGznlBp9O10c28WJbm
   IQt1lbtsgyGusY8OOh1UN11q5dv9TGtMk8/lu/2BwRVyogNqQGJT4qa3o
   hPwuiH0R5nVSdmD9Ofna3eky0gLpc8tpC9ih99ePtZoAtE9pIfRc1A89O
   6nu3veA+GBwG20mYgF+czyNpZGK3KiDcak9ymbbGHhZqaaNqr55gZy+Ac
   wjMNDE8uVjYO1AgFld5ZiNsxvHiy0XyRm1csOTk4A8n+LaeBkYFKQXCbs
   Q==;
X-CSE-ConnectionGUID: BEfxsd/VRZmvLqvyR9wCWQ==
X-CSE-MsgGUID: hwGapNMCSbG+RXcwXcYrWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="101592441"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101592441"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:32:55 -0700
X-CSE-ConnectionGUID: JTMUIvI0T9qn6L4D7jiYzQ==
X-CSE-MsgGUID: FlDH24J7Sp+98lPDYr3kkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270717765"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:32:53 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jakub Staniszewski <jakub.staniszewski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2] ice: fix FDB deletion
Date: Fri, 18 Sep 2026 15:32:52 +0200
Message-ID: <20260918133252.4169450-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jakub Staniszewski <jakub.staniszewski@intel.com>

Correct the logic in ndo_fdb_del() to align with other drivers in
upstream. The condition was inverted — it was rejecting permanent
(NUD_PERMANENT) MAC addresses while allowing non-permanent ones to be
deleted, which is the opposite of the intended behavior.

The correct logic is to reject deletion of non-permanent entries,
mirroring the fix applied to ndo_dflt_fdb_del() in commit 645359930231
("rtnetlink: Fix inverted check in ndo_dflt_fdb_del()").

Also add is_link_local_ether_addr() to the unicast branch of
ice_fdb_del() to mirror ice_fdb_add(), which already handles link-local
addresses as unicast via dev_uc_add_excl(). Without this, a link-local
address added via ice_fdb_add() would fall through to dev_mc_del() on
deletion and fail to be removed.

Fixes: e94d4478669357cd ("ice: Implement filter sync, NDO operations and bump version")
Cc: stable@vger.kernel.org
Signed-off-by: Jakub Staniszewski <jakub.staniszewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2: no code changes, resending to pick up Reviewed-by.
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 707c743..39cc622 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6160,12 +6160,12 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
 {
 	int err;
 
-	if (ndm->ndm_state & NUD_PERMANENT) {
+	if (!(ndm->ndm_state & NUD_PERMANENT)) {
 		netdev_err(dev, "FDB only supports static addresses\n");
 		return -EINVAL;
 	}
 
-	if (is_unicast_ether_addr(addr))
+	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
 		err = dev_uc_del(dev, addr);
 	else if (is_multicast_ether_addr(addr))
 		err = dev_mc_del(dev, addr);
-- 
2.52.0

