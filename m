Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02118372B37
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530650; cv=none; b=f9BUg6cF4ZsjNteYQm6hwSRebJWCr657671zBXzlzOZPAa6ClJ/xn4zDodSohDT28bO/KYW0uAZ2nTbDUK4hD957drwaSUV9ORv60YspR2LmaseZBwqfxv2mvbiucXVM8dAcW5t+lt/44NgOQfPe80sxmoRw6c0yxYILvXF53sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530650; c=relaxed/simple;
	bh=WvY8etkLwV45A9s3GXVtAah3pPIXPalc6ighfCKx394=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkPGZ99/itLCZmD3IdG23XFVzHkGrG60qRqhN1WakpyORKJbLAFT8At402yrDsNCHNcTDbBcGWU2SCsXSvCVl3biylkmUW+sPCblVif8ZkXXPnISsPMBzRu1bQtq7OtEUL6F+PW8NgAAYeOtIUMCF3iw5ju4wiXnRl8IaLmMz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1775530608t22fca258
X-QQ-Originating-IP: AKN8EdQVfZ9wPprpJ3uit6bso5E4Ov2tUEDAOxEDCLU=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 10:56:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8131314169239299263
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 5/9] net: wangxun: move ethtool_ops.set_channels into libwx
Date: Tue,  7 Apr 2026 10:56:12 +0800
Message-Id: <20260407025616.33652-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260407025616.33652-1-jiawenwu@trustnetic.com>
References: <20260407025616.33652-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M3vv73qU6a4u5jDypHNAbS5b1PMA8Z5dzcVHSYkrdsP5UeX7fmmxq/qZ
	KGd5ABiW6rGdFmgztSTVx3vB5JGAsBiESJDe21AEK5aRcJI7LY4M6argaoD6k3Z1FNsyElc
	x498a644GTGkRs+8CzBTXY7yElB7jTznRAvvcSp3GEEMc4OVnETRDtNzDtlN7IEhriDrk9B
	RDmTzdWRQ2F1Wyi/h/uw0tqrhzhUUgw9fcX67cA5LztjCtCbCOVIdhPs0HEm72raY3UIeNA
	3mQVNS7nerS9Yp5GvlUgxTTTKf0ujR0Qb9m5pPZWSdF2qENgEBeIpGtEmd8JDuVHhalgNge
	K0OJEM9ozNf31XzQhElTQAhjejYSBgsRzDA3WzC/OrTdHiYMivM5BgJudQjvaPWm1EzaQlC
	GLonZZLmzjD9tIpnT4WM6E1wRPHZPDY65rj+PBJosPkFsy0bYY2ptprRhaqw8B841V8c45U
	7lIv92hrrFSTcHFByL6Szf83gyKElkx9qypAXe4VSATO7fjsqTKIWsRmtQQlkyFOvsNevtd
	Z6FyDT/jQfLz26lVWZmBRx8fo4WZH8xxtSE7UL62XKhlVT5rVvwMEjkpuiFIBtJ4TO8OyZJ
	Phjqtd20cpP8l3cNX4jvZRTxo2UX0qP0sQZNntHgZUxeZD3Z3C3XIAVQU9OvVLMNJ9o0rOn
	o6Y9f30SKVvVHglb7wyDVFvbWi/ZAjH0JCx8E7Dq4n6sTOq/mlauDRISSttXnO6eo/wISQj
	53KLUTEuHCaj8BKnazC3e0kjMyASgMPCGnstiEPlrQciPF28kHZnTdmcsfOHFKWrELX4uOq
	JkLZEDoRYHUXZlaNOXTCAvgvuB6bd2N6sqi35ORGXuL7aBG1PjKe+oIA72TH5KnZcJID14D
	FDqkLfooJrnrazSzbBcmuNooFL+I1h/iGqdn3uiuZpUjlUblJC++PJzDDCS2Ra+1LvE0AGR
	LBVMp+EWSa4Ods5zPqpdQEuPSOtMckTg32M/J58jCmnnzVA8sV5i3MTmOzJyJ6+dJNCOVD9
	M/qAbgtLquqsPEkgVb5A9gZio+IX8THIU5IcUkYhto4txokc1moaH4F64Lpuc=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Since function ops wx->setup_tc() is set in txgbe and ngbe,
ethtool_ops.set_channels can be implemented in libwx to reduce
duplicated code.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c   |  2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 15 +--------------
 .../net/ethernet/wangxun/txgbe/txgbe_ethtool.c    | 15 +--------------
 3 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 2de1170db8c7..6adb8cbcad1f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -555,7 +555,7 @@ int wx_set_channels(struct net_device *dev,
 
 	wx->ring_feature[RING_F_RSS].limit = count;
 
-	return 0;
+	return wx->setup_tc(dev, netdev_get_num_tc(dev));
 }
 EXPORT_SYMBOL(wx_set_channels);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 1b76ad897e97..b2e191982803 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -68,19 +68,6 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	return err;
 }
 
-static int ngbe_set_channels(struct net_device *dev,
-			     struct ethtool_channels *ch)
-{
-	int err;
-
-	err = wx_set_channels(dev, ch);
-	if (err < 0)
-		return err;
-
-	/* use setup TC to update any traffic class queue mapping */
-	return ngbe_setup_tc(dev, netdev_get_num_tc(dev));
-}
-
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
@@ -104,7 +91,7 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_coalesce		= wx_get_coalesce,
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
-	.set_channels		= ngbe_set_channels,
+	.set_channels		= wx_set_channels,
 	.get_rxfh_fields	= wx_get_rxfh_fields,
 	.set_rxfh_fields	= wx_set_rxfh_fields,
 	.get_rxfh_indir_size	= wx_rss_indir_size,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 46375799d057..3e32aca72806 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -91,19 +91,6 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	return err;
 }
 
-static int txgbe_set_channels(struct net_device *dev,
-			      struct ethtool_channels *ch)
-{
-	int err;
-
-	err = wx_set_channels(dev, ch);
-	if (err < 0)
-		return err;
-
-	/* use setup TC to update any traffic class queue mapping */
-	return txgbe_setup_tc(dev, netdev_get_num_tc(dev));
-}
-
 static int txgbe_get_ethtool_fdir_entry(struct txgbe *txgbe,
 					struct ethtool_rxnfc *cmd)
 {
@@ -587,7 +574,7 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_coalesce		= wx_get_coalesce,
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
-	.set_channels		= txgbe_set_channels,
+	.set_channels		= wx_set_channels,
 	.get_rxnfc		= txgbe_get_rxnfc,
 	.set_rxnfc		= txgbe_set_rxnfc,
 	.get_rx_ring_count	= txgbe_get_rx_ring_count,
-- 
2.48.1

