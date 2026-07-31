Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE07392837
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484273; cv=none; b=Gt7LVGWfqzvAnXNe5BgKEK+1xwP28beX0Z+8es6jxVmOoQwZa2n4G0IkEzJ+Z6raxCvsx6Rt73wwSQteasd8RD33d7a6GyJCFXfGuIav5H9Dd8jJu1y7zvUaBwenfQL1zOL9r5xU2027RPwHvrb4fkNHERdjCZBXr+QPujCHqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484273; c=relaxed/simple;
	bh=CSCdhjebhpvom5SvR8tUwUPKSjj+huD0qGaBQ88RvC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NALgC9lSB1Oqo8i652/fWVAy5bp0WMlB7nBK7j0SpUhb2i3rLNuSd7Wk2yVAvSZcgA1DaCapQB7LxDSkHNvqsonAAh9hXEgiIF5iIGFri3/9Vl+dUUU0FDGQK0z6faMcDE82a8L0Pb03rMD9lT78awAqIMrIYpbanbCC2WovB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1785484211tf5f8b0f0
X-QQ-Originating-IP: 4bke+HBADe8Dgsp2Y7xFDNeMY7wXbigOqIa4D/LCLLE=
Received: from localhost.localdomain ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 15:50:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13952194884746767889
EX-QQ-RecipientCnt: 10
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
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 3/5] net: libwx: Add per queue netdev-genl stats apis
Date: Fri, 31 Jul 2026 15:49:56 +0800
Message-Id: <20260731074958.19333-4-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260731074958.19333-1-mengyuanlou@net-swift.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Od8yW6FVaoBXd1dPO6TQQFDr/oaPDXdFIwCQfe+b1x/q+PtntpUbZkqE
	722R/H120vWnlLsGtD0BYJRrvBXV+8eHO/5JZJkZlrcbFOIpo3BVrOcxt0E9PgCgqE4euOZ
	UWrkZTC0eUarrGzuf/3dljQV6D2l1OltWxiNSLKgTjgnlfTNYuUTYk/Pv+zfnyvmUEu3LE6
	PR3G+971AdeefIsVaeqZJIK6DebaUSL6zYS6tV650GdrybXrCLCaQv1pdd33v0BHQNkWDiA
	B/yKnRUBjxOs6tG9R9N0E5tdKm3sNF5GpW9rhOXszOYM1dwWnWX2aDOLPiZ4kueny4iKdyZ
	tx9VuDlDwYWEVccsTxNjZ/sdAhDRcya7+RcCM/ijzDZ9xIBc7fHKnmeavcZc7jy5WZgg9da
	B8jq0TYvhCTBwruWDzAwUbblaTDSRrXKVrx1wPbGwpUgJ397cqd3al81krnmNKJNjEoJlAs
	gFcmsAHJPD/lcWLbwGkTuQ2F1UMUgvxyWLsGn/2bKQv0MH8XzFHB962KFpQOy9y/Zf7wh9v
	8mqZcQfvy8QpsWh7dJwJfLX5Lknl0wdH8a/XqYbnNx0BSM0iNBwt0dvRCp9rOcRpeziomIt
	XffG5/WJr9B/WDGD87kCYVRc/ytDleNKGrSeuDg+tH94+EQ9x9Y3lp63LM9HejXYr5TYF7D
	g6oXeUzZtUd8wK49+bBlA+X/oIj0nI/XNrzONYgKZo63Wa3N+vYtEf4wxzAjBQ0U1ZzfUj+
	FaTLm7TplrOLqBZvsI5ghV6lOtZLIIihjyMBRQF37nNYd6+MlKMPRbvgR3yJ3Onm3Rroffc
	B/AcA8TxdI+eeSYvcW16uvepIUCshGK2jDkrpZougUtZMmXLv9bOQKpHULczIbpeYP3Io/9
	TJk+46JOcsWVruR+EHH/8AxKW8P1+vLH9VKWba+AdFU/3Au7bEGrfjmXs0SNGJZkE46Vv4y
	ehJ2gTVF5Ds8gUHsHiKzPGN6YC8e4KyMlJgBcB1gKkwSQevwkjhh3zRvrVpthD3+c7v2GVl
	qjjXKM0SJRlrZVjDdCpQxZIa3tW6PbJ2yGQ8wDk2mFJxgU5DWEtfyumLWI5xDomVE8PFW5J
	uBdNpDHEplTxdqlxq6ApcodlCFaNIJgReRqs4iMufp4pYm0Y/Gs9m249JBU7V4uEoYPkgDN
	MIWlrlkuHtXU5rLbOo+idFjuGQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Implement netdev_stat_ops for libwx devices to support the generic
