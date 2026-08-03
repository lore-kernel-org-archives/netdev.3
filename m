Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC9399CF5
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739471; cv=none; b=YZ6cV/HnnWx+KUHJEqT0lyrO3VA5ALwXqxvbPRqnAMtppmk+zmU6+9f2Zua8FxiQb1Axge/hds9ALdEwD7YfFFVgOgjRTjiHbIMR9Vzv4cRUhZRjTIvZ6FYkYdLkztvZ7bMXarbmZMxKI7prHVt2bnGyUXZtG2fufFIngzGGCsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739471; c=relaxed/simple;
	bh=vmtvoyEC3rNecxYBrkZHC5NPT3eiE8B3ckG5dQCfMC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MecFDFG6SbQM+TxnXFk2UsbH9HRJLohriWdO8iicK4GVlPOpKZzRRML8YwNP1Sf9VXv9iDTcT/PVNqO16843jXnWzlkF9Jnuw8GklaAOdWsTJ6+D04Uj574osR5WDJ/7A7K08a2GZ1Mza2mGd5NKaUmN2hNbvgMp8+Ui8Hw7PK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz10t1785739423t3f457f7c
X-QQ-Originating-IP: 2EppO5zxDXtWPJxyz30ACf0v52NhZf2u7HBs7X3CIJA=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Aug 2026 14:43:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2120100639091123094
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Joe Damato <joe@dama.to>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v14 1/5] net: ngbe: implement libwx reset ops
Date: Mon,  3 Aug 2026 14:43:30 +0800
Message-Id: <20260803064334.21876-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260803064334.21876-1-jiawenwu@trustnetic.com>
References: <20260803064334.21876-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mrgh6nGOssQafU3wtoNtsPfee7EaHc6dsnB91tqTQjtj2FKsZWSL1EPY
	s08BZjOYWalMaTolRWhGRh3t5tm8/XBoEH4X7T3EPJfaC0WEsavnKWA9h5YSK+9gMCF3niM
	dt6PXWD8rPpvAIb/Dq+GOr211Oj/78uGV4eWFGU1shLG9tkK/5UYLeT8qbXP8slzuS0r4kb
	gbkIOx67sCsQ47AYH+k3uon3oiQzRPtZodg/CdIA7K/y0XKbEHjdD+qblTxX6d7Ys/u96/P
	T9bE/4+L4LDsMmiVq6BSwyNcFYElE6lZTCrNWVb6e18/XMSripYCB0Tz00WC+5LWlYyzKAG
	WjZNmvekPiemewXSgqIIY2TKP2YK+ye7/v87dfk6bZhj1GBuiV+UhCIYSopuewCG+YqmpKE
	MfnEgmA486csVBmDwoWgty5ePNIiSNLvBD+GgUIERP1Jt+rCoxzdb7orcb1NyY1RQpAl8be
	Nxo8oBrFAcVpAd+A3Mn3zx9wHWOCXFMz3t37HYnWyXIQtyEZ9mvOw1HLt+LNBnRvH04mN8w
	pXUqQSgeYpC8VpnRF6IKBCuS3sFrSbyLuSnPuynCfhjC9xdIqi10YWS5+S30ukalHpmJ3+C
	d7C59SXJW+p8X9M8s8uNMTQWiror8J6PA23POpV8mnynTAacF4ZPnnyktG0xxnh25bMk94L
	RDHI0iHLmq+0bTy3BFCOJnToJgjuOCvOsErdk5/tBmeNkPRXASEpROvBKJgQvXQ2XLSoLTC
	kLLTKZxi4XdNO93Q3qxsBTrzAXdxBSA8WnIpzB5GcSQssaBz6Nq2XMrM8SweGH0n2uf1iQ7
	kyecrKC4psIc0rnmr1MOaHgIteUVTu0SaiAKywHusCWkNoMcdFOzt/CPyUvfUQN/TfJuvLs
	sSlxfznQYRZQt8QNcPzx6xGDGAlcOEvj7g5GHt0uVRy4PHgCQgwF7NoNEmSh2CuxSZVdQg2
	chDcPG1sUJc6iHKUz0uFxEFJrM8pjBmzqLlxbD0ntKL/yKiWti2BFAlyNpkmOoslXDQCIdm
	CK3MPly5Cw7hQOpp84gPjtNw7PQ/xsZleyuvke+HIOZbK/rMnW4oyQ79GJUDS6O6OlnPioM
	dxX1Y2xw/+VA7/1mN75oO4=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Implement wx->do_reset() for library module calling.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
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

