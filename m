Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623812;
	b=b4+zMI0783KUxBQ106rNXTC9aNI80WQ60yFSpfuUIGkzcpsvo3TYELCR8dHY4yU8LDJN
	 YxfncrOKBejcW+C3W8Is9N7Hw70GtnSynr8it6qi3nJjmCdRoy5yKlx+XP650LPfXpNzd
	 YOwllx9dKVDAflEqljWHESDbwAecl5GOPSK/xv48i/USV3olflyr/y4kyQUj6DnYRBsOt
	 ZAZ2D8aPpLoLS2bXu2Zpo4kDCwxX+OHMb6FSb3Hihub9D1B3o+XVq8mM/+ChNoxfHc3hf
	 mcNUVOgV9vbhrWgClrGQHgSAcPJU/nDpT+1v2F5K71nhxSWe5GnmjRdpNAvdVME9f0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623812;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wL2ypXM7U7jDidZXETRovycmTg9tb2+4IQCQVBmHczQ=;
	b=1KQ6qd8akJoF20SXwTNGrhbA4bK19jRWGkeFPFl5XzY3JkUZh/S7Rsm+E+PWDp08GVOj
	 9x2aXX8q9F5yTyKorRLl0TSbnho3E+6w72Mb0jy4m3ujDfZM57DzV0TAOagVjoIrPcMZi
	 EsxKlkEIUScb38chR3JFDanmlpyJCL6GKkP0ZCps9q6XeDSzLKOC4KIhJqJ4rZSGeQAn4
	 AoNc7isNIIQCyga75Py6TjAulqf4Tk++6V+7ltKYNZcA5Wp6qd0N0M3LA7bLrz/L/02/X
	 96Z+ZBe1jzLpGG8zY0g+EZmLVPYNL6OFqUGopKExcDZFG9EdFX/VxAon8X2hHVyecNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nrIvL71U;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F2606A334
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA6F2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nrIvL71U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793623811; x=1825159811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Ool9WUNJhuEpKceKvvePJstHdedIO+Jhn2SBI3aNnA=;
  b=nrIvL71U+o7Qwnm6DRy2maOyTMrXIa0UsilvljGyAQZ3vhHqxTO7D9UV
   Z8YNbGq1nwiSnTnL6bQzxCKQ5zxTq9gPO9GUTahmicJI1UKFedTdDgulJ
   51QLkfB7w4l57vgzEgTjo5sDlSbQst1mtU8OCc8X7KtLPHJwWk/tqYtiT
   ASHAu6wRevxQzUXdE2bAgZGsSnqKgipaDRW7AxWnYBuoJl2LDu2i2yBgU
   Ym9p5p4Od3uD3yfrn7MjHvWKrSIxexHsaY5zrnaI+7m6OYhKiPVy/qyZ6
   9ARj9TQdlRQGqkCGZH55xvwcMXZEWhF/FNotEOETtakXjyM3ZLTT6N7yl
   A==;
X-CSE-ConnectionGUID: m82M6TOhQ7Wf7Lhy9n6CjQ==
X-CSE-MsgGUID: tH8QBUWzSk+p1IhRiF9b7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191859"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191859"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:50:11 -0800
X-CSE-ConnectionGUID: t4qAZCwPRBmMLqQ2XIngBw==
X-CSE-MsgGUID: +EWtg7vZRSSSNZCc/9z+7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7928479"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 04:50:09 -0800
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
Subject: [PATCH net 4/9] ice: xsk: do not free in-flight frags on XDP_TX completion
Date: Mon,  2 Nov 2026 13:49:45 +0100
Message-Id: <20261102124950.958345-5-maciej.fijalkowski@intel.com>
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

ice_xmit_xdp_tx_zc() takes the frags of a multi-buffer frame off
pool->xskb_list but leaves XDP_FLAGS_HAS_FRAGS set on the head. When
the head completes, xsk_buff_free() frees whatever is on the list at
that point, which are the frags of a frame still being received.

If ice_xmit_xdp_tx_zc() completes such a head while cleaning the ring
before sending another frame, xsk_buff_get_frag() returns NULL and
xsk_buff_xdp_get_dma() dereferences it.

Clear the flag on the head once its frags are on the ring. As
xdp_get_buff_len() then covers only the head, count Rx bytes before
running the XDP program, like libeth does.

Fixes: eeb2b5381038 ("ice: xsk: Tx multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index ea8ac0fcdf6e..bf14ed8f87a3 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -493,6 +493,11 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
 	tx_desc->cmd_type_offset_bsz |=
 		cpu_to_le64(ICE_TX_DESC_CMD_EOP << ICE_TXD_QW1_CMD_S);
 
+	/* Each frag is now freed via its own Tx buffer. Completing the head
+	 * must not release what is on the pool's frag list at that time.
+	 */
+	xdp_buff_clear_frags_flag(head);
+
 	return ICE_XDP_TX;
 
 busy:
@@ -592,6 +597,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		struct sk_buff *skb;
 		u16 stat_err_bits;
 		u16 vlan_tci;
+		u32 xdp_len;
 
 		rx_desc = ICE_RX_DESC(rx_ring, ntc);
 
@@ -634,6 +640,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 
 		((struct libeth_xdp_buff *)first)->desc = rx_desc;
 
+		xdp_len = xdp_get_buff_len(first);
 		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring,
 					 xsk_pool);
 		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
@@ -648,7 +655,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 			goto construct_skb;
 		}
 
-		total_rx_bytes += xdp_get_buff_len(first);
+		total_rx_bytes += xdp_len;
 		total_rx_packets++;
 
 		first = NULL;
-- 
2.43.0

