Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710585;
	b=hs/5l4Fgq2zwJ8eJ8lgVudptAty61L4CJ0Z0xOo5mXtPvIWMpRgsqhqMkkCqu6jnyw3G
	 9Np9ejQWJ9xu9XJ49XRlmA+F1FgL4IolombuYxLFAky6VaTimLV0qgvZ1l3uQvCfvewJz
	 +nEzBznfol2E10QZIbSYHCIqU8qMjtkxCRRuf67S2tOb4HVrTBzxJv31lMEkUtrRvbJEO
	 O6OoyswG/l4VpL9+vlIkb+RoRkgu9lmILnotxZRB5GPisvApGBpDvnC6z1tD0rGBWU9m/
	 y2HNzYQ9n5CI0sYYC2EhY/tcuP26j0K3t3D47uKCW0+EMPpo1A+avF6ZhV7GPxsBRIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710585;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kusgFLicJ8cDxCoSPNLD9mTVoDoE6a8bHmah47xgC2w=;
	b=glqfja39PW2muCU0mZmv/hpHJVwnn2WNPdin5q3mAVxbZnp9LIxexia9Prt35PyTFOsh
	 Cu20ulKq+n0oasZ8b9ZDp7RRzkq+d4i0RcMcs6coiZapxaqVGMP+AhqTNuGZ38/uIb6FW
	 OHmixaeUOtIXn+tOorvj9PLbQ2MsXdpN/b5a4LyOsRCxDlStVQCvWr8XMOYHyjW3c4eVK
	 brl+w9HjPrZhdnQwE8DcruL4k9xFSGMVfz1EDUK5GpwNljvySg+8kGYYo5uIAI13nc5Q7
	 DQMrnlniyddOSRa2+j4d5K8KLPqVKaw3nZPEbhff05ioKQBLBwU3BDSx3Rw9g1zkHOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i7J4sI68;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8E606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00C8E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i7J4sI68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793710585; x=1825246585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g0Rq2YlcXtBHweKI7SYSJ1GRA/vbFkHhtvPw6vNsF8I=;
  b=i7J4sI68EAzt8jauCzXmdJoDjPlQxa8CJ/pO1hqkgqvicJybppTheMji
   /SjrlJ+E4S7CaOc/0C1DvNGiSZXBFbrlwtPWN/9s48+EyTXLc6qmn1UDA
   52R7Kg/jFtlpNuqdXuS4YN0VXdh7deHzKfzCVxFmH4yLT63fRNqHZh6cL
   NSE4Al2QMXstZ52d3WBAjPXVi8RufpHwBEsxF6mWLWyPaXfz1ovM2PVh5
   1XcS2CKn6lnSxAxEaPdhN41y21x3VEDSsINT0237sFo5t3Mzofcd90UaD
   TEU9uXwq07kOS00gQ1P3lqDDeSmSMSb2Jexl9pTzgY6FlRlZLJfNQT0wv
   w==;
X-CSE-ConnectionGUID: lor49FX/RHyQUXkmOjcN/g==
X-CSE-MsgGUID: ITTu6KNiRnuVI5rInKIEsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2460801"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2460801"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 04:56:24 -0800
X-CSE-ConnectionGUID: FYyOU7IWQj2v7NDdEjShEQ==
X-CSE-MsgGUID: zWJmx/9XSm2upOZX33I/3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6316906"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 03 Nov 2026 04:56:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0E7AC99; Tue, 03 Nov 2026 13:56:21 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] net: thunderbolt: Stop queueing Rx buffers if allocation fails
Date: Tue,  3 Nov 2026 13:56:19 +0100
Message-ID: <20261103125621.1111198-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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

