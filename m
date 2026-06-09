Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21E403135
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040974; cv=none; b=KsLFqgLsZ1Tn5/6b6ecWoEHHR6pRUF05v/aiUVDePWP+rSPcXHC4FshD0rDSmoiTBiUxmccNZ1NBMnHZiccsMQ+fVp6Si2iQGZw6VMh8Bhcs5yN0jzkn0IVKo21M11mSNGwHFemZs39J4eKkri7JEeQN78FVcDQFJd6XQ43Hjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040974; c=relaxed/simple;
	bh=ItuS9Nv3mFg/AklMR4gsfvfMo0KKi40B0v0cgb2/9sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwpDzLWWLR/kbUhSx7JuXEln9PYsiX3aTNiZs4V6wW6nBMaRAL8a9/l9ochbqjdSF+gf22hBE4GbXMcF+Y+YxnFp30XdZI6tHl5PqqmYp8ytlwZSAkLYFkOA2g0yLX5rKQ6Lc8VAq5SY90PDjNcjoFMaK1rmzzanP135eRG38Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/SUcscV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/SUcscV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040973; x=1812576973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ItuS9Nv3mFg/AklMR4gsfvfMo0KKi40B0v0cgb2/9sQ=;
  b=E/SUcscV47vgMGj76DajW6nsFboJICPvKrHJlVg3QUUg1FUvCIDNWksL
   BzWE5zV5Vrw7NpIIqs9/haUOsuFW8x5g/YqvzVj08fExhcx1nmCCw3azW
   IUM+wDWSU5hlB/aSvnfGsDyNi846IlnJ+L4AKM37gpPkZnGpUTU2d+SNc
   i7WeVsC1Ki48Hqy+6hM0hn0ZI6p8n1Yc/oAefg38eXbETfGirdWgV37q3
   pFjD/wLENk4fHtxF8n1rVcR7GhqGNaFLdGCRtQp/8iewpu5XVr4qexkkI
   Pv6wYcGtRrXsjEedC3pNj2XmaYSpan8G8wCh67vVkn6fngQrcaUakQxGc
   A==;
X-CSE-ConnectionGUID: RjrbQ2PJSdylTwR+PtGqQA==
X-CSE-MsgGUID: eU8O+iYYR22Y78Y5WFItVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568545"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568545"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:08 -0700
X-CSE-ConnectionGUID: ASECfJR9SeiD6KQ1JQZsSA==
X-CSE-MsgGUID: WTup23kZRmSTQ/c3bFdHIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838581"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 05/15] ixgbe: e610: remove redundant assignment
Date: Tue,  9 Jun 2026 14:35:46 -0700
Message-ID: <20260609213559.178657-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Remove unnecessary code. No functional impact.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 665a9813e251..4d8ae5b56145 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -142,20 +142,14 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 			  IXGBE_PF_HICR);
 
 	/* Read sync Admin Command response */
-	if ((hicr & IXGBE_PF_HICR_SV)) {
-		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
+	if ((hicr & IXGBE_PF_HICR_SV))
+		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = raw_desc[i];
-		}
-	}
 
 	/* Read async Admin Command response */
-	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
-		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
+	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C))
+		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
-			raw_desc[i] = raw_desc[i];
-		}
-	}
 
 	/* Handle timeout and invalid state of HICR register */
 	if (hicr & IXGBE_PF_HICR_C)
-- 
2.47.1

