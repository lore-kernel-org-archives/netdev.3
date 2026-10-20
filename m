Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476123;
	b=q/hLvBZgPM03CTGeOy4i413c3zFQhVcQbi1nVQTSfjhdy4c1NQzRTMXfM9W0hAxinAQp
	 JLChUstrBlB19doA82ZDY58S0OsMtaLG0QApIWPnuwcgnrJb7mVgWwdIEDplxSlPM34l9
	 mgwqmiNttLmDBX0++yGDP6aT0hOpZmdDUrcweGk3S1MAl7VBk+a3gfHBEGH9d5HoAIvjo
	 7igoCYxX/aXBRtDPN4dqzUYLUlFSyPBni9GXQToQxVMeByOk3mNHZgvdRdtIMDVkmPnIS
	 tYhjGZW+JcZTn8DK/WE4ZZmCicEY0OvLP/izb51bbQiLR5m4of1kqdWiVrixs8OoxGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476123;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=3gG82tVaW0Q+m9cDe7ys89ReJ2sKRr5G6OYaMbo0Hbo=;
	b=qc2GnUlmhNVmQuZqioIm6aa9181343H7fOtz6Z1OThN2clzhQyKx4ZFn9hSRM27fMniR
	 LX7Beg49DlMtVj6rraOhdtV0A/To0LvAsl0uCFutz7Apb0lmvWTnaT5o8SNTvBR3gYzCa
	 4tKfyUcnXBrWu5bXicJxV+DDFwMnJunSYLkQmga24dhYh7NxjKOJndmKMQY4jKUS57yjg
	 jgvdbYbM5pVSm2OeUNXxoOmkQm+ZC3R8C3CehNliOryBEw1Sy92ekkC5WUu5y20+QVfwt
	 ZpuP8/HUU3C7OSdOiedW6VP1t6O8P5ie0tYQoF31O8ZJo+3+Ol9oAOsUs7Xemt7nwtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=trustnetic.com;
	spf=pass smtp.mailfrom=trustnetic.com;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A5606A322
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D36A5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1792476085t05003356
X-QQ-Originating-IP: ZXNDUDU7lHwecOd64LOYQAekKiwS36y5eRcboEMf8Qw=
Received: from lap-jiawenwu.trustnetic.com ( [115.205.193.71])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 Oct 2026 14:01:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3596843355133494
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 3/3] net: txgbe: keep MAC enabled for AML devices that support NCSI
Date: Tue, 20 Oct 2026 14:01:07 +0800
Message-Id: <20261020060107.25636-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20261020060107.25636-1-jiawenwu@trustnetic.com>
References: <20261020060107.25636-1-jiawenwu@trustnetic.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M+CqXF/k5BI0m7qiW052YcEXZHiP4jkLDjDHSPc/RUXzr4t7o1qNSQnv
	/MgXvtSG5pX1fp3JMXl7r7GkvjOu5e+tynzHF7yYpnWaWh3QenlthdVAJQiDIW/ujp5PkoQ
	xSBnnv/QBJ/UwgdfgLm0xLIcVc9KRGgcZCPYQkIDFYjWYKTibCLqXonJ4NStg2dgTK78e1H
	HjbIdSGmR1I1CMrGjx1NTT8ZNmBEHZwEIMGecyfqtxYozmU0zG1W1ef4GeVmUIgnCUoAN3K
	02uaf/cT/Ukyp9actbsEvIqSwNqhMFTwZ0wBsETFOgjEhXjizcRnjQAnHZwcAw/+xZSN2XX
	lXVUCXdIna2AsGcE+KYUZ3MHSli27XxMCxU2MfWg1rykkIvcBBgnD4iliGw9EYCE0WoWkQL
	UUtjH7B/WfIBtiXcARhkyWnJdS4xEA2frlPwAW1+Mq1s6qQ0RsITD1417WEW0i7sX1MYIl1
	EqYmt3Fxq+BPD6yvEDHp9Iyp9OSJhkoCopY+5Le+ZuwplhQ3c3NidYdKW1Fq4mQ8d4QtW6c
	QGTZGslKrKFrP7PImvQ0g/cUgVMbyAgh8btHl11vl0tIBZIQAsAwG0NZ8BYwKHY5vS2t0kz
	iLRkOhfCx1f3nN6jw3BJ+15hLuy6NUO+IQh72sS1wT/5Po6Y9Cpd2u3iODdaRb1gpnAtY/i
	sCfn498prxSoURf6Ckdh0gqcUi4bjl2ngicbnET2TEjfkjFj0lzzfZqLjD20Zdz5RYFZskn
	/kF33SvYTlCHqFAa7mIDok+s29dR+/r2/AP1o4V7eYp2xNatRhu2a9zvCf6Iu3uu8WrkxXU
	Y+79USFAuCmrp3FPLdCS3/KC1Lo+1Ricww8vsfpU1WFM8SQIYeU/HC96uM/mQkv8Q4pja8S
	E5uMkIdiw+8UjetohXNu10GuP1+5lZIamlt2jXz9gDOcqYPrAeeAryU+B9WxHf+2Z1rmf3G
	jW2vgqdKMmpz0OV3THAyA4Q+N1zdceYcyIiTk39K/+6W6r911jK5O3/74+hmD5JbSBpTNkT
	gLI5tK8dkjbwaP1i7nH/ETAp3ih71WxCq6FqM7Z+Z2kIDjMw8QoYFCv78fUZn2UUzk9TbBf
	4JnRBIHwb1lfQYJSgriF5o=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

AML devices using NCSI require MAC Tx and Rx to remain enabled after
the host link goes down. However, mac_link_down() disables both paths
unconditionally. On AML 10G/25G devices, txgbe_down() also disables the
TX laser when the host interface is closed, blocking BMC pass-through
transmission even if MAC Tx remains enabled.

Skip disabling MAC Tx and Rx in mac_link_down() when ncsi_enabled is
set. Also keep the TX laser enabled for these devices in txgbe_down().

Fixes: 343929799ace ("net: txgbe: Support to handle GPIO IRQs for AML devices")
Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c  | 6 ++++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 26d0cfc58ee2c..9f1ce3e2e3a4d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -458,8 +458,10 @@ static void txgbe_mac_link_down_aml(struct phylink_config *config,
 {
 	struct wx *wx = phylink_to_wx(config);
 
-	wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
-	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
+	if (!wx->ncsi_enabled) {
+		wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
+		wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
+	}
 
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index a60a711e8e1b4..7f0cef24ec28b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -295,8 +295,10 @@ void txgbe_down(struct wx *wx)
 		break;
 	case wx_mac_aml:
 		phylink_stop(wx->phylink);
-		/* Disable TX laser */
-		wr32m(wx, WX_GPIO_DR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
+		if (!wx->ncsi_enabled) {
+			/* Disable TX laser */
+			wr32m(wx, WX_GPIO_DR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
+		}
 		break;
 	case wx_mac_sp:
 		phylink_stop(wx->phylink);
-- 
2.51.0

