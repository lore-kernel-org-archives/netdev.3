Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8724D1781
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671147; cv=none; b=p1Q5T0PzTRz+JKZQ4CZij2H72wkjA8UwDMX4YBSBFPNcu4SOrS44Y+s0lRmtpSc8TyHz11dXm7AqMYni+QUKbwlLx2LeyMIZ+CiukoRjK1PgwrMC9IaQazWIBAFUofpmINhe2bsYem3uTcyoqD5HIhkg1IOvATU1rQunsIAG0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671147; c=relaxed/simple;
	bh=3K2ZIS8f+rhwpoiDFh0PMpB1FMbQ4qqvng5xOXzTKB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxslONDJxQRrMo2eT3wgfYUX4LA7y9EvdVU9u88XtbajBX6x+QqzLFxwFyqz/PfCrF7J/EtIzf1+hZqgEVG87XpduDU0eElmUJiwxLS3BoigJu8lJc4DG0z9YlEiBJWnLqd2KtWdj9z0cTM7EDH2peJyj+2WV9hKoiHPd/bgbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfTMM6Gk; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfTMM6Gk"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f38so12303115ad.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789671144; x=1790275944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdWhhNtszMEmt8ITPevkH5iiNt1jxAGJIs212sri5Ao=;
        b=bfTMM6GkR00P5JXmdgW+cVM5WYqB4UgnJZwDd8vpV1mVSBR3+nRDYU++VkTVn3cXI6
         RKhuzfSYz5vsOcORnOBxR08fH+l94Hy7fWUblj3fnI2qPswdZ+suw4XirWhOt8MV39ba
         wj5SH84x9H0b4Bjiz4WIUVElv8/Y47CooTDRaeGX4my3FVgASlTG8NPpDdfv5cOoWtgm
         Thp4I9ptIcyMXLE3EwoysoVJi5wIRJ67KZd3z3dDcBMVvBeavG3OeBfR5W7OBHmne59O
         OzB4zlOreh/sDmj5CNjCetbbnRVm4Ye3nW14rg53lavxC9CHpKJGTacY5XHwgLbyS9ir
         iTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789671144; x=1790275944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fdWhhNtszMEmt8ITPevkH5iiNt1jxAGJIs212sri5Ao=;
        b=NNy+Qjxa+zcWuiEEwVLk9O/89q3507rpeGbOmEHQtYpm0ONx3uGAm/L9b3yvLp520v
         BfojywB9tQP9OrKDZR2Qq6PNNWMlYkEeou40G71WVBt4seOwdgUBf3AzmhhClo/ZvzUy
         5v2N1TVe7lijAfW8yrEMYInRIk49FET9/QiM+kDeJokcdvlSjiCDZkVN7hsoaLxZxPB5
         3waAoXZyi4KQVKu/mPRPXwBl0Q87fHFAFNp8D2MHJTWaqxwpTGIlnsE+cO0UeSORA+fA
         kKHBBUXTsfwMAkvoEh7R5XeeKZngwnJdyjlNlaR4vre74LnXSG1NoyGqlugvtA+DwQGF
         Lq8A==
X-Gm-Message-State: AFuF++lm6a7/F+0uhZEfo73+teMlTeFRJ0MajS/kbY6jcvqDRxgacXWm
	yPCt7CUE+mJ9dxIgJ8Od4acKidV7wWEFmZVRsNR6bTSoibeHU4V9wgdBSFn/RGFK
X-Gm-Gg: AYBFou0dyH4h1+QUrsbF0h/ySsq+691C4YAGSpicYBX+Jn+WIhbLfB04tj9nuoDS4Uf
	kVQiaYxprSj7DaZ0POciTvmTgazk5rmtwjq+Hvjj475As27KEIi6CHQPmKMKJs8elSs3U9rD2ZF
	Sg3xN6LwikWm/IzJljuQyTY+j5Gvq2pdwkXLaEM7mAViJLz69vavloEAGbjcVDWgRkeCrkcCtOx
	8BigT/Sv86HL6lNra3xAewUIayZ/jf38hkeb55TvUis7ZKvIbpge8QsW+y37WvbSOnlZ6jtgyjM
	SKDJPHNcpwY8r+nYQfDHLzOM4CfR9zMMfcFKKrWJQdOM6vrJSjjfZfiPISy/VadbXrZOHDu+ULQ
	O203i24clWA2OFd98FnxYSW3Hc4WZtgJJiviW5AeRJLxeL9U4wMaUcsdGIN7j1WCB2GIoyzvr+i
	Bt8cGQKCdCvPabG8gHwIJvtkpYKZbKLUKYNy0llFnt60ca7ULAqWk2tVQLNwgGoWyYwDUpdVkER
	yqqDL0HdhRXOLvpfuNTj5250w==
X-Received: by 2002:a17:902:c94c:b0:2d8:d4cc:be64 with SMTP id d9443c01a7336-2ddb1c196e8mr1602265ad.17.1789671144464;
        Thu, 17 Sep 2026 11:52:24 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f331b7sm31032655ad.82.2026.09.17.11.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:52:23 -0700 (PDT)
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
Subject: [PATCH net-next v3 7/8] net: dsa: motorcomm: Split MDIO bus module
Date: Fri, 18 Sep 2026 02:49:54 +0800
Message-ID: <20260917185010.3189199-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917185010.3189199-1-mmyangfl@gmail.com>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
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
index 7b61cab55e2c..491ba1edfa3c 100644
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

