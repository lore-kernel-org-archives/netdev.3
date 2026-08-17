Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414134B04A7;
	Mon, 17 Aug 2026 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786932285; cv=none; b=WRxlLkb9XUikxDuwoPuO1L7nKI1lqI8dt7EBvVfn2tISc+5nd2fY6zY3UZLO/d+L/69NpQi+YEkMlCM52f8MFw3nbIejLp+Rm33r6Tn6iAJwcBz+DyvZQvbQ0M5+jFOPdTxFY48QWGW7wiVejDwAeVOdKIdiXrV+OXL6TIbcGnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786932285; c=relaxed/simple;
	bh=ezOOOBzYO00OYElOFroDP/t0n6fll9xOQYPumq+p3RA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CWSZzc3Km9ricUuNAjDHNtAkbLmjb0DZK1cb9n5knQrgUXWXNGKTHckK4DrSlxWdBJzjW2EXCbLQWkCUcmULWns+fQg9p2w/8XZBmzQ6UAa+Ix9utV1zxMzxIpJ6135KmRR0rur4di5272rwFU8c+R7jKMzXdgdTHhXcKphYamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=X5x/wzLO; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="X5x/wzLO"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FtO3nsh+WxmuifXApYvHY/ycnfH2wqRvAL/Mq+n2y64=;
	b=X5x/wzLOol5FSEQ6g4OTLbCaHJHQ4wO6QSyv6m+V8qkXtcUciij5O3JBqbu6ahxEAKwUiEeOD
	f0rRfHCugsQdtMUIifLuouDVNRPau7gVYqJd66uo8ZjgsCBMbZvvFt0kZvXPCwg3PjrE5KUtJoK
	BL0rMn/eWrGoosz7Ck8aIs8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hNbVd49nZz1T4gd;
	Mon, 17 Aug 2026 09:54:33 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B8744056D;
	Mon, 17 Aug 2026 10:04:30 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 17 Aug 2026 10:04:29 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri
 Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chen Anwen
	<chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v13 0/3] net: hinic3: PF initialization
Date: Mon, 17 Aug 2026 10:03:59 +0800
Message-ID: <cover.1786774752.git.tengpeisen@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

Add 10 ethtool ops for information of coalesce and eth data.
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

PATCH 03 V03: https://lore.kernel.org/netdev/cover.1774940117.git.zhuyikai1@h-partners.com/
* Change unnedd to unneeded (AI review)
* Remove packets,bytes,errors and dropped in hinic3_rx/tx_queue_stats (AI review)
* Remove duplicated entried in hinic3_port_stats[] (AI review)
* change stats_info.head.status to ps->head.status (AI review)

PATCH 03 V04: https://lore.kernel.org/netdev/cover.1775618797.git.zhuyikai1@h-partners.com/
* Remove restore_drop_sge in hinic3_rx_queue_stats (AI review)
* Remove hinic3_nic_stats (AI review)
* Use old_q_param to store old config and use it in error handling (Mohsin Bashir)
* Add netdev_info to inform the user that depth is trimmed (Mohsin Bashir)
* Remove const in hinic3_get_qp_stats_strings parameters (Mohsin Bashir)
* Change EOPNOTSUPP to ERANGE in is_coalesce_exceed_limit (Mohsin Bashir)
* Update nic_dev->rss_type after hinic3_set_rss_type (Mohsin Bashir)
* Modify MGMT_STATUS_CMD_UNSUPPORTED to EOPNOTSUPP for complying with the
  error code specifications (Mohsin Bashir)

PATCH 03 V05: https://lore.kernel.org/netdev/cover.1775711066.git.zhuyikai1@h-partners.com/
* Clear HINIC3_CHANGE_RES_INVALID bit in error handling (AI review)
* Use low >= high to avoid low=high in is_coalesce_legal (AI review)
* As tx and rx share interrupts, we only use ETHTOOL_COALESCE_RX_USECS for
user setting to avoid user misunderstanding. So we do not add
ETHTOOL_COALESCE_TX_USECS. (Mohsin Bashir & AI review)

PATCH 03 V06: https://lore.kernel.org/netdev/cover.1779867397.git.zhuyikai1@h-partners.com/
* Remove redundant rx_jumbo_pending and rx_mini_pending judgement (Jakub Kicinski)
* Remove redundant max tx_pending judgement when .get_ringparam already got the
   max value (Jakub Kicinski)
* Use extack instead of netdev_err/netdev_info/netdev_warning (Jakub Kicinski)
* Remove HINIC3_CHANNEL_RES_VALID and only use HINIC3_CHANGE_RES_INVALID
  bit (Jakub Kicinski)
* Deference freed pointers in hinic3_change_channel_settings error
  handling (Jakub Kicinski)
* Modify hinic3_open_channel (Jakub Kicinski)

