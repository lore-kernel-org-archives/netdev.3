Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD083EFFC5
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965755; cv=none; b=PYqK8nHlMUzh4cCFHG8KFKClwcFXeoEzTSR4P13qBx/yes7oZFBqYHHcS4k0o1HR3BfEQUCb2+BznJhQSEJplj77AbslPfuq9LqoSEc1LkJBwh5WHYVhse0R0GlBAUlcivfOys+wt/1M8poxt3Ewjk4Gz6htQ4kbQl01OpnilDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965755; c=relaxed/simple;
	bh=1coqiwWlJPlhomCJrgiHxszVKxKz9kd15ZO8k1aS+ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAw9p7jcAzKQchp3mW0LsMa2JkoCGVVIBBalQPGhZ6cJSu/Y611/7/98zdHr+PzDQhxGbMLXMvA/SzHyh1VcWl9iAHZY4a/ganYSdGf7umPkVD4yxS+IVfr6mJ2q8lfF/SI+6LuUFRzmU+c3aebSYHE0gC1igruG9dT7YEivq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/qTne4E; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/qTne4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965753; x=1817501753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1coqiwWlJPlhomCJrgiHxszVKxKz9kd15ZO8k1aS+ks=;
  b=H/qTne4EpNg67Z19mwxxvafPynPNrOjEA+mCW3ZXTT7s2aTLu8p2/hgi
   EvX/yMZEA90dpTeYnGrJ5PqiTIvg87Z4AyVZKQrp6JM9RpsGa0vf2RHHD
   j1e8NNtVWYpyoYeTXkK5lQQ0cN335DzE8ej7DMu+MgHdIs4ha3u+eiz6x
   iOGoX3haZ7TWsCdchaDgXDohdIyYr1g9huHKZeC06RKij3MyXz2aHAY6b
   3f0vjrGZrnt/W/7jLXEBeqGivW9OsSS9RoA22Zpt2U1u4LZczRrvFfGog
   /2961FvkgocbyvuMckyuducahsnR200Kt/9Gr8Jj8AMfPR7wFunKLQPOf
   A==;
X-CSE-ConnectionGUID: r75gQo6KSbK438t/xmksSQ==
X-CSE-MsgGUID: +tkhq3DFRMaeJL61ts3lCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343548"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343548"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:49 -0700
X-CSE-ConnectionGUID: avlLS83LQaO4cSjnm8mh5g==
X-CSE-MsgGUID: njcX5xD+QjuEwEc6+0pOSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576097"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH net-next 06/15] ice: reduce loglevel to debug for 'Can't delete DSCP' message
Date: Wed,  5 Aug 2026 14:35:31 -0700
Message-ID: <20260805213541.2281287-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
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

