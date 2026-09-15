Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6F44E021
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511522; cv=none; b=M1nj7pAhW9uiHV9XHmUF9shkaZjendX0m+26bAMsSReCDVReGa8mIrCK5++FmRYpO7c6yXoeYzmChX7JT1fwgfw0v9aMXnUB0jYpJGkk3bztEPREnUKt4QH9PrMCQNPIeY+V6cynREma1QLqqUsN1cJ2LBYTNKM6meyH8I3Sg6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511522; c=relaxed/simple;
	bh=S2XZh3VaVySPUgw4QBLbbko84fncUIEkPW+FJJvR2HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjFER4VGcBsOidiniWCMOUik6kAlY0PJyshyXcZyBf7DnmJQ9h6xcA/rHsTZorkSQUemuLkPSWm9wERbvswpCvrtrsnZsf2QqLkz4k82L+CqRzZEeW3EtcyNqmv/UFPxSVg6Rjb6Q6FQk2i2HOkFVBSWcWhE9UuX3B8ebQGzz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNkeHs8j; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNkeHs8j"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so275330a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789511519; x=1790116319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zK0dUXrqiJhS7PWIeZXjl74BNkmdl+RVL7V4FpfahtM=;
        b=LNkeHs8jkAWzaqimW1OpBHWwQNsm+sLb77nTBTJGV5LR3jTczF2e0+CkQCZhlzUlbj
         iS7n+9Hw/z2HXrDHgVPOrJ6PppGzEE7iZU49fIDqiETzZMvGt+toBGcYbqythvErLwiQ
         V89wTt3b4I5AncYD+eZ/DaTqPxiADZTO91PNXLk7bkmg+WDhS9V15mjPEgrnIEWXEHgb
         wOc97lFR7JANpZSLumUNVVUxCet264RrsI9W5mUP1ynWcXiZNo0zrgA9919724XfToEG
         kIOQnNamI86owC9HRLibIW/OOkT3SrSnlgmyuSQ5/2l1C8guaytIteW1wa7C51WFZp8F
         sLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511519; x=1790116319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zK0dUXrqiJhS7PWIeZXjl74BNkmdl+RVL7V4FpfahtM=;
        b=HCEuZ47vPs8Nn/VPW1XOHScwVr1eycTqRUvXuqt3DjueCAWhRAJaKx5bCpJIm9Uh3E
         JAQVmc177z4ZT5X7SsaX52pCETnwyfwKFAakLVsJ9VazN5SYIRvYueiz5wYQE6hOgfyj
         VbhSLBmlZT8xtyUsi7jSHXa6zLOd8Uxs27+g45o3GViICt3P90EtbI56lETBoXBw1ubG
         HFI9I16AjQubSWgQyYSr0NOmApX2jsdUoNMbKhsSzhoFwcukDAa5KIKPLQHEizbiUQyM
         xzjJQL8EsM3a5kOyZ7c8kePHX98ZV6tuRYIfkHeuMkqg7NBegQD8go/XrGvAc3oynmzg
         SSBg==
X-Forwarded-Encrypted: i=1; AKwUvBwnJ7dEj3GUrVQMPbE3bx52oPfLn6NN9z1Y/97vMNeg4ThoXbUZcqk9fy3ypJjM/lsWosECEE4=@vger.kernel.org
X-Gm-Message-State: AFuF++nNrAYRJj1GguYp+eL+aRQGIXlo/HU728Lyk93xcltDB4+fdFHJ
	OpSoJoR+UX6kyZa8jvVzgb+Xy3e75hrFZBYun7MXHY+d/ZGeeHnnN9s=
X-Gm-Gg: AYBFou0AbKyg2vQxdjjgHS3XLkkHwplkvn7mV+qqAWx7nmKlbcqwv2GXh1EVRk0I1Kt
	keVdpSrDVNhSoASUy05PFVc047DVdthau/hkGR+qPLsFHpC2xehlV4Ne5FceZ59HOU9FNFRnLaI
	s1HpZ9v63f3hBwUzWzIErVVRkFbKCjESDn1WH8A/1SIWOKo2jXevtM9Whe9ErbvoRzNRf76mpvN
	MswptS1LNkcIrNnBcUsaSnyFE93vbLzZo+DjYhU0mVGVouriMv8jbxXT9YKB4lhjoDD4r/hpsw+
	iK6hz5IrIl5+96Rwww0vxSQJd1uLJEAQWOSmDcjGtdrwv/0BBpIlCkSXhlIjglk3s5YvayIE1UI
	iGbXAxlH8ika5YCPrRGFW3tW5M/UdR2TOvRjvOie9Q3NfUdVrQCUH27f8krcQyMzvJEHS5Mmyod
	molt4s2FMxE9g9v50PaL+0Wt64/qnl3D3knH+GzSFd4GHovFCpJXjEUe2EqVDXgwj2FcyrKNWOG
	/Hol/iIdSvuTeJEBuKwqBKsIA==
