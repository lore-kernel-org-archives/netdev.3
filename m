Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCAB393DD3
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808789; cv=none; b=XpGrytCiRkrXTnmJVti48ngZDkI7sw2v3vhKfqyHgk0l05267lohrGIGqmB9ZJecCg8E33IeZZRU2Ej/HI9uIxOhWttMtID2hbJqOe2JsKbDSLsCPzxHR7IBa8cIMOYLowxcOdnvmGZJ0KcvBlFy/48eYnv7a+yOZ4qyRnpdWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808789; c=relaxed/simple;
	bh=X1cxe9LTfm0MWVMHD8ZVie2/ZFrkeJFXtLRCR4KT9k0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olBWMGQZWiXS+LMggLAtTUNLiX4ktqkWUAsYLvxBeHgQ3DkE/omrvnxD1aXPSjgDTb+IrAfOXxPhSOuP99wQOQMbnzODS13BloffiIdNyoWFWx+7ZAzll3s9ngNTVY3Dxhkxq8aSF8eRIAcQkxJB/g0XCNvGb8zSmKcKPN8kX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/jG6jhb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/jG6jhb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-482dd6ee390so4443791f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788808785; x=1789413585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P88mw7jxmkXBU/JAeuDwKiJ/YVmoCPyskYUuX4IRFD0=;
        b=O/jG6jhb92mBsrs5XrnwcNIyETLpzQ99NXtrY0cIaFNk245oYnL3PXGhNPW1UGXjGU
         Bi7wriWvvmE1ZafwehjAszmHj/7NvTcVNxgZ3hB8JG50XwKacuFRprxgiIVJXdK9aWAR
         xSfpLjTdua8hhTAWvhZAAbeMcwO7dQp6Nk/lANPeE1p707GH/MO7VF7WF9DCnOxN53xB
         42zSXZeKISsDc9TH0Vnr2nNAFnYGtEWZbWCDbfnf08hsy5VpHwtRG9czuEOAHCwGNTpl
         +NF+mNHbpDIN1WFsrnBg7n2JOq7ORKp/5VHOxlAHDP3jYT6Sw7cPzhoqpE2Q3tQxKkBS
         Kt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788808785; x=1789413585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P88mw7jxmkXBU/JAeuDwKiJ/YVmoCPyskYUuX4IRFD0=;
        b=WZta6MWqShreGboOi9kSLVIf0ocJ+WR7sTe54eY3mQF9MRi5y52XNnO0w8/WQVUuqO
         RmKPE1j/Q52kkXjK7YibrSpbOCuR4L41qW+DGiYDqdSsNcrGKrIEBMT3yk3UNdZoYxX6
         pqxLuJgHPzwxRd+kzzH6hlW5sRrZWGAMb4f5j51dNGLPOdkAzNsoXujdewZ8WRS+mh+R
         K01j6kDf8PtPxNMx+MKQTitPySps+sELPd95HCw+lMaZc7BoTdpbLf7UkJqnBjFOvGT3
         MMQx0u+JLmGZmeliJmkcP9Q+tgk2yj7sCk5318Fbf9Jt0etI22Viq8FPwFfe+Fnj7AZy
         GL1Q==
X-Gm-Message-State: AFuF++kSJ3xUFGawPGCGRDxSFKB1QoPWuMwh7bNu4AN7Vgns/OMln4+m
	Asf52LU8nCCKIQbjuDSB8y8skBr68vlnQeeYPNHa20poVILNVH938cnqs8DlX74K
X-Gm-Gg: AYBFou3PeM+DDuV+Gpp8ERggxf2/AWKAYcDJ28eLWkLFfdv+Rf+x7heDPUZzD+wKgvM
	zTnhGU96C6XhwwSUqd9gbNZQbwg+NWChckdU1vMVT9MBcpnYbltvmakJ6y2tfTKId2ljrSqOI6d
	yVu9eo4r515/sBfQhx9Ow5nZ8IYuuhOSzWbJhXi6uqCDqC+6VWKHcwN4b3VwdlXtk8zt8XB46jd
	xdnjmhFNDv4vnDSrygovFPixWqRk6TBFf+3mqNFecIVKRpyyDTPooKotYnw7CGZ7EjxC7sWifsD
	e3lFWSjES6HAFVIcryrmzSy8mRRtLITzSf1/HaRM5caaeN+ZLpu3vbGecQhXCxG49zE/4l3G9SU
	oflK6YlIOgYHPuqWCHI8pZkzqIYkUw3ySUQw+U4yti8sFPfFCJIHqIY4ouM+XMrdgtjrCKZU4gd
	upQQJvgaaw85piv2UqmKdx0qgwVyXrKB/KjXyVKYhnT21fYToJIY6a62Z44zrg13fXrjc9vfC6h
	33mWAi8BB1l1279bR7sOmffBY6S3aFWtS+sB78e
X-Received: by 2002:a05:6000:2910:b0:482:d98f:ec9c with SMTP id ffacd0b85a97d-48587050696mr26889219f8f.10.1788808785339;
        Mon, 07 Sep 2026 12:19:45 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs692038.centertel.pl. [5.184.246.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bbb51sm31975196f8f.30.2026.09.07.12.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 12:19:44 -0700 (PDT)
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
Subject: [PATCH net] net: dsa: realtek: rtl8365mb: wait out the full chip reset time
Date: Mon,  7 Sep 2026 21:19:40 +0200
Message-ID: <20260907191940.806734-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset bit clears well before the chip has finished its internal
bring-up, so configuring it right away makes register writes to blocks
that are not up yet get lost. The switch is then left half configured:
the CPU port link comes up and the switch still transmits towards the
CPU, but nothing the CPU sends is ever forwarded - no MIB TX counter
moves on any user port, while the MAC reports every frame as transmitted
without errors.

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
@@ -2980,18 +2983,38 @@ static int rtl8365mb_switch_init(struct
 
 static int rtl8365mb_reset_chip(struct realtek_priv *priv)
 {
+	unsigned long deadline;
+	unsigned long remaining;
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
+	remaining = deadline - jiffies;
+	if ((long)remaining > 0)
+		msleep(jiffies_to_msecs(remaining));
+
+	return 0;
 }
 
 static int rtl8365mb_setup(struct dsa_switch *ds)
