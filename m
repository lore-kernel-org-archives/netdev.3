Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBC27B340
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357707; cv=none; b=P9IGRkkFTIXMDgMWaEpylqFtwvvG4jWOIOwu3pVURx2xaAh+nRoj40W1ni84RPeG6dIRVGLrzg/6YbO+tLRleoP02cytpYP2BZw+NuhnEmtjIC3/AIhEYzGwaWxMjXdE3wuAEwc2UAqTbchh1oGDD4iXJ1wEJtGT9YwnqlP5kLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357707; c=relaxed/simple;
	bh=L6wFLgo75OBbsTVRHSFdNT6sYdqsXUqea1hudqbm/Kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ub0nKIuWPtuBmCYvWIMAXZr/aAdLBc3bgvNo9veLDVg8XxUxrTFWa7QDTrnwGULxn7fGPz6LYfOnDr/ZS4IF4GwRJSwo/l5uVOIIgP+kDe9FbDB9c9tC7eG58+LfJI5qG1MJ1uKGkwNc9hIFxqmjt/oSKxDoldvD7GNbIVgkJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfLu4NI0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfLu4NI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787357703; x=1818893703;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=L6wFLgo75OBbsTVRHSFdNT6sYdqsXUqea1hudqbm/Kw=;
  b=MfLu4NI0FuPnI8rg7KpHWfidksTdWb6V+cR+Nt/vzjw1tCpgM+vH1LWh
   uoAq7DUDCtTCKWRihR6s3gVfh0xJRWti9v+l5sP6NBiyJRZP79BjVQuzU
   66sbapEYjgbE8lIw1xL0fgjB0QddkFa9rDLvyn2oRjygE7EOxwKuysa6f
   NZsPdLAsD8Bc8WYh1A13sCezo5z1zQbfchh4QZzQV+uCU2WxFyd1NPNkL
   Rd7THq5GB4cZcdVuuOfvlyWtAHY03bA+KO6BUFctOxBFayub+FkT+FOoq
   S0mFV7pztESFX/b8NQVWrLBRDgzGd1dAZgr4AsexgsjbNfwsjWynwm3fu
   w==;
X-CSE-ConnectionGUID: vpuYnmeOSnKsVrrZa4sviA==
X-CSE-MsgGUID: x/3Mn2I0TNCBOERqfUdE5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584774"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91584774"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:59 -0700
X-CSE-ConnectionGUID: VtHKTQ6rSneGnyx1Eu0mpw==
X-CSE-MsgGUID: 9Ypcah5xS8qMhOexfQdBdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="263836481"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:12 -0700
Subject: [PATCH iwl-net 07/12] ice: E825: perform a soft reset when
 starting the PHY timer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-7-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=L6wFLgo75OBbsTVRHSFdNT6sYdqsXUqea1hudqbm/Kw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl78uONZu+zn5bquRlODDdQWzxNvZbjBeq/voVXV5k
 qKXiElcRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABPZvIbhv1eA0/41v6Nj2ydt
 7HKPmnPn8JUUw6+cs7+ar3NXb1X1qmL4p+W741Ou3an4zHOtn/aY7vD9GpamaMaYP3/fJsegx1/
 FGAE=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
soft reset prior to programming the PHY. This ensures that we clear any
outstanding Tx timestamp memory, and ensures that the PHY internal state
has been completely reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index b7d217ac31f3..10e973876608 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2119,9 +2119,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
  * @hw: pointer to the HW struct
  * @port: the PHY port to start
  *
- * Start the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Perform a PHY soft reset and then start the clock for the PHY port.
+ *
+ * This must be done as part of the flow to re-calibrate Tx and Rx
+ * timestamping offsets whenever the clock time is initialized or when link
+ * speed changes.
  *
  * Return:
  * * %0     - success
@@ -2137,6 +2139,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 
+	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+	if (err)
+		return err;
+
 	err = ice_stop_phy_timer_eth56g(hw, port, false);
 	if (err)
 		return err;

-- 
2.55.0.814.gc42f45431d0f

