Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B94908D3
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698516; cv=none; b=F51+jltcs16ZilU4qiRR9tvBP4+HJYEzbNFkSILeYXFqZZ0Wtd2C18UXkw7b9c3HxCg0W/FS4t44qmecfpKuhLKO/KeYZ5FQq+HmGxrRt6eCmx/oYadu3qDS4GDYnNMstr/OP4I8EuTH4IFG4yvwvi7zVU6Vu9o3RRXHXXK22SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698516; c=relaxed/simple;
	bh=D2gba3kNzEbxSw1ulMCFjBqIc8abrLSzDW55DQ8ANvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZbCTT7LxEbuslNKG6VMvJv1N7zZNu9qlDFd8M5Z/obGwoKJFqSo2ucURjw62W/MHToPJl85NVv7SiPXlSuV1ROX4gIBlk4aCsRp/gn3B9X7OliemZEeFdRh5DGgfAIwrjGIBw1eNPU2cpTeH7Kf6xlc35CCmbBTpr/n6GwZM9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwshzIJl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwshzIJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698511; x=1819234511;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=D2gba3kNzEbxSw1ulMCFjBqIc8abrLSzDW55DQ8ANvU=;
  b=IwshzIJl633FDES2m6syY2xBFTyIRU+5h3JiFYzG2tu25JcjrywMGsZ+
   wlcP5XZoPW9jtlQNaGCWxbqnznY6a0dPDvZRIambWRsuohqhnCy0klhcx
   PZ1L+WwOIkaC6mpqFloKvzRVhLrunX3br8Ep2iWgSiSCkQFJ57MIO2OWP
   oD/QrrkEay7Wh1WY0CEEfVxb04ThfSOHq6VKe/FcDC6IrE0xmRrlCUX2R
   18LTXwccK0LqDRtMoAt0UAEehGfN8IsPPlBODkpw9TzuDkLrHMXRvVvvH
   Ptr/u1vZmV0dNP3JgAjIuygCF6OVM2JsMVsKaSOm1dbIfaAiAMpXVt4CD
   g==;
X-CSE-ConnectionGUID: 6RiNo9RLQTyFUtnlcfjg8Q==
X-CSE-MsgGUID: UAGcOyvsRp26c1X7D4XaOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120432"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120432"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:06 -0700
X-CSE-ConnectionGUID: Zy/Zr6QSR7O08KKvTQ0qWw==
X-CSE-MsgGUID: B34U7YquSBiESqbjEP+6VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789680"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:31 -0700
Subject: [PATCH iwl-net v2 07/14] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-7-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2950;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=D2gba3kNzEbxSw1ulMCFjBqIc8abrLSzDW55DQ8ANvU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WZtoT13dhuopzTIx1xIWb7sxY9njw0Ft6j5RbSs27
 l5lvLO9o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgInoqjIytHB8PddqU5TzLIvr
 +vITRhzHLBKvxh+K0Ph/rSOgXO5VJsP/sH0fLm4XuG3MUv7Xg2WaaGtJxtew7SsOWDcseZ+mbFL
 GBAA=
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
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
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

