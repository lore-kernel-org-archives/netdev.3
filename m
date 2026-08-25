Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E52477E4D
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698510; cv=none; b=OmUwfK7ZGhR1t3PNCZa81iLEcCIQgW4RLieoWS58fueVJR+uJ97EDol3NxVwnRQLmnR9nCIOgbIZd7nhVR3Ok7BuKkyiIpnusV+jxSgQt80blpJuHDMzLbFDAu/wqAsZwl7hB0QQ/wPh/l7C7BLlic5ZWE97DRtIjyHVkD+8GBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698510; c=relaxed/simple;
	bh=Sjg0PSFVQgrhpJweLV0+MIJmWnIEe9kamjhvO9C0ZoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjlbPkVy6MrBuF27NVbLkK0OE3RWY/cl5CeTw6e8Ybn9s9syTMSGsZ2Fwr0oO0+ouNyWLhSVl5GdM5vdXSjemttjXYKBfbmEovaTPP1iOGwVaYl+9TtOrBuPqcH+2egOQLuf82KVyTdmzyNf6wWbkWpv1sXNMNtxK837YYH35+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPfSAasy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPfSAasy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698508; x=1819234508;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Sjg0PSFVQgrhpJweLV0+MIJmWnIEe9kamjhvO9C0ZoM=;
  b=FPfSAasy0BnqtJRRG8dYcHnLsP0QJTwv0dD8eAz5+pLEOi1yP6JPNEzL
   THWz88rdYseLawsf5iHmrjX5LLsocDuJHrmd3Bxvwc1u3OtkoBJoWuFJ0
   dnCvITIAt0nYJLV+5tIG0e6k4+sCMuQKfR2b9dSNzVtNhZdhgtM6s+47H
   dFnYHqN9bhGClMwIGbzxQZGeGSIMqrNU6Ct8MZhIG75lva10eKhm8GELe
   n3qRFEjyNPph4QKGiN39MGbDBKy3UAYHGN9IwViKH3k7MmsypDNuGf08m
   tADb9hpxuziPRLiRFAM9pF/1HWyLNcubC7ipxuoXj2y0kmliu5E7c+kYJ
   Q==;
X-CSE-ConnectionGUID: Puv8zK3qSEOBmvpNhK66yw==
X-CSE-MsgGUID: D4BFLpj6R6+2mw5Fo8NvNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120416"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:05 -0700
X-CSE-ConnectionGUID: 1lZCFVuiTY2uzgT6BDM2jQ==
X-CSE-MsgGUID: wsjPO74jQVi1prKCAk8FBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789664"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:26 -0700
Subject: [PATCH iwl-net v2 02/14] ice: fix removal of PTP timestamp tracker
 during reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-2-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1996;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Sjg0PSFVQgrhpJweLV0+MIJmWnIEe9kamjhvO9C0ZoM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+Wev4y33bzzpsMPuTv84+cZ1LtfX8lop1B1dqRwY8X
 Kosu3VWRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNxWsTwz+B7trP8hfK8uS8U
 Odf8z9HY5ybIyGpy0TRW/Os75yBfQ0aGL99ND80vO8AhOfnszuMXjZmiG/hei15eVv6fo09GZXc
 VJwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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
2.55.0.814.gc42f45431d0f

