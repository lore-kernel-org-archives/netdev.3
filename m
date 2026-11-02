Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616397;
	b=Ti2y2IuEM8ahB5zRt/e4YuqKOn/oIdbh3myfHFllnoVUiLA46KY4Js8j41OGYIwJ2KYN
	 14EMl/RybIz+11I5Tk/zXk93utp5RpAnR/w/TIzsTn/CRt+ZQhWe3fgh2yKLTJJTcCO/j
	 Dqd6oyWR0kJzwM4r7Gs1r65/Xt2bF3hK75lvwVrLFDtE/lFrAATpqHwu1tGRGUOxqXcXO
	 whMyGdprXL8LXByqrr3Jdqle57Ka9+7uMdxe3uQzlOQKULCu7RYMK80ExtSF63YP8zWO7
	 /4cC1IdQ2jHM7+JEJWS/xUBbLHiO35fvxWYMxk2hgHpPaaMNRaRJsLPCvMJCn63etXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616397;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0de0W6jxw8KtscxBWkG1yp2WbDEIeVe8u254gNP5E2o=;
	b=ck4y2nTTnHctb+Vec/T/JujeaP4bcTwXCoxz78tihH/7FOgW3t53WnbVS975ASBGpnqG
	 PoXFBF+ikmhqNpEXWDvyEg7zn+dZCUbGG9IZqAzb4Jluojts6jjSJvKx5l9mHXxGVMqyF
	 8NLnOSwQOzN8FADxrdTwprbTWXhHf/AlnA14PXWm3IDoNZW8T19EH4BCMFdAgbelpfZVZ
	 p5gOVU9EUSKA7W57OT2r9r4AXRch6O+zSHflhBBQfyrzWzAUXjYedMSQ+TUdLJovd5knu
	 yVjvUwimUorjL1WlIO3DduNHCEo7m2pgvuX9bxQZ9ZNfxC7+oPgzS65cRWrnNBd4+Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cgxm+ilw;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05977606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05977606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cgxm+ilw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616396; x=1825152396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cW+Movk1Z1ls6/YMIHhoUPIB2qHu/pPsMjpsRhMTgpk=;
  b=cgxm+ilwBapPV7UtlOwiC7DIZRefd4t34yF0v4Mw3gdPNwGsrEnaxa+q
   p3Rf8l7QH4mNUhJY0TVuvr8vRWXqZpXlxE/RaMjrr2iXO0uJrDoqZfUuA
   yPgDbL4TSsuU0nfVYxWqHuIOURDCRWmXTFXvk3re1B3N7nht+/xnL9+Yu
   yKUhPY31Q/HylD7XQuwGw7MzvGv0utihIQ/N8y6OCZa7/oC/Ghoul81dt
   5VKebGyTRNSCGz7PqIPv5YUrCNfeKY0laiRb9IlBcZSIagjJUXJfuqFCD
   uPaBifwhw+AjEWtSKPwwrPSTsAwuKCsW36gKgWvnrOarcZ8bYmA6orxvs
   A==;
X-CSE-ConnectionGUID: tzjHPn7qQr2XAbyw7sNnIw==
X-CSE-MsgGUID: S0VkugOwQ3aRTdoiIwXgZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305019"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305019"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:46:31 -0800
X-CSE-ConnectionGUID: E20Jtrf3Tz2N8/ujoxdMtQ==
X-CSE-MsgGUID: XGQpi2oeSFywndy8YLvBoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012003"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:30 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com [10.217.184.18])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 64FB92876A;
	Mon,  2 Nov 2026 10:46:28 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 1/6] ice: don't wait out a reset in ice_dcbnl_devreset()
Date: Mon,  2 Nov 2026 11:50:16 +0100
Message-ID: <20261102105346.30739-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_dcbnl_devreset() spins on ice_is_reset_in_progress() while holding RTNL,
taken by dcb_doit(), and pf->tc_mutex, taken by its dcbnl caller. The reset
rebuild needs RTNL in ice_ena_vsi() and pf->tc_mutex in ice_dcb_rebuild(),
both called from ice_rebuild(). So the waiter keeps the reset from ever
finishing, and thus keeps waiting.

Nothing is gained by the wait anyway: a reset in flight normally rebuilds
the DCB config and reopens the netdev on its own, which is all the
ifdown/ifup here is for. Bail out instead.

The reset bits are cleared only after ice_rebuild() returns, so a call can
still see them set after the rebuild has finished, and skip the ifdown/ifup.
That is harmless: ice_pf_dcb_cfg() has already reconfigured the VSIs, only
the stack-level notifications of the bounce are lost.

Fixes: b94b013eb626 ("ice: Implement DCBNL support")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index bb5cc0a2ba69..9cdb9581fdc3 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -15,8 +15,9 @@ static void ice_dcbnl_devreset(struct net_device *netdev)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
-	while (ice_is_reset_in_progress(pf->state))
-		usleep_range(1000, 2000);
+	/* waiting for a reset in flight would block it on the locks we hold */
+	if (ice_is_reset_in_progress(pf->state))
+		return;
 
 	dev_close(netdev);
 	netdev_state_change(netdev);
-- 
2.54.0

