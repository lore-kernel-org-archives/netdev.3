Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293042773D8;
	Wed, 17 Jun 2026 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695702; cv=none; b=qdxN8AAef0Q5q4KKKUj1LtMEnIUQTDK0Bg62Yq87BZ9W2sM2obr0caZ/UKTQI/jAdI4mszqGcGnuzErWoq8fknsuJS3/n0AcA88nXs+UaGh1Llr9BdLkaEDfJb5zLwcAn4c1SE84jAkj3kkTPeEeoRH6KqmZQzIxegMDhtf//k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695702; c=relaxed/simple;
	bh=sfUFZ+TIwX+3ZRgNeDk2+yL4vaVASnsLkrpFMVm5IMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iWlySU8DhtYUH6XmNGjH+xPgLFUDhkXVXaQWJTxMUrB9qcIj3VQLWrndyPrq05Fa1X8bwO1ycPxgRkgPy7kJqpc2P9DR6bfxmYXlYGmLKU2PsMdCiD3bx8DagRlv0nZU+HQwAhCRr4Er5bARCJY/oWyUXhANb6A0s3/j4L5JkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fPhbn23I; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fPhbn23I"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6Z8nJjeFIyF82rBOJru0ItkAhIaFHo3pl359iDUSmCU=;
	b=fPhbn23IY4Y5pG8H+C+SLeA1BP/cac3sFCHlEQRjmPOZs2T9l+EGZIHvtJV3wvI3lfrwvu2WA
	VI+c7QK6DeKY01hQC3rS53tsfg/RKC7vC+HAUUXs8kX/5ryrSkySltHYDOOmWNKp6ioUcuqD4oR
	feia85jzRLHj6xUNVY1Minw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ggLwc1n42znTbp;
	Wed, 17 Jun 2026 19:19:28 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 123DF40539;
	Wed, 17 Jun 2026 19:28:16 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 19:28:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 0/5] net: hns3: fix configuration deadlocks and refactor link setup
Date: Wed, 17 Jun 2026 19:27:16 +0800
Message-ID: <20260617112721.75186-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch series addresses a sequence of link configuration deadlocks
and parameter contamination issues in the hns3 network driver, which
typically occur during hardware resets or driver initialization under
specific user-configured scenarios.

The bugs root from asynchronous discrepancies between the MAC state machine
and cached user requests during sudden hardware resets, leading to invalid
parameter combos or frozen registers.

The series is organized as follows:
- Patch 1 refactors the ethtool link settings entry path to unify copper
  port handling (both native kernel PHY_LIB and firmware-controlled PHY)
  and ensures req_xxx configurations are uniformly saved across all modes.
- Patch 2 refactors the MAC initialization by extracting the autoneg and
  speed configuration logic out of hclge_mac_init() into a dedicated
  helper function.
- Patch 3 fixes a permanent link-down deadlock after a reset by
  ensuring that the driver caches and uses the user's intended autoneg
  /speed settings (req_***) rather than un-synchronized runtime states
  or SPEED_UNKNOWN tokens.
- Patch 4 fixes a link loss issue on optical ports during
  initialization by differentiating autoneg default values between
  copper and fiber media types.
- Patch 5 fixes an initialization (probe) failure caused by lane_num
  contamination from previous active lifecycle by introducing
  req_lane_num=0, which leverages firmware automatic lane matching.

Shuaisong Yang (5):
  net: hns3: unify copper port ksettings configuration path
  net: hns3: refactor MAC autoneg and speed configuration
  net: hns3: fix permanent link down deadlock after reset
  net: hns3: differentiate autoneg default values between copper and
    fiber
  net: hns3: fix init failure caused by lane_num contamination

 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  26 ++---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 100 ++++++++++++++----
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   1 +
 3 files changed, 90 insertions(+), 37 deletions(-)


base-commit: 406e8a651a7b854c41fecd5117bb282b3a6c2c6b
-- 
2.33.0

