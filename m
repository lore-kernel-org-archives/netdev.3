Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91812E2EF9
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781374818; cv=none; b=FI8tPVdmUl7Qv1cwSjuq624d6Qgyfn1LyMA+6m3IFlsC1q1Gk+bP+3F/kLabhR76SNvXRd88ZS5ikMrYP/E0xaP/NOKnPZdUruBPXGK6XwkuDrrN/Ogf2JUh11uV6kRST5RqSsFYfcllFs0dAW0hz1l7UmZOE3Dw6YvUDDu2Bio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781374818; c=relaxed/simple;
	bh=fP25Y4oo8wjxpzOUad+dvhuyJIcbgUuH3c6TIawPARs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8SumKd0rvyo4rPyTybZaQU+jweEWM9QXFh0Y9XMetDCiAzHoRi/hdRU0riehC0hngcfbICEYTO1kyqzpFucYmNrOtgeXdu6oZMjrI9mwQmFyToa7+z+llTmy7sN4PgxS54OXTSKBy1pQjzg8C5iJMxUthMujlLt4X/N+2JRj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=HoXms2k9; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=jefMHLlS; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="HoXms2k9";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="jefMHLlS"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=HoXms2k9soKUdjDAetHC3TjleMhqGlOT4c5Xi8pwQkq2ogdzorIfVauyCY2DjgOz0t9vdXBFhDGGohsoi1XHMKAZz95Xtiqqi3qZTO61YJSvR+FdKPjd9qMTEec+ECoseUuY8U5i44E6s0oPdchduIyivgXTAZI1149rBpK5YRZyOh06tNnMhbeNClUq8+7ZXAY9SpcEEVAdM7A+D9suXxuNikw0rQKDOryR94IqCbrfawQUgFRK4NIl0y0wMIOobiUtZi6zK7r1WyiI8ICC6mBHAWZhff3qXYy1ey9ijJ2EAuOqCdiEjHldUA+g8KVVCsjvsQ8Nl4bE7lIonYjA2g==; s=purelymail3; d=tinyisr.com; v=1; bh=fP25Y4oo8wjxpzOUad+dvhuyJIcbgUuH3c6TIawPARs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=jefMHLlSOlyfjN1Dbc+9cLUTIvty9r938Zfb5EIe6GN4tvqzJYK7Ka7IMF7VUImYUxzH1i8G30jbVLE6s6cqFM4kSLL+nVoK4NOZ9kLXdvaalkJSMw8Fmd2BYJRdsmDF9DZ3HdZyIJf4I0yxXiwA+G8PsBLaiNO6+lZEsBYC8OE9KZXzc9Xoc4AeEVVGPuW7TdRhq39JxjH91j4WGqWyNumRiomQ5VSHI5uv1BedsFnvD5Sjx30S9zDfLY0JXpFIk9jLq3Z785VexJPGrVYIcSpda1yR6ND1COn83NVqglyUhBocr3Ig3NGBPPqF06jcwpzg/AT/2gQYGRUKTSrqKQ==; s=purelymail3; d=purelymail.com; v=1; bh=fP25Y4oo8wjxpzOUad+dvhuyJIcbgUuH3c6TIawPARs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1738339834;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 13 Jun 2026 18:20:11 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v5 2/4] net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet PHYs
Date: Sat, 13 Jun 2026 21:18:43 +0300
Message-ID: <20260613181845.111877-3-joey@tinyisr.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613181845.111877-1-joey@tinyisr.com>
References: <20260613181845.111877-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The Fast Ethernet PHYs present in the MT7628 SoCs require an
undocumented bit to be set before they can establish 100mbps links.

This commit adds the Kconfig option MEDIATEK_FE_SOC_PHY and the
corresponding driver mtk-fe-soc.c.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/mediatek/Kconfig      | 10 +++++-
 drivers/net/phy/mediatek/Makefile     |  1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c | 50 +++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kc=
onfig
index bb7dc876271e..b6a51f38c358 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -21,8 +21,16 @@ config MEDIATEK_GE_PHY
 =09  common operations with MediaTek SoC built-in Gigabit
 =09  Ethernet PHYs.
=20
+config MEDIATEK_FE_SOC_PHY
+=09tristate "MediaTek SoC Fast Ethernet PHYs"
+=09help
+=09  Support for MediaTek MT7628 built-in Fast Ethernet PHYs.
+=09  This driver only sets an initialization bit required for the PHY
+=09  to establish 100 Mbps links. All other PHY operations are handled
+=09  by the kernel's generic PHY code.
+
 config MEDIATEK_GE_SOC_PHY
-=09tristate "MediaTek SoC Ethernet PHYs"
+=09tristate "MediaTek SoC Gigabit Ethernet PHYs"
 =09depends on ARM64 || COMPILE_TEST
 =09depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
 =09=09   COMPILE_TEST
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/M=
akefile
index ac57ecc799fc..6f9cacf7f906 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MEDIATEK_2P5GE_PHY)=09+=3D mtk-2p5ge.o
+obj-$(CONFIG_MEDIATEK_FE_SOC_PHY)=09+=3D mtk-fe-soc.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)=09=09+=3D mtk-ge.o
 obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)=09+=3D mtk-ge-soc.o
 obj-$(CONFIG_MTK_NET_PHYLIB)=09=09+=3D mtk-phy-lib.o
diff --git a/drivers/net/phy/mediatek/mtk-fe-soc.c b/drivers/net/phy/mediat=
ek/mtk-fe-soc.c
new file mode 100644
index 000000000000..9eb4960bcaad
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-fe-soc.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for MT7628 Embedded Switch internal Fast Ethernet PHYs
+ */
+#include <linux/module.h>
+#include <linux/phy.h>
+
+#define MTK_FPHY_ID_MT7628=090x03a29410
+#define MTK_EXT_PAGE_ACCESS=090x1f
+
+static int mt7628_phy_read_page(struct phy_device *phydev)
+{
+=09return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
+}
+
+static int mt7628_phy_write_page(struct phy_device *phydev, int page)
+{
+=09return __phy_write(phydev, MTK_EXT_PAGE_ACCESS, page);
+}
+
+static int mt7628_phy_config_init(struct phy_device *phydev)
+{
+=09/*
+=09 * This undocumented bit is required for the PHYs to be able to
+=09 * establish 100mbps links.
+=09 */
+=09return phy_modify_paged(phydev, 0x8000, 30, BIT(13), BIT(13));
+}
+
+static struct phy_driver mtk_soc_fe_phy_driver[] =3D {
+=09{
+=09=09PHY_ID_MATCH_EXACT(MTK_FPHY_ID_MT7628),
+=09=09.name =3D "MediaTek MT7628 PHY",
+=09=09.config_init =3D mt7628_phy_config_init,
+=09=09.read_page =3D mt7628_phy_read_page,
+=09=09.write_page =3D mt7628_phy_write_page,
+=09},
+};
+
+module_phy_driver(mtk_soc_fe_phy_driver);
+static const struct mdio_device_id __maybe_unused mtk_soc_fe_phy_tbl[] =3D=
 {
+=09{ PHY_ID_MATCH_EXACT(MTK_FPHY_ID_MT7628) },
+=09{ }
+};
+
+MODULE_DESCRIPTION("MediaTek SoC Fast Ethernet PHY driver");
+MODULE_AUTHOR("Joris Vaisvila <joey@tinyisr.com>");
+MODULE_LICENSE("GPL");
+
+MODULE_DEVICE_TABLE(mdio, mtk_soc_fe_phy_tbl);
--=20
2.54.0

