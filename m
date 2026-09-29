Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61489579811
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721725; cv=none; b=YmvL7qkVuychlQjFQhGE88c3kPhaSgtRuiouokBkBJaEmHj94EqP6wSBLTk0kbgOnTxBqOs4wa1VqsHMjXtdklpan3kFUrvROW/3wV62Jiu+FHAbXkhKU6c+a1Pyr9ATvsIdTqlsN3pSdsGTtQfMRqb3S8rNu7EMaMX2AxXUsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721725; c=relaxed/simple;
	bh=1coqiwWlJPlhomCJrgiHxszVKxKz9kd15ZO8k1aS+ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bB1gPVjwTPWDMSziipgOXPhPh0/r2lt+sO4CrAhOucMmBrntVhGbAkfah29dI4Bwg36yIcXpgWxjaOl+gg9RocVxTBrq30e3+Fth0nLskNe8w5cbRZ926O5Jt8qZpQJY7VfgrrsN1Tiq+bN8q4Gf+ade3H3a7xLLK+xrCBHWIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+LX4Zet; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+LX4Zet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721723; x=1822257723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1coqiwWlJPlhomCJrgiHxszVKxKz9kd15ZO8k1aS+ks=;
  b=A+LX4ZetCrJnd0NTNBcvDEKvZjxzfWJcYk81fGLsxB0JR352o/xWb+2q
   E3RhBrHpCZ+sKOyXBf9wTTpqz3b/j+nWK2GF/SCgzIjmoGXfu8TrgiCYl
   O2uhgZCMQv/aufUB9zPpZdwDjT0YJURiNmSdO787/mMVOAaSdn9kYVDjx
   AXnJ9FOWmD34mGTFvTnloy9fkMEkIFmkn4QyE8SM9AGHhnK/lzNyEPHSk
   hahFF7ITYlv6iigQkEYt/wnQHtzyJpKuJPvdyjRuEGTPY1afQK7KY6CSk
   N9rKTQNqaEc9NKwRYy9xXWc9lzmHCOYgzVQshCqPk08CeeSC+bj+NXgwU
   A==;
X-CSE-ConnectionGUID: SGwSJ/e4RHO4JjfDgjWtsg==
X-CSE-MsgGUID: b/HziWgjR2mCFKhkYsKwqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548853"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548853"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:01 -0700
X-CSE-ConnectionGUID: B+x/tjsiSEmTbGBbQvzboQ==
X-CSE-MsgGUID: WPz+7CapStqB9WeJPtULwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452297"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	xiongwm2026@163.com,
	ynorov@nvidia.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH net-next 01/10] ice: reduce loglevel to debug for 'Can't delete DSCP' message
Date: Tue, 29 Sep 2026 15:41:41 -0700
Message-ID: <20260929224153.1455466-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reduce netdev message "Can't delete DSCP netlink app ..." from error
to debug level when in FW (firmware) DCB mode.
This is not a real error and a kind of expected behavior. The device
is fully operational and error message might be wrongly interpreted by
the user.

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index a10c1c8d8697..bb5cc0a2ba69 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -872,7 +872,7 @@ static int ice_dcbnl_delapp(struct net_device *netdev, struct dcb_app *app)
 	int ret = 0;
 
 	if (pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) {
-		netdev_err(netdev, "can't delete DSCP netlink app when FW DCB agent is active\n");
+		netdev_dbg(netdev, "can't delete DSCP netlink app when FW DCB agent is active\n");
 		return -EINVAL;
 	}
 
-- 
2.47.1

