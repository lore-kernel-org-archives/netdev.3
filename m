Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D73AB5D9
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594957; cv=none; b=TKGwZSzmNfWj7RSNFFU0Xo7BJSUQJyBrWBY2Z00hZFrBRg02GYSM3vDP/j9qBlJUp9DUwZaCZaYyUkKzSEqYcThwNsBj51rXclt2YBUnqQYFGc5UnuLV+BQ1ynh1i+daMie8HFfbatnjGVoG+Lp6iIRkiPvfRIVCkZaf6o8h0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594957; c=relaxed/simple;
	bh=9aq3l7pQ7Mjfw3VwJA+8Dhs6YWVZvwwIVUvAlQE2R7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwScxAZXUuzgIqsAJ+cAazv/UYL7IE/+XVModPZVe1Lg0f3XcH8I3x/YsvyBv0qwuGEn6MCewQWiQ5WvUgvFLC/R0/byuu+tCNATvpVSIvcfzVnMTyhbMCDgIPlEgVdQDkVnxTcAQXbAmTT/WQaMznslia3EQCILTwITYCQwLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDb4HBNp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDb4HBNp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778594956; x=1810130956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9aq3l7pQ7Mjfw3VwJA+8Dhs6YWVZvwwIVUvAlQE2R7Q=;
  b=VDb4HBNprG0Jq/G6wM6x31bJRRcwOMJcRsFuZH6gRIJCRJzT17YHuajj
   Q0xCf9Zx5VmYqobaXlMZpmPTZKMvv+Kh1OOU7quQX0QtxZZgCLVySdIn2
   Q7LYM7eVM968wPl5xj4oMDJTv4i1qaHHUAxpNJH3G0Y1UwN46pjb+nUpv
   yUTNstYhIUcTBHmt6L858ZnktuFI85aHWVlbOYOZF/DuBv7Sbxv+jDbkr
   6722xGYWHgd5Hj7BCdjd8PPv8oWov7Cz45hrgF2seX8l9CjrMGrVEZ6Em
   O+dVc3x5Ogv4eOeiZ3K8EbfkCOqdebnIgH0nuEBmJOyD0yHOMi2H5KlM0
   w==;
X-CSE-ConnectionGUID: VMV65/BQSJef4LLcdOCUzQ==
X-CSE-MsgGUID: mOBd8ah3Qxay2/SLU9mj1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96929671"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="96929671"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:09:16 -0700
X-CSE-ConnectionGUID: yt5lASHASUa8mIPToME5Gw==
X-CSE-MsgGUID: GkscmG7nR26lRYvKSdTKVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="275892491"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 12 May 2026 07:09:14 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 5/8] ixgbe: use ktime_get_real_ns() in ixgbe_ptp_reset()
Date: Tue, 12 May 2026 16:09:01 +0200
Message-ID: <20260512140904.4105236-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
References: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
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

