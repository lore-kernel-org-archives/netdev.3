Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DD0385D90
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130028; cv=none; b=YGJJYxOdObTqLqjspJwSjdTu7Nmu3kJ8TXmVNQQwHdTh/fIFkekG7BX3JBSUE+SLtjeJ8SrGFIPTi2aoaluVNe0ZPh9lrYGQESftErwGqDWgGVmEeR6VXTOrcKfsdm4Ba+MYuUzOACHIgqzMpdaewt1eCTK6bKK2LJTOGdUOWSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130028; c=relaxed/simple;
	bh=xjUv0NwzYr0Oa3odjBrlzQpjLtYUWPN9ltEzFzeZgtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqsTcjQdtlyRSaNdKB7rBN42UY9r1qWEAITbHWEDxMoPjM/QnncuE6N1vi5n+p+NJtlkuc8wi9oq0mksbrcLvgbrbzK3vz94vfW0XFLuW76EgGZtOb2qXpGYf+7Ml1XnmscYFBH8GbkbrqGo5B58q/kJhaALx7r3ihNgJ5qVazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9ehQVyG; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9ehQVyG"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so254900a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790130026; x=1790734826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3yzwbr4GKjVvqORjzKamnj3DkZgDBWV6VbdLMWVI3w=;
        b=e9ehQVyGJwX0dYhou0kses8xqYsbH9w7eIt74eTLd0x8koejZ6S9cHx22MnmkhY35Q
         JcCzjig6mKfQpcXZbVURW8YYcHgSQMFdPFd0SLhEV+83XxzFRB3sfwOQrHgn7EEHavUT
         d6P+5fuPQP/QH0B5OjOn8AnuIDlt9fRZEl1uCAjePtg5A8t3W70x3dhaoL7It5yIhdZ1
         HXsK0qkHtzKPwaX+AEZJdM4YFX1F5LLe9pGU94BgQXHa5k0ki2tcowefQ8B6WdUoauWA
         N20z7mqcHehbaTaFCDruwSG1vkahejmYsyPg3ryLgRXrerqjTz9Rg9pdKYIv4NN3fucT
         3Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790130026; x=1790734826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w3yzwbr4GKjVvqORjzKamnj3DkZgDBWV6VbdLMWVI3w=;
        b=Thb3+mjtCHFmOXKKnRT6yu4i7XOjqsiXVvNdTITNmG9Q+gGR+O0eSJ+NEYgdX70l7n
         hlAIL4T/Vehns77j/bzA0DW3D0mYhexk/xXIMoruoBtly8CzmKSfRLWG1x6EDoh2q4ky
         RYcf5txKJXiTQzrwPucefoXLWpupm0cmzq2VWJQndHq063/1H7aXhwgyUJwBwhbqCbCO
         7g0pWQ0WNAb6j1iIHlDLVGr420IAVIw/OTTe2+g+9/EbuGXD9YFyBtXpV0+8dmNfzQwr
         7PXM5Ybi3iXWvrl7844/4YiAVC+YRKZvpTCXo8fXselmXp5JDmD6TylzXDEg68ABiz+f
         YfAg==
X-Gm-Message-State: AFuF++nnVC6tlXIDqzhxoJihqrnd447aSuJja5ZLzz4FwaBqs1PjMeAD
	24FCzfrPjIGYpRgf67yN3XE3ODgdz2Bz/p06cJAqmo+KsD5PummWzDUh6Owy1w==
X-Gm-Gg: AYBFou21FffdZSZUdOCA8845N6fnbqnA19skFDv4qJD15sRWNK85n08hS42diuMS0hn
	bOCH8fheORTmIsgsOWlL72JHCeA7SvWZY89RtCrFHCsWiAF4eFKGeN4z3qAjGsszWNCndgEOZCV
	7bSfmpzL4GDDRjIyEFLjgk7qQNikOVV0bj1QVz9GZaEwpkKc+bJjQtkVBd5HhG/sfa8MN/eijn3
	Iic5VTX2zClFMAk/ZLd0BvEHr7RSe/7gYt2QNq73WKKLBtAlj5F7VSZr0CGIk/966ezcHqdob7D
	pyjeQgBKwwH7re5NB3p/31DcovxnJy9KErLuUCDwGmt5TdJHhTE3zPC8gUq1HjvadJTLYZkdz8d
	5WgOIvPSwLPfu4rgC8WWL/q4ySLjt1hvlq4ifsc5Va0lM/g9eJTOvo/FVLau6N/2KUoktM+Ovo1
	xtOWQ8FCWK7Q9qWSrCfUTJbowzd77wJq2EJG3/e6RK2pUX7/MjXhxqemBhUyie5mJt679pszC3Z
	AfxFbW1XJDEPC4Lfel0xTi0
X-Received: by 2002:a05:6300:2788:20b0:3dd:fb34:7662 with SMTP id adf61e73a8af0-3ddfb34c3f8mr440526637.47.1790130025518;
        Tue, 22 Sep 2026 19:20:25 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fe8sm502924b3a.51.2026.09.22.19.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:20:24 -0700 (PDT)
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
Subject: [PATCH net-next v4 7/8] net: dsa: motorcomm: Split MDIO bus module
Date: Wed, 23 Sep 2026 10:19:39 +0800
Message-ID: <20260923021945.2203368-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923021945.2203368-1-mmyangfl@gmail.com>
References: <20260923021945.2203368-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split it in order to be used in other modules.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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
index ee433f1e1b58..6e1219ef05d7 100644
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
index 6a9fb27ddfb7..f68b77f815b1 100644
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

