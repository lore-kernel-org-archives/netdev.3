Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F74EE872
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562304; cv=none; b=n5kqvNi8zp5HLCBwSAbmIFUvEc9nQZreML3PRdC5zbwX5L+wik7TVJ6X43B7MzKi9ePT9cEhl6lhu8sAdFl8d+Jd04jgaM4I+PUly1/0er7Q9QmHO4t41BDir4flbfsUoPyUXeFt4yIcsyQyToYcyNehWzpYIupOJbSgtkp4y8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562304; c=relaxed/simple;
	bh=Fzj8sc4Qr4DvpixmPFnP96rfERU9Kt8qb+t/fnTtX28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJoxXNyywlpzgM2i/ygnzeZTd+jKekW3Rbx27lvm9vvEkg2TPzAADz/PBo50GNxOu3z4E8FTCwxnbDohqDaJWh6pSaenB9roTjlq7O1R9syyPQbuh5pGfDFH5Fdqwfz7OvbGtStuCTRw/+sKwoE6M+35Wr8YUh2ZULjvMxQVxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO6zz68R; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO6zz68R"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-487048857f6so3884244f8f.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791562293; x=1792167093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTKR5rc4VAEWmVWUO5h8Ps4gLdrxgtTZsZDz+0cGmfY=;
        b=kO6zz68RHgiAT0E5oI5HJJ4nP0VtnwrwGfiY+UPClgOmYiFwfgCsBT37LXcrv4Jn9L
         95V3yiSH0uW4uBh2e1abcCkEJgV3PkocfTcX7wcmooZTM4QE8L+giOXTY3jw98XUXE6q
         8KQJpr6oSAnJ8nQNsKu1c7lKPqIAZYtb7uSFVr3Tb48ZLQxoOdRfir6RHtICtvGrED7b
         2fgunfBR6Lb5gYPUIv6FUYkzjZEUHhGuPZcmqQXvv8or/+KsJigTrmwK/T6HzPpDAqow
         JWiwcpN5J3t8dxg85gJ7+F0QJXFvGKu6qPPMKpyB9MndzaLulvOfnhZKqzZs4FeA1B2s
         wFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562293; x=1792167093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FTKR5rc4VAEWmVWUO5h8Ps4gLdrxgtTZsZDz+0cGmfY=;
        b=Ap2nSfrR2idQPr0pa4PLKLbbpoLIdfY1E3rIAwXRoSCFYeaXLoDFb29JPUZMfCFCm7
         AhlHH8VnUeSGcZiWVdbMBD4e2tvhPc6wYN+zc2kFTDZTWX9t/8edyoWrMTXWNEuhVPwC
         0bEVrin0KOV2D6VYhtVa/VBAee8kl5gtkl5Lme13zUFRSoQGRzGBANeyw9TlG8WzP0vG
         RQAQObb1BB6zwidHmxqiTaUx2ztLwOZmgwnBd5HnhTyn5d20ru+QIp/+hdyWZzGKm/z8
         IWgbZ36sdH4t36/9CvXKEUETrUQp7r5tJ+J5byPbRwsG+ssrayjdAs0HQ0ak+uKkhZB6
         e13g==
X-Forwarded-Encrypted: i=1; AKwUvBwk3xK/yCgs5m9loJ51T0/bM3Ox2JpcJ5KEFuvvWt6fl092IpISii8smF5STsLvTBKZAsxlwGY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVZKxyd4BPBP2mQfG1EuJYWR1ic7dXSIu62hVBbjZIQol0iOlb
	O6fbCn3FVvJ6SqUlHf+6+u7TLnf/beJBbEhERltJxx1948uaBxZrbCqw
X-Gm-Gg: AYBFou0TmSQwIFcRA/6FbRtQJKxTQfz+L1Gf8YKO7b6uYf3oaa1egZpXuf32ytCVDho
	yXNMagGH5DVkTJJ0wqiWs3h4c0vdMfXym1x+i4d7TlsltdmWfEgAjmivQqErSmhJ1zzL5HXNV/Y
	axs4wLpLETb7PsRhMpaw664b2iMnftLn8kv8EybmHYu/LEeF6TmyEzkD4Zg89XixlmB5syVb0p2
	e3cOGbsdlg/dkTalpG9vATJP8CTSiiBJh8/sm3VXn8icobyyJUOEHrfeMXCzodNQShnrnldHxvQ
	puy6+658G1tGJTT7gWTjcH+HvIt3Nu72vKGarJeG5tjBxG5gTy8Sn6d7zdHlFstOU3gs8rDP7m2
	wXgYxZTSzXYXOAH1rPncKFUfbFVm2T5el/EhF1wK3NICVF5up4jWt4ls2Oht/tsHlRAR1LlO13M
	Dij+u2h/fqSv5MjnAbuzQ2nOLfJS1e2jTq5HPrjWu73a+2mBw5Ly/SDP1NJcU3MHEU8WjfyGW4R
	YCBqZjSpW188wx+pHEKFqtbyX2Yat61UH6Jd4XiGrB90NJI/Go0jJlVO2F5F9tmkPomXuYO7VFQ
	EwIyMgvPdF7d5jsCwJAC52ZlOBRD
X-Received: by 2002:adf:e004:0:20b0:487:88b:4681 with SMTP id ffacd0b85a97d-48dba9db07cmr3641609f8f.10.1791562292479;
        Fri, 09 Oct 2026 09:11:32 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db94e2f08sm4744701f8f.15.2026.10.09.09.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:11:31 -0700 (PDT)
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
Cc: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v25 10/10] net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver
Date: Fri,  9 Oct 2026 18:10:55 +0200
Message-ID: <20261009161102.38961-11-ansuelsmth@gmail.com>
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

Add Airoha AN8855 5-Port Gigabit DSA switch. Switch can support
10M, 100M, 1Gb, 2.5G and 5G Ethernet Speed but 5G is currently error out
as it's not currently supported as requires additional configuration for
the PCS.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/mediatek/Kconfig      |   10 +
 drivers/net/dsa/mediatek/Makefile     |    1 +
 drivers/net/dsa/mediatek/an8855.c     | 1765 +++++++++++++++++++++++++
 drivers/net/dsa/mediatek/an8855.h     |  755 +++++++++++
 drivers/net/dsa/mediatek/mt7530-lib.c |   68 +-
 drivers/net/dsa/mediatek/mt7530-lib.h |   22 +
 6 files changed, 2601 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/dsa/mediatek/an8855.c
 create mode 100644 drivers/net/dsa/mediatek/an8855.h

diff --git a/drivers/net/dsa/mediatek/Kconfig b/drivers/net/dsa/mediatek/Kconfig
index 7b48300dca0c..2799e78a8651 100644
--- a/drivers/net/dsa/mediatek/Kconfig
+++ b/drivers/net/dsa/mediatek/Kconfig
@@ -1,4 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config NET_DSA_AN8855
+	tristate "Airoha AN8855 Ethernet switch support"
+	depends on MFD_AIROHA_AN8855 || COMPILE_TEST
+	depends on NET_DSA
+	select NET_DSA_MT7530_LIB
+	select NET_DSA_TAG_AIROHA
+	help
+	  This enables support for the Ethernet switch inside the
+	  Airoha AN8855 chip.
+
 config NET_DSA_MT7530_LIB
 	tristate
 
diff --git a/drivers/net/dsa/mediatek/Makefile b/drivers/net/dsa/mediatek/Makefile
index b2c0693dbb58..60e5f5cd0901 100644
--- a/drivers/net/dsa/mediatek/Makefile
+++ b/drivers/net/dsa/mediatek/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_NET_DSA_AN8855)	+= an8855.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MT7530_LIB) += mt7530-lib.o
 obj-$(CONFIG_NET_DSA_MT7530_MDIO) += mt7530-mdio.o
