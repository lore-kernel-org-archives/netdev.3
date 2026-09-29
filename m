Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226657D20A
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721728; cv=none; b=JuwnL2jr7TwoYqkY2mGNizLaQzdLt4do2WV91j2ROaYjZaIc5N/B1NZJ/h363/AE5hlc85V4UMsCFAesfPsl9JHdDUqHGcg8W2+V5Lx328OCPeTySv4uv1CHRTC8SGnvJthL80or/J03oMoXjpME6CK3t7ZfC9Mj+hJ1cGuDmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721728; c=relaxed/simple;
	bh=uh4FdMuHAwT9B2zLb2vIrnKfu0GrMrFO7d9Ky1TIp4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHoXD/iKZRsPsDC8xNUAA4lhKTHknOUFZnXm1Fc0d2l8ZlAdN6jG1LW3ulhqSiM/6qAJu0Gbb6fWGAujbpcUCuAPRpFr3RRyS1yMe78fuxkiWIBWFLdgGZqd123UEfTvgf5Vf3Q9MAiJl0XRpDqvgu8MRNChtGj1HMq3C472de0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhcBxUpD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhcBxUpD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721725; x=1822257725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uh4FdMuHAwT9B2zLb2vIrnKfu0GrMrFO7d9Ky1TIp4w=;
  b=XhcBxUpDOg6cgn+r7Psxvvap3GGyiTCsb3tqXFUm35JirUgYZDxdX5lS
   GpoPh6ZYqKlgXEsEz6nFd9ieyXMrWxVWRZnZKpxMxtZ5+hqzJp/BkvjVQ
   JK/PshbwYzlVLdn0NzxabpdspuXPXXffs5nw3gdu6MzgGN5obKp2WiS/8
   iDj68r9Tp0ovdrf4tNQ47DN4qFxt/xs+r/C8pxSrVIpp4YAIuunXdBqUd
   V2odvqZH/C0Nt+XCYowOVr3gcZC2eDzhJc8ehwh5tYL+AVErARb2ozKGp
   FU/vHa+F2avF1kBIApomjV2kSzrHhuC7EEEtysQ5Fv8SXwy4rQUryMW6b
   g==;
X-CSE-ConnectionGUID: tE/hXik3Q3uGaT7sSgVe2A==
X-CSE-MsgGUID: nxAvyEcmSoaFaCUYvEBPUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548871"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548871"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:01 -0700
X-CSE-ConnectionGUID: EvgYysY3R8qzwsWB8dV4qg==
X-CSE-MsgGUID: 0n48MesXQ0qk1oLMPi8v+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452311"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	xiongwm2026@163.com,
	ynorov@nvidia.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 04/10] ice: increase OICR interrupt moderation rate to 20K interrupts/sec
Date: Tue, 29 Sep 2026 15:41:44 -0700
Message-ID: <20260929224153.1455466-5-anthony.l.nguyen@intel.com>
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

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

The miscellaneous interrupt cause (OICR) is throttled to 8K
interrupts per second (124 us minimum spacing). This interrupt
handles VF mailbox messages and Tx timestamps, so the low rate
imposes a minimum latency floor on both use-cases.

Raise the rate to 20K interrupts per second (50 us minimum
spacing) to allow lower latency handling for Tx timestamp
bursts and high VF message rates.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 707c7431b91a..73f69d453542 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3428,7 +3428,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 		     ((pf->ll_ts_irq.index + pf_intr_start_offset) &
 		      PFINT_SB_CTL_MSIX_INDX_M) | PFINT_SB_CTL_CAUSE_ENA_M);
 	wr32(hw, GLINT_ITR(ICE_RX_ITR, pf->oicr_irq.index),
-	     ITR_REG_ALIGN(ICE_ITR_8K) >> ICE_ITR_GRAN_S);
+	     ITR_REG_ALIGN(ICE_ITR_20K) >> ICE_ITR_GRAN_S);
 
 	ice_flush(hw);
 	ice_irq_dynamic_ena(hw, NULL, NULL);
-- 
2.47.1

