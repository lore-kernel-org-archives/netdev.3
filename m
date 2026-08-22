Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC323395F
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357703; cv=none; b=Psp/jJNgLJ+mAfsYkZFNLQ03p9eL866oMLk7HTC6vZ5iqKWPh7Vkf/3ouz2ylYRv2wxxtO1Iwy9oSFpj8957ltsqpoj/QNruBXdFsFG8g4omSPeS+49O2nFKBCNi/3f7dLbuTIMFMkyulsVQzanXXaEv4LCGqtdSAshMEvVV/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357703; c=relaxed/simple;
	bh=5eZvQaW2XLQ33MmDw+tyy8L38wPLaGjF22CO10SuBzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5VEOOsQLLZzfwbv3UOpH9pktmUBtQJ5h+JXcY+E+aLXjz9nHXzQwVWib17BqB0dNUyW3f1uJL6pmhV1c5rry9zRGHhvZxwIeA2sIeYyImsPDFWDpc4fizNlA5V6I4fbaD5uQil7uPxc/sfDCG9ZQ34Kdr0+wtsejz3dL/1N6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URBu87Nz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URBu87Nz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787357701; x=1818893701;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5eZvQaW2XLQ33MmDw+tyy8L38wPLaGjF22CO10SuBzQ=;
  b=URBu87NzK2ra7iW7AjA/yaGDJwAJxf08i0If8MEMI23hM8ke/VOqeuTz
   NntL/G6voiGx5VyMvF0lWi5RVCElO67rNjUqq6Oyj8IYYtSyTCHaCjXPo
   gvhvd7Q93pk3le1NKUm3S39PaZ6g9CCDI49VP36Fn86gv/qkN7xaVILhw
   moYJVcaCZdCbpzaFgSa30HrL7hDBMg8zR/d6Jx48YkHQXuUILGDCqYx2t
   2j/ulRGUpXdoZQHgKFJ85GXIujsmJLtL09zJibjIUujjUe6a78bdwzlZZ
   Ci17qAdYNkKwsgXYsYe2LPvBT4xO5XwIhtJwpGuCys3EsUHr+PSJJbV0V
   g==;
X-CSE-ConnectionGUID: 7qYIPuWJRQGerDU744nS6w==
X-CSE-MsgGUID: BN9WNm8MREWcycZpBz0fUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584764"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91584764"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:58 -0700
X-CSE-ConnectionGUID: 2ur6FEYBRiWBzqqvYWZ11w==
X-CSE-MsgGUID: UhabILBcS3+nYuiEyqbKgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="263836472"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:58 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:10 -0700
Subject: [PATCH iwl-net 05/12] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-5-9d0731eb4858@intel.com>
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
 Maciej Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=5eZvQaW2XLQ33MmDw+tyy8L38wPLaGjF22CO10SuBzQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl79yKrfP9TS7tZxlQ/0CLsPaOrfQ9ofy5w+1X2n5X
 rbc5FNSRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABPx2MrIsK9Kf863c2UlIiUC
 L9oPVkzw1/zgss3y0TrDstSOvzclPRkZJuokvf5TkNIf9HDn9lu7HjqktV645Pbk6Kuw6wfV6xz
 vMAIA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice_stop_phy_timer_eth56g() function is called by the driver for E825
devices to ensure that the PHY timer has been stopped. The equivalent
function for older E822 devices performed many steps. However, on E825 it
only clears the PHY_REG_TX_OFFSET_READY and PHY_REG_RX_OFFSET_READY bits to
indicate to HW that it should no longer treat the PHY offset as valid.

When PHY_REG_TX_OFFSET_READY is cleared, the hardware still captures Tx
timestamps, but it no longer sets the valid bit for these timestamps. This
sounds reasonable at first glance. However, this results in the internal
outstanding timestamp counter becoming out of sync.

When capturing a timestamp, hardware increments its internal counter and
sets the associated "ready" bit in the timestamp memory status. Then it
compares the timestamp count to the threshold to determine if it should
trigger an interrupt to the MAC.

Upon reading the timestamp hardware is supposed to decrement the counter,
clear the valid bit, and clear the associated bit from the memory status
register. However, it only performs these steps *if* the valid bit is set.

Since the valid bit is not set while PHY_REG_TX_OFFSET_READY is clear, the
timestamp counter is not decremented and the memory status is not cleared.
This leaves the counter out-of-sync until a PHY soft reset.

According to the hardware engineers, the PHY_REG_TX_OFFSET_READY bit has no
other effects. It only controls whether hardware captures timestamps with
the valid bit set or not. Since capturing timestamps with the valid bit
clear is problematic, they recommend simply not clearing
PHY_REG_TX_OFFSET_READY.

Note that the PHY_REG_RX_OFFSET_READY performs a similar task. However,
clearing it is fine as there is no associated timestamp counter on the Rx
side. Receive timestamps are simply inserted into the descriptor. Clearing
this register clears the valid bit for timestamps until we complete
calibration and re-enable the register.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Suggested-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751..d48eb3c61823 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2115,10 +2115,6 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
 {
 	int err;
 
-	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_OFFSET_READY, 0);
-	if (err)
-		return err;
-
 	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_RX_OFFSET_READY, 0);
 	if (err)
 		return err;

-- 
2.55.0.814.gc42f45431d0f

