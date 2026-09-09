Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD254EEA5
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955713; cv=none; b=Q+OrjnPJNJNjgJRVThVR2BE5NTKvX9HzDmi00jKKCCO6GQeoic5Ubz40I7cOTp5w6aTchR3QEfLObqqMa+QXj/QHz06Rxcbom0vFYO+7DwZKN2CDXTJ2Q+dwA1kZ+brNMpUW2GjgD0sbqWKjrjJ9wOVzdG7sYHxnl1/QTtY/bTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955713; c=relaxed/simple;
	bh=FEYAAO6pCKqj2A+BD1FimNGZyov3kVMVDmohN6P/W5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvKXM7GizPwIK86RAG8FO7aZ13RC8f5iNrLITN01x6UYcWV630XKUGYr5TOMM+TdBSLYCqtOom3xMdQb1yj1ldTgdi3k8z/t0Z9puJn0zWYf8JrB48YovEMl1bYw1LnKvqTWbJOWSQt8W1j1cgL+U6/D1/4WZJ0Eh//iONbc9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVBcCjiA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVBcCjiA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d05d51553so34495185e9.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788955710; x=1789560510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TprgLdwsI5e3Seg1jFebtv2HCsPpBUoE0nDTX9l+dok=;
        b=VVBcCjiAqjS/1LWiJC5dg1P510ZN0S0rMfaFKRdU8HeB1f75234AH1B/XxR5lb0WR5
         LXyomIR1dSqnNu8VVICuqcDGV3+a7w1QDmcGcOwLMi26JYigGGeTu2x8Hj0FD9VAITe3
         dVP3qbTiiBgnPwa0z+oBRF6mpkVX++fDx0mSzJpfxci3z04SAOrigfudPxrpFByt/ri0
         2S2fmWinIqqo3xhSqa+KXDtPtBOENpxYMMnAsr3LP4HfVjl92k2zSnupWwg8g9yO+fUQ
         z8u8aAsic0C4C5Slok+RCWkjS/3GlUJnfZt1OtysCIMUTOQBDf9hS4/Z++JAD2prDztA
         202w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788955710; x=1789560510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TprgLdwsI5e3Seg1jFebtv2HCsPpBUoE0nDTX9l+dok=;
        b=Jn7WxeF1aoai/0uXSSGx9DBQGsmOsZqjHrDTjbB2YWP7KKfHXyXz9Cw76XOsFcPBdR
         2DDIUw67XpZgfwNYVn1PKey4hyjujoIgl3Ur4w2tFw3fb3wzUTGho+DK50IkaaMaJtjo
         +rpd4D9UdHUgi2IHed4CTlF6n+r2MxnHQx9TFMQAfzHLc/mV0UnnlYywmbDEjnKcC4KL
         fukuMrV4kLH8PmGFU/Tbcligv5akeo5TPo/J38IOvXtRJf7d++BCLrIVuXPWGLt7nCmt
         MduHNXOvguuSm6OTFngDrv/sJku2PNA78gyB0dwxW1pXSsPaVnqKVDBWTcq/SS1t2Qh9
         Sc1g==
X-Gm-Message-State: AFuF++kl6HIyu+nXkBjwIsRHo8qR9JxyAg4SzpXxPGDDPijdlz7ObrD9
	at048k2moXVw89kHL2ggo5xqbu9JJKMD5su5AxuTQ/O8O3bJ7+9NS0aw
X-Gm-Gg: AYBFou3G7Mkq5ljr7bFRO1N0mWLHOrmHaXcwbDFWmvpKlYGphITgOw0nrP12h6eiHw9
	4TsOzNbYkU2ecN5PqC7LhmnFKpRPyousewbso3zC/U0HotMyqS9A/Kdl6Me+hJryHUdrhpQbriP
	spotHYkUz+8grypjB5JdkkULuOceN4ZOZnIDGWdNs+SEuMj0FanVPbTrwTTDLngY3JW0B3WP++O
	GBr6nx3GzYzdhURcDcQim07/txWWb2YJp2GIlD0GMzEdhDt7906Basmkxpub/62QDxGp6x8t0au
	7DVO8dU3KKvxuxVwGfRuPH3aaFJHxakBFEFNRZil6FF0kl5OhIv5PS8DG21mYpWoIC3cGObZflA
	qgOAEM2C5uXSr6gsZMUMAcdvrBZ4mPHtht4/QhmMN4PBv+B6xtYia82rYxRO4KSC970qxF/UKZ0
	KrvgbharzkhQBPwGkjGh3iR1OAicMrYOEC5XtnSisX6S/WiOM/L+n+hnx4DG4i5B9kN4ks5jwGV
	J6o1KZqTSe9bvU40teAXA==
X-Received: by 2002:a05:600c:a05:b0:49c:fc6e:a3dc with SMTP id 5b1f17b1804b1-49cfc6ea772mr315974165e9.27.1788955709705;
        Wed, 09 Sep 2026 05:08:29 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c51:e108:176f:2adf:3ca6:dc52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm41762835f8f.22.2026.09.09.05.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:08:29 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanislaw Pal <kuncy7@gmail.com>
