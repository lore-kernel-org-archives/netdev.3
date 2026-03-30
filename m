Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686519F40B;
	Mon, 30 Mar 2026 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774832621; cv=none; b=Rh6zFUaszc0WnQtqZimiHzZj1B4UUT/5z9IdJfDGtfgXDBjV4nW6L9h7qAOJfZR+GFXtsyLBvRThG4tgdAE7nM/ei3Dx7fKfHTztvCy8Bc32PNSo+ed/wCc0+ah+RKC/X2dMH0noMXKBG7q3K35Z/4Vggj6cWnwuZZKbYTEFjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774832621; c=relaxed/simple;
	bh=TzRZsuYrHMTvIHY9v4/+KA6xIA7OtYEcJKYeWJxMSus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WAA4yGdyN5dvZzhPj2ZvurqK9b8cA4WUKuYkwi2rD0Mpjc3m/k8aqIKP54013Qo9hqLvbWghdfTK8Nt+Zrtyf8v8D6ROZVwNvhl9h/ArWQ/JdWyxvVKplVCbXmUyFVsSyx07MW51hrcwPbL/CcVCBBEa4+vch8PNaKVUkGGQlI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=a1FPFToK; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="a1FPFToK"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1MM1BNsLVTt5dtBUaUIUrDkNqAsAUo52wg7CAdMZ7Ic=;
	b=a1FPFToKukzPFYSQID16nuHoj+vH4OVjy4eLOh8bpc3tnZC+/9HHiNJmIW8UtT4o27fY+xiKJ
	geqGmzON5sikYDhLdDgEx7Y4vn+DO8/ELJo349Jj9DQbbdCt026L590wMDRF63yB5eIL0Wl+E6M
	ORlLPLa/IENiGXSedutf14I=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fkXt42J8fznV4W;
	Mon, 30 Mar 2026 08:58:04 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CB8740565;
	Mon, 30 Mar 2026 09:03:29 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 30 Mar 2026 09:03:28 +0800
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
Subject: [PATCH net-next v02 0/6] net: hinic3: PF initialization
Date: Mon, 30 Mar 2026 09:03:17 +0800
Message-ID: <cover.1774684571.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

PATCH 03 V02:
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

Fan Gong (6):
  hinic3: Add ethtool queue ops
  hinic3: Add ethtool statistic ops
  hinic3: Add ethtool coalesce ops
  hinic3: Add ethtool rss ops
  hinic3: Configure netdev->watchdog_timeo to set nic tx timeout
  hinic3: Remove unneed coalesce parameters

 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 878 +++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  13 +-
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  16 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  16 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  39 +
 .../huawei/hinic3/hinic3_netdev_ops.c         | 101 +-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  64 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 109 +++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  24 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |   4 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 487 +++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  19 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  61 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  17 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  80 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |   2 +
 16 files changed, 1904 insertions(+), 26 deletions(-)


base-commit: 8e7adcf81564a3fe886a6270eea7558f063e5538
-- 
2.43.0

