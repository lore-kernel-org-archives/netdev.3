Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530773;
	b=wNHrRsNA6Rd4cRMADVqTZzf6u6WiMkszV+2LSp0C5q/V19uBdNnLZsCx4dFKM1maRw9X
	 e1176w42Ob7gxnhkPdhTBy2vJK0K6UlYyDGPRvbCUGKCggLWGhEkXpM32qVrh8Q4cXpyb
	 KmfLTFK7gRB3pb4aRguyMRg1QmvR6YYQeC267OpL80roGlGA1cv0XBa9CUOmFEXoOIccf
	 bkwMqOCi1l8DgDqhtYuz50QEniKQPI+AE0W9Ds9cjSo+5GqIRubVLHy6iy61514HmXJZt
	 I0ayHHtsawciqeQNRzprcC7yJPHaifWcSei/J/x7+EFogdEe/eJT3cQ5GzgNu+TZImg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530773;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AR0Mkn+bQ82IeGpPhvQ/OS+0bEJG0ouCesgAWz0S+q8=;
	b=IRhnNDW1yERWpHxFPw8flatRkAxk7zPVI5OKmAcyxZm5GyrPSgsiZiyXa31oo2XweQ+1
	 0Dbgij3lr+39869avtmXKyg/q8hLANNrIgmp1WV3WE/1uzwQh9n9ZMLYHSw63ryQBhHUC
	 cwQVLJ35Lzm3QYGoUbTF1gbhpQqmYgNsAacF4Iv2ZT58iQlN3kKkyZpV4662UIY2Lylm6
	 QHqOjVnvh9AMOwpRUTwMTpzzvJWnhWJxDoLaF6v5KwEcSc9oNoSOIogsP6L3u7c+NbEjB
	 wmkAq0ok+tPKs4mUmJUmi4m3Fld7m3sEobKOXSMYf9gh8Y3WNNpi4pLuy9t2EZX0RVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G6qRP3j1;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09455606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09455606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G6qRP3j1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794530773; x=1826066773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LxGlHMn/pILfSngf7NbTbVLtURc2gGTCL18tBFav+7c=;
  b=G6qRP3j13v68xEO8MGbjI0Evwogbieyghgtg85e4NBhe5jmNsaaNpJCN
   S3Rs2ppFSLlDRsIszYO9lUjpC9JyhEkMnZ45w0b2nG2jXbaurUIX9Q83M
   elboWf5fIkYsCFiMm3YdSwWASZZzu8T3Lis8EsOm3NmGZ0sRl50Iy9Jt2
   wskNWNX3TsQeSzcUa6LLlzJecNzpA4F3RB0XHtjJBfv39Bm+FlkHtClIh
   iJBi6ldhR33UgrQi2j5ZwLJr/qEhZqdPlUrmZ1MZFksRbqUfukKmhHhI+
   Bm2qGb6KC5hqiS5Prq/+DKEUThAU3U9l/ZiaIMOCYzcj73PErMbe9TWJT
   Q==;
X-CSE-ConnectionGUID: NYdVBydyTySLOsMFrDsxHA==
X-CSE-MsgGUID: yGtBcGRNSTSoC5iznAjY4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3361668"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3361668"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:46:12 -0800
X-CSE-ConnectionGUID: QNf77+ysTNeQQVfArk9+Jw==
X-CSE-MsgGUID: 21mudO9gTCC354kBAUnLDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8724614"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2026 16:46:12 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Filip Balluch <fballuch@redhat.com>,
	anthony.l.nguyen@intel.com,
	mheib@redhat.com,
	aleksandr.loktionov@intel.com,
	luoxuanqiang@kylinos.cn,
	bjorn@kernel.org,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 2/6] i40e: fix freeing of TX rings on RX allocation failure
Date: Thu, 12 Nov 2026 16:45:56 -0800
Message-ID: <20261113004602.129864-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
References: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filip Balluch <fballuch@redhat.com>

When ethtool -G is used to change ring buffer sizes while the interface is
up, i40e_set_ringparam() allocates temporary TX and RX rings. If the RX
ring allocation fails, the error path at the free_tx label incorrectly
calls i40e_free_tx_resources(vsi->tx_rings[i]), freeing the live TX rings
instead of the temporary tx_rings[i].

Since the interface is still up, the next TX completion interrupt causes
i40e_clean_tx_irq() to dereference the freed ring descriptors, resulting in
a NULL pointer dereference in IRQ context and a kernel panic.

This can be reproduced on systems with Intel X710 NICs under memory
pressure, where the second port's DMA allocation fails after the first port
succeeds.

Fix by freeing the temporary tx_rings[i] in the error path instead of
the live vsi->tx_rings[i].

Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
Signed-off-by: Filip Balluch <fballuch@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 6a992df06fa1..ef756487d668 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2249,7 +2249,7 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if (tx_rings) {
 		for (i = 0; i < tx_alloc_queue_pairs; i++) {
 			if (i40e_active_tx_ring_index(vsi, i))
-				i40e_free_tx_resources(vsi->tx_rings[i]);
+				i40e_free_tx_resources(&tx_rings[i]);
 		}
 		kfree(tx_rings);
 		tx_rings = NULL;
-- 
2.47.1

