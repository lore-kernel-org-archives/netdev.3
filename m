Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37EE47ECC1
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476937; cv=none; b=SIhXihKK8AmELAzgs0vyNZ9Pq4QqY19HUR0o+s0vpdzCRkLPUW5fMBGbwVrLCLtMuoRBv+U2tUFRyrAEBuqIazGEL2P5iYblIa+XTQAUDgztZTyCOGsvKS+dl9JfzmzCi4/8LpnZYEvD8zzS9yAgDKMYn4YohFqG43CAevMPh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476937; c=relaxed/simple;
	bh=wkYdKCahcYvuXtF/djytxmBw0lj6xW76BgT0HfFKymA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXPf6AKj2MRorPJYmsvE2fqeGRl6PR9bLJWOMe84rklsfVFElLn/JpauiiaRNNKaFRbEVfgsDXwmSWCL7TXZw1mvYRezSlCjPoWMNv8iISs8uStgrtuLEe2Unr3ptoi7WT1Ii9i0WEYxR87wcrwUfU+vyCdwEDMmU+ItPH9wswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEiiNUc8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEiiNUc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476936; x=1821012936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wkYdKCahcYvuXtF/djytxmBw0lj6xW76BgT0HfFKymA=;
  b=cEiiNUc8QdyQ/lokJUs7fdwDHn12W/Qje+tjht3yk+KldofQpo+aahdi
   NsLXSz2EwgB3NoecS5Q2Ezy3F0+QHvQvpol5VGF0EMg2Id6kwkjkLsdhq
   ZwUigTebybxNv4pEnSjaDn1kKh3mY0WUjIFNGG4DJX125rDd1GEU0RxTY
   GruJChNGwI8jc0eEUbRfYoPZRpmwKZMRONxcnULCMOQ6znqa5wHdHrkto
   XQmMrHGJQHB1stZq/KW76KoMTxkznOO8WUjvAG6CVwatwl+/ivH3G/adN
   oPGCrDGMas3wn8/kyT1zp8DhXdWV+TWcL7ljagskaCvzm8E+bbu0PQ2Lr
   g==;
X-CSE-ConnectionGUID: QcdZr16dQyqajThdmxstlA==
X-CSE-MsgGUID: I0lOleVrToGHtDwDuccsJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853106"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89853106"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:36 -0700
X-CSE-ConnectionGUID: hfI6/nsQQNGXgmlMFhPb4w==
X-CSE-MsgGUID: brN35pjzTPS5gphhgPG8qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225189"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:35 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: [PATCH iwl-net v2 3/3] ice: support RDMA on 4+-port E830 devices
Date: Tue, 15 Sep 2026 14:55:29 +0200
Message-ID: <20260915125529.3975723-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

E810 and E82X devices do not support RDMA on configurations with more
than 4 ports. This limitation does not apply to E830 devices, which
have a different hardware design and support RDMA regardless of the
port count.

Narrow the RDMA capability disable condition to skip E830 devices.

Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ef1ce10..d53307b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2507,7 +2507,7 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
 		caps->maxtc = 4;
 		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
 			  caps->maxtc);
-		if (caps->rdma) {
+		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
 			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
 			caps->rdma = 0;
 		}
-- 
2.52.0

