Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E719357A25
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177653; cv=none; b=Uufoh1H2LQQQxtps0xWZvTDZ9AWpnISr3sGCqPXFCbcXNOoy01ochLzcA5tMMZlodwfZAUyIgdR3sa3UKCoR+Ttnz3UFlcseYadGo8YwpRw9KUh6WftmA4rctTk1G6M7slhcrw4IUowRPFFV5bzbcRRFofPYb9Mip5WM2GWMNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177653; c=relaxed/simple;
	bh=qXGvZ1sAvRdJ7PZpmd+qgawwSEx6Iidpfn7F3CQIgm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=rs7bey4xx3ZsRxO3qghvJbA1Ydt9dBtIYHhxNPcaIbh6A7Slb23PVHVe0xNAA1bqyrDFk2Z3Qj3YG9lpTrRUI6/+ZSziVsL/XRKHITIiotB0WHSkPG+e7sectCrlQzjiR0TocZHclqQAs82qupQEQZmjw2OfUR0OHx+i2ns62ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MNdv0umz; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MNdv0umz"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260611113403euoutp0149d5769f7dff689b37fc00724fad28cf~4A6FNVK-z1538115381euoutp01E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:34:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260611113403euoutp0149d5769f7dff689b37fc00724fad28cf~4A6FNVK-z1538115381euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781177643;
	bh=8vJeVAj/z4tf6ALczbGi0hk+xhcfHPNc5wF724wvVsk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MNdv0umzypzsIVXa6OLGXAv2/YPAT1p++ZX2Q3ucV5HTcI7TS69Sug/e/jA218Y1T
	 1QkNCbRWz3C6k/AQASY6oWtIB0GFX0TAijBDDKNrJTHeTRTMUVI+M9rvKu4USu9kMT
	 iZDd68kQaJn1EsCr62hFOOMFtYRkHs8NIvkKJDvI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260611113403eucas1p1f4b61896c875f1f6833d6ca136472af8~4A6E3YY0z0769007690eucas1p15;
	Thu, 11 Jun 2026 11:34:03 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260611113402eusmtip20128068a5cba2e17cd8baa05654eb531~4A6EOyVCm3265632656eusmtip28;
	Thu, 11 Jun 2026 11:34:02 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, k.domagalski@samsung.com,
	k.tegowski@samsung.com, Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net 0/2] net/stmmac: Fixes for maximum TX/RX queues to use
 by driver
Date: Thu, 11 Jun 2026 13:33:56 +0200
Message-Id: <20260611113358.3379518-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260611113403eucas1p1f4b61896c875f1f6833d6ca136472af8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260611113403eucas1p1f4b61896c875f1f6833d6ca136472af8
X-EPHeader: CA
X-CMS-RootMailID: 20260611113403eucas1p1f4b61896c875f1f6833d6ca136472af8
References: <CGME20260611113403eucas1p1f4b61896c875f1f6833d6ca136472af8@eucas1p1.samsung.com>

When contributing other changes preparing functions for new XGMAC hardware
https://lore.kernel.org/netdev/20260601162537.553512-1-j.raczynski@samsung.com/
there have been reports by Sashiko AI review about pre-existing issues
in the code. These problems are non-insignificant and are 'net' material fixes,
rather than net-next features.
One issue in this patchset was reported by Sashiko AI, while other
technically part of new patchset, but is reasonable related fix.
All of issues are wrong DTS configuration, but kernel needs to handle it.

Jakub Raczynski (2):
  net/stmmac: Apply TBS config only to used queues
  net/stmmac: Apply MTL_MAX queue limit if config missing

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1

