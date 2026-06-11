Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EDD242D67
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177648; cv=none; b=hEo3jIFHPcUwDaWRG5oPOWD2rM+6xG/ib8c6yPYS+qgF7bZRonPwBjlaYDwW7Fsjn45Xvc26G0yN4r9MO98aEXY+j5tyEWni1FqYlQUTY9cv0IuDF20cT8mahVkF309pQMc3oSpQSDhdqQUSIJ0DVJ/AXuVgqPeodnaF5NtCn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177648; c=relaxed/simple;
	bh=kWWkiFYHvJ96M7uzdCoBKIdODP6dYm/UhYjrtgcq2ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=IGTgp+y63mkgWSr3+QVQzL3CGeZ687Mq5GvHHBLc6MtX5U+Fo5omuk7YHuhq42+rqPKkDXuuYda0WX5zB86Y27z1/G+xLUlqm397dxQIVhokSYZT+G7cRpJhxlWk8b5i632GGZSOx3wXGJSjbjMOJcccQ8q/1lOEqfH1TSqev8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hs1iC8+b; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hs1iC8+b"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260611113405euoutp025b4a5552f0e900d31466270b0600f15c~4A6GXCL8-1020010200euoutp02E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:34:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260611113405euoutp025b4a5552f0e900d31466270b0600f15c~4A6GXCL8-1020010200euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781177645;
	bh=aiWNA2XcQ9MIGpb5iKT0AZ6heJ1aLAPFSuWzw5lWfBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hs1iC8+bqurdiMo/Cnpg9tlui3TVPRRe6dzepPnEcM8ZoHBcadWG/UAvWTFmWQsDT
	 bQqV48UI6it831kNnUvYDFHPHTozVPlq6J6sTrUYE4hIDtQoUW+i+xSeZVXhxxfXNo
	 LhNKjrCluhxgVIGWul3JGIvj+VmXre32GFSxsRsM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260611113404eucas1p1ae62c08edaca2d98535c39c59faea923~4A6F-FrlA0882108821eucas1p1u;
	Thu, 11 Jun 2026 11:34:04 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260611113403eusmtip20658597299be23109b0b32fcf53ad27d~4A6E9bI9t0415604156eusmtip2B;
	Thu, 11 Jun 2026 11:34:03 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, k.domagalski@samsung.com,
	k.tegowski@samsung.com, Jakub Raczynski <j.raczynski@samsung.com>, Chang-Sub
	Lee <cs0617.lee@samsung.com>
Subject: [PATCH net 1/2] net/stmmac: Apply TBS config only to used queues
Date: Thu, 11 Jun 2026 13:33:57 +0200
Message-Id: <20260611113358.3379518-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611113358.3379518-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260611113404eucas1p1ae62c08edaca2d98535c39c59faea923
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260611113404eucas1p1ae62c08edaca2d98535c39c59faea923
X-EPHeader: CA
X-CMS-RootMailID: 20260611113404eucas1p1ae62c08edaca2d98535c39c59faea923
References: <20260611113358.3379518-1-j.raczynski@samsung.com>
	<CGME20260611113404eucas1p1ae62c08edaca2d98535c39c59faea923@eucas1p1.samsung.com>

While opening stmmac driver, there is enabling of TBS (Time-Based Scheduling)
option in dma config. Currently this is executed for all possible TX queues via
MTL_MAX_TX_QUEUES macro, but actual number of queues used might differ.
While setting this is generally harmless, since memory for MTL_MAX_TX_QUEUES
is allocated, it is incorrect, because it prepares config for unused queues.

Change this to apply tbs config only to tx_queues_to_use.

Fixes: 4896bb7c0b31a ("net: stmmac: do not clear TBS enable bit on link up/down")
Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..5917bf47c7de 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4140,7 +4140,7 @@ static int __stmmac_open(struct net_device *dev,
 	u8 chan;
 	int ret;
 
-	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
+	for (int i = 0; i < priv->plat->tx_queues_to_use; i++)
 		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
 			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
-- 
2.34.1

