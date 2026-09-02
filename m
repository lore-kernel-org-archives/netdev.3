Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D53A05C2;
	Wed,  2 Sep 2026 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337295; cv=none; b=Hnjp67lI+dKdZHmpg2QHALLigjALiWTdwgq500HBoCr0idKZGMrA3b9u57wrbj8X3hxsG9/b2PyWjVFl3q0YHUmVd6bUryxbJPzWmUcV2LIGpLfYH2/z4d6/MNXnkfwQ+zrjzL2z1csync43MITmzL2hP4hMt7BzQ46O24uO7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337295; c=relaxed/simple;
	bh=R3X8O2fdRR7eWuffHh+Aj/T9P5jV1Jyou6Qg0dLg66Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdBWitIGgpjl5DJCfoIrK+29TzNCZm5Tv6RPtf5DJIHlkJE3LAvRoVJMxv8ZKcr2740cLr28WIoHJPn2RKM0Bddjeklqm7z/LTD+7A+nl1OP71OgjSQo7ob6l8p9z+W0HWbr2lsjpAaqiy5BW43jPwHtrOoh/r2/Xf2gJQ/K4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lfc66Aah; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lfc66Aah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788337294; x=1819873294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3X8O2fdRR7eWuffHh+Aj/T9P5jV1Jyou6Qg0dLg66Q=;
  b=Lfc66Aah93Dx14FelNl9DHaeKSEbxRSyCt80sY8WdGgTv0LsadDR1TWN
   BBiAEJCcT3pCwVRCoH7DxYQ91SPHX0aPDjPB92VGax9Div5rmuHfKF251
   iFjaCWtWwcGt0vspwiLTdZsHFMrPOgYL5ZoD4D6ui4Q1ZCJ/2GOzHo0l0
   2L/j4mfC9gWxWww8gR9pCM/zTlGrg4D7WZuhc6JaKiiuPhaJPw4Ez3kbm
   9lsMFJOH3QdosBI2a1S7bHlrBbcU7ZyZpratedxkDRPl06WDEcdpxeH/s
   1pS01C9WrOgJbA/HJp6jTueCWREDeE4UbGz8HbvGzjj7ZpMlJqbL9yTJ/
   g==;
X-CSE-ConnectionGUID: TyblbzMjRPa1p1b0c1RXPA==
X-CSE-MsgGUID: FQYOJeBUT9KKSXeDPjeQ9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88664298"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88664298"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 01:21:32 -0700
X-CSE-ConnectionGUID: oU/J8xF4QGCcaJiYd5tBWA==
X-CSE-MsgGUID: OfZ2gXcWTy6Xuv8awQ9vXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="273521569"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 02 Sep 2026 01:21:29 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 278929D; Wed, 02 Sep 2026 10:21:28 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] net: thunderbolt: Update ring indices only after all frames are queued
Date: Wed,  2 Sep 2026 10:21:28 +0200
Message-ID: <20260902082128.1148463-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260902082128.1148463-1-mika.westerberg@linux.intel.com>
References: <20260902082128.1148463-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take advantage of the new API and update the ring producer/consumer
indices only after the frames have been queued. This reduces the number
of doorbell register writes from one per frame to one per batch.

Measured using iperf3 over a Thunderbolt/USB4 net connection between
Arrow Lake and Panther Lake systems (average of three runs):

  before         after
  ~14.3 Gbit/s   ~15.3 Gbit/s

Assisted-by: LLM
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index d9fb587a62c5..cf51b9c39f4e 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -540,11 +540,12 @@ static int tbnet_alloc_rx_buffers(struct tbnet *net, unsigned int nbuffers)
 		trace_tbnet_alloc_rx_frame(index, tf->page, dma_addr,
 					   DMA_FROM_DEVICE);
 
-		tb_ring_rx(ring->ring, &tf->frame);
+		tb_ring_rx_more(ring->ring, &tf->frame);
 
 		ring->prod++;
 	}
 
+	tb_ring_notify(ring->ring);
 	return 0;
 
 err_free:
@@ -1243,7 +1244,8 @@ static netdev_tx_t tbnet_start_xmit(struct sk_buff *skb,
 		goto err_drop;
 
 	for (i = 0; i < frame_index + 1; i++)
-		tb_ring_tx(net->tx_ring.ring, &frames[i]->frame);
+		tb_ring_tx_more(net->tx_ring.ring, &frames[i]->frame);
+	tb_ring_notify(net->tx_ring.ring);
 
 	if (net->svc->prtcstns & TBNET_MATCH_FRAGS_ID)
 		atomic_inc(&net->frame_id);
-- 
2.50.1

