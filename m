Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CDF1E51E0
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857054; cv=none; b=mpu5Dp81hm4+M1UimRTy6ASPyeSTji8VmGj5Oidjsy/UnuOuyeF+KOW4vKW3bqghFbfrPWvcOsDBcPFLLkwVS61WXMGEXSh+oxNvqvt8ee8cQ9r3pgnp4ym4/pH+YqKcHENIOboAj4w8xlcN2ZP6N6Xnq2EY/QvWvTkgpxMLk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857054; c=relaxed/simple;
	bh=OJi9lpGzM89oH9Z8nNCPiZuO5Ihla7QNdmtPLvDfI14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JyKgoWJBOtsddFIP8b136IDBKAKdJv8u4Ju1bGwhc1ga9UvQzyjAd+Tp1+fzTA6tjA/sZ6Wsppqo9wgllDP6d+2klif8Dbk09gu3O/fipIpWHOd0OTfSMWrjyjrlPafTqXlsYkMPT9s4ye4oxJDwD8n+zNIQe3HyKqFXcCBwoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjeAF3L3; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjeAF3L3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771857053; x=1803393053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OJi9lpGzM89oH9Z8nNCPiZuO5Ihla7QNdmtPLvDfI14=;
  b=LjeAF3L3tamTIqmoZ1yBhexEQp/t6OcU7WCtuhFxR4CfdAw2hq7sBsoc
   +6pMAbCiaAxIdZKMQe8lWTbxr5zkG2KXMug1tKt8Ldxnv9/NHjahlB2lA
   MHQepLcAkHeB7a7uPuucs0UGYl3QBIiotqdsvCX0wS6mPaON3coVC8f3q
   jGUHB8GodxBS4+NBJ6bhKwSXaYelxhm11v/M1EMx4CkopJID9rP/qaah5
   TcTPZhciCFWfaVXmkPJa7v0UjrHUImcMWNnAUYkh1NPCgXWYxB8qEAgv1
   ILfy18Yy9smqxgQFeGxpxqSVI2uUXtXZA5uxpPzG841mPUKXVbIBzJrXw
   g==;
X-CSE-ConnectionGUID: w2SGjv+eTwG1Y2dfFnguLg==
X-CSE-MsgGUID: TBkguPj3QNuYqnff9uSrEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72061138"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72061138"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:30:52 -0800
X-CSE-ConnectionGUID: 5L0wxdfrRy+XNyQYOtxE8g==
X-CSE-MsgGUID: vvogyipbQ1S3Nu6ppaGaRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="220574764"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by orviesa005.jf.intel.com with ESMTP; 23 Feb 2026 06:30:50 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net v2] ice: dpll: Fix compilation warning
Date: Mon, 23 Feb 2026 15:31:55 +0100
Message-ID: <20260223143214.241797-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ice_dpll.c: In function ‘ice_dpll_init’:
ice_dpll.c:3588:59: error: ‘%u’ directive output may be truncated
writing between 1 and 10 bytes into a region of size 4
[-Werror=format-truncation=] snprintf(pin_name, sizeof(pin_name),
"rclk%u", i);

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 73a4e28ed75f..f101fdb3e9cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3532,7 +3532,7 @@ static int
 ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 			  int start_idx)
 {
-	char pin_name[8];
+	char pin_name[16];
 	int i, ret;
 
 	pf->dplls.wq = create_singlethread_workqueue("ice_dpll_wq");

base-commit: af960c69349a922fac3b4fbdb42e118a35c8700f
-- 
2.43.0

