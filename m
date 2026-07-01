Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972303B83FB
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890723; cv=none; b=QxqkGBH4D4jSbkh6sYWTGJMVksIcbUshFEbuykDcQc+Z9AT7QMg1TTjNGkS/XJdVJjAcbd2uXqNC/wu9xjVbCGwzyPcTmO78djewifyIVj0LDjyGsINGt6wOwk17DFY6v6sEh4IGbs1bfrjwPhcAl4HPwETxAkw2xlRsnYpqG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890723; c=relaxed/simple;
	bh=6AFo5vxslIwLJHmQAwxTHn5JObBYSyWZatqARdMMw2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ox1SAP05bhINqAMXDjvSUb+vgP4BKCHcwjPASo108KBhykHSCjeFPer3Y87meeGK53kjO+ZiQqs4vX68Epq4zh416CWFQL9r8byyG0+tIXyXetXkhD5SXgJwd5Y/rirsHySFj0dGDZyyOMG5ufb+h7YKp/UKhO/D1D+3PdV1mVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1782890655t9e75a560
X-QQ-Originating-IP: wavIFXMIPHC+CuQGohfVdKWfhNz1bxfm+R3ILw7qpk8=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.190.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 15:24:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6453058476610151947
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
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v9 1/5] net: ngbe: implement libwx reset ops
Date: Wed,  1 Jul 2026 15:23:53 +0800
Message-Id: <20260701072357.33984-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260701072357.33984-1-jiawenwu@trustnetic.com>
References: <20260701072357.33984-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OTrYKT7O7S5ZSbeqFnGiS0FReZrA0sjMdU2HrA3uZq43qlmaQ78Mh7mL
	bqxogMQbhXSal06L8M4LTa3ZH08n0s4O375n/geiAIsogvk6F1MF7TQiUGlk6V0f/tREyKA
	wvgIirQwFw9idJkO/ZrBg1OzNscObvbVbbpj0mU7qYBmW5Rs4maTwoKPpVsVq74In0QW3kv
	2p1yHY/rn8fGFzuJKFwqvIh/mXcILOIpTRHT07Blu2dUjhKgAAE08Y/80Eeh8HMGH4jCB3m
	aiU5dDIjy01+W0KchTP7Vc3V/TEaUP7YouXuMZeD9s6Qdbnz/hTAQtsNgMhNlUcJhcYnpRm
	nKsgd+BcPh2lxUwet93FmTnp3STKj4+yetc2Evic8GCfahbGwOV70mBWkg2QCOAoIYb0vPu
	n4Oj9Y/kk8fUwtGhhom7YNSmYw41desRO79TtMW6mNvmulsYuIFAdsvL139v+eJ3GCthalo
	+RLyWn5y6CYjhiEPQDt3kVKJq/4YR+J5kSS/skSz5g4wNhStMj76h0Kl6F3Ny15nw+nBR/M
	BLHI+tNMiKNEc/GcrjVo6NFPg/Kbvfsz+dUWtpR/nj8/g9+e8Lni7gxYkkGvO0xpiEPUqQ7
	bL/q0dEm/cy2/f3T5PbyQXoOLgKfVoobk1HToBpA0JvtoOFmTmtlyfEv6EtpLu4B14jpY0p
	J0rAylyGTlUveL996WqC58inw1QG3ZOMNFFTpNP4y5m6pb8ehV4OJRkNGQqOgruFEUBI5Us
	5xby7KPKuB9XvAOL2QKXbBAnBiuu0VVrqfOlVLoEQTvG5UU7r0f3QPpUCpXQTRyIs021svl
	Ce/cDhFs9ZL58GaG+hGNjrULFxwaY7UgwCAutJ+NuvP9nXhUx9Z846CeGoQO831mzPnoJAf
	V6dEjHjkkZm5AvtAU5lszyXibasR2aFlIWwVOxA11Rxn4fX79b4OvjNPAioHIYe2t1O7zpo
	DOBt3fUWa+9T5ZPXhBrjzHYc85/1Ns7z1IXA4iqTt15zQHSQM2dhpyKTFE8iEbIXJ9D5ehE
	AvvXqRZPu6cI2H+ooo3YoHW9ufAy67z+lx2H8cRRwcHtzkH+Ets40qIstvjMWFflQh8Ds9/
	EHidasqkubDQYSrwWWo0hcfxBNWpwYTIiLR6m8WE/UgojQOvu3vUkzYUDu8PHhfZU+vTluV
	AupzTTzvB+mL9eo=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

