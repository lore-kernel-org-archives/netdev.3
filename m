Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38793BB13F
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476943; cv=none; b=OqMOkDNX1jIboltdm5vTTAuQfNe55Y30N0jAifp509I6Clxkl6MyA5Wpc9SQVxKGq/vwuEpadmKA82gOklRxqxtRXouTg8epafoXk7/D2ubJeEZ81enGgMpCj/wEksHDCfVaSv9Ck8BsBHeloYKt/AkAVwrrs0wI71XPA1IQM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476943; c=relaxed/simple;
	bh=tDUir5n0cojiGdZCBkMQYJ8ICGb6dImsb7j6dxNI/D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpSlvxdACUvJsfjY7ZtrXEpV2/cHAAMlDdixL7CuwCcAZaW3vm8LtHVry3hNQAZg+MwKtQ8ibBzP9RtFb4C+NdCYafukjZDakX26d5M9O2XYMa5AkDUNDim7zQrNEfePPN2H9b3gdlYhIq/wcG+VfNYPRzKS02JtXk0Yu+IRJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nn97w85M; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nn97w85M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476942; x=1821012942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDUir5n0cojiGdZCBkMQYJ8ICGb6dImsb7j6dxNI/D0=;
  b=nn97w85MWtt2DQ916OEGlebiM8d3SUzS7XlHiaJcrAGrafg3f10nWN+Z
   v2TIb0sbTLmtcCte+NT5UBP74BSeBueU3SAUdb8Y02oLgqEg4k8oEHxEO
   5JZDVECaCwj3yh6R4qesUoxxvJflgEwgfNonueLdYO/pRvOFJsC9Atxwn
   dtOSXY/kvTXj/u8iJZxWdsicF7W7vMc44vHko+AhA3wuJ49NhSW6r6AVs
   30QgXerOAeJjxL3KIVPaXfvbvKhwT/zurjVNyYgTbkps3LCAKnY+nrsuH
   KIblmRZmuL0oCyGeFHWQ7ipkd6qMRAFrEoPwrkc4CjpV0GyDb1ZaWdbyC
   g==;
X-CSE-ConnectionGUID: EylHyN3sR+uTOjQF1uqrjw==
X-CSE-MsgGUID: Qc3Cm3CgQoO2Ko5e40RZrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853120"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89853120"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:41 -0700
X-CSE-ConnectionGUID: OGFKUvL1SQSpw76CizHwOQ==
X-CSE-MsgGUID: SwFl9AVURzmVCXXWXfs6kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225220"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:41 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 1/4] ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
Date: Tue, 15 Sep 2026 14:55:35 +0200
Message-ID: <20260915125538.3975870-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
References: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
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

