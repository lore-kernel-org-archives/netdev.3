Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257532C21C5
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 03:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209958; cv=none; b=LlJhRDW1//U3CiUzyVP6d01CqBNNTPdRtljfuKIG9yj8BVrLUDrHUL3TAKnQhNgcnvvl2PxlNP8Y3arIdO0rH2k9jbEEv81OCRTCRE2WPd2wIKyCDcTE295VEWHhRNx+tAPcBxXOg+j+/LXjmFZu0R2CyEhZX03XbBH3iIZS0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209958; c=relaxed/simple;
	bh=9aq3l7pQ7Mjfw3VwJA+8Dhs6YWVZvwwIVUvAlQE2R7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xks3K5tFMAZ0xaLIvWOlloqs51l6ft30BHbofjGrxsTuD5NaWQuwbudOHFRZFzKGVvUFCDO3pRIs7q4sCbkuJ+kFByo7MHaqQJLIKo6f83J2Vi38lOlilSST+7FPtMv+VQ9OmJ3J5hmW9cxQYIoXyWagXE0OqpQUwDO2e917pD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbH9sH/Z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbH9sH/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778209957; x=1809745957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9aq3l7pQ7Mjfw3VwJA+8Dhs6YWVZvwwIVUvAlQE2R7Q=;
  b=DbH9sH/ZEGfMM5rL90m1z8MfqCqRANZjdbfQUTHUQcam0IGtjMLu0E2K
   wCLmUVPlfkSH4PNYy+wE4roIXTnMZTUJKuZO/nSFH8l/fsMpaKcV89gdQ
   XaqKh3zPViJvSeZ3MbwqwRaES6HLWkP1aZWQaY7oU8j0dVZD7eebTGDIC
   JyCfbgO6vM/OBtU5WijF/n+2mzzv2zEw3K/G94STQeawMcvNegwhOmRzb
   dlVwtYMO1qyGQ9e8LKxf/f7mZJiY3w3Plw3g8NZw2wDDI+e1BCNweqI1n
   3s5GjPHazfHvxjZ4bSMT3lsW8r8Wd2cEaiYSKInn5JzV4x73TFnzLscxE
   A==;
X-CSE-ConnectionGUID: YMhcTT5DTf+6iYLhz8jtbQ==
X-CSE-MsgGUID: Sjm6W8cURruix4JgpGHenA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027506"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="79027506"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:12:37 -0700
X-CSE-ConnectionGUID: ZlO2kQE9SYGyGqP1UIPL7Q==
X-CSE-MsgGUID: nCsr5/F3RrqGPXX54wiubw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="241623205"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 20:12:35 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next 5/8] ixgbe: use ktime_get_real_ns() in ixgbe_ptp_reset()
Date: Fri,  8 May 2026 05:12:23 +0200
Message-ID: <20260508031226.3601800-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
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

