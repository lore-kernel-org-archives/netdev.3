Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C93B27E9
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476924; cv=none; b=Ju3qwYYAlzD31k5XmMLn5JE+sGWwq+KXaILcwgVzvUEzmtPXB+1qCMEmJvJWNyMO9U0JHRLC011prM+UWes8jjQRq18GAd4ULUhkB5M7Ktr3wz6jXypv5hdm70ee513n0/9Pr2onKxQudYffqVEZsFJxt1z7CKmQKK7RLnvmWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476924; c=relaxed/simple;
	bh=as05ITydtJv40NasvrOuvsBKvHNNZNXXjN1IanYdf4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Adpzp+9DPRgrI2Louf5deTwk+6OFbkOoIWZxQolDhQJovXgYTxhG7l+KfUJ2zSvjdHqFc/IjW1sFVUVK34UV+4ZqGRqyHdwKZqQoO/ywt/PAJwTjdb/tn6OenhHSG9JA0RV9jpbSTPW8Q4EDjJPNFUTW9xWbKKXx4tu9gyytgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TK4F5WEa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TK4F5WEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476923; x=1821012923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=as05ITydtJv40NasvrOuvsBKvHNNZNXXjN1IanYdf4w=;
  b=TK4F5WEafBnCyc8rel7wNxhyQk/kORAIJSvbX1AXFxO2sGsipyVJTOz1
   vSfoJchQ362sCr3T7oSBcTmgFeZBwSKKfCz+bEb85xvTG+5xuJI3zyli6
   G2BIJbXjrGyQNPwp8AbwuAvaQP0/nJDsYp8ndHhDwt6555o5XtHI2/94J
   y+KyUCFo/th1sRUmF9KbZyc9/Yz2YxPvqPaMkqaF2Jph+YkdZpl8xgSE5
   +hmxjCfmRnLwKa4ODRq7aZGDp2LHGtEo8pbPWeouj4lAp/ZFC7MXYhHaW
   3fuWtTPM5kxW9aJO3xdYGkOG2b2wPo8296gBwWUzubTCbzgVn66zkWfMU
   Q==;
X-CSE-ConnectionGUID: V6Rt4x1WT9eOURqrqPoF1Q==
X-CSE-MsgGUID: 8Df9XefgS2m9MWr5bcFCig==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853093"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89853093"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:22 -0700
X-CSE-ConnectionGUID: HfsaFdiSTb6NbfDMXHkBsg==
X-CSE-MsgGUID: q33d96EtSwSYAjaFO/dkQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225108"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:21 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jakub Staniszewski <jakub.staniszewski@intel.com>
Subject: [PATCH iwl-net] ice: fix FDB deletion
Date: Tue, 15 Sep 2026 14:55:19 +0200
Message-ID: <20260915125519.3975583-1-aleksandr.loktionov@intel.com>
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
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d888354..4c6d863 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6151,12 +6151,12 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
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

