Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97C490BF5
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698515; cv=none; b=pJpRE2BoiuxvBE9KJ2Q8kzfeikA+YON0sxbaVnuiujMj1VvFTPk5H6Hh8tFN99C/6yWD7sHDYvWTateYNFmooFCqPMhD+BwbIDgIxkz8aWwPbjB/UkwLRcIgOfEdWUfKywEIfrJA45NSFhhUApCgMy/ovoN4Oxa2UQa7rmYAlXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698515; c=relaxed/simple;
	bh=qWHh36Du9B7DNvrjcUINH5z+vifLevrg3n3fwwfTHgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YHtYvBLToyZjzYJ6n4IO6+IsDboLpaaq6DqOjUBCAFHLCQ9HKbYQYwiJS/lJL2SRln8ZA7anTaJ6TbU5GRJoY1vhvG6IVtbZhOpBFTNWfZ8LsJlAE5GpCHmKMQQkotLc02F47p3pLcV7HZy93hjrh/9q8rRgbuqp5mI4PAZPXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/Sptp98; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/Sptp98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698512; x=1819234512;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qWHh36Du9B7DNvrjcUINH5z+vifLevrg3n3fwwfTHgc=;
  b=H/Sptp985I6PMzYMKXxyZxkG6HEqq6uCYWGB1+Mgcr5DvcIJ4kKNY9bS
   9Ujo8iMAIl6K2Juz9GC0a7naYLyl7X58zJVzMhEPV8Z0OQ5HvwfCaiCmb
   AngCekPNwysY6i6iuRlCwlcu/j45kIy+az4J/wtpJvbYmqeCgXbKcZy9K
   FMPHDTsv1N7jCSoTTFu61Ez8pPaOCJPsEOyol75mXeqWcGveCfte0wjLH
   zxKUiWRBBuGkyrXtG5ZNjmzIMB60E72bvuqgt0PmmMoM/jONBBjlFNnrb
   0exxbojaG5ai9MpY1BDK0xNVjHvcaY6hK8pP8Z0PpdR82mtE3AvmI7FYZ
   Q==;
X-CSE-ConnectionGUID: MqG1/y1pSNGXbHGVSx31jw==
X-CSE-MsgGUID: MbQDq3uGQSOK81CO/s4Spw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120439"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120439"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:07 -0700
X-CSE-ConnectionGUID: QKIxEL3IRJqrh6pIHYstoA==
X-CSE-MsgGUID: A4w0nnH2RUqnfsfWamcQww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789689"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:33 -0700
Subject: [PATCH iwl-net v2 09/14] ice: E825: perform a soft reset when
 starting the PHY timer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-9-8223f95d26e3@intel.com>
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
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=qWHh36Du9B7DNvrjcUINH5z+vifLevrg3n3fwwfTHgc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WVt2+xm8rtoP0wRTfddYCX8x/vlrE4d61FT9OtfXo
 fI2brs6SlkYxLgYZMUUWRQcQlZeN54QpvXGWQ5mDisTyBAGLk4BmIjUdkaGa+oOXi80X6yoFN8w
 59Xxx1dWnZp4Sy/VeM7HH/d0xcX3fmBkOFD6UywhsT2pYpltzwQLF79LF747GWV4f3K+cHiVUvo
 UXgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
soft reset prior to programming the PHY. This ensures that we clear any
outstanding Tx timestamp memory, and ensures that the PHY internal state
has been completely reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a3a9f7ce04d2..64e18fe1176b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2120,9 +2120,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
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
@@ -2138,6 +2140,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
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

