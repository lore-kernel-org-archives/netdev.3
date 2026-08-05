Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615B3F4DF8
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965762; cv=none; b=Q0J2Pvw7qLpTIp6gIoWjEjBG5dZjC9K04KXH4EBYG+8AlCNVo5QsEsnYK6nZ844Ub59+yPSgDT4IUa1eSnA9QHZrEXddGsUulQG1LLZ3Pkk/uq0QKtzFKz+KXVCKB8Y8dsAk+hPmELDyBP8I4tGT9w6JUGVzMqIT5y+smAdWfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965762; c=relaxed/simple;
	bh=c3v/0pXVJ3LHvSHduyEsiQyoPwrhjb4Z3NoaAw1QoTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFXltgKwqB2XmBsryuGUfNlOM1gU3NDdwYn9cfKxooal9VJASJ4sdMxb5ae6E5yOMYE66nP5j5YrOJmAvPsPotN2JALg4wyFQy+yn/al0pNMnHFe0QKuOdy4p/P8Ufgthm6Rildaio0HeDu1FEWN+MjWvPzb+bQZvC+LkbsH02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jr9zt6wF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jr9zt6wF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965754; x=1817501754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c3v/0pXVJ3LHvSHduyEsiQyoPwrhjb4Z3NoaAw1QoTs=;
  b=Jr9zt6wFeytyyqHoujFeR3gz/Dh/gKuL/W4QKRMOt3NNFjQalwECOJ6P
   HGeLEy4JeKYmp23XrdbBdV0BIpJ6FfZefC5dry7zK9R1vSAWxDvXE/Tqi
   Rk6cCbF9P60qwc/EZCZtiEHj/qiPrMW5/PlXXj5WFtuj4Bgf6bAd5ujUJ
   Wu0F/EIm/PdUVE9nKMwzySuKhiPifAcoylgiUpyzwqK0cUW67tB39gtjc
   r0BEMmymxgpg/7aVq12HaAv5e4tQWPq2evXy/gKBZHvxfzXtK8Xo09duo
   LZJZI6b/rLZtzRW/KcIYbQZLPXt64AvXvYb2UMuU+2IBFz6W7Sn/Ck91p
   Q==;
X-CSE-ConnectionGUID: zb4Wks0+S/6Nw5AcPih3QQ==
X-CSE-MsgGUID: FQ4/LRg1R/Sng7xsU9T5cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343578"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343578"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:51 -0700
X-CSE-ConnectionGUID: Htl4cuimTDyPvKHlgYKh0w==
X-CSE-MsgGUID: qLTa15orSRiUaszKM8vPtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576130"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 08/15] ice: increase OICR interrupt moderation rate to 20K interrupts/sec
Date: Wed,  5 Aug 2026 14:35:33 -0700
Message-ID: <20260805213541.2281287-9-anthony.l.nguyen@intel.com>
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
index a5e9c3114706..fefbc51c7190 100644
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

