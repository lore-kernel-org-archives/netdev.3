Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304811;
	b=QFKlMsilVuxMOfqo2crd8bob46zEXfg91SMPkliGWM6jIxjOKf8fhwt9rFdSmfO3SvDU
	 o6mY/0FC7ySc0oYjtmUiJn13s5p2v4ymSY6XgnjfDfdoy1Gt8XDerAUshdpUgmAzZXW3y
	 7TjU6om6/jBgADamWY0tsqFSOCMskAfygF8EcH4eVJnuAw8fAJgCRtfpWq4RPE+LQCtbs
	 XbBN2D4Vn69MssP0nMliBbO6lLyGfrEmeg6q9OdJIurcg7cliQH3BxJm6XEFIKaLwpPxb
	 t8lTALU7Cx2yU+g388jOvgKoueZVRzK3Dqq+yH4CRs/1/+GCFhtngQnsVKWP7mZehQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304811;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status;
	bh=z8uqAJFPJ4rgUOnA9YNeA/fLoPT7Fur55yBh2LPSnHo=;
	b=nm4NqaOEOCvLyEx8oMAc59PgIGo7jByigbB0YPhsCWUCWziQ8j/mIhk78SNWoybkXJ0Q
	 mIePltBOZZSSypCMo7WfM2OStXNC+DBs2iTGkz8wgfB3yC48tOfEy1L4JXwbrNj5B5zZE
	 JWakJDtESkU8jVWFqx6Rd77jc448pkuPP9csHa7X40r1rYXnHk5EuH+fN8pa3frWv1Fow
	 vr8Nk8AOa7i266LC9YHgFehnxikhmHNhX0pLHgve6F7kdF/+E1D5vWW2CbJ0UmmrJRdMz
	 udE3P+W7T+dfFi6injHpIC1vGE7uy3nfa66Al5sfmXm5r3t/0xL+a+7CnePY/8IuMSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jmu.edu.cn;
	spf=pass smtp.mailfrom=jmu.edu.cn;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D73606A33C;
	Tue, 10 Nov 2026 10:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59D73606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from Vostro-3710.. (unknown [14.220.232.40])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5425f9997;
	Tue, 10 Nov 2026 18:00:04 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Frank <Frank.Sae@motor-comm.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/2] net: phy: motorcomm: add led_brightness_set for YT8521
Date: Tue, 10 Nov 2026 18:00:00 +0800
Message-Id: <20261110100001.1873309-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-HM-Tid: 0aa1c4e6882103a2kunm6bb3c9f9144c10
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHU0fVk1DThpNTRoaHRlDS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKT1VJSUtVSUhJVU9LWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++

Add support for manual brightness setting on YT8521/YT8531 PHY.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/net/phy/motorcomm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 463e1ea3efc9..bcd3afef0d49 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -258,6 +258,10 @@
 #define YTPHY_WCR_INTR_SEL			BIT(6)
 #define YTPHY_WCR_ENABLE			BIT(3)
 
+#define YTPHY_LED_GENERAL_CFG_REG		0xA00B
+#define YTPHY_LED_FORCE_MODE(x)			BIT((x) * 3)
+#define YTPHY_LED_FORCE_EN(x)			BIT((x) * 3 + 2)
+
 /* 2b00 84ms
  * 2b01 168ms  *default*
  * 2b10 336ms
@@ -1775,6 +1779,31 @@ static int yt8531s_config_init(struct phy_device *phydev)
 	return phy_restore_page(phydev, old_page, ret);
 }
 
+static int yt8521_led_brightness_set(struct phy_device *phydev, u8 index,
+				     enum led_brightness value)
+{
+	u16 regs;
+	int ret;
+
+	if (index >= YT8521_MAX_LEDS)
+		return -EINVAL;
+
+	/* clear HW LED setup */
+	ret = ytphy_write_ext(phydev, YT8521_LED0_CFG_REG + index, 0);
+	if (ret < 0)
+		return ret;
+
+	regs = ytphy_read_ext(phydev, YTPHY_LED_GENERAL_CFG_REG);
+	if (value != LED_OFF)
+		regs |= YTPHY_LED_FORCE_EN(index) |
+			YTPHY_LED_FORCE_MODE(index);
+	else
+		regs &= ~(YTPHY_LED_FORCE_EN(index) |
+			  YTPHY_LED_FORCE_MODE(index));
+
+	return ytphy_write_ext(phydev, YTPHY_LED_GENERAL_CFG_REG, regs);
+}
+
 static const unsigned long supported_trgs = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
 					     BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
 					     BIT(TRIGGER_NETDEV_LINK)        |
@@ -3266,6 +3295,7 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.soft_reset	= yt8521_soft_reset,
 		.suspend	= yt8521_suspend,
 		.resume		= yt8521_resume,
+		.led_brightness_set = yt8521_led_brightness_set,
 		.led_hw_is_supported = yt8521_led_hw_is_supported,
 		.led_hw_control_set = yt8521_led_hw_control_set,
 		.led_hw_control_get = yt8521_led_hw_control_get,
@@ -3288,6 +3318,7 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.get_wol	= ytphy_get_wol,
 		.set_wol	= yt8531_set_wol,
 		.link_change_notify = yt8531_link_change_notify,
+		.led_brightness_set = yt8521_led_brightness_set,
 		.led_hw_is_supported = yt8521_led_hw_is_supported,
 		.led_hw_control_set = yt8521_led_hw_control_set,
 		.led_hw_control_get = yt8521_led_hw_control_get,
-- 
2.34.1