Sashiko pointed out that there is a bug in the driver when Rx buffer
allocation fails, we silently release the memory but leave the
descriptor in the hardware ring. This could cause all kinds of memory
corruption to happen. Fix this by making tbnet_alloc_rx_buffers() not
release the buffers already queued and modify the call sites accordingly.

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Closes: https://sashiko.dev/#/patchset/20260902082128.1148463-1-mika.westerberg%40linux.intel.com
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 49 +++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index cf51b9c39f4e..30b3568a83fc 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -506,7 +506,7 @@ static unsigned int tbnet_available_buffers(const struct tbnet_ring *ring)
 static int tbnet_alloc_rx_buffers(struct tbnet *net, unsigned int nbuffers)
 {
 	struct tbnet_ring *ring = &net->rx_ring;
-	int ret;
+	int ret = 0;
 
 	while (nbuffers--) {
 		struct device *dma_dev = tb_ring_dma_device(ring->ring);
@@ -524,14 +524,16 @@ static int tbnet_alloc_rx_buffers(struct tbnet *net, unsigned int nbuffers)
 		tf->page = dev_alloc_pages(TBNET_RX_PAGE_ORDER);
 		if (!tf->page) {
 			ret = -ENOMEM;
-			goto err_free;
+			break;
 		}
 
 		dma_addr = dma_map_page(dma_dev, tf->page, 0,
 					TBNET_RX_PAGE_SIZE, DMA_FROM_DEVICE);
 		if (dma_mapping_error(dma_dev, dma_addr)) {
+			__free_pages(tf->page, TBNET_RX_PAGE_ORDER);
+			tf->page = NULL;
 			ret = -ENOMEM;
-			goto err_free;
+			break;
 		}
 
 		tf->frame.buffer_phy = dma_addr;
@@ -546,10 +548,6 @@ static int tbnet_alloc_rx_buffers(struct tbnet *net, unsigned int nbuffers)
 	}
 
 	tb_ring_notify(ring->ring);
-	return 0;
-
-err_free:
-	tbnet_free_buffers(ring);
 	return ret;
 }
 
@@ -678,7 +676,7 @@ static void tbnet_connected_work(struct work_struct *work)
 
 	ret = tbnet_alloc_tx_buffers(net);
 	if (ret)
-		goto err_free_rx_buffers;
+		goto err_stop_rings;
 
 	ret = tb_xdomain_enable_paths(net->xd, net->local_transmit_path,
 				      net->tx_ring.ring->hop,
@@ -686,7 +684,7 @@ static void tbnet_connected_work(struct work_struct *work)
 				      net->rx_ring.ring->hop);
 	if (ret) {
 		netdev_err(net->dev, "failed to enable DMA paths\n");
-		goto err_free_tx_buffers;
+		goto err_stop_rings;
 	}
 
 	netif_carrier_on(net->dev);
@@ -695,13 +693,11 @@ static void tbnet_connected_work(struct work_struct *work)
 	netdev_dbg(net->dev, "network traffic started\n");
 	return;
 
-err_free_tx_buffers:
-	tbnet_free_buffers(&net->tx_ring);
-err_free_rx_buffers:
-	tbnet_free_buffers(&net->rx_ring);
 err_stop_rings:
 	tb_ring_stop(net->rx_ring.ring);
 	tb_ring_stop(net->tx_ring.ring);
+	tbnet_free_buffers(&net->rx_ring);
+	tbnet_free_buffers(&net->tx_ring);
 	tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
 	tbnet_connect_failed(net);
 }
@@ -826,9 +822,13 @@ static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
 static int tbnet_poll(struct napi_struct *napi, int budget)
 {
 	struct tbnet *net = container_of(napi, struct tbnet, napi);
-	unsigned int cleaned_count = tbnet_available_buffers(&net->rx_ring);
 	struct device *dma_dev = tb_ring_dma_device(net->rx_ring.ring);
-	unsigned int rx_packets = 0;
+	unsigned int cleaned_count, rx_packets = 0;
+	bool no_buffers = false;
+
+	/* Buffers a previous run was not able to return to the ring */
+	cleaned_count = tb_ring_size(net->rx_ring.ring) -
+			tbnet_available_buffers(&net->rx_ring);
 
 	while (rx_packets < budget) {
 		const struct thunderbolt_ip_frame_header *hdr;
@@ -845,8 +845,14 @@ static int tbnet_poll(struct napi_struct *napi, int budget)
 		 * time.
 		 */
 		if (cleaned_count >= MAX_SKB_FRAGS) {
-			tbnet_alloc_rx_buffers(net, cleaned_count);
+			int ret;
+
+			ret = tbnet_alloc_rx_buffers(net, cleaned_count);
 			cleaned_count = 0;
+			if (ret) {
+				no_buffers = true;
+				break;
+			}
 		}
 
 		frame = tb_ring_poll(net->rx_ring.ring);
@@ -917,12 +923,19 @@ static int tbnet_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	if (cleaned_count)
-		tbnet_alloc_rx_buffers(net, cleaned_count);
+	if (cleaned_count && tbnet_alloc_rx_buffers(net, cleaned_count))
+		no_buffers = true;
 
 	if (rx_packets >= budget)
 		return budget;
 
+	/*
+	 * We were not able to fill the RX ring for more buffers on this
+	 * run. Keep the polling enabled to retry the allocation.
+	 */
+	if (no_buffers && !tbnet_available_buffers(&net->rx_ring))
+		return budget;
+
 	napi_complete_done(napi, rx_packets);
 	/* Re-enable the ring interrupt */
 	tb_ring_poll_complete(net->rx_ring.ring);
-- 
2.50.1

