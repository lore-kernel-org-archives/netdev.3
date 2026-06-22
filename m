Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D818356758
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165680; cv=none; b=r9xmf6tMuVsQ7bMAZ5b+bJbh8wi6mxBFTiwP9FGcgFDTT5aPzHqRFPW8coEStqx8AAfzKL0Fv3s3SSgZpJBlYlyGCzrrnSkSeNjWH8yU26Tx4597q5j0NMmTo9/wJ7qWhjfFvOy9SOhspnmDNqk6ZYXxKPZQYNSszEltZsSPhsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165680; c=relaxed/simple;
	bh=R7C+piqaI93YvOd0r/N47Ydv6xe5tGb3vp1MDdWvmzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtHpYVHVH4d84gdsBVnlVXr55XixRPScro2287DNzy3U5YXMhywLuNL2bsMtviONOuAdMe23CTyy5zuZv/shniZzrwS0KI1a9kFQ9QqJfpXGRJcUDJGJjKwi+23dCu+1vWYl1GicmKsw0t6QOdwudjYzZtvJP2ETzWzULECeulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0oIt95q; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0oIt95q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782165671; x=1813701671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R7C+piqaI93YvOd0r/N47Ydv6xe5tGb3vp1MDdWvmzI=;
  b=D0oIt95qZ1phwQUktw9lGEQdPK9Z9uXECA5Z6xQHFD0CMrE7wgic5kvx
   R1UMjNEiDHb0SICEG+SGrYCgChZhBudDnwZhkdZOsKIe7ofxx9E/TS7f2
   0zj7aQkTz5BXvnIt77Ii7uU4vJj7LlcNenyaTLbaqe/rHcRw3MVR8A+hy
   mPoFV59U9Ycxot80IbISl8HCHPz25tgbVsqm64VyY32bklxiVKOA8mhQ/
   kXFbBok6YPIk3L9fAINPuYckNnwJx/px/x9cHvZKKhUPWVE+jl8poR3MF
   NMUK/ljCe6JGo2SHYCMhOqhrt+9kG5PjvwKLLGELTy8D2T0Lr2rMrpF2r
   w==;
X-CSE-ConnectionGUID: JlZ506TeQE+OmTvZGX19Kg==
X-CSE-MsgGUID: aikpPkXwRW6f2VMtrBV/5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82675572"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82675572"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 15:01:05 -0700
X-CSE-ConnectionGUID: FTqS32ZpTgKX9tszBQ5Xag==
X-CSE-MsgGUID: Hp1BNPJsQVmLqnqmSon/Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="248205717"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 22 Jun 2026 15:01:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Patryk Holda <patryk.holda@intel.com>
Subject: [PATCH net 4/8] ice: call netif_keep_dst() once when entering switchdev mode
Date: Mon, 22 Jun 2026 15:00:51 -0700
Message-ID: <20260622220059.2471844-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
References: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@intel.com>

netif_keep_dst() only needs to be called once for the uplink VSI, not
once for each port representor.  Move it from ice_eswitch_setup_repr()
to ice_eswitch_enable_switchdev().

Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f0969035f..c30e27bbfe6e 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -117,8 +117,6 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	if (!repr->dst)
 		return -ENOMEM;
 
-	netif_keep_dst(uplink_vsi->netdev);
-
 	dst = repr->dst;
 	dst->u.port_info.port_id = vsi->vsi_num;
 	dst->u.port_info.lower_dev = uplink_vsi->netdev;
@@ -312,6 +310,8 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 	if (ice_eswitch_br_offloads_init(pf))
 		goto err_br_offloads;
 
+	netif_keep_dst(uplink_vsi->netdev);
+
 	pf->eswitch.is_running = true;
 
 	return 0;
-- 
2.47.1

