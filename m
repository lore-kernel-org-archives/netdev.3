Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FA3C10B0
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954863; cv=none; b=tq3/Ix9M+Y/M9Dzh0iziukg4r5/t2S1JaQNmiRowirP3CgUUmi+uKP8VnITzs0m9NpIxOjAeiU7+OAzYG3xoe2bkIEgc+qqb21ytP5YmYU8L03h88txOaV9UEwpHwqtntCHGY0FZDtBcmDj6hDOfxpbkYYdOri36rLzMZFYAlfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954863; c=relaxed/simple;
	bh=6DeTG1xa/Ln65H62/4x+LMvP9NB1O1vI5av2V+UqGgc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tU/+Wly0kquk5JTNHEgZvL5khGXUrYa5g2eI50ZpYgenumkcrXhYlHr4o15HVSjSNk4UWNEsLK7Cab1YWlO+w2c2nObueC4qkqIS0PbnZnWg0l79x/mzt27Cgex/zRdv2SLQqXu+2Yu9Ww5qEaxt36WeC/KYwhqai4QGGh1bpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1ZWt3Rb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1ZWt3Rb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b966dd74so20231445e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786954859; x=1787559659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M9T+8NIUGYBAR6mlNIug3Q6VvqG8vRRPcgCMH1v4erc=;
        b=h1ZWt3RbtEKmpSoQHBc0SpnqJu31W1F4G9yQyZ7KJ1TlT71RGr/BQFh/qGvJw9GZIf
         FnW8gFOXMEoBr0G3RFp31a8TrPGOe/ZmgWO1G903tc4FmNF11Z5ypZasE0laqHRNk0W7
         HHwn3h7RrusD3ZKk4H5GAGJrAG2KJg5nvKsUMxt9m4Y1mDPpK5oDTpxbAIIlnBtacQoi
         9xIcxQfXbZ4jlUuC0n8aN8bWEWW8eghzpJX1F8td2v6BvF7R8QdBTo+0190EdmcKfix5
         M35omAURQkxfVAQbYll93IVVvvuXhRRMStlN0y4bvBWgKtNMCcaeVlxLZrboF2BACDAY
         zW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954859; x=1787559659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M9T+8NIUGYBAR6mlNIug3Q6VvqG8vRRPcgCMH1v4erc=;
        b=YknFlSXtI6HWe6sR93yylqA7RMSfA7MbQiK/w3Spahkp4C3TveBbEGTOCnuIgxGoJf
         p6EqFM6uy3BWRUH9Ox/cVrYLQNAQLPHyXHZyrfCSjtJszXzWjOoOU8f7muYXJFn0ywLQ
         PgjSpI5ytEeuPBw0RvbLu1ZF99zLbsE6MWHX9w55GkICk7YJ1UwZb8pzPdd7DgkEsthi
         gRcIGuaqVbKHOYMYadHD4mWTW0Ptkkg6UCWQp72yB5llRke84GH1nQ+sbTX10fdEJNDJ
         0Jwj3idTTMA6h73QV7+eSVKjngHxMPe8nmnG659eennMPc8Y4b6OQ5XQJlnq7ZrkucV5
         xn3g==
X-Forwarded-Encrypted: i=1; AHgh+RrxVoXKtVY5zeh181WfcvmWrZJzAuK1i6eKDfCTI4Yhc82F41fRuJK2lWhQ5xcgW8EHkY/5P+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpORueSU77ipnrihBeSxHJZ+QjtzlWF/43y1h8RyyMiAjC9STr
	xLekMeyS142dPpgn5eK4s1FwoClovw5OHfakQrsYXuLMvjIxuIzlin9+wzn6n5An
X-Gm-Gg: AR+sD10MaxoNydJxKLlzWUkcdRGDRK4EkQXJTKzTjp/GVzrwRQ5GX+agpmiIuiqCCpb
	QMS9bhEn23MchBZJ4y6ZP8CW0pH6SzmmhPt/a6jc5AQRI8Do7g5oAi8gq4dpSCqqEISi0flf8kr
	1JWtJ36qPhunRx23+jd9uwwewrC4XdkCMgjcuGa3tBsTFn5vf0jSTk7V3YuMS/lLbSyKSkijsXn
	1xh+icfo31Wu8vp7xgHsUx3SOYJjE6qvS2gAf0jTotm27VDID5nOJM9ClvK2mZ8q+z14BeUSBnS
	Fd1z3ddwGEw7h97obmWqLHQCf2yi6H+hZaCbzVTTo+z6PTiDbWVSse8ygvIzfL9WOqKmYoDt2vT
	dmvdUdeaPnywKoMZv5ff5eMGNdNCybYD/rKMhjG7xOHo3+jQNWvp9xtCPFvDqjRhdq/wBcvkx1O
	EQVy0xzJoxevqVtBoMXMu1ol1FPDUfdw1Ubdk8loCPgpvRX2bRKOId3XnlZRenLKSsBZpd3wGgW
	QC+cWj4QbjQBYhE0X4VIrdv9cwHJNau08Na+5OSBX9e9OTlyBX9kDp2x4nsUqL8/wE=
X-Received: by 2002:a05:600c:4f52:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-4998793dafcmr362760695e9.7.1786954859332;
        Mon, 17 Aug 2026 01:20:59 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-40-190-175.business.telecomitalia.it. [79.40.190.175])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4999d078517sm19684195e9.5.2026.08.17.01.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 01:20:58 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v20 08/10] net: dsa: mt7530: move MDIO bus locking into regmap
Date: Mon, 17 Aug 2026 10:20:30 +0200
Message-ID: <20260817082034.20326-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817082034.20326-1-ansuelsmth@gmail.com>
References: <20260817082034.20326-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Golle <daniel@makrotopia.org>