X-Received: by 2002:a17:90a:d650:b0:39d:f7dd:4e4f with SMTP id 98e67ed59e1d1-39e1e300ab8mr779291a91.10.1789511518725;
        Tue, 15 Sep 2026 15:31:58 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:556:537c:f7cd:8a1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1c337e97sm208036a91.2.2026.09.15.15.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 15:31:58 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Rosen Penev <rosenp@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH net v3 2/2] net: phy: qca808x: keep an explicit active-high LED across the reset
Date: Wed, 16 Sep 2026 07:31:38 +0900
Message-ID: <20260915223138.321307-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915223138.321307-1-donggeunyoo.kernel@gmail.com>
References: <20260915223138.321307-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the previous patch an 'active-high' LED node is accepted, so
led_polarity_mode can now hold 0. qca808x_config_init() only re-asserts
QCA808X_LED_ACTIVE_HIGH when the mode is -1, the value that means device
tree asked for nothing, so an explicit active-high does not reach the
register.

That matters because the bit does not survive a reset. phy_init_hw() runs
.soft_reset before .config_init on every attach and resume, and
commit f203c8c77c76 ("net: phy: qcom: qca808x: default to LED active High if not set")
records why: "on PHY reset, the Active High bit is not set resulting in
the LED driven as active-low". The polarity written from device tree
during phy_probe() is therefore gone by the time the link comes up, and
the LED runs inverted.

Re-assert the bit for anything other than an explicit active-low, which
is the one case that wants it clear and gets that from the reset for
free. Name the unset value while here: led_polarity_mode otherwise
holds a PHY_LED_ACTIVE_* value, so spelling the comparison
PHY_LED_ACTIVE_LOW says what it means where -1, 0 and 1 did not.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908105959.70453-1-donggeunyoo.kernel%40gmail.com
Cc: stable@vger.kernel.org
Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
Tested in QEMU against a synthetic MDIO bus answering as a QCA8081, with
the reset clearing BIT(6). With only 1/2 applied an 'active-high' node
comes up inverted; see the cover letter.

 drivers/net/phy/qcom/qca808x.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 3ba58f14e248..bab26e4c6140 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -87,6 +87,9 @@
 
 #define QCA8081_PHY_ID				0x004dd101
 
+/* led_polarity_mode otherwise holds a PHY_LED_ACTIVE_* value */
+#define QCA808X_PHY_LED_UNSET			-1
+
 MODULE_DESCRIPTION("Qualcomm Atheros QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -187,8 +190,7 @@ static int qca808x_probe(struct phy_device *phydev)
 	if (!priv)
 		return -ENOMEM;
 
-	/* Init LED polarity mode to -1 */
-	priv->led_polarity_mode = -1;
+	priv->led_polarity_mode = QCA808X_PHY_LED_UNSET;
 
 	phydev->priv = priv;
 
@@ -200,8 +202,8 @@ static int qca808x_config_init(struct phy_device *phydev)
 	struct qca808x_priv *priv = phydev->priv;
 	int ret;
 
-	/* Default to LED Active High if active-low not in DT */
-	if (priv->led_polarity_mode == -1) {
+	/* Set LED Active High unless active-low was requested in DT */
+	if (priv->led_polarity_mode != PHY_LED_ACTIVE_LOW) {
 		ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
 				       QCA808X_MMD7_LED_POLARITY_CTRL,
 				       QCA808X_LED_ACTIVE_HIGH);
@@ -615,7 +617,7 @@ static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
 	 * To detect this, check if last requested polarity mode
 	 * match the new one.
 	 */
-	if (priv->led_polarity_mode >= 0 &&
+	if (priv->led_polarity_mode != QCA808X_PHY_LED_UNSET &&
 	    priv->led_polarity_mode != active_low) {
 		phydev_err(phydev, "PHY polarity is global. Mismatched polarity on different LED\n");
 		return -EINVAL;
-- 
2.53.0

