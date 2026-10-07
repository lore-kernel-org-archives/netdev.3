Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAF3390C8A
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403410; cv=none; b=fwJHiLm9ojUp2P0uo4rmSOMg7eSoRbSjFltTrjH6FgvHOzqGmWWu/09QnLWUQowpiVGMEOJqi7hJ2gomSF6TNxNBzYyA8ueIR3rsOkzWVKQZ8vS8E3sxoNzlpdGgaprMH7dK6QaA4NMZ82q3ZKkvtZVHZ0WxuPor2qghMd7R65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403410; c=relaxed/simple;
	bh=a4mcv9oUmg3FAGRPQ/LhS/it/LUVnSs147ZtH9kUuIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCWxm73wzAFEUci1Ac3BW9mriK9s+ZuMIal5lywYjpMq4+PGSk8HqdTosRExaxdemNGu/N+blQIE3/HDFTkMLGkKYyHmWuTnYtec1Sewq3PqmYyAJyj+AQ3NR7f4iauQ5uAHHseYKLU7Vbf3O6xuMzyeE2VKj0kgTum4HvQVEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvIcrUq9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvIcrUq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791403408; x=1822939408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a4mcv9oUmg3FAGRPQ/LhS/it/LUVnSs147ZtH9kUuIw=;
  b=UvIcrUq9uDBPDpXbcNs8SCEjETqrKwi1wNzVfPuLP9LiifC3M+iUJ/kE
   o1WEcaY3Dk5EpMIWxjAmHAyRJ/CKgS3fWn99PBn/U+Xo93UONH8FoH3tw
   oNY/FWfDwdbXlwjbIrO8CO2z3SCF17WQnv3sdwNmXqMXXQ9pQikpfKz3g
   4Z95dly8VYn1gzr2K4qdawrfpnH3EIiXmOPJ15Gt/L9wwogM16R2WnMFp
   iEPIhNMvDnMp2K4km0n/cxcrE58QKgR5hGgTan+SYqey6Xqyqe7maOlar
   WdGLMvt2t4PxFRQ2LW2cxAlxPsJD3q0IgldGAZrQ4IekbbJeBtYEUx61K
   g==;
X-CSE-ConnectionGUID: jAs3LrPSTDSE2B34pyqL3Q==
X-CSE-MsgGUID: yBhrveF6T4ea5i0vU4KLTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="173241"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="173241"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 13:03:27 -0700
X-CSE-ConnectionGUID: IyOWPPkKT5qgnvbK+ZHYxw==
X-CSE-MsgGUID: l49xqbp4SAOYpeRMiH5CjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="238066"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 07 Oct 2026 13:03:25 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net] ice: keep the RSS hash function on indirection-only updates
Date: Wed,  7 Oct 2026 22:03:11 +0200
Message-Id: <20261007200311.730443-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool core passes RXH_XFRM_NO_CHANGE (0xff) in input_xfrm when a
request does not touch the input transformation, e.g. when it only
rewrites the RSS indirection table. ice_set_rxfh() tests input_xfrm only
for RXH_XFRM_SYM_XOR, which 0xff has set, so such an update switches the
VSI to symmetric Toeplitz hashing behind the user's back.

Once symmetric-xor is reported, the core requires all hashed flow types
to be symmetric for any following RSS set. The GTP flow types hash on
the TEID, so every later netlink RSS update fails with "hash field config
is not symmetric", including the one that would put the indirection
table back.

Keep the current hash function when input_xfrm is RXH_XFRM_NO_CHANGE.
ice_set_rss_hfunc() then returns early and leaves the VSI as it is.

This has been encountered while trying to run xskxceiver within drv-net
tests where one of the setup steps was queue pull out of RSS indirection
table.

Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index dffa213734f1..fd2f3cb9faba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3704,7 +3704,9 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	}
 
 	/* Update the VSI's hash function */
-	if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
+	if (rxfh->input_xfrm == RXH_XFRM_NO_CHANGE)
+		hfunc = vsi->rss_hfunc;
+	else if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
 		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
 
 	err = ice_set_rss_hfunc(vsi, hfunc);
-- 
2.43.0

