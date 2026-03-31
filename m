Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73693D6666;
	Tue, 31 Mar 2026 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943807; cv=none; b=bcBEDxQQLCWhcJ5yc05Jot8UOwkgRnyb8ckxLkkFiVLeud5N0qYUE+EMbS60InoiQ+JsoOEudPUdv8Au4pUA7mmn5MrPQaaieVY5ytjTCm0FOT6Ms7m8SgqWCL+5XTxKyIZUZcfQojX02IE2kb9YSe9dnQTj2SqrA1Xfs26rI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943807; c=relaxed/simple;
	bh=fASAJArR/y4QkZiyZg0U2Rb9L8SqjCZ6jcF32RLWFFk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MKtXdZSj5AsPyOhiI+trGFej5WWvxeeT3xnTuCX2oJLBq+68+jK4Zwz92023uOo2fXzp+6vBNwvhSy/ungH7DCSSVGTCOTpz2C7044Pa91teqCKJLOLRVyQuU5xwQtzCEnQ6JQJbw+N/AXlic9pgAn8uL2o1IvugKDyk6IcPycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LYxQ3DT/; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LYxQ3DT/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eVo/An4M/gQLQ281O7gOuOLQWBzM9qkbNV/IQ7yuXx8=;
	b=LYxQ3DT/isqTlMjvhNVzBpmxE9pjTOJLoTQzcWQaqm8Cm53FaCLXMIGyKJvBdWhY0pSpK6RFN
	0kzPhYN4bJOhWx26AivuByk/0sEYEvwPMP7E6BRFSoo7V0u0ozUtN0sg+M69MzokCbPRWrWlUx4
	NFif1SIiI5TL05S98jPCbx8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4flKzP3Y5kzKmSv;
	Tue, 31 Mar 2026 15:50:25 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EA8240563;
	Tue, 31 Mar 2026 15:56:36 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 31 Mar 2026 15:56:35 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v03 0/6] net: hinic3: PF initialization
Date: Tue, 31 Mar 2026 15:56:19 +0800
Message-ID: <cover.1774940117.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This is [3/3] part of hinic3 Ethernet driver second submission.
With this patch hinic3 becomes a complete Ethernet driver with
pf and vf.

Add 20 ethtool ops for information of queue, rss, coalesce and eth data.
Add MTU size validation
Config netdev watchdog timeout.
Remove unneed coalesce parameters.

Changes:

PATCH 03 V01: https://lore.kernel.org/netdev/cover.1773387649.git.zhuyikai1@h-partners.com/
* Add rmon/pause/phy/mac/ctrl stats (Ioana Ciornei)

PATCH 03 V02: https://lore.kernel.org/netdev/cover.1774684571.git.zhuyikai1@h-partners.com/
* Modify "return -EINVAL" intension problem (AI review)
* Use le16_to_cpu for rss_indir pair.out->buf (AI review)
* Use u32 instead of int in coalesce_limits to avoid overflow (AI review)
* Remove redundant u64_stats_update_begin/end when reading stats without
  concurrent reader (AI review)
* Modify nic_dev->stats.syncp logic (AI review)
* Complete rxq/txq stats stats fileds in hinic3_rx/txq_get_stats (AI review)
* Remove statistics values in rtnl_link_stats64 from ethtool statistics
  values (AI review)
* Add channel_cfg_lock & channel_res_lock to protect resources access (AI review)
* Remove OutOfRangeLengthField, FrameToolong and InRangeLengthErrors (Ioana Ciornei)
* Remove redundant mtu commit (Maxime Chevialler)

PATCH 03 V03:
* Change unnedd to unneeded (AI review)
* Remove packets,bytes,errors and dropped in hinic3_rx/tx_queue_stats (AI review)
* Remove duplicated entried in hinic3_port_stats[] (AI review)
* change stats_info.head.status to ps->head.status (AI review)

Fan Gong (6):
  hinic3: Add ethtool queue ops
  hinic3: Add ethtool statistic ops
  hinic3: Add ethtool coalesce ops
  hinic3: Add ethtool rss ops
  hinic3: Configure netdev->watchdog_timeo to set nic tx timeout
  hinic3: Remove unneeded coalesce parameters

 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 829 +++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  13 +-
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  16 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  16 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  39 +
 .../huawei/hinic3/hinic3_netdev_ops.c         | 101 ++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  64 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 109 +++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  24 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |   4 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 487 +++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  19 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  59 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  17 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  80 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |   2 +
 16 files changed, 1853 insertions(+), 26 deletions(-)


base-commit: 8e7adcf81564a3fe886a6270eea7558f063e5538
-- 
2.43.0

