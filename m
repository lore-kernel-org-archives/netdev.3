Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEC747F2E6
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220602; cv=none; b=uT/838SWagcu449yE7Z1xCAFmU+o+ajwZE/BRF0Uq0OeiEPCJor7JrWrnaBXQNoPznE/HPE32SCnvzOBjYQSi89XlaIV6i8sVi0mmz2Pw0/5IQaxJmhMJnrAh7rN4aXKrQ7h7Ln8jy2oVX+rTQMNGX1ZQyiEO1RuFivzkXIjoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220602; c=relaxed/simple;
	bh=jnXoc7jTqpIui1SgMV3BTf/tUR+HHI5I3ArW5Dsa8HI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VZlboVPf3QZMe1Yt5ViiZcRZsLLq3iF4hndZ3MfYg8XrNcZSQlfCbBHid7KZoOChtURU5Nr4UCmRe0WfH0vd4j6qIryY0X3j/JJZvYXx9SEOoedwRAyxlvHzwx8+SZtklEZC0nvzOMypY3ND4qzucBk89B3sIbOKyaug8DVU6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjJL8Ux7; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjJL8Ux7"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso873528a12.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789220599; x=1789825399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X0kiGyCc19auOwBum2qDP1udARgoeuAtiwGA+19Ip6k=;
        b=pjJL8Ux7fq8xT4dUHRmpzBNn2K5WL4f+SzwGwyOVxdKVAoowpMZlGcstzIVdP2n5LA
         fQm4enPyx9kVwjvjcTMaFUko2yOzhG0L42zcvkIwMJ0fe4CUf0uvDaTZ0IcK87m6/XJc
         HiAQL2hZBgM6n0xHQWWYKU8DG1+RJJ0/oAx4P9hOhn/bcMnofX50EMfBDZYsBbRE6aRg
         u+V0qssK1O6DVIrwkY7lY18LdTNF8NcDrc7hrZa1YwGyTSfY3saY5uQvHsxPfBIfRqU5
         /ROn57B9398ujCPpJ1vPYORjdLUjrAyLjXFK8ZjQ9/8ZaUCLYvr1CqI6HnTAenkvxysx
         pqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789220599; x=1789825399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0kiGyCc19auOwBum2qDP1udARgoeuAtiwGA+19Ip6k=;
        b=oTI3fNH8n2zorcbB8xNbv0JnkWw1d1fbHhA08GtN4KlGReiqgPfZ0l7TAkVNr0d/Dm
         D9GV5TkFY6DLr86qG1fXlj+QByxskHI0OgNjsRbzvdwEOm7AdIWRwLyiEalzHeObAaq3
         WE9Qf4QQ/eN8u7vvCVCcIejmrr52DAX7ipx2RAzpfqDCKYNE2SvyNJRvVbsFh+242BA6
         bq+Wl8nTyIeYOQBbRp1XCLwsdWfdfDqLOcjVntriVdW3NEXkCrF5/rsrCT25Ex2vzyHe
         VbFaC/HN1LhoVH9ase/YeCDWlJn4WAnJoo/Lg4xQmerP/83caEzVbGCvRqgQcKz2FDYK
         OuWA==
X-Gm-Message-State: AFuF++kDVe38XhVKe4IIyDZb+GhOcAbCRfnrExdZ7wkDDF2e5YFmziHq
	W3JsXM46LwEYrKAk3Sxo25hhU2YDT9nuo+Rd0AG9XeFNqRsGzwAeqQoRKRpQJkmx
X-Gm-Gg: AYBFou3WvkA66npAdQ5xf+nmqrU48W2FU4AirXF/gQauKgmdUM0490ZdP0PvTcpWciv
	QvsVMi+aE//9K4ZazjCGDPFE+TMZ0eAc+TIxOxGkYrqkwxtJSwl8Wg1i8isXVA9poe/lWTshqx6
	7DZlPmGt9zvmE5VUyPY+qt5LknAitsWnZyNHHVymsvlntyLtESmcfAeB/+/UeBIhuwxygRADdVO
	Z9dB/SGnmHJQO8gfOA+36Pf2da32BDEsmgB9UFe/SElNtUoiAAG81ak3xQDlq13o/xWim+mO27m
	cz+/itat7KuZJ7iz+l6TVoyGJO8F6o+bMcNcab9njy7/QRRh1j2VbHJA9Phm2Tg3zeuEbvLxAbf
	eN14UtN9oEjuDs9yAvNSHGxsUVUCFOVNV10PsaS9vt30St1PsuthMxafCrhdf3Z+Sa6xKUM+z0w
	bToCqs88LfHJ0q1CM687Ze2wXF0uTiwma1SJHDLzX0CDnbZfCfE5+fo4Fw93P67AUdoyrvFRxKx
	eL139xn0N0=
