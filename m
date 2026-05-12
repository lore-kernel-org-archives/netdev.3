Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEBB4B8DE3
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578279; cv=none; b=mgxqSFpzbYGCOWCdlvOvDDYky6EeUdeGkUtI3N9TzquqpUcmUJazKgJVdFBaPFNe2Y0BOotnQzN186Zv7Vp92Fwxkzs6nOXa3haceVTldJnzHLC75a2hW7lrInrqqzRBt+NOpqCvIsGrejlRU6dyTPcHUTNew52h/UYMpPtQvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578279; c=relaxed/simple;
	bh=BMA+HcsTduy9KAlNO7woXKOs4/OBkd3hKSbqaxHi534=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcfAw76adbCVfdNguCOdWVNJUwySJTXmiH/wlIHG/DC3sHwUKU3m32K6Zh760kCVrx+jWcHfL9fT4eiP3Gje/LFJKLs7FAUOjdIfkkvB6BAdZLo4k6S1SHbcgnPzZlL7p0sAIJ4mhbKzemXWyQ4dPBPNiR/LwXxXklQ9qgwMeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2p0XxPP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2p0XxPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778578278; x=1810114278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BMA+HcsTduy9KAlNO7woXKOs4/OBkd3hKSbqaxHi534=;
  b=n2p0XxPPxfdVLzgxfJ8A+OBV6S5mbcVyxzPUqbbOI/+Oldg4ExWI8NKm
   K8oYnl9MMV2M34WOEKHdV5awXgh9rrGEmQiEXYmG4fmuqzebKQfWLx/MG
   9RvrRxKNkmfA6Y3uMCBV2xPPLq2KIvMI7SmyfwbJ6zyqE6X+c+IyNeP8N
   65VqUxqBAvxcXzfQEuPzdeaxID59o8eXbGwyoQ3NlKupLbkPv7TP3JQKd
   nhwUwMv0QnYB3G4bptv4hoYJjQ/prlRuXjBnOyhsC2k1z1Atf67moBAVA
   UKzd6hNYImC3CTqVVxd1K0LNfvyt2NDE7Q8iRzV116C1EZqiuxOgNm8mh
   A==;
X-CSE-ConnectionGUID: 1n+PBnyRRJSuoK8YMCjvcg==
X-CSE-MsgGUID: +euGOi6LRTWAyBZiBD53+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79663249"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79663249"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:31:16 -0700
X-CSE-ConnectionGUID: NLE6tDptS1+vOqXPGHhNDw==
X-CSE-MsgGUID: 9R60V5r/SKmcyCu698rAsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231323227"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2026 02:31:16 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 3/4] iavf: pass the return value of skb_checksum_help()
Date: Tue, 12 May 2026 10:47:28 +0200
Message-ID: <20260512084729.1338557-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260512084729.1338557-1-michal.swiatkowski@linux.intel.com>
References: <20260512084729.1338557-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_checksum_help() can fail. Pass its return value back to the caller.

Commonize this software path in goto.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index ab46a49bb5e0..c5d4486c0396 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1909,11 +1909,7 @@ static int iavf_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
-			if (*tx_flags & IAVF_TX_FLAGS_TSO)
-				return -1;
-
-			skb_checksum_help(skb);
-			return 0;
+			goto checksum_sw_fb;
 		}
 
 		/* compute outer L3 header size */
@@ -1990,16 +1986,19 @@ static int iavf_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			  IAVF_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	default:
-		if (*tx_flags & IAVF_TX_FLAGS_TSO)
-			return -1;
-		skb_checksum_help(skb);
-		return 0;
+		goto checksum_sw_fb;
 	}
 
 	*td_cmd |= cmd;
 	*td_offset |= offset;
 
 	return 1;
+
+checksum_sw_fb:
+	if (*tx_flags & IAVF_TX_FLAGS_TSO)
+		return -1;
+
+	return skb_checksum_help(skb);
 }
 
 /**
-- 
2.49.0

