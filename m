Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359E4FC8CA
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624776; cv=none; b=aPhlVdutjjAv/DyRQ91cb4FbjwhU/E6n6mCcNGEXvfM6hlbrZXY9wgr8Mfwo2SvyOauaTRxK5LECL2sjYGYYxwDus2QRkP512Q5FbTTLD6g1++p49QeY6BGFothQwt1M89aofddgjJIL7COGbV6N6zFDur9RjLW8H91kkJ/uMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624776; c=relaxed/simple;
	bh=U+JvuMxnZEvPH1bhnMd0oLYJB/5yHKU/tCjqo+6Nmts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecbrpO/5jwFQ+n9DQN9fv+6Xb1dZp3AOtuWsA0GqOY0Rt71zloe7DXukJzh89BdO5GqwYdZxywvtSP1HmJ7wiKjBmPzhxaWufN777oeDEvLqEtTuFbcUdR6ZEFkzug9eZ6yVlZfo8+G3gj6HEB0dj55hJTrT4iYlnR8XITsrnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs+h03Ba; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs+h03Ba"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-4888598e4f9so2086041f8f.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790624772; x=1791229572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wYkBWEaad7pJtWSE9fUzK8FJHWmMOd6HhAL0BzGHkSI=;
        b=fs+h03Ba1OytyniTFxy4wBwum9f6v2u3UAKSksFvZuGKdoxRqXaKOJHuGqkw284Kkf
         GbfeGIwB3sOLLdNRW+3xTuowo5EPKK9uyXcjfoghwUkn816L0iMd2FM7Wq2Gpvmt6yt+
         tO7E+z2Vrd5i3mnW10xUGEdEBKWefkH0S/3Q6upF9PBPCtFoUA/LZU86LTXq4IL7gyKa
         tQga3aUk5GN8YTUyxvQyvKUqa6yNGXI56Pp8SVWIBaDCbO5KifE5px9X8umgCPc166aS
         7QHydRPRP3NL44fHWHKHuYQjEdWBTrDtqc5jpgV+Kxl8JtVoHo1NGfRJJV0Et9BQdATe
         +Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624772; x=1791229572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wYkBWEaad7pJtWSE9fUzK8FJHWmMOd6HhAL0BzGHkSI=;
        b=nCBPcUCRnZb8FBd4KLVZb0fLVA3LZtcG5AnEVNBKWuBytN6DZByXfWrXapuwKjtrTB
         QaPVtcptStd7Z5PLtsRnqajhTN537SuMclRWA81Kn0D/hCeL0ZB5/kpdnJaME808H3ff
         2sByUM46uEClHo3DCi0cYQ3pAwMz7jK2gtoGvaMZZNymXkHYW8nQIzD3myhM5TvOLsN/
         nugE88/zOqb4yeREGGOG6VL+wjZqWhj91SGUBbp/Z7A7SAcazYxKJ+cJcfU1/SPDBtyZ
         ktmVNeczy207V0fYPXK6hcY+FPYWK2Q9fiS77XKef9hne2D1UlS6i11waih08RUkXtSH
         aFvA==
X-Forwarded-Encrypted: i=1; AKwUvBzSj22WawmwgJRfs8XHAYnKqTMhuI8KKSQAHRUjZFwjnJSNDX/mRdm0JzBJWOCCdrU/9Qd7/WU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWyHRBdvBsK/QXfeU9sifUN+u4yzXqbJsAUEcAQTxV2lAGFZfV
	fxwTuWSzLVzZyN92M8XxSckfHj641MC/LuD/3KYbcv8fUNcuBWPxRmdkLAxLog==
X-Gm-Gg: AYBFou3CGsTjIW/GiYqZF5Ai22YckHLTitVaIi3gEIJw+oqO5Ly1RPth7bAap8bh5qH
	LeJ919VcDzHrx4uQaHjKLZxyd2jOynTf3n53YJHLkDYf8pAUVHuM6qbQCXZhgdG/0HeB9P+1F2F
	nJ3+lia1k6HmmvF0UD+bwxp6LRnRuyx4I6mWZAhIYOLTJdhvGoDcXmzJv/YwTAFllGABhiz1uEo
	loxJ95GWlUxfFbn7rkV/HMHVhgqnD8PNkUywEOup8XVv0aw6S+KlNc+dAWFW7N59LUuDErCNZWy
	ecZcakLnO97iAs71J4PzGEu3gBrDFYrYM/0quvBxYZdZfiYoTaw6cPJuFzjSCqkjaNZaQOGn/Hk
	EbV9jurdzV1dm6lGoarDf33ldKny7La6V92oHeoQpc0ne8pWGorlfoM6AVxvdcX0LocNzOtu+8k
	8I+DXbfS1m8WSpub2/48Kk23hKMX7l88oyXIuokdC79o48gwYEVN5NdMCN/jBFw14erBfX8WgAc
	WH22E7i6cYsM9pQqNN7ox6s5ckNml2S1BiWcBAYHBf8hV+j3glNv9Rr4hYnUUcn
X-Received: by 2002:a05:6000:2511:b0:487:27f9:840 with SMTP id ffacd0b85a97d-48871726b7cmr23962375f8f.53.1790624772381;
        Mon, 28 Sep 2026 12:46:12 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-82-57-191-234.retail.telecomitalia.it. [82.57.191.234])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48af071532dsm1527706f8f.20.2026.09.28.12.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:46:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v24 08/10] net: dsa: move mediatek DSA driver in dedicated directory
Date: Mon, 28 Sep 2026 21:45:07 +0200
Message-ID: <20260928194511.41878-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928194511.41878-1-ansuelsmth@gmail.com>
References: <20260928194511.41878-1-ansuelsmth@gmail.com>
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
index 59e6385b2c50..ff8c5dda07b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16839,9 +16839,9 @@ M:	Chester A. Unal <chester.a.unal@arinc9.com>
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

