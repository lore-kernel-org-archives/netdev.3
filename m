Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220E4ED1B7
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562291; cv=none; b=Xd5HzBg9oxuI08SsOHokdqsf+uqnrqtlNBM3Uj8JndxT36qyVwRK55hQTQf0FYzeugBDzTsvORowwOYWZh32lyvrF+G+rVNDfot4XO+eKIMesxJdKZcPJtGDmYeht7ERVWui7ok5ZQr4lHvRHWBhdZTCU1swhiJnX3RDHmicIGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562291; c=relaxed/simple;
	bh=MfmS97tEUb10gYE/u3qgJEuKsvGjsyPjvMwC//JlJ+M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwuC6Ykj0P/us2Szj4m5p4ZSRJQjdB4Tlp0BomwmOGQJl5+kd+mQ1i5hgXoZHdPaejYlS+tDyk3fzXHLf4vJImuubQ8HL9G846Ac2tlXwCF7Mafej/RPddvgAnR4iAdXT7q0Y7w/5xnw8Gh5VoYUkxpOfQUbSgzcR0jQ3AcupQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4N+vy7G; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4N+vy7G"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-487048857f6so3884134f8f.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791562287; x=1792167087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Whz6EeGgKypqRBi5YrO/rCW1xhvllxiK3E64CG3XL+M=;
        b=i4N+vy7GLyIryAI8Y9pfE42eVz9YkNkc0dpE0wUdtZ8RgstiMbySlO5DMeLy+7vOGq
         sS7IapvgZ7yZfyfrb930TKByVW4Vq+19YN57r2JRMx25WuvdJaxVJy5QHUQhVoWs8UgK
         Flw0uMlOsiiOesiFPzZyrdMPZcp5MFHI9j1Mt0tGNJtQDRYrOsg5DkKU2JlrzMgy51nJ
         Dc4/sSLNCFfw17Tx1KLYYJ4x2UWzEZpOFz2dwahSYMjRjaK/R/ckQSn1DGV943RxDCvc
         nU3cV7eTv9RNF1Uj7k2tQlzyzvcGUUUH4Xp3kBld7L4/3T72vRAhtlfjQxkIn/CSpz+H
         k15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562287; x=1792167087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Whz6EeGgKypqRBi5YrO/rCW1xhvllxiK3E64CG3XL+M=;
        b=SWfj2D4Xulg3ctEgtBHIx8PVZZK1eIA7v/kpsLj3ALep6vhYFxZMHNkNB2EzsXRMjN
         99C6dwSe1s2doGTQMLiRrYheD2gyacuboO8yI3+t2OZf0ZI5X6pXZUSNFN1ZeZ1YbVAx
         7W6OY3fWVgi2UZvYI4OzuilEBAAN+5DXwCBwKGvNe1KZIkAUtpEI9Aiq8WCPLdX5CFdA
         NEivzzZA18hos4p4Hn5kNNXsC1f9bA/l86xeQe/a5OIYnk0evp4xzAimQPNnPz2VmI81
         uELnubFrycntUd9P+dqXG3blZFENr665kjSrWQS2qCvzKwkosb0/cfRJZSZnYzyHP2cr
         qT2w==
X-Forwarded-Encrypted: i=1; AKwUvBwUQGnQ3WXAK6sUW171oRC0Yz1KUB5krmRC9CmAhAdCV21dBrtMTwu+IR6qdFOHZUUL0Qal/zI=@vger.kernel.org
X-Gm-Message-State: AFq9FYINYeXm+QpYK/YmuvtFhF3ZOCz6iJeYgjl7oVzZd+xhQck94kO8
	MSRTkh/bxZx5z9AoRrspGGSWtSILSQxAUVJ1B/Erq755J7du2aITvBjB