netdev queue statistics interface.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 49 +++++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 31572f59b9ce..ae20733c703d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -5,6 +5,7 @@
 #include <net/ip6_checksum.h>
 #include <net/page_pool/helpers.h>
 #include <net/inet_ecn.h>
+#include <net/netdev_queues.h>
 #include <linux/workqueue.h>
 #include <linux/iopoll.h>
 #include <linux/sctp.h>
@@ -3100,6 +3101,54 @@ void wx_get_stats64(struct net_device *netdev,
 }
 EXPORT_SYMBOL(wx_get_stats64);
 
+static void wx_get_queue_stats_rx(struct net_device *dev, int idx,
+				  struct netdev_queue_stats_rx *stats)
+{
+	struct wx *wx = netdev_priv(dev);
+	struct wx_ring *ring = wx->rx_ring[idx];
+
+	stats->packets = ring->stats.packets;
+	stats->bytes = ring->stats.bytes;
+	stats->alloc_fail = wx->alloc_rx_buff_failed;
+	stats->csum_complete = wx->hw_csum_rx_good;
+	stats->csum_bad = wx->hw_csum_rx_error;
+}
+
+static void wx_get_queue_stats_tx(struct net_device *dev, int idx,
+				  struct netdev_queue_stats_tx *stats)
+{
+	struct wx *wx = netdev_priv(dev);
+	struct wx_ring *ring = wx->tx_ring[idx];
+
+	stats->packets = ring->stats.packets;
+	stats->bytes = ring->stats.bytes;
+}
+
+static void wx_get_base_stats(struct net_device *dev,
+			      struct netdev_queue_stats_rx *rx,
+			      struct netdev_queue_stats_tx *tx)
+{
+	rx->bytes = 0;
+	rx->packets = 0;
+	rx->alloc_fail = 0;
+	rx->csum_complete = 0;
+	rx->csum_bad = 0;
+	tx->bytes = 0;
+	tx->packets = 0;
+}
+
+static const struct netdev_stat_ops wx_stat_ops = {
+	.get_queue_stats_rx  = wx_get_queue_stats_rx,
+	.get_queue_stats_tx  = wx_get_queue_stats_tx,
+	.get_base_stats      = wx_get_base_stats,
+};
+
+void wx_set_stat_ops(struct net_device *netdev)
+{
+	netdev->stat_ops = &wx_stat_ops;
+}
+EXPORT_SYMBOL(wx_set_stat_ops);
+
 int wx_set_features(struct net_device *netdev, netdev_features_t features)
 {
 	netdev_features_t changed = netdev->features ^ features;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index bc671786978e..cf6dd74fef87 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -30,6 +30,7 @@ void wx_free_resources(struct wx *wx);
 int wx_setup_resources(struct wx *wx);
 void wx_get_stats64(struct net_device *netdev,
 		    struct rtnl_link_stats64 *stats);
+void wx_set_stat_ops(struct net_device *netdev);
 int wx_set_features(struct net_device *netdev, netdev_features_t features);
 netdev_features_t wx_fix_features(struct net_device *netdev,
 				  netdev_features_t features);
-- 
2.30.1

