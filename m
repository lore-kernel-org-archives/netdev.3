Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346892F7F13
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647840; cv=none; b=pRaaDxzffg20n/ZE6njwg2kcThgYDgJ1sxiahXiQHIsoQAf7ZjZEZEnXYYQNvUoSthCCBsauh1Ab31LNFnNDipVjSMeH/aP9vfcVmBxu7LPd0L8qeVaz2MNCySiqnT0Iv97ilodhqVH11vAliV6+HZN8F1AU5iwLEPeI9p9xDWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647840; c=relaxed/simple;
	bh=GVmU9mI4wzWwfLZPxUqGE9q3ORsxRGQP1sPRIKrPBSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/ld1aFVV1Wfqwny9bbMF80MT8iEDuNKMXn1maHAZ/kdvQKpaUfsRB2IYHMglM7GEIDSKh2CQWt4ZTtHJ7VfxnGfsjq4S9utIl858np+UQOWYJmWvPRagcbcJL6ahdXULK0Pza9/PU3BYbNaqe35LNJxIyjxrjasvNjzct6cHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=pYYGnmqK; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=C8Px6ZVU; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="pYYGnmqK";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="C8Px6ZVU"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=pYYGnmqKC3ERUp3NfQHtRH7QUMjhtKrUCRj7PQPg1AUewBIqTAPlufgzp+rkmJ7mJlfB9Ayluqp3mOm5OGBWmfh6VBZQkLrm+/0vJhW7a94vQ/E/HgDZ+xn8VTYJawX9f3BHTxc55WTM8w4E7Oa3NFYX8LP9+90VPcplnQwPE89jg/wKDv6zdpzNNfH1zgv9DqCFZMn1i7oPcgM6cfzw+a3syLo1nKNh2HFqmdtNZYA+Hl2F4enOAaFHJynU85lA1QHX8r/32yv8eQtA079ghzcyqx6SWDmm28GbT0l5l5DdlvbK+Gh7wOJi6zDLGHHwcYRtXrODOJ49nn2Bxb3XBQ==; s=purelymail3; d=tinyisr.com; v=1; bh=GVmU9mI4wzWwfLZPxUqGE9q3ORsxRGQP1sPRIKrPBSY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=C8Px6ZVUBoX+be5sjb8PyA5manq/Ecr2Ee4Qzmr0Ed2W4jMVuMLJ+Vto8MPrLIGGM3ayBsIZwd6w5R7t4Og97RMnl8FiXJXz0Y4KqHm7KQhIuuEYUO9E87WGbZuNaVPFG5cf9Sz8ScU3oM8D8Xz4Ike8R56hm7txAtj8JUe4FIcr1x5SUEgVVASrhSZA+79aEWOdO/0qi7a7/TqJDnTvPrdaIAFgPbuvDPNe5HglXBMm1y31YvTitLFlqjcbOoAFRlhGk8IEF4NjRZDDmhjqa5QMlnY+f7/naR2Xl5JekSgNPZmz3Hx3K3E7Vv+WlBbKUy/zlQHI3LaNrrsKesaShQ==; s=purelymail3; d=purelymail.com; v=1; bh=GVmU9mI4wzWwfLZPxUqGE9q3ORsxRGQP1sPRIKrPBSY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1221505461;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 13 Aug 2026 19:03:56 +0000 (UTC)
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
Subject: [PATCH net-next v7 2/4] net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet PHYs
Date: Thu, 13 Aug 2026 22:02:39 +0300
Message-ID: <20260813190241.789323-3-joey@tinyisr.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813190241.789323-1-joey@tinyisr.com>
References: <20260813190241.789323-1-joey@tinyisr.com>
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
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mediatek/Kconfig      | 11 +++++-
 drivers/net/phy/mediatek/Makefile     |  1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c | 52 +++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kc=
onfig
index b6d41bbbbc27..3b9cf82c0cb2 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -21,8 +21,17 @@ config MEDIATEK_GE_PHY
 =09  common operations with MediaTek SoC built-in Gigabit
 =09  Ethernet PHYs.
=20
+config MEDIATEK_FE_SOC_PHY
+=09tristate "MediaTek SoC Fast Ethernet PHYs"
+=09depends on SOC_MT7620 || COMPILE_TEST
+=09help
+=09  Support for MediaTek MT7628 built-in Fast Ethernet PHYs.
+=09  This driver only sets an initialization bit required for the PHY
+=09  to establish 100 Mbps links. All other PHY operations are handled
+=09  by the kernel's generic PHY code.
+
 config MEDIATEK_GE_SOC_PHY
-=09tristate "MediaTek SoC Ethernet PHYs"
+=09tristate "MediaTek SoC Gigabit Ethernet PHYs"
 =09depends on ARM64 || ECONET || COMPILE_TEST
 =09depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
 =09=09   ECONET || COMPILE_TEST
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
index 000000000000..0b0d6c1fefbd
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-fe-soc.c
@@ -0,0 +1,52 @@
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
+=09=09.name=09=09=3D "MediaTek MT7628 PHY",
+=09=09.config_init=09=3D mt7628_phy_config_init,
+=09=09.read_page=09=3D mt7628_phy_read_page,
+=09=09.write_page=09=3D mt7628_phy_write_page,
+=09=09.suspend=09=3D genphy_suspend,
+=09=09.resume=09=09=3D genphy_resume,
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
2.55.0

