Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65294908DF
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698521; cv=none; b=rDVV8hU8z2TEwpI5gGCJOwJwuKLcsSWYWfv54Gny/Vbj43dMN6K5TSQ2b6rVcmaEI/srpNWIH2FCPwbfKkC359oPzXnbX+yM3wZ7XuQJlZf1l8JAbz7yCwslm1OByD4281xuTAVUO2y/GZh6xTA7XYA9HtRBKNCwEvp3zH8TuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698521; c=relaxed/simple;
	bh=RRgCM1Jt5ZKW3xOnkfDLQfBOMA02Aj+2gZ+Lbs4N+UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyRC9M93Kt2o/stl3HXV/7ZjD1QR81WnNFnLd2G4QU7Gb1T/xZ/p2lPJij8e22ifb41FPOvPG2HxsMmm1BBr0bxngSN1MKAEPlqLsPH5OSs66eKJDsQXEriHG9NGX7qLNdJjpl/II+Rhgq7pqAGRJ1d57+uIGRGf1AjsrhPjoh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWoLr6Id; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWoLr6Id"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698518; x=1819234518;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RRgCM1Jt5ZKW3xOnkfDLQfBOMA02Aj+2gZ+Lbs4N+UU=;
  b=BWoLr6IdhDJgppYf04ltA97+qHGQ4TLiSKibgjfHVPRQ7tRczVKj52bD
   fFA+zS+3dn1CiMHFUbvbUepc5wsp6Ruzl4Bk95KP6U4kh992+LARsCWY7
   4r8oygP0O6z0a2Y6u9e7x0WtugrvEwTXatNfaBxY3VJjfgJlT5VQL2odD
   5hdPP4LA9hEl18026eYGQeZppuJA+T+LstlGVetZMFdiKsHPkeCLM/xhl
   E4HD94Igi9Xvzs1facG7XwmWT0mNtZictuZkhfqPJ1zqw9v4MbVDHJ4Hl
   ipnbwVN3p/dX+Hsa0OeYT+97pS+O/u+NuXmFGMOreuwsTiZl+Fb/ClYwj
   w==;
X-CSE-ConnectionGUID: vb/vWIiXRLOoNsCrXQOqvg==
X-CSE-MsgGUID: yJqFy5zEQlGsCWSa6zuJLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120451"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120451"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:08 -0700
X-CSE-ConnectionGUID: qIV6klrbQoqQUSQ2WA8HJA==
X-CSE-MsgGUID: gxswPdFiQ7SawCZYXOkmoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789704"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:07 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:37 -0700
Subject: [PATCH iwl-net v2 13/14] ice: skip reading Tx ready bitmap on
 ports with no timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-13-8223f95d26e3@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=RRgCM1Jt5ZKW3xOnkfDLQfBOMA02Aj+2gZ+Lbs4N+UU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WbvyfEubqy9CUn1cs6/PFdHOecUktO9tv5O7k1RVo
 K3dprSOUhYGMS4GWTFFFgWHkJXXjSeEab1xloOZw8oEMoSBi1MAJuI+neGfqXFUqnViyZNeye2V
 zzoSy0L3rRayaJjAeuWnW4XEtGxdRoa7n/q7OVe+DNtb/0nszIFTr6b6i/t+fOPuJ2Up0C3j6MQ
 DAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

On E82x devices, the interrupt for Tx timestamps are handled by the clock
owner. When an interrupt with the Tx timestamp cause is fired, the clock
owner PF iterates the list of ports and checks for timestamps across all
ports.

The existing logic reads the PHY timestamp ready bitmap before iterating
the list of in-use timestamp indexes, even for ports which have no
timestamps waiting in the software timestamp tracker. This has a
significant and measurable latency impact on reporting Tx timestamps.

Check the bitmap and exit early in the event that there are no timestamps
waiting on a port. Observant reviewers may notice that the check is done
without acquiring the lock. This is fine, as the only thread that can clear
in_use bits is the miscellaneous interrupt handler. Whether the thread sees
or fails to see a new outstanding timestamp does not affect correctness,
only determining whether or not it should do extra work.

Using the ice Tx timestamp traces, with a simple ptp4l setup the average
latency appears to be around 175 to 200 microseconds with a few outliers
taking hundreds of microseconds to be reported. With the check to skip
empty bitmaps (and thus skip reading the ready bitmap for inactive ports),
the average latency drops ~50 microseconds.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 8500e9a5b047..96e96ba1731d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -573,7 +573,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */

-- 
2.55.0.814.gc42f45431d0f

