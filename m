Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD146AA81
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143324; cv=none; b=c4v+EoiR5EpTT/mfkS0PmNWUyucCxiGNbXq5FDvtSaX5C5w3X1e5RrSxDf6mG+1YhMKDmveFh1o4FDxnYEWGd7EK96u4l85UEBkyAhHzDC9bgubZqJpHbK8ulfgjVwbSw04AvSyBf6608wCNJLvqwvbyfjT25ibwDv5+PT4vM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143324; c=relaxed/simple;
	bh=mVDiciemjnXwjzo7gJdwCll0llvuA4nn3LCEv+ITtrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8ZgpdIOn+URaEfZjsxG1SfCNKOgcjr1SOZlK6H14GgUXYGtnKPf9nfQ12zWHfFIPCfz2FKlVH8sA93vxM3EJhyCbxLyz0jhIoeTkUTNaOb7T2pnTfwsHcmqbsBmoLariQK1I3+3zD+ZRDvjuVeQHMZPelF82sRGj3hXZesk0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzpFWJEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzpFWJEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7D71F000C8;
	Fri, 16 Oct 2026 09:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143323;
	bh=Wj1yakcgv8iYwBumxLsYvWb/OoGgD8gf6KIlwSwV0T0=;
	h=From:To:Cc:Subject:Date;
	b=jzpFWJEbDQ0dPVmyJ4qV3UHEbl8vSSEAlgpYfb7Zv+lEA+GeQoUD+MX4cMpNrbObY
	 snkWeejtDcZ7gcaAX49QjMWHZmx7UAPdlsQGI7s7Tw550kTTDO5d6B0Zdn+eFcGySr
	 QJafCdiCvrkNbX0RwcyyhyVG2Yo9HWe/paZDYIM3He1drY2Ln4RaMnQOifryy/plTv
	 ENnus2C8NLbJKGLlWwbsBhzwyhDavSYGJqYokx2Fr+6H0sQlH13Lp+l0Pq8qIjlYj9
	 74yeO+N3uejVfA8cYCpAiv0otuPxU1IMlG/KIbFEVp1BvRdRRn3Go6pnio3iUE1nc/
	 1bAopeS74tUyw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next] hinic: use skb_put_padto()
Date: Fri, 16 Oct 2026 11:35:18 +0200
Message-ID: <20261016093518.2756935-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hinic_xmit_frame() pads short frames with skb_pad(), then
sets skb->len directly, leaving skb->tail stale.

Use skb_put_padto(), which updates both and is a litle less confusing.

Also remove one pointless netdev_err() call.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Cai Huoqing <cai.huoqing@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
Part of a medium plan to get rid of skb_pad(), source of many mistakes.

 drivers/net/ethernet/huawei/hinic/hinic_tx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index 9b60966736db537ae87e2871a977975c4c6b919d..899d103f24803b3731240f5982c9545c2e390b38 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -563,14 +563,8 @@ netdev_tx_t hinic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	txq = &nic_dev->txqs[q_id];
 	qp = container_of(txq->sq, struct hinic_qp, sq);
 
-	if (skb->len < MIN_SKB_LEN) {
-		if (skb_pad(skb, MIN_SKB_LEN - skb->len)) {
-			netdev_err(netdev, "Failed to pad skb\n");
-			goto update_error_stats;
-		}
-
-		skb->len = MIN_SKB_LEN;
-	}
+	if (skb_put_padto(skb, MIN_SKB_LEN))
+		goto update_error_stats;
 
 	nr_sges = skb_shinfo(skb)->nr_frags + 1;
 	if (nr_sges > 17) {
-- 
2.53.0

