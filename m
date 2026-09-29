Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC857F735
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721733; cv=none; b=pgDG1ms5zAPIu5Jq40W8Kpjqc+ZNNuH/jxlR1qd0ox1dxQdVJTev/T/3aRiHod69d4k8p9/4E3QEjSAmv48ZC8489MmxYRkNN+wa5d7BBlEYPkZ8MfxPgVgqhT93EL/x4ixFlSO0+5i0dcbmq3Rsaql5D2RF9cOM8ayu2r67QjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721733; c=relaxed/simple;
	bh=qhT0i5QXcTyWqSA3gGsb0I6gd555outee1Nrtom8R54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4OPM28HByrC6WdEEbnGRM7lc+6TtFCKZsOsJHftMG/pn3G+DSgbeeRD775vA18aDRNU/hZXCgnvAvcaJgvA5meo4DSaUojywBKX1wxeaODa5czqNWNIS347BOh/jbMgOBYqtvFbEW+UAsNG424Qefzm/VCNo72irLuzLGU3ljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJMvW6er; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJMvW6er"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721730; x=1822257730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qhT0i5QXcTyWqSA3gGsb0I6gd555outee1Nrtom8R54=;
  b=JJMvW6erER6l4bpU6E2N3qPYMY8jz6h7C0i40iWD9rUaahGQtJ/DtxKa
   ZSayotzAzgCj66pX+Py4HCOFPSbK4/7PCALuvvc8By90TXemgoF2+QTKb
   ZQHOwhiwbpjMVJMua4/TKbdHtm6eAJFNSAkCePcWjAPrnrovySl1GG0Jq
   M6I15dFDObikBOqb0AzbCi0lk07q/N2Bx0xCqXoroL4lZrUms6SV9jvQl
   yfzWjduf1cXiYZJVY0gnFffequ2q8i9eujDLTXAYqVeaIjprcYEJipd9o
   YxZVl9L/lnDWgowLRGpgiGzRZ+ZCBlSbjVHD3JRc1JMjwaqNfdotJfesQ
   Q==;
X-CSE-ConnectionGUID: JNnGnQrOTwinIRTk/MK/1Q==
X-CSE-MsgGUID: W5wQLwIVT9OB5f+a/Dygxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548907"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548907"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:02 -0700
X-CSE-ConnectionGUID: MVyiOLnFSxSFM8G6zi6avg==
X-CSE-MsgGUID: 1xu29XteT5KdBPB7UqbvDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452340"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	aleksandr.loktionov@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	xiongwm2026@163.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH net-next 09/10] ice: drop pf == NULL check in ice_pf_state_is_nominal()
Date: Tue, 29 Sep 2026 15:41:49 -0700
Message-ID: <20260929224153.1455466-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov <ynorov@nvidia.com>

The function has 3 callers, all except one explicitly require
pf != NULL. Add the corresponding check to the remaining caller,
and remove it from the ice_pf_state_is_nominal(). It makes the
fun function a one-liner.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 73996e3022ef..6d5b8acc4764 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
  */
 bool ice_pf_state_is_nominal(struct ice_pf *pf)
 {
-	if (!pf)
-		return false;
-
 	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 73f69d453542..454fba07d4ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5530,7 +5530,7 @@ static int ice_suspend(struct device *dev)
 
 	pf = pci_get_drvdata(pdev);
 
-	if (!ice_pf_state_is_nominal(pf)) {
+	if (!pf || !ice_pf_state_is_nominal(pf)) {
 		dev_err(dev, "Device is not ready, no need to suspend it\n");
 		return -EBUSY;
 	}
-- 
2.47.1

