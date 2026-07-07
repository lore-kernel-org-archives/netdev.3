Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D237FF5D
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446104; cv=none; b=ASL7Awki250p0sg0MltZLqU+AZTkFtkA+RGcTxGmETz/LHs45JQxe2xs9beZLJ/UPvenxEBnNpuzi+sj2F4rCbIxKuVHzJNoG4oZWSiQJieIyde2oeqsmU4BWum/cJOytBjJUKFHdHmcwvqAyOj1yi7BujC4qzVI+a+rWleu0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446104; c=relaxed/simple;
	bh=i0bQxOBX18UYFMM8jpxcDX7DYW4c5s3mKOoz1KdKh7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ejwAij1iLxqOwEl0oN58kpByFZyRtK0Vl/M4OXeo1wbvBrEt7xPTHt1ETcgO+Nyh5dZEC9T4sU4u0AgiAAEnLBOefZX2H55MkunPFKH7dZr6qQZg4E+xkhTxykIlrDGHX9Y7a0qNTzyqeWfu8M44/gZr6D3StWjbYdSGtQro4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L/Y3F9RT; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L/Y3F9RT"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174135euoutp02e2bb7b0e794b48c9864382c075af8ce3~AEsZXiDf02061020610euoutp02Y
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:41:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260707174135euoutp02e2bb7b0e794b48c9864382c075af8ce3~AEsZXiDf02061020610euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446095;
	bh=Q5JM7bNL+vvD39sKvHstP3GgCnVUZ9CKB+B+yeWlQEg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=L/Y3F9RTlHLo98VkCsSuh+UtR71ATMVFANv9mPj2yDBHZrlpg6+aRld7uyr/joUN6
	 v0g+wmPShDE3aSnGD9TvS7mUCx6NsMP/sPQ/Gmz9rN47FQvmvwmBu74VwRhRc8Wnt6
	 ehtqLK3NID0EkXo+RsrvbYXXtq1HcjYzsVMDipk8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174134eucas1p2d88b2b6007e833f02ef6497b388374ef~AEsYmDoRO2783027830eucas1p2n;
	Tue,  7 Jul 2026 17:41:34 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260707174133eusmtip1f584699ca9032f159ed4a173781ce399~AEsX6Tayo1541815418eusmtip1L;
	Tue,  7 Jul 2026 17:41:33 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net 0/2] net/stmmac: Secure against failures of DMA memory
 allocation
Date: Tue,  7 Jul 2026 19:41:13 +0200
Message-Id: <20260707174115.1264466-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174134eucas1p2d88b2b6007e833f02ef6497b388374ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174134eucas1p2d88b2b6007e833f02ef6497b388374ef
X-EPHeader: CA
X-CMS-RootMailID: 20260707174134eucas1p2d88b2b6007e833f02ef6497b388374ef
References: <CGME20260707174134eucas1p2d88b2b6007e833f02ef6497b388374ef@eucas1p2.samsung.com>

This series fixing two possible issues related to fails of
__alloc_dma_rx_desc_resources(). Original issue from 1st patch is related to
page_pool that has happened in testing env, while second was requested by
Sashiko to have similar change for DMA allocation. 
To have complete fix for all failures of __alloc_dma_rx_desc_resources(),
merge two fixes into series.

---
Note:
1st patch "Set Rx queue page_pool to NULL when freeing DMA resources" is
set to v2 while this series is v1. I know this is inconsistent, but this
series is not v2 and would be even more confusing.
Hopefully that doesn't break some CI, as second patch is v1.

Link to original:
https://lore.kernel.org/netdev/20260630100953.747868-1-j.raczynski@samsung.com/

Changes in v2 (in first patch):
- Added reviewed by Maxime
- Dropped null check as page_pool_destroy() does provide that
- Modified comment to reflect that

Jakub Raczynski (2):
  net/stmmac: Set Rx queue page_pool to NULL when freeing DMA resources
  net/stmmac: Prevent dma queue NULL free on allocation failure

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.34.1

