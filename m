Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62E04570CC
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253778; cv=none; b=A5+OeHCbvQPoqkPTZ+l5m9id6Y/bSrcMP9YH3JOOJBnRQqPusHUmhS6hPWUzQPATy763p6fnH2F4vU/vIJ31s44PEOgz7bs/K9yHM4FN+TFVTGpM99/xCwmzGcMkHYhmGhZFSAg+6/7rrT65Dbqpf92lhq5G4Nz9uSEdQpdHsi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253778; c=relaxed/simple;
	bh=aew3G0wQnA+cl/zvznbqylIu4hIFGHINCMdxlwCnhLw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFZ9kVzxS5oPkf3tOzy0SLOVeHYxi5pLaFmRZwp/1VzbyrKt+F/6mM0hnBxHvKDUMERvrliwpoq9IEPbOPO+N2YjMoLhARkyjsW8kt7RWRMcyOq0heEnw7dV+dPgGbZkGzdK3wYc6yM4GcWZTDGlVGIUdkn02aJT9KBahZPCy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyBc+k1D; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyBc+k1D"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so6294765e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253775; x=1785858575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SYjaVLSyECwhZTYecx4FhraqJDr8W4MzrHZKpg3sjsI=;
        b=VyBc+k1DhddiR6RXW1ftp1ZzT1pXGxXCJTkjEVeX3nNq2dB2a+utpUQW31ZdtLb/jg
         P1b7tUBOR1fetitb/gSWJ3Y5w0WgnW9M78NggY08aG5b1Ar+voApGbCCHSoYs5po6aZV
         THUbDqA3V9rMIJ5ttrJcmFtg0Qi1xIKCpgl3b4kGjO0IJF/LDlyvdgH5v0CWISYfamU1
         ZjLBHYZzvB+RXETS4++nrGEQLFn6ots+GQhGtCi6XDvgv1SBw4XHSV2FjnaNV2gXBKr9
         J5vHni/WQV28RA7D6cGPX3s8kWCfqlTNmpFeRF/50JLUPakNCEycVo2Wb+AwwyFVS9r+
         XcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253775; x=1785858575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SYjaVLSyECwhZTYecx4FhraqJDr8W4MzrHZKpg3sjsI=;
        b=WwTy3GGAbMsXXDaUZUfWnWNooe+XB7ysad/xKONV5zni7CCR1DWG1Cbg9OuYu0zrHV
         QM5AtaVw0Njf7F4NeVGEqqso4LukcfW29JQm/4K7rThP9XxSIGeeLVKXz9KUarKRWGfR
         XQ3ZKF0A3RcaukZNT50mxwchirpNKEyTakTe+DfwuunSn3dtaiB/59FwYpHmM6YbxFLE
         L8o5uLoF5/yoXu5lH3OQG3Q7nh8pCLVnPoS3avtwPxkOQ9cKKMXtvpREXvTwhl3m8iOZ
         Eof0WovAk9v7K78+wYiNjXBYPJRHVtxctp3MfIKjTe3PnEeCU/HvHz6yZFR54D32hoqq
         9LCg==
X-Forwarded-Encrypted: i=1; AHgh+RotKhKimPjc4m3ZpNlrlnwZJX03xV46oon69kpuUnseuggrRmkfjpAdbXIK5DQGmcU4xnN7q2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWxOrW9e7hbd2tayYpSUnd3vUWpCR1+3cKURywEHT9M2GnzwP
	cbeiIb4wUD825S9LriKIbInSYfpuRwyNztpzXDIeZDJp7UqBcWvQU/Xc
X-Gm-Gg: AR+sD13kaGivUO5IVPDVyXLa06gtIIDMesutq/xsuiOzmCv5bqIz67w5WwUJbN9oUVy
	keiTrne8NXPkgdrZYcCPi9OZyEUX/pWeRJdW5bGUi+hF/MZeIsjV0kJB7/bWI7lGfeZHNAVan5F
	/rQxG5nBY81xHBQ1wNZr8QtfStL4z8K1+W3C2a7JT2FC1ou7nE5m3SUIqpax/CK6+UffWvT6MCO
	voun/hmlGQmRmP7aYOgK+DZms1RFWbEDqjnUG9rga8bY0tcr68um4PocZt8Hl2Pc9TrsDX/KNJ8
	mf3oNOodMxZn/SSdPp+ratVIVbMQJmSf2i7OmK/6CQM+qwYphxES3rLO6HP5VL61G6edJH7RHG9
	eHy1Z5OdgBMUYumZoZyiMypFihqawsFIIoiUn52yz+/h4l46rX8F8oXvHB5Zn+bs4KasYfFBJxU
	0aUyBLb2JG0fv1D9vXfdiIMSkM5gyw
