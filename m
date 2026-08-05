Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094BA42BE89
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965768; cv=none; b=BLqVrmbKoYTQx6RUVoI7Tvb8eW36PMyPOUjNh/QHb33T1ED9WbNmpWtUPu/d8cZ+5rffT5hmtRW1jAD8jZr41kzE4yYUgGChx+cHM+soeVWg5fCJb6n5GFwASL+JWvuNVqaqIspRgwLlGRvQde2P8usauhYxxHcFIfGLBKSZC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965768; c=relaxed/simple;
	bh=9mci65arxAv8Fw1TDpSPToFsSq5AHZFy8aj7yMn9dL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umRUOUFZvKunNFz131ZxIp4w6mgoywXvt8hrvTZPyASKRsj/iEyv6FCDo3pl5l7d1W/fLxC7Do89LbOmhxjNgs0EjAbgEZG9rNteePTqhP3VzW4u6p01tqUuVNBaxN95JrvPRaf0cttU/Fo/8AWweY4ErKvXQTcMaPospHuk0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMiPueBw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMiPueBw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965765; x=1817501765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9mci65arxAv8Fw1TDpSPToFsSq5AHZFy8aj7yMn9dL0=;
  b=EMiPueBwphI66AXVJiKaxr/b3qQFK6LmWc+43OKonbOuGyYlmbIQufzA
   KikI7aOF/DTJFej1r1qbGbnicFvDV/3JuTWlQiU0D2v02RwnT08+yglUN
   ymSCobBffCFvGBVSaFW3Xv7RWbMCkdRgPmDCgsX+RzqG2BkX+1nCwvZfO
   KSsv9X2N+hIlHHuYbWyS5GFZrpo4/8tKLxbLENWoKdl2u+vK9nim/R5uX
   8G+oW6mr9Uvj4MQJ8SiEuGeaWve0cjxdSKMtHrXoslhkx2qJKL8xqfhXG
   a3/l14kPv94/SfMn2Wv1b9wYB7RZXbJVnTtX0eWLDElHBWFZFRH5nIcPP
   Q==;
X-CSE-ConnectionGUID: Fo9fToTQSA6bnsZVAa4RCA==
X-CSE-MsgGUID: LQj2HoVmRFOwi+DfxPJVpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343649"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343649"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:55 -0700
X-CSE-ConnectionGUID: X8Anv8BARj2j8zAeZZLmhw==
X-CSE-MsgGUID: Rx0+L21dTVCHGTEurldqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576172"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:54 -0700
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Michal Cohen <michalx.cohen@intel.com>
Subject: [PATCH net-next 15/15] e1000e: Avoid DMA re-mapping on RX copybreak
Date: Wed,  5 Aug 2026 14:35:40 -0700
Message-ID: <20260805213541.2281287-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Vollrath <tactii@gmail.com>

This patch factors out DMA re-mapping for skbs which were recycled in
the RX path due to copybreak or errors. There is only one path out of
the e1000_clean_rx_irq() loop where the skb is consumed and DMA needs
to be re-mapped, so don't unmap it before checking the conditions.

The buffer allocation loop is adjusted to not assume that DMA is
unmapped, handling mapping errors gracefully.

On systems with IOMMU enabled, the cost of re-mapping DMA is greater
than the cost of copying data out of the ring buffer. When I use this
patch and configure e1000e with copybreak=2048, my system with IOMMU
completes RX roughly twice as fast under load.

Informal performance comparisons were based on Asus Gryphon Z97 which
includes an I218-V and with a Xeon E3-1240 v3 in the socket. ktime_get()
measurement was injected into e1000e_poll() wrapping the
adapter->clean_rx() call. The total time spent in clean_rx() was divided
by work_done to print the average time spent per buffer. iperf3 -R was
used to saturate the RX path and awk was used for statistics. Control
revision was set to 7.1-rc1 because iwl-next hadn't been updated yet.

  rev     | iommu | copybreak | samples | mean (ns) |   stdev
  7.1-rc1 |   off |         0 |    4748 |    453.72 |  155.82
  7.1-rc1 |   off |      2048 |    4743 |    554.83 |  103.67
  7.1-rc1 |    on |         0 |    4751 |   1139.22 |  150.56
