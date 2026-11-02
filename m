Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623813;
	b=NbQXeYJGii+tGQkkWeAxcGh8gqwlw8REZvyjd/rjb5sSSyP4Zo2C1VjzdC14fQvwQSoV
	 JTfk7K7Los7lzM+yBfYWBwzWcjlbxosy3Ad//xEUDh5Bzn/Lz4K2YrlQyF29K6V0sHcNX
	 yPEy0R5P8aVKSvqs6hlbOsOARRtLQ0yYXDuLbCC8FPW4VJKVEdvWqK6QmlFikzhNBvM/R
	 6aAGiWu28YXPwDagANZWS2VMhLVE7k7ThHX5k/FGniN9Sx6f4w89SYe3ivhLFtk1OKRLO
	 btCPDbiniFo9oH3vgAhqFaKSMqO0Xyx97Aq+Qv5MgCYW0c4rNq0uifr6TTWtHUQCyZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623813;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vc0WEbP/1LzS6rVeclqxFTWZzre9KhjfMN8KPceuG/4=;
	b=rZsZ31gDTYWxRxtIegs8lQ5UKmuuv0xMnGw0DQH2yAk0MjLtaQ2fZUJWbtySL9IT4Huz
	 h1xFgl15b2xEa/cUAypBvxm2JleaN14w2VRhpoyBzXmA/gKDtu9H9Fk0Iseuw+yB8Cb4/
	 TJtqeRqvqkM497ZLwc0YL9TqlTX9V7siiSbuAcDxbKnXyMuqDepp0WO2JP12hCtBW0baw
	 DNhfQuB/kgoTYCX28qzaKjE+iE0Xf9Mp8AyPUgrsUM+CGDKXGIqqOda+UeR/b/A0peKG6
	 H1hkcyY6FahjJayb5kkCVW+y5iIec2Gi22l7YG4ThnjZW0JpQvN6r4jyBY5CPoAle7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YjF9Kujd;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF560A2616
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21FF560A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YjF9Kujd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793623813; x=1825159813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DBN8CqgY90G0pDKszzLHWtKOhW3gliAlJDxb6if+R/I=;
  b=YjF9KujdVeo4JbtUDDcKDTbBwrhAiGJOUFqQCoGvLxZzLN2Tb/BxmnNB
   tiQ+5+Gpr6cViCEz5kCU9Up3m9mFKI4Rxj/iyV/gDUkpyUW2RcDBcMe1B
   3U9NZmMKBmUfUQI7RaDq6HVZWL1B36ojN0DeoysRCPELExP+fHR89w06v
   1HVBKaF5U2yjwKWyyxEe7MDWis5sEttZxmfLgfyhG0lS895tGi9d7QV5d
   SjN2hdVXyx+50kzZap9cY2R7O6mvLHTdSYp0ZpcUwjs/dPD4ctckVmwIU
   Qf26DE5/Ccyx/GS8EMnEPOLSTVlbbcwFEkyB73rAL3lTbCfQ9fhLy9Yo1
   g==;
X-CSE-ConnectionGUID: WWfsA+DVSvCMOiLJc9NXyQ==
X-CSE-MsgGUID: MAFVr80jRqCbBix+c1fvZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191865"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191865"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:50:13 -0800
X-CSE-ConnectionGUID: B22WpFLvQNK/VUdAj8BrJA==
X-CSE-MsgGUID: lV5RynutR5iRNdhEoE0LGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7928485"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 04:50:11 -0800
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
Subject: [PATCH net 5/9] libeth: xsk: do not free in-flight frags on XDP_TX completion
Date: Mon,  2 Nov 2026 13:49:46 +0100
Message-Id: <20261102124950.958345-6-maciej.fijalkowski@intel.com>
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

libeth_xsk_tx_queue_bulk() takes the frags of a multi-buffer frame off
pool->xskb_list but leaves XDP_FLAGS_HAS_FRAGS set on the head. When
the head completes, libeth_xsk_buff_free_slow() frees whatever is on
the list at that point.

The XDPSQ can be completed by a bulk flush while the frags of a frame
are being queued, or by its cleanup timer while a partial Rx frame is
stashed. Those frags are then freed while in use, and the frame being
queued is sent truncated.

Clear the flag on the head once all of its frags are queued.

Fixes: b3ad8450b4dc ("libeth: xsk: add XSk XDP_TX sending helpers")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/libeth/xsk.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index a452b7828ce4..249b1c740788 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -77,11 +77,17 @@ libeth_xsk_tx_queue_bulk(struct libeth_xdp_tx_bulk *bq,
 	if (!libeth_xsk_tx_queue_head(bq, xdp))
 		goto out;
 
-	for (const struct libeth_xdp_buff *head = xdp; ; ) {
+	for (struct libeth_xdp_buff *head = xdp; ; ) {
 		xdp = container_of(xsk_buff_get_frag(&head->base),
 				   typeof(*xdp), base);
-		if (!xdp)
+		if (!xdp) {
+			/* Each frag is now freed via its own SQE. Freeing
+			 * the head must not release what is on the pool's
+			 * frag list at that time.
+			 */
+			xdp_buff_clear_frags_flag(&head->base);
 			break;
+		}
 
 		if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
 		    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_XSK))) {
-- 
2.43.0

