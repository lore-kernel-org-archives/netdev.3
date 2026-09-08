Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB359650E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889452; cv=none; b=G7ImFzrVP2Xsv9YoCxtW3INvn2JLYV559gkVFJH3QtLViSTenroS5T3acJCZnUFlrzNqDcCq7+opZNnotM8BCAkXv5+JHeEznf5KXhlBAB/5qbfHYKYhQVbL99J9pDLBrSF83q7pDUPslIzsK6abXuwGJCh3I5gDWEQy+6xfwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889452; c=relaxed/simple;
	bh=hNRuYcb3+zszQAJDDATE5Ow+eYTPQVx0lvM1l3rHFKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIiNiFB1Y8sciX++YU5XT8Y4muL2N4yp1lfSPycbYTNpQQj3SUGfEb39hhH5dkjn4viT66/q8yKrtk5aaKnClpLt5hlkjDP7hibog41i+4Nb4Ho+i7Fv00i2ajUuzsmr4IVnOvfG4BCy4KJ7z8tOqz+v4xAdcut81ldFjEfW8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dglnCGna; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dglnCGna"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so38833245e9.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889449; x=1789494249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcJ35m9tvamfPDaA2SBLbKOnO2OqX0gIoTTWWORdBi0=;
        b=dglnCGnaRvWdPdQELSEvxVxyR6hFvmhF2DRTMtfEc6X895ilpPthTAfGP97hw8ayoH
         aVbCOEG1CM6D+HIHt5dYJvZZRVPpJJCa6u13jCsX5uOYgl+WR1TAglW3KuAypI8qwG3e
         3ga5XhSrx11F4dQtAU2QUm1CydS55HNz6j04NPv8H36MN1T5UBVEylvzO2EASYOF3P0p
         KDA6fW6rROKbNxuNw4GPaSynlKzfepq1MGp3DbLvKBqLyTnfYJz2sx+B/osx7zjM0WQ7
         tkbAoYVuItLFQ05U+/av7mXbj7jGWchDZ+QxTHgLWOWhzkgP3Cv7hghX93fGVKjb57xt
         fx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889449; x=1789494249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcJ35m9tvamfPDaA2SBLbKOnO2OqX0gIoTTWWORdBi0=;
        b=Mil/pRLav00iaAHmhDr6thsFo3QPYyRzyjYBcLyhKOMeXQJva58v8m8tu98F+Y1YHD
         qJuAb1KoevzWdKzspIaMULf36ft1gLkFBD5DedDnclG6pUwmaJ2XF/xy3C9dBY1uukaz
         Y+ND8T7vB2Iv6VaOzkzXyO+lQzQH0PThAXIPP2j3VcawCbTnnF834VFKlqFad5e0UAHM
         FZeRmhZhGIJ4qwBYqhYxngK3KZQqXe19DUKhCvuBW2dAvtiENMjiWcLt8kqC1LIC8kes
         RLi19KuEu0lvvPQWPPh1c40gtZUEGFva5xOajS8a9rV3u3H9bGVMxk3abQBDa1N+LCkR
         RnMA==
X-Gm-Message-State: AFuF++kvUHB4mrg0DSbFM5fXUz0mNf1Ze7R91ph6DS3qdc6W9BEInwHj
	QAqz7fuauKQARqf4kYF0NOIxbasDQ2BNOBBOXtZNGRenMEa/0IV+22XR
X-Gm-Gg: AYBFou0c14owPuXw/C1UJ/zH4pb4GIsVf4LKAraUwg+fAbB5Hwiw0s/nMqqr1z9kakv
	10CKqw7+Xp9mlzew5iRCPoSa5w39ihwGoyi/rSUhEcsMQT/tIRcUA9cKFpJaTx5AmeoKHiUZTFg
	0LZ5OylkJu87XuYGRAp4SzKjNdILgMvkTL36f3axcDA0DgyPPMUI+6Si+KCqYP3zDIjpcx9iKJZ
	xAONwTzFhhM0nF7h2Tha16YIPCB5ECDQI89MHeuA1Kec5q+mNShCFaX2EiyhMtAJRGFhZl5+nxr
	N8mQbKtfZsEi+Rz628AEknJZR9yiEALcsOxqXcNqzOx+0plVxVz+zKAhERORgQJh08lUq1pLa6Z
	9JIj8pP3mw6WTkYfuQT+FCwmmeOVeAClEZL2KBSdqhL35Rb0jCDJ/2BLolz8X32pxGPohv1EW/V
	4CM1bil9z6flfMWYMe3sLuyrpAS1WzVzseZ+REmRKbY5aCAt+ZTlvuBKFF1fwFFmDol5b2QxFpd
	JDgc19MWQ==
