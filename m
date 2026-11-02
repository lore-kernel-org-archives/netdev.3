Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623822;
	b=5E0IwsSVMwtTOvywoBpUZimgxbO4sbPwJlpphi1Yt8wG7LkmdTeWyVq/E0INJ/WLtDZp
	 EvTFf83aHCJfAhemIzv+qymG2b0dTE6T3LcP/1sqD302mFFfTB4ADicNqd7Uc9ObVc69P
	 5vbifT09Otcs4T9o6lsU2x3Y0cLFtRVLmK+QMN+R05gnUweCR4vdv/VFvTC0K79Iu5BcM
	 NKNrp/J+b+89C3U1sCrhW1csnems7I8J+8SI13WJS8+9wQLtDmwXkmEqT7i5/alxbEoT2
	 irkVfaRjUJnEGGcSdx9X0EXR4U3Rt98IbHd21b1Usw3O0vdvOJBeomgYtL8tFYvCKyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623822;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ARwvuTqWJyf2ZgMAGzDdPyyXdF6Flj5kN/HVKbOs2uA=;
	b=oijYjwB7b5vVzHo9iaJsM+N7jCJs5cW6f9pJCldcis2iZa8Y3Wjq3ZxuTDcdVpPkD7IC
	 DsAMyQLk7l6kVsuxlJqax5MZeY+sZ0xg3DWRsAYDefE7NRUnfHzOVSfTZp7WiYA6HE7GD
	 zJCZokLSbB6mzgZ3uV66TL7PyRLlOf97GqLWTZXepHUeyPX2O/AX4MwAxMk8QU/EOH40n
	 Cks4HrO+AaXliOCQm3+Is2CaghBtzqxFw8nLacDxzTcx2YMujdq590CZf3zP0dgAtY6al
	 7IrXF/dgMTKCGdZdoKo4hEMiBw9xDxlxgkRG0P4fKjDfn+Nh3iVTHgmYd4yc8TbXoog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=czUI0zFI;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1AB60A260B
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB1AB60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=czUI0zFI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793623821; x=1825159821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qlpthv2WFaTFwrPP5FBf5U+4r54qzzegRyMHHNLFwSE=;
  b=czUI0zFILmmL/G0DjfWKWl9ky6iqHi0YX90RmgDyByjodpk1I56iiSIz
   g8gM86Bhv+9bwT3s1L0Mqa7X2s3T7oh2Q8FcTWaTACOAIX4G6mT+DZTqL
   CEFqKSkQYoUOzuynhMzpoBQjnzJGkTKX90D38yGd4w9lZvKhx+GMFxC4w
   1bnwIa0WyVntHZ/TAhTXerFAasDB+7JpTjHyRsN0fbfsbZzrSn7O2Fvsg
   KN1YA3v5+zMHrbp5uJ9inEMNjWB8AX7Vwus5DrN1EjVLIiMevAZSLiz4x
   aoWKLtaF8rLZAo2hE/Jqmezpqr0Hdpnio6ZblWcknDTsGKEsXTnop7FYz
   A==;
X-CSE-ConnectionGUID: ECLwfPXmTey7RiAtmPEBBA==
X-CSE-MsgGUID: 9PxmaIxzRJ+mYdTKjvjZ4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191885"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191885"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:50:20 -0800
X-CSE-ConnectionGUID: BteuTZDGRwehUd7xNeUcKQ==
X-CSE-MsgGUID: 7uCQWOWBR5uo3VEuCYKsKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7928538"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 04:50:19 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	zuomao338@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 8/9] ice: xsk: free stashed Rx frame when cleaning the ring
Date: Mon,  2 Nov 2026 13:49:49 +0100
Message-Id: <20261102124950.958345-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
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

ice_clean_rx_irq_zc() stashes a partially received multi-buffer frame
in rx_ring->xsk, with its frags on pool->xskb_list. next_to_clean is
already past its buffers, so ice_xsk_clean_rx_ring(), which walks
next_to_clean..next_to_use, misses the frame, and ice_vsi_cfg_rxq()
later clears the pointer via ring->xdp.data.

The buffers are lost to user space and, as the pool outlives the ring
across ifdown/ifup or a reset, the stale frags are taken as frags of
the next frame. Before commit 93f53db9f9dc ("ice: switch to Page
Pool"), the frame was tracked by rx_ring->first_desc and leaked the
same way.

Free the stashed frame when cleaning the ring.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index bf14ed8f87a3..0c1ce3e86a45 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -912,6 +912,11 @@ void ice_xsk_clean_rx_ring(struct ice_rx_ring *rx_ring)
 	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 
+	if (rx_ring->xsk) {
+		xsk_buff_free(&rx_ring->xsk->base);
+		rx_ring->xsk = NULL;
+	}
+
 	while (ntc != ntu) {
 		struct xdp_buff *xdp = *ice_xdp_buf(rx_ring, ntc);
 
-- 
2.43.0

