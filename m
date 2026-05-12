Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF34BC023
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578280; cv=none; b=jT7ghEthsK4Wt1/UaSMjMQ9vGsgObXM3ftrnx3YO+ok+mfNsv2CxFCX3sh1r8DC2Sy7pk87H3UCQa7eVWOdNZH76sUWoiio8IfUUEoim4OPmUieq37ByH/8NanlQvct0XmMUTcHBTz0B50OGkm5g3kF7A0+Q5+uSptdR5KMuKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578280; c=relaxed/simple;
	bh=Wp9oJK+TQouTc/5MVS5LRf6gpBnWoPMk1KagdWAWwo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2QzMOxubx2RolLnTdXs9E17QQZkhqKGcnVdDfw9P34rxhnAmlLUS6KyU9XMMVx6+HbkHe/Bf1nUBoJxWASkG+riuqE3N+gxxCHgHhPHp8XEX+SR3BfGGtV18DWwUh5mTkS9yGwEVDtBTmC+AzsJcDqeJMKlF9oIXaBl4Wcejq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJRRC4jW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJRRC4jW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778578279; x=1810114279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wp9oJK+TQouTc/5MVS5LRf6gpBnWoPMk1KagdWAWwo0=;
  b=IJRRC4jWMRNsrzCgyMLkurAouP6HTv6TZdltH3lns4TAJyIBoGuClCiX
   c0rmXBRghzHFrDBX0stSjmrE2566sujtdDTdJ8E9tDabzPm9oqIpaAOK2
   z3hZQybcEbFzzSdfs04YqRuDWJFoMJyLeLOxVUtPK7KaC/DY2tTU45cIE
   lwcjDLmSHHSxVXZZkgcOpC/zGfHaoUTykL9zcbp5tVY7JqHjE5pMd+Ozr
   e0+J0wyVGBhyjxJhbogukYlFavCgfzgYXgxP/X+soF4O59GjwVwIFO2D6
   fVWXfvhdfMs8VQXrEoMNJ8b0kYy3T05mMOA3bi4QPQ+LJE9VRDzuaQWT0
   A==;
X-CSE-ConnectionGUID: wGUMekafRqyIpF8LDjtKgQ==
X-CSE-MsgGUID: kDWv3R1AQZebSc07+R60iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79663252"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79663252"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:31:18 -0700
X-CSE-ConnectionGUID: V3CUeQEsRsWwvGUZVETVwQ==
X-CSE-MsgGUID: LrPDCEucT/SS3ZE8dAO3Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231323233"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2026 02:31:17 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 4/4] idpf: pass the return value of skb_checksum_help()
Date: Tue, 12 May 2026 10:47:29 +0200
Message-ID: <20260512084729.1338557-5-michal.swiatkowski@linux.intel.com>
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
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 22 ++++++++-----------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index e3ddf18dcbf5..dde986706a37 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -78,12 +78,7 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
-			if (is_tso)
-				return -1;
-
-			skb_checksum_help(skb);
-
-			return 0;
+			goto checksum_sw_fb;
 		}
 		off->tx_flags |= IDPF_TX_FLAGS_TUNNEL;
 
@@ -138,7 +133,7 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
 					 sizeof(*ip.v6), &l4_proto,
 					 &frag_off);
 	} else {
-		return -1;
+		goto checksum_sw_fb;
 	}
 
 	/* compute inner L3 header size */
@@ -163,12 +158,7 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
 		l4_len = sizeof(struct sctphdr) >> 2;
 		break;
 	default:
-		if (is_tso)
-			return -1;
-
-		skb_checksum_help(skb);
-
-		return 0;
+		goto checksum_sw_fb;
 	}
 
 	offset |= l4_len << IDPF_TX_DESC_LEN_L4_LEN_S;
@@ -176,6 +166,12 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
 	off->hdr_offsets |= offset;
 
 	return 1;
+
+checksum_sw_fb:
+	if (is_tso)
+		return -1;
+
+	return skb_checksum_help(skb);
 }
 
 /**
-- 
2.49.0