PATCH 03 V07: https://lore.kernel.org/netdev/cover.1779940072.git.zhuyikai1@h-partners.com/
* Remove the trailing '\n' in NL_SET_ERR_MSG* (Jakub Kicinski)

PATCH 03 V08: https://lore.kernel.org/netdev/cover.1780907605.git.wudi234@huawei.com/
* Update patch commit to be more accurate for change information (AI review)
* Modify <net/devlink.h> to <linux/netlink.h> (AI review)
* Use sq/rq_depth instead of rx/txqs[0].q_depth (AI review)
* hinic3_change_channel_settings() runs under change_res_mutex
  to protect dynamic channel updates (AI review)
* hinic3_close() serializes close and channel reconfiguration paths (AI review)
* Remove useless u64_stats_init in hinic3_get_drv_queue_stats() (AI review)
* hinic3_get_drv_queue_stats() fills rxq stats at correct idx
  when txq is null (AI review)
* Remove unnecessary semicolons after the closing bracket of
  static inline functions (AI review)
* Disable preemption in hinic3_rx_fill_buffers() (AI review)
* Add spinlock to protect per-queue coalesce parameters from
  concurrent access (AI review)
* Reject static coalesce config when adaptive RX coalesce is
  enabled (AI review)
* Validate interface state and queue ID before modifying coalesce
  parameters (AI review)
* Differentiate get_coalesce output for adaptive/static modes and
  zero-fill the struct (AI review)
* Return -ERANGE for invalid coalesce frame limits and simplify
  error message (AI review)
* Remove unused watchdog timeout definition and assignment (AI review)
* Return -EOPNOTSUPP when RSS type query is unsupported by firmware (AI review)
* Reject L4 hash bits for pure L3 flow types (AI review)
* Split RSS type conversion to correctly handle L3-only flows (AI review)
* Reprogram RSS indir table and HW parameters after channel count
  changes (AI review)
* Propagate exact error code from channel parameter validation (AI review)
* Update SW RSS indir copy only after HW programming succeeds (AI review)
* Program RSS hash type to HW before updating SW state to prevent
  inconsistency (AI review)

PATCH 03 V09: https://lore.kernel.org/netdev/cover.1781062575.git.wudi234@huawei.com/
* Remove useless messages in hinic3_set_ringparam() (Jakub Kicinski)
* Solve the big-endian and little-endian issue (Jakub Kicinski)

PATCH 03 V10: https://lore.kernel.org/netdev/cover.1782718232.git.wudi234@huawei.com/
* Unify 3 mutex in struct hinic3_nic_dev: port_state_mutex, change_res_mutex,
  coal_lock.
* Correct copy-paste error in hinic3_get_ringparam() (AI Review and
  Harshitha Ramamurthy)
* hinic3_set_interrupt_moder() now compare q_id and num_qps inside mutex lock
  (AI Review)
* Error branches in hinic3_link_status_change() goto unlock mutex before return
  (AI Review)
* In hinic3_change_channel_settings(), hinic3_config_num_qps() and
  hinic3_alloc_channel_resources() now run inside mutex lock. (AI Review)
* Call hinic3_free_qp_ctxts() in error paths of hinic3_open_channel(),
  thus hinic3_change_channel_settings() don't call it in error path (AI Review)
* Unset HINIC3_INTF_UP during close and reopen in hinic3_change_channel_settings
* hinic3_change_channel_settings() restore previous resources before freeing
  new_qp_params (AI Review)
* Delete unused macro HINIC3_LRO_PKT_HDR_LEN (AI Review)
* Drop packets when skb_checksum_help() return error (AI Review)
* Use rxq->q_mask instead of rxq->q_depth - 1 in hinic3_configure_rxqs()
  (Dimitri Daskalakis)
* Clarify extack error message in hinic3_check_ringparam_valid()
  (Harshitha Ramamurthy)
* Use rounddown_pow_of_two() instead of 1U << ilog2() in hinic3_set_ringparam()
  for readability. (Harshitha Ramamurthy)
* Protect interrupt coalesce parameter reads with state_lock to prevent data
  races(AI Review)
* Restore previous coalesce parameters on HW configuration failure (AI Review)
* Always report all coalesce parameters regardless of adaptive mode (AI Review)
* Safely stop DIM work when disabling adaptive RX coalescing (AI Review)
* Change coalesce disabled message from extack error to info log (AI Review)
* Implement dedicated get_rx_ring_count ethtool operation (Dimitri Daskalakis)
* Pass new RSS hash type to HW instead of the old one (AI Review)
* Initialize default RSS indirection table before HW programming when not
  user-configured(AI Review)
* Revert queue count on RSS reprogramming failure (AI Review)
* Use sizeof for RSS indirection table copy to prevent size mismatch (AI Review)

PATCH 03 V11: https://lore.kernel.org/all/cover.1784538912.git.root@localhost.localdomain/
* Remove state_lock in hinic3_set_interrupt_moder() and
  hinic3_link_status_change() (Andrew Lunn and AI Review)
