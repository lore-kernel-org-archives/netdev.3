Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476122;
	b=sxWNf47z0fQ3220GTZVfLgPAAX02PSsPLbqWWRnKB+bwHbESa2zmU0ts7h7Bv6IZoVML
	 I71AswbX+DE9RbYtr3Wr0qc3sf3PbDVSpm9BIvycd5nGsRhQNG5DimeQsWIfLryXZRuii
	 JOJ4kochnWAfVJJ7c7HOIQEYn+Y7gLWAViqBvoqaH9Yc7fG8ZGl4t0dEKSsMpu15Y+ekn
	 E+ECsuZ/mMzAfaiZQdaycmrPbZjFWMlBuS8JL+NTZJCKSGv9rCQ32Er2qSfvqzHjLSeQF
	 dU3TNkSarL4XMnSp5kqYYi9hSRCuRrAmpORJ2vVZ7u9R8v/Qmctg6QRqZlWdyOdH5oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476122;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=dxusCF+SCBpsU06K6fJnpcskUHP+HnjzTEukSq9PV8s=;
	b=UkICRkoOWlHZykIdkfnOpKMmoWbIOPy9AXefm0pcKYrvSOQBS3EFdeWauPxvrWuF3qyq
	 fJqkNE83WgHz1r+WBwgROREpkUCVb6NOOnBbiiCOroWSjO1QHYIeI2fhZkP1k+M03quXE
	 c5PVbB+QrvLcQd+MQk7aznzK7wH0UdzjnkSsfyXGVhGaMQZmLbr0Vt2GPcYKfFuQnIHYk
	 3a4Hg8nXEEL/eE4CIu3RPjlnEZdrnn9HZpDPmi+EuaoyFV/p0Fr6gV2Gl6mMs0BB19d1/
	 GXop+5kRjPw48Vd6EQNX+rfgrD1WlSishqekp1L1S3Ba77zVDZDz4m5hcLHWyR2TNQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=trustnetic.com;
	spf=pass smtp.mailfrom=trustnetic.com;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE679606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE679606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1792476082t9dec0bc9
X-QQ-Originating-IP: gYcqKoZ9eX98CpMxhfGf3oKSABLm82azbsZ2weh/rwU=
Received: from lap-jiawenwu.trustnetic.com ( [115.205.193.71])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 Oct 2026 14:01:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9930145804730570897
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
Subject: [PATCH net v3 2/3] net: txgbe: keep MAC enabled for SP devices that support NCSI
Date: Tue, 20 Oct 2026 14:01:06 +0800
Message-Id: <20261020060107.25636-3-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: ND3CPZxVFFQcv/AXvxFKCXf4dfghPe0Mm1ClRTpjUN8JAcTVwAjyxFkZ
	hmk1SfW0T2kDEaNban0pouzQ8Wei5w40xybHmmF3YMevHKOomHG02qfKGuqghM6FmF/kT71
	W+E/OhfsuzlyqpA8Gi2tR0IbdGseMH0Vh1CdYOKbfva6N4dFJmUA9KORcfGVMJ44M5OqswI
	hYngLVqHSvo8VVhlIq96e0JMYEErdDArv2qpiAmZAEY7t+44WldKvhL4nbMpRn+CGsVrC+u
	m4FdkgqizsT50TNsgh0z4eQh4Xqr6I95bmBtT00iVgkfDGNcdZ0gXPOEErVkqEQP9hAGvNQ
	itU+RHDYyO7NVYTd6tEN3EsmZNTqKUXlbOWFFLohluWdhUVOeANJAUwjSoQYS7tyyltnt79
	uDtpYjPYtTaKsTtZG+u8vpjW7tShB5UfBsSk1LxOQi2FAqvMtKT+aPPyo+HfnA4+khnd/no
	WOnZ5BxUxJ66cQRZc1EdDq1IS0yd3aZj0cbcr5eLVt498WdDFlJEgopDTNPpSWc8aWfYZ5D
	jbiy4agoC1Ft3zksou6QEDYefSWD133Ce4KfdL1lhVKFSbxQJsnMeA2YC6S6LAx+2LPLg4d
	UXb95j1oSJ8+7na6/zkxgpjDk7I9Y0+jB0XWtpAKvsG3QwLAYLuTui0Xb0ifZy9Jhbhsp0Y
	78NtmtQtHrwPZYPiT5gMAYNNAhitvxWBrg+vosdrYJQsuYOAJb9kTqloxVa0/ghM4+Ineef
	3qQbVtM9UOESwQGE1xrfXjVR2cm+olubEHRuWn7d3G7V7Az+Y9/gc3GbYzsRsbp8ggDgsEX
	T5QkhbT1uvNKXEz+v5RE6gIs/9Oen7fnLqdbzOtTRGJUh+RQ8yQT1Qlwj8Tw+Ls+4A+Qqib
	qfmkuxVFPfvRS8jJuSqsgAAu5xBh7YCZbFZ2JYevq6gkiH56PAezZx6ScO1nWR/ejhYdEnv
	KMdCyniCMnrrIC5sGemArn+7e8Hi1VdEgrdgVXTOhQ+448oCc/tQ1MY2ilQK9tGMlK6gGhV
	0EPvPXRO0RsFnSPRPJkWfnd84hYsnkEqWFoLUfmVjHzJur4D7QoF04tUAlC5uDnqhfJFyGf
	w==
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

