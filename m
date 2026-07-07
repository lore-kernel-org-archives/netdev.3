Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FDB3845D0
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446281; cv=none; b=NiUFiVOyPe53FdXJoNt6wfvYhwpadrrxS4oNZMewhfncY3otPG5b4AgygwRkmaiDgAdH+Kba1VVx06feZoJikGEPpAcRr/4BPiIRxsHQhlr0cEemDJmhMxM86FgCRAwFHKkouvN+77yXLYrYUDFbzvEKGBG+2BzgdTnOZc9S7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446281; c=relaxed/simple;
	bh=hus5eAjRTVkJjQ92lu1Wkj26e2Kl0Wvta7FR9LlvKTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=vEE+O5gkfQa+7Z2Bq9LYhXbYed3MU555qeoNSSKhz2POjAXkp1qa/505MpNVGZJW3eiwiK6PrfuJHHrPfJAmT5aogxEoDsFtZUCAs71T6WwAsiWezxOdYM654LUKOXFZLKtRWzjUWYwt83pXrGl2Qy99qY1iGmnQwlqBiOBpgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KsmoXaci; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KsmoXaci"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174438euoutp016a7bd9ae61a44c78aa9369aa4b6f250d~AEvEIFlOv0448904489euoutp01R
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:44:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707174438euoutp016a7bd9ae61a44c78aa9369aa4b6f250d~AEvEIFlOv0448904489euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446278;
	bh=/V3IDsSnQjAP3/DFshVE1YPFZDzJBaRoz5Q/CBJ2mdU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KsmoXaciTtDB6sClKMx7k4Z4SHwRLTGPVL+/+u6L9lm0XADBbKPkwOn6BgeK9PMT1
	 wdh7CHhaqNtdraJ11IukdHnqO27Sf3gh3hU03aSjDEPBqzdOAV6yrpWT3Aa7+5bGnL
	 yhHUMC3VDjFNigem6uE4oD5r+QIK72cm9bcjzz4g=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174437eucas1p2cedaa017eea6cd5696535b17925a3b53~AEvDKjXIQ2942329423eucas1p2d;
	Tue,  7 Jul 2026 17:44:37 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174436eusmtip2f88fbdd78f52216b16d2a8d14239ea38~AEvCEQoaf1514515145eusmtip2F;
	Tue,  7 Jul 2026 17:44:36 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net 0/2] net/stmmac: Verify more wrong DTS configuration
Date: Tue,  7 Jul 2026 19:44:29 +0200
Message-Id: <20260707174431.1264520-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174437eucas1p2cedaa017eea6cd5696535b17925a3b53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174437eucas1p2cedaa017eea6cd5696535b17925a3b53
X-EPHeader: CA
X-CMS-RootMailID: 20260707174437eucas1p2cedaa017eea6cd5696535b17925a3b53
References: <CGME20260707174437eucas1p2cedaa017eea6cd5696535b17925a3b53@eucas1p2.samsung.com>

Commit 8a7bca6de6de protected against possible wrong number of TX/RX queues,
which could happen with new XGMAC hardware that has more supported queues than
currently available in driver.
Sashiko mentioned that there should also be protection against zero input
and some AXI related config, as these are possible kernel panics too.
While this series has lower value than original patch, since this
misconfiguration should not happen by pure mistake, there is no reason not
to fix it.

Jakub Raczynski (2):
  net/stmmac: Protect against zero queue DTS config
  net/stmmac: Verify provided DTS AXI setup

 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.34.1

