Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D54C0438
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025908; cv=none; b=aiybayDjxHxKkBfF5yvt4KmHceqIbmiX+aiUT33BYXFvbiVfiESYuZnW4ohgoHKncDl4K1yqrIbOYqVp0B67dxn0422/lMGy4cOBI8TKijaXM7L2sHNZsnvpxZnylfvkua043la+sHNBwXjFJD6/h9jGJqjugHAp7QVbYBsye6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025908; c=relaxed/simple;
	bh=AihS6eTa0xJl67Crhu8pkZYsSX2Ju3pM+Lhvy6Xr6Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaH1bH6JENDKoLanDenak0nNmI1/ga6UTLNwWKBNHCtnjGYBc7WHL9iQJP435fmawFa3T236kYD2s16tKyWYLMxdt6P4dLvTrNsH6BRBXH47zlU4O+WkZwX16bw8nvlJ/3Vji8snrgK/wG2qXoqy9N0ny1iXtEZyuaEgOBCBKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4+Jqsiy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4+Jqsiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781025907; x=1812561907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AihS6eTa0xJl67Crhu8pkZYsSX2Ju3pM+Lhvy6Xr6Zk=;
  b=H4+JqsiyM7pggrDNeKcxcNy2XkM3lcO8oENjN7ht5xMoyxUwAKEZOmGh
   3uY5WiFNa4r0OIMSDk63T3fgi8WHhpF8Vu8yF+Tzb+6AvsD0jwVu6o24F
   2s/VcmnTSmKo2gIRmZS3SQ1dXnx/9cIuTK7N5iEOvWK2LHl146D6dfF57
   rwvlIIE6G9MtRCcsoxtKPF+QmqZ+bHBo/UNylNPApo5VPRCtTGx3eeBlJ
   HccuOJuzrpbz68jjnv8OKFHwn/vhUxsdDyxqI44nXh1qcbZdJlcvbQqZv
   URYObApbc+RIY4criUc9om7kJ4yfSgkh47EZrY8V25ZIhJZ8LqcHnvKfZ
   w==;
X-CSE-ConnectionGUID: /HPMhfg+QZOWXsl0OmO55w==
X-CSE-MsgGUID: uxV4Rbm1Q+qB4XxRXkkjjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99373440"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="99373440"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:25:05 -0700
X-CSE-ConnectionGUID: cbkG5OQSRfaNOBxwHVHH8Q==
X-CSE-MsgGUID: eEE7c8qASMetXWTCO8i16Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="250995096"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2026 10:25:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: KhaiWenTan <khai.wen.tan@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	vinicius.gomes@intel.com,
	chwee.lin.choong@intel.com,
	faizal.abdul.rahim@intel.com,
	khai.wen.tan@intel.com,
	faizal.abdul.rahim@linux.intel.com,
	hong.aun.looi@intel.com,
	vladimir.oltean@nxp.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 3/3] igc: skip RX timestamp header for frame preemption verification
Date: Tue,  9 Jun 2026 10:24:56 -0700
Message-ID: <20260609172458.4046222-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
References: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: KhaiWenTan <khai.wen.tan@linux.intel.com>

When RX hardware timestamping is enabled, a 16-byte inline timestamp header
is added to the start of the packet buffer, causing FPE handshake
verification to fail.

Because an incorrect packet buffer is passed to igc_fpe_handle_mpacket(),
the mem_is_zero() check inspects the timestamp metadata instead of the
actual mPacket payload. As a result, valid Verify/Response mPackets can be
missed when inline RX timestamps are present.

Pass pktbuf + pkt_offset to igc_fpe_handle_mpacket() so it inspects the
actual mPacket payload instead of the timestamp header.

Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
Co-developed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 8ac16808023c..c470d2354ce8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2649,7 +2649,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		}
 
 		if (igc_fpe_is_pmac_enabled(adapter) &&
-		    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf)) {
+		    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf + pkt_offset)) {
 			/* Advance the ring next-to-clean */
 			igc_is_non_eop(rx_ring, rx_desc);
 			cleaned_count++;
-- 
2.47.1