The switch register regmap was created with .disable_locking = true,
relying on callers to manually lock the MDIO bus. Move the locking
into the regmap using .lock/.unlock callbacks, matching the PCS
regmaps that already do this. This allows any code path reaching the
regmap to be automatically protected.

With regmap handling bus locking, the manual mt7530_mutex_lock/unlock
wrappers in mt7530_write(), _mt7530_read(), mt7530_rmw() and
mt7530_port_change_mtu() become redundant and are removed.

The MT7531 indirect PHY access functions need serialization of their
multi-step register sequences, but no longer need to hold bus->mdio_lock
across the whole operation. Switch them to reg_mutex.

core_write()/core_rmw() are the only remaining callers of
mt7530_mutex_lock(). They access TRGMII core PHY registers via the
clause 22 MMD indirect protocol -- a separate register space that
bypasses regmap and needs manual bus->mdio_lock protection.

Generated using the following semantic patch:

// Remove mt7530_mutex_lock/unlock around single regmap-based calls.
@@
expression priv, reg, val;
@@
 {
-	mt7530_mutex_lock(priv);
-
 	mt7530_mii_write(priv, reg, val);
-
-	mt7530_mutex_unlock(priv);
 }

@@
expression priv, reg, mask, set;
@@
 {
-	mt7530_mutex_lock(priv);
-
 	regmap_update_bits(priv->regmap, reg, mask, set);
-
-	mt7530_mutex_unlock(priv);
 }

@@
expression p;
identifier val;
@@
 {
-	u32 val;
-	mt7530_mutex_lock(p->priv);
-	val = mt7530_mii_read(p->priv, p->reg);
-	mt7530_mutex_unlock(p->priv);
-	return val;
+	return mt7530_mii_read(p->priv, p->reg);
 }

@@
expression priv;
@@
-	mt7530_mutex_lock(priv);
 	val = mt7530_mii_read(priv, MT7530_GMACCR);
 	...
 	mt7530_mii_write(priv, MT7530_GMACCR, val);
-	mt7530_mutex_unlock(priv);

@@
expression priv, port;
@@
 	INIT_MT7530_DUMMY_POLL(&p, priv, MT7531_PHY_IAC);
-	mt7530_mutex_lock(priv);
+	mutex_lock(&priv->reg_mutex);

@@
expression priv;
@@
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/mt7530-mdio.c |  9 ++++++---
 drivers/net/dsa/mt7530.c      | 36 ++++++-----------------------------
 2 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 784dd58a7158..422f785d2143 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -148,12 +148,14 @@ static const struct regmap_config regmap_config = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = MT7530_CREV,
-	.disable_locking = true,
+	.lock = mt7530_mdio_regmap_lock,
+	.unlock = mt7530_mdio_regmap_unlock,
 };
 
 static int
 mt7530_probe(struct mdio_device *mdiodev)
 {
+	struct regmap_config rc = regmap_config;
 	struct mt7530_priv *priv;
 	struct device_node *dn;
 	int ret;
@@ -207,8 +209,9 @@ mt7530_probe(struct mdio_device *mdiodev)
 			return PTR_ERR(priv->io_pwr);
 	}
 
-	priv->regmap = devm_regmap_init(priv->dev, &mt7530_regmap_bus, priv,
-					&regmap_config);
+	rc.lock_arg = &priv->bus->mdio_lock;
+	priv->regmap = devm_regmap_init(priv->dev, &mt7530_regmap_bus,
+					priv, &rc);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2b7be091c056..d01772cfe3a2 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -188,29 +188,13 @@ mt7530_mii_read(struct mt7530_priv *priv, u32 reg)
 static int
 mt7530_write(struct mt7530_priv *priv, u32 reg, u32 val)
 {
-	int ret;
-
-	mt7530_mutex_lock(priv);
-
-	ret = mt7530_mii_write(priv, reg, val);
-
-	mt7530_mutex_unlock(priv);
-
-	return ret;
+	return mt7530_mii_write(priv, reg, val);
 }
 
 static u32
 _mt7530_read(struct mt7530_dummy_poll *p)
 {
-	u32 val;
-
-	mt7530_mutex_lock(p->priv);
-
-	val = mt7530_mii_read(p->priv, p->reg);
-
-	mt7530_mutex_unlock(p->priv);
-
-	return val;
+	return mt7530_mii_read(p->priv, p->reg);
 }
 
 static u32
@@ -226,11 +210,7 @@ static void
 mt7530_rmw(struct mt7530_priv *priv, u32 reg,
 	   u32 mask, u32 set)
 {
-	mt7530_mutex_lock(priv);
-
 	regmap_update_bits(priv->regmap, reg, mask, set);
-
-	mt7530_mutex_unlock(priv);
 }
 
 static void
@@ -597,7 +577,7 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 
 	ret = val & MT7531_MDIO_RW_DATA_MASK;
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -645,7 +625,7 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 	}
 
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -681,7 +661,7 @@ mt7531_ind_c22_phy_read(struct mt7530_priv *priv, int port, int regnum)
 
 	ret = val & MT7531_MDIO_RW_DATA_MASK;
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -717,7 +697,7 @@ mt7531_ind_c22_phy_write(struct mt7530_priv *priv, int port, int regnum,
 	}
 
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -1452,8 +1432,6 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
 
-	mt7530_mutex_lock(priv);
-
 	val = mt7530_mii_read(priv, MT7530_GMACCR);
 	val &= ~MAX_RX_PKT_LEN_MASK;
 
@@ -1473,8 +1451,6 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 
 	mt7530_mii_write(priv, MT7530_GMACCR, val);
 
-	mt7530_mutex_unlock(priv);
-
 	return 0;
 }
 
-- 
2.53.0

