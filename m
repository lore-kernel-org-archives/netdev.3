Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AF4EB853
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200760; cv=none; b=XFe4B3kC3bGOWg/3z07AWWb+g1mz1+P+xQQrlpvF4qBE3Ls1CoFl8CJtiaXO/vUxa7USFob/Ic4c5VK3VguNRs6ImPW/DUk4Au4/d3ufMZNMaJzw7TBM+9RtrlmdzCNuLh9KattF1h/0YugR0LhpD1ueVKMcYk3qFQOnp8VbRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200760; c=relaxed/simple;
	bh=Y9sArGvG06fTxoj89o52hgoYE/AuOUlmcdKNh3A52M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRNKHOpZXBqm+v2xuNO1R/5rJVWca4OWUSFLJQ+RR+XQ+tRzoOPzsEwSfEn+//AfXxfanJccxQFQXrVHDd58dQGIey1OQnxv7TUesrOMgFXxuC69nPAtCDlywnu2TPTrL7kF5DzUjLMPxDLhNJWGegKKlStrNu0JQOgNTPn55mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgOFElSV; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgOFElSV"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa4c24cso228018166b.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200757; x=1790805557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfaWWRdlASqYfBci2TjPeC9jvASabRGvOwAX9IAIbN4=;
        b=BgOFElSV8Cb00qpqi9vVNT+HwBtABRl1duAhAjALaEicoA9H9QKQHRloEDJSaYrTe9
         iNIQ9hHD8HdyJy4tphV1tO65JRy/F1BlvL+4UmfAsVmuhdQQC73Hb1ngHy9sjnXc/6yh
         EtyRAX8SobeFU4lhQQstNCEvwRHKvFS5t6tPCVZgK49VgoIQwu+ZU7iRG+wNAqlZ0TRq
         HjJ7T2lZBqbZapowN8GQFW5ZmTnGm5xozfC2USUSzjXK5lqUtYXnCIY9QA4dxhcjIwem
         4nszfGIEgvcShlMKjxkHSHAkPbgbRfZRpooDIFC5e+M1IH2dSYohV6nYSUZwhULAhhsZ
         n7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200757; x=1790805557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UfaWWRdlASqYfBci2TjPeC9jvASabRGvOwAX9IAIbN4=;
        b=IashuKpiIibExMOXVQi0Vp1Yh5vVIRq+whjbmvKdj0j5VAixCuGUDfdWnHpy6E3u9C
         UPCNzAIfq5nCQ3ApnRVnHTZa0JapuKS1bIsTOOfizFana0quyw/PpycwX5ifiVUt+Q9J
         diuR2g0UTCxZ9OobNuGIiZZWbclQPw7VA/bMfEAbK5X3XZt5x44Oox3bRV4k18vSVaCG
         /P8fQff4vM2Ov008J5ZB+wC4ng7E0v+hX2sJs3ntrMNIK8Z62oYGQJsh8U+6Sdrf0yMh
         /p183pYg0T79BXLPLzFetdRiM4R6LfJYIAd5Lz9Btw9v6j3z7WVvLmvpC5j3R1HdyjiK
         dBlw==
X-Gm-Message-State: AFuF++n452l7o6CJoot6Pge8jJufvQAjZd/LbDUHUvnYXkbkmcE57MF4
	7K89dgLgy6rnCFEv6Xj10QQ4akjHIl8erb8G1ReArUPxgAGFJ7J5F+xTO0k9Bhsx9dgMMg==
X-Gm-Gg: AYBFou2Vzs/CIr3jx5Sm2shZW7zzBS68DmhfGdC+HT/Mjgmiy4dTCq5NlgYGTJFWdnn
	scxLI6Bqjk8ZmvFtxlpiWGJ7Ot9sEAvbul/rLG3bD7BY60ajfZbcbRbvXNpNVh3sfH7l+ct+dGS
	qMQSVcM451Isza9yX+gd5sosWkMz0EgetnxKcv0Ce+rku+WoFH2TZLdk3wjoT4n7IcfM1jO8QmE
	rT6E8xmWQcbqraSwzGFKE8emK2wjOMtOnKRHsGT6UroM7DbOFLZhhU0YOYFEHF07iZoeBmySwxb
	uTkK6fGjEpF/JZWrfQgKbDb4QRjB5hbW0Bkx7SWDCNy6XVrYZz2CCykgtjSeJUEGrrPN2KHaIAz
	TIXDfxnmgI9YUFyK/LWqQmEbTrwMQur3qJdzro7fP/Wm+7RO9AeY7TO5drIvzrtmH7n0Z9ec7LW
	uA0ekCegiMLdDSA/57V9lwlcAVj5ff+GclvhA1meaFBCNw6I/P0BXfcGn21QD7U+1COoPgSIH/w
	CgdoPkfwAYEtkcIggTade0y2dUD2FVJMBK3pcdVH/DfY4T5mQIxFYn2vGBbZrTTfav4dKeytTqE
	7tl4lfC3OvUl50J1Lal8DQ==
X-Received: by 2002:a17:907:a088:b0:c19:6104:e5e4 with SMTP id a640c23a62f3a-c2ac21fcbe3mr39259066b.20.1790200756904;
        Wed, 23 Sep 2026 14:59:16 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6dcf0dsm197647666b.61.2026.09.23.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:59:16 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [RFC PATCH net-next v3 2/5] net: dsa: qca8k: serialize CPU MAC pause during MTU changes
