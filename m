Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576603793A9
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869062; cv=none; b=bvhjor6rr2OmKY0+HHxcGf8TIrT9jIlnayCe6IEVN7AAevNY8Y0/5SlZsthSPBTR56kjU4SWWrkMCdktjUvZJev6kaK663Z+4sx7SjiH8DAgC/QHWav/6pZmv6HMTg4gm+vR8pyIq61HBpanRzojgscE+0lrSNu50aUBc2wqwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869062; c=relaxed/simple;
	bh=WpVSKU5AYUdlGh/JmWIkDRS+XWke55vTL36de5TGti4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OboI7iGwQQhJ1fxWmg3drGfAq+lshX02/C+g9p7HWgc9Cgy+6kx9JXmYCCg0fVdbgrTC7WwWSxlgaUzkWCoGmKGksSXeTKBhjIT75+IMu+ZQp5DHLxwdCSRf0y95cG5SOdh4INhncGpcg0e7HWVmsYxR0Y17GVVdwPIO6nMC4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7bGjU+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7bGjU+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0261F00A3D;
	Fri, 19 Jun 2026 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781869061;
	bh=5YSFkwBdwIZvGA3XLMEJv/9BLBx9P14qbmrv7iQoAww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b7bGjU+U38EIWEfujwNOg+vifivWQzXRPCkAvvF+6b+SHVBYhnFkc16N7UucBuwzW
	 Fe0ijn4s/ibPDBOAZdRvnjG/t/LJ2wSnPTybsR/OElf8k9TpqHUj8MB6q3/gqOybPA
	 HRJgOhxhGWkiRHFKw9ts6k3h3RDBJ7hJCsk4qvRYEnj8DqlkRzFmBMSSeoZmvKBDfG
	 qFJwGTSZ6T/BzSAbLBY/vFHP4+0m4sMVeHYHqK5G7p9QroKW6rMzgwcnd2d0cjKzwI
	 MLLe8p1YGJE40jqcGNn3DlTb/eOIIaiA/YWYH1mTGHPk8eekZdWXhqJgfEg+QPiMQ2
	 zEcBp6goQaFaA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 19 Jun 2026 13:37:13 +0200
Subject: [PATCH net v2 1/2] net: airoha: Fix off-by-one in
 airoha_tc_remove_htb_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-airoha-qos-fixes-v2-1-5c43485038f9@kernel.org>
References: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
In-Reply-To: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Wayen Yan <win847@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.3

airoha_tc_htb_alloc_leaf_queue() computes the HTB QoS channel index
as opt->classid % AIROHA_NUM_QOS_CHANNELS and stores it in qos_sq_bmap.
However, airoha_tc_remove_htb_queue() clears the HTB configuration
using queue + 1 as the channel index, causing an off-by-one error.
Use queue directly as the QoS channel index to match the allocation
logic.

Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
Reviewed-by: Simon Horman <horms@kernel.org>
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