X-Gm-Gg: AYBFou0LtcYgBog3j4crTdNvaJ3okJtcVJubWs7N/I56RpxLXEs7mIAWQjNwC5oJaia
	Uu3Onf+7P2dpzczYW3OIvvBU0m/ezhCj0cn3yVH1LUMUSSvZlESuWc8Vw9x3QW8fgP2EcUcnXIj
	zLpOc8d558JHVsxLEW8RJtpd4lPi7L0wTBwni3W5GyjKNZjyNIhHSoabKhB0hgj0NGxsr3TGDR3
	YIvtUmLqgl3Xuebt6OEUcxN7bgN/K0sIcuz4qipDfZBrzLeWoPv1Zy65jWg35OiSaKJWLu8LaTd
	JSoIiKc5/2OTHCkPFXajc/jAyX01xmD8Oh4zz9j3MKLaAeLZCYddfhAl0+lsPDoX4MSTa6oX/Cf
	ypGLw1TK4tmDGkGt4V6tq+nWTGlIeb//nWARPJa2vTV5XZCguyxYtU7SpCnR2qNbasXe3kfQMY3
	hgWCkWjj0cSkyu5O6Z3vFF8HAB8kxhF1qVuXHVw95ObShx7KImKogOUm+msmD92s/8F6bTqQ3w4
	HrZ6zkvHhZC6h4ggvxW80YmnUhAxChC5gdKFg+x2lNnQObpGgqOltH48pW3ZywK7yX1woqCnNSj
	y9H0uaQjDgtYCUc8/FmXOWOE6Cb9
X-Received: by 2002:a05:6000:46da:b0:48b:1276:72e7 with SMTP id ffacd0b85a97d-48dba9db139mr3567737f8f.13.1791562287342;
        Fri, 09 Oct 2026 09:11:27 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db94e2f08sm4744701f8f.15.2026.10.09.09.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:11:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v25 08/10] net: dsa: move mediatek DSA driver in dedicated directory
Date: Fri,  9 Oct 2026 18:10:53 +0200
Message-ID: <20261009161102.38961-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009161102.38961-1-ansuelsmth@gmail.com>
References: <20261009161102.38961-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To tidy things up and better organize DSA drivers, move the Mediatek
related driver to the dedicated Vendor directory.

MAINTAINERS file is updated accordingly to reference the new location.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                                  |  6 +--
 drivers/net/dsa/Kconfig                      | 45 +-------------------
 drivers/net/dsa/Makefile                     |  5 +--
 drivers/net/dsa/mediatek/Kconfig             | 45 ++++++++++++++++++++
 drivers/net/dsa/mediatek/Makefile            |  5 +++
 drivers/net/dsa/{ => mediatek}/mt7530-mdio.c |  0
 drivers/net/dsa/{ => mediatek}/mt7530-mmio.c |  0
 drivers/net/dsa/{ => mediatek}/mt7530.c      |  0
 drivers/net/dsa/{ => mediatek}/mt7530.h      |  0
 drivers/net/dsa/{ => mediatek}/mt7628.c      |  0
 10 files changed, 55 insertions(+), 51 deletions(-)
 create mode 100644 drivers/net/dsa/mediatek/Kconfig
 create mode 100644 drivers/net/dsa/mediatek/Makefile
 rename drivers/net/dsa/{ => mediatek}/mt7530-mdio.c (100%)
 rename drivers/net/dsa/{ => mediatek}/mt7530-mmio.c (100%)
 rename drivers/net/dsa/{ => mediatek}/mt7530.c (100%)
 rename drivers/net/dsa/{ => mediatek}/mt7530.h (100%)
 rename drivers/net/dsa/{ => mediatek}/mt7628.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53dcff93f896..e16c14ea38a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16841,9 +16841,9 @@ M:	Chester A. Unal <chester.a.unal@arinc9.com>
 M:	Daniel Golle <daniel@makrotopia.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/dsa/mt7530-mdio.c
