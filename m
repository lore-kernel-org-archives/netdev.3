Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFD134CCF
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762457; cv=none; b=VgkUfpJn3hQkLquMWgw1EpbjyVgZwft2l+BoEbZoHHOMNQoaFDs/LjMHvuuDlnMaVWL6NxjIZe3QxWAivAnSV/sqkes7TiFq0SBDzkZZIux98LBROoT3SaRujCuXfGFCg62zLnUJH5OlldjfLmnFy6W8aOcUZRFGMsQ7tkwxHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762457; c=relaxed/simple;
	bh=6oO+TU3vfyQnpts6aO+fsUIMVfk8yZ5SbUi3Z/7j6oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/A6lZNzHJBFeRHLLAsotz/xivictQ8DXLxM8KJ4O7P1FTOV7/10g4LtWRKpt2nDlTp/rpTpeuu6tfu7/9qPANWWqGKQwaQzNBIzciC/dTTx0v1uKJGyhSdJmSmJNyb/fyJ71bDZE/HCsQjQDJLfG0CZ0Nq9lZGDvoI9z1ZKUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Meegnm5e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Meegnm5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF0E1F000E9;
	Thu, 18 Jun 2026 06:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781762456;
	bh=nYloxdgygYkPA7nL3juFbK1wjjU26h+FbB0DnjN9yBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Meegnm5efee4PPsRHuUQRJo90vS6LuzcUOpQeQzkvlPhRfz/5bU5JA9upWJvwCEAb
	 wXR7D7m7jq3zFDL293+KxJqcNvoDj1gV7TlbAETHh1WC7bRoCza4C5jma0GkXk8zOs
	 FJVlPONeENnjHgyGAtl4mX63Cp57h0lm5esW1FH19KZp6KaTPBf632IyqHvMnprrrb
	 Qb0SYJ4b+3p2SrnsB8X97+12B0ijqn3LT64wGGp6D/n0TW3bI+FIvjn8x7QJ5DLvQl
	 uw/rO8DokZnMz4lqhXjbg8BfRl1jThtQvDwvjLcuC1450o5qMlbKzCFh/d6HKfxOVW
	 u4audTANr63iA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 18 Jun 2026 08:00:29 +0200
Subject: [PATCH net 1/2] net: airoha: Fix off-by-one in
 airoha_tc_remove_htb_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-airoha-qos-fixes-v1-1-37192652157f@kernel.org>
References: <20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org>
In-Reply-To: <20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

airoha_tc_htb_alloc_leaf_queue() computes the HTB QoS channel index
as opt->classid % AIROHA_NUM_QOS_CHANNELS and stores it in qos_sq_bmap.
However, airoha_tc_remove_htb_queue() clears the HTB configuration
using queue + 1 as the channel index, causing an off-by-one error.
Use queue directly as the QoS channel index to match the allocation
logic.

Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64dde6464f3f..aa98d1823ab6 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3006,7 +3006,7 @@ static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
 	struct airoha_qdma *qdma = dev->qdma;
 
 	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
-	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
+	airoha_qdma_set_tx_rate_limit(netdev, queue, 0, 0);
 
 	clear_bit(queue, qdma->qos_channel_map);
 	clear_bit(queue, dev->qos_sq_bmap);

-- 
2.54.0

