Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359137BE72
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165683; cv=none; b=jTwnjFsxoh4FiSFoDabWxdcU7XTLpukc2NR46YkPn49ryzhGCNCkW524ZmDCa83J6Cz0Mnj2aCCGUJnk5OSN55o0WPNCZH7LfSiGnJX7Cnoy7kIM1hlB2gAFImm1KnowSJsE62htvnxT14ct0cEnQfJUikVV3QHLYy2C0rcjjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165683; c=relaxed/simple;
	bh=TVV5GTh1Jcornq5c5KG3r9E6+A0Bd7wX1wfwDB1bMGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CudfATsKuULBwP1lDAxnI3j5VLbN0W/3mib0RwWWcCzgy4fcQdUgV2J7lfYcYaINSZbPCMgCIGKUMYnoYLlMRkdFFkz6UJiuEPKfbPmtQuWcV1+9znoMbGWc3e0uqrPl6gjAmXzblQVplHeozyP2jhEYKz9APYWIxgBREm1v/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n52Ax/qz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n52Ax/qz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782165671; x=1813701671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TVV5GTh1Jcornq5c5KG3r9E6+A0Bd7wX1wfwDB1bMGo=;
  b=n52Ax/qzszZgOMwOfsHddwfdMFPKrk3nUbAwPpL9zlfzVeTACI7ZIOrq
   lFEMmRYSbnl6vaxY3mlS9VG4yXVO7g6d7UYpVfkdRvOUIDbIr4cc0fevV
   fHpOtRKplaBw8526AuS83/e/5f69hz6exkKdBAwe/CBrGkigJ3BZE39fu
   GwQUBBYimCTKFHgBzL44GQ1TaopG+MTNpPkNxBFB4PjFjj+K7DM3W+oM+
   TwiGnDHPNkyQ41hugEsAq1Mb5Tt0yoK69ZWpeh2V6jVgbSCYPVBn0hObJ
   BSpxYXVIzD5+pTPA+4oBPmWyJCt/wB+fcvBsG4j6tHAE0F/m2YKaV8JsQ
   Q==;
X-CSE-ConnectionGUID: qq2YhoxjRk2p+69phYEnrg==
X-CSE-MsgGUID: +VWGVU3nQgaI5VB0A9RAlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82675599"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82675599"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 15:01:05 -0700
X-CSE-ConnectionGUID: H7Lg0mzHQHuDxhB78ejHfg==
X-CSE-MsgGUID: 6Sk321bITPKtFTMO29fl5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="248205728"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 22 Jun 2026 15:01:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 7/8] i40e: Fix i40e_debug() to use struct i40e_hw argument
Date: Mon, 22 Jun 2026 15:00:54 -0700
Message-ID: <20260622220059.2471844-8-anthony.l.nguyen@intel.com>
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

From: Mohamed Khalfella <mkhalfella@purestorage.com>

i40e_debug() macro takes struct i40e_hw *h as first argument. But the
macro body uses hw instead of h. This has been working so far because hw
happens to be the name of the variable in the context where the macro is
expanded. Fix the macro to use the passed argument.

Fixes: 5dfd37c37a44 ("i40e: Split i40e_osdep.h")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debug.h b/drivers/net/ethernet/intel/i40e/i40e_debug.h
index e9871dfb32bd..01fd70db9086 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debug.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_debug.h
@@ -42,7 +42,7 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw);
 #define i40e_debug(h, m, s, ...)				\
 do {								\
 	if (((m) & (h)->debug_mask))				\
-		dev_info(i40e_hw_to_dev(hw), s, ##__VA_ARGS__);	\
+		dev_info(i40e_hw_to_dev(h), s, ##__VA_ARGS__);	\
 } while (0)
 
 #endif /* _I40E_DEBUG_H_ */
-- 
2.47.1

