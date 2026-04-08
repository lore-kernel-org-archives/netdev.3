Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BA3CCFD3
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653949; cv=none; b=eQlIMnwnGvqJR9Ga7nmpzdXYVuezpcAl2neLpv1DYzvJBbpVQkXvsG3YwAGUrAhd8c2dFq5kVywXMDfpDHeIwEj8HtgSmFSWUoCYkjVoagYUTYjmkufy7F2OlrmQmbFKJxTuKKU+zHvNzfXvitRzgfSDdQunQYGsIXqj5EH7874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653949; c=relaxed/simple;
	bh=GraGK+5jYTqk03FZotLtS7Brb5Ynw8+no2h6/cXf4ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rY9O777nrUUd40ZaDE9WRsRqHE91h3SS+6EQ34ZfR0S9K8esVIRXMfumfCeGEW7sf2K9Jl31Z6+pqmyYgVex8NOC4DCsdONoV/s+894As7LNxR9tJY83ABIkOzSE7VgkrbRa5DVq8FdYRLk8i2hinQLzICIi5Zpr1Rob8EoNA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5f4OTrl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5f4OTrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653948; x=1807189948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GraGK+5jYTqk03FZotLtS7Brb5Ynw8+no2h6/cXf4ww=;
  b=h5f4OTrlTFiZQW9qNYjRxwrDKPw9O3ilopeXwcKn4sILRBbjEq70/yFC
   HJBXspl92cG9vohzFAD3qXpqkIe4Auwsq7+hANA/0IJGPpl1BGymTZ2Kt
   pw/BzbTgBtHHX0NaGtjDggydfH9ubfiyBxewogdoVGVOyu1Cnm4GAHVn4
   eW2H6Sl6YIVtCapVaM7yZVHXD4X7k6XSc7ZedLGic4Eoj+yGka3XfLQZQ
   guKNcDFjySkwfz4AUZ7VN2j4MZJu+UXCMDW/YJLEPiKcNKGBE11KgIeI2
   10OzldD9mbwSxJ+OgBan25aYGbzlqfzhe6QvzAcOsgPAKDMzN4NQUdAJA
   g==;
X-CSE-ConnectionGUID: 1sY0TnchR+yrMdsvpkEkNQ==
X-CSE-MsgGUID: olRlCVe1R0yb+VYLI3QM2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087287"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087287"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:28 -0700
X-CSE-ConnectionGUID: bIcCOUscSTK6IFHvfTvbYA==
X-CSE-MsgGUID: drH3t9zmTdiNJw2uTdWSTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228715105"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:26 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 6/8] ixgbe: use ktime_get_real_ns() in ixgbe_ptp_reset()
Date: Wed,  8 Apr 2026 15:12:14 +0200
Message-ID: <20260408131216.2662245-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
ktime_get_real_ns() in ixgbe_ptp_reset().  Using the combined helper
avoids the unnecessary intermediate ktime_t variable and makes the
intent clearer.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2:
 - Carry Reviewed-by: Simon Horman from reply email; add [N/M]
   numbering; no code change.

 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 6885d23..a7d1635 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -1347,7 +1347,7 @@ void ixgbe_ptp_reset(struct ixgbe_adapter *adapter)
 
 	spin_lock_irqsave(&adapter->tmreg_lock, flags);
 	timecounter_init(&adapter->hw_tc, &adapter->hw_cc,
-			 ktime_to_ns(ktime_get_real()));
+			 ktime_get_real_ns());
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 
 	adapter->last_overflow_check = jiffies;
-- 
2.52.0
