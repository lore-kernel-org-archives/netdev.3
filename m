Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B5440A09
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857242; cv=none; b=dx4N9RyNWJxQaR7QYvzUYlP+mohzW6VghEN/OtjlPNLSOvlfRAvf764NOYte22YoIP6liYWzaiZnPJ9yq9K5nP2PUyZgbKTx+FSMwx/HA2GCmY2san+bJ5ktLt3JE2ZEvfDtRmLnNce/OnhO1eWQrEsobS9u4nHGVocG820CADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857242; c=relaxed/simple;
	bh=7RhcOh6j9a4iDxvmyKr9avnTpPJ9y3LaGCJHB8dz9jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGITmj3ILhPsDk/8pH4THGw4lCsOfkrbV/yRqvX6ltNg8pcRSnQVuM5JVByEbppzFaC9ZrIl9N024AjJ8eNWjqwFU+uON9F/jVqmoaXEx6m3ISJT1o91iX/Pvk7yw0ohd3ETkSEz42AlqWmeVAeplvAW9kM24AJD76G8WV0GW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1791857208tc64b5b64
X-QQ-Originating-IP: hKpsr8gLs0lJHnBoS5xcSXJMUFQNORpjBwWo0s4ULVA=
Received: from lap-jiawenwu.trustnetic.com ( [115.198.217.6])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:06:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8525594059281678314
EX-QQ-RecipientCnt: 17
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 2/3] net: txgbe: keep MAC enabled for SP devices that support NCSI
Date: Tue, 13 Oct 2026 10:06:25 +0800
Message-Id: <20261013020626.5548-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20261013020626.5548-1-jiawenwu@trustnetic.com>
References: <20261013020626.5548-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NDgMZBR9sMmaHOOA450PVBH69KCw+edEUPP+KuXXCrklgi8R1L0gY8d1
	vJ0WC79vkcYPBsIoF/liJFLcTaTzG61IDn0WGiworjooNHC10H1WUo59VfwIslm+SZaRap5
	3dR12l/eUvVpA73UtXL/oktWrdGKLTLya+BeyoUjrFA4pzI17OJypKIW3rISopVpXHpLhzu
	9uWHm9GfXhjpRGmpzUdEhXq8Aw6ZgC+lLdOcU0SHiCyFsnmG6nG+Do+iyduPV8YcDAPTuzY
	/NMUfdvBCt/jhVSwUEedolRvtFS6TYLN36F11cPdUfFS5t6PHgiMJ0dLY7dI29tPg+H7jZP
	MKc1bTWa5RTXCa2C6T/MoOL+KZ4xZcdr1jfzjfm0FJuHsU4NmY46UvqswS7fGdcWrbCFlNA
	7eYzpbAOE4LsBFHOEcH04WBoqeYzWM4AcO2EOHzpPVI5R5RFTWqVw2I+d5RQmnxO9T419l3
	N3a5yJdvQRDYr+q7G23tUlrZgM1BQFlM3wxeC2VO0xDndWSizCH5UgHOqejPongasJ23e9a
	mwIoDGHDMkwv6zx3C7+eaULYdOvvQkMX3RfMACqrT9Ebw1a8D6XuJI+M63eZWjHAquHCBdm
	xneVjha0sHUazW+f7ZK4Sw2OdDYyv5eyv+rDACVOBkDa+aAu7QYJjISEZs5XinuOib97CVw
	vW6lHZeeimDQuBInxZPFwErsaVho9MmSMDUVL6TNfXWWcmYa1JYoJRTzslgHBIYKdDjqHY4
	54iT3+teqE0gcp/pBDACcAJx2xSsp0mCFIZxaEbt0PNX/KjkdsFm2bL81yQhtmlIZmFfLUu
	SchGh3iu+op9B3wIUMM049XvpLMDu3hOF7GQaMeecL91iKeD3PE1dML+TClmLAo7QX2wM/5
	kgXmlg737gm6lI43zKe2TDgf0bjuNn3St5D0xRpxJq39MUGUaDciwg0PK4lJvm4NdAaKNE9
	HhyT9q5wtSA5stI+IWn7CJ5+7VTJ6FrMP1OMI+Z/pzyDQPpXhUDJZnS2NGizgDW9KIf/kn5
	T+afreYNtyzPTCBIzV+IWoklepr41IWxq4ixLdeQtYnXpUbz5lU5BIUqaoWHrRBVc7HRwhU
	43AmjRdKPDJwAUebrHjQHAVmhH2hBP7gw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

SP devices using NCSI require the MAC transmitter and optical Tx to
remain enabled when the host interface is down.

Skip disabling MAC Tx in mac_link_down() for NCSI devices. Keep the
data-path shutdown in mac_prepare() for PCS reconfiguration, and
re-enable MAC Tx in mac_finish() without waiting for host link-up.

txgbe_down() still performs a LAN reset through txgbe_reset_hw() after
the MAC is left enabled. This does not clear MAC Tx on NCSI devices,
because the NCSI firmware protects the MAC configuration from the LAN
reset, so no further re-enable is needed on the down path.

Keep TX_DISABLE deasserted while an NCSI host interface is down.
Retain normal SFP GPIO handling while the interface is up, including
transmit fault recovery.

TX_DISABLE is driven by the SFP core, which asserts it at probe and
whenever the upstream is stopped by phylink_stop(). Neither the SFP
core nor phylink provides a way to keep the transmitter enabled while
the interface is down.

Therefore, handle this in the GPIO controller: requests to assert
TX_DISABLE are ignored while WX_STATE_DOWN is set on an NCSI device.
WX_STATE_DOWN is set before phylink_stop() in txgbe_down() and cleared
before phylink_start() in txgbe_up_complete(), so requests made while
the interface is up, including TX fault recovery, still reach the
hardware.

While the interface is down, the SFP core considers TX_DISABLE
asserted although the line is driven low. This does not affect the
SFP state machine, which stays in SFP_S_DOWN until the upstream is
started again and then deasserts TX_DISABLE itself.

Fixes: 08f08f9390e4 ("net: txgbe: Support phylink MAC layer")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index dc9f243146580..589ad5d2f17b3 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -182,7 +182,8 @@ static void txgbe_mac_link_down(struct phylink_config *config,
 {
 	struct wx *wx = phylink_to_wx(config);
 
-	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
+	if (!wx->ncsi_enabled)
+		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
 
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
@@ -253,6 +254,10 @@ static int txgbe_mac_finish(struct phylink_config *config, unsigned int mode,
 	txgbe_enable_sec_tx_path(wx);
 	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, WX_MAC_RX_CFG_RE);
 
+	/* NCSI requires MAC Tx to be enabled even if the host link stays down. */
+	if (wx->ncsi_enabled)
+		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, WX_MAC_TX_CFG_TE);
+
 	return 0;
 }
 
@@ -368,6 +373,11 @@ static int txgbe_gpio_direction_out(struct gpio_chip *chip, unsigned int offset,
 	unsigned long flags;
 	u32 set;
 
+	/* Keep the NCSI transmitter enabled while the host interface is down. */
+	if (wx->ncsi_enabled && BIT(offset) == TXGBE_GPIOBIT_1 &&
+	    test_bit(WX_STATE_DOWN, wx->state))
+		val = 0;
+
 	set = val ? BIT(offset) : 0;
 
 	raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-- 
2.51.0

