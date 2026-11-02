Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623807;
	b=JNRAIT7atQFGlMDNPeIxJsAwGWujOZjk0m1MNAI78kxr/ryA7SoytRkPpMH2ksk3e5Uu
	 QqgfbeG7GjI4TTt74hsAXYcCWeFEMCsi1wLIyLgbpsFpv/Cbbh5HO+j94ZHUt+UkWKItc
	 J+zExOKhV0uRmDY5NXMaJ87PoZU68zH1IHcnahQDD2wpSzCM6fZmkgFIhFSgs2U72rW8j
	 dOrPDnK5nMMJzHd+RtS4jbaXOGFfFHZshWTKLi3IVwrGS5wCGnCuldrBexCFzZEcVCUrZ
	 ITaiWzdBRuqPQV3hu8VA0FLhEUJ9EifD1itjZQRROrsx24xAqGLD5nKeFlmcrtfViNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623807;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TaLXpRiiAqQvussAdJ0W57PubYGFD/fOjHKHTXr2nsA=;
	b=etUubaLjvTuPmsFf5ivurL3elhNyHd0Cx2+8kYTH76QYCld4oYCS+ywYGv6O+BHWS8fh
	 i4Cbxnth6xL6uZJQmmTLs+lPnRZibdbCLKvPUSlwLkP79JAAcT2svoKnKYhpAi0sWa2n4
	 pbUjmMCRkNmWts9Ww68+/5vfNgZSwCHeucG8DP7jEMcDE+A0SzJwp0ARkS78FpM4Ar/sT
	 2SkKphX3W4/LqN3n3K+wV7sbHhmvbB2NLJErk8kwmXCU5gmTs6K6cfdzWby+LV8m1zzj4
	 K0LNC1YMIJHNtzpoGsJtidvKoq6qNhkoqqiO8rbZA+Re8Tr4F983t7NUyNKOiMKS42g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="K+I10/m4";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF60606A332
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF60606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K+I10/m4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793623806; x=1825159806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iYTpDMA821YLH+wqX2htnyg78liIcEFPiYMMZcdASl0=;
  b=K+I10/m4C8AC0IatdFNmjQC9wIjt+a83tuJTcOj1W6jkPWP2iMNoRrp1
   17RkuVy3Pmx6Qog1fP1599l6hAMbgxKPzhVP3e7FTb0SMqHzh2GsCk5Im
   6Z5JArkG+9SAJNyjlGSaqgxnOIIEppftKBX0uWMuPeb0m7kd0I9+H7Vzo
   2m2cZTBSXzuIOaart31T28lyOLgF4Lv6YFSPHroF2OR9ngbipqr+OrugY
   hkpY4/Gr3eVi7Tha7/uUklaczMZl5/KTjPLgt2afCfvwS0+SHSviTH8ua
   OdIhU1WYefXXEJqbVvA3/8TTxVikr5mIDjUK2ztp6pdedxzcGzBx4YatM
   w==;
X-CSE-ConnectionGUID: YrKckiMrT+SSzlsLyMJdjA==
X-CSE-MsgGUID: +fGuRV70SVa/vXg3OBXVBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191828"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191828"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:50:06 -0800
X-CSE-ConnectionGUID: wMEIlxuIRdyDcz5x0LOiEA==
X-CSE-MsgGUID: FtS0VQlcSUmNQob0vdsO1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7928457"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 04:50:05 -0800
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
Subject: [PATCH net 2/9] i40e: xsk: fix xsk_buff_add_frag() error handling in Rx
Date: Mon,  2 Nov 2026 13:49:43 +0100
Message-Id: <20261102124950.958345-3-maciej.fijalkowski@intel.com>
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

When xsk_buff_add_frag() fails, i40e_clean_rx_irq_zc() frees the frame
but stays on the current descriptor, so the next poll restarts from the
freed head. If the frags array was full, the retry passes on a frame
missing the freed frags, with its head already on the free list. If the
buffer is a duplicate, every poll fails the same way and the queue
stalls.

Free the current buffer along with the frame and move on to the next
descriptor, as ice does. The rest of the dropped frame is received as
a new frame. xp_free() skips a duplicate already freed with the frame.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 51a05ce4c7ce..e6ae4c7a5cb3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -469,16 +469,24 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		xsk_buff_set_size(bi, size);
 		xsk_buff_dma_sync_for_cpu(bi);
 
-		if (!first)
+		if (++next_to_process == count)
+			next_to_process = 0;
+
+		if (!first) {
 			first = bi;
-		else if (!xsk_buff_add_frag(first, bi)) {
+		} else if (!xsk_buff_add_frag(first, bi)) {
+			/* Drop what has been gathered so far. xp_free() skips
+			 * @bi if it duplicates a buffer that is already on a
+			 * pool list. Remaining buffers of this packet, if any,
+			 * will be processed as a new packet.
+			 */
 			xsk_buff_free(first);
-			break;
+			xsk_buff_free(bi);
+			next_to_clean = next_to_process;
+			first = NULL;
+			continue;
 		}
 
-		if (++next_to_process == count)
-			next_to_process = 0;
-
 		if (i40e_is_non_eop(rx_ring, rx_desc))
 			continue;
 
-- 
2.43.0

