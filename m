Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8280501F25
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633336; cv=none; b=cktaEQ2PQDU5KPQ+daKYUnZwRb00C06w4R98iXAin14uIdBm1hahpexfHAXq/gZxADHbdmNXO9z7DHiMOwfuCyNjd1zfJHTuoJEcS6ufjPWLSzh3D/FyrE6xWSaszhcJEq3bsk5ScoDNlHPRbNRoQNb0jwuxpHlWzKL3Tkz5v8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633336; c=relaxed/simple;
	bh=VaM4NppZCxPXljhY/QlEyNMC+vJQVzidM1IwAqdE3M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwX8RXSZ6vmXRw7KjeH5ZiNhxrTzlk8aXujkhCsUDP+TQvrZpsIW3TNTnmT9w5jAt2gBoUN9FbMuiZc69fChHzyhnGsDSXE2+iUhamutuH0w8uUb/nOcsQpZuUOujad8Q+3dbrBpdAAd+BJzgZSN3JT0joXxJZPVXaP6ZL3CIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0RqD1Nw; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0RqD1Nw"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acac47206aso185147a12.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790633333; x=1791238133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z3V6DnUc5BNPjCgDYdl4mTlvDmy/zFhHy2cJzjNAFn4=;
        b=W0RqD1NwoNr4zjoE0hp7fhmvdI7ONeo+HdjnhEAq99f+cWsnfXCT7QMdfrjymsvpji
         KQD+ab+cFURhYdsXwcAfDUVPoR3eXALrpI51cjDoxWFcpJ3JZdWKVLPxz/n/2Yajg6at
         feJ+L9Zx7YD55W28CjiVDPksN7k7g0A+KtaPd1ir7VHb43F7lQs0pXovsxVVdMTmVWM9
         5KlthnXvWOwhSQNsOzdsNs8gmj1UPkfpVkcLcGmoxFyDLxv049ZKLkbePhsko+RN/f0A
         LZlgvaAVnJv6q5/RCbMoCGL7kqeFuHPbxeN5wq9bQbhCVnm7N5Z2wYStIhxGIieu3qQ9
         E0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633333; x=1791238133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z3V6DnUc5BNPjCgDYdl4mTlvDmy/zFhHy2cJzjNAFn4=;
        b=pCLmENK9AP1KfwxbbKkcc9zlU3n5klhy1xdR0lVVRzQIQjWgb6DLScfvnwL9aL84R/
         DzaJ/NOFvZN5JQzii7ZajDI9j9uo71s5+HzpwXFqRh9IlR6JAqx5KlnBpJzepnsEVRu6
         SiEkfgBSdew2YPHCyspezFl8q1K/U06XiFGrlbFSGj87VCmGG2KPoBQCcw04ZeS99HIE
         Qic3sqHaBs1kCPeHFeEzRl7wZf3crLuhZEGvz40bzOFw1qoMvKMXRwiOCMCdr7ycpor+
         XPCmF6NbYrNHvSGbRE3ZfM48px2Veg9JH3sCFVlp2gQ6tb2ealo+zbT8mKod1ElCikpe
         qbLg==
X-Gm-Message-State: AFuF++nhdmgcxzBTaiJ6gQA+JjF1ULNhoUJJzNdrM2ymZaNfQfdqV07s
	lk0y/Phskc2uFPVK68JKj14zIPADURecfFPXEnhvIlVu4CuSMEPL32jF3H4IRWsdNUwUaA==
X-Gm-Gg: AYBFou0JO1jLxXDPYWBbuzJ7zw+ahEXwxfYgmBov03ULG/xTZ1jk9QQGdtsOyJHXqWt
	SG6trnXa7MUqQAHbRSckaqJLlcEfmGwNvOUbwfrstrG64mtK42SBk7G5BkiKf7ENd4nW+vQUdzw
	S+Mn3/bB8TmvcPfYErW/CS6f0DNgoM//6ncdkTWKuLvdMeKw/naUFOOJnTrDLeBJyHZBEPxkexl
	AWN7/fKuLF6z80UV0o1M3JppkrYnuc0w4Q9bpeKjqcZqFbdgH6Z/d+TZq9LsQACnUVmJnSsuduf
	kOkybw46GFQ2Cv+Y7UO63M8tEK3BEv+KDKv6s50jACIeggP8Dif19TcLsxFe9QESh4GBaf6Md6/
	bU6OvXdmGo2JUDzLy/Sf2iE3VAHALdpmtdC8uhyax8t4HVHLcfA9qoRtN5DNmTxCMtKd3+x7mfq
	/bdqjYHcBG/RAmLhir385h/indzBQkRUG4bal/S7XDXeaKJjsOWam3fYbHvxDwbUB9X+GsajSH8
	lVy5e+bNNaNTADjY01/iH47v0NattnYjPpAoagDboKLMNG7BteVAeSq
X-Received: by 2002:a17:907:6a16:b0:c2b:eb1:ac01 with SMTP id a640c23a62f3a-c2b0eb2a6e0mr715857466b.41.1790633333053;
        Mon, 28 Sep 2026 15:08:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:c07a:9093:1956:b4bf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bcacfsm345002466b.74.2026.09.28.15.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:08:52 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH net-next v4 2/3] net: dsa: qca8k: serialize CPU MAC pause during MTU changes
Date: Tue, 29 Sep 2026 00:08:10 +0200
Message-ID: <20260928220811.1880-3-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260928220811.1880-1-yongzhao.derek@gmail.com>
References: <20260928220811.1880-1-yongzhao.derek@gmail.com>
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
index 89113d22d5d..7bd9d9abcef 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1495,7 +1495,9 @@ qca8k_phylink_mac_link_up(struct phylink_config *config,
 
 	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
+	mutex_lock(&priv->reg_mutex);
 	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port), reg);
+	mutex_unlock(&priv->reg_mutex);
 }
 
 static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 13005f10edb..6b32bdd75ea 100644
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

