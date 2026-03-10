Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30A3ACF04
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176225; cv=none; b=DAQlV07WKSbotw08Ik1vd3CDKLZQIauOLndSBpHsv+FMB2/QoZM4htBrreErMBkfhfS0rDSzGzCPAoDcrIlQSO6uqDGqxmUlAexYlCrG6NfbDco84718cArv3z13jbQEzD+UVdlDP8pNDLOJKStM3hDbfr6TehFTZOO4AiY8TWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176225; c=relaxed/simple;
	bh=QjvrbjQXSnIly57uwDbFUsltcNCvjoRkg9/NMV/66P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOppU3Bw5mNksBiZJ/t1lcdEx1bRoatN8tesYbiTEdov60rCTgiITajvhkuTGil6CBA4q0XeYplN0A/aRPqtpMBmXMQg92EHvF4B8UMwzqOk87K2w+qg1W9hUFEszbpFpXJjDoki2vuQYNR1ibSuOlWGPElg2ImoHFdsSExVIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ok3OLAX+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ok3OLAX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773176223; x=1804712223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QjvrbjQXSnIly57uwDbFUsltcNCvjoRkg9/NMV/66P0=;
  b=Ok3OLAX+x7Ac85V5K/1TjKyOxvONZL45E2hc+6WhLDIo7lGOQhc7wPZx
   drvLYSwm2IpQ82BZjMr5rAnLBc0cSvsZM34QpG21CyGK2LtPaLfLTK3z7
   jv8QfIYweDaIYUtl16Zgt4Xhqxhpu309sWsxGy4xQe6kxxK0Tq7Afflwp
   M4IwNft7i+yejIvbmezVsfsDPqB3UFNrfq4AErA8dtrjfuyERFrjFWukv
   L9xQ7AJl5BxCkiAb/LbAYjuhrPUPNrzGrKL2hjuXQiM647NVFVhG2582p
   k53edmfMawlFZwVD5SrmDMYmlJeLZMzZz7CiEWzMO6UVlWOQxrbNfGGM9
   g==;
X-CSE-ConnectionGUID: /lwQNvsVSw6IVqN/1Al0QQ==
X-CSE-MsgGUID: Qaq7hGXcQzS2HHPTLkR1ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85326058"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85326058"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:57:01 -0700
X-CSE-ConnectionGUID: lELXMKOORh6qG8BrpcC+qA==
X-CSE-MsgGUID: W360DyzwTwuy5jRaaSOkKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="258162887"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 10 Mar 2026 13:57:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Matt Vollrath <tactii@gmail.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	roel.kluin@gmail.com
Subject: [PATCH net 5/5] e1000/e1000e: Fix leak in DMA error cleanup
Date: Tue, 10 Mar 2026 13:56:53 -0700
Message-ID: <20260310205654.4109072-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
References: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Vollrath <tactii@gmail.com>

If an error is encountered while mapping TX buffers, the driver should
unmap any buffers already mapped for that skb.

Because count is incremented after a successful mapping, it will always
match the correct number of unmappings needed when dma_error is reached.
Decrementing count before the while loop in dma_error causes an
off-by-one error. If any mapping was successful before an unsuccessful
mapping, exactly one DMA mapping would leak.

In these commits, a faulty while condition caused an infinite loop in
dma_error:
Commit 03b1320dfcee ("e1000e: remove use of skb_dma_map from e1000e
driver")
Commit 602c0554d7b0 ("e1000: remove use of skb_dma_map from e1000 driver")

Commit c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of
unsigned in *_tx_map()") fixed the infinite loop, but introduced the
off-by-one error.

This issue may still exist in the igbvf driver, but I did not address it
in this patch.

Fixes: c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of unsigned in *_tx_map()")
Assisted-by: Claude:claude-4.6-opus
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 --
 drivers/net/ethernet/intel/e1000e/netdev.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3d7648a119e5..9b09eb144b81 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -2952,8 +2952,6 @@ static int e1000_tx_map(struct e1000_adapter *adapter,
 dma_error:
 	dev_err(&pdev->dev, "TX DMA map failed\n");
 	buffer_info->dma = 0;
-	if (count)
-		count--;
 
 	while (count--) {
 		if (i == 0)
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 35dab1e3132f..9befdacd6730 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5652,8 +5652,6 @@ static int e1000_tx_map(struct e1000_ring *tx_ring, struct sk_buff *skb,
 dma_error:
 	dev_err(&pdev->dev, "Tx DMA map failed\n");
 	buffer_info->dma = 0;
-	if (count)
-		count--;
 
 	while (count--) {
 		if (i == 0)
-- 
2.47.1

