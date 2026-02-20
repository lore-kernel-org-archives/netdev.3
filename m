Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9612DA768
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771572631; cv=none; b=n9NFNj37gLVHqSfKRQuOKu2HVAjwW/cCHCcNo1w7XD6z2ireVGLDjr3yCP8NFOyoUjfSNZwt9xAbYc6UVauf8RJkoeZiTqL/OEHrXSj/Pb8JjA1izv8WLR88x3aQNNsWH+fpjTdVBQrm9zGBwjyBVzuXcK5rAmBcELWk0iLIC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771572631; c=relaxed/simple;
	bh=t0chq214HkHrpgpq/8q/aGOsHgiMN8Wk/jEfJVeixCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5AI8h7ySSnhH7TUpLj0IFehw5blNoKfxKgeZvooDUroQpmGhxCVvWmgpdATreXzXCpPCeGyjHHeFIZQ3H/R5D11bMNgD0i1mTh1t/xHXHhUDHp0EYWi6/pJcQHIC/SfzXxk/it3xBPljDnPAez3UCEwPvXJY+ezJbls75ttiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVaD2V9Q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVaD2V9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771572630; x=1803108630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0chq214HkHrpgpq/8q/aGOsHgiMN8Wk/jEfJVeixCU=;
  b=aVaD2V9Q7xDzVPymJhzcK8Ixk2B4weY88Rw97qs/pTWIU0u725WFJyU/
   zk0Kc8oiTk3AmUx8pa/10zaSgP++/LaMrn/244LKgZ4j6xiV/ZfgFmuFC
   Vzp0lPpTZ/Qtlk8P1Ex3/fsIAYddNGEkmrQ5g7jFwalZJewqX1hmI6D6/
   AYpjO4+TnicCqCdGlRfUPUSKAjh6WgzDw6kDSNLAYtxHoEpGAfoVmPfhu
   8MEG9Xxs/RsWv3QEetWxJPrJIFKJlDRZQYb/UHYCHnlemJbXnwPtrtIb2
   zCJEU1BIXGbK1/haY7IQcFoRPsIAwb9hVhb1P8aC4P8xgieQj3rJEhiAz
   w==;
X-CSE-ConnectionGUID: cnFzfEgrRXaBXpe4iTQ1AQ==
X-CSE-MsgGUID: 11kMCAQBQcuaZQHV5SvllA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="95286634"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="95286634"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:30:30 -0800
X-CSE-ConnectionGUID: WSwxpYZlRgm87c0AWpJaXw==
X-CSE-MsgGUID: sKGreoBqSgC8y2H7JQDauA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="219289839"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 19 Feb 2026 23:30:28 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	marcin.szycik@linux.intel.com
Subject: [PATCH iwl-next v3 1/2] ethtool: treat RXH_GTP_TEID as intrinsically symmetric
Date: Fri, 20 Feb 2026 08:30:24 +0100
Message-ID: <20260220073025.654391-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220073025.654391-1-aleksandr.loktionov@intel.com>
References: <20260220073025.654391-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A GTP tunnel uses the same TEID value in both directions of a flow;
including TEID in the hash input does not break src/dst symmetry.

ethtool_rxfh_config_is_sym() currently rejects any hash field bitmap
that contains bits outside the four paired L3/L4 fields.  This causes
drivers that hash GTP flows on TEID to fail the kernel's preflight
validation in ethtool_check_flow_types(), making it impossible for
those drivers to support symmetric-xor transforms at all.

Strip RXH_GTP_TEID from the bitmap before the paired-field check so
that drivers may honestly report TEID hashing without blocking the
configuration of symmetric transforms.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 net/ethtool/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5fae329..9a3fd76 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -911,6 +911,9 @@ int ethtool_rxfh_config_is_sym(u64 rxfh)
 {
 	bool sym;
 
+	/* Strip TEID before checking - it carries no src/dst asymmetry */
+	rxfh &= ~(u64)RXH_GTP_TEID;
+
 	sym = rxfh == (rxfh & (RXH_IP_SRC | RXH_IP_DST |
 			       RXH_L4_B_0_1 | RXH_L4_B_2_3));
 	sym &= !!(rxfh & RXH_IP_SRC)   == !!(rxfh & RXH_IP_DST);
-- 
2.52.0