X-Received: by 2002:a05:600c:a49:b0:49c:fc6c:be0c with SMTP id 5b1f17b1804b1-49cffdc3823mr240544975e9.18.1788889448553;
        Tue, 08 Sep 2026 10:44:08 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:cd1:262a:7008:e441:b965:c64d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f815bsm306646455e9.4.2026.09.08.10.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:44:08 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanislaw Pal <kuncy7@gmail.com>
Subject: [PATCH net v2] net: dsa: realtek: rtl8365mb: wait out the full chip reset time
Date: Tue,  8 Sep 2026 19:44:03 +0200
Message-ID: <20260908174403.420507-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset bit clears well before the RTL8365MB/RTL8367S has finished its
internal bring-up, so configuring it right away makes register writes to
blocks that are not up yet get lost. The switch is then left half
configured: the CPU port link comes up and the switch still transmits
towards the CPU, but nothing the CPU sends is ever forwarded - no MIB TX
counter moves on any user port, while the MAC reports every frame as
transmitted without errors.

The driver already documents the 1 s reset time the chip needs and polls
with a 1 s timeout, but stops waiting as soon as the bit clears. Sleep
out the remainder of that second instead, measured from the reset write,
so the total wait stays at 1 s regardless of how long the poll took.

Seen on a TP-Link Archer AX55 v1 (IPQ5018 + RTL8367S, 2.5G HSGMII trunk)
on roughly three out of four boots. Unbinding and rebinding the driver
always fixed it at runtime. With this patch: 6 out of 6 clean boots.

Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
Changes in v2:
- Declare "remaining" as long instead of unsigned long and drop the cast
  from the comparison, so the sign is carried by the type (Andrew Lunn).
- Name the affected parts in the opening sentence instead of "the chip".
- Link to v1: https://lore.kernel.org/all/20260907191940.806734-1-kuncy7@gmail.com/
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
@@ -2980,18 +2983,38 @@
 
 static int rtl8365mb_reset_chip(struct realtek_priv *priv)
 {
+	unsigned long deadline;
+	long remaining;
 	u32 val;
+	int ret;
 
 	priv->write_reg_noack(priv, RTL8365MB_CHIP_RESET_REG,
 			      FIELD_PREP(RTL8365MB_CHIP_RESET_HW_MASK, 1));
 
+	deadline = jiffies + msecs_to_jiffies(RTL8365MB_CHIP_RESET_TIME_MS);
+
 	/* Realtek documentation says the chip needs 1 second to reset. Sleep
 	 * for 100 ms before accessing any registers to prevent ACK timeouts.
 	 */
 	msleep(100);
-	return regmap_read_poll_timeout(priv->map, RTL8365MB_CHIP_RESET_REG, val,
-					!(val & RTL8365MB_CHIP_RESET_HW_MASK),
-					20000, 1e6);
+	ret = regmap_read_poll_timeout(priv->map, RTL8365MB_CHIP_RESET_REG, val,
+				       !(val & RTL8365MB_CHIP_RESET_HW_MASK),
+				       20000, 1e6);
+	if (ret)
+		return ret;
+
+	/* The bit clearing only means the reset was accepted, not that the
+	 * chip is ready: register writes issued before the documented reset
+	 * time has elapsed are silently dropped by blocks that are still
+	 * coming up, which leaves the switch half configured. Wait out
+	 * whatever is left of that second, measured from the reset write, so
+	 * the poll above does not add to the total.
+	 */
+	remaining = (long)(deadline - jiffies);
+	if (remaining > 0)
+		msleep(jiffies_to_msecs(remaining));
+
+	return 0;
 }
 
 static int rtl8365mb_setup(struct dsa_switch *ds)
