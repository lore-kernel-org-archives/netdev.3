Received: from mail-pz2-f25.google.com (mail-pz2-f25.google.com [74.125.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41084B8298
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577054; cv=none; b=gu7RUdZvv21eKaEfbsy6g66F5rDfBoOfbhAVFpp/wDUQ9yCmBolkpaMyzFRYyScpkZKvzIZvlZ67oSq76oZSqzzoe0yhO+qCcSEwSi3GO69TMtL/FI1pWVyqJd38ns7/84NL3DeCqUMVgAE41XO/IRdJwv9iV/XohgoTq1PXH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577054; c=relaxed/simple;
	bh=F2Prgz29T+jTiEa6vcQe1q6NIeuBEr97mTPeLD6h+IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkXbAY7WbjiHiXYL+HKUMmQ6KSfPlbUBNOUJ84eZnXUhD1tCgYFkz7bfBWoJEhs+knTqjrhhpkXvTwQOv1LMC5wavsCMJ7KtsoVL90q/59/5Gvg2yOR6lEfYK5h5Qbi2U/sDh9GaBuF3wc3BKODDrUVNvyoLATTCHSfCfZsxV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAfrVjrG; arc=none smtp.client-ip=74.125.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAfrVjrG"
Received: by mail-pz2-f25.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso990800a12.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577031; x=1790181831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+2Q3mTjdDlrxij5IsS30F/SyZaUVlGmYVSRkzfKqyo=;
        b=NAfrVjrGmbU5wtWco8CxLNoKZvw3eTWaUMSdNkpduXuXBoD7n6DVY5WGzCKMn2LOZf
         KCv+Judnv9CN8aBlZiXWbSDWmUXomdM3R8aEUVeE17p4cAHaoAadqr8elNhvMVPgKhS3
         /G6/WuBTYnJfE9wKlFYYR5ud5vHtGyYuy1YhnzV5Zolo+w/Iw/62jPwPpqIcZ0Sy0ujk
         C0HBTO80QlIzoN7WnXXysCUZVIN9LQDbWznyD6/hERXTS893WzWy+ROaq4E9maWixmpV
         xJkqc9MW8ZhcUMq3LJ5nz6+hR6iRl7ErURz7HbqsXoIXhO4ee+EiFEVqPZiURlm+ANiM
         UyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577031; x=1790181831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+2Q3mTjdDlrxij5IsS30F/SyZaUVlGmYVSRkzfKqyo=;
        b=SEZmOSREkc4leUUlWXEd6przEgsui/1V6+hjlA6jei+01EgOfZd65h2W8bwgBP4F+B
         PxLDX9pgOLouJL8pdIr16D8RmhjbT6fbMsj7dgWWfTrNCEl60HFZ2MT8aU3GpYbiFf+H
         HYFAwoKCyyL4rEq9c8B4GVGiUEkS17ziJh+zc7WO0vJlyVvyBNbUASMhUYSflWKpXwnS
         xIZy6Z1zhi9sPWu0id0AkvhQtTPghsfjoEhf3sRojHgL5VwthLtbBYdR3j0/GHwWGoap
         /ecUNIf22nKLfUNznn8d4LAC9+B/FROdk9B6sU7F/0YmR9RpPgbh1ln+SOtf3GICPDmD
         OnPg==
X-Gm-Message-State: AFuF++mZ+FFAYMlh0uK2rLIXu6J+goZnK0VHlYwqa7SJ1FeiVE+i1CoK
	+q1s/q6fNSo71ICc2gTIXaYKs6kMe59O+XY6s56apPzjNtg0bkLALuy064EMh/JYB+0=
X-Gm-Gg: AYBFou08365T3kqmlKqh6j+02Hl8nA/pM6ThvSLHNRL7YVDi42XsN0IiuEA+c8om/t2
	eTBDcwBCn4kP7iiPpYXyCB+iq7Ti7efKW8/HKh8hiTXLVR3YeLcH/4wsMgZ5L+KPV2BBLOvB+ni
	H/7Zz2LYL1PbPgBu8AK1HcCw9n9MOCUeoaviq60WryjQ/ygefCdjie8kiGV+1/V0tzTsKmC+iiS
	zzEM7rgvRYiVj+ubr34nTFGSixZmUxesmtVRfJFg1EK3W8rnACo0m3N2rwxcw452M/8Hf51toa5
	kCB1lMPU7RjMdO2SF7KqjjXgi9yA6Gc2PhR8GAnSVsIMOZYeBiSTboHvFrBEzqwUJ1CVtu5+oFT
	4aWJL802wEwF6YP2S41JBIaiDT57c2muAJjxEKemOIhBO9ja+3LDZ4PDPh3UejlzNfU3Cq0PTEW
	u2vF3noLRdEIN+hk2AACIutX5vn8SOv/X3Dtv+cegq3WXT1pnwRNw1tnc4nSiQtT/v1RTWEJNVx
	rzCqj/pufp5keE/pN1HJM5I+Cob6Ap1HIpx
X-Received: by 2002:a05:6a20:9d93:b0:3da:9f19:bf2 with SMTP id adf61e73a8af0-3dd5f5c7a3dmr9686951637.18.1789577030891;
        Wed, 16 Sep 2026 09:43:50 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc757csm1902278a12.32.2026.09.16.09.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:43:50 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/8] net: dsa: motorcomm: Split MDIO bus module
Date: Thu, 17 Sep 2026 00:43:07 +0800
Message-ID: <20260916164310.3168269-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916164310.3168269-1-mmyangfl@gmail.com>
References: <20260916164310.3168269-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split it in order to be used in other modules.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/Makefile   |   1 +
 drivers/net/dsa/motorcomm/chip.c     | 269 +-------------------------
 drivers/net/dsa/motorcomm/chip.h     |  21 --
 drivers/net/dsa/motorcomm/mdio_bus.c | 278 +++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/mdio_bus.h |  39 ++++
 5 files changed, 319 insertions(+), 289 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.c
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.h

diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index aeb12cb91f93..f7cce7eabbb8 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 yt921x-objs := chip.o
 yt921x-$(CONFIG_NET_DSA_YT921X_LEDS) += leds.o
+yt921x-objs += mdio_bus.o
 yt921x-objs += smi.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index e7fa5557ec81..c7a8004ce34a 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -27,6 +27,7 @@
 
 #include "chip.h"
 #include "leds.h"
+#include "mdio_bus.h"
 #include "smi.h"
 
 struct yt921x_mib_desc {
@@ -266,274 +267,6 @@ static const struct yt921x_reg_ops yt921x_reg_ops_mdio = {
 
 /* TODO: SPI/I2C */
 
-static int yt921x_intif_wait(struct yt921x_priv *priv)
-{
-	u32 val = 0;
-
-	return yt921x_reg_wait(priv, YT921X_INT_MBUS_OP, YT921X_MBUS_OP_START,
-			       &val);
-}
-
-static int
-yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
-{
-	struct device *dev = to_device(priv);
-	u32 mask;
-	u32 ctrl;
-	u32 val;
-	int res;
-
-	res = yt921x_intif_wait(priv);
-	if (res)
-		return res;
-
-	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
-	       YT921X_MBUS_CTRL_OP_M;
-	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
-	       YT921X_MBUS_CTRL_READ;
-	res = yt921x_reg_update_bits(priv, YT921X_INT_MBUS_CTRL, mask, ctrl);
-	if (res)
-		return res;
-	res = yt921x_reg_write(priv, YT921X_INT_MBUS_OP, YT921X_MBUS_OP_START);
-	if (res)
-		return res;
-
-	res = yt921x_intif_wait(priv);
-	if (res)
-		return res;
-	res = yt921x_reg_read(priv, YT921X_INT_MBUS_DIN, &val);
-	if (res)
-		return res;
-
-	if ((u16)val != val)
-		dev_info(dev,
-			 "%s: port %d, reg 0x%x: Expected u16, got 0x%08x\n",
-			 __func__, port, reg, val);
-	*valp = (u16)val;
-	return 0;
-}
-
-static int
-yt921x_intif_write(struct yt921x_priv *priv, int port, int reg, u16 val)
-{
-	u32 mask;
-	u32 ctrl;
-	int res;
-
-	res = yt921x_intif_wait(priv);
-	if (res)
-		return res;
-
-	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
-	       YT921X_MBUS_CTRL_OP_M;
-	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
-	       YT921X_MBUS_CTRL_WRITE;
-	res = yt921x_reg_update_bits(priv, YT921X_INT_MBUS_CTRL, mask, ctrl);
-	if (res)
-		return res;
-	res = yt921x_reg_write(priv, YT921X_INT_MBUS_DOUT, val);
-	if (res)
-		return res;
-	res = yt921x_reg_write(priv, YT921X_INT_MBUS_OP, YT921X_MBUS_OP_START);
-	if (res)
-		return res;
-
-	return yt921x_intif_wait(priv);
-}
-
-static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
-{
-	struct yt921x_priv *priv = mbus->priv;
-	u16 val;
-	int res;
-
-	if (port >= YT921X_PORT_NUM)
-		return U16_MAX;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_intif_read(priv, port, reg, &val);
-	mutex_unlock(&priv->reg_lock);
-
-	if (res)
-		return res;
-	return val;
-}
-
-static int
-yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
-{
-	struct yt921x_priv *priv = mbus->priv;
-	int res;
-
-	if (port >= YT921X_PORT_NUM)
-		return -ENODEV;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_intif_write(priv, port, reg, data);
-	mutex_unlock(&priv->reg_lock);
-
-	return res;
-}
-
-static int
-yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
-{
-	struct device *dev = to_device(priv);
-	struct mii_bus *mbus;
-	int res;
-
-	mbus = devm_mdiobus_alloc(dev);
-	if (!mbus)
-		return -ENOMEM;
-
-	mbus->name = "YT921x internal MDIO bus";
-	snprintf(mbus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
-	mbus->priv = priv;
-	mbus->read = yt921x_mbus_int_read;
-	mbus->write = yt921x_mbus_int_write;
-	mbus->parent = dev;
-	mbus->phy_mask = (u32)~GENMASK(YT921X_PORT_NUM - 1, 0);
-
-	res = devm_of_mdiobus_register(dev, mbus, mnp);
-	if (res)
-		return res;
-
-	priv->mbus_int = mbus;
-
-	return 0;
-}
-
-static int yt921x_extif_wait(struct yt921x_priv *priv)
-{
-	u32 val = 0;
-
-	return yt921x_reg_wait(priv, YT921X_EXT_MBUS_OP, YT921X_MBUS_OP_START,
-			       &val);
-}
-
-static int
-yt921x_extif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
-{
-	struct device *dev = to_device(priv);
-	u32 mask;
-	u32 ctrl;
-	u32 val;
-	int res;
-
-	res = yt921x_extif_wait(priv);
-	if (res)
-		return res;
-
-	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
-	       YT921X_MBUS_CTRL_TYPE_M | YT921X_MBUS_CTRL_OP_M;
-	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
-	       YT921X_MBUS_CTRL_TYPE_C22 | YT921X_MBUS_CTRL_READ;
-	res = yt921x_reg_update_bits(priv, YT921X_EXT_MBUS_CTRL, mask, ctrl);
-	if (res)
-		return res;
-	res = yt921x_reg_write(priv, YT921X_EXT_MBUS_OP, YT921X_MBUS_OP_START);
-	if (res)
-		return res;
-
-	res = yt921x_extif_wait(priv);
-	if (res)
-		return res;
-	res = yt921x_reg_read(priv, YT921X_EXT_MBUS_DIN, &val);
-	if (res)
-		return res;
-
-	if ((u16)val != val)
-		dev_info(dev,
-			 "%s: port %d, reg 0x%x: Expected u16, got 0x%08x\n",
-			 __func__, port, reg, val);
-	*valp = (u16)val;
-	return 0;
-}
-
-static int
-yt921x_extif_write(struct yt921x_priv *priv, int port, int reg, u16 val)
-{
-	u32 mask;
-	u32 ctrl;
-	int res;
-
-	res = yt921x_extif_wait(priv);
-	if (res)
-		return res;
-
-	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
-	       YT921X_MBUS_CTRL_TYPE_M | YT921X_MBUS_CTRL_OP_M;
-	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
-	       YT921X_MBUS_CTRL_TYPE_C22 | YT921X_MBUS_CTRL_WRITE;
-	res = yt921x_reg_update_bits(priv, YT921X_EXT_MBUS_CTRL, mask, ctrl);
-	if (res)
-		return res;
-	res = yt921x_reg_write(priv, YT921X_EXT_MBUS_DOUT, val);
-	if (res)
-		return res;
-	res = yt921x_reg_write(priv, YT921X_EXT_MBUS_OP, YT921X_MBUS_OP_START);
-	if (res)
-		return res;
-
-	return yt921x_extif_wait(priv);
-}
-
-static int yt921x_mbus_ext_read(struct mii_bus *mbus, int port, int reg)
-{
-	struct yt921x_priv *priv = mbus->priv;
-	u16 val;
-	int res;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_extif_read(priv, port, reg, &val);
-	mutex_unlock(&priv->reg_lock);
-
-	if (res)
-		return res;
-	return val;
-}
-
-static int
-yt921x_mbus_ext_write(struct mii_bus *mbus, int port, int reg, u16 data)
-{
-	struct yt921x_priv *priv = mbus->priv;
-	int res;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_extif_write(priv, port, reg, data);
-	mutex_unlock(&priv->reg_lock);
-
-	return res;
-}
-
-static int
-yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
-{
-	struct device *dev = to_device(priv);
-	struct mii_bus *mbus;
-	int res;
-
-	mbus = devm_mdiobus_alloc(dev);
-	if (!mbus)
-		return -ENOMEM;
-
-	mbus->name = "YT921x external MDIO bus";
-	snprintf(mbus->id, MII_BUS_ID_SIZE, "%s@ext", dev_name(dev));
-	mbus->priv = priv;
-	/* TODO: c45? */
-	mbus->read = yt921x_mbus_ext_read;
-	mbus->write = yt921x_mbus_ext_write;
-	mbus->parent = dev;
-
-	res = devm_of_mdiobus_register(dev, mbus, mnp);
-	if (res)
-		return res;
-
-	priv->mbus_ext = mbus;
-
-	return 0;
-}
-
 /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
 static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 {
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 6652bb4304b7..c1b5f29eb0fa 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -243,27 +243,6 @@ enum yt921x_speed {
 #define   YT9218_SYS_CLK_167M				0
 #define   YT921X_SYS_CLK_143M				1
 
-#define YT921X_EXT_MBUS_OP		0x6a000
-#define YT921X_INT_MBUS_OP		0xf0000
-#define  YT921X_MBUS_OP_START			BIT(0)
-#define YT921X_EXT_MBUS_CTRL		0x6a004
-#define YT921X_INT_MBUS_CTRL		0xf0004
-#define  YT921X_MBUS_CTRL_PORT_M		GENMASK(25, 21)
-#define   YT921X_MBUS_CTRL_PORT(x)			FIELD_PREP(YT921X_MBUS_CTRL_PORT_M, (x))
-#define  YT921X_MBUS_CTRL_REG_M			GENMASK(20, 16)
-#define   YT921X_MBUS_CTRL_REG(x)			FIELD_PREP(YT921X_MBUS_CTRL_REG_M, (x))
-#define  YT921X_MBUS_CTRL_TYPE_M		GENMASK(11, 8)  /* wild guess */
-#define   YT921X_MBUS_CTRL_TYPE(x)			FIELD_PREP(YT921X_MBUS_CTRL_TYPE_M, (x))
-#define   YT921X_MBUS_CTRL_TYPE_C22			YT921X_MBUS_CTRL_TYPE(4)
-#define  YT921X_MBUS_CTRL_OP_M			GENMASK(3, 2)  /* wild guess */
-#define   YT921X_MBUS_CTRL_OP(x)			FIELD_PREP(YT921X_MBUS_CTRL_OP_M, (x))
-#define   YT921X_MBUS_CTRL_WRITE			YT921X_MBUS_CTRL_OP(1)
-#define   YT921X_MBUS_CTRL_READ				YT921X_MBUS_CTRL_OP(2)
-#define YT921X_EXT_MBUS_DOUT		0x6a008
-#define YT921X_INT_MBUS_DOUT		0xf0008
-#define YT921X_EXT_MBUS_DIN		0x6a00c
-#define YT921X_INT_MBUS_DIN		0xf000c
-
 #define YT921X_PORTn_EGR(port)		(0x100000 + 4 * (port))
 #define  YT921X_PORT_EGR_TPID_CTAG_M		GENMASK(5, 4)
 #define   YT921X_PORT_EGR_TPID_CTAG(x)			FIELD_PREP(YT921X_PORT_EGR_TPID_CTAG_M, (x))
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
new file mode 100644
index 000000000000..ba70343f3f33
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/mdio_bus.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include <linux/of_mdio.h>
+
+#include "chip.h"
+#include "mdio_bus.h"
+#include "smi.h"
+
+#define to_device(priv) ((priv)->ds.dev)
+
+static int yt921x_intif_wait(struct yt921x_priv *priv)
+{
+	u32 val = 0;
+
+	return yt921x_reg_wait(priv, YT921X_INT_MBUS_OP, YT921X_MBUS_OP_START,
+			       &val);
+}
+
+static int
+yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
+{
+	struct device *dev = to_device(priv);
+	u32 mask;
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	res = yt921x_intif_wait(priv);
+	if (res)
+		return res;
+
+	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
+	       YT921X_MBUS_CTRL_OP_M;
+	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
+	       YT921X_MBUS_CTRL_READ;
+	res = yt921x_reg_update_bits(priv, YT921X_INT_MBUS_CTRL, mask, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_INT_MBUS_OP, YT921X_MBUS_OP_START);
+	if (res)
+		return res;
+
+	res = yt921x_intif_wait(priv);
+	if (res)
+		return res;
+	res = yt921x_reg_read(priv, YT921X_INT_MBUS_DIN, &val);
+	if (res)
+		return res;
+
+	if ((u16)val != val)
+		dev_info(dev,
+			 "%s: port %d, reg 0x%x: Expected u16, got 0x%08x\n",
+			 __func__, port, reg, val);
+	*valp = (u16)val;
+	return 0;
+}
+
+static int
+yt921x_intif_write(struct yt921x_priv *priv, int port, int reg, u16 val)
+{
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	res = yt921x_intif_wait(priv);
+	if (res)
+		return res;
+
+	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
+	       YT921X_MBUS_CTRL_OP_M;
+	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
+	       YT921X_MBUS_CTRL_WRITE;
+	res = yt921x_reg_update_bits(priv, YT921X_INT_MBUS_CTRL, mask, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_INT_MBUS_DOUT, val);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_INT_MBUS_OP, YT921X_MBUS_OP_START);
+	if (res)
+		return res;
+
+	return yt921x_intif_wait(priv);
+}
+
+static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
+{
+	struct yt921x_priv *priv = mbus->priv;
+	u16 val;
+	int res;
+
+	if (port >= YT921X_PORT_NUM)
+		return U16_MAX;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_intif_read(priv, port, reg, &val);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return res;
+	return val;
+}
+
+static int
+yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
+{
+	struct yt921x_priv *priv = mbus->priv;
+	int res;
+
+	if (port >= YT921X_PORT_NUM)
+		return -ENODEV;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_intif_write(priv, port, reg, data);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
+{
+	struct device *dev = to_device(priv);
+	struct mii_bus *mbus;
+	int res;
+
+	mbus = devm_mdiobus_alloc(dev);
+	if (!mbus)
+		return -ENOMEM;
+
+	mbus->name = "YT921x internal MDIO bus";
+	snprintf(mbus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+	mbus->priv = priv;
+	mbus->read = yt921x_mbus_int_read;
+	mbus->write = yt921x_mbus_int_write;
+	mbus->parent = dev;
+	mbus->phy_mask = (u32)~GENMASK(YT921X_PORT_NUM - 1, 0);
+
+	res = devm_of_mdiobus_register(dev, mbus, mnp);
+	if (res)
+		return res;
+
+	priv->mbus_int = mbus;
+
+	return 0;
+}
+
+static int yt921x_extif_wait(struct yt921x_priv *priv)
+{
+	u32 val = 0;
+
+	return yt921x_reg_wait(priv, YT921X_EXT_MBUS_OP, YT921X_MBUS_OP_START,
+			       &val);
+}
+
+static int
+yt921x_extif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
+{
+	struct device *dev = to_device(priv);
+	u32 mask;
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	res = yt921x_extif_wait(priv);
+	if (res)
+		return res;
+
+	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
+	       YT921X_MBUS_CTRL_TYPE_M | YT921X_MBUS_CTRL_OP_M;
+	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
+	       YT921X_MBUS_CTRL_TYPE_C22 | YT921X_MBUS_CTRL_READ;
+	res = yt921x_reg_update_bits(priv, YT921X_EXT_MBUS_CTRL, mask, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_EXT_MBUS_OP, YT921X_MBUS_OP_START);
+	if (res)
+		return res;
+
+	res = yt921x_extif_wait(priv);
+	if (res)
+		return res;
+	res = yt921x_reg_read(priv, YT921X_EXT_MBUS_DIN, &val);
+	if (res)
+		return res;
+
+	if ((u16)val != val)
+		dev_info(dev,
+			 "%s: port %d, reg 0x%x: Expected u16, got 0x%08x\n",
+			 __func__, port, reg, val);
+	*valp = (u16)val;
+	return 0;
+}
+
+static int
+yt921x_extif_write(struct yt921x_priv *priv, int port, int reg, u16 val)
+{
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	res = yt921x_extif_wait(priv);
+	if (res)
+		return res;
+
+	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
+	       YT921X_MBUS_CTRL_TYPE_M | YT921X_MBUS_CTRL_OP_M;
+	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
+	       YT921X_MBUS_CTRL_TYPE_C22 | YT921X_MBUS_CTRL_WRITE;
+	res = yt921x_reg_update_bits(priv, YT921X_EXT_MBUS_CTRL, mask, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_EXT_MBUS_DOUT, val);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_EXT_MBUS_OP, YT921X_MBUS_OP_START);
+	if (res)
+		return res;
+
+	return yt921x_extif_wait(priv);
+}
+
+static int yt921x_mbus_ext_read(struct mii_bus *mbus, int port, int reg)
+{
+	struct yt921x_priv *priv = mbus->priv;
+	u16 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_extif_read(priv, port, reg, &val);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return res;
+	return val;
+}
+
+static int
+yt921x_mbus_ext_write(struct mii_bus *mbus, int port, int reg, u16 data)
+{
+	struct yt921x_priv *priv = mbus->priv;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_extif_write(priv, port, reg, data);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
+{
+	struct device *dev = to_device(priv);
+	struct mii_bus *mbus;
+	int res;
+
+	mbus = devm_mdiobus_alloc(dev);
+	if (!mbus)
+		return -ENOMEM;
+
+	mbus->name = "YT921x external MDIO bus";
+	snprintf(mbus->id, MII_BUS_ID_SIZE, "%s@ext", dev_name(dev));
+	mbus->priv = priv;
+	/* TODO: c45? */
+	mbus->read = yt921x_mbus_ext_read;
+	mbus->write = yt921x_mbus_ext_write;
+	mbus->parent = dev;
+
+	res = devm_of_mdiobus_register(dev, mbus, mnp);
+	if (res)
+		return res;
+
+	priv->mbus_ext = mbus;
+
+	return 0;
+}
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.h b/drivers/net/dsa/motorcomm/mdio_bus.h
new file mode 100644
index 000000000000..ae5792b8da24
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/mdio_bus.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_MDIO_BUS_H
+#define _YT_MDIO_BUS_H
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/of.h>
+
+#define YT921X_EXT_MBUS_OP		0x6a000
+#define YT921X_INT_MBUS_OP		0xf0000
+#define  YT921X_MBUS_OP_START			BIT(0)
+#define YT921X_EXT_MBUS_CTRL		0x6a004
+#define YT921X_INT_MBUS_CTRL		0xf0004
+#define  YT921X_MBUS_CTRL_PORT_M		GENMASK(25, 21)
+#define   YT921X_MBUS_CTRL_PORT(x)			FIELD_PREP(YT921X_MBUS_CTRL_PORT_M, (x))
+#define  YT921X_MBUS_CTRL_REG_M			GENMASK(20, 16)
+#define   YT921X_MBUS_CTRL_REG(x)			FIELD_PREP(YT921X_MBUS_CTRL_REG_M, (x))
+#define  YT921X_MBUS_CTRL_TYPE_M		GENMASK(11, 8)  /* wild guess */
+#define   YT921X_MBUS_CTRL_TYPE(x)			FIELD_PREP(YT921X_MBUS_CTRL_TYPE_M, (x))
+#define   YT921X_MBUS_CTRL_TYPE_C22			YT921X_MBUS_CTRL_TYPE(4)
+#define  YT921X_MBUS_CTRL_OP_M			GENMASK(3, 2)  /* wild guess */
+#define   YT921X_MBUS_CTRL_OP(x)			FIELD_PREP(YT921X_MBUS_CTRL_OP_M, (x))
+#define   YT921X_MBUS_CTRL_WRITE			YT921X_MBUS_CTRL_OP(1)
+#define   YT921X_MBUS_CTRL_READ				YT921X_MBUS_CTRL_OP(2)
+#define YT921X_EXT_MBUS_DOUT		0x6a008
+#define YT921X_INT_MBUS_DOUT		0xf0008
+#define YT921X_EXT_MBUS_DIN		0x6a00c
+#define YT921X_INT_MBUS_DIN		0xf000c
+
+struct yt921x_priv;
+
+int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp);
+int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp);
+
+#endif
-- 
2.53.0