-F:	drivers/net/dsa/mt7530-mmio.c
-F:	drivers/net/dsa/mt7530.*
+F:	drivers/net/dsa/mediatek/mt7530-mdio.c
+F:	drivers/net/dsa/mediatek/mt7530-mmio.c
+F:	drivers/net/dsa/mediatek/mt7530.*
 F:	net/dsa/tag_mtk.c
 
 MEDIATEK T7XX 5G WWAN MODEM DRIVER
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index fe8cd5338fda..ffc26eb3e899 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -28,50 +28,7 @@ source "drivers/net/dsa/hirschmann/Kconfig"
 
 source "drivers/net/dsa/lantiq/Kconfig"
 
-config NET_DSA_MT7530
-	tristate "MediaTek MT7530 and MT7531 Ethernet switch support"
-	select NET_DSA_TAG_MTK
-	select REGMAP_IRQ
-	imply NET_DSA_MT7530_MDIO
-	imply NET_DSA_MT7530_MMIO
-	help
-	  This enables support for the MediaTek MT7530 and MT7531 Ethernet
-	  switch chips. Multi-chip module MT7530 in MT7621AT, MT7621DAT,
-	  MT7621ST and MT7623AI SoCs, and built-in switch in MT7988 SoC are
-	  supported as well.
-
-config NET_DSA_MT7530_MDIO
-	tristate "MediaTek MT7530 MDIO interface driver"
-	depends on NET_DSA_MT7530
-	select MEDIATEK_GE_PHY
-	select PCS_MTK_LYNXI
-	help
-	  This enables support for the MediaTek MT7530 and MT7531 switch
-	  chips which are connected via MDIO, as well as multi-chip
-	  module MT7530 which can be found in the MT7621AT, MT7621DAT,
-	  MT7621ST and MT7623AI SoCs.
-
-config NET_DSA_MT7530_MMIO
-	tristate "MediaTek MT7530 MMIO interface driver"
-	depends on NET_DSA_MT7530
-	depends on HAS_IOMEM
-	imply MEDIATEK_GE_SOC_PHY
-	help
-	  This enables support for the built-in Ethernet switch found
-	  in the MediaTek MT7988 SoC.
-	  The switch is a similar design as MT7531, but the switch registers
-	  are directly mapped into the SoCs register space rather than being
-	  accessible via MDIO.
-
-config NET_DSA_MT7628
-	tristate "MediaTek MT7628 Embedded Ethernet switch support"
-	depends on HAS_IOMEM && (SOC_MT7620 || COMPILE_TEST)
-	select NET_DSA_TAG_MT7628
-	select MEDIATEK_FE_SOC_PHY
-	select REGMAP_MMIO
-	help
-	  This enables support for the built-in Ethernet switch found
-	  in the MT7628 SoC.
+source "drivers/net/dsa/mediatek/Kconfig"
 
 config NET_DSA_MV88E6060
 	tristate "Marvell 88E6060 ethernet switch chip support"
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index 7e637d56b35c..ee4784a9839b 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -2,10 +2,6 @@
 obj-$(CONFIG_NET_DSA_BCM_SF2)	+= bcm-sf2.o
 bcm-sf2-objs			:= bcm_sf2.o bcm_sf2_cfp.o
 obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
-obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
-obj-$(CONFIG_NET_DSA_MT7530_MDIO) += mt7530-mdio.o
-obj-$(CONFIG_NET_DSA_MT7530_MMIO) += mt7530-mmio.o
-obj-$(CONFIG_NET_DSA_MT7628) += mt7628.o
 obj-$(CONFIG_NET_DSA_MV88E6060) += mv88e6060.o
 obj-$(CONFIG_NET_DSA_RZN1_A5PSW) += rzn1_a5psw.o
 obj-$(CONFIG_NET_DSA_SMSC_LAN9303) += lan9303-core.o
@@ -17,6 +13,7 @@ obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_SPI) += vitesse-vsc73xx-spi.o
 obj-y				+= b53/
 obj-y				+= hirschmann/
 obj-y				+= lantiq/
