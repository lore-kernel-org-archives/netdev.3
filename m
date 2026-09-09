Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53593545D8D
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980781; cv=none; b=b6gqsB4dm1x+tJPV5I2w1FJ7vhY/N/y0MHnoPDIRz0B2n1g4++fo8z/TK7OTBPppXroccWUsl521kFHVEolq1bchECThz9+ap0iQeAOn+BMTw4uJ2rgFl2WIt7DXtpne9h1I7W/LGNnKHY9Q45GtNkDaTYoJZcMc3a3A33Qi82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980781; c=relaxed/simple;
	bh=ZH7EisBsqh3RraTtw+YauM8M5TzkSbFw2ggz/xHw/wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6J4+QgkQEZBw4VIAdCjdHW8abjTSyp9bBffx/0oJmC4a/tdeuDKquKrDFmS3w3QU05rOIBqz2tEhB0PLHwdKXQZIx8uTpdDvIxjF8HNWVc/G/j+JLb6pZTBYaJfwTnCko/+69zyJy5L371dpi2SMbHjS1fOcO450brIUtJ7IvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG1uzRrB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG1uzRrB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d944747d41so69413635ad.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788980779; x=1789585579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRvc0Djm57SNFg95c8EgKAjqZ4dz9mEW4R04D0OlHVY=;
        b=DG1uzRrB103K7VHowZDWP0WdFswPVzDxc1IJlm7DblVacI1WFhbncE+YZggRqCid37
         gd/7M5IcwNAEHfGTS/gKrDIhNEEHfIrCChHkNNBMUlwjvAyZVJ3TKDemYQ2iDAx0a7Q/
         PvP7CCFERMHHMoYaavPTjmgNZuPRHWCR7KhCfk4S6BvNd7pOzUqYRk0uu4S0cVoU10M3
         +dCANzZfcti9N1GaeCGcUT7wZs9nN8DkVdD6TZIOrJ/N5Djr6YAjb0p7PvPXwcieDQbx
         ZTj+RhBGKKVBC+goTUHyAzAfsZs4G+2gWJYWQMrEuFgACMO74JwIu40V+oICOVTlx5As
         k7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980779; x=1789585579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NRvc0Djm57SNFg95c8EgKAjqZ4dz9mEW4R04D0OlHVY=;
        b=FI6iyKl5HVhyUjvoY6740MSBX0dat7ZMGwYOEyXBGdp5PqopqbOiHij74neniQ1QKk
         RLo+c5mxWJrQbsWD5KRP0775jPXj0Ju8LMeDxEMaCMxvejhT+68wHmI9D3Qk2uEIr7x8
         0Gvgul9K3istcDmYkBZBtZjZ+oOwDSMPesHYYticxOLeaPcfqOdwp1d5zWwlK9tsl/wK
         /Sle0PtkgX8jLgWYvRukPtvZdRx3O6n9uN+HOHngqCS3zYEk+XBc1pgaUcce3+GVz5Sd
         2/AJlNKSt4yIJ2SwhZRM0iNYZrGVQxIVE4J07s9ggjNZK81SHcXYJGyxCFXHZG8NZ9TL
         Iwew==
X-Gm-Message-State: AFuF++k49mQnHLHSZLnERnTXrjkbHc8Ev9PSAgJC63Htkm2fLeuidzTf
	zP9QD4isRmrlza63t4Mo29URptU+w6V98+3Oa+IQ7qXaMrB0waFd6XvLwb32GYodyrE=
X-Gm-Gg: AYBFou0OTPaL+qWVaXb+PHnt8wE4DygKa+b7z/Ozr5hoIqgZL8oW0/pT+pegTD1K9YE
	GG5VRBSH5KiLorYbDBfqp97UoXay21siDuOnKmh3nnQty9yYqr4uQMANYegyaJkcMREHqVDtdNq
	cQ9+hEID2smiUEmYrSGHADgrGFYbpsM5Zvz6EaoxR8/zLKwX53Mvcy8nQkHEPDTjhVnVAvMpiBu
	Iq5M6NPX9LwSq6MwWFMW9bUOZKymyFfs2jWVJL2ww06wW1ySt8+xc5/dLm4lEA8COziIUK9ydmc
	fMbf06E3zsiGRnKTCM5K6tR+xvJoQ5vzA6aQptqbDqkN0NKcQntvnUmB5E/YgNIk7uXaqfQjth8
	lJ3qJujFvDmqCtFjQxrD/TzqzWw/52kJgASTPcxnGbcBE6wFX9qk92yhcVDgB2nINIk8W+PiWEc
	g+k4Ofr5FVtR52yGn0PoxlJukGL7oltZUcYAb+9rDjMozjs//WcpsBUorHd7U67xZCTQ9ike5bS
	7loGieLSfZVLL0p2BM+jJZJxSgrH+4yQxs=
X-Received: by 2002:a17:902:c94d:b0:2dc:e272:bf27 with SMTP id d9443c01a7336-2dce272c0f6mr79705445ad.13.1788980778445;
        Wed, 09 Sep 2026 12:06:18 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4d0:7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dcffa9827dsm13988515ad.66.2026.09.09.12.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:06:18 -0700 (PDT)
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
Subject: [PATCH net-next 6/7] net: dsa: motorcomm: Split MDIO bus module
Date: Thu, 10 Sep 2026 03:05:34 +0800
Message-ID: <20260909190541.466476-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190541.466476-1-mmyangfl@gmail.com>
References: <20260909190541.466476-1-mmyangfl@gmail.com>
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
 drivers/net/dsa/motorcomm/mdio_bus.h |  37 ++++
 5 files changed, 317 insertions(+), 289 deletions(-)
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
index beeb08f2b000..85a31389050b 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -27,6 +27,7 @@
 
 #include "chip.h"
 #include "leds.h"
+#include "mdio_bus.h"
 #include "smi.h"
 
 struct yt921x_mib_desc {
@@ -271,274 +272,6 @@ static const struct yt921x_reg_ops yt921x_reg_ops_mdio = {
 
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
index b9a9e9d22d4b..21132a147d6b 100644
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
index 000000000000..261a71c637f5
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/mdio_bus.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_MDIO_BUS_H
+#define _YT_MDIO_BUS_H
+
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

