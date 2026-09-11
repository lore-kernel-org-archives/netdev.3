Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F229ACFD
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086888; cv=none; b=Bps+WrTlqVdKpWwq/EvuELjdETGxqk+EK3h3XyU8g+SQ4GH3MHHdr0DdKoEv+6HEQ3j6kqo4M928ujfOjb21/NoQ6iy5rTi0Ll1AEBRIcBTLGRQpanP8oLK7uKcAqhTTU9XkLLJvDTtZmE3Z0TJay3y5Q4YazcFTV6unJJi2k6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086888; c=relaxed/simple;
	bh=F9/TVgEPpBmP7N9Rup/85U6WpG8B3MKxvdQzqmiWCRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E61xxaoy8yuah8IeBxVCVid2AvUwH7+Xh40nb9rO/gCe2W5ZrgppI5tsB6RgEyqSEG2JhU0R1VaCeC81fo2zVLnivB3YTDpH+3OB0VTEOaV3+CaxvqZcBZcoJdJ6aVybPzQaA2eLGehTW4XIOIaMa+6ZRrfWnBRQQxCrk+x2A+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxEpLZgF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxEpLZgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789086886; x=1820622886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F9/TVgEPpBmP7N9Rup/85U6WpG8B3MKxvdQzqmiWCRU=;
  b=KxEpLZgFg70JRHq3wLu+LxVsbGA2BYbmKBhZhhtQyZ4xBqhvsg6P2dKP
   Yi9CxScUtOEjA9HHRXKnjAN7c2LW4zNY3OM4oyC9RIMKW0Eine52+eMtH
   Nzz5YuEYl3MFwg/Hk8aY/9UZ7MxCOagOvvOT5lUr0UF6q5biOVjBasJ0H
   Ql4npxJt2EzO2QKDsfDwWQm2xU/I7YS7hpwK0KeQaiXlj+14Q3qByyDnc
   0Ckzo7s4pSk736S5wREjD+5AwZeGsyVxyCYuNpEVL7Uzmrqh3E1mM3xeR
   JVSIul/gskKiX4ZFmRTJn6bexJz5sfGBrYNw1YxroOixvZhWtP8cbgASI
   A==;
X-CSE-ConnectionGUID: aVUXVPrETpe3qSvF9ZMWpw==
X-CSE-MsgGUID: ZvSYf/j4RPqMhl8r+7FhHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89564676"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89564676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:34:43 -0700
X-CSE-ConnectionGUID: /jhy5PZkQ+SrLUUC3j9rrg==
X-CSE-MsgGUID: Y0EYibQ6Rh6PDXTUPqakxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272291045"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 10 Sep 2026 17:34:44 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 02/15] ice: fix removal of PTP timestamp tracker during reset
Date: Thu, 10 Sep 2026 17:34:11 -0700
Message-ID: <20260911003430.3386340-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Commit 7a25fe5cd5fb ("ice: stop destroying and reinitalizing Tx tracker
during reset") intended to modify the PTP reset flow of the driver so that
it stopped calling ice_ptp_reset_tx_tracker() during teardown and stopped
calling ice_ptp_init_tx_*() during rebuild.

Unfortunately, the commit only removed the calls to ice_ptp_init_tx_*().
This fixed a memory leak in PF reset. However, now a CORE or GLOBAL reset
will leave the device unable to initiate Tx timestamp requests
indefinitely.

In practice the CORE and GLOBAL resets rarely happen in production
environments, which explains why this has not been caught until now.
However, it is trivial to verify by triggering the reset from userspace via
ethtool. For ice the following command will trigger a GLOBAL reset:

  $ ethtool --reset eno8303np0 irq-shared dma-shared filter-shared \
                               offload-shared ram-shared mac-shared phy-shared

This was found by Sashiko review during feedback for an unrelated change.

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
Fixes: 7a25fe5cd5fb ("ice: stop destroying and reinitalizing Tx tracker during reset")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b12181b8c843..142d39ee5cc5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2979,8 +2979,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 
-	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-
 	/* Disable periodic outputs */
 	ice_ptp_disable_all_perout(pf);
 
-- 
2.47.1

