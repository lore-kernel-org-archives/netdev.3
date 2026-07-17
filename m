Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55D345741
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314429; cv=none; b=IA8vz2uzkg/vABdhK60PvPc9hbNHtRZAGgH8goIZDPI2DP7MS3HPYr0soci+ii6rXlIstyIyK1eNj1qPIsr4U/nLkPSZAtirtIxmC/f2KyjpIxDnuWQZtgSJdzHuafi2XP3CIUuOkidIcN/rzR9WM7XRy0vRNoWxTl2tihtjXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314429; c=relaxed/simple;
	bh=eIvO8t/cc1StWNCbpgpjTmzKlzi7fSDxLY3v5Egyito=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/I1ObzR38eu4MwZJoZcdC24OTu3UuHPND6KX5ITpU3YUMtyqqoXIyhnvUYXz2cYKnIc3CoBBeHTWeFEzNHDK1EqAet5KbQSq0odye88zJwTo67HAUkasy6YuGWCOmJCJcTtwD7gT5xuO/zgh4uH50+UddrbEbyY/ggE/ceY2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOWs08OF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOWs08OF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314428; x=1815850428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eIvO8t/cc1StWNCbpgpjTmzKlzi7fSDxLY3v5Egyito=;
  b=HOWs08OF3omW2X3+zaWeAyss1ao7NhYs1EQvSb9rtEZJjrYufW89SypA
   UvH8U7DccbsPY32bzEfyQDWkhJTzKA6vZnqUcBvtv+MoityvPF/3H8u/X
   ixSYrA61UgSsgDx3+E5T49N2odc0AJ4tVAqz+1JRjc3POPKTnjLTxDcHZ
   2FEKtqPViv4v3voZse0a6RKE30QsE9s4VFiEHpNKcVoI3DdaS2UZXjzj8
   gHLJs2n9nfGGMFGOWOrDwY8jmSCOX35Clr2wG8Pi09ySaMbKrmjEFIAbh
   c8P+iG5eOFgy/ZRsN8wCsCsDl2i36VtFHWGqbj+VTHXw5NYfstIKscyuH
   g==;
X-CSE-ConnectionGUID: gsIzdhdMT5eHnrMF3lkigw==
X-CSE-MsgGUID: U5LXws93Rjm+8Uv4FcUYFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347591"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347591"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:46 -0700
X-CSE-ConnectionGUID: 2P+TZ9/PReajnVaSixaqYA==
X-CSE-MsgGUID: Uz/f18tITX29KldlgurYrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827226"
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
Subject: [PATCH net 02/13] ice: remove redundant switchdev check in ice_eswitch_attach_vf()
Date: Fri, 17 Jul 2026 11:53:24 -0700
Message-ID: <20260717185340.3595286-3-anthony.l.nguyen@intel.com>
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

All callers of ice_eswitch_attach_vf() check the switchdev mode before
calling the function, the internal switchdev mode check in
ice_eswitch_attach_vf() is redundant. Remove this check to align with
the design pattern used for ice_eswitch_attach_sf(), where the caller is
responsible for checking switchdev mode before attachment.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c30e27bbfe6e..b069e6c514fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -512,9 +512,6 @@ int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 	struct ice_repr *repr;
 	int err;
 
-	if (!ice_is_eswitch_mode_switchdev(pf))
-		return 0;
-
 	repr = ice_repr_create_vf(vf);
 	if (IS_ERR(repr))
 		return PTR_ERR(repr);
-- 
2.47.1

