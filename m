Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255DF451996;
	Tue,  4 Aug 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848990; cv=none; b=jPCjjXPes0dfG4+7Y5IWIbUVOYMo59IuAJYVInFcSNXxbKK/XM4viL+o13BQhpzQQKuqdnwRXhsprsKy0DxF+RkocxHop4NL/+MB/aKzNe2KCR67G1Bx3xeEdqtF99ieyqaBX3nq2zagEwOfe1pNrzd2rO5QOixgv+44X1rkxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848990; c=relaxed/simple;
	bh=ql5986Ng1V5cydZS9dbt2tBjBEZITGxqZbbDg/8bbWE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tEc2AOuG0cKgkaoKLAWisik430kuncTwRE2T2MBycc5ceOZTQs+e9O+ulwzZjGoB1QTvpwNPVBUOq74H3Pjv3mr5etaTCkaZrM/W9302no65Yrvg9g5T9nFKaGnz7drDcNkkbgPjvXv9FGgKuNL8OzMZFNoExBzlwtrfRv0Wh08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DJcAOxEz; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DJcAOxEz"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ylirOHwKxX33T747CtbzIkdkiOa0ohk9T7+N5Ewf7nw=;
	b=DJcAOxEzytQlARNmE/zCqONU+t5N7DeT/kLMxgrXbMDCClwd4GmkxIfzMqq8CrRgimwcG0fJ+
	b/nGBVVpNwRjTDPg/eaFq37D5l4UWT4rz6948GL0tujmG57KJYDZKmWqnvyZKyxBV66lvmAAdXN
	eeUtWk4WVWnLupUPlrqCG0A=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hDttd6tRSz1cyPG;
	Tue,  4 Aug 2026 21:00:09 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E66A4057A;
	Tue,  4 Aug 2026 21:09:39 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 21:09:38 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 0/3] net: hns3: some cleanups for hns3 driver
Date: Tue, 4 Aug 2026 21:09:30 +0800
Message-ID: <20260804130933.880552-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500018.china.huawei.com (7.202.195.199)

This series contains three small cleanups for the hns3 driver.

Patch 1 sets msg->desc to NULL after kfree to avoid leaving a
dangling pointer in a struct that is reused across loop iterations.

Patch 2 adds the missing const qualifier to the reg parameter of
hclge_log_error(), which is never modified within the function.

Patch 3 uses the txqueue parameter passed by the ndo_tx_timeout
callback directly, instead of iterating all tx queues to find the
timed out one.

Jian Shen (2):
  net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info()
  net: hns3: use txqueue parameter directly in ndo_tx_timeout

Jijie Shao (1):
  net: hns3: add missing const qualifier to hclge_log_error() reg
    parameter

 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 47 ++++++++-----------
 .../hisilicon/hns3/hns3pf/hclge_err.c         |  3 +-
 2 files changed, 22 insertions(+), 28 deletions(-)


base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
-- 
2.43.0

