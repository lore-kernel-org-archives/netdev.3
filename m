Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E477403B15
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040972; cv=none; b=pRU5xdi85vcOu2BYY4HMJaPZqwpD5Bw6JybVRYDpcNSQ7eCN+xGfJA/uOkyTwAmJGyLBfHV5JJb4b0qpjdJ8MaUCoRJw1MOpNyyc+fbTb72vwk4OZyNJdQqA+WmFfW5ZU1FK4EBwe5QVP7bA6/VtQQrS6M/skPKaWlxFvThOT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040972; c=relaxed/simple;
	bh=mVXXhGscleP94SeAnVaZApnK0NKaPJVgrTB1Hj344LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRx16DRxJfAW+BTryGRZNStnQpAgyYpVsC9PZ8SAjK5uIaahU8BRdvp8gvkg+OII3QD2E+T+5qI+wjNuXpDpJswHRKUdoQVpMpbDT+dRPlOuOedenZ6PnRrAtmC4cHNCU9Pd+HDhaqdUI5VnIVSiwoJZhRRkyDMymiWLwqvnze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKPThtNC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKPThtNC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040971; x=1812576971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mVXXhGscleP94SeAnVaZApnK0NKaPJVgrTB1Hj344LI=;
  b=SKPThtNCIi4AhWJnGwNq7o3ZITwQev4k2J//PEcV0QfGLXR++I71WMgD
   s5OIcLTP+YmArLLGJtqaOTlOWr7+mGRoaI+NU9VbS0lDlNjjK/gds/LoR
   4nc5f1v3RHGItSmKgWk2OX2PxdVWrqlgGREvzacx820vBA99znHy04gsf
   OAs1IieRFTwOLBHL/MV3SQG4ypLVjMTmcWy/ns/8yBQcwzZzhKtV6LC3c
   FMn1UHZcYdSmEWgKZNwhzi+b9D4O/B1K6cOGyXGtVtlwKBDtRw4eaTauR
   2F5GIb8yJKmAwPDyiRtmzkq8Vr+8SVAF1OYPvd/u/vNdFM5FcjH1wqARS
   Q==;
X-CSE-ConnectionGUID: N15svWroTGaTUzbNd/cCbQ==
X-CSE-MsgGUID: /zzcAGIYQGeCcpBcX49yXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568522"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568522"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:08 -0700
X-CSE-ConnectionGUID: LP6XrXHeQtOhbJ4p3vN3wg==
X-CSE-MsgGUID: zKHho4d9TiagUGAxG+UP4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838571"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Natalia Wochtman <anthony.l.nguyen@intel.com>,
	richardcochran@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 02/15] ice: remove redundant checks from PTP init
Date: Tue,  9 Jun 2026 14:35:43 -0700
Message-ID: <20260609213559.178657-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Natalia Wochtman <natalia.wochtman@intel.com>

Remove unnecessary condition checks in ice_ptp_setup_adapter() and
ice_ptp_init(). They are duplicated in ice_pf_src_tmr_owned().

Change ice_ptp_setup_adapter() to return void.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Natalia Wochtman <natalia.wochtman@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 36df742c326c..cca004265662 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3059,14 +3059,9 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
 }
 
-static int ice_ptp_setup_adapter(struct ice_pf *pf)
+static void ice_ptp_setup_adapter(struct ice_pf *pf)
 {
-	if (!ice_pf_src_tmr_owned(pf) || !ice_is_primary(&pf->hw))
-		return -EPERM;
-
 	pf->adapter->ctrl_pf = pf;
-
-	return 0;
 }
 
 static int ice_ptp_setup_pf(struct ice_pf *pf)
@@ -3309,10 +3304,9 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* If this function owns the clock hardware, it must allocate and
 	 * configure the PTP clock device to represent it.
 	 */
-	if (ice_pf_src_tmr_owned(pf) && ice_is_primary(hw)) {
-		err = ice_ptp_setup_adapter(pf);
-		if (err)
-			goto err_exit;
+	if (ice_pf_src_tmr_owned(pf)) {
+		ice_ptp_setup_adapter(pf);
+
 		err = ice_ptp_init_owner(pf);
 		if (err)
 			goto err_exit;
-- 
2.47.1

