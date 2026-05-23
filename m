Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3320356775;
	Sat, 23 May 2026 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779533721; cv=none; b=RXOHy9aTZl5/+yLtUbjr7G6cR+1zd++oJjFbqhF/Bt0utXvmHPz/SQaBfpSnnAdNXmoZPhxyCGOS8oJw6RjO1utQMeDuzacAISKuR40ref4vgliZXremrOWOJIS1+naZOU1mItMHXCVWe606BXv59JyBltfWTZYHMNKpRzpqWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779533721; c=relaxed/simple;
	bh=Z0XnwtJLwnPUgzcwlDcKDlQypcOn8FH44HNqVCSzORk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dNRB71A6Tj6yo8gePgAjO+flXeanwF6QwlUfTakXn+mDahzxmASGMtKUp4vfpXMMR0JPSBCHVf3P8Yz+L3pmmEWx3xYSIvELeUgyR2YFb0GQR1OxqIwd/cXSPpvCAH2pR3Os3ZRIPXhbruOJ6KlE3WqTCnIfQ2rnLW1u3TX/c2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eemmzHzZ; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eemmzHzZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sNJlfzD7Z00tXyJTPBX7EjDaUa0gzHTASAG7spOpnZA=;
	b=eemmzHzZZFTZUNQ22pCreCHH2+V4fmPUhV2pUcdVysDl+at5YKXsDZBR2zefNOY9jUgU++sTt
	VM2QNv1mYe9jBlTvahv0s83Hzi5+8HhmpwhmXAOBK3uQ8LX4HGr7H49qdVgENTrHMfjwGg4hsF4
	Sfb/BurKzZhu8VQLmxGh6sA=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gMzPB2ZWnz1cyQG;
	Sat, 23 May 2026 18:47:26 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E40D40561;
	Sat, 23 May 2026 18:55:08 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 23 May 2026 18:55:07 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net-next 0/6] net: hns3: enhance tc flow offload support
Date: Sat, 23 May 2026 18:54:43 +0800
Message-ID: <20260523105449.661848-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patchset enhances the tc flow offload support for hns3 driver:

- Patch 1: Refactor hclge_add_cls_flower() to support more actions
- Patch 2: Improve unused_tuple parameter setting for separate src/dst configuration
- Patch 3: Add support for HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET actions
- Patch 4: Add support for FLOW_DISSECTOR_KEY_IP and FLOW_DISSECTOR_KEY_ENC_KEYID dissectors
- Patch 5: Add debugfs support for dumping FD rules
- Patch 6: Move FD code to a separate file (hclge_fd.c) for better code organization

---
ChangeLog:
v1 -> v2:
  - Fixed warnings similar to "warning: restricted __le32 degrades to integer",
    pointed out by Jakub
  - Fixed warnings related to
    "warning: diagnostic behavior may be improved by adding the 'format(printf, 5, 7)'",
    pointed out by Jakub
  v1: https://lore.kernel.org/all/20260518093526.1109595-1-shaojijie@huawei.com/
---

Jijie Shao (6):
  net: hns3: adjust add_cls_flower() for support more action
  net: hns3: improve the unused_tuple parameter setting
  net: hns3: support two more actions for tc flow
  net: hns3: support IP and tunnel VNI dissectors for tc flow
  net: hns3: debugfs support for dumping fd rules
  net: hns3: move fd code to a separate file

 drivers/net/ethernet/hisilicon/hns3/Makefile  |    1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |    3 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |    6 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |    3 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |  150 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_fd.c | 2575 +++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_fd.h |   33 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 2514 +---------------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |    6 +
 9 files changed, 2817 insertions(+), 2474 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.h

-- 
2.33.0

