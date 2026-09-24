Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69247FB19
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254775; cv=none; b=MolMBGzcZucQA0RGNZkRLfV6oFlOWT1JUFO22VzVQFxGX5Mby67ZhhnJJhkghCCXsOwSLM0My++vhYlSiw3CEw09/FYyie8o0mrPMxlrwmFxhfG8261FDAuU3D6CfkRzbwXIScNsw2jM5pDtymWNFXuWNF7aM8uss5BEMBi/FKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254775; c=relaxed/simple;
	bh=0b3wewW4J9me+EBD22mhqtMxIvwOlQSGeFmNhvtYCyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5a7X78UTM1c0NAuILswcL0ASmLDNJO8rbEpz+u8ZMX4rHRVSxfEfF1wIpHPMYkdl3RSAOQUPxi7Df2uzWDC+tOKJLxmQ2Bp8ddqQzmCInSU1zui6N/br3Lq7ycrtgKzIsfTDcBsU1IrU8yRaM1cddKJyogJMnb82CIE9s6dL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUGwxotn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUGwxotn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254774; x=1821790774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0b3wewW4J9me+EBD22mhqtMxIvwOlQSGeFmNhvtYCyc=;
  b=RUGwxotnDkMW2AL8Uyfeyb+hUrxeXoNJHBK51LffMyWDmHGSdbKD5gdC
   XCbLR8IAAlFW9v6aQ69h6RNTt91ebkN+sVMhWcyU/EJBaFSDIsa2DzpkA
   fbSWQmIzGqx+V13PSKMXLmI4N1sTM9yFUh/Z/ouJxG+gbkMiPBbV5U+EY
   ljowooxEOUJkyKMNrxl+v02ZCQceJ5w64u9p6fzsOZMv+jMnbP3ha+/48
   xmiDrQeuJTYjg/yip6rpWOPjT6mfzr3pZ/izXs7BsJC677dyekLcwZzU4
   0M4xyA8FMn7mWlyEfz9itZWQA8emGEIDA6CTPqqAq9yeDVDnQf8o4EOgl
   w==;
X-CSE-ConnectionGUID: 4HoGPvrsS7Suv/pVKHwTIA==
X-CSE-MsgGUID: 272whTbsSMKw2UKJIY3FtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249241"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90249241"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:24 -0700
X-CSE-ConnectionGUID: gXqXcLCPTLKAoOkqsR84Aw==
X-CSE-MsgGUID: AxK0IT0xRgOeOsUpOT+SRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311934430"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:24 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 6/8] ice: Document control PF lock ordering
Date: Thu, 24 Sep 2026 12:59:14 +0000
Message-ID: <20260924125916.2796499-7-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document adapter->ctrl_pf_lock as the outer lifetime lock for TX clock
state and PTP hardware semaphore operations. This makes the existing
ordering constraints visible to future callers and helps avoid nesting
the rwsem below a DPLL lock.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index f7e6680d124c..67f2fc6e79e4 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -156,10 +156,21 @@ struct ice_dpll {
  * Locking:
  *   Acquisition order (top to bottom):
  *
- *     txclk_notify_rwsem (read)
- *       -> pf->dplls.lock
- *         -> ctrl_pf->dplls.lock
+ *     adapter->ctrl_pf_lock (read)
+ *       -> txclk_notify_rwsem (read)
+ *         -> pf->dplls.lock
+ *           -> ctrl_pf->dplls.lock
  *
+ *   PTP hardware semaphore path:
+ *
+ *     ptp_port->ps_lock
+ *       -> adapter->ctrl_pf_lock (read)
+ *         -> PFTSYN_SEM
+ *
+ *   - ice_ptp_port_phy_restart() takes @ps_lock before reaching
+ *     ice_ptp_lock() via ice_start_phy_timer_eth56g() or
+ *     ice_start_phy_timer_e82x(), so ctrl_pf_lock is not the outermost
+ *     lock on that path. Never take @ps_lock with ctrl_pf_lock held.
  *   - @lock serializes all DPLL state mutations on this PF. When the
  *     controlling PF's lock must also be taken (e.g. updating the shared
  *     tx_refclks usage map), acquire pf->dplls.lock first, then
-- 
2.53.0