+obj-y				+= mediatek/
 obj-y				+= microchip/
 obj-y				+= motorcomm/
 obj-y				+= mv88e6xxx/
diff --git a/drivers/net/dsa/mediatek/Kconfig b/drivers/net/dsa/mediatek/Kconfig
new file mode 100644
index 000000000000..ef62481662fd
--- /dev/null
+++ b/drivers/net/dsa/mediatek/Kconfig
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NET_DSA_MT7530
+	tristate "MediaTek MT7530 and MT7531 Ethernet switch support"
+	select NET_DSA_TAG_MTK
+	select REGMAP_IRQ
+	imply NET_DSA_MT7530_MDIO
+	imply NET_DSA_MT7530_MMIO
+	help
+	  This enables support for the MediaTek MT7530 and MT7531 Ethernet
+	  switch chips. Multi-chip module MT7530 in MT7621AT, MT7621DAT,
+	  MT7621ST and MT7623AI SoCs, and built-in switch in MT7988 SoC are
+	  supported as well.
+
+config NET_DSA_MT7530_MDIO
+	tristate "MediaTek MT7530 MDIO interface driver"
+	depends on NET_DSA_MT7530
+	select MEDIATEK_GE_PHY
+	select PCS_MTK_LYNXI
+	help
+	  This enables support for the MediaTek MT7530 and MT7531 switch
+	  chips which are connected via MDIO, as well as multi-chip
+	  module MT7530 which can be found in the MT7621AT, MT7621DAT,
+	  MT7621ST and MT7623AI SoCs.
+
+config NET_DSA_MT7530_MMIO
+	tristate "MediaTek MT7530 MMIO interface driver"
+	depends on NET_DSA_MT7530
+	depends on HAS_IOMEM
+	imply MEDIATEK_GE_SOC_PHY
+	help
+	  This enables support for the built-in Ethernet switch found
+	  in the MediaTek MT7988 SoC.
+	  The switch is a similar design as MT7531, but the switch registers
+	  are directly mapped into the SoCs register space rather than being
+	  accessible via MDIO.
+
+config NET_DSA_MT7628
+	tristate "MediaTek MT7628 Embedded Ethernet switch support"
+	depends on HAS_IOMEM && (SOC_MT7620 || COMPILE_TEST)
+	select NET_DSA_TAG_MT7628
+	select MEDIATEK_FE_SOC_PHY
+	select REGMAP_MMIO
+	help
+	  This enables support for the built-in Ethernet switch found
+	  in the MT7628 SoC.
diff --git a/drivers/net/dsa/mediatek/Makefile b/drivers/net/dsa/mediatek/Makefile
new file mode 100644
index 000000000000..0ed6e11f292e
--- /dev/null
+++ b/drivers/net/dsa/mediatek/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
+obj-$(CONFIG_NET_DSA_MT7530_MDIO) += mt7530-mdio.o
+obj-$(CONFIG_NET_DSA_MT7530_MMIO) += mt7530-mmio.o
+obj-$(CONFIG_NET_DSA_MT7628) += mt7628.o
diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mediatek/mt7530-mdio.c
similarity index 100%
rename from drivers/net/dsa/mt7530-mdio.c
rename to drivers/net/dsa/mediatek/mt7530-mdio.c
diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mediatek/mt7530-mmio.c
similarity index 100%
rename from drivers/net/dsa/mt7530-mmio.c
rename to drivers/net/dsa/mediatek/mt7530-mmio.c
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mediatek/mt7530.c
similarity index 100%
rename from drivers/net/dsa/mt7530.c
rename to drivers/net/dsa/mediatek/mt7530.c
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mediatek/mt7530.h
similarity index 100%
rename from drivers/net/dsa/mt7530.h
rename to drivers/net/dsa/mediatek/mt7530.h
diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mediatek/mt7628.c
similarity index 100%
rename from drivers/net/dsa/mt7628.c
rename to drivers/net/dsa/mediatek/mt7628.c
-- 
2.55.0