diff --git a/drivers/net/dsa/mediatek/an8855.c b/drivers/net/dsa/mediatek/an8855.c
new file mode 100644
index 000000000000..22171cd885c7
--- /dev/null
+++ b/drivers/net/dsa/mediatek/an8855.c
@@ -0,0 +1,1765 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Airoha AN8855 DSA Switch driver
+ * Copyright (C) 2023 Min Yao <min.yao@airoha.com>
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/ethtool.h>
+#include <linux/etherdevice.h>
+#include <linux/if_bridge.h>
+#include <linux/iopoll.h>
+#include <linux/netdevice.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/phylink.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <net/dsa.h>
+
+#include "an8855.h"
+#include "mt7530-lib.h"
+
+static const struct mt7530_reg_field an8855_fields[] = {
+	{ MT7530_BC_FFP, REG_FIELD(AN8855_BCF, 0, 7) },
+	{ MT7530_UNM_FFP, REG_FIELD(AN8855_UNMF, 0, 7) },
+	{ MT7530_UNU_FFP, REG_FIELD(AN8855_UNUF, 0, 7) },
+
+	{ MT7530_CCR_MIB_ENABLE, REG_FIELD(AN8855_MIB_CCR, 31, 31) },
+	{ MT7530_CCR_RX_OCT_CNT_GOOD, REG_FIELD(AN8855_MIB_CCR, 7, 7) },
+	{ MT7530_CCR_RX_OCT_CNT_BAD, REG_FIELD(AN8855_MIB_CCR, 6, 6) },
+	{ MT7530_CCR_TX_OCT_CNT_GOOD, REG_FIELD(AN8855_MIB_CCR, 5, 5) },
+	{ MT7530_CCR_TX_OCT_CNT_BAD, REG_FIELD(AN8855_MIB_CCR, 4, 4) },
+
+	{ MT7530_BPDU_EG_TAG, REG_FIELD(AN8855_BPC, 9, 11) },
+	{ MT7530_BPDU_PORT_FW, REG_FIELD(AN8855_BPC, 0, 2) },
+	{ MT7530_PAE_BPDU_FR, REG_FIELD(AN8855_PAC, 28, 28) },
+	{ MT7530_PAE_EG_TAG, REG_FIELD(AN8855_PAC, 25, 27) },
+	{ MT7530_PAE_PORT_FW, REG_FIELD(AN8855_PAC, 16, 18) },
+	{ MT7530_R01_BPDU_FR, REG_FIELD(AN8855_RGAC1, 12, 12) },
+	{ MT7530_R01_EG_TAG, REG_FIELD(AN8855_RGAC1, 9, 11) },
+	{ MT7530_R01_PORT_FW, REG_FIELD(AN8855_RGAC1, 0, 2) },
+	{ MT7530_R02_BPDU_FR, REG_FIELD(AN8855_RGAC1, 28, 28) },
+	{ MT7530_R02_EG_TAG, REG_FIELD(AN8855_RGAC1, 25, 27) },
+	{ MT7530_R02_PORT_FW, REG_FIELD(AN8855_RGAC1, 16, 18) },
+	{ MT7530_R03_BPDU_FR, REG_FIELD(AN8855_RGAC2, 12, 12) },
+	{ MT7530_R03_EG_TAG, REG_FIELD(AN8855_RGAC2, 9, 11) },
+	{ MT7530_R03_PORT_FW, REG_FIELD(AN8855_RGAC2, 0, 2) },
+	{ MT7530_R0E_BPDU_FR, REG_FIELD(AN8855_RGAC2, 28, 28) },
+	{ MT7530_R0E_EG_TAG, REG_FIELD(AN8855_RGAC2, 25, 27) },
+	{ MT7530_R0E_PORT_FW, REG_FIELD(AN8855_RGAC2, 16, 18) },
+
+	{ MT7530_VAWD_IVL_MAC, REG_FIELD(AN8855_VAWD0, 5, 5) },
+	{ MT7530_VAWD_EG_CON, REG_FIELD(AN8855_VAWD0, 11, 11) },
+	{ MT7530_VAWD_VTAG_EN, REG_FIELD(AN8855_VAWD0, 10, 10) },
+	{ MT7530_VAWD_PORT_MEM, REG_FIELD(AN8855_VAWD0, 26, 31) },
+	{ MT7530_VAWD_FID, REG_FIELD(AN8855_VAWD0, 1, 4) },
+	{ MT7530_VAWD_VLAN_VALID, REG_FIELD(AN8855_VAWD0, 0, 0) },
+	{ __MT7530_VAWD1, REG_FIELD(AN8855_VAWD0, 0, 31) },
+
+	{ MT7530_VAWD_ETAG, REG_FIELD(AN8855_VAWD0, 12, 23) },
+	{ __MT7530_VAWD2, REG_FIELD(AN8855_VAWD1, 0, 31) },
+
+	{ MT7530_VTCR_BUSY, REG_FIELD(AN8855_VTCR, 31, 31) },
+	{ MT7530_VTCR_FUNC, REG_FIELD(AN8855_VTCR, 12, 15) },
+	{ MT7530_VTCR_VID, REG_FIELD(AN8855_VTCR, 0, 11) },
+
+	{ MT7530_ATWD_CVID, REG_FIELD(AN8855_ATWD, 16, 27), },
+	{ MT7530_ATWD_IVL, REG_FIELD(AN8855_ATWD, 15, 15), },
+	{ MT7530_ATWD_FID, REG_FIELD(AN8855_ATWD, 28, 31), },
+	{ MT7530_ATWD_AGE_TIMER, REG_FIELD(AN8855_ATA2, 0, 8), },
+	{ MT7530_ATWD_PORT_MAP, REG_FIELD(AN8855_ATWD2, 0, 7), },
+	{ AN8855_ATWD_TYPE, REG_FIELD(AN8855_ATA2, 9, 9), },
+	{ AN8855_ATWD_VLD, REG_FIELD(AN8855_ATWD, 0, 0), },
+	{ MT7530_ATWD_MAC_BYTE_5, REG_FIELD(AN8855_ATA2, 16, 23), },
+	{ MT7530_ATWD_MAC_BYTE_4, REG_FIELD(AN8855_ATA2, 24, 31), },
+	{ MT7530_ATWD_MAC_BYTE_3, REG_FIELD(AN8855_ATA1, 0, 7), },
+	{ MT7530_ATWD_MAC_BYTE_2, REG_FIELD(AN8855_ATA1, 8, 15), },
+	{ MT7530_ATWD_MAC_BYTE_1, REG_FIELD(AN8855_ATA1, 16, 23), },
+	{ MT7530_ATWD_MAC_BYTE_0, REG_FIELD(AN8855_ATA1, 24, 31), },
+
+	{ __MT7530_ATWD1, REG_FIELD(AN8855_ATWD, 0, 31), },
+	{ __MT7530_ATWD2, REG_FIELD(AN8855_ATWD2, 0, 31), },
+	{ __MT7530_ATWD3, REG_FIELD(AN8855_ATA1, 0, 31), },
+	{ __MT7530_ATWD4, REG_FIELD(AN8855_ATA2, 0, 31), },
+
+	{ MT7530_ATRD_CVID, REG_FIELD(AN8855_ATRD0, 10, 21), },
+	{ MT7530_ATRD_AGE_TIMER, REG_FIELD(AN8855_ATRD1, 3, 11), },
+	{ MT7530_ATRD_PORT_MAP, REG_FIELD(AN8855_ATRD3, 0, 7), },
+	{ AN8855_ATRD_ARP, REG_FIELD(AN8855_ATRD0, 1, 2), },
+	{ MT7530_ATRD_MAC_BYTE_5, REG_FIELD(AN8855_ATRD1, 16, 23), },
+	{ MT7530_ATRD_MAC_BYTE_4, REG_FIELD(AN8855_ATRD1, 24, 31), },
+	{ MT7530_ATRD_MAC_BYTE_3, REG_FIELD(AN8855_ATRD2, 0, 7), },
+	{ MT7530_ATRD_MAC_BYTE_2, REG_FIELD(AN8855_ATRD2, 8, 15), },
+	{ MT7530_ATRD_MAC_BYTE_1, REG_FIELD(AN8855_ATRD2, 16, 23), },
+	{ MT7530_ATRD_MAC_BYTE_0, REG_FIELD(AN8855_ATRD2, 24, 31), },
+
+	{ MT7530_ATC_BUSY, REG_FIELD(AN8855_ATC, 31, 31), },
+	{ MT7530_ATC_MAT, REG_FIELD(AN8855_ATC, 7, 11), },
+	{ MT7530_ATC_CMD, REG_FIELD(AN8855_ATC, 0, 2), },
+	{ __MT7530_ATC, REG_FIELD(AN8855_ATC, 0, 31), },
+
+	{ MT7530_MIRROR_EN, REG_FIELD(AN8855_MIR, 7, 7) },
+	{ MT7530_MIRROR_PORT, REG_FIELD(AN8855_MIR, 0, 4) },
+
+	{ MT7530_SSP_FID_PST, REG_FIELD_ID(AN8855_SSP, 0, 15, AN8855_NUM_PORTS, 0x200) },
+
+	{ MT7530_PCR_PORT_TX_MIR, REG_FIELD_ID(AN8855_PCR, 20, 20, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_PCR_PORT_RX_MIR, REG_FIELD_ID(AN8855_PCR, 16, 16, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_PCR_PORT_VLAN, REG_FIELD_ID(AN8855_PCR, 0, 1, AN8855_NUM_PORTS, 0x200) },
+
+	{ MT7530_PCR_MATRIX, REG_FIELD_ID(AN8855_PORTMATRIX, 0, 5, AN8855_NUM_PORTS, 0x200) },
+
+	{ MT7530_PSC_SA_DIS, REG_FIELD_ID(AN8855_PSC, 4, 4, AN8855_NUM_PORTS, 0x200) },
+
+	{ MT7530_PVC_EG_TAG, REG_FIELD_ID(AN8855_PVC, 8, 10, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_PVC_VLAN_ATTR, REG_FIELD_ID(AN8855_PVC, 6, 7, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_PVC_ACC_FRM, REG_FIELD_ID(AN8855_PVC, 0, 1, AN8855_NUM_PORTS, 0x200) },
+
+	{ MT7530_PPBV1_G0_PORT_VID, REG_FIELD_ID(AN8855_PPBV1, 0, 11, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_PVID_G0_PORT_VID, REG_FIELD_ID(AN8855_PVID, 0, 11, AN8855_NUM_PORTS, 0x200) },
+
+	{ MT7530_GMACCR_MAX_RX_JUMBO, REG_FIELD(AN8855_GMACCR, 4, 7) },
+	{ MT7530_GMACCR_MAX_RX_PKT_LEN, REG_FIELD(AN8855_GMACCR, 0, 1) },
+
+	{ MT7530_MIB_TX_DROP, REG_FIELD_ID(AN8855_PORT_MIB_TX_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_CRC_ERR, REG_FIELD_ID(AN8855_PORT_MIB_TX_CRC_ERR, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_UNICAST, REG_FIELD_ID(AN8855_PORT_MIB_TX_UNICAST, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_MULTICAST, REG_FIELD_ID(AN8855_PORT_MIB_TX_MULTICAST, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_BROADCAST, REG_FIELD_ID(AN8855_PORT_MIB_TX_BROADCAST, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_COLLISION, REG_FIELD_ID(AN8855_PORT_MIB_TX_COLLISION, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_SINGLE_COLLISION, REG_FIELD_ID(AN8855_PORT_MIB_TX_SINGLE_COLLISION, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_MULTIPLE_COLLISION, REG_FIELD_ID(AN8855_PORT_MIB_TX_MULTIPLE_COLLISION, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_DEFERRED, REG_FIELD_ID(AN8855_PORT_MIB_TX_DEFERRED, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_LATE_COLLISION, REG_FIELD_ID(AN8855_PORT_MIB_TX_LATE_COLLISION, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_EXCESSIVE_COLLISION, REG_FIELD_ID(AN8855_PORT_MIB_TX_EXCESSIVE_COLLISION, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_PAUSE, REG_FIELD_ID(AN8855_PORT_MIB_TX_PAUSE, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_PKT_SZ_64, REG_FIELD_ID(AN8855_PORT_MIB_TX_PKT_SZ_64, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_PKT_SZ_65_TO_127, REG_FIELD_ID(AN8855_PORT_MIB_TX_PKT_SZ_65_TO_127, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_PKT_SZ_128_TO_255, REG_FIELD_ID(AN8855_PORT_MIB_TX_PKT_SZ_128_TO_255, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_PKT_SZ_256_TO_511, REG_FIELD_ID(AN8855_PORT_MIB_TX_PKT_SZ_256_TO_511, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_PKT_SZ_512_TO_1023, REG_FIELD_ID(AN8855_PORT_MIB_TX_PKT_SZ_512_TO_1023, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_TX_PKT_SZ_1024_TO_1518, REG_FIELD_ID(AN8855_PORT_MIB_TX_PKT_SZ_1024_TO_1518, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_TX_PKT_SZ_1519_TO_MAX, REG_FIELD_ID(AN8855_PORT_MIB_TX_PKT_SZ_1519_TO_MAX, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_BYTES_LOW, REG_FIELD_ID(AN8855_PORT_MIB_TX_BYTES_LOW, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_TX_BYTES_HIGH, REG_FIELD_ID(AN8855_PORT_MIB_TX_BYTES_HIGH, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_TX_OVERSIZE_DROP, REG_FIELD_ID(AN8855_PORT_MIB_TX_OVERSIZE_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_TX_BAD_PKT_BYTES_LOW, REG_FIELD_ID(AN8855_PORT_MIB_TX_BAD_PKT_BYTES_LOW, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_TX_BAD_PKT_BYTES_HIGH, REG_FIELD_ID(AN8855_PORT_MIB_TX_BAD_PKT_BYTES_HIGH, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_DROP, REG_FIELD_ID(AN8855_PORT_MIB_RX_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_FILTERING, REG_FIELD_ID(AN8855_PORT_MIB_RX_FILTERING, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_UNICAST, REG_FIELD_ID(AN8855_PORT_MIB_RX_UNICAST, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_MULTICAST, REG_FIELD_ID(AN8855_PORT_MIB_RX_MULTICAST, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_BROADCAST, REG_FIELD_ID(AN8855_PORT_MIB_RX_BROADCAST, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_ALIGN_ERR, REG_FIELD_ID(AN8855_PORT_MIB_RX_ALIGN_ERR, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_CRC_ERR, REG_FIELD_ID(AN8855_PORT_MIB_RX_CRC_ERR, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_UNDER_SIZE_ERR, REG_FIELD_ID(AN8855_PORT_MIB_RX_UNDER_SIZE_ERR, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_FRAG_ERR, REG_FIELD_ID(AN8855_PORT_MIB_RX_FRAG_ERR, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_OVER_SZ_ERR, REG_FIELD_ID(AN8855_PORT_MIB_RX_OVER_SZ_ERR, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_JABBER_ERR, REG_FIELD_ID(AN8855_PORT_MIB_RX_JABBER_ERR, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_PAUSE, REG_FIELD_ID(AN8855_PORT_MIB_RX_PAUSE, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_PKT_SZ_64, REG_FIELD_ID(AN8855_PORT_MIB_RX_PKT_SZ_64, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_PKT_SZ_65_TO_127, REG_FIELD_ID(AN8855_PORT_MIB_RX_PKT_SZ_65_TO_127, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_PKT_SZ_128_TO_255, REG_FIELD_ID(AN8855_PORT_MIB_RX_PKT_SZ_128_TO_255, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_PKT_SZ_256_TO_511, REG_FIELD_ID(AN8855_PORT_MIB_RX_PKT_SZ_256_TO_511, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_PKT_SZ_512_TO_1023, REG_FIELD_ID(AN8855_PORT_MIB_RX_PKT_SZ_512_TO_1023, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_RX_PKT_SZ_1024_TO_1518, REG_FIELD_ID(AN8855_PORT_MIB_RX_PKT_SZ_1024_TO_1518, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_RX_PKT_SZ_1519_TO_MAX, REG_FIELD_ID(AN8855_PORT_MIB_RX_PKT_SZ_1519_TO_MAX, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_BYTES_LOW, REG_FIELD_ID(AN8855_PORT_MIB_RX_BYTES_LOW, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_BYTES_HIGH, REG_FIELD_ID(AN8855_PORT_MIB_RX_BYTES_HIGH, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_CTRL_DROP, REG_FIELD_ID(AN8855_PORT_MIB_RX_CTRL_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_INGRESS_DROP, REG_FIELD_ID(AN8855_PORT_MIB_RX_INGRESS_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ MT7530_MIB_RX_ARL_DROP, REG_FIELD_ID(AN8855_PORT_MIB_RX_ARL_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_FLOW_CONTROL_DROP, REG_FIELD_ID(AN8855_PORT_MIB_FLOW_CONTROL_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_WRED_DROP, REG_FIELD_ID(AN8855_PORT_MIB_WRED_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_MIRROR_DROP, REG_FIELD_ID(AN8855_PORT_MIB_MIRROR_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_RX_BAD_PKT_BYTES_LOW, REG_FIELD_ID(AN8855_PORT_MIB_RX_BAD_PKT_BYTES_LOW, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_RX_BAD_PKT_BYTES_HIGH, REG_FIELD_ID(AN8855_PORT_MIB_RX_BAD_PKT_BYTES_HIGH, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_RXS_FLOW_SAMPLING_PKT_DROP, REG_FIELD_ID(AN8855_PORT_MIB_RXS_FLOW_SAMPLING_PKT_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_RXS_FLOW_TOTAL_PKT_DROP, REG_FIELD_ID(AN8855_PORT_MIB_RXS_FLOW_TOTAL_PKT_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+	{ AN8855_MIB_PORT_CONTROL_DROP, REG_FIELD_ID(AN8855_PORT_MIB_PORT_CONTROL_DROP, 0, 31, AN8855_NUM_PORTS, 0x200) },
+};
+
+static const struct mt7530_mib_desc an8855_mib[] = {
+	MIB_DESC(MT7530_MIB_TX_DROP, -1, "TxDrop"),
+	MIB_DESC(MT7530_MIB_TX_CRC_ERR, -1, "TxCrcErr"),
+	MIB_DESC(MT7530_MIB_TX_COLLISION, -1, "TxCollision"),
+	MIB_DESC(AN8855_MIB_TX_OVERSIZE_DROP, -1, "TxOversizeDrop"),
+	MIB_DESC(AN8855_MIB_TX_BAD_PKT_BYTES_LOW,
+		 AN8855_MIB_TX_BAD_PKT_BYTES_HIGH, "TxBadPktBytes"),
+	MIB_DESC(MT7530_MIB_RX_DROP, -1, "RxDrop"),
+	MIB_DESC(MT7530_MIB_RX_FILTERING, -1, "RxFiltering"),
+	MIB_DESC(MT7530_MIB_RX_CRC_ERR, -1, "RxCrcErr"),
+	MIB_DESC(MT7530_MIB_RX_CTRL_DROP, -1, "RxCtrlDrop"),
+	MIB_DESC(MT7530_MIB_RX_INGRESS_DROP, -1, "RxIngressDrop"),
+	MIB_DESC(MT7530_MIB_RX_ARL_DROP, -1, "RxArlDrop"),
+	MIB_DESC(AN8855_MIB_FLOW_CONTROL_DROP, -1, "FlowControlDrop"),
+	MIB_DESC(AN8855_MIB_WRED_DROP, -1, "WredDrop"),
+	MIB_DESC(AN8855_MIB_MIRROR_DROP, -1, "MirrorDrop"),
+	MIB_DESC(AN8855_MIB_RX_BAD_PKT_BYTES_LOW,
+		 AN8855_MIB_RX_BAD_PKT_BYTES_HIGH, "RxBadPktBytes"),
+	MIB_DESC(AN8855_MIB_RXS_FLOW_SAMPLING_PKT_DROP, -1, "RxsFlowSamplingPktDrop"),
+	MIB_DESC(AN8855_MIB_RXS_FLOW_TOTAL_PKT_DROP, -1, "RxsFlowTotalPktDrop"),
+	MIB_DESC(AN8855_MIB_PORT_CONTROL_DROP, -1, "PortControlDrop"),
+};
+
+static void
+an8855_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct an8855_priv *priv = ds->priv;
+	bool learning = false;
+	int ret;
+
+	mt7530_lib_stp_state_set(&priv->lib_priv, port, state);
+
+	switch (state) {
+	case BR_STATE_LEARNING:
+	case BR_STATE_FORWARDING:
+		learning = dp->learning;
+		fallthrough;
+	default:
+		break;
+	}
+
+	ret = regmap_update_bits(priv->regmap, AN8855_PSC_P(port), AN8855_SA_DIS,
+				 learning ? 0 : AN8855_SA_DIS);
+	if (ret)
+		dev_err(priv->ds->dev, "failed to update learn reg: %d\n", ret);
+}
+
+static void an8855_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct an8855_priv *priv = ds->priv;
+	int ret;
+
+	mutex_lock(&priv->reg_mutex);
+
+	/* Set to clean Dynamic entry */
+	ret = regmap_write(priv->regmap, AN8855_ATA2, AN8855_ATA2_TYPE);
+	if (ret) {
+		dev_err(priv->ds->dev, "failed to update ATA2 reg: %d\n", ret);
+		goto exit;
+	}
+
+	/* Set Port */
+	ret = regmap_write(priv->regmap, AN8855_ATWD2,
+			   FIELD_PREP(AN8855_ATWD2_PORT, BIT(port)));
+	if (ret) {
+		dev_err(priv->ds->dev, "failed to update ATWD2 reg: %d\n", ret);
+		goto exit;
+	}
+
+	/* Flush Dynamic entry at port */
+	ret = mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_FLUSH,
+				 AN8855_FDB_MAT_MAC_TYPE_PORT, NULL);
+	if (ret)
+		dev_err(priv->ds->dev, "failed to send FDB cmd: %d\n", ret);
+
+exit:
+	mutex_unlock(&priv->reg_mutex);
+}
+
+static int an8855_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					struct switchdev_brport_flags flags,
+					struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
+			   BR_BCAST_FLOOD | BR_ISOLATED))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int an8855_port_bridge_flags(struct dsa_switch *ds, int port,
+				    struct switchdev_brport_flags flags,
+				    struct netlink_ext_ack *extack)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_bridge_flags(&priv->lib_priv, port, flags,
+					    extack);
+}
+
+static int an8855_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct an8855_priv *priv = ds->priv;
+	u32 age_count, age_unit, val;
+
+	/* Convert msec in AN8855_L2_AGING_MS_CONSTANT counter */
+	val = msecs / AN8855_L2_AGING_MS_CONSTANT;
+
+	/* Derive the count unit */
+	age_unit = DIV_ROUND_UP(val, FIELD_MAX(AN8855_AGE_CNT) + 1) - 1;
+	if (age_unit > FIELD_MAX(AN8855_AGE_UNIT))
+		age_unit = FIELD_MAX(AN8855_AGE_UNIT);
+
+	/* Get the count in unit, age_unit is always incremented by 1 internally */
+	age_count = DIV_ROUND_UP(val, age_unit + 1) - 1;
+
+	return regmap_update_bits(priv->regmap, AN8855_AAC,
+				  AN8855_AGE_CNT | AN8855_AGE_UNIT,
+				  FIELD_PREP(AN8855_AGE_CNT, age_count) |
+				  FIELD_PREP(AN8855_AGE_UNIT, age_unit));
+}
+
+static int an8855_port_bridge_join(struct dsa_switch *ds, int port,
+				   struct dsa_bridge bridge,
+				   bool *tx_fwd_offload,
+				   struct netlink_ext_ack *extack)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_bridge_join(&priv->lib_priv, port, bridge,
+					   tx_fwd_offload, extack);
+}
+
+static void an8855_port_bridge_leave(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_bridge_leave(&priv->lib_priv, port, bridge);
+}
+
+static int an8855_port_fdb_add(struct dsa_switch *ds, int port,
+			       const unsigned char *addr, u16 vid,
+			       struct dsa_db db)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_fdb_add(&priv->lib_priv, port, addr, vid, db);
+}
+
+static int an8855_port_fdb_del(struct dsa_switch *ds, int port,
+			       const unsigned char *addr, u16 vid,
+			       struct dsa_db db)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_fdb_del(&priv->lib_priv, port, addr, vid, db);
+}
+
+static int an8855_port_fdb_dump(struct dsa_switch *ds, int port,
+				dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct an8855_priv *priv = ds->priv;
+	int banks, count = 0;
+	u32 rsp;
+	int ret;
+	int i;
+
+	mutex_lock(&priv->reg_mutex);
+
+	/* Load search port */
+	ret = regmap_write(priv->regmap, AN8855_ATWD2,
+			   FIELD_PREP(AN8855_ATWD2_PORT, BIT(port)));
+	if (ret)
+		goto exit;
+	ret = mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_START,
+				 AN8855_FDB_MAT_MAC_PORT, &rsp);
+	if (ret < 0)
+		goto exit;
+
+	do {
+		/* From response get the number of banks to read, exit if 0 */
+		banks = FIELD_GET(AN8855_ATC_HIT, rsp);
+		if (!banks)
+			break;
+
+		/* Each banks have 4 entry */
+		for (i = 0; i < 4; i++) {
+			struct mt7530_fdb _fdb = {  };
+
+			count++;
+
+			/* Check if bank is present */
+			if (!(banks & BIT(i)))
+				continue;
+
+			/* Select bank entry index */
+			ret = regmap_write(priv->regmap, AN8855_ATRDS,
+					   FIELD_PREP(AN8855_ATRD_SEL, i));
+			if (ret)
+				break;
+			/* wait 1ms for the bank entry to be filled */
+			usleep_range(1000, 1500);
+			mt7530_lib_fdb_read(&priv->lib_priv, &_fdb);
+
+			ret = cb(_fdb.mac, _fdb.vid, _fdb.noarp, data);
+			if (ret < 0)
+				break;
+		}
+
+		/* Stop if reached max FDB number */
+		if (ret < 0 || count >= AN8855_NUM_FDB_RECORDS)
+			break;
+
+		/* Read next bank */
+		ret = mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_NEXT,
+					 AN8855_FDB_MAT_MAC_PORT, &rsp);
+		if (ret < 0)
+			break;
+	} while (true);
+
+exit:
+	mutex_unlock(&priv->reg_mutex);
+	return ret;
+}
+
+static int an8855_port_vlan_filtering(struct dsa_switch *ds, int port,
+				      bool vlan_filtering,
+				      struct netlink_ext_ack *extack)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_vlan_filtering(&priv->lib_priv, port,
+					      vlan_filtering,
+					      extack);
+}
+
+static int an8855_port_vlan_add(struct dsa_switch *ds, int port,
+				const struct switchdev_obj_port_vlan *vlan,
+				struct netlink_ext_ack *extack)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_vlan_add(&priv->lib_priv, port, vlan, extack);
+}
+
+static int an8855_port_vlan_del(struct dsa_switch *ds, int port,
+				const struct switchdev_obj_port_vlan *vlan)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_vlan_del(&priv->lib_priv, port, vlan);
+}
+
+static int an8855_port_mdb_add(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_mdb *mdb,
+			       struct dsa_db db)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_mdb_add(&priv->lib_priv, port, mdb, db);
+}
+
+static int an8855_port_mdb_del(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_mdb *mdb,
+			       struct dsa_db db)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_mdb_del(&priv->lib_priv, port, mdb, db);
+}
+
+static int an8855_port_change_mtu(struct dsa_switch *ds, int port,
+				  int new_mtu)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_change_mtu(&priv->lib_priv, port, new_mtu);
+}
+
+static int an8855_port_max_mtu(struct dsa_switch *ds, int port)
+{
+	return AN8855_MAX_MTU;
+}
+
+static void an8855_get_strings(struct dsa_switch *ds, int port,
+			       u32 stringset, uint8_t *data)
+{
+	int i;
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(an8855_mib); i++)
+		ethtool_puts(&data, an8855_mib[i].name);
+}
+
+static void an8855_get_ethtool_stats(struct dsa_switch *ds, int port,
+				     uint64_t *data)
+{
+	struct an8855_priv *priv = ds->priv;
+	const struct mt7530_mib_desc *mib;
+	struct mt7530_lib_priv *lib_priv;
+	int i;
+
+	lib_priv = &priv->lib_priv;
+	for (i = 0; i < ARRAY_SIZE(an8855_mib); i++) {
+		struct regmap_field *high = NULL;
+
+		mib = &an8855_mib[i];
+		if (mib->field_high != -1)
+			high = lib_priv->fields[mib->field_high];
+
+		mt7530_lib_read_port_stats(lib_priv->fields[mib->field_low],
+					   high, port, data + i);
+	}
+}
+
+static int an8855_get_sset_count(struct dsa_switch *ds, int port,
+				 int sset)
+{
+	if (sset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	return ARRAY_SIZE(an8855_mib);
+}
+
+static void an8855_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				     struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_get_eth_mac_stats(&priv->lib_priv, port, mac_stats);
+}
+
+static const struct ethtool_rmon_hist_range an8855_rmon_ranges[] = {
+	{ 0, 64 },
+	{ 65, 127 },
+	{ 128, 255 },
+	{ 256, 511 },
+	{ 512, 1023 },
+	{ 1024, 1518 },
+	{ 1519, AN8855_MAX_MTU },
+	{}
+};
+
+static const struct mt7530_rmon_hist an8855_rmon_hist_info = {
+	.ranges_fields = (unsigned int []){
+		MT7530_MIB_RX_PKT_SZ_64,
+		MT7530_MIB_RX_PKT_SZ_65_TO_127,
+		MT7530_MIB_RX_PKT_SZ_128_TO_255,
+		MT7530_MIB_RX_PKT_SZ_256_TO_511,
+		MT7530_MIB_RX_PKT_SZ_512_TO_1023,
+		AN8855_MIB_RX_PKT_SZ_1024_TO_1518,
+		AN8855_MIB_RX_PKT_SZ_1519_TO_MAX,
+	},
+	.ranges_tx_fields = (unsigned int []){
+		MT7530_MIB_TX_PKT_SZ_64,
+		MT7530_MIB_TX_PKT_SZ_65_TO_127,
+		MT7530_MIB_TX_PKT_SZ_128_TO_255,
+		MT7530_MIB_TX_PKT_SZ_256_TO_511,
+		MT7530_MIB_TX_PKT_SZ_512_TO_1023,
+		AN8855_MIB_TX_PKT_SZ_1024_TO_1518,
+		AN8855_MIB_TX_PKT_SZ_1519_TO_MAX,
+	},
+	.ranges = an8855_rmon_ranges,
+	.num_ranges = ARRAY_SIZE(an8855_rmon_ranges) - 1,
+};
+
+static void an8855_get_rmon_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_rmon_stats *rmon_stats,
+				  const struct ethtool_rmon_hist_range **ranges)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_get_rmon_stats(&priv->lib_priv, port, rmon_stats, ranges,
+					 &an8855_rmon_hist_info);
+}
+
+static void an8855_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				      struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	mt7530_lib_get_eth_ctrl_stats(&priv->lib_priv, port, ctrl_stats);
+}
+
+static int an8855_port_mirror_add(struct dsa_switch *ds, int port,
+				  struct dsa_mall_mirror_tc_entry *mirror,
+				  bool ingress,
+				  struct netlink_ext_ack *extack)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	return mt7530_lib_port_mirror_add(&priv->lib_priv, port, mirror, ingress, extack);
+}
+
+static void an8855_port_mirror_del(struct dsa_switch *ds, int port,
+				   struct dsa_mall_mirror_tc_entry *mirror)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	mt7530_lib_port_mirror_del(&priv->lib_priv, port, mirror);
+}
+
+static int an8855_port_enable(struct dsa_switch *ds, int port,
+			      struct phy_device *phy)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct an8855_priv *priv = ds->priv;
+	int ret;
+
+	mutex_lock(&priv->reg_mutex);
+
+	/* Allow the user port gets connected to the cpu port and also
+	 * restore the port matrix if the port is the member of a certain
+	 * bridge.
+	 */
+	if (dsa_port_is_user(dp)) {
+		struct dsa_port *cpu_dp = dp->cpu_dp;
+
+		priv->ports[port].pm |= BIT(cpu_dp->index);
+	}
+	priv->ports[port].enable = true;
+	ret = regmap_fields_write(priv->lib_priv.fields[MT7530_PCR_MATRIX],
+				  port, 0);
+	if (ret)
+		goto exit;
+
+	ret = regmap_set_bits(priv->regmap, AN8855_PMCR_P(port),
+			      AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
+
+exit:
+	mutex_unlock(&priv->reg_mutex);
+
+	return ret;
+}
+
+static void an8855_port_disable(struct dsa_switch *ds, int port)
+{
+	struct an8855_priv *priv = ds->priv;
+	int ret;
+
+	mutex_lock(&priv->reg_mutex);
+	priv->ports[port].enable = false;
+	ret = regmap_fields_write(priv->lib_priv.fields[MT7530_PCR_MATRIX],
+				  port, 0);
+	if (ret)
+		goto exit;
+
+	ret = regmap_clear_bits(priv->regmap, AN8855_PMCR_P(port),
+				AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
+exit:
+	mutex_unlock(&priv->reg_mutex);
+	if (ret)
+		dev_err(priv->ds->dev, "failed to disable port: %d\n", ret);
+}
+
+static int an8855_set_mac_eee(struct dsa_switch *ds, int port,
+			      struct ethtool_keee *e)
+{
+	if (e->tx_lpi_timer > 0xFFF)
+		return -EINVAL;
+
+	return 0;
+}
+
+static enum dsa_tag_protocol an8855_get_tag_protocol(struct dsa_switch *ds,
+						     int port,
+						     enum dsa_tag_protocol mp)
+{
+	return DSA_TAG_PROTO_AIROHA;
+}
+
+static int an8855_setup(struct dsa_switch *ds)
+{
+	struct an8855_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	int ret;
+
+	/* Enable and reset MIB counters */
+	mt7530_lib_mib_reset(&priv->lib_priv);
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		/* Disable MAC by default on all user ports */
+		an8855_port_disable(ds, dp->index);
+
+		/* Individual user ports get connected to CPU port only */
+		ret = regmap_write(priv->regmap, AN8855_PORTMATRIX_P(dp->index),
+				   FIELD_PREP(AN8855_PORTMATRIX_MASK, BIT(AN8855_CPU_PORT)));
+		if (ret)
+			return ret;
+
+		/* Disable Broadcast Forward on user ports */
+		ret = regmap_clear_bits(priv->regmap, AN8855_BCF, BIT(dp->index));
+		if (ret)
+			return ret;
+
+		/* Disable Unknown Unicast Forward on user ports */
+		ret = regmap_clear_bits(priv->regmap, AN8855_UNUF, BIT(dp->index));
+		if (ret)
+			return ret;
+
+		/* Disable Unknown Multicast Forward on user ports */
+		ret = regmap_clear_bits(priv->regmap, AN8855_UNMF, BIT(dp->index));
+		if (ret)
+			return ret;
+
+		ret = regmap_clear_bits(priv->regmap, AN8855_UNIPMF, BIT(dp->index));
+		if (ret)
+			return ret;
+
+		/* Set default PVID to on all user ports */
+		mt7530_port_set_pvid(&priv->lib_priv, dp->index, AN8855_PORT_VID_DEFAULT);
+	}
+
+	/* Enable Airoha header mode on the cpu port */
+	ret = regmap_write(priv->regmap, AN8855_PVC_P(AN8855_CPU_PORT),
+			   AN8855_PORT_SPEC_REPLACE_MODE | AN8855_PORT_SPEC_TAG);
+	if (ret)
+		return ret;
+
+	/* Unknown multicast frame forwarding to the cpu port */
+	ret = regmap_write(priv->regmap, AN8855_UNMF, BIT(AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	/* Set CPU port number */
+	ret = regmap_update_bits(priv->regmap, AN8855_MFC,
+				 AN8855_CPU_EN | AN8855_CPU_PORT_IDX,
+				 AN8855_CPU_EN |
+				 FIELD_PREP(AN8855_CPU_PORT_IDX, AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	/* CPU port gets connected to all user ports of
+	 * the switch.
+	 */
+	ret = regmap_write(priv->regmap, AN8855_PORTMATRIX_P(AN8855_CPU_PORT),
+			   FIELD_PREP(AN8855_PORTMATRIX_MASK, dsa_user_ports(ds)));
+	if (ret)
+		return ret;
+
+	/* CPU port is set to fallback mode to let untagged
+	 * frames pass through.
+	 */
+	ret = regmap_update_bits(priv->regmap, AN8855_PCR_P(AN8855_CPU_PORT),
+				 AN8855_PORT_VLAN,
+				 FIELD_PREP(AN8855_PORT_VLAN, AN8855_PORT_FALLBACK_MODE));
+	if (ret)
+		return ret;
+
+	/* Enable Broadcast Forward on CPU port */
+	ret = regmap_set_bits(priv->regmap, AN8855_BCF, BIT(AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	/* Enable Unknown Unicast Forward on CPU port */
+	ret = regmap_set_bits(priv->regmap, AN8855_UNUF, BIT(AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	/* Enable Unknown Multicast Forward on CPU port */
+	ret = regmap_set_bits(priv->regmap, AN8855_UNMF, BIT(AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(priv->regmap, AN8855_UNIPMF, BIT(AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	/* Setup Trap special frame to CPU rules */
+	mt7530_lib_trap_frames(&priv->lib_priv);
+
+	dsa_switch_for_each_port(dp, ds) {
+		/* Disable Learning on all ports.
+		 * Learning on CPU is disabled for fdb isolation and handled by
+		 * assisted_learning_on_cpu_port.
+		 */
+		ret = regmap_set_bits(priv->regmap, AN8855_PSC_P(dp->index),
+				      AN8855_SA_DIS);
+		if (ret)
+			return ret;
+
+		/* Enable consistent egress tag (for VLAN unware VLAN-passthrough) */
+		ret = regmap_update_bits(priv->regmap, AN8855_PVC_P(dp->index),
+					 AN8855_PVC_EG_TAG,
+					 FIELD_PREP(AN8855_PVC_EG_TAG, AN8855_VLAN_EG_CONSISTENT));
+		if (ret)
+			return ret;
+	}
+
+	/* Setup VLAN for Default PVID */
+	ret = mt7530_lib_setup_vlan0(&priv->lib_priv);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(priv->regmap, AN8855_CKGCR,
+				AN8855_CKG_LNKDN_GLB_STOP | AN8855_CKG_LNKDN_PORT_STOP);
+	if (ret)
+		return ret;
+
+	/* Flush the FDB table */
+	ret = mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_FLUSH,
+				 AN8855_FDB_MAT_ALL, NULL);
+	if (ret < 0)
+		return ret;
+
+	/* Set min a max ageing value supported */
+	ds->ageing_time_min = AN8855_L2_AGING_MS_CONSTANT;
+	ds->ageing_time_max = FIELD_MAX(AN8855_AGE_CNT) *
+			      FIELD_MAX(AN8855_AGE_UNIT) *
+			      AN8855_L2_AGING_MS_CONSTANT;
+
+	/* User reported problem with WiFi roaming and
+	 * ethernet port. Enabling assisted learning fix
+	 * the issue.
+	 */
+	ds->assisted_learning_on_cpu_port = true;
+
+	return 0;
+}
+
+static struct phylink_pcs *an8855_phylink_mac_select_pcs(struct phylink_config *config,
+							 phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct an8855_priv *priv = dp->ds->priv;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return &priv->pcs;
+	default:
+		return NULL;
+	}
+}
+
+static void an8855_phylink_mac_config(struct phylink_config *config,
+				      unsigned int mode,
+				      const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct dsa_switch *ds = dp->ds;
+	struct an8855_priv *priv;
+	int port = dp->index;
+
+	priv = ds->priv;
+
+	/* Nothing to configure for internal ports */
+	if (port != 5)
+		return;
+
+	mutex_lock(&priv->reg_mutex);
+	regmap_update_bits(priv->regmap, AN8855_PMCR_P(port),
+			   AN8855_PMCR_IFG_XMIT | AN8855_PMCR_MAC_MODE |
+			   AN8855_PMCR_BACKOFF_EN | AN8855_PMCR_BACKPR_EN,
+			   FIELD_PREP(AN8855_PMCR_IFG_XMIT, 0x1) |
+			   AN8855_PMCR_MAC_MODE | AN8855_PMCR_BACKOFF_EN |
+			   AN8855_PMCR_BACKPR_EN);
+	mutex_unlock(&priv->reg_mutex);
+}
+
+static void an8855_phylink_get_caps(struct dsa_switch *ds, int port,
+				    struct phylink_config *config)
+{
+	struct an8855_priv *priv = ds->priv;
+	u32 reg = 0;
+	int ret;
+
+	switch (port) {
+	case 0:
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		break;
+	case 5:
+		phy_interface_set_rgmii(config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		break;
+	}
+
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+				   MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
+
+	ret = regmap_read(priv->regmap, AN8855_CKGCR, &reg);
+	if (ret)
+		dev_err(ds->dev, "failed to read EEE LPI timer\n");
+
+	memcpy(config->lpi_interfaces, config->supported_interfaces,
+	       sizeof(config->lpi_interfaces));
+	config->lpi_capabilities = MAC_100FD | MAC_1000FD;
+	/* Global LPI TXIDLE Threshold, default 60ms (unit 2us) */
+	config->lpi_timer_default = FIELD_GET(AN8855_LPI_TXIDLE_THD_MASK, reg) *
+				    AN8855_TX_LPI_UNIT;
+
+	config->eee_enabled_default = true;
+}
+
+static void an8855_phylink_mac_link_down(struct phylink_config *config,
+					 unsigned int mode,
+					 phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct an8855_priv *priv = dp->ds->priv;
+
+	mutex_lock(&priv->reg_mutex);
+
+	/* With autoneg just disable TX/RX else also force link down */
+	if (phylink_autoneg_inband(mode)) {
+		regmap_clear_bits(priv->regmap, AN8855_PMCR_P(dp->index),
+				  AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
+	} else {
+		regmap_update_bits(priv->regmap, AN8855_PMCR_P(dp->index),
+				   AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN |
+				   AN8855_PMCR_FORCE_MODE | AN8855_PMCR_FORCE_LNK,
+				   AN8855_PMCR_FORCE_MODE);
+	}
+
+	mutex_unlock(&priv->reg_mutex);
+}
+
+static void an8855_phylink_mac_link_up(struct phylink_config *config,
+				       struct phy_device *phydev, unsigned int mode,
+				       phy_interface_t interface, int speed,
+				       int duplex, bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct an8855_priv *priv = dp->ds->priv;
+	int port = dp->index;
+	u32 reg = 0;
+
+	mutex_lock(&priv->reg_mutex);
+
+	regmap_read(priv->regmap, AN8855_PMCR_P(port), &reg);
+	if (phylink_autoneg_inband(mode)) {
+		reg &= ~AN8855_PMCR_FORCE_MODE;
+	} else {
+		reg |= AN8855_PMCR_FORCE_MODE | AN8855_PMCR_FORCE_LNK;
+
+		reg &= ~AN8855_PMCR_FORCE_SPEED;
+		switch (speed) {
+		case SPEED_10:
+			reg |= AN8855_PMCR_FORCE_SPEED_10;
+			break;
+		case SPEED_100:
+			reg |= AN8855_PMCR_FORCE_SPEED_100;
+			break;
+		case SPEED_1000:
+			reg |= AN8855_PMCR_FORCE_SPEED_1000;
+			break;
+		case SPEED_2500:
+			reg |= AN8855_PMCR_FORCE_SPEED_2500;
+			break;
+		case SPEED_5000:
+			dev_err(priv->ds->dev, "Missing support for 5G speed. Aborting...\n");
+			goto exit;
+		}
+
+		reg &= ~AN8855_PMCR_FORCE_FDX;
+		if (duplex == DUPLEX_FULL)
+			reg |= AN8855_PMCR_FORCE_FDX;
+
+		reg &= ~AN8855_PMCR_RX_FC_EN;
+		if (rx_pause || dsa_port_is_cpu(dp))
+			reg |= AN8855_PMCR_RX_FC_EN;
+
+		reg &= ~AN8855_PMCR_TX_FC_EN;
+		if (tx_pause || dsa_port_is_cpu(dp))
+			reg |= AN8855_PMCR_TX_FC_EN;
+	}
+
+	reg |= AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN;
+
+	regmap_write(priv->regmap, AN8855_PMCR_P(port), reg);
+
+exit:
+	mutex_unlock(&priv->reg_mutex);
+}
+
+static void an8855_phylink_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct an8855_priv *priv = dp->ds->priv;
+	int port = dp->index;
+	int ret;
+
+	mutex_lock(&priv->reg_mutex);
+	priv->tx_lpi_timer_ports[port] = 0;
+	ret = regmap_clear_bits(priv->regmap, AN8855_PMCR_P(port),
+				AN8855_PMCR_FORCE_EEE1G |
+				AN8855_PMCR_FORCE_EEE100);
+	mutex_unlock(&priv->reg_mutex);
+	if (ret)
+		dev_err(dp->ds->dev, "failed to disable EEE for port %d\n",
+			port);
+
+	ret = regmap_clear_bits(priv->regmap, AN8855_PMEEECR_P(port),
+				AN8855_LPI_MODE_EN);
+	if (ret)
+		dev_err(dp->ds->dev, "failed to disable LPI for port %d\n",
+			port);
+}
+
+static int an8855_phylink_mac_enable_tx_lpi(struct phylink_config *config,
+					    u32 timer, bool tx_clock_stop)
+{
+	struct an8855_priv *priv;
+	struct dsa_switch *ds;
+	struct dsa_port *dp;
+	int port;
+	u32 val;
+	int ret;
+
+	dp = dsa_phylink_to_port(config);
+	port = dp->index;
+	ds = dp->ds;
+	priv = ds->priv;
+
+	/* TX LPI timer is global, find the highest timer
+	 * across all port.
+	 * If requested timer is 0, set to enter LPI immediately
+	 * for the single port.
+	 */
+	if (timer) {
+		int i;
+
+		/* Save requested timer and search the highest one */
+		mutex_lock(&priv->reg_mutex);
+		priv->tx_lpi_timer_ports[port] = timer;
+		for (i = 0; i < AN8855_NUM_PORTS; i++) {
+			if (!priv->ports[i].enable)
+				continue;
+
+			if (i == port)
+				continue;
+
+			if (timer < priv->tx_lpi_timer_ports[i])
+				timer = priv->tx_lpi_timer_ports[i];
+		}
+
+		timer /= AN8855_TX_LPI_UNIT;
+		if (FIELD_FIT(AN8855_LPI_TXIDLE_THD_MASK, timer))
+			val = FIELD_PREP(AN8855_LPI_TXIDLE_THD_MASK, timer);
+		else
+			val = AN8855_LPI_TXIDLE_THD_MASK;
+
+		ret = regmap_update_bits(priv->regmap, AN8855_CKGCR,
+					 AN8855_LPI_TXIDLE_THD_MASK, val);
+		mutex_unlock(&priv->reg_mutex);
+		if (ret) {
+			dev_err(dp->ds->dev, "failed to set global LPI timer\n");
+			return ret;
+		}
+	} else {
+		ret = regmap_set_bits(priv->regmap, AN8855_PMEEECR_P(port),
+				      AN8855_LPI_MODE_EN);
+		if (ret) {
+			dev_err(dp->ds->dev, "failed to enable LPI for port %d\n",
+				port);
+			return ret;
+		}
+	}
+
+	mutex_lock(&priv->reg_mutex);
+	ret = regmap_set_bits(priv->regmap, AN8855_PMCR_P(port),
+			      AN8855_PMCR_FORCE_EEE1G |
+			      AN8855_PMCR_FORCE_EEE100);
+	mutex_unlock(&priv->reg_mutex);
+	if (ret)
+		dev_err(dp->ds->dev, "failed to enable EEE for port %d\n",
+			port);
+
+	return ret;
+}
+
+static unsigned int an8855_pcs_inband_caps(struct phylink_pcs *pcs,
+					   phy_interface_t interface)
+{
+	/* SGMII can be configured to use inband with AN result */
+	if (interface == PHY_INTERFACE_MODE_SGMII)
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+
+	/* inband is not supported in 2500-baseX and must be disabled */
+	return LINK_INBAND_DISABLE;
+}
+
+static void an8855_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+				 struct phylink_link_state *state)
+{
+	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, AN8855_PMSR_P(AN8855_CPU_PORT), &val);
+	if (ret < 0) {
+		state->link = false;
+		return;
+	}
+
+	state->link = !!(val & AN8855_PMSR_LNK);
+	state->an_complete = state->link;
+	state->duplex = (val & AN8855_PMSR_DPX) ? DUPLEX_FULL :
+						  DUPLEX_HALF;
+
+	switch (val & AN8855_PMSR_SPEED) {
+	case AN8855_PMSR_SPEED_10:
+		state->speed = SPEED_10;
+		break;
+	case AN8855_PMSR_SPEED_100:
+		state->speed = SPEED_100;
+		break;
+	case AN8855_PMSR_SPEED_1000:
+		state->speed = SPEED_1000;
+		break;
+	case AN8855_PMSR_SPEED_2500:
+		state->speed = SPEED_2500;
+		break;
+	case AN8855_PMSR_SPEED_5000:
+		dev_err(priv->ds->dev, "Switch doesn't support 5G speed. Setting Unknown.\n");
+		fallthrough;
+	default:
+		state->speed = SPEED_UNKNOWN;
+		break;
+	}
+
+	if (val & AN8855_PMSR_RX_FC)
+		state->pause |= MLO_PAUSE_RX;
+	if (val & AN8855_PMSR_TX_FC)
+		state->pause |= MLO_PAUSE_TX;
+}
+
+static int an8855_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			     phy_interface_t interface,
+			     const unsigned long *advertising,
+			     bool permit_pause_to_mac)
+{
+	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
+	u32 val;
+	int ret;
+
+	/* TX FIR - improve TX EYE */
+	ret = regmap_update_bits(priv->regmap, AN8855_INTF_CTRL_10,
+				 AN8855_RG_DA_QP_TX_FIR_C2_SEL |
+				 AN8855_RG_DA_QP_TX_FIR_C2_FORCE |
+				 AN8855_RG_DA_QP_TX_FIR_C1_SEL |
+				 AN8855_RG_DA_QP_TX_FIR_C1_FORCE,
+				 AN8855_RG_DA_QP_TX_FIR_C2_SEL |
+				 FIELD_PREP(AN8855_RG_DA_QP_TX_FIR_C2_FORCE, 0x4) |
+				 AN8855_RG_DA_QP_TX_FIR_C1_SEL |
+				 FIELD_PREP(AN8855_RG_DA_QP_TX_FIR_C1_FORCE, 0x0));
+	if (ret)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x0;
+	else
+		val = 0xd;
+	ret = regmap_update_bits(priv->regmap, AN8855_INTF_CTRL_11,
+				 AN8855_RG_DA_QP_TX_FIR_C0B_SEL |
+				 AN8855_RG_DA_QP_TX_FIR_C0B_FORCE,
+				 AN8855_RG_DA_QP_TX_FIR_C0B_SEL |
+				 FIELD_PREP(AN8855_RG_DA_QP_TX_FIR_C0B_FORCE, val));
+	if (ret)
+		return ret;
+
+	/* RX CDR - improve RX Jitter Tolerance */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x5;
+	else
+		val = 0x6;
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_BOT_LIM,
+				 AN8855_RG_QP_CDR_LPF_KP_GAIN |
+				 AN8855_RG_QP_CDR_LPF_KI_GAIN,
+				 FIELD_PREP(AN8855_RG_QP_CDR_LPF_KP_GAIN, val) |
+				 FIELD_PREP(AN8855_RG_QP_CDR_LPF_KI_GAIN, val));
+	if (ret)
+		return ret;
+
+	/* PLL */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x1;
+	else
+		val = 0x0;
+	ret = regmap_update_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_1,
+				 AN8855_RG_TPHY_SPEED,
+				 FIELD_PREP(AN8855_RG_TPHY_SPEED, val));
+	if (ret)
+		return ret;
+
+	/* PLL - LPF */
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				 AN8855_RG_DA_QP_PLL_RICO_SEL_INTF |
+				 AN8855_RG_DA_QP_PLL_FBKSEL_INTF |
+				 AN8855_RG_DA_QP_PLL_BR_INTF |
+				 AN8855_RG_DA_QP_PLL_BPD_INTF |
+				 AN8855_RG_DA_QP_PLL_BPA_INTF |
+				 AN8855_RG_DA_QP_PLL_BC_INTF,
+				 AN8855_RG_DA_QP_PLL_RICO_SEL_INTF |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_FBKSEL_INTF, 0x0) |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BR_INTF, 0x3) |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BPD_INTF, 0x0) |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BPA_INTF, 0x5) |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BC_INTF, 0x1));
+	if (ret)
+		return ret;
+
+	/* PLL - ICO */
+	ret = regmap_set_bits(priv->regmap, AN8855_PLL_CTRL_4,
+			      AN8855_RG_DA_QP_PLL_ICOLP_EN_INTF);
+	if (ret)
+		return ret;
+	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				AN8855_RG_DA_QP_PLL_ICOIQ_EN_INTF);
+	if (ret)
+		return ret;
+
+	/* PLL - CHP */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x6;
+	else
+		val = 0x4;
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				 AN8855_RG_DA_QP_PLL_IR_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_IR_INTF, val));
+	if (ret)
+		return ret;
+
+	/* PLL - PFD */
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				 AN8855_RG_DA_QP_PLL_PFD_OFFSET_EN_INTRF |
+				 AN8855_RG_DA_QP_PLL_PFD_OFFSET_INTF |
+				 AN8855_RG_DA_QP_PLL_KBAND_PREDIV_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_PFD_OFFSET_INTF, 0x1) |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_KBAND_PREDIV_INTF, 0x1));
+	if (ret)
+		return ret;
+
+	/* PLL - POSTDIV */
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				 AN8855_RG_DA_QP_PLL_POSTDIV_EN_INTF |
+				 AN8855_RG_DA_QP_PLL_PHY_CK_EN_INTF |
+				 AN8855_RG_DA_QP_PLL_PCK_SEL_INTF,
+				 AN8855_RG_DA_QP_PLL_PCK_SEL_INTF);
+	if (ret)
+		return ret;
+
+	/* PLL - SDM */
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				 AN8855_RG_DA_QP_PLL_SDM_HREN_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SDM_HREN_INTF, 0x0));
+	if (ret)
+		return ret;
+	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				AN8855_RG_DA_QP_PLL_SDM_IFM_INTF);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_SS_LCPLL_PWCTL_SETTING_2,
+				 AN8855_RG_NCPO_ANA_MSB,
+				 FIELD_PREP(AN8855_RG_NCPO_ANA_MSB, 0x1));
+	if (ret)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x7a000000;
+	else
+		val = 0x48000000;
+	ret = regmap_write(priv->regmap, AN8855_SS_LCPLL_TDC_FLT_2,
+			   FIELD_PREP(AN8855_RG_LCPLL_NCPO_VALUE, val));
+	if (ret)
+		return ret;
+	ret = regmap_write(priv->regmap, AN8855_SS_LCPLL_TDC_PCW_1,
+			   FIELD_PREP(AN8855_RG_LCPLL_PON_HRDDS_PCW_NCPO_GPON, val));
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(priv->regmap, AN8855_SS_LCPLL_TDC_FLT_5,
+				AN8855_RG_LCPLL_NCPO_CHG);
+	if (ret)
+		return ret;
+	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CK_CTRL_0,
+				AN8855_RG_DA_QP_PLL_SDM_DI_EN_INTF);
+	if (ret)
+		return ret;
+
+	/* PLL - SS */
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_3,
+				 AN8855_RG_DA_QP_PLL_SSC_DELTA_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SSC_DELTA_INTF, 0x0));
+	if (ret)
+		return ret;
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_4,
+				 AN8855_RG_DA_QP_PLL_SSC_DIR_DLY_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SSC_DIR_DLY_INTF, 0x0));
+	if (ret)
+		return ret;
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_3,
+				 AN8855_RG_DA_QP_PLL_SSC_PERIOD_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SSC_PERIOD_INTF, 0x0));
+	if (ret)
+		return ret;
+
+	/* PLL - TDC */
+	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CK_CTRL_0,
+				AN8855_RG_DA_QP_PLL_TDC_TXCK_SEL_INTF);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_PLL_SDM_ORD,
+			      AN8855_RG_QP_PLL_SSC_TRI_EN);
+	if (ret)
+		return ret;
+	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_PLL_SDM_ORD,
+			      AN8855_RG_QP_PLL_SSC_PHASE_INI);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_RX_DAC_EN,
+				 AN8855_RG_QP_SIGDET_HF,
+				 FIELD_PREP(AN8855_RG_QP_SIGDET_HF, 0x2));
+	if (ret)
+		return ret;
+
+	/* TCL Disable (only for Co-SIM) */
+	ret = regmap_clear_bits(priv->regmap, AN8855_PON_RXFEDIG_CTRL_0,
+				AN8855_RG_QP_EQ_RX500M_CK_SEL);
+	if (ret)
+		return ret;
+
+	/* TX Init */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x4;
+	else
+		val = 0x0;
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_TX_MODE,
+				 AN8855_RG_QP_TX_RESERVE |
+				 AN8855_RG_QP_TX_MODE_16B_EN,
+				 FIELD_PREP(AN8855_RG_QP_TX_RESERVE, val));
+	if (ret)
+		return ret;
+
+	/* RX Control/Init */
+	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_RXAFE_RESERVE,
+			      AN8855_RG_QP_CDR_PD_10B_EN);
+	if (ret)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x1;
+	else
+		val = 0x2;
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_MJV_LIM,
+				 AN8855_RG_QP_CDR_LPF_RATIO,
+				 FIELD_PREP(AN8855_RG_QP_CDR_LPF_RATIO, val));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_SETVALUE,
+				 AN8855_RG_QP_CDR_PR_BUF_IN_SR |
+				 AN8855_RG_QP_CDR_PR_BETA_SEL,
+				 FIELD_PREP(AN8855_RG_QP_CDR_PR_BUF_IN_SR, 0x6) |
+				 FIELD_PREP(AN8855_RG_QP_CDR_PR_BETA_SEL, 0x1));
+	if (ret)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0xf;
+	else
+		val = 0xc;
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_CKREF_DIV1,
+				 AN8855_RG_QP_CDR_PR_DAC_BAND,
+				 FIELD_PREP(AN8855_RG_QP_CDR_PR_DAC_BAND, val));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE,
+				 AN8855_RG_QP_CDR_PR_KBAND_PCIE_MODE |
+				 AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE_MASK,
+				 FIELD_PREP(AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE_MASK, 0x19));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_FORCE_IBANDLPF_R_OFF,
+				 AN8855_RG_QP_CDR_PHYCK_SEL |
+				 AN8855_RG_QP_CDR_PHYCK_RSTB |
+				 AN8855_RG_QP_CDR_PHYCK_DIV,
+				 FIELD_PREP(AN8855_RG_QP_CDR_PHYCK_SEL, 0x2) |
+				 FIELD_PREP(AN8855_RG_QP_CDR_PHYCK_DIV, 0x21));
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(priv->regmap, AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE,
+				AN8855_RG_QP_CDR_PR_XFICK_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_CKREF_DIV1,
+				 AN8855_RG_QP_CDR_PR_KBAND_DIV,
+				 FIELD_PREP(AN8855_RG_QP_CDR_PR_KBAND_DIV, 0x4));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_26,
+				 AN8855_RG_QP_EQ_RETRAIN_ONLY_EN |
+				 AN8855_RG_LINK_NE_EN |
+				 AN8855_RG_LINK_ERRO_EN,
+				 AN8855_RG_QP_EQ_RETRAIN_ONLY_EN |
+				 AN8855_RG_LINK_ERRO_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_DLY_0,
+				 AN8855_RG_QP_RX_SAOSC_EN_H_DLY |
+				 AN8855_RG_QP_RX_PI_CAL_EN_H_DLY,
+				 FIELD_PREP(AN8855_RG_QP_RX_SAOSC_EN_H_DLY, 0x3f) |
+				 FIELD_PREP(AN8855_RG_QP_RX_PI_CAL_EN_H_DLY, 0x6f));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_42,
+				 AN8855_RG_QP_EQ_EN_DLY,
+				 FIELD_PREP(AN8855_RG_QP_EQ_EN_DLY, 0x150));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_2,
+				 AN8855_RG_QP_RX_EQ_EN_H_DLY,
+				 FIELD_PREP(AN8855_RG_QP_RX_EQ_EN_H_DLY, 0x150));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_PON_RXFEDIG_CTRL_9,
+				 AN8855_RG_QP_EQ_LEQOSC_DLYCNT,
+				 FIELD_PREP(AN8855_RG_QP_EQ_LEQOSC_DLYCNT, 0x1));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_8,
+				 AN8855_RG_DA_QP_SAOSC_DONE_TIME |
+				 AN8855_RG_DA_QP_LEQOS_EN_TIME,
+				 FIELD_PREP(AN8855_RG_DA_QP_SAOSC_DONE_TIME, 0x200) |
+				 FIELD_PREP(AN8855_RG_DA_QP_LEQOS_EN_TIME, 0xfff));
+	if (ret)
+		return ret;
+
+	/* Frequency meter */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x10;
+	else
+		val = 0x28;
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_5,
+				 AN8855_RG_FREDET_CHK_CYCLE,
+				 FIELD_PREP(AN8855_RG_FREDET_CHK_CYCLE, val));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_6,
+				 AN8855_RG_FREDET_GOLDEN_CYCLE,
+				 FIELD_PREP(AN8855_RG_FREDET_GOLDEN_CYCLE, 0x64));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_7,
+				 AN8855_RG_FREDET_TOLERATE_CYCLE,
+				 FIELD_PREP(AN8855_RG_FREDET_TOLERATE_CYCLE, 0x2710));
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(priv->regmap, AN8855_PLL_CTRL_0,
+			      AN8855_RG_PHYA_AUTO_INIT);
+	if (ret)
+		return ret;
+
+	/* PCS Init */
+	if (interface == PHY_INTERFACE_MODE_SGMII &&
+	    neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED) {
+		ret = regmap_clear_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_0,
+					AN8855_RG_SGMII_MODE | AN8855_RG_SGMII_AN_EN);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_clear_bits(priv->regmap, AN8855_RG_HSGMII_PCS_CTROL_1,
+				AN8855_RG_TBI_10B_MODE);
+	if (ret)
+		return ret;
+
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+		/* Set AN Ability - Interrupt */
+		ret = regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN_FORCE_CL37,
+				      AN8855_RG_FORCE_AN_DONE);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(priv->regmap, AN8855_SGMII_REG_AN_13,
+					 AN8855_SGMII_REMOTE_FAULT_DIS |
+					 AN8855_SGMII_IF_MODE,
+					 AN8855_SGMII_REMOTE_FAULT_DIS |
+					 FIELD_PREP(AN8855_SGMII_IF_MODE, 0xb));
+		if (ret)
+			return ret;
+	}
+
+	/* Rate Adaption - GMII path config. */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
+		ret = regmap_clear_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0,
+					AN8855_RG_P0_DIS_MII_MODE);
+		if (ret)
+			return ret;
+	} else {
+		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+			ret = regmap_set_bits(priv->regmap, AN8855_MII_RA_AN_ENABLE,
+					      AN8855_RG_P0_RA_AN_EN);
+			if (ret)
+				return ret;
+		} else {
+			ret = regmap_update_bits(priv->regmap, AN8855_RG_AN_SGMII_MODE_FORCE,
+						 AN8855_RG_FORCE_CUR_SGMII_MODE |
+						 AN8855_RG_FORCE_CUR_SGMII_SEL,
+						 AN8855_RG_FORCE_CUR_SGMII_SEL);
+			if (ret)
+				return ret;
+
+			ret = regmap_clear_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0,
+						AN8855_RG_P0_MII_RA_RX_EN |
+						AN8855_RG_P0_MII_RA_TX_EN |
+						AN8855_RG_P0_MII_RA_RX_MODE |
+						AN8855_RG_P0_MII_RA_TX_MODE);
+			if (ret)
+				return ret;
+		}
+
+		ret = regmap_set_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0,
+				      AN8855_RG_P0_MII_MODE);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_set_bits(priv->regmap, AN8855_RG_RATE_ADAPT_CTRL_0,
+			      AN8855_RG_RATE_ADAPT_RX_BYPASS |
+			      AN8855_RG_RATE_ADAPT_TX_BYPASS |
+			      AN8855_RG_RATE_ADAPT_RX_EN |
+			      AN8855_RG_RATE_ADAPT_TX_EN);
+	if (ret)
+		return ret;
+
+	/* Disable AN if not in autoneg */
+	ret = regmap_update_bits(priv->regmap, AN8855_SGMII_REG_AN0, BMCR_ANENABLE,
+				 neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED ? BMCR_ANENABLE :
+									      0);
+	if (ret)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_SGMII) {
+		/* Follow SDK init flow with restarting AN after AN enable */
+		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+			ret = regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN0,
+					      BMCR_ANRESTART);
+			if (ret)
+				return ret;
+		} else {
+			ret = regmap_set_bits(priv->regmap, AN8855_PHY_RX_FORCE_CTRL_0,
+					      AN8855_RG_FORCE_TXC_SEL);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Force Speed with fixed-link or 2500base-x as doesn't support aneg */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX ||
+	    neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
+		if (interface == PHY_INTERFACE_MODE_2500BASEX)
+			val = AN8855_RG_LINK_MODE_P0_SPEED_2500;
+		else
+			val = AN8855_RG_LINK_MODE_P0_SPEED_1000;
+		ret = regmap_update_bits(priv->regmap, AN8855_SGMII_STS_CTRL_0,
+					 AN8855_RG_LINK_MODE_P0 |
+					 AN8855_RG_FORCE_SPD_MODE_P0,
+					 val | AN8855_RG_FORCE_SPD_MODE_P0);
+		if (ret)
+			return ret;
+	}
+
+	/* bypass flow control to MAC */
+	ret = regmap_write(priv->regmap, AN8855_MSG_RX_LIK_STS_0,
+			   AN8855_RG_DPX_STS_P3 | AN8855_RG_DPX_STS_P2 |
+			   AN8855_RG_DPX_STS_P1 | AN8855_RG_TXFC_STS_P0 |
+			   AN8855_RG_RXFC_STS_P0 | AN8855_RG_DPX_STS_P0);
+	if (ret)
+		return ret;
+	ret = regmap_write(priv->regmap, AN8855_MSG_RX_LIK_STS_2,
+			   AN8855_RG_RXFC_AN_BYPASS_P3 |
+			   AN8855_RG_RXFC_AN_BYPASS_P2 |
+			   AN8855_RG_RXFC_AN_BYPASS_P1 |
+			   AN8855_RG_TXFC_AN_BYPASS_P3 |
+			   AN8855_RG_TXFC_AN_BYPASS_P2 |
+			   AN8855_RG_TXFC_AN_BYPASS_P1 |
+			   AN8855_RG_DPX_AN_BYPASS_P3 |
+			   AN8855_RG_DPX_AN_BYPASS_P2 |
+			   AN8855_RG_DPX_AN_BYPASS_P1 |
+			   AN8855_RG_DPX_AN_BYPASS_P0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void an8855_pcs_an_restart(struct phylink_pcs *pcs)
+{
+}
+
+static const struct phylink_pcs_ops an8855_pcs_ops = {
+	.pcs_inband_caps = an8855_pcs_inband_caps,
+	.pcs_get_state = an8855_pcs_get_state,
+	.pcs_config = an8855_pcs_config,
+	.pcs_an_restart = an8855_pcs_an_restart,
+};
+
+static const struct phylink_mac_ops an8855_phylink_mac_ops = {
+	.mac_select_pcs	= an8855_phylink_mac_select_pcs,
+	.mac_config	= an8855_phylink_mac_config,
+	.mac_link_down	= an8855_phylink_mac_link_down,
+	.mac_link_up	= an8855_phylink_mac_link_up,
+	.mac_disable_tx_lpi = an8855_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = an8855_phylink_mac_enable_tx_lpi,
+};
+
+static const struct dsa_switch_ops an8855_switch_ops = {
+	.get_tag_protocol = an8855_get_tag_protocol,
+	.setup = an8855_setup,
+	.phylink_get_caps = an8855_phylink_get_caps,
+	.get_strings = an8855_get_strings,
+	.get_ethtool_stats = an8855_get_ethtool_stats,
+	.get_sset_count = an8855_get_sset_count,
+	.get_eth_mac_stats = an8855_get_eth_mac_stats,
+	.get_eth_ctrl_stats = an8855_get_eth_ctrl_stats,
+	.get_rmon_stats = an8855_get_rmon_stats,
+	.port_enable = an8855_port_enable,
+	.port_disable = an8855_port_disable,
+	.set_ageing_time = an8855_set_ageing_time,
+	.port_bridge_join = an8855_port_bridge_join,
+	.port_bridge_leave = an8855_port_bridge_leave,
+	.port_fast_age = an8855_port_fast_age,
+	.port_stp_state_set = an8855_port_stp_state_set,
+	.port_pre_bridge_flags = an8855_port_pre_bridge_flags,
+	.port_bridge_flags = an8855_port_bridge_flags,
+	.port_vlan_filtering = an8855_port_vlan_filtering,
+	.port_vlan_add = an8855_port_vlan_add,
+	.port_vlan_del = an8855_port_vlan_del,
+	.port_fdb_add = an8855_port_fdb_add,
+	.port_fdb_del = an8855_port_fdb_del,
+	.port_fdb_dump = an8855_port_fdb_dump,
+	.port_mdb_add = an8855_port_mdb_add,
+	.port_mdb_del = an8855_port_mdb_del,
+	.port_change_mtu = an8855_port_change_mtu,
+	.port_max_mtu = an8855_port_max_mtu,
+	.port_mirror_add = an8855_port_mirror_add,
+	.port_mirror_del = an8855_port_mirror_del,
+	.support_eee = dsa_supports_eee,
+	.set_mac_eee = an8855_set_mac_eee,
+};
+
+static int an8855_setup_lib_priv(struct an8855_priv *priv)
+{
+	struct mt7530_lib_priv *lib_priv = &priv->lib_priv;
+	int i;
+
+	lib_priv->dev = priv->ds->dev;
+	lib_priv->ds = priv->ds;
+	lib_priv->regmap = priv->regmap;
+	lib_priv->ports = priv->ports;
+	lib_priv->reg_mutex = &priv->reg_mutex;
+
+	for (i = 0; i < ARRAY_SIZE(an8855_fields); i++) {
+		const struct mt7530_reg_field *reg_field;
+		struct regmap_field *field;
+
+		reg_field = &an8855_fields[i];
+		field = devm_regmap_field_alloc(priv->ds->dev, priv->regmap,
+						reg_field->field);
+		if (IS_ERR(field))
+			return PTR_ERR(field);
+
+		lib_priv->fields[reg_field->id] = field;
+	}
+
+	return 0;
+}
+
+static int an8855_switch_probe(struct platform_device *pdev)
+{
+	struct an8855_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Get regmap from MFD */
+	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!priv->regmap)
+		return -ENOENT;
+
+	priv->ds = devm_kzalloc(&pdev->dev, sizeof(*priv->ds), GFP_KERNEL);
+	if (!priv->ds)
+		return -ENOMEM;
+
+	priv->ds->dev = &pdev->dev;
+	priv->ds->num_ports = AN8855_NUM_PORTS;
+	priv->ds->priv = priv;
+	priv->ds->ops = &an8855_switch_ops;
+	ret = devm_mutex_init(&pdev->dev, &priv->reg_mutex);
+	if (ret)
+		return ret;
+	priv->ds->phylink_mac_ops = &an8855_phylink_mac_ops;
+
+	priv->pcs.ops = &an8855_pcs_ops;
+	priv->pcs.poll = true;
+
+	ret = an8855_setup_lib_priv(priv);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	return dsa_register_switch(priv->ds);
+}
+
+static void an8855_switch_remove(struct platform_device *pdev)
+{
+	struct an8855_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	if (!priv)
+		return;
+
+	dsa_unregister_switch(priv->ds);
+
+	dev_set_drvdata(&pdev->dev, NULL);
+}
+
+static void an8855_switch_shutdown(struct platform_device *pdev)
+{
+	struct an8855_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	if (!priv)
+		return;
+
+	dsa_switch_shutdown(priv->ds);
+
+	dev_set_drvdata(&pdev->dev, NULL);
+}
+
+static const struct of_device_id an8855_switch_of_match[] = {
+	{ .compatible = "airoha,an8855-switch" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an8855_switch_of_match);
+
+static struct platform_driver an8855_switch_driver = {
+	.probe = an8855_switch_probe,
+	.remove = an8855_switch_remove,
+	.shutdown = an8855_switch_shutdown,
+	.driver = {
+		.name = "an8855-switch",
+		.of_match_table = an8855_switch_of_match,
+	},
+};
+module_platform_driver(an8855_switch_driver);
+
+MODULE_AUTHOR("Min Yao <min.yao@airoha.com>");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for Airoha AN8855 Switch");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/mediatek/an8855.h b/drivers/net/dsa/mediatek/an8855.h
new file mode 100644
index 000000000000..85003e568450
--- /dev/null
+++ b/drivers/net/dsa/mediatek/an8855.h
@@ -0,0 +1,755 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Min Yao <min.yao@airoha.com>
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#ifndef __AN8855_H
+#define __AN8855_H
+
+#include <linux/bitfield.h>
+
+#include "mt7530-lib.h"
+
+#define AN8855_NUM_PORTS		6
+#define AN8855_CPU_PORT			5
+#define AN8855_NUM_FDB_RECORDS		2048
+#define AN8855_GPHY_SMI_ADDR_DEFAULT	1
+#define AN8855_PORT_VID_DEFAULT		0
+
+#define MTK_TAG_LEN			4
+#define AN8855_MAX_MTU			(15360 - ETH_HLEN - ETH_FCS_LEN - MTK_TAG_LEN)
+
+#define AN8855_L2_AGING_MS_CONSTANT	1024
+
+#define AN8855_TX_LPI_UNIT		2 /* us */
+
+/*	AN8855_SCU			0x10000000 */
+#define AN8855_RG_GPIO_LED_MODE		0x10000054
+#define AN8855_RG_GPIO_LED_SEL(i)	(0x10000000 + (0x0058 + ((i) * 4)))
+#define AN8855_RG_INTB_MODE		0x10000080
+#define AN8855_RG_RGMII_TXCK_C		0x100001d0
+
+#define AN8855_PKG_SEL			0x10000094
+#define   AN8855_PAG_SEL_AN8855H	0x2
+
+#define AN8855_RG_GPIO_L_INV		0x10000010
+#define AN8855_RG_GPIO_CTRL		0x1000a300
+#define AN8855_RG_GPIO_DATA		0x1000a304
+#define AN8855_RG_GPIO_OE		0x1000a314
+
+/* Register for system reset */
+#define AN8855_RST_CTRL			0x100050c0
+#define   AN8855_SYS_CTRL_SYS_RST	BIT(31)
+
+#define AN8855_INT_MASK			0x100050f0
+#define   AN8855_INT_SYS		BIT(15)
+
+#define AN8855_RG_CLK_CPU_ICG		0x10005034
+#define   AN8855_MCU_ENABLE		BIT(3)
+
+#define AN8855_RG_TIMER_CTL		0x1000a100
+#define   AN8855_WDOG_ENABLE		BIT(25)
+
+#define AN8855_RG_GDMP_RAM		0x10010000
+
+/* Registers to mac forward control for unknown frames */
+#define AN8855_MFC			0x10200010
+#define   AN8855_CPU_EN			BIT(15)
+#define   AN8855_CPU_PORT_IDX		GENMASK(12, 8)
+
+#define AN8855_PAC			0x10200024
+#define   AN8855_TAG_PAE_MANG_FR	BIT(30)
+#define   AN8855_TAG_PAE_BPDU_FR	BIT(28)
+#define   AN8855_TAG_PAE_EG_TAG		GENMASK(27, 25)
+#define   AN8855_TAG_PAE_LKY_VLAN	BIT(24)
+#define   AN8855_TAG_PAE_PRI_HIGH	BIT(23)
+#define   AN8855_TAG_PAE_MIR		GENMASK(20, 19)
+#define   AN8855_TAG_PAE_PORT_FW	GENMASK(18, 16)
+#define   AN8855_PAE_MANG_FR		BIT(14)
+#define   AN8855_PAE_BPDU_FR		BIT(12)
+#define   AN8855_PAE_EG_TAG		GENMASK(11, 9)
+#define   AN8855_PAE_LKY_VLAN		BIT(8)
+#define   AN8855_PAE_PRI_HIGH		BIT(7)
+#define   AN8855_PAE_MIR		GENMASK(4, 3)
+#define   AN8855_PAE_PORT_FW		GENMASK(2, 0)
+
+#define AN8855_RGAC1			0x10200028
+#define   AN8855_R02_MANG_FR		BIT(30)
+#define   AN8855_R02_BPDU_FR		BIT(28)
+#define   AN8855_R02_EG_TAG		GENMASK(27, 25)
+#define   AN8855_R02_LKY_VLAN		BIT(24)
+#define   AN8855_R02_PRI_HIGH		BIT(23)
+#define   AN8855_R02_MIR		GENMASK(20, 19)
+#define   AN8855_R02_PORT_FW		GENMASK(18, 16)
+#define   AN8855_R01_MANG_FR		BIT(14)
+#define   AN8855_R01_BPDU_FR		BIT(12)
+#define   AN8855_R01_EG_TAG		GENMASK(11, 9)
+#define   AN8855_R01_LKY_VLAN		BIT(8)
+#define   AN8855_R01_PRI_HIGH		BIT(7)
+#define   AN8855_R01_MIR		GENMASK(4, 3)
+#define   AN8855_R01_PORT_FW		GENMASK(2, 0)
+
+#define AN8855_RGAC2			0x1020002c
+#define   AN8855_R0E_MANG_FR		BIT(30)
+#define   AN8855_R0E_BPDU_FR		BIT(28)
+#define   AN8855_R0E_EG_TAG		GENMASK(27, 25)
+#define   AN8855_R0E_LKY_VLAN		BIT(24)
+#define   AN8855_R0E_PRI_HIGH		BIT(23)
+#define   AN8855_R0E_MIR		GENMASK(20, 19)
+#define   AN8855_R0E_PORT_FW		GENMASK(18, 16)
+#define   AN8855_R03_MANG_FR		BIT(14)
+#define   AN8855_R03_BPDU_FR		BIT(12)
+#define   AN8855_R03_EG_TAG		GENMASK(11, 9)
+#define   AN8855_R03_LKY_VLAN		BIT(8)
+#define   AN8855_R03_PRI_HIGH		BIT(7)
+#define   AN8855_R03_MIR		GENMASK(4, 3)
+#define   AN8855_R03_PORT_FW		GENMASK(2, 0)
+
+#define AN8855_AAC			0x102000a0
+#define   AN8855_MAC_AUTO_FLUSH		BIT(28)
+/* Control Address Table Age time.
+ * (AN8855_AGE_CNT + 1) * ( AN8855_AGE_UNIT + 1 ) * AN8855_L2_AGING_MS_CONSTANT
+ */
+#define   AN8855_AGE_CNT		GENMASK(20, 12)
+/* Value in seconds. Value is always incremented of 1 */
+#define   AN8855_AGE_UNIT		GENMASK(10, 0)
+
+/* Registers for ARL Unknown Unicast Forward control */
+#define AN8855_UNUF			0x102000b4
+
+/* Registers for ARL Unknown Multicast Forward control */
+#define AN8855_UNMF			0x102000b8
+
+/* Registers for ARL Broadcast forward control */
+#define AN8855_BCF			0x102000bc
+
+/* Registers for port address age disable */
+#define AN8855_AGDIS			0x102000c0
+
+/* Registers for mirror port control */
+#define AN8855_MIR			0x102000cc
+#define   AN8855_MIRROR_EN		BIT(7)
+#define   AN8855_MIRROR_PORT		GENMASK(4, 0)
+
+/* Registers for BPDU and PAE frame control*/
+#define AN8855_BPC			0x102000d0
+#define   AN8855_BPDU_MANG_FR		BIT(14)
+#define   AN8855_BPDU_BPDU_FR		BIT(12)
+#define   AN8855_BPDU_EG_TAG		GENMASK(11, 9)
+#define   AN8855_BPDU_LKY_VLAN		BIT(8)
+#define   AN8855_BPDU_PRI_HIGH		BIT(7)
+#define   AN8855_BPDU_MIR		GENMASK(4, 3)
+#define   AN8855_BPDU_PORT_FW		GENMASK(2, 0)
+
+/* Registers for IP Unknown Multicast Forward control */
+#define AN8855_UNIPMF			0x102000dc
+
+enum an8855_bpdu_port_fw {
+	AN8855_BPDU_FOLLOW_MFC = 0,
+	AN8855_BPDU_CPU_EXCLUDE = 4,
+	AN8855_BPDU_CPU_INCLUDE = 5,
+	AN8855_BPDU_CPU_ONLY = 6,
+	AN8855_BPDU_DROP = 7,
+};
+
+/* Register for address table control */
+#define AN8855_ATC			0x10200300
+#define   AN8855_ATC_BUSY		BIT(31)
+#define   AN8855_ATC_HASH		GENMASK(24, 16)
+#define   AN8855_ATC_HIT		GENMASK(15, 12)
+#define   AN8855_ATC_MAT_MASK		GENMASK(11, 7)
+#define   AN8855_ATC_MAT(x)		FIELD_PREP(AN8855_ATC_MAT_MASK, x)
+#define   AN8855_ATC_SAT		GENMASK(5, 4)
+#define   AN8855_ATC_CMD		GENMASK(2, 0)
+
+enum an8855_fdb_mat_cmds {
+	AN8855_FDB_MAT_ALL = 0,
+	AN8855_FDB_MAT_MAC, /* All MAC address */
+	AN8855_FDB_MAT_DYNAMIC_MAC, /* All Dynamic MAC address */
+	AN8855_FDB_MAT_STATIC_MAC, /* All Static Mac Address */
+	AN8855_FDB_MAT_DIP, /* All DIP/GA address */
+	AN8855_FDB_MAT_DIP_IPV4, /* All DIP/GA IPv4 address */
+	AN8855_FDB_MAT_DIP_IPV6, /* All DIP/GA IPv6 address */
+	AN8855_FDB_MAT_DIP_SIP, /* All DIP_SIP address */
+	AN8855_FDB_MAT_DIP_SIP_IPV4, /* All DIP_SIP IPv4 address */
+	AN8855_FDB_MAT_DIP_SIP_IPV6, /* All DIP_SIP IPv6 address */
+	AN8855_FDB_MAT_MAC_CVID, /* All MAC address with CVID */
+	AN8855_FDB_MAT_MAC_FID, /* All MAC address with Filter ID */
+	AN8855_FDB_MAT_MAC_PORT, /* All MAC address with port */
+	AN8855_FDB_MAT_DIP_SIP_DIP_IPV4, /* All DIP_SIP address with DIP_IPV4 */
+	AN8855_FDB_MAT_DIP_SIP_SIP_IPV4, /* All DIP_SIP address with SIP_IPV4 */
+	AN8855_FDB_MAT_DIP_SIP_DIP_IPV6, /* All DIP_SIP address with DIP_IPV6 */
+	AN8855_FDB_MAT_DIP_SIP_SIP_IPV6, /* All DIP_SIP address with SIP_IPV6 */
+	/* All MAC address with MAC type (dynamic or static) with CVID */
+	AN8855_FDB_MAT_MAC_TYPE_CVID,
+	/* All MAC address with MAC type (dynamic or static) with Filter ID */
+	AN8855_FDB_MAT_MAC_TYPE_FID,
+	/* All MAC address with MAC type (dynamic or static) with port */
+	AN8855_FDB_MAT_MAC_TYPE_PORT,
+};
+
+/* Registers for address table access */
+#define AN8855_ATA1			0x10200304
+#define   AN8855_ATA1_MAC0		GENMASK(31, 24)
+#define   AN8855_ATA1_MAC1		GENMASK(23, 16)
+#define   AN8855_ATA1_MAC2		GENMASK(15, 8)
+#define   AN8855_ATA1_MAC3		GENMASK(7, 0)
+#define AN8855_ATA2			0x10200308
+#define   AN8855_ATA2_MAC4		GENMASK(31, 24)
+#define   AN8855_ATA2_MAC5		GENMASK(23, 16)
+#define   AN8855_ATA2_UNAUTH		BIT(10)
+#define   AN8855_ATA2_TYPE		BIT(9) /* 1: dynamic, 0: static */
+#define   AN8855_ATA2_AGE		GENMASK(8, 0)
+
+/* Register for address table write data */
+#define AN8855_ATWD			0x10200324
+#define   AN8855_ATWD_FID		GENMASK(31, 28)
+#define   AN8855_ATWD_VID		GENMASK(27, 16)
+#define   AN8855_ATWD_IVL		BIT(15)
+#define   AN8855_ATWD_EG_TAG		GENMASK(14, 12)
+#define   AN8855_ATWD_SA_MIR		GENMASK(9, 8)
+#define   AN8855_ATWD_SA_FWD		GENMASK(7, 5)
+#define   AN8855_ATWD_UPRI		GENMASK(4, 2)
+#define   AN8855_ATWD_LEAKY		BIT(1)
+#define   AN8855_ATWD_VLD_MASK		BIT(0) /* vid LOAD */
+#define AN8855_ATWD2			0x10200328
+#define   AN8855_ATWD2_PORT		GENMASK(7, 0)
+
+/* Registers for table search read address */
+#define AN8855_ATRDS			0x10200330
+#define   AN8855_ATRD_SEL		GENMASK(1, 0)
+#define AN8855_ATRD0			0x10200334
+#define   AN8855_ATRD0_FID		GENMASK(28, 25)
+#define   AN8855_ATRD0_VID		GENMASK(21, 10)
+#define   AN8855_ATRD0_IVL		BIT(9)
+#define   AN8855_ATRD0_TYPE		GENMASK(4, 3)
+#define   AN8855_ATRD0_ARP		GENMASK(2, 1)
+#define   AN8855_ATRD0_LIVE		BIT(0)
+#define AN8855_ATRD1			0x10200338
+#define   AN8855_ATRD1_MAC4		GENMASK(31, 24)
+#define   AN8855_ATRD1_MAC5		GENMASK(23, 16)
+#define   AN8855_ATRD1_AGING		GENMASK(11, 3)
+#define AN8855_ATRD2			0x1020033c
+#define   AN8855_ATRD2_MAC0		GENMASK(31, 24)
+#define   AN8855_ATRD2_MAC1		GENMASK(23, 16)
+#define   AN8855_ATRD2_MAC2		GENMASK(15, 8)
+#define   AN8855_ATRD2_MAC3		GENMASK(7, 0)
+#define AN8855_ATRD3			0x10200340
+#define   AN8855_ATRD3_PORTMASK		GENMASK(7, 0)
+
+enum an8855_fdb_type {
+	AN8855_MAC_TB_TY_MAC = 0,
+	AN8855_MAC_TB_TY_DIP = 1,
+	AN8855_MAC_TB_TY_DIP_SIP = 2,
+};
+
+/* Register for vlan table control */
+#define AN8855_VTCR			0x10200600
+#define   AN8855_VTCR_BUSY		BIT(31)
+#define   AN8855_VTCR_FUNC		GENMASK(15, 12)
+#define   AN8855_VTCR_VID		GENMASK(11, 0)
+
+enum an8855_vlan_cmd {
+	/* Read/Write the specified VID entry from VAWD register based
+	 * on VID.
+	 */
+	AN8855_VTCR_RD_VID = 0,
+	AN8855_VTCR_WR_VID = 1,
+};
+
+/* Register for setup vlan write data */
+#define AN8855_VAWD0			0x10200604
+/* VLAN Member Control */
+#define   AN8855_VA0_PORT		GENMASK(31, 26)
+/* Egress Tag Control */
+#define   AN8855_VA0_ETAG		GENMASK(23, 12)
+#define   AN8855_VA0_ETAG_PORT		GENMASK(13, 12)
+#define   AN8855_VA0_ETAG_PORT_SHIFT(port) ((port) * 2)
+#define   AN8855_VA0_ETAG_PORT_MASK(port) (AN8855_VA0_ETAG_PORT << \
+						AN8855_VA0_ETAG_PORT_SHIFT(port))
+#define   AN8855_VA0_ETAG_PORT_VAL(port, val) (FIELD_PREP(AN8855_VA0_ETAG_PORT, (val)) << \
+						AN8855_VA0_ETAG_PORT_SHIFT(port))
+#define   AN8855_VA0_EG_CON		BIT(11)
+#define   AN8855_VA0_VTAG_EN		BIT(10) /* Per VLAN Egress Tag Control */
+#define   AN8855_VA0_IVL_MAC		BIT(5) /* Independent VLAN Learning */
+#define	  AN8855_VA0_FID		GENMASK(4, 1)
+#define   AN8855_VA0_VLAN_VALID		BIT(0) /* VLAN Entry Valid */
+#define AN8855_VAWD1			0x10200608
+#define   AN8855_VA1_PORT_STAG		BIT(1)
+
+enum an8855_fid {
+	AN8855_FID_STANDALONE = 0,
+	AN8855_FID_BRIDGED = 1,
+};
+
+/* Same register field of VAWD0 */
+#define AN8855_VARD0			0x10200618
+
+enum an8855_vlan_egress_attr {
+	AN8855_VLAN_EGRESS_UNTAG = 0,
+	AN8855_VLAN_EGRESS_TAG = 2,
+	AN8855_VLAN_EGRESS_STACK = 3,
+};
+
+/* Register for port STP state control */
+#define AN8855_SSP			0x10208000
+#define AN8855_SSP_P(x)			(AN8855_SSP + ((x) * 0x200))
+/* Up to 16 FID supported, each with the same mask */
+#define	  AN8855_FID_PST		GENMASK(1, 0)
+#define   AN8855_FID_PST_SHIFT(fid)	(2 * (fid))
+#define   AN8855_FID_PST_MASK(fid)	(AN8855_FID_PST << \
+						AN8855_FID_PST_SHIFT(fid))
+#define   AN8855_FID_PST_VAL(fid, val)	(FIELD_PREP(AN8855_FID_PST, (val)) << \
+						AN8855_FID_PST_SHIFT(fid))
+
+enum an8855_stp_state {
+	AN8855_STP_DISABLED = 0,
+	AN8855_STP_BLOCKING = 1,
+	AN8855_STP_LISTENING = AN8855_STP_BLOCKING,
+	AN8855_STP_LEARNING = 2,
+	AN8855_STP_FORWARDING = 3
+};
+
+/* Register for port control */
+#define AN8855_PCR			0x10208004
+#define AN8855_PCR_P(x)			(AN8855_PCR + ((x) * 0x200))
+#define   AN8855_EG_TAG			GENMASK(29, 28)
+#define   AN8855_PORT_PRI		GENMASK(26, 24)
+#define   AN8855_PORT_TX_MIR		BIT(20)
+#define   AN8855_PORT_RX_MIR		BIT(16)
+#define   AN8855_PORT_VLAN		GENMASK(1, 0)
+
+enum an8855_port_mode {
+	/* Port Matrix Mode: Frames are forwarded by the PCR_MATRIX members. */
+	AN8855_PORT_MATRIX_MODE = 0,
+
+	/* Fallback Mode: Forward received frames with ingress ports that do
+	 * not belong to the VLAN member. Frames whose VID is not listed on
+	 * the VLAN table are forwarded by the PCR_MATRIX members.
+	 */
+	AN8855_PORT_FALLBACK_MODE = 1,
+
+	/* Check Mode: Forward received frames whose ingress do not
+	 * belong to the VLAN member. Discard frames if VID ismiddes on the
+	 * VLAN table.
+	 */
+	AN8855_PORT_CHECK_MODE = 2,
+
+	/* Security Mode: Discard any frame due to ingress membership
+	 * violation or VID missed on the VLAN table.
+	 */
+	AN8855_PORT_SECURITY_MODE = 3,
+};
+
+/* Register for port security control */
+#define AN8855_PSC			0x1020800c
+#define AN8855_PSC_P(x)			(AN8855_PSC + ((x) * 0x200))
+#define   AN8855_SA_DIS			BIT(4)
+
+/* Register for port vlan control */
+#define AN8855_PVC			0x10208010
+#define AN8855_PVC_P(x)			(AN8855_PVC + ((x) * 0x200))
+#define   AN8855_PORT_SPEC_REPLACE_MODE	BIT(11)
+#define   AN8855_PVC_EG_TAG		GENMASK(10, 8)
+#define   AN8855_VLAN_ATTR		GENMASK(7, 6)
+#define   AN8855_PORT_SPEC_TAG		BIT(5)
+#define   AN8855_ACC_FRM		GENMASK(1, 0)
+
+enum an8855_vlan_port_eg_tag {
+	AN8855_VLAN_EG_DISABLED = 0,
+	AN8855_VLAN_EG_CONSISTENT = 1,
+	AN8855_VLAN_EG_UNTAGGED = 4,
+	AN8855_VLAN_EG_SWAP = 5,
+	AN8855_VLAN_EG_TAGGED = 6,
+	AN8855_VLAN_EG_STACK = 7,
+};
+
+enum an8855_vlan_port_attr {
+	AN8855_VLAN_USER = 0,
+	AN8855_VLAN_STACK = 1,
+	AN8855_VLAN_TRANSPARENT = 3,
+};
+
+enum an8855_vlan_port_acc_frm {
+	AN8855_VLAN_ACC_ALL = 0,
+	AN8855_VLAN_ACC_TAGGED = 1,
+	AN8855_VLAN_ACC_UNTAGGED = 2,
+};
+
+#define AN8855_PPBV1			0x10208014
+#define AN8855_PPBV1_P(x)		(AN8855_PPBV1 + ((x) * 0x200))
+#define   AN8855_PPBV_G0_PORT_VID	GENMASK(11, 0)
+
+#define AN8855_PORTMATRIX		0x10208044
+#define AN8855_PORTMATRIX_P(x)		(AN8855_PORTMATRIX + ((x) * 0x200))
+#define   AN8855_PORTMATRIX_MASK	GENMASK(5, 0)
+/* Port matrix without the CPU port that should never be removed */
+#define   AN8855_USER_PORTMATRIX	GENMASK(4, 0)
+
+/* Register for port PVID */
+#define AN8855_PVID			0x10208048
+#define AN8855_PVID_P(x)		(AN8855_PVID + ((x) * 0x200))
+#define   AN8855_G0_PORT_VID		GENMASK(11, 0)
+
+/* Register for port MAC control register */
+#define AN8855_PMCR_P(x)		(0x10210000 + ((x) * 0x200))
+#define   AN8855_PMCR_FORCE_MODE	BIT(31)
+#define   AN8855_PMCR_FORCE_SPEED	GENMASK(30, 28)
+#define   AN8855_PMCR_FORCE_SPEED_5000	FIELD_PREP_CONST(AN8855_PMCR_FORCE_SPEED, 0x4)
+#define   AN8855_PMCR_FORCE_SPEED_2500	FIELD_PREP_CONST(AN8855_PMCR_FORCE_SPEED, 0x3)
+#define   AN8855_PMCR_FORCE_SPEED_1000	FIELD_PREP_CONST(AN8855_PMCR_FORCE_SPEED, 0x2)
+#define   AN8855_PMCR_FORCE_SPEED_100	FIELD_PREP_CONST(AN8855_PMCR_FORCE_SPEED, 0x1)
+#define   AN8855_PMCR_FORCE_SPEED_10	FIELD_PREP_CONST(AN8855_PMCR_FORCE_SPEED, 0x0)
+#define   AN8855_PMCR_FORCE_FDX		BIT(25)
+#define   AN8855_PMCR_FORCE_LNK		BIT(24)
+#define   AN8855_PMCR_IFG_XMIT		GENMASK(21, 20)
+#define   AN8855_PMCR_EXT_PHY		BIT(19)
+#define   AN8855_PMCR_MAC_MODE		BIT(18)
+#define   AN8855_PMCR_TX_EN		BIT(16)
+#define   AN8855_PMCR_RX_EN		BIT(15)
+#define   AN8855_PMCR_BACKOFF_EN	BIT(12)
+#define   AN8855_PMCR_BACKPR_EN		BIT(11)
+#define   AN8855_PMCR_FORCE_EEE5G	BIT(9)
+#define   AN8855_PMCR_FORCE_EEE2P5G	BIT(8)
+#define   AN8855_PMCR_FORCE_EEE1G	BIT(7)
+#define   AN8855_PMCR_FORCE_EEE100	BIT(6)
+#define   AN8855_PMCR_RX_FC_EN		BIT(5)
+#define   AN8855_PMCR_TX_FC_EN		BIT(4)
+
+#define AN8855_PMSR_P(x)		(0x10210010 + (x) * 0x200)
+#define   AN8855_PMSR_SPEED		GENMASK(30, 28)
+#define   AN8855_PMSR_SPEED_5000	FIELD_PREP_CONST(AN8855_PMSR_SPEED, 0x4)
+#define   AN8855_PMSR_SPEED_2500	FIELD_PREP_CONST(AN8855_PMSR_SPEED, 0x3)
+#define   AN8855_PMSR_SPEED_1000	FIELD_PREP_CONST(AN8855_PMSR_SPEED, 0x2)
+#define   AN8855_PMSR_SPEED_100		FIELD_PREP_CONST(AN8855_PMSR_SPEED, 0x1)
+#define   AN8855_PMSR_SPEED_10		FIELD_PREP_CONST(AN8855_PMSR_SPEED, 0x0)
+#define   AN8855_PMSR_DPX		BIT(25)
+#define   AN8855_PMSR_LNK		BIT(24)
+#define   AN8855_PMSR_EEE1G		BIT(7)
+#define   AN8855_PMSR_EEE100M		BIT(6)
+#define   AN8855_PMSR_RX_FC		BIT(5)
+#define   AN8855_PMSR_TX_FC		BIT(4)
+
+#define AN8855_PMEEECR_P(x)		(0x10210004 + (x) * 0x200)
+#define   AN8855_LPI_MODE_EN		BIT(31)
+#define   AN8855_WAKEUP_TIME_2500	GENMASK(23, 16)
+#define   AN8855_WAKEUP_TIME_1000	GENMASK(15, 8)
+#define   AN8855_WAKEUP_TIME_100	GENMASK(7, 0)
+#define AN8855_PMEEECR2_P(x)		(0x10210008 + (x) * 0x200)
+#define   AN8855_WAKEUP_TIME_5000	GENMASK(7, 0)
+
+#define AN8855_GMACCR			0x10213e00
+#define   AN8855_MAX_RX_JUMBO		GENMASK(7, 4)
+/* 2K for 0x0, 0x1, 0x2 */
+#define   AN8855_MAX_RX_JUMBO_2K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x0)
+#define   AN8855_MAX_RX_JUMBO_3K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x3)
+#define   AN8855_MAX_RX_JUMBO_4K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x4)
+#define   AN8855_MAX_RX_JUMBO_5K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x5)
+#define   AN8855_MAX_RX_JUMBO_6K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x6)
+#define   AN8855_MAX_RX_JUMBO_7K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x7)
+#define   AN8855_MAX_RX_JUMBO_8K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x8)
+#define   AN8855_MAX_RX_JUMBO_9K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x9)
+#define   AN8855_MAX_RX_JUMBO_12K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xa)
+#define   AN8855_MAX_RX_JUMBO_15K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xb)
+#define   AN8855_MAX_RX_JUMBO_16K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xc)
+#define   AN8855_MAX_RX_PKT_LEN		GENMASK(1, 0)
+#define   AN8855_MAX_RX_PKT_1518_1522	FIELD_PREP_CONST(AN8855_MAX_RX_PKT_LEN, 0x0)
+#define   AN8855_MAX_RX_PKT_1536	FIELD_PREP_CONST(AN8855_MAX_RX_PKT_LEN, 0x1)
+#define   AN8855_MAX_RX_PKT_1552	FIELD_PREP_CONST(AN8855_MAX_RX_PKT_LEN, 0x2)
+#define   AN8855_MAX_RX_PKT_JUMBO	FIELD_PREP_CONST(AN8855_MAX_RX_PKT_LEN, 0x3)
+
+#define AN8855_CKGCR			0x10213e1c
+#define   AN8855_LPI_TXIDLE_THD_MASK	GENMASK(31, 14)
+#define   AN8855_CKG_LNKDN_PORT_STOP	BIT(1)
+#define   AN8855_CKG_LNKDN_GLB_STOP	BIT(0)
+
+/* Register for MIB */
+#define AN8855_MIB_COUNTER		0x10214000
+#define AN8855_PORT_MIB_COUNTER(x)	(AN8855_MIB_COUNTER + (x) * 0x200)
+/* Each define is an offset of AN8855_PORT_MIB_COUNTER */
+#define   AN8855_PORT_MIB_TX_DROP	(AN8855_MIB_COUNTER + 0x00)
+#define   AN8855_PORT_MIB_TX_CRC_ERR	(AN8855_MIB_COUNTER + 0x04)
+#define   AN8855_PORT_MIB_TX_UNICAST	(AN8855_MIB_COUNTER + 0x08)
+#define   AN8855_PORT_MIB_TX_MULTICAST	(AN8855_MIB_COUNTER + 0x0c)
+#define   AN8855_PORT_MIB_TX_BROADCAST	(AN8855_MIB_COUNTER + 0x10)
+#define   AN8855_PORT_MIB_TX_COLLISION	(AN8855_MIB_COUNTER + 0x14)
+#define   AN8855_PORT_MIB_TX_SINGLE_COLLISION (AN8855_MIB_COUNTER + 0x18)
+#define   AN8855_PORT_MIB_TX_MULTIPLE_COLLISION (AN8855_MIB_COUNTER + 0x1c)
+#define   AN8855_PORT_MIB_TX_DEFERRED	(AN8855_MIB_COUNTER + 0x20)
+#define   AN8855_PORT_MIB_TX_LATE_COLLISION (AN8855_MIB_COUNTER + 0x24)
+#define   AN8855_PORT_MIB_TX_EXCESSIVE_COLLISION (AN8855_MIB_COUNTER + 0x28)
+#define   AN8855_PORT_MIB_TX_PAUSE	(AN8855_MIB_COUNTER + 0x2c)
+#define   AN8855_PORT_MIB_TX_PKT_SZ_64	(AN8855_MIB_COUNTER + 0x30)
+#define   AN8855_PORT_MIB_TX_PKT_SZ_65_TO_127 (AN8855_MIB_COUNTER + 0x34)
+#define   AN8855_PORT_MIB_TX_PKT_SZ_128_TO_255 (AN8855_MIB_COUNTER + 0x38)
+#define   AN8855_PORT_MIB_TX_PKT_SZ_256_TO_511 (AN8855_MIB_COUNTER + 0x3c)
+#define   AN8855_PORT_MIB_TX_PKT_SZ_512_TO_1023 (AN8855_MIB_COUNTER + 0x40)
+#define   AN8855_PORT_MIB_TX_PKT_SZ_1024_TO_1518 (AN8855_MIB_COUNTER + 0x44)
+#define   AN8855_PORT_MIB_TX_PKT_SZ_1519_TO_MAX (AN8855_MIB_COUNTER + 0x48)
+#define   AN8855_PORT_MIB_TX_BYTES_LOW	(AN8855_MIB_COUNTER + 0x4c) /* 64 bytes */
+#define   AN8855_PORT_MIB_TX_BYTES_HIGH	(AN8855_MIB_COUNTER + 0x50)
+#define   AN8855_PORT_MIB_TX_OVERSIZE_DROP (AN8855_MIB_COUNTER + 0x54)
+#define   AN8855_PORT_MIB_TX_BAD_PKT_BYTES_LOW (AN8855_MIB_COUNTER + 0x58) /* 64 bytes */
+#define   AN8855_PORT_MIB_TX_BAD_PKT_BYTES_HIGH (AN8855_MIB_COUNTER + 0x5c)
+#define   AN8855_PORT_MIB_RX_DROP	(AN8855_MIB_COUNTER + 0x80)
+#define   AN8855_PORT_MIB_RX_FILTERING	(AN8855_MIB_COUNTER + 0x84)
+#define   AN8855_PORT_MIB_RX_UNICAST	(AN8855_MIB_COUNTER + 0x88)
+#define   AN8855_PORT_MIB_RX_MULTICAST	(AN8855_MIB_COUNTER + 0x8c)
+#define   AN8855_PORT_MIB_RX_BROADCAST	(AN8855_MIB_COUNTER + 0x90)
+#define   AN8855_PORT_MIB_RX_ALIGN_ERR	(AN8855_MIB_COUNTER + 0x94)
+#define   AN8855_PORT_MIB_RX_CRC_ERR	(AN8855_MIB_COUNTER + 0x98)
+#define   AN8855_PORT_MIB_RX_UNDER_SIZE_ERR (AN8855_MIB_COUNTER + 0x9c)
+#define   AN8855_PORT_MIB_RX_FRAG_ERR	(AN8855_MIB_COUNTER + 0xa0)
+#define   AN8855_PORT_MIB_RX_OVER_SZ_ERR (AN8855_MIB_COUNTER + 0xa4)
+#define   AN8855_PORT_MIB_RX_JABBER_ERR	(AN8855_MIB_COUNTER + 0xa8)
+#define   AN8855_PORT_MIB_RX_PAUSE	(AN8855_MIB_COUNTER + 0xac)
+#define   AN8855_PORT_MIB_RX_PKT_SZ_64	(AN8855_MIB_COUNTER + 0xb0)
+#define   AN8855_PORT_MIB_RX_PKT_SZ_65_TO_127 (AN8855_MIB_COUNTER + 0xb4)
+#define   AN8855_PORT_MIB_RX_PKT_SZ_128_TO_255 (AN8855_MIB_COUNTER + 0xb8)
+#define   AN8855_PORT_MIB_RX_PKT_SZ_256_TO_511 (AN8855_MIB_COUNTER + 0xbc)
+#define   AN8855_PORT_MIB_RX_PKT_SZ_512_TO_1023 (AN8855_MIB_COUNTER + 0xc0)
+#define   AN8855_PORT_MIB_RX_PKT_SZ_1024_TO_1518 (AN8855_MIB_COUNTER + 0xc4)
+#define   AN8855_PORT_MIB_RX_PKT_SZ_1519_TO_MAX (AN8855_MIB_COUNTER + 0xc8)
+#define   AN8855_PORT_MIB_RX_BYTES_LOW	(AN8855_MIB_COUNTER + 0xcc) /* 64 bytes */
+#define   AN8855_PORT_MIB_RX_BYTES_HIGH	(AN8855_MIB_COUNTER + 0xd0)
+#define   AN8855_PORT_MIB_RX_CTRL_DROP	(AN8855_MIB_COUNTER + 0xd4)
+#define   AN8855_PORT_MIB_RX_INGRESS_DROP (AN8855_MIB_COUNTER + 0xd8)
+#define   AN8855_PORT_MIB_RX_ARL_DROP	(AN8855_MIB_COUNTER + 0xdc)
+#define   AN8855_PORT_MIB_FLOW_CONTROL_DROP (AN8855_MIB_COUNTER + 0xe0)
+#define   AN8855_PORT_MIB_WRED_DROP	(AN8855_MIB_COUNTER + 0xe4)
+#define   AN8855_PORT_MIB_MIRROR_DROP	(AN8855_MIB_COUNTER + 0xe8)
+#define   AN8855_PORT_MIB_RX_BAD_PKT_BYTES_LOW (AN8855_MIB_COUNTER + 0xec) /* 64 bytes */
+#define   AN8855_PORT_MIB_RX_BAD_PKT_BYTES_HIGH (AN8855_MIB_COUNTER + 0xf0)
+#define   AN8855_PORT_MIB_RXS_FLOW_SAMPLING_PKT_DROP (AN8855_MIB_COUNTER + 0xf4)
+#define   AN8855_PORT_MIB_RXS_FLOW_TOTAL_PKT_DROP (AN8855_MIB_COUNTER + 0xf8)
+#define   AN8855_PORT_MIB_PORT_CONTROL_DROP (AN8855_MIB_COUNTER + 0xfc)
+#define AN8855_MIB_CCR			0x10213e30
+#define   AN8855_CCR_MIB_ENABLE		BIT(31)
+#define   AN8855_CCR_RX_OCT_CNT_GOOD	BIT(7)
+#define   AN8855_CCR_RX_OCT_CNT_BAD	BIT(6)
+#define   AN8855_CCR_TX_OCT_CNT_GOOD	BIT(5)
+#define   AN8855_CCR_TX_OCT_CNT_BAD	BIT(4)
+#define   AN8855_CCR_RX_OCT_CNT_GOOD_2	BIT(3)
+#define   AN8855_CCR_RX_OCT_CNT_BAD_2	BIT(2)
+#define   AN8855_CCR_TX_OCT_CNT_GOOD_2	BIT(1)
+#define   AN8855_CCR_TX_OCT_CNT_BAD_2	BIT(0)
+#define   AN8855_CCR_MIB_ACTIVATE	(AN8855_CCR_MIB_ENABLE | \
+					 AN8855_CCR_RX_OCT_CNT_GOOD | \
+					 AN8855_CCR_RX_OCT_CNT_BAD | \
+					 AN8855_CCR_TX_OCT_CNT_GOOD | \
+					 AN8855_CCR_TX_OCT_CNT_BAD | \
+					 AN8855_CCR_RX_OCT_CNT_BAD_2 | \
+					 AN8855_CCR_TX_OCT_CNT_BAD_2)
+#define AN8855_MIB_CLR			0x10213e34
+#define   AN8855_MIB_PORT6_CLR		BIT(6)
+#define   AN8855_MIB_PORT5_CLR		BIT(5)
+#define   AN8855_MIB_PORT4_CLR		BIT(4)
+#define   AN8855_MIB_PORT3_CLR		BIT(3)
+#define   AN8855_MIB_PORT2_CLR		BIT(2)
+#define   AN8855_MIB_PORT1_CLR		BIT(1)
+#define   AN8855_MIB_PORT0_CLR		BIT(0)
+
+/* HSGMII/SGMII Configuration register */
+/*	AN8855_HSGMII_AN_CSR_BASE	0x10220000 */
+#define AN8855_SGMII_REG_AN0		0x10220000
+/*        AN8855_SGMII_AN_ENABLE	BMCR_ANENABLE */
+/*        AN8855_SGMII_AN_RESTART	BMCR_ANRESTART */
+#define AN8855_SGMII_REG_AN_13		0x10220034
+#define   AN8855_SGMII_REMOTE_FAULT_DIS	BIT(8)
+#define   AN8855_SGMII_IF_MODE		GENMASK(5, 0)
+#define AN8855_SGMII_REG_AN_FORCE_CL37	0x10220060
+#define   AN8855_RG_FORCE_AN_DONE	BIT(0)
+
+/*	AN8855_HSGMII_CSR_PCS_BASE	0x10220000 */
+#define AN8855_RG_HSGMII_PCS_CTROL_1	0x10220a00
+#define   AN8855_RG_TBI_10B_MODE	BIT(30)
+#define AN8855_RG_AN_SGMII_MODE_FORCE	0x10220a24
+#define   AN8855_RG_FORCE_CUR_SGMII_MODE GENMASK(5, 4)
+#define   AN8855_RG_FORCE_CUR_SGMII_SEL	BIT(0)
+
+/*	AN8855_MULTI_SGMII_CSR_BASE	0x10224000 */
+#define AN8855_SGMII_STS_CTRL_0		0x10224018
+#define   AN8855_RG_LINK_MODE_P0	GENMASK(5, 4)
+#define   AN8855_RG_LINK_MODE_P0_SPEED_2500 FIELD_PREP_CONST(AN8855_RG_LINK_MODE_P0, 0x3)
+#define   AN8855_RG_LINK_MODE_P0_SPEED_1000 FIELD_PREP_CONST(AN8855_RG_LINK_MODE_P0, 0x2)
+#define   AN8855_RG_LINK_MODE_P0_SPEED_100 FIELD_PREP_CONST(AN8855_RG_LINK_MODE_P0, 0x1)
+#define   AN8855_RG_LINK_MODE_P0_SPEED_10 FIELD_PREP_CONST(AN8855_RG_LINK_MODE_P0, 0x0)
+#define   AN8855_RG_FORCE_SPD_MODE_P0	BIT(2)
+#define AN8855_MSG_RX_CTRL_0		0x10224100
+#define AN8855_MSG_RX_LIK_STS_0		0x10224514
+#define   AN8855_RG_DPX_STS_P3		BIT(24)
+#define   AN8855_RG_DPX_STS_P2		BIT(16)
+#define   AN8855_RG_EEE1G_STS_P1	BIT(12)
+#define   AN8855_RG_DPX_STS_P1		BIT(8)
+#define   AN8855_RG_TXFC_STS_P0		BIT(2)
+#define   AN8855_RG_RXFC_STS_P0		BIT(1)
+#define   AN8855_RG_DPX_STS_P0		BIT(0)
+#define AN8855_MSG_RX_LIK_STS_2		0x1022451c
+#define   AN8855_RG_RXFC_AN_BYPASS_P3	BIT(11)
+#define   AN8855_RG_RXFC_AN_BYPASS_P2	BIT(10)
+#define   AN8855_RG_RXFC_AN_BYPASS_P1	BIT(9)
+#define   AN8855_RG_TXFC_AN_BYPASS_P3	BIT(7)
+#define   AN8855_RG_TXFC_AN_BYPASS_P2	BIT(6)
+#define   AN8855_RG_TXFC_AN_BYPASS_P1	BIT(5)
+#define   AN8855_RG_DPX_AN_BYPASS_P3	BIT(3)
+#define   AN8855_RG_DPX_AN_BYPASS_P2	BIT(2)
+#define   AN8855_RG_DPX_AN_BYPASS_P1	BIT(1)
+#define   AN8855_RG_DPX_AN_BYPASS_P0	BIT(0)
+#define AN8855_PHY_RX_FORCE_CTRL_0	0x10224520
+#define   AN8855_RG_FORCE_TXC_SEL	BIT(4)
+
+/*	AN8855_XFI_CSR_PCS_BASE		0x10225000 */
+#define AN8855_RG_USXGMII_AN_CONTROL_0	0x10225bf8
+
+/*	AN8855_MULTI_PHY_RA_CSR_BASE	0x10226000 */
+#define AN8855_RG_RATE_ADAPT_CTRL_0	0x10226000
+#define   AN8855_RG_RATE_ADAPT_RX_BYPASS BIT(27)
+#define   AN8855_RG_RATE_ADAPT_TX_BYPASS BIT(26)
+#define   AN8855_RG_RATE_ADAPT_RX_EN	BIT(4)
+#define   AN8855_RG_RATE_ADAPT_TX_EN	BIT(0)
+#define AN8855_RATE_ADP_P0_CTRL_0	0x10226100
+#define   AN8855_RG_P0_DIS_MII_MODE	BIT(31)
+#define   AN8855_RG_P0_MII_MODE		BIT(28)
+#define   AN8855_RG_P0_MII_RA_RX_EN	BIT(3)
+#define   AN8855_RG_P0_MII_RA_TX_EN	BIT(2)
+#define   AN8855_RG_P0_MII_RA_RX_MODE	BIT(1)
+#define   AN8855_RG_P0_MII_RA_TX_MODE	BIT(0)
+#define AN8855_MII_RA_AN_ENABLE		0x10226300
+#define   AN8855_RG_P0_RA_AN_EN		BIT(0)
+
+/*	AN8855_QP_DIG_CSR_BASE		0x1022a000 */
+#define AN8855_QP_CK_RST_CTRL_4		0x1022a310
+#define AN8855_QP_DIG_MODE_CTRL_0	0x1022a324
+#define   AN8855_RG_SGMII_MODE		GENMASK(5, 4)
+#define   AN8855_RG_SGMII_AN_EN		BIT(0)
+#define AN8855_QP_DIG_MODE_CTRL_1	0x1022a330
+#define   AN8855_RG_TPHY_SPEED		GENMASK(3, 2)
+
+/*	AN8855_SERDES_WRAPPER_BASE	0x1022c000 */
+#define AN8855_USGMII_CTRL_0		0x1022c000
+
+/*	AN8855_QP_PMA_TOP_BASE		0x1022e000 */
+#define AN8855_PON_RXFEDIG_CTRL_0	0x1022e100
+#define   AN8855_RG_QP_EQ_RX500M_CK_SEL	BIT(12)
+#define AN8855_PON_RXFEDIG_CTRL_9	0x1022e124
+#define   AN8855_RG_QP_EQ_LEQOSC_DLYCNT	GENMASK(2, 0)
+
+#define AN8855_SS_LCPLL_PWCTL_SETTING_2	0x1022e208
+#define   AN8855_RG_NCPO_ANA_MSB	GENMASK(17, 16)
+#define AN8855_SS_LCPLL_TDC_FLT_2	0x1022e230
+#define   AN8855_RG_LCPLL_NCPO_VALUE	GENMASK(30, 0)
+#define AN8855_SS_LCPLL_TDC_FLT_5	0x1022e23c
+#define   AN8855_RG_LCPLL_NCPO_CHG	BIT(24)
+#define AN8855_SS_LCPLL_TDC_PCW_1	0x1022e248
+#define  AN8855_RG_LCPLL_PON_HRDDS_PCW_NCPO_GPON GENMASK(30, 0)
+#define AN8855_INTF_CTRL_8		0x1022e320
+#define AN8855_INTF_CTRL_9		0x1022e324
+#define AN8855_INTF_CTRL_10		0x1022e328
+#define   AN8855_RG_DA_QP_TX_FIR_C2_SEL	BIT(29)
+#define   AN8855_RG_DA_QP_TX_FIR_C2_FORCE GENMASK(28, 24)
+#define   AN8855_RG_DA_QP_TX_FIR_C1_SEL	BIT(21)
+#define   AN8855_RG_DA_QP_TX_FIR_C1_FORCE GENMASK(20, 16)
+#define AN8855_INTF_CTRL_11		0x1022e32c
+#define   AN8855_RG_DA_QP_TX_FIR_C0B_SEL BIT(6)
+#define   AN8855_RG_DA_QP_TX_FIR_C0B_FORCE GENMASK(5, 0)
+#define AN8855_PLL_CTRL_0		0x1022e400
+#define   AN8855_RG_PHYA_AUTO_INIT	BIT(0)
+#define AN8855_PLL_CTRL_2		0x1022e408
+#define   AN8855_RG_DA_QP_PLL_SDM_IFM_INTF BIT(30)
+#define   AN8855_RG_DA_QP_PLL_RICO_SEL_INTF BIT(29)
+#define   AN8855_RG_DA_QP_PLL_POSTDIV_EN_INTF BIT(28)
+#define   AN8855_RG_DA_QP_PLL_PHY_CK_EN_INTF BIT(27)
+#define   AN8855_RG_DA_QP_PLL_PFD_OFFSET_EN_INTRF BIT(26)
+#define   AN8855_RG_DA_QP_PLL_PFD_OFFSET_INTF GENMASK(25, 24)
+#define   AN8855_RG_DA_QP_PLL_PCK_SEL_INTF BIT(22)
+#define   AN8855_RG_DA_QP_PLL_KBAND_PREDIV_INTF GENMASK(21, 20)
+#define   AN8855_RG_DA_QP_PLL_IR_INTF	GENMASK(19, 16)
+#define   AN8855_RG_DA_QP_PLL_ICOIQ_EN_INTF BIT(14)
+#define   AN8855_RG_DA_QP_PLL_FBKSEL_INTF GENMASK(13, 12)
+#define   AN8855_RG_DA_QP_PLL_BR_INTF	GENMASK(10, 8)
+#define   AN8855_RG_DA_QP_PLL_BPD_INTF	GENMASK(7, 6)
+#define   AN8855_RG_DA_QP_PLL_BPA_INTF	GENMASK(4, 2)
+#define   AN8855_RG_DA_QP_PLL_BC_INTF	GENMASK(1, 0)
+#define AN8855_PLL_CTRL_3		0x1022e40c
+#define   AN8855_RG_DA_QP_PLL_SSC_PERIOD_INTF GENMASK(31, 16)
+#define   AN8855_RG_DA_QP_PLL_SSC_DELTA_INTF GENMASK(15, 0)
+#define AN8855_PLL_CTRL_4		0x1022e410
+#define   AN8855_RG_DA_QP_PLL_SDM_HREN_INTF GENMASK(4, 3)
+#define   AN8855_RG_DA_QP_PLL_ICOLP_EN_INTF BIT(2)
+#define   AN8855_RG_DA_QP_PLL_SSC_DIR_DLY_INTF GENMASK(1, 0)
+#define AN8855_PLL_CK_CTRL_0		0x1022e414
+#define   AN8855_RG_DA_QP_PLL_TDC_TXCK_SEL_INTF BIT(9)
+#define   AN8855_RG_DA_QP_PLL_SDM_DI_EN_INTF BIT(8)
+#define AN8855_RX_DLY_0			0x1022e614
+#define   AN8855_RG_QP_RX_SAOSC_EN_H_DLY GENMASK(13, 8)
+#define   AN8855_RG_QP_RX_PI_CAL_EN_H_DLY GENMASK(7, 0)
+#define AN8855_RX_CTRL_2		0x1022e630
+#define   AN8855_RG_QP_RX_EQ_EN_H_DLY	GENMASK(28, 16)
+#define AN8855_RX_CTRL_5		0x1022e63c
+#define   AN8855_RG_FREDET_CHK_CYCLE	GENMASK(29, 10)
+#define AN8855_RX_CTRL_6		0x1022e640
+#define   AN8855_RG_FREDET_GOLDEN_CYCLE	GENMASK(19, 0)
+#define AN8855_RX_CTRL_7		0x1022e644
+#define   AN8855_RG_FREDET_TOLERATE_CYCLE GENMASK(19, 0)
+#define AN8855_RX_CTRL_8		0x1022e648
+#define   AN8855_RG_DA_QP_SAOSC_DONE_TIME GENMASK(27, 16)
+#define   AN8855_RG_DA_QP_LEQOS_EN_TIME	GENMASK(14, 0)
+#define AN8855_RX_CTRL_26		0x1022e690
+#define   AN8855_RG_QP_EQ_RETRAIN_ONLY_EN BIT(26)
+#define   AN8855_RG_LINK_NE_EN		BIT(24)
+#define   AN8855_RG_LINK_ERRO_EN	BIT(23)
+#define AN8855_RX_CTRL_42		0x1022e6d0
+#define   AN8855_RG_QP_EQ_EN_DLY	GENMASK(12, 0)
+
+/*	AN8855_QP_ANA_CSR_BASE		0x1022f000 */
+#define AN8855_RG_QP_RX_DAC_EN		0x1022f000
+#define   AN8855_RG_QP_SIGDET_HF	GENMASK(17, 16)
+#define AN8855_RG_QP_RXAFE_RESERVE	0x1022f004
+#define   AN8855_RG_QP_CDR_PD_10B_EN	BIT(11)
+#define AN8855_RG_QP_CDR_LPF_BOT_LIM	0x1022f008
+#define   AN8855_RG_QP_CDR_LPF_KP_GAIN	GENMASK(26, 24)
+#define   AN8855_RG_QP_CDR_LPF_KI_GAIN	GENMASK(22, 20)
+#define AN8855_RG_QP_CDR_LPF_MJV_LIM	0x1022f00c
+#define   AN8855_RG_QP_CDR_LPF_RATIO	GENMASK(5, 4)
+#define AN8855_RG_QP_CDR_LPF_SETVALUE	0x1022f014
+#define   AN8855_RG_QP_CDR_PR_BUF_IN_SR	GENMASK(31, 29)
+#define   AN8855_RG_QP_CDR_PR_BETA_SEL	GENMASK(28, 25)
+#define AN8855_RG_QP_CDR_PR_CKREF_DIV1	0x1022f018
+#define   AN8855_RG_QP_CDR_PR_KBAND_DIV	GENMASK(26, 24)
+#define   AN8855_RG_QP_CDR_PR_DAC_BAND	GENMASK(12, 8)
+#define AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE 0x1022f01c
+#define   AN8855_RG_QP_CDR_PR_XFICK_EN	BIT(30)
+#define   AN8855_RG_QP_CDR_PR_KBAND_PCIE_MODE BIT(6)
+#define   AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE_MASK GENMASK(5, 0)
+#define AN8855_RG_QP_CDR_FORCE_IBANDLPF_R_OFF 0x1022f020
+#define   AN8855_RG_QP_CDR_PHYCK_SEL	GENMASK(17, 16)
+#define   AN8855_RG_QP_CDR_PHYCK_RSTB	BIT(13)
+#define   AN8855_RG_QP_CDR_PHYCK_DIV	GENMASK(12, 6)
+#define AN8855_RG_QP_TX_MODE		0x1022f028
+#define   AN8855_RG_QP_TX_RESERVE	GENMASK(31, 16)
+#define   AN8855_RG_QP_TX_MODE_16B_EN	BIT(0)
+#define AN8855_RG_QP_PLL_IPLL_DIG_PWR_SEL 0x1022f03c
+#define AN8855_RG_QP_PLL_SDM_ORD	0x1022f040
+#define   AN8855_RG_QP_PLL_SSC_PHASE_INI BIT(4)
+#define   AN8855_RG_QP_PLL_SSC_TRI_EN	BIT(3)
+
+/*	AN8855_ETHER_SYS_BASE		0x1028c800 */
+#define AN8855_RG_GPHY_AFE_PWD		0x1028c840
+#define AN8855_RG_GPHY_SMI_ADDR		0x1028c848
+
+struct an8855_priv {
+	struct dsa_switch *ds;
+	struct regmap *regmap;
+	/* Protect ATU or VLAN table access */
+	struct mutex reg_mutex;
+
+	struct phylink_pcs pcs;
+
+	struct mt7530_port ports[AN8855_NUM_PORTS];
+	u32 tx_lpi_timer_ports[AN8855_NUM_PORTS];
+
+	struct mt7530_lib_priv lib_priv;
+};
+
+#endif /* __AN8855_H */
diff --git a/drivers/net/dsa/mediatek/mt7530-lib.c b/drivers/net/dsa/mediatek/mt7530-lib.c
index 098dd45d3ee9..432576803332 100644
--- a/drivers/net/dsa/mediatek/mt7530-lib.c
+++ b/drivers/net/dsa/mediatek/mt7530-lib.c
@@ -423,9 +423,11 @@ int mt7530_lib_fdb_cmd(struct mt7530_lib_priv *priv, enum mt7530_fdb_cmd cmd,
 		return ret;
 	}
 