X-Received: by 2002:a05:600c:4584:b0:495:501a:fcf8 with SMTP id 5b1f17b1804b1-496c6575c60mr30023435e9.9.1785253775035;
        Tue, 28 Jul 2026 08:49:35 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain ([37.161.95.51])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-496c4632263sm94912035e9.15.2026.07.28.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:49:34 -0700 (PDT)
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
Subject: [PATCH net-next v19 08/10] net: dsa: mt7530: move MDIO bus locking into regmap
Date: Tue, 28 Jul 2026 17:48:35 +0200
Message-ID: <20260728154846.1828945-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728154846.1828945-1-ansuelsmth@gmail.com>
References: <20260728154846.1828945-1-ansuelsmth@gmail.com>
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
 drivers/net/dsa/mt7530.c      | 38 +++++++++--------------------------
 2 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 11ea924a9f35..f7c8eeb27211 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -141,12 +141,14 @@ static const struct regmap_config regmap_config = {
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
@@ -200,8 +202,9 @@ mt7530_probe(struct mdio_device *mdiodev)
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
index 3c2a3029b10c..5f56a423b147 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -184,11 +184,7 @@ mt7530_mii_read(struct mt7530_priv *priv, u32 reg)
 static void
 mt7530_write(struct mt7530_priv *priv, u32 reg, u32 val)
 {
-	mt7530_mutex_lock(priv);
-
 	mt7530_mii_write(priv, reg, val);
-
-	mt7530_mutex_unlock(priv);
 }
 
 static u32
@@ -200,15 +196,7 @@ _mt7530_unlocked_read(struct mt7530_dummy_poll *p)
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
@@ -224,11 +212,7 @@ static void
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
@@ -555,7 +539,7 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 
 	INIT_MT7530_DUMMY_POLL(&p, priv, MT7531_PHY_IAC);
 
-	mt7530_mutex_lock(priv);
+	mutex_lock(&priv->reg_mutex);
 
 	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
 				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -588,7 +572,7 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 
 	ret = val & MT7531_MDIO_RW_DATA_MASK;
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -603,7 +587,7 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 
 	INIT_MT7530_DUMMY_POLL(&p, priv, MT7531_PHY_IAC);
 
-	mt7530_mutex_lock(priv);
+	mutex_lock(&priv->reg_mutex);
 
 	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
 				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -635,7 +619,7 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 	}
 
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -649,7 +633,7 @@ mt7531_ind_c22_phy_read(struct mt7530_priv *priv, int port, int regnum)
 
 	INIT_MT7530_DUMMY_POLL(&p, priv, MT7531_PHY_IAC);
 
-	mt7530_mutex_lock(priv);
+	mutex_lock(&priv->reg_mutex);
 
 	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
 				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -672,7 +656,7 @@ mt7531_ind_c22_phy_read(struct mt7530_priv *priv, int port, int regnum)
 
 	ret = val & MT7531_MDIO_RW_DATA_MASK;
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -687,7 +671,7 @@ mt7531_ind_c22_phy_write(struct mt7530_priv *priv, int port, int regnum,
 
 	INIT_MT7530_DUMMY_POLL(&p, priv, MT7531_PHY_IAC);
 
-	mt7530_mutex_lock(priv);
+	mutex_lock(&priv->reg_mutex);
 
 	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, reg,
 				 !(reg & MT7531_PHY_ACS_ST), 20, 100000);
@@ -709,7 +693,7 @@ mt7531_ind_c22_phy_write(struct mt7530_priv *priv, int port, int regnum,
 	}
 
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -1444,8 +1428,6 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
 
-	mt7530_mutex_lock(priv);
-
 	val = mt7530_mii_read(priv, MT7530_GMACCR);
 	val &= ~MAX_RX_PKT_LEN_MASK;
 
@@ -1465,8 +1447,6 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 
 	mt7530_mii_write(priv, MT7530_GMACCR, val);
 
-	mt7530_mutex_unlock(priv);
-
 	return 0;
 }
 
-- 
2.53.0

