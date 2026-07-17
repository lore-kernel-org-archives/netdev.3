Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC7393DF1
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314430; cv=none; b=SWRCwootlZIhAC69viBfWvuaukG9wNVjbpMfkYgnZWJmpuvwKVzjflpVTkozIVzhtgU8e7iBkRr6sG1pQrLWdS5V4a7zyv97JSnLiBA6CAqJKTpSmIFiJ40gg7aPsNIEsu6WtIxqPhgSeN2gdei9obxV2cGescGgX+Wf/DCBseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314430; c=relaxed/simple;
	bh=ymB+th/EM0ytcHws4YFA5DU+gTrO+phq0hABDqToolQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnD+zX0J6C2/vvlqqA6EywIUGdwgAJhk5GEemrPSRRpJXClpT2NhhFkYR+03qpJVNR13l187FO2jn1e4hYkNOdGHcmFr2Ba7nXthgt/ZmgqMPEpyvZzK0ep8tZdss6Fzt1F6MIZtpl8xkgTvkGlyAeYEq6cuqt3RsfllUBr09oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIGnLl40; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIGnLl40"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314430; x=1815850430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymB+th/EM0ytcHws4YFA5DU+gTrO+phq0hABDqToolQ=;
  b=OIGnLl40hSLiAxvQkb5OHab1owEAF6UB6UXJL9chtgtLNJUzIzlqymh0
   D11CrZYhe+pFNUc4szIwcyiTmcchlJWvgh8LXwddjr8y21cBcQz9vFFvP
   srNYpeJJqWFgkTGQ82Fqk/A/SoRLuv0ayLB3UkQXhz3bg27Bnioy3E/H4
   2hSXnaT2vDZmOpA5a0A4vMbElTvf2ff1qE0i81JFaF4JkCVbNPKURCnv8
   AE8/wd6mZMFl/+JVkW6gupuRQ3UCIyVEydo41ZSaBpqEdu+eNrBNKEXC9
   84U7OuUXp25liwQfvPurrUYGmtQGPsr3Mxe0E7dE19IWV5u+uE++1Nsjg
   w==;
X-CSE-ConnectionGUID: +8Ac8g4XRCOnMEE8as1HoA==
X-CSE-MsgGUID: LhbzaqTWSPurYanF8zW8cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347617"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347617"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:47 -0700
X-CSE-ConnectionGUID: 0IKevqeaSfOHh4/m/3h9Gg==
X-CSE-MsgGUID: 3dXj4YJpR66lhxwl7OF5fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827240"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	daniel.machon@microchip.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 06/13] ice: fix LAG recipe to profile association
Date: Fri, 17 Jul 2026 11:53:28 -0700
Message-ID: <20260717185340.3595286-7-anthony.l.nguyen@intel.com>
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

From: Marcin Szycik <marcin.szycik@linux.intel.com>

ice_init_lag() associates recipes to profiles, assuming that Link
Aggregation-related profiles will always have profile ID lower than 70
(ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER). This value seems arbitrary and
might not always be valid for some versions of DDP package, i.e. LAG
profiles may have profile ID greater than 70. This would lead to
misconfigured switch and LAG not working properly.

Fix it by checking up to maximum profile ID.

Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 310e8fe2925c..08a17ded0ad5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2623,7 +2623,7 @@ int ice_init_lag(struct ice_pf *pf)
 		goto  free_lport_res;
 
 	/* associate recipes to profiles */
-	for (n = 0; n < ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER; n++) {
+	for (n = 0; n < ICE_MAX_NUM_PROFILES; n++) {
 		err = ice_aq_get_recipe_to_profile(&pf->hw, n,
 						   &recipe_bits, NULL);
 		if (err)
-- 
2.47.1

