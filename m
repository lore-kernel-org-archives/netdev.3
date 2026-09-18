Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EE4FDA59
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738402; cv=none; b=TQHHqNIkj4EEkKFcR+UwcUgEECQ9hGn6+0A5OGZ8D9C4pR9FSW34+8jvA5fhe9qn4TPSOwUMpGzgUJiYPJelcA+V/jp0hJ3PrChpmg4u4LGxCuK9We4GTEMZyJygLlNF4p0UOs6SCCUSJrcajLqVh86nE+LaYDYzekh+eWbGxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738402; c=relaxed/simple;
	bh=pMriqRWop9RRBaxFqNlEj6k2sISo5ki9t7sSSotR/PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=as3wPW9U7yNaSF7JSxReGNlr3HIk8PDUzRpJFQ9gqsmKtdLwS26vM1tAJH8UC9cAKzAz0vpdGX7UAbwr9BtlmFgO4ZFoQSiXdeomVRAhhnC7AvA9RqqLteyn69MS+jf9p8o2hNqaZQm0jgaaD9bjw9Cr4qBGGmcLoqllR/K0IqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMNrGRmT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMNrGRmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738400; x=1821274400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pMriqRWop9RRBaxFqNlEj6k2sISo5ki9t7sSSotR/PM=;
  b=MMNrGRmTUuNFgN960sLGTm78U0sX/tY4Swx0IKHCVLWZ1kgLfkUBJt2O
   BcmQHo1K+NOCTdMb/ZeHOYtICfehMBjxzN2mvzOn9TVd3ll06/TSN8RMD
   z+jpxSJ466yZGyeVsMCaxCufdnf+o5gRygYZh/F7rnWShlEgzo6m7wjA0
   cSVtxo/vgIg17OBrnHsH4cGxxJzJ3OfZKUzsONsO0pQs3Gz7sw/+0WvoR
   +8dDsUal5K1sMLJ58vnLRwx085kYxSn51qg4NOHaRSBEYinKJxqrok2Zv
   ujC3VZAQr7n2w9GHXOv9m2EHRCaCX0qBR2yaIJREAoQLseLPGbaGRMSrk
   A==;
X-CSE-ConnectionGUID: rZqjWbSPQ8+q6DDkrgCl8A==
X-CSE-MsgGUID: wEjZ8GeATkuTWIEjC/I2tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="101592497"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101592497"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:33:20 -0700
X-CSE-ConnectionGUID: UX2ng1vHSlGT0mhMPseRAQ==
X-CSE-MsgGUID: Fxz136FOTai9xYvPBAc6RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270717952"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:19 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 1/4] ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
Date: Fri, 18 Sep 2026 15:33:13 +0200
Message-ID: <20260918133317.4169815-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918133317.4169815-1-aleksandr.loktionov@intel.com>
References: <20260918133317.4169815-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexander.h.duyck@intel.com>

At the current maximum of 126 us the minimum bulk-mode interrupt rate
is ~7936 interrupts/s.  Under sustained full-line-rate bulk RX traffic
this is low enough that descriptor ring starvation can occur before the
next interrupt fires.

Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us.  This raises the
minimum rate to ~11905 interrupts/s (~12K ints/s), providing enough
headroom to drain the ring before it wraps.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 9b82175..1a7fd90 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -475,7 +475,7 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 
 #define IXGBE_ITR_ADAPTIVE_MIN_INC	2
 #define IXGBE_ITR_ADAPTIVE_MIN_USECS	10
-#define IXGBE_ITR_ADAPTIVE_MAX_USECS	126
+#define IXGBE_ITR_ADAPTIVE_MAX_USECS	84
 #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
 #define IXGBE_ITR_ADAPTIVE_BULK		0x00
 
-- 
2.52.0