* 7.1-rc1 |    on |      2048 |    4737 |   1267.02 |  184.62
   +patch |   off |         0 |    4739 |    456.30 |  146.33
   +patch |   off |      2048 |    4739 |    538.56 |  132.97
   +patch |    on |         0 |    4769 |   1165.97 |  140.19
*  +patch |    on |      2048 |    4745 |    562.25 |  171.80

No surprises here, IOMMU DMA ops are known to be expensive. For most
users the kernel default is iommu=on and driver default is
copybreak=256, so unless the workload is small packets, some tuning of
either knob would be needed to see the full benefit of this change.

The kludge of unconditional unmapping has existed since this driver was
introduced in 2007[1], inherited from the e1000 driver which has since
factored it out[2]. IOMMU tech was new at the time.

[1] Commit bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
[2] Commit 2b294b18689c ("e1000: perform copybreak ahead of DMA unmap")

Assisted-by: Claude:claude-4-7-opus
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Michal Cohen <michalx.cohen@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 32 ++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..b08bcbdb19d9 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -675,6 +675,8 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
 		skb = buffer_info->skb;
 		if (skb) {
 			skb_trim(skb, 0);
+			if (likely(buffer_info->dma))
+				goto write_desc;
 			goto map_skb;
 		}
 
@@ -692,10 +694,12 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
 						  DMA_FROM_DEVICE);
 		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
 			dev_err(&pdev->dev, "Rx DMA map failed\n");
+			buffer_info->dma = 0;
 			adapter->rx_dma_failed++;
 			break;
 		}
 
+write_desc:
 		rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
 		rx_desc->read.buffer_addr = cpu_to_le64(buffer_info->dma);
 
@@ -953,7 +957,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 		dma_rmb();	/* read descriptor and rx_buffer_info after status DD */
 
 		skb = buffer_info->skb;
-		buffer_info->skb = NULL;
 
 		prefetch(skb->data - NET_IP_ALIGN);
 
@@ -967,9 +970,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 
 		cleaned = true;
 		cleaned_count++;
-		dma_unmap_single(&pdev->dev, buffer_info->dma,
-				 adapter->rx_buffer_len, DMA_FROM_DEVICE);
-		buffer_info->dma = 0;
 
 		length = le16_to_cpu(rx_desc->wb.upper.length);
 
@@ -985,8 +985,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 		if (adapter->flags2 & FLAG2_IS_DISCARDING) {
 			/* All receives must fit into a single buffer */
 			e_dbg("Receive packet consumed multiple buffers\n");
-			/* recycle */
-			buffer_info->skb = skb;
 			if (staterr & E1000_RXD_STAT_EOP)
 				adapter->flags2 &= ~FLAG2_IS_DISCARDING;
 			goto next_desc;
@@ -994,8 +992,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 
 		if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
 			     !(netdev->features & NETIF_F_RXALL))) {
-			/* recycle */
-			buffer_info->skb = skb;
 			goto next_desc;
 		}
 
@@ -1022,19 +1018,33 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 			struct sk_buff *new_skb =
 				napi_alloc_skb(&adapter->napi, length);
 			if (new_skb) {
+				dma_sync_single_for_cpu(&pdev->dev,
+							buffer_info->dma,
+							adapter->rx_buffer_len,
+							DMA_FROM_DEVICE);
 				skb_copy_to_linear_data_offset(new_skb,
 							       -NET_IP_ALIGN,
 							       (skb->data -
 								NET_IP_ALIGN),
 							       (length +
 								NET_IP_ALIGN));
-				/* save the skb in buffer_info as good */
-				buffer_info->skb = skb;
+				dma_sync_single_for_device(&pdev->dev,
+							   buffer_info->dma,
+							   adapter->rx_buffer_len,
+							   DMA_FROM_DEVICE);
 				skb = new_skb;
+				goto copybreak_done;
 			}
 			/* else just continue with the old one */
 		}
-		/* end copybreak code */
+
+		buffer_info->skb = NULL;
+		dma_unmap_single(&pdev->dev, buffer_info->dma,
+				 adapter->rx_buffer_len,
+				 DMA_FROM_DEVICE);
+		buffer_info->dma = 0;
+
+copybreak_done:
 		skb_put(skb, length);
 
 		/* Receive Checksum Offload */
-- 
2.47.1

