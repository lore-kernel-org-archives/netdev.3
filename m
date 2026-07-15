Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551603644C4
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118974; cv=none; b=JRTqBDsje5UAYdsG+GX7DA3+xfRE9k1c7723jejd/Y8OmKJe6UT9Pe5Auf8GsIF9G/v2+DGwuIHTHALsSN/Tn1qJQ67R9zeM6NkuJ+2UG0TCZ9iATqMK1eaNhc2MYV1kzZ4klEQbc+F8k/m5eTGgtrqWxPQK392Zwt37UrPEEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118974; c=relaxed/simple;
	bh=3K8tCYgOogiXE6opUYKajW5n8qGiG95G+MUViEbfnw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Rhe1czL9FN1YSMAsssRxWLsD1qqGPd6Vs9QQWRR5+ir4/KWmZKdQtvkJVWI7FAbD2p+Xi+K7So7XBgpGduzMM0kiZ4DUFCTWqV1ZVRro4MRgJw4G+MsPA6Mdrk1C6czSIhD7ebZrnolbAg92Ax/EPU6W617vk8MbVTLrB32d68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uemelT76; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uemelT76"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260715123610euoutp01229193c2926d3676b4a6f11cf15a8133~CdsA1q74D1870818708euoutp01d
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:36:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260715123610euoutp01229193c2926d3676b4a6f11cf15a8133~CdsA1q74D1870818708euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784118970;
	bh=SDVJJ1xLr7xWky9ho2VxmausoMg83j1se4IAydWbvyk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=uemelT76i6UY2X5tg7rTHBUs6lCA4V/nH0Rn6HMYiwuJOeOZwt8NkhTlejbY9RmMg
	 rT21VlTUCk5fwPyFFH2vrdP7JTLzH9XOILYjpKRvnWA36DsY0tXNFyUZfhEfm88kGo
	 k+nzcY9ku5kR88E6iC+hzTjm5XsLwxE8rKtl59+Q=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260715123609eucas1p276498c4701060ffbb6789cb096696a31~CdsAMHlXz0124001240eucas1p23;
	Wed, 15 Jul 2026 12:36:09 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260715123609eusmtip2e748e18c41f35c2b9b6c1ce83debc305~Cdr-s-uy20360603606eusmtip2D;
	Wed, 15 Jul 2026 12:36:09 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net v3 0/2] net/stmmac: Secure against failures of DMA
 memory allocation
Date: Wed, 15 Jul 2026 14:36:00 +0200
Message-Id: <20260715123602.51950-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260715123609eucas1p276498c4701060ffbb6789cb096696a31
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260715123609eucas1p276498c4701060ffbb6789cb096696a31
X-EPHeader: CA
X-CMS-RootMailID: 20260715123609eucas1p276498c4701060ffbb6789cb096696a31
References: <CGME20260715123609eucas1p276498c4701060ffbb6789cb096696a31@eucas1p2.samsung.com>

This series fixing two issues related to fails of
__alloc_dma_rx_desc_resources(). Original issue from 1st patch is related to
page_pool that has happened in testing env, while second was requested by
Sashiko to have similar change for DMA allocation. 
To have complete fix for all failures of __alloc_dma_rx_desc_resources(),
merge two fixes into series.

---
Changes in v3:
- Added null assignment to page pointers (suggested by sashiko)
- Convert IS_ERR_OR_NULL check to just NULL check

Changes in v2:
- Added reviewed by Maxime to first patch
- Dropped null check as page_pool_destroy() does provide that
- Modified comment to reflect that

Link to v2:
https://lore.kernel.org/all/20260707174115.1264466-1-j.raczynski@samsung.com/

Link to v1:
https://lore.kernel.org/netdev/20260630100953.747868-1-j.raczynski@samsung.com/

Jakub Raczynski (2):
  net/stmmac: Set Rx queue page_pool to NULL when freeing DMA resources
  net/stmmac: Prevent dma queue NULL free on allocation failure

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.34.1

