Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C33FBEB3
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302113; cv=none; b=gQ5Iwo7OkFjhBRny1XqGNOi8cQ6zxb8iejDV77vHlrRJH5MPn7Xau9yDvIa6TibRBFavC2uBgBRj6yG8AUymcgX6GReIEIb09EiExN/sNmVvVHDn8rFapW9wCnbTY8QK0UwRXBUspz/6KJRN39TnrNhlgZKStHlv9CdApb8uuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302113; c=relaxed/simple;
	bh=YjIFpceXumzYuQOJFoApvkkRKN9MLrnLFf5J3hWq3qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTAm4SqYA6+Tk9wkDeKFdt9KPm8hb80RAkbr8HPvPWEPgcelEaTCvJ7h9lNx1eIe8Jq5NEPfBAvpc1u3h/MAo3t9yzfetxKU+5uMfHc5IHNvjPSGxShvhaJeBdr0EUUqptiDBLsCklgFfDOob02YGAfd6AhBDviZ0k0p5AZzpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuqwnJXi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuqwnJXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779302112; x=1810838112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YjIFpceXumzYuQOJFoApvkkRKN9MLrnLFf5J3hWq3qI=;
  b=BuqwnJXiH5AyJ4nkeQCXsPOFEHUB3fxrqWldF4JS5KVE9KsLr27pK2wr
   ToUy0XZGkzOAeA7MMrB1lPlTxjdYCSrXGy+BEA1SdCj9DpMSZ4JzdfKsc
   wOWh05lAKQiTbW3GxkTX90NXOasx0jgFGwFDqFaaQn9QnATS2nbEiMPjU
   WyFHzc4x6D2lNiQKLAzo/UMUuXXEtC0iL+Mle7dJhtMoi44U/MyJ+LvU5
   eTCuGT2LG9Y/Jmp/yRb1kWgft9Hhv2AhH6MPgnXynwZ+3fDh0PxHEaD04
   ASymlETWLVeaNNPeXObpYzpqyxhI1J5o0ClMotOUkCyHk+nZN8BN6lYH5
   w==;
X-CSE-ConnectionGUID: KIuvT9GZS/GUKg/I3sfp5g==
X-CSE-MsgGUID: vtRGqGouTxqOQjPiw25w5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80391781"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80391781"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:35:08 -0700
X-CSE-ConnectionGUID: mOzdmUeqRPiWNj4GU8JT3A==
X-CSE-MsgGUID: OjJnyqCsRIy8Zfr5oKuQRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="239423907"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 20 May 2026 11:35:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	kory.maincent@bootlin.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 7/8] i40e: set supported_extts_flags for rising edge
Date: Wed, 20 May 2026 11:34:55 -0700
Message-ID: <20260520183501.3360810-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemyslaw Korba <przemyslaw.korba@intel.com>

The i40e driver always supported only rising edge detection, so
advertise PTP_RISING_EDGE, and PTP_STRICT_FLAGS to ensure the
PTP core properly validates user requests.

Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 7d07c389bb23..c4525bfab09c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1344,6 +1344,8 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
 	pf->ptp_caps.n_ext_ts = 2;
 	pf->ptp_caps.pps = 1;
 	pf->ptp_caps.n_per_out = 2;
+	pf->ptp_caps.supported_extts_flags = PTP_RISING_EDGE |
+					     PTP_STRICT_FLAGS;
 
 	pf->ptp_caps.pin_config = kzalloc_objs(*pf->ptp_caps.pin_config,
 					       pf->ptp_caps.n_pins);
-- 
2.47.1