Date: Wed, 23 Sep 2026 23:58:54 +0200
Message-ID: <20260923215858.1653-3-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260923215858.1653-1-yongzhao.derek@gmail.com>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global maximum frame size must be updated with CPU MACs disabled.
The previous logic only paused ports 0 and 6, leaving an internal PHY
CPU port enabled while modifying the register.

Include enabled internal CPU ports in the pause sequence. Use the
existing reg_mutex to serialize the MTU update against port enable, port
disable, and phylink link-up and link-down transitions. Read and restore
each port's original TXMAC and RXMAC bits, ensuring ports that were down
remain down and preserving LINK_AUTO. Retain existing handling for ports
0 and 6.

Abort before updating the frame size if reading port status or pausing
the MAC fails. Attempt to restore all ports already modified, and report
any restoration failures even if an earlier error occurred.

The standalone qca8k MDIO error-propagation fix is a prerequisite for
this series; that error-handling bug predates this locking change.

Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
 drivers/net/dsa/qca/qca8k-8xxx.c   |  2 +
 drivers/net/dsa/qca/qca8k-common.c | 79 ++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index f9e2eb0b9..d8564001c 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1488,7 +1488,9 @@ qca8k_phylink_mac_link_up(struct phylink_config *config,
 
 	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
+	mutex_lock(&priv->reg_mutex);
 	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port), reg);
+	mutex_unlock(&priv->reg_mutex);
 }
 
 static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 13005f10e..6b32bdd75 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -463,7 +463,8 @@ int qca8k_mib_init(struct qca8k_priv *priv)
 	return ret;
 }
 
-void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
+static void qca8k_port_set_status_locked(struct qca8k_priv *priv, int port,
+					 int enable)
 {
 	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
@@ -477,6 +478,13 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 		regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
 }
 
+void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
+{
+	mutex_lock(&priv->reg_mutex);
+	qca8k_port_set_status_locked(priv, port, enable);
+	mutex_unlock(&priv->reg_mutex);
+}
+
 void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		       uint8_t *data)
 {
@@ -751,8 +759,10 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
 {
 	struct qca8k_priv *priv = ds->priv;
 
-	qca8k_port_set_status(priv, port, 1);
+	mutex_lock(&priv->reg_mutex);
+	qca8k_port_set_status_locked(priv, port, 1);
 	priv->port_enabled_map |= BIT(port);
+	mutex_unlock(&priv->reg_mutex);
 
 	if (dsa_is_user_port(ds, port))
 		phy_support_asym_pause(phy);
@@ -764,14 +774,20 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)
 {
 	struct qca8k_priv *priv = ds->priv;
 
-	qca8k_port_set_status(priv, port, 0);
+	mutex_lock(&priv->reg_mutex);
+	qca8k_port_set_status_locked(priv, port, 0);
 	priv->port_enabled_map &= ~BIT(port);
+	mutex_unlock(&priv->reg_mutex);
 }
 
 int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
+	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 	struct qca8k_priv *priv = ds->priv;
-	int ret;
+	u32 status[QCA8K_NUM_PORTS] = { 0 };
+	int ret, restore_ret, i;
+	u32 stopped = 0;
+	u32 ports;
 
 	/* We have only have a general MTU setting.
 	 * DSA always set the CPU port's MTU to the largest MTU of the user
@@ -784,25 +800,58 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 
 	/* To change the MAX_FRAME_SIZE the cpu ports must be off or
 	 * the switch panics.
-	 * Turn off both cpu ports before applying the new value to prevent
-	 * this.
+	 * Include internal PHY CPU ports as well as the two MAC-only ports.
+	 * Toggle only MAC enables, preserving the phylink link-control mode.
 	 */
-	if (priv->port_enabled_map & BIT(0))
-		qca8k_port_set_status(priv, 0, 0);
+	ports = BIT(0) | BIT(6);
+	for (i = 1; i < 6; i++)
+		if (dsa_is_cpu_port(ds, i))
+			ports |= BIT(i);
 
-	if (priv->port_enabled_map & BIT(6))
-		qca8k_port_set_status(priv, 6, 0);
+	mutex_lock(&priv->reg_mutex);
+	ports &= priv->port_enabled_map;
+
+	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
+		if (!(ports & BIT(i)))
+			continue;
+
+		ret = regmap_read(priv->regmap, QCA8K_REG_PORT_STATUS(i),
+				  &status[i]);
+		if (ret)
+			goto unlock;
+	}
+
+	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
+		if (!(ports & BIT(i)) || !(status[i] & mask))
+			continue;
+
+		stopped |= BIT(i);
+		ret = regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(i),
+					mask);
+		if (ret)
+			goto restore;
+	}
 
 	/* Include L2 header / FCS length */
 	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, new_mtu +
 			  ETH_HLEN + ETH_FCS_LEN);
 
-	if (priv->port_enabled_map & BIT(0))
-		qca8k_port_set_status(priv, 0, 1);
-
-	if (priv->port_enabled_map & BIT(6))
-		qca8k_port_set_status(priv, 6, 1);
+restore:
+	for (i = 0; i < QCA8K_NUM_PORTS; i++)
+		if (stopped & BIT(i)) {
+			restore_ret = regmap_update_bits(priv->regmap,
+							 QCA8K_REG_PORT_STATUS(i),
+							 mask, status[i] & mask);
+			if (restore_ret) {
+				dev_err(priv->dev, "failed to restore MAC state on port %d: %d\n",
+					i, restore_ret);
+				if (!ret)
+					ret = restore_ret;
+			}
+		}
 
+unlock:
+	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
 
-- 
2.43.0

