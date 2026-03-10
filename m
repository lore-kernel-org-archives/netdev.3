Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110E52DEA90;
	Tue, 10 Mar 2026 01:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104713; cv=none; b=H1LpACXYcPGm38i8ADuuJDXzSWBQJCix7E8A817o80tA4AuuzyEqlGp1agTKld6juZJaOUhVqC5TLcCD9bg3f5gh9pGIw3aCPrcpJYLHnNhUlK+Wn9jQnScfOkZK+oRh5vjBclm60YI2WDEtI+U5pHGHQWpVSeK4GT7eyT6wtnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104713; c=relaxed/simple;
	bh=XDVzaTvoHhih9S2ROW/E49YhSZaEsw9UltiVFhyAdFk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UhOul9/pXHCGt9/QLhYBbMTt2PITijVMH0Y8SU6OWD5BMMWyU42r+0IxQhXFrBGhlmcoeJOHNIn5ZHtKWlmO7DpLzmYst0leHhfx0n6lqtZZ56uBdzTD+4zSfAQTTAOFt02Opw9Ihqu3eREkanQcGUvIH72kYp/yYNow0izBrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dyAVVO3v; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dyAVVO3v"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gVJRCe5iD/Ss/Mfi5UBzu8MXwGBuIFJpZYk+LKekLHQ=;
	b=dyAVVO3vOZLYIYyN3MgrZYx9UXvZL7zl1N4MplJp1/n8ASKK2TryNF4dlMBtncWRdq3+gUmcw
	q6hqluzVt9NOeyqdv/u/RicKK7VgFaWlCZDGAHK5QaJotlg9BmA3hO3AnQpzhv639aRVk8/bd6Z
	iT5GXxgUxz1ibqm43usr2Yo=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fVFsR1PDKzpT06;
	Tue, 10 Mar 2026 08:59:55 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 635074056A;
	Tue, 10 Mar 2026 09:05:04 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 10 Mar 2026 09:05:03 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>
Subject: [PATCH net-next v03 0/9] net: hinic3: PF initialization
Date: Tue, 10 Mar 2026 09:04:48 +0800
Message-ID: <cover.1773062356.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This is [2/3] part of hinic3 Ethernet driver second submission.
With this patch hinic3 becomes a complete Ethernet driver with
pf and vf.

Add cmdq detailed-response interfaces.
Add dump interfaces for cmdq, aeq, ceq and mailbox.
Add msg_send_lock for message sending concurrency.
Add PF device support and chip_present_flag to check cards.
Add rx vlan offload support.
Add PF FLR wait and timeout handling.
Add 5 ethtool ops for information of driver and link.

Changes:

PATCH 02 V01: https://lore.kernel.org/netdev/cover.1771916043.git.zhuyikai1@h-partners.com/
* Add err handling after cmdq_sync_cmd_direct_resp (AI review)
* Merge "cmdq_sync_cmd_detail_resp" and "cmdq_sync_cmd_direct_resp" into
   "cmdq_sync_cmd_exec" (AI review)
* Add "status == HINIC3_PCIE_LINK_DOWN" in check_hwif_ready_handler to check
  card present (AI review)
* Remove unneed GRO feature judgement and move csum_level to hinic3_rx_csum
  (AI review)
* Add chip_present_flag judgement in hinic3_check_flr_finish_handler to avoid
  meaningless polling (AI review)
* Remove unneed judgement in hinic3_parse_l2nic_res_cap (AI review)
* Add hinic3 prefix to get_cap_from_fw and modify error log (AI review)
* Execute hinic3_set_wq_page_size for both PF and VF (AI review)
* Divide v01 patch into two parts (Jakub Kicinski)

PATCH 02 V02: https://lore.kernel.org/netdev/cover.1772697509.git.zhuyikai1@h-partners.com/
* Add le16_to_cpu for printing buf_in->size (AI review)
* Modify hinic3_cfg_hw_pause error handling (AI review)

PATCH 02 V03:

Fan Gong (9):
  hinic3: Add command queue detailed-response interfaces
  hinic3: Add Command Queue/Async Event Queue/Complete Event
    Queue/Mailbox dump interfaces
  hinic3: Add chip_present_flag checks to prevent errors when card is
    absent
  hinic3: Add RX VLAN offload support
  hinic3: Add msg_send_lock for message sending concurrecy
  hinic3: Add PF device support and function type validation
  hinic3: Add PF FLR wait and timeout handling
  hinic3: Add PF/VF capability parsing and parameter validation
  hinic3: Add ethtool basic ops

 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 195 +++++++-
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  |  15 +
 .../ethernet/huawei/hinic3/hinic3_common.c    |   6 +-
 .../ethernet/huawei/hinic3/hinic3_common.h    |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   |  65 +++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   |   5 +
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 425 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  47 +-
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |   8 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  69 +++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   2 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  12 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |   9 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  23 +-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   3 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  39 +-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |   4 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  16 +-
 .../huawei/hinic3/hinic3_netdev_ops.c         |  16 +-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  77 ++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 110 +++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   3 +
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   |   2 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  15 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |   3 +
 30 files changed, 1146 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c


base-commit: ad3dfa80be765757f612da04318248f6d20e4f71
-- 
2.43.0

