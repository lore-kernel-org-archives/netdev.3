Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2425742F
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789088; cv=none; b=OV3qDMh3y1L1iPY4JZL5E2YYgmu0a9NpIxHriAKLllz+R1tifo9mB9Jf0163g4IT15pBcIJA5pkhfXb1jZlNLiDzqcnDBNu4FwiJ5lVA2VNQcLFfMnBfCEKKK/Cvb3z0jR491gs6RehD1sOcWZqmvzWiWpgVbG1fuGFcquKIHjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789088; c=relaxed/simple;
	bh=6AFo5vxslIwLJHmQAwxTHn5JObBYSyWZatqARdMMw2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sH4vXzBBbb5c7qYgISBX8GM6TMaYBQVy1c9towNF0M9MZCWVCDm5KARHu1du3lUp/Pf5fHg9b0raqBAZ1Gv+H536srRl6Lw5X4SV4wowvMpvnZRqGIVr4Ko/HQH9qjV4bTuMzQdnk38cEu547/rXqKVtv0Uj+p9RSKHnhPFwDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1782789035t41e87c53
X-QQ-Originating-IP: 9b9OZYErz+T/7doDIquKIFNXO+Df55w0rajOXo2eYx0=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.190.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jun 2026 11:10:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14681940318599943677
EX-QQ-RecipientCnt: 22
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v8 1/5] net: ngbe: implement libwx reset ops
Date: Tue, 30 Jun 2026 11:10:12 +0800
Message-Id: <20260630031016.19820-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260630031016.19820-1-jiawenwu@trustnetic.com>
References: <20260630031016.19820-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MjqaYNLY8QZGAuSvXXcZndUvmpZwhtF5Ngam9z5DqaLVRMByXHeVueNw
	Wg71+XaJRhWj925Yu9pJvd0fM0mIrqX9ceBPa8vSFrHKe6m7O9EV7mcqQ2NgFedblfbTJW4
	xHL2CBv1gJNyLl585Ks9fBBipa9JZSQfTYopvabckeCS+l+143pFON1h1/3/swO0vfH8+9c
	URuDr1x/VuWiTmURBozVstFda/X3istzbcEGBb5Jgsyh3oP/aVGUsp5PiIfppeWLl+DcUBR
	ImgWX4UpeG237mpn4vyL0LOq3VVTbNzTy0TmcYZpaDiM4gVJz/MA98+1WoqSS9OgP9zbYWj
	BUOFaCloRMSr0NySqhyydVsDGnF9azOOOeSYPRVttX0tSeaUX67aHdS7vRJWonBl8BsQvm1
	B+2oDxtdmLmjRWIdilaPQlZO+CAbHyt8H+MmotkOciY606mOYZhjf/vl2bx7u6CMQncJGqC
	mLhoIOgVOwkNZuLM9TK2b0KpIJyxN+J0rf2lCFW3C91428vtdyRGxnDBzvUoVf4L5/jXU0W
	Wx0bCCe+ikVsT5b6n7l71fc9UmHWjZltirq6b7JDUwT5gWo4ExaGKn+X+i8E4QHMYFsTqnT
	YeOXXz4uaxrZNdGn8sibcrr3V/umFO+/4aUKC5K4tWtwz/QyVQVMLPLyVavEzsRtHA1tfjS
	H40gmqW8iEIHK8iht3A2br2EUSzlrljdvM/yKHvxBkB+sX7yomCF2c3kvou89AfwSq+pyy4
	cNTCX5cysgzMuzpW+5B6E3D3nOHcFbZQ9FCQe3abXbed4fPbPs14WhEoUlcY6i7dQ2t3+tL
	12WUOP+LI15+rJdnU0D5qPKtlw9ROIgfe/ELr9M+t9IZ5oYy2XHczL3wGTr8WUkKIrPBUnE
	YX4SV8ZqkoQqXACwGlFhSqQPVZuv+VxDGb4lP6zGUqFZ5FUwyCJUTtctVoslHVoRjy3elf3
	BSEwqqALlu7yTEblZKCR+inQleUIW2pHRCL1utLKKy0V/QAx6ipQrnv9QbKmLkEvBUR80XY
	dgAbbB6JlVnzJEgsZqe8V1QmQx+hyp84NPb0bG1R1W9Heg/qZnbJ0IVmuDwp8BTenSgtfcr
	g==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

