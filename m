Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C5390230
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578276; cv=none; b=jcUAUIPbU5b8sQFl4j+ZWFYOacQmDjJHxkD+eTqWF9DCMguSKT2A1fm8YrN5RNGedT/qD7iVBkrT9lbhkkImbuNIXz9N6XyiMBOzYUfpkhTDLk0pBevFdJir1lwAgdNxf/FTmMATRLsDHXwIhmd8pX0JwUIekwk2FEyR67wOEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578276; c=relaxed/simple;
	bh=tz2+aBfguTWb6mMviRrhzIeZvuvfpFVmax6haPLT2S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGvJ0ps7a5Tbfsu3Anbljh5bIwyW1Kz3VwDwQR961ZbEmKkX0g3Km3KaGT2G/CO90fkMpwIpKLUCNj7g+1CJz3zI1mb3jHA5ZmpO7bk+mdRBoabxU9A7qIkZWjesqzVSq0/e3zQkxU8YxpFfuayTur35h4fKEFA6o5q7AvpAG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAsrWcAJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAsrWcAJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778578275; x=1810114275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tz2+aBfguTWb6mMviRrhzIeZvuvfpFVmax6haPLT2S8=;
  b=FAsrWcAJ33U/t/cDCskrLibLhEq7mqGmM2QhQoJxI8EOlUgRyB1YRfb2
   c+F7zTjflSnLfzLSbRlCD62vhR0NPnYD+DjUYXqgp+UVmcTr0eHYrslo5
   qC9XD94yheFHn8cAQi3PgAu27G8jmXDFZgLfYPHzWX4eAWNvLSCW6iJLE
   Zx7hlml21fb3ARyP/C0o4yV0vLKBLM5oiblT6NYEnPOptXvAF6syEgOkb
   jDcE26LedwhFgm4PeO1sk/5R+HRdKy7HPndxPaWejU8Kqy+Q5teMAhRiz
   5Zn3BIt0Wq6X0NX72g37oWAPiQWoPGD0yWtkp3lyXXLVqkTim5ljiOrZ9
   A==;
X-CSE-ConnectionGUID: NWYKh6vxSwiRrP1no0cIiA==
X-CSE-MsgGUID: reTxny+UQhi/ZJMjdS0SoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79663243"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79663243"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:31:14 -0700
X-CSE-ConnectionGUID: jq6YEiKESjq1jKu3tOnIGg==
X-CSE-MsgGUID: T/U1A9PrSNSwhI0TjeGXWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231323212"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2026 02:31:13 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 1/4] ice: pass the return value of skb_checksum_help()
Date: Tue, 12 May 2026 10:47:26 +0200
Message-ID: <20260512084729.1338557-2-michal.swiatkowski@linux.intel.com>
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

Instead of just returning error try calculating software checksum first.
There is a check for TSO in checksum_sw_fb.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 94129a7a9e12..f52a4af36eb0 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1673,7 +1673,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 			ret = ipv6_skip_exthdr(skb, exthdr - skb->data,
 					       &l4_proto, &frag_off);
 			if (ret < 0)
-				return -1;
+				goto checksum_sw_fb;
 		}
 
 		/* define outer transport */
@@ -1692,11 +1692,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
-			if (first->tx_flags & ICE_TX_FLAGS_TSO)
-				return -1;
-
-			skb_checksum_help(skb);
-			return 0;
+			goto checksum_sw_fb;
 		}
 
 		/* compute outer L3 header size */
@@ -1755,7 +1751,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 			ipv6_skip_exthdr(skb, exthdr - skb->data, &l4_proto,
 					 &frag_off);
 	} else {
-		return -1;
+		goto checksum_sw_fb;
 	}
 
 	/* compute inner L3 header size */
@@ -1808,15 +1804,17 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 		break;
 
 	default:
-		if (first->tx_flags & ICE_TX_FLAGS_TSO)
-			return -1;
-		skb_checksum_help(skb);
-		return 0;
+		goto checksum_sw_fb;
 	}
 
 	off->td_cmd |= cmd;
 	off->td_offset |= offset;
 	return 1;
+
+checksum_sw_fb:
+	if (first->tx_flags & ICE_TX_FLAGS_TSO)
+		return -1;
+	return skb_checksum_help(skb);
 }
 
 /**
-- 
2.49.0