* In hinic3_change_channel_settings(), cur_trxq_params is read after taking lock,
  and get symmetrically restored when alloc resources failed. (AI Review)
* Remove preempt_disable()/preempt_enable() pairs in hinic3_rx_fill_buffers().
  (AI Review)
* Add a comment about csum_err, and rewrite its judgement in hinic3_rx_csum().
  (AI Review)
* Rollback hash function type to previous state if setting RSS indirection
  table or key fails (AI Review)
* Allow users to disable L3 hashing for IPV4/IPV6 flows by properly handling
  empty hash tuple in ethtool (AI Review)
* Update software queue coalesce state only after successful hardware
  configuration to avoid manual rollback (AI Review)
* Use READ_ONCE and WRITE_ONCE for adaptive_rx_coal to ensure safe
  concurrent memory access (AI Review)
* Reset RX queue DIM state to DIM_START_MEASURE when canceling
  adaptive RX coalescing work (AI Review)
* Remove unnecessary state_lock mutexes when reading queue coalesce
  parameters in IRQ and update paths (AI Review)
* Rename is_coalesce_legal to hinic3_validate_coalesce for better code
  readability and naming consistency (AI Review)

PATCH 03 V12: https://lore.kernel.org/all/cover.1785120952.git.root@localhost.localdomain/
* Remove get_val_of_ptr() which is unnecessary (Dimitri Daskalakis)
* Split the monolithic patch into multiple patches (Mohsin Bashir)
* Fix MSI-X leak and defer q_params publication and add error-path
  rollback to prevent regressions (AI Review)
* Rfactor hinic3_update_hash_func_type() (AI Review)
* Guard irq_cfg traversal with INTF_UP check to prevent NULL dereference
  and fully reinitialize DIM state on adaptive re-enable (AI Review)
* Snapshot per-queue coalesce configs before applying and rollback via
  backup array on partial failure to ensure atomic set_coalesce (AI Review)

PATCH 03 V13:
* Split previous version into 3 parts. The first 2 patches were sent to
  net tree, patch #5, #6 and #8 stayes in this series, and others will be sent
  in the future. (Larysa Zaremba and Jakub Kicinski)
* Remove dead size field from struct hinic3_stats and add
  HINIC3_STAT_SIZE_CHECK() with BUILD_BUG_ON_ZERO to enforce
  per-entry compile-time verification that all stats members are u64. (AI Review)
* Remove never-incremented frag_len_overflow and frag_size_err from
  hinic3_txq_stats, hinic3_txq_clean_stats(), hinic3_txq_get_stats()
  and the hinic3_tx_queue_stats ethtool table. (AI Review)
* Add missing txq_stats.busy increment in hinic3_send_one_skb() when
  returning NETDEV_TX_BUSY due to insufficient WQEBBs. (AI Review)
* Add missing txq_stats.offload_cow_skb_err increment when offload
  type is invalid in hinic3_send_one_skb(). (AI Review)
* Remove mac_tx_good_oct_num and mac_rx_good_oct_num from the
  hinic3_port_stats private table as they are already reported through
  the get_eth_mac_stats standard interface. (AI Review)
* Fix OctetsTransmittedOK/ReceivedOK mapping in
  hinic3_get_eth_mac_stats() to use mac_tx/rx_good_oct_num instead
  of mac_tx/rx_total_oct_num per RFC 2863 (error-free frames only). (AI Review)
* Add HINIC3_IS_VF guard to hinic3_get_eth_phy_stats() to prevent
  VF from reading physical port stats, consistent with the ethtool
  -S path which already gates hinic3_port_stats on PF-only. (AI Review)
* Use u64_stats_update_begin_irqsave/end_irqrestore in
  hinic3_rx_fill_buffers() where the function can be called from
  preemptible process context via hinic3_configure_rxqs(), avoiding
  seqcount deadlock on 32-bit systems. (AI Review)
* Expand state_lock protection scope in hinic3_get_coalesce() and
  hinic3_set_coalesce() to cover intr_coalesce array accesses. (AI Review)
* Use standard net_dim_work_cancel() in hinic3_set_coalesce() to cancel
  DIM work instead of manually clearing struct fields, ensuring safe DIM
  state reset and simplifying error rollback. (AI Review)

Fan Gong (3):
  hinic3: Add ethtool statistic ops
  hinic3: Add ethtool coalesce ops
  hinic3: Remove unneeded coalesce parameters

 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 786 +++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  11 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   8 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   4 +-
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  37 +
 .../huawei/hinic3/hinic3_netdev_ops.c         |   4 +-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  64 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 109 +++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   6 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  73 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  18 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  68 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |   4 +-
 13 files changed, 1160 insertions(+), 32 deletions(-)


base-commit: ce6b4d3216b63f902bb8e9695ee6c10c83415f65
-- 
2.54.0

