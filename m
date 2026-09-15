Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0333B27E9;
	Tue, 15 Sep 2026 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478813; cv=none; b=jsMjozVZ6gfxTuosOPNaH/k9dZMaI5geelG24a6KzzZEti2elTyr7Lfh2a6W+0PEbvRzM7ruQ35IUevNpHcmXBsFIF2JUEnR8PGEYJzpXGWy7upWYo5sg3xTHmsz5CTbAPaBkq5DkunT3HOsP8/9kLxPvw32ZCwrC3ychjk1OqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478813; c=relaxed/simple;
	bh=XXixfnotrDFDLJ3MC04CYMHRJIZh00gAnh6mZo27jJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u6Vzse4FedRgWOjN60l9u6mUdv71B4FI8VV9WEvao/79CdG7hpDF9K8QhvuRW+o6HA0ypZ+7Xn1ORyz8e+y7zL+F+9TGAOtdpCL5jR1ASxkAq5ic0RdMmki7TK49Ut7G7uiGfE6pEsJGIP+Wql8+rD1nK0yrHCxjZ2JxQ30RRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i/ppghtb; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i/ppghtb"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NALW2w75cKqUnnYHZymCBrNS3wzoONrPw8WafCQ5Em8=;
	b=i/ppghtbgV8DJPSmaArPaN8YIShT1YxCSXIrmozA8rMifZb8T+F2rtHL3IvmUsgFQ4ARlYygt
	Pt2gCTsG00BxzqNsEui0FWOoZPjnrDTKZqfknAFMoyLMdnaHHoxccWyxLSV6ATzkmHZOqBa0Uja
	5GaE+Sj9SWSntLD7Eyl9AIE=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hkjF048kmz12LF9;
	Tue, 15 Sep 2026 21:15:32 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 423A340538;
	Tue, 15 Sep 2026 21:26:41 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 15 Sep 2026 21:26:40 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 0/3] net: hns3: three fixes for hns3 driver
Date: Tue, 15 Sep 2026 21:24:31 +0800
Message-ID: <20260915132434.1141742-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500018.china.huawei.com (7.202.195.199)

This series contains three bug fixes for the HNS3 driver.

Patch 1 fixes a vector resource leak in the error path of
hns3_nic_alloc_vector_data, where a devm_kcalloc failure after
successful get_vector() leaves allocated vectors unreleased.

Patch 2 fixes an interface stall that occurs when the hardware RX
queue is full and memory allocation fails.  Without an RX interrupt,
NAPI is never scheduled and the queue cannot drain.  A delayed work
re-arms NAPI polling on affected vectors to break the deadlock.

Patch 3 fixes a use-after-free in debugfs read callbacks that can
access priv->ring and ring->desc while reset, driver unload, or
ethtool ring resize is freeing those resources.  A mutex is added
to synchronize debugfs readers against resource teardown.

Jijie Shao (3):
  net: hns3: fix vector resource leak in hns3_nic_alloc_vector_data
  net: hns3: fix interface stuck after OOM with full hardware rx queue
  net: hns3: fix use-after-free in debugfs read during reset/unload

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  1 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 95 +++++++++++--------
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 68 ++++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   | 17 ++++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  2 +
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 14 +++
 6 files changed, 154 insertions(+), 43 deletions(-)


base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
-- 
2.43.0