-	regmap_field_read(priv->fields[MT7530_ATC_INVALID], &val);
-	if (cmd == MT7530_FDB_READ && val)
-		return -EINVAL;
+	if (priv->fields[MT7530_ATC_INVALID]) {
+		regmap_field_read(priv->fields[MT7530_ATC_INVALID], &val);
+		if (cmd == MT7530_FDB_READ && val)
+			return -EINVAL;
+	}
 
 	if (rsp)
 		regmap_field_read(priv->fields[__MT7530_ATC], rsp);
@@ -442,6 +444,8 @@ static void mt7530_lib_fdb_write(struct mt7530_lib_priv *priv, u16 vid,
 	regmap_field_write(priv->fields[__MT7530_ATWD1], 0);
 	regmap_field_write(priv->fields[__MT7530_ATWD2], 0);
 	regmap_field_write(priv->fields[__MT7530_ATWD3], 0);
+	if (priv->fields[__MT7530_ATWD4])
+		regmap_field_write(priv->fields[__MT7530_ATWD4], 0);
 
 	regmap_field_write(priv->fields[MT7530_ATWD_CVID], vid);
 	regmap_field_write(priv->fields[MT7530_ATWD_IVL], 1);
@@ -452,7 +456,17 @@ static void mt7530_lib_fdb_write(struct mt7530_lib_priv *priv, u16 vid,
 	 * be aged out and STATIC_EMP specified as erasing an
 	 * entry
 	 */
-	regmap_field_write(priv->fields[MT7530_ATWD_ENT_STATUS], type);
+	if (priv->fields[MT7530_ATWD_ENT_STATUS])
+		regmap_field_write(priv->fields[MT7530_ATWD_ENT_STATUS], type);
+	if (priv->fields[AN8855_ATWD_TYPE]) {
+		/* Default to static entry (0) */
+		regmap_field_write(priv->fields[AN8855_ATWD_TYPE], 0);
+	}
+	if (priv->fields[AN8855_ATWD_VLD]) {
+		/* Load entry if STATIC_ENT */
+		regmap_field_write(priv->fields[AN8855_ATWD_VLD],
+				   type == STATIC_ENT);
+	}
 	regmap_field_write(priv->fields[MT7530_ATWD_MAC_BYTE_5], mac[5]);
 	regmap_field_write(priv->fields[MT7530_ATWD_MAC_BYTE_4], mac[4]);
 	regmap_field_write(priv->fields[MT7530_ATWD_MAC_BYTE_3], mac[3]);
@@ -483,8 +497,14 @@ void mt7530_lib_fdb_read(struct mt7530_lib_priv *priv, struct mt7530_fdb *fdb)
 	fdb->mac[1] = val;
 	regmap_field_read(priv->fields[MT7530_ATRD_MAC_BYTE_0], &val);
 	fdb->mac[0] = val;
-	regmap_field_read(priv->fields[MT7530_ATRD_ENT_STATUS], &val);
-	fdb->noarp = val == STATIC_ENT;
+	if (priv->fields[MT7530_ATRD_ENT_STATUS]) {
+		regmap_field_read(priv->fields[MT7530_ATRD_ENT_STATUS], &val);
+		fdb->noarp = val == STATIC_ENT;
+	}
+	if (priv->fields[AN8855_ATRD_ARP]) {
+		regmap_field_read(priv->fields[AN8855_ATRD_ARP], &val);
+		fdb->noarp = !!val;
+	}
 }
 EXPORT_SYMBOL_GPL(mt7530_lib_fdb_read);
 
@@ -787,6 +807,17 @@ void mt7530_lib_port_bridge_leave(struct mt7530_lib_priv *priv, int port,
 }
 EXPORT_SYMBOL_GPL(mt7530_lib_port_bridge_leave);
 
+void mt7530_port_set_pvid(struct mt7530_lib_priv *priv, int port,
+			  u16 pvid)
+{
+	regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
+			    port, pvid);
+	if (priv->fields[AN8855_PVID_G0_PORT_VID])
+		regmap_fields_write(priv->fields[AN8855_PVID_G0_PORT_VID],
+				    port, pvid);
+}
+EXPORT_SYMBOL_GPL(mt7530_port_set_pvid);
+
 static void mt7530_port_set_vlan_unaware(struct mt7530_lib_priv *priv, int port)
 {
 	struct dsa_switch *ds = priv->ds;
@@ -807,8 +838,7 @@ static void mt7530_port_set_vlan_unaware(struct mt7530_lib_priv *priv, int port)
 	regmap_fields_write(priv->fields[MT7530_PVC_ACC_FRM],
 			    port, MT7530_VLAN_ACC_ALL);
 
-	regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
-			    port, G0_PORT_VID_DEF);
+	mt7530_port_set_pvid(priv, port, G0_PORT_VID_DEF);
 
 	for (i = 0; i < priv->ds->num_ports; i++) {
 		if (i == port)
@@ -840,8 +870,7 @@ static void mt7530_port_set_vlan_aware(struct mt7530_lib_priv *priv, int port)
 	if (dsa_is_user_port(ds, port)) {
 		regmap_fields_write(priv->fields[MT7530_PCR_PORT_VLAN],
 				    port, MT7530_PORT_SECURITY_MODE);
-		regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
-				    port, priv->ports[port].pvid);
+		mt7530_port_set_pvid(priv, port, priv->ports[port].pvid);
 
 		/* Only accept tagged frames if PVID is not set */
 		if (!priv->ports[port].pvid)
@@ -919,10 +948,12 @@ static int mt7530_vlan_cmd(struct mt7530_lib_priv *priv, enum mt7530_vlan_cmd cm
 		return ret;
 	}
 
-	regmap_field_read(priv->fields[MT7530_VTCR_INVALID], &val);
-	if (val) {
-		dev_err(priv->dev, "read VTCR invalid\n");
-		return -EINVAL;
+	if (priv->fields[MT7530_VTCR_INVALID]) {
+		regmap_field_read(priv->fields[MT7530_VTCR_INVALID], &val);
+		if (val) {
+			dev_err(priv->dev, "read VTCR invalid\n");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -1044,8 +1075,7 @@ int mt7530_lib_port_vlan_add(struct mt7530_lib_priv *priv, int port,
 
 		/* Only configure PVID if VLAN filtering is enabled */
 		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
-			regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
-					    port, vlan->vid);
+			mt7530_port_set_pvid(priv, port, vlan->vid);
 	} else if (vlan->vid && priv->ports[port].pvid == vlan->vid) {
 		/* This VLAN is overwritten without PVID, so unset it */
 		priv->ports[port].pvid = G0_PORT_VID_DEF;
@@ -1055,8 +1085,7 @@ int mt7530_lib_port_vlan_add(struct mt7530_lib_priv *priv, int port,
 			regmap_fields_write(priv->fields[MT7530_PVC_ACC_FRM],
 					    port, MT7530_VLAN_ACC_TAGGED);
 
-		regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
-				    port, G0_PORT_VID_DEF);
+		mt7530_port_set_pvid(priv, port, G0_PORT_VID_DEF);
 	}
 
 	mutex_unlock(priv->reg_mutex);
@@ -1093,8 +1122,7 @@ int mt7530_lib_port_vlan_del(struct mt7530_lib_priv *priv, int port,
 			regmap_fields_write(priv->fields[MT7530_PVC_ACC_FRM],
 					    port, MT7530_VLAN_ACC_TAGGED);
 
-		regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
-				    port, G0_PORT_VID_DEF);
+		mt7530_port_set_pvid(priv, port, G0_PORT_VID_DEF);
 	}
 
 	mutex_unlock(priv->reg_mutex);
diff --git a/drivers/net/dsa/mediatek/mt7530-lib.h b/drivers/net/dsa/mediatek/mt7530-lib.h
index da2ee781f7e6..1465eb49f4cb 100644
--- a/drivers/net/dsa/mediatek/mt7530-lib.h
+++ b/drivers/net/dsa/mediatek/mt7530-lib.h
@@ -159,6 +159,8 @@ enum mt7530_regmap_field {
 	MT7530_ATWD_AGE_TIMER,
 	MT7530_ATWD_PORT_MAP,
 	MT7530_ATWD_ENT_STATUS,
+	AN8855_ATWD_TYPE,
+	AN8855_ATWD_VLD,
 	MT7530_ATWD_MAC_BYTE_5,
 	MT7530_ATWD_MAC_BYTE_4,
 	MT7530_ATWD_MAC_BYTE_3,
@@ -169,11 +171,13 @@ enum mt7530_regmap_field {
 	__MT7530_ATWD1,
 	__MT7530_ATWD2,
 	__MT7530_ATWD3,
+	__MT7530_ATWD4,
 
 	MT7530_ATRD_CVID,
 	MT7530_ATRD_AGE_TIMER,
 	MT7530_ATRD_PORT_MAP,
 	MT7530_ATRD_ENT_STATUS,
+	AN8855_ATRD_ARP,
 	MT7530_ATRD_MAC_BYTE_5,
 	MT7530_ATRD_MAC_BYTE_4,
 	MT7530_ATRD_MAC_BYTE_3,
@@ -201,6 +205,7 @@ enum mt7530_regmap_field {
 	MT7530_PVC_ACC_FRM,
 
 	MT7530_PPBV1_G0_PORT_VID,
+	AN8855_PVID_G0_PORT_VID,
 
 	MT7530_GMACCR_MAX_RX_JUMBO,
 	MT7530_GMACCR_MAX_RX_PKT_LEN,
@@ -223,8 +228,13 @@ enum mt7530_regmap_field {
 	MT7530_MIB_TX_PKT_SZ_256_TO_511,
 	MT7530_MIB_TX_PKT_SZ_512_TO_1023,
 	MT7530_MIB_TX_PKT_SZ_1024_TO_MAX,
+	AN8855_MIB_TX_PKT_SZ_1024_TO_1518,
+	AN8855_MIB_TX_PKT_SZ_1519_TO_MAX,
 	MT7530_MIB_TX_BYTES_LOW,
 	MT7530_MIB_TX_BYTES_HIGH,
+	AN8855_MIB_TX_OVERSIZE_DROP,
+	AN8855_MIB_TX_BAD_PKT_BYTES_LOW,
+	AN8855_MIB_TX_BAD_PKT_BYTES_HIGH,
 	MT7530_MIB_RX_DROP,
 	MT7530_MIB_RX_FILTERING,
 	MT7530_MIB_RX_UNICAST,
@@ -243,11 +253,21 @@ enum mt7530_regmap_field {
 	MT7530_MIB_RX_PKT_SZ_256_TO_511,
 	MT7530_MIB_RX_PKT_SZ_512_TO_1023,
 	MT7530_MIB_RX_PKT_SZ_1024_TO_MAX,
+	AN8855_MIB_RX_PKT_SZ_1024_TO_1518,
+	AN8855_MIB_RX_PKT_SZ_1519_TO_MAX,
 	MT7530_MIB_RX_BYTES_LOW,
 	MT7530_MIB_RX_BYTES_HIGH,
 	MT7530_MIB_RX_CTRL_DROP,
 	MT7530_MIB_RX_INGRESS_DROP,
 	MT7530_MIB_RX_ARL_DROP,
+	AN8855_MIB_FLOW_CONTROL_DROP,
+	AN8855_MIB_WRED_DROP,
+	AN8855_MIB_MIRROR_DROP,
+	AN8855_MIB_RX_BAD_PKT_BYTES_LOW,
+	AN8855_MIB_RX_BAD_PKT_BYTES_HIGH,
+	AN8855_MIB_RXS_FLOW_SAMPLING_PKT_DROP,
+	AN8855_MIB_RXS_FLOW_TOTAL_PKT_DROP,
+	AN8855_MIB_PORT_CONTROL_DROP,
 
 	MT7530_FIELD_MAX,
 };
@@ -385,6 +405,8 @@ int mt7530_lib_port_vlan_add(struct mt7530_lib_priv *priv, int port,
 int mt7530_lib_port_vlan_del(struct mt7530_lib_priv *priv, int port,
 			     const struct switchdev_obj_port_vlan *vlan);
 
+void mt7530_port_set_pvid(struct mt7530_lib_priv *priv, int port,
+			  u16 pvid);
 int mt7530_lib_setup_vlan0(struct mt7530_lib_priv *priv);
 
 #endif /* __MT7530_LIB_H */
-- 
2.55.0