Subject: [PATCH net-next v3] net: dsa: realtek: rtl8365mb: wait out the full chip reset time
Date: Wed,  9 Sep 2026 14:08:25 +0200
Message-ID: <20260909120825.33350-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Realtek documentation gives the chip 1 second to reset, and the driver
says so in a comment, but it only sleeps 100 ms and then polls the reset
bit and continues as soon as that bit clears. The bit reports that the
register block is back, not that the chip has finished its internal
bring-up: Luiz notes that older parts such as the RTL8367R need
noticeable extra time after it clears, so a driver that keys off the bit
alone is relying on that margin being zero.

Sleep out the documented second before touching anything, then read the
bit once and fail with -ETIMEDOUT if the chip has not come out of reset.

Probe therefore takes 1 s on every chip the driver supports, not only on
the part this was found on.

Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
Changes in v3:
- Drop the deadline arithmetic around regmap_read_poll_timeout() in
  favour of a plain msleep() and a single read (Luiz, Alvin).
- Retarget at net-next and drop the Fixes tag and the stable Cc; see the
  note below.
- Link to v2: https://lore.kernel.org/all/20260908174403.420507-1-kuncy7@gmail.com/

I have deliberately not carried Linus's Reviewed-by from v2, since this
revision replaces the implementation he reviewed.

On the evidence, and why this is no longer posted as a fix:

v1 and v2 justified this with cold-boot failure counts from my Archer
AX55 v1. I no longer think those counts should carry the patch. It is a
single four-year-old board that has already had one confirmed power
supply fault, Johan cannot reproduce anything like it on an MR80X v2.20
with the same IPQ5018 and RTL8367S, and Luiz's own observation is that
family C parts should not need the extra time.

Alvin put the dilemma precisely: either the supplies are stable, in
which case a cold probe and an unbind/rebind should behave the same -
and on my board they do not - or they are not stable, in which case the
board is out of spec and its behaviour proves nothing about the driver.
I think the second branch is the likely one here. For what it is worth
my device tree describes no regulators for the switch at all, so there
is nothing for Oleksij's series to consume; I will follow that up
separately rather than hold this patch to it. The device tree you asked
about is not upstream yet - it is in the OpenWrt submission at
https://github.com/openwrt/openwrt/pull/24197, file
target/linux/qualcommax/dts/ipq5018-archer-ax55-v1.dts; the switch node
has a reset GPIO and no supplies.

What is left is narrow but, I think, still worth fixing: the driver
documents a 1 s reset time and does not wait for it. That argument does
not depend on my hardware. If you would rather this waited for someone
to reproduce a real failure on a healthy board, I have no objection to
it being dropped.

The companion patch, "let the SerDes PLL settle after the data-path
reset", is withdrawn - its evidence came from the same board and was
never isolated from this one.
---
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -136,6 +136,9 @@
 #define RTL8365MB_CHIP_RESET_SW_MASK	0x0002
 #define RTL8365MB_CHIP_RESET_HW_MASK	0x0001
 
+/* Time the chip needs to complete a reset, per Realtek documentation */
+#define RTL8365MB_CHIP_RESET_TIME_MS	1000
+
 /* Interrupt polarity register */
 #define RTL8365MB_INTR_POLARITY_REG	0x1100
 #define   RTL8365MB_INTR_POLARITY_MASK	0x0001
@@ -2981,17 +2984,27 @@
 static int rtl8365mb_reset_chip(struct realtek_priv *priv)
 {
 	u32 val;
+	int ret;
 
 	priv->write_reg_noack(priv, RTL8365MB_CHIP_RESET_REG,
 			      FIELD_PREP(RTL8365MB_CHIP_RESET_HW_MASK, 1));
 
-	/* Realtek documentation says the chip needs 1 second to reset. Sleep
-	 * for 100 ms before accessing any registers to prevent ACK timeouts.
+	/* Realtek documentation says the chip needs 1 second to reset. The
+	 * reset bit clears before that time is up, and it only reports that
+	 * the register block is back, not that the chip has finished its
+	 * internal bring-up, so wait out the documented time before touching
+	 * anything.
 	 */
-	msleep(100);
-	return regmap_read_poll_timeout(priv->map, RTL8365MB_CHIP_RESET_REG, val,
-					!(val & RTL8365MB_CHIP_RESET_HW_MASK),
-					20000, 1e6);
+	msleep(RTL8365MB_CHIP_RESET_TIME_MS);
+
+	ret = regmap_read(priv->map, RTL8365MB_CHIP_RESET_REG, &val);
+	if (ret)
+		return ret;
+
+	if (val & RTL8365MB_CHIP_RESET_HW_MASK)
+		return -ETIMEDOUT;
+
+	return 0;
 }
 
 static int rtl8365mb_setup(struct dsa_switch *ds)
