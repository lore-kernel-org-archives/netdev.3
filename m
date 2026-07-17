Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053239FCAE
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314433; cv=none; b=OCNIv+Hrn7OtsSQk0M5dyAP5IZD9qjmouYjwvXcdcp/P1F2Guj3IZpRiH6+b42s7q8ywUDnubV4TLdff+ojNfppZcpCS0eTtcMhXazzyB8cLtBYcY+Cxi/i7YHTlckSJTtz/cesvRLXSFSTpdB69Ffy0oL/2Qu72WDJacMPUdAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314433; c=relaxed/simple;
	bh=Nas1ipnQuKPprZACURq/t6XA3zKZwlfryP9WpVD+sgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRIeXuRAla1T+hvhGgmbB/UO00fea6SmO8wQsEtf2zu5Azfabz5KgabwdGGBW00qGSZK9+QcXBDnlsVpQGfUYa5I5Ihl+q9uF6nImMiQIH+lA/9YbMoRbbCUf6NZ8IMcbv0z6vP9PKpgslY501r1H/Lg8tm/1OQrZK7kUqJdRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkZ8WkK8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkZ8WkK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314432; x=1815850432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nas1ipnQuKPprZACURq/t6XA3zKZwlfryP9WpVD+sgs=;
  b=PkZ8WkK8lx4gEGQulIn1FYNnCWCC8BkRKAJ4gScq85NFX+kPBPZzAAmG
   fa9GyjmVhI7KnWsJSDmqstaWapcWTl5H97iTWbA0/CLxqjQzf35sGvO7O
   tpiw7wIEnlzx7x5Lc/NPTC9gMafmUQsH1x9dbKs8iMDuOs0TgCA+fF0y8
   ObjQ79P8WnUop+5V6z1GEt/DaRjiotwNnS1aqOsfLD/iPagCa4MKhBWsE
   7izV2RcP+lroaCHhOBfbHsxyoOK9W+17fspdEZJ5QRdUf46lEtjhAf+a5
   dGnhgSXuYRiKIVEYvqyM05lo9un+u0HhBLX17wnBKN0tRV9P8+K80WRlF
   Q==;
X-CSE-ConnectionGUID: fpPIuydjRfaMpkxfa8t88A==
X-CSE-MsgGUID: EZrFVH6eSy2ezvY8sB4DGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347646"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347646"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:49 -0700
X-CSE-ConnectionGUID: IA5jQNSiTFSU+GhwQCpv5A==
X-CSE-MsgGUID: pyIXVLOBTMio5NlWJi3+xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827256"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 10/13] ice: prevent tstamp ring allocation for non-PF VSI types
Date: Fri, 17 Jul 2026 11:53:32 -0700
Message-ID: <20260717185340.3595286-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

The pf->txtime_txqs bitmap tracks which Tx queues have ETF (Earliest
TxTime First) offload enabled. This bitmap is indexed by queue number
and is set by ice_offload_txtime(), which only operates on PF VSI
queues.

However, ice_is_txtime_ena() does not check the VSI type before
consulting the bitmap. When ETF offload is enabled on PF Tx queue 0,
bit 0 is set in pf->txtime_txqs. During a subsequent PCI reset
rebuild, the CTRL VSI's Tx queue 0 is reconfigured and
ice_is_txtime_ena() is called for that ring. Since it only checks
pf->txtime_txqs by queue index without distinguishing VSI type, it
finds bit 0 set and returns true, matching the PF VSI's ETF queue,
not the CTRL VSI's. This causes ice_vsi_cfg_txq() to spuriously
allocate a tstamp_ring for the CTRL VSI ring.

Since CTRL VSI rings have no associated netdev, ice_clean_tx_ring()
takes an early return at the !netdev check before reaching
ice_free_tx_tstamp_ring(), leaking the allocation. Each PCI reset
leaks one 64-byte tstamp_ring.

Fix this by restricting ice_is_txtime_ena() to return true only for
PF VSI rings, since txtime_txqs is only meaningful for PF VSI queues.

Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index f72bb1aa4067..fc91b6665f90 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -767,6 +767,9 @@ static inline bool ice_is_txtime_ena(const struct ice_tx_ring *ring)
 	struct ice_vsi *vsi = ring->vsi;
 	struct ice_pf *pf = vsi->back;
 
+	if (vsi->type != ICE_VSI_PF)
+		return false;
+
 	return test_bit(ring->q_index,  pf->txtime_txqs);
 }
 
-- 
2.47.1

