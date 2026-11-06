Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945689;
	b=Kra6PsWu2+MB3V0l8L+xeay9bipCGiXV8KkByZvbANO5UwV8GRyQkN7e0J7C+V0DSi6l
	 0ClWKFzLqaNcqHaVQkQQxV8hcn6rHn9/oCaxo15A09SXvdouNKZT2tZcwEcQtLhNvAOYG
	 h9iSRyYYuOgsvPPd3U/srIE/jRXKhYMI4cNj4vqbh7m1euUDcHjDRbGdKg6rezwO3MRST
	 Hv8RBNs7UX3HWSTXpDl/LEQNXwOamiz9wUsCmqUBvZOgfCka7TZ3LHJz4xZs6G7D4oeqp
	 65/sTVV4v03HqhDRrR2tZDFD3LjXYGLnobViNOn9qzhCQH+c67CIypc7b4X7OqrpS6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945689;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=HTzZkQH2GhgXXoaLZg5WRDiws1C0RMwh6u5Ab2scxoE=;
	b=NGc/FCMLrHHBI0ux1BuhOYQ8dYaScZ+cvt65kiw0ida7FICDx3o8wuboAWai9d2+/+K9
	 pDfQct4YFNOijLZVlH7amtp2BQgtLvDM2rmNXcSUG68MMm0r/69oKwqA9V6T0/9CjO+4K
	 Z4zta3vrjIDgQEvsOPVVO3cgVftY4ud9jgul1BHwdblqFJ6ogaTERWXdZVNoVU2BbXfUS
	 O0qOCa6F5zMhT4deGE4eUgfe+K6jFLmxWFGGrb9e515vvL715wpMihqEnCOIW0TmnZBX8
	 haYMkVkFchQZm8JNKkxGNy2eFbaSadDnvEc8fmZuo9uhmAg/PqmT9xwXRPj+s6kBgXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=I02bRVy1;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD365606A32D;
	Fri,  6 Nov 2026 06:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD365606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=I02bRVy1
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HTzZkQH2GhgXXoaLZg5WRDiws1C0RMwh6u5Ab2scxoE=;
	b=I02bRVy16pbooNxHM7mPn73lUeCEdvvRmMLCEU+9c7wwa2vXuD+c4kgZnCZuDe/uL1j1ev6Dl
	yWN5yP+N0ShiRswLbH5rqZcO3ZSuT8O2t3ck4OVWJ4dG0lr0xNNpKVqxkWAl1b1MLOJH0pxVXPO
	vF1i2uP4fpFXZcJRPaNd3aI=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jLTRQ4q07znTV6;
	Fri,  6 Nov 2026 14:14:42 +0800 (CST)
Received: from dggpemr200011.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 74AEA40561;
	Fri,  6 Nov 2026 14:14:40 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr200011.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 14:14:40 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 14:14:37 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: [PATCH net-next v01 0/4] net: hinic3: Bugfix for later patch-set.
Date: Fri, 6 Nov 2026 14:14:27 +0800
Message-ID: <cover.1793946318.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemq100015.china.huawei.com (7.152.185.230)

This patch-set fix 4 bugs.

Fixes: Solve an LRO stall issue
Fixes: Avoid concurrent updates on 32-bit systems.
Fixes: Ensure secure concurrent access to adaptive_rx_coal.
Fixes: Ensure max_qps is always greater than or equal to num_qps

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791858167.git.gongfan1%40huawei.com

This changes the return value when the loop exits on the LRO
replenish threshold. It used to return nr_pkts and now returns budget.
In hinic3_poll():
        work_done = hinic3_rx_poll(irq_cfg->rxq, budget);
        busy |= work_done >= budget;
        if (busy)
                return budget;
As a result, the threshold exit now skips napi_complete_done(),
hinic3_net_dim() and the MSI-X re-enable. NAPI keeps polling instead
of waiting for the next interrupt.
This seems unrelated to statistics, and the commit message does not
mention it. Was it intended? If it fixes an LRO stall, could it go in
a separate patch with its own explanation and a Fixes: tag?

https://sashiko.dev/#/patchset/cover.1792149958.git.gongfan1%40huawei.com

In hinic3_get_stats64() in hinic3_netdev_ops.c, the reader retry loops
accumulate txq_stats and rxq_stats using '+=':
    do {
        start = u64_stats_fetch_begin(&txq_stats->syncp);
        bytes += txq_stats->bytes;
        ...
    } while (u64_stats_fetch_retry(&txq_stats->syncp, start));
If the loop retries due to concurrent updates on 32-bit systems, the counters
are added multiple times. This was previously benign since the fields weren't
populated by the driver, but these new updates will cause incorrect statistics
on 32-bit platforms.

https://sashiko.dev/#/patchset/cover.1774684571.git.zhuyikai1%40h-partners.com

When disabling adaptive RX coalescing via ethtool, does the driver
cancel any pending Dynamic Interrupt Moderation (DIM) work items?
If adaptive coalescing is disabled but an already-scheduled DIM worker
executes asynchronously in a workqueue, could it blindly apply dynamically
calculated DIM values to the hardware, silently overwriting the user's newly
configured static parameters?

https://sashiko.dev/#/patchset/cover.1792671176.git.gongfan1%40huawei.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792671176.git.gongfan1%40huawei.com

After that, hinic3_sw_init()->hinic3_try_to_enable_rss() can shrink
max_qps to 1 when alloc_rss_resource() or hinic3_set_hw_rss_parameters()
fails:
hinic3_rss.c:hinic3_try_to_enable_rss() {
    ...
    err = alloc_rss_resource(netdev);
    if (err) {
        nic_dev->max_qps = 1;
        goto err_reset_q_params;
    }
    ...
}
Only hinic3_vport_up() lowers real_num_*_queues, and only on a successful
open. A device-scope dump before the first successful open (or after opens
that fail before hinic3_vport_up()) still does this:
netdev_nl_stats_by_netdev()
    netdev_stat_queue_sum(netdev, 0, netdev->real_num_rx_queues, &rx_sum,
                          0, netdev->real_num_tx_queues, &tx_sum);
There is no netdev->up check on this path, so i runs from 1 to
func_max_qnum - 1 against a one-entry array.
Would this read past the end of the rxqs and txqs slab objects and return
those values to user space? NETDEV_CMD_QSTATS_GET does not require
GENL_ADMIN_PERM, so any local user can issue it.
The same applies to nic_dev->txqs[i] in hinic3_get_queue_stats_tx().
Before this patch hinic3 had no stat_ops, and hinic3_get_stats64() bounds
its loops by max_qps.

Fan Gong (4):
  Fixes: Solve an LRO stall issue
  Fixes: Avoid concurrent updates on 32-bit systems.
  Fixes: Ensure secure concurrent access to adaptive_rx_coal.
  Fixes: Ensure max_qps is always greater than or equal to num_qps

 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  2 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  2 +-
 .../huawei/hinic3/hinic3_netdev_ops.c         | 59 +++++++++----------
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 11 ++--
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  7 ++-
 5 files changed, 39 insertions(+), 42 deletions(-)


base-commit: 73022f605c447f31610b94ed4a983d2b4bf2c721
-- 
2.43.0

