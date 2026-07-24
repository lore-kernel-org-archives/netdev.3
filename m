Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD3C402BB3
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888047; cv=none; b=jiJSCpoV5eJ+0RLJCi5oTh3ktvRhn52AuiofClvK97jStqg4qGubiuoG86l+U6dNpMvUhjePYJ7iSTK05pvrItSOT8UdnXJSt617ZPrUZcFdCkEruApBbu5wU5hgX4xUSSFhWeNyGEQYBWNhP9vLIT4/07vq6FiYpzN9nI89ITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888047; c=relaxed/simple;
	bh=6AFo5vxslIwLJHmQAwxTHn5JObBYSyWZatqARdMMw2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sTwoo2WfiuNzHSdX+RFLTaZ9Gifr5SBp45K+vfPw8IjwbSDS+IDUzyvbI1D8qyCNfkbtu6kUx8oG8sgsJSbYCuo7P79gWg1JXUSX/GM/Il23f3fWKKjdJSbl24+zufEOtpnV4XWlS0JOpLTA+XGxf+fljfQ6HW4JVCjUTCh9oXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1784888003t2d7f546a
X-QQ-Originating-IP: TMlJ+cQ3CEi1jGJzbgUuGfW72uc2PAP/fLysocj+8kQ=
Received: from lap-jiawenwu.trustnetic.com ( [115.227.112.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 18:13:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14249460951690733662
EX-QQ-RecipientCnt: 21
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v12 1/5] net: ngbe: implement libwx reset ops
Date: Fri, 24 Jul 2026 18:13:05 +0800
Message-Id: <20260724101309.23472-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260724101309.23472-1-jiawenwu@trustnetic.com>
References: <20260724101309.23472-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NPaGQIkfoCn83Xc8JtGG6aQ0hptzUgqg4OezEOcEK0bK2CyGFa+MZ64z
	IOLXMlzfs9JVB7exHjQbR96/G8BCzALhXSut5/TAA5a5ZovnJgIrDzPy4wxDNESjtWVgmCz
	yIkzv8UlXLuDwdXbmwZOIsS/v1SYJMYb25upHA2+nVszPpgyIibsaZp3jMKtvDCor1ttrSw
	o44kDX2BAF0vNgOygVSihxVwk2W1my2qbkNZce0lXU3qraPLLzIlphjx62HRY71gxLZGW7/
	uhmHcnf4WouL3aC+fkOWoUudUxRd4YpAHnZ8NUHHAP9vFRQl+ZypGykjYkjNRfswDsQAusI
	TYUhoDlftTKKuiAR8BslAw25W5+Wx128aagZQrrUXOaMs4MLkuhYDPh3CipA9aAZiIyghO1
	1NEDUN3LClTddmULn09NpOPV4XnGkQs8R7kmvWpBGeYmkEoC4BLa45OmH+1AwJf1foffgs6
	ymPsBgEFAJiGZuCMoav/bgmSlk9A32w2XP5zb9gS5NpoEerV+LyxDwF6G5MiKVKhRrYBvZz
	3uST85FFiSsw9j96RtHvpUpV2AHuOl1iYkFi8y8Bv7++o3MoHahikSk7OAepICOk80lZU3c
	7OkWND0FDrE9emY5KbfspXTE671vzCGv0UIUGkj/phuIYv5/Bt+zcpsEE72ZTB1sTxIR5i5
	BSqH5mhA1FdqSdvVmMWgKINMbniG0SBwgCnc9KY8oqVOK0F1aBcBCdDp8d/wdwWhvBEgwI3
	ma171kxKiXTcsaa7+zpbPg5GrCt5lQAcEcdCXyfa+W7ook39ddmsh0Ez8KIvoZi8lN3wbf3
	nSuTLVy1A25OLFS6uRqzjAQPDgG4zL5ZkXbjrlK6JF2cVOm6aWujLCqsXRek0+pWr/QCJKW
	twrvkeiuOQY1+KdE2GNY3xJ19bTuJYkD5FntwKnjOP6Vgyyk/p/jo+GkC1uLaJqG7AqQPke
	doEiE2j1TNuXiBjlDBXCTYeMzwmDyOTBdc3kEZd2V1fPOvWnsfoOTjDrKmAyvggKRyaIocS
	ufvGX/YeSpAOHj3s43W+pZrSTX2Z6TY3dAbn/2J3BzZiIFcLidYk9B7XqAR1n6qGpjR1oQz
	FSYDu2lFgShmntLWh4Jv1k=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Implement wx->do_reset() for library module calling.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 37 ++++++++++++++++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index b2e191982803..1960f7154151 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -59,7 +59,6 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
 	kvfree(temp_ring);
 
-	wx_configure(wx);
 	ngbe_up(wx);
 
 clear_reset:
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a16221995909..bbbec9b43bc2 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -133,6 +133,7 @@ static int ngbe_sw_init(struct wx *wx)
 
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
+	wx->do_reset = ngbe_do_reset;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -423,7 +424,7 @@ void ngbe_down(struct wx *wx)
 	wx_clean_all_rx_rings(wx);
 }
 
-void ngbe_up(struct wx *wx)
+static void ngbe_up_complete(struct wx *wx)
 {
 	wx_configure_vectors(wx);
 
@@ -490,7 +491,7 @@ static int ngbe_open(struct net_device *netdev)
 
 	wx_ptp_init(wx);
 
-	ngbe_up(wx);
+	ngbe_up_complete(wx);
 
 	return 0;
 err_dis_phy:
@@ -503,6 +504,12 @@ static int ngbe_open(struct net_device *netdev)
 	return err;
 }
 
+void ngbe_up(struct wx *wx)
+{
+	wx_configure(wx);
+	ngbe_up_complete(wx);
+}
+
 /**
  * ngbe_close - Disables a network interface
  * @netdev: network interface device structure
@@ -590,6 +597,8 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	 */
 	if (netif_running(dev))
 		ngbe_close(dev);
+	else
+		ngbe_reset(wx);
 
 	wx_clear_interrupt_scheme(wx);
 
@@ -606,6 +615,30 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
+static void ngbe_reinit_locked(struct wx *wx)
+{
+	netif_trans_update(wx->netdev);
+
+	mutex_lock(&wx->reset_lock);
+	set_bit(WX_STATE_RESETTING, wx->state);
+
+	ngbe_down(wx);
+	ngbe_up(wx);
+
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	mutex_unlock(&wx->reset_lock);
+}
+
+void ngbe_do_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		ngbe_reinit_locked(wx);
+	else
+		ngbe_reset(wx);
+}
+
 static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_open               = ngbe_open,
 	.ndo_stop               = ngbe_close,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 7077a0da4c98..4f648f272c08 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -125,5 +125,6 @@ extern char ngbe_driver_name[];
 void ngbe_down(struct wx *wx);
 void ngbe_up(struct wx *wx);
 int ngbe_setup_tc(struct net_device *dev, u8 tc);
+void ngbe_do_reset(struct net_device *netdev);
 
 #endif /* _NGBE_TYPE_H_ */
-- 
2.51.0