X-Received: by 2002:a05:6a21:6f88:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3daed3197ddmr18121705637.13.1789220598571;
        Sat, 12 Sep 2026 06:43:18 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.dm.ae ([157.51.208.45])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f06423sm16362396eec.20.2026.09.12.06.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:43:18 -0700 (PDT)
From: Ahmed Naseef <naseefkm@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ahmed Naseef <naseefkm@gmail.com>
Subject: [PATCH net] net: phy: mediatek: do not report link and per-speed LED rules together
Date: Sat, 12 Sep 2026 17:43:06 +0400
Message-Id: <20260912134306.3544329-1-naseefkm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_phy_led_hw_ctrl_get() reports TRIGGER_NETDEV_LINK whenever any of the
speed bits in on_set is on, and in addition reports every individual
TRIGGER_NETDEV_LINK_* bit that is set. The netdev trigger refuses that
combination: netdev_led_attr_store() rejects TRIGGER_NETDEV_LINK together
with any per-speed rule, and it validates the whole resulting mode rather
than just the bit being written. Once the hardware has any link bit
programmed, every write to the trigger attributes of that LED therefore
fails with -EINVAL and the LED can no longer be configured.

The rules are also fed back into the hardware: the trigger stores what is
read back, and a later write of device_name programs it again, expanding
TRIGGER_NETDEV_LINK to every speed in on_set. An LED configured for a
single speed is thereby silently widened to "on at any link speed".

Both are easy to see on the EcoNet EN7528, whose four PHYs share one LED
block. The first LED programs the block correctly, the second reads those
rules back and rewrites them widened, and the remaining two then read the
widened value, so an LED configured for "link_10 link_100" ends up lit on a
1000 Mbps link.

on_set holds every speed the LED can indicate and is exactly what
mtk_phy_led_hw_ctrl_set() programs for TRIGGER_NETDEV_LINK, so report the
speed independent rule only when all of them are on, and the individual
speeds otherwise. The mapping is then the inverse of the one used when
programming the LED and round trips without changing the register.

Fixes: c66937b0f8db ("net: phy: mediatek-ge-soc: support PHY LEDs")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
---
 drivers/net/phy/mediatek/mtk-phy-lib.c | 27 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index dfd0f4e439a2..608072fbfde9 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -156,20 +156,27 @@ int mtk_phy_led_hw_ctrl_get(struct phy_device *phydev, u8 index,
 	if (!rules)
 		return 0;
 
-	if (on & on_set)
+	/* TRIGGER_NETDEV_LINK must not be reported together with any of the
+	 * per-speed rules, the netdev trigger rejects that combination.
+	 * on_set holds every speed this LED can indicate and is what
+	 * mtk_phy_led_hw_ctrl_set() programs for TRIGGER_NETDEV_LINK, so
+	 * report the speed independent rule only when they are all on.
+	 */
+	if ((on & on_set) == on_set) {
 		*rules |= BIT(TRIGGER_NETDEV_LINK);
+	} else {
+		if (on & MTK_PHY_LED_ON_LINK10)
+			*rules |= BIT(TRIGGER_NETDEV_LINK_10);
 
-	if (on & MTK_PHY_LED_ON_LINK10)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
+		if (on & MTK_PHY_LED_ON_LINK100)
+			*rules |= BIT(TRIGGER_NETDEV_LINK_100);
 
-	if (on & MTK_PHY_LED_ON_LINK100)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
+		if (on & MTK_PHY_LED_ON_LINK1000)
+			*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
 
-	if (on & MTK_PHY_LED_ON_LINK1000)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
-
-	if (on & MTK_PHY_LED_ON_LINK2500)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_2500);
+		if (on & MTK_PHY_LED_ON_LINK2500)
+			*rules |= BIT(TRIGGER_NETDEV_LINK_2500);
+	}
 
 	if (on & MTK_PHY_LED_ON_FDX)
 		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);

base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
-- 
2.34.1

