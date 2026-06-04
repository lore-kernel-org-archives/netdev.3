Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0713F1ABA
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563465; cv=none; b=fvRePs0pjmeJmdY5CjbqkxQXhXJhPeBgtsueR8/YQI4PHIP9VGzBtrl1xmpXBHbkUfm7J1ps+BRDEnxeda5b9FqWRFKuk8+tfaeLF69S7EMMNnpxIsySInZ1JU8nZO7GJn+hsFUzzFpxd9gWp4XvcQjP2yVcJ53zVJD3kys1Sj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563465; c=relaxed/simple;
	bh=56TyP/dBmL8VQd2a80QfyfyOjHTLJlJY4roG//frVgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lykw3mITy+DHxGSQ99nQB5IDGyFJJu5ZYmJg0ke05K916y4j3PXm7QlqPlQNuPdigCW/cYn9lk/QrXkZXS9NhNj1xKpcOHzkGNP87PcbNPH+gf00VcmuUx7M1FaVfPWlNzhEwdnQMAfZbMEsBP4WuZNWUtFXtMmmcqQGwA1SzuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz9t1780563404tda7242c5
X-QQ-Originating-IP: I2WaA2U/RULlD1SBEEfgDlfCtvl7uIiqiMLFu24esSM=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.207.111])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jun 2026 16:56:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4135773208672168791
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 1/5] net: ngbe: implement libwx reset ops
Date: Thu,  4 Jun 2026 16:56:27 +0800
Message-Id: <20260604085631.12720-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260604085631.12720-1-jiawenwu@trustnetic.com>
References: <20260604085631.12720-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MnfyDvrjPlz1eBzwaxuZZOqPtmEmlLCFk9V2gnnSqTze1mmrProjzu4N
	x/LBblUqSMCQaAJGBUxuBeuuC+gqIVKOrlIA71s+aQjUktCmD61m5qd/nuH3yvddNH9Oe/X
	WHTxU87kRJHIUX0FZwJ9kvrSnkxfjyQL+Zxi1PMoQdqqqWKfNH4Q0sZopEbHCMY6He2Rlut
	fUrXjNJt8fSMWmg9egYoOfbEQ05w8EU17d5tU2KfHMTyUhXpWpyAVgEPTl/leDCZrr2aM1g
	TNio1nsMxa2kbudR5lbzJEPk//nxMny6gL1JujKDl2qexsHwbzvTyF0hPblDTNhEdCwSVdr
	8bbKNIV33TXil48V9WME4wyNhWLiJoxv1Gy7wiZgiWdz5zwzujmhfqC+uowEHzO3jSGro4n
	yl5YX0iObPk1MMRpJU5veW3UALWBk1f6tvkwmMZBMeHVFIP1ze4rw3lip758hwLGC8zpyxf
	h7B8EePHf8WBNxdevF0JV2PiPAAEDgyvMUSH2WiweZvoH7xiByX85FlrintqInx82r4C+KD
	3b1T7H9ZDX3z7wkPymI+duJDLbBmnvEe+2+viTUj4bAIlbdSB7kOJcAXQBWokzhf+cXwDOe
	bNj4nlu4N53O5p0eTN/+yCnbd4rBD43D3O3zc9rXgwF+CiepVuKoq+LcwytpFymOMxx37P+
	wXKXHlP4pGz8tvdFxTj7sqiVDJ5jWE0UXLAGwNA6L6DQMBTMJWli5NHy/u2zk9u25AeY0tL
	TmZu4i0x3V197VPr182A5KModO/PF6lF0Yx6qO1xhfFt/l78Ue8/Z/+wHgIiQMxVVP3mZMi
	VysMKWGn/uWb7aMkUZk7vrzzbsQr0YIkP8GczhGSpngZA9nTOACm/t8yxeGUisvoLiO3mTJ
	O7PWy9Fs2IPhPmNiYSOFq+H0OCwiousVWXWzbNCZjKehrE6q2/i2d49sVhfIIuk4KD+CX61
	7qKMiKS8rFWjBSK4BBTyy5lOnTP/89Ph88abWbcDtXRqketGBBSOHwym4xeBEs6WOR2lM7z
	XqjTE4MXJhuteAT3WtvGngj0PE3dnQDFrEuC4+D5+J9/e4GQo7OJlAx4fx7msIq9vJx1OlH
	ZC1AYIRyR+Oio5C47RTgxLR4H8xjeGufkGACLqjpww0
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Implement wx->do_reset() for library module calling.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
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
index 8678c49b892a..dea6dfb043f3 100644
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

