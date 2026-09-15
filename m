Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E387381E9A
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465143; cv=none; b=s7aVQ77vmUeuq5C6E8uCYRJQneBoTNviRk0jnYyfADh9iBZ2q0AVxzalSeeX+XDSDo4qDmK0WTtIgTBPgHOR9tpPp0FS9Qs9NACHYAv78zG5jRjVnK4EkvyZ3fbly+rOaQBX4vsPcUTkg51Men87E3jO5TiQWDTIbvnuGvwwQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465143; c=relaxed/simple;
	bh=lEmX+QwZpuzJsU2jURDMIi8KkoIcAn/nHUVpyXCMLdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L5LlALRx2fqW21LGx6dp7Y7kHb/z8xN2YQU1RQS8+ZGk8visk0hjuCxBSV+aHnGfu3Jdf3SRKcV/Cnowg9+BvpI0qZVtJDbeTnHxnQ8//JpaJ+L7wCSNucRD3babFBWjZQg/LDLzzVu3Mh7ReDph0alSGQaTzpjTyv25IZNwIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz21t1789465055tde14547c
X-QQ-Originating-IP: 0luuxEV/KGq8ZmO0sO1OStNVSvDqZY/VokhQKFJeWn4=
Received: from localhost.localdomain ( [122.233.172.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Sep 2026 17:37:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1313240632918394090
EX-QQ-RecipientCnt: 13
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	u.kleine-koenig@baylibre.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next] net: libwx: Add ethtool -L support for VF drivers
Date: Tue, 15 Sep 2026 17:37:14 +0800
Message-Id: <20260915093714.18815-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NFNrK8KlcSCRW1V3ZLHVioC8DiXSJLowyp7Cy9WwQR79cTgxPVwdqMVt
	Mxl5GPLHaQ4qOvMq+LlhQMz8daDMwzkQw0xQinnIOzFfD60en0RhLM+SJoe3fI3Yb3KM4cf
	AarBuaPq50pkSbucEhFuKU8gs6apXuqZsQlAZXm4BeOvLnGiQJN87g/B9Uwk7MU1YHbVhOU
	cyOFx1/XcfeaDNSlpwCrMsIuSlVTh2FiU8irkdmqojkon78HxYb8B5bZ12x/WRpTS7Eibg9
	bi+QYKwvQLzKMz+EOYJUx//GLfVHcalyLWKoDj6TTKyiA5ViOY2uvNH5AJJbybNtxOpPbWo
	tB4xRqSw5g2ZrK4sx78R9yMyGWpH46Fls0WZhoaOchC0TNQ5Pop3lB9+43dC7XCm6zJP1Tx
	6ELOmq1nL8NLG2yWA1kqyLpm/NWdkxrjdTUoNeKySXc25GVYSS9x1Q9vgmZLs5lSCG+C7aV
	ExtguMDjvIb/DqjrQLJNytL1If1PM3voH8rYNEKXSApM0AswfSxwJHAZx2Vqg0zcJlQr1kA
	kpYDF5t9LnKhc5FIKO/bOiY2oOdXFhIaLwPQ7N/vd9zneRfKcHPn+fm3R/InTB7Z9Rrz2Ok
	gnG/oh362zDFykrU36WgBPwSCTGDsjT4Mwgxd0VsMVOYzEh8VQDChrJ2vOR3lMsa+k/jEhy
	tbXar+8j45xUaT75Q2DfJYp1rvcxMyV2xD1iwN99HRUJ8pvIXugWDz508h1uQnehcLZE4kr
	RS+Ebig9fEg9z2bo7tOGt+g3m2ZUIwrm3DdI1xzq+oc7z6lZLuOt2FU6l0ETe2cM3hRac7x
	/DOwp8UxpLEKay7QCLstM5ccqg06MQzkBEhSayzXDvmcGeuozHyfG/73pZ+79K5jZbf2rMf
	2Y5rVTXepgLTN1QrFKIPVxvpWUAAocXHTYZfMbBZmJio+BLBlM0AP3SYs91ZD0eHNkj8TW/
	OZo5j/UtG8GcGvBAYzWwEdjrJWAwGyOqIJ89Jp3aUFVgw5Yc8Kg1Jgoua2yoR0lx7xnHxYB
	uSUVn1exSz6tbfrbwWcQLJ68g4fetZ/KoXflGW1rOtFFzOFc4oQ4uZMfpl9gTrL8HJ7dLZy
	5geNM/6V8uE
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Implement get_channels and set_channels ethtool operations for Wangxun
VF net_device instances in libwx.

This allows users to query and dynamically reconfigure the number of RX/TX
channels on VF interfaces via `ethtool -l/ -L`.

Specifically:
- Add wx_get_channels_vf() and wx_set_channels_vf() to report and update
  channel limits and combined queue counts.
- Re-evaluate RSS limits in txgbevf_set_num_queues() based on user settings
  stored in wx->ring_feature[RING_F_RSS].limit.
- Adjust VF MRQC RSS hash mask logic in wx_setup_vfmrqc_vf() to correctly
  match queue configuration thresholds.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 64 +++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  2 +-
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  3 +
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 940d2e59876c..d24370790941 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -564,6 +564,68 @@ int wx_set_channels(struct net_device *dev,
 }
 EXPORT_SYMBOL(wx_set_channels);
 
+static void wx_get_channels_vf(struct net_device *dev,
+			       struct ethtool_channels *ch)
+{
+	struct wx *wx = netdev_priv(dev);
+
+	/* report maximum channels */
+	ch->max_combined = wx->mac.max_rx_queues;
+
+	ch->max_other = 1;
+	ch->other_count = 1;
+
+	/* record current channels */
+	ch->combined_count = wx->num_rx_queues;
+}
+
+static int wx_set_channels_vf(struct net_device *dev,
+			      struct ethtool_channels *ch)
+{
+	struct wx *wx = netdev_priv(dev);
+	u16 rss_limit;
+	int ret;
+
+	rss_limit = wx->ring_feature[RING_F_RSS].limit;
+
+	/* verify other_count has not changed */
+	if (ch->other_count != 1)
+		return -EINVAL;
+
+	/* verify the number of channels does not exceed hardware limits */
+	if (ch->combined_count > wx->mac.max_rx_queues)
+		return -EINVAL;
+
+	/* if device is resetting, do nothing */
+	if (test_bit(WX_STATE_RESETTING, wx->state))
+		return -EBUSY;
+
+	wx->ring_feature[RING_F_RSS].limit = ch->combined_count;
+
+	if (netif_running(dev))
+		wxvf_close(dev);
+
+	wx_clear_interrupt_scheme(wx);
+
+	ret = wx_init_interrupt_scheme(wx);
+	if (ret)
+		goto err_out;
+
+	if (netif_running(dev)) {
+		ret = wxvf_open(dev);
+		if (ret)
+			goto err_close;
+	}
+
+	return 0;
+
+err_close:
+	wx_clear_interrupt_scheme(wx);
+err_out:
+	wx->ring_feature[RING_F_RSS].limit = rss_limit;
+	return ret;
+}
+
 u32 wx_rss_indir_size(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
@@ -852,6 +914,8 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_link_ksettings	= wx_get_link_ksettings_vf,
+	.get_channels		= wx_get_channels_vf,
+	.set_channels		= wx_set_channels_vf,
 };
 
 void wx_set_ethtool_ops_vf(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
index 7325b475ee10..6fec3ab5e4e4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -237,7 +237,7 @@ void wx_setup_vfmrqc_vf(struct wx *wx)
 
 	vfmrqc |= WX_VXMRQC_RSS_EN;
 
-	if (wx->num_rx_queues > 3)
+	if (wx->num_rx_queues >= 3)
 		vfmrqc |= WX_VXMRQC_RSS_HASH(2);
 	else if (wx->num_rx_queues > 1)
 		vfmrqc |= WX_VXMRQC_RSS_HASH(1);
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 8b16b900820a..6e8659082051 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -72,6 +72,9 @@ static void txgbevf_set_num_queues(struct wx *wx)
 		queue = min_t(u16, wx->mac.max_rx_queues, wx->mac.max_tx_queues);
 		rss = min_t(u16, queue, rss);
 
+		if (wx->ring_feature[RING_F_RSS].limit)
+			rss = min_t(u16, rss, wx->ring_feature[RING_F_RSS].limit);
+
 		if (wx->vfinfo->vf_api >= wx_mbox_api_13) {
 			wx->num_rx_queues = rss;
 			wx->num_tx_queues = rss;
-- 
2.30.1


