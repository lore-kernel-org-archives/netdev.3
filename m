Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345043B6CB
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143799; cv=none; b=KMV5j/Jz5ogt6jhKCHQrT9d7xcUOqrsLVvRt8O949a50qndNB4kPAesrlSWggwDGg1rYs7safmN09fw1eKVlJi273A1YSpmIk7sD97CyFtXJQDPhVohE+uACd+7OS7s2dLVUfWzSHkQt1XhTZu/4oG6mJE16CKAj70Ho+F44Hfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143799; c=relaxed/simple;
	bh=YyTzn6ek5qXEnmUuD30Tnu8qQyVMMw+tK6ncWRzZV14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMy0RTjnC0CSEJ8whP2VbbzFNgcs8fkDo+dKho5cWX1YkpNA/iXF7OTbUG6hQry8qTm7NV2eDNZyN13+df/5LhPA/qnElwySrAvH13g9pMfGBW4xGp0ujFMTye8yH6I2vev+Q9XwZZmjdYo5xbvknADqcSrWpTzD9xXjg+J8T9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2avaNkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2avaNkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4AB1F000C5;
	Fri, 16 Oct 2026 09:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143797;
	bh=8ApGlbv1yO5tmmZOTA7DnXv6Lcy2I+cKRyP4UlT0qV8=;
	h=From:To:Cc:Subject:Date;
	b=g2avaNkwj4k4IjRZ/fUMVHzwWrzSXJUZwc15+MTF7o+4jiVGVWc8VKqXxpb5YU9Kv
	 R2+uW4gGCYVwK/C+qCG2mZNOGhP/Edm8auJ4lAmSqG/Kbq+6nChz8UEYSXL/u9pSUG
	 U4sIhlY0tU1m+dAfijPSGKSMNpR810/mRQLt0P8R0gMwpSHGdcqmDeXorP5QLJOVLr
	 qml4qzy7JxkkBQOqJCH1nvUqZnX0MCqDqFAknSq1BGM1hUM2AL/+IBEtj1HpLviAV+
	 N8wAIAOIEgqmkXfPrH+hA4RSrUaVihYhwqbf/hH/uFnhCt6jXkAb0xnEM/rs49MdIU
	 QMeQpThZKVFKA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next] fm10k: use skb_put_padto()
Date: Fri, 16 Oct 2026 11:43:12 +0200
Message-ID: <20261016094312.2759956-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded skb_pad() + __skb_put() sequence
in fm10k_xmit_frame() with skb_put_padto().

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
Part of a medium term plan to get rid of skb_pad(), source of many mistakes.

 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index c86701be4364aeae2831d8551b0012ab27b4bfa7..669a02c6415c65a37e43cb283cc24f57b31dd770 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -561,13 +561,8 @@ static netdev_tx_t fm10k_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 	/* The minimum packet size for a single buffer is 17B so pad the skb
 	 * in order to meet this minimum size requirement.
 	 */
-	if (unlikely(skb->len < 17)) {
-		int pad_len = 17 - skb->len;
-
-		if (skb_pad(skb, pad_len))
-			return NETDEV_TX_OK;
-		__skb_put(skb, pad_len);
-	}
+	if (skb_put_padto(skb, 17))
+		return NETDEV_TX_OK;
 
 	if (r_idx >= num_tx_queues)
 		r_idx %= num_tx_queues;
-- 
2.53.0

