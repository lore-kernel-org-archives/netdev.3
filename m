Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053845;
	b=dmy6aleCRnX/NsvQu1q72+9NuDgbOUtM597w/seswOp1P1gWzhwMxPk4bRtsmh1uI8Mt
	 IahtS1/lOYO5TZM7fEIs+Bne2L1VUvXvaYcaiC50kyur5E7a0cmOsIQEoe3oItnljHW9J
	 jfeWJsY7QDbHPGYW9FGL3Mv6A3Qm/tCrzuj67b1KT/JmKCzwIOzERLK1eIAHDx1BhJSuJ
	 ljT8lY8cifN7/dZfo2XJhdGItzYcPcP8DL2+JA/E/CvY6qwCcsUQ/tnRLZKrRPS0lb8j8
	 Slpnj6dZuge2auWV3TB38RtA7yktpu+UrdwNDQ2Dk8mqhHDJNpKoPrCmlq8+PJ0ahQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lh4p54ENGltKCdS7NjGeds5Ujsc0z1KtVefTgWHitfM=;
	b=ehW8XeZQZN1RBd7PlSH9PRjNM5GHUXNMMDWaw7JT+PKpaOvUDyqbKplO2B97I5R5xpbk
	 +Tl+f8SaLfvEL9Vo6NsXLXy+1ugzlbKs0OdbBPu/pU6/kI1jAbaWGsLo7i33aacqAM6Ui
	 xcFZGM0+2l/ZbaISytXDG/vajDuOJLJjxrc//RnOGcYoZxmUPo9PBGURKp6Xji2liNxx1
	 D5StEF4ribbS0yf2+V0vcvrDrdp4vyMvgfhp77/YEXYFUcuRy66tpJvVQMFQ60vpLYZVR
	 VtCE2lGasogD89MpOkvzlLYhMNDdBJTUPh/QFHirnbjvvzzdKBcM1uQc7nudKiErLoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQ+Gvoyi;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B7606A33B
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 747B7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQ+Gvoyi
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ed28bac8d7so1818125ad.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053845; x=1794658645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lh4p54ENGltKCdS7NjGeds5Ujsc0z1KtVefTgWHitfM=;
        b=FQ+GvoyibS7bsQ4T+tZjXoPsQ31uzSKWfBCxPEM//YhLm8dggpzLNFxFMwVDUzdaeu
         gt29EU7c5R4RMWQJ/Bo/QR6bzOoVT0VN6n6EB9iPw1pXAJ0IaNELkEKMCdQbdzTsptVw
         VfAW3EPHaVvrnGVKHqVAgRzAw/DwwydX7x8oF0lV/gp/5QQoWnEdmFBP5767Mmdeuw1N
         J9VD0ZnC6jB/pQ0Kkj1FXPyEUcFdJq5NnE+aGI4Nv1qIdrdo0FhTIqVEZqjKZEiqkstF
         drJ6XQqYgwVVOv+jRZpymPNxMwXQtFHuXLc+NLqn8ph0YpXzpYN97g7/AmnbUzUaqEKl
         VOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053845; x=1794658645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lh4p54ENGltKCdS7NjGeds5Ujsc0z1KtVefTgWHitfM=;
        b=kyAE9FSiYxRHPElk99utGOsHH8/lsbDWnqOLqvS9QlUTRWbPQKIOm9uUy9mnhPTOWW
         FT6J52npFY1ALjBOu9oSRhodHTCuxI1n9cNTJyhZxrbhKYl4Sbmz10rw++SblirCdu+7
         cBI612v1cS0ftDbB8eoJ1pUQi7l1GlwRv84VnQfiG/YcENAexTSXtuIafetyZwKB+Rqx
         TYE1gSQLwtZCAO+3IwZiTGxl1j+FN/y8+X2WhG5AQMSZjwaZTMIgYFnwkSbobvGtTfkd
         gn4fRX0LoAc3VXpZbz8TQoDVZ7Gl6cKhewBNhkNpU1XgnP9MbNinrjzODz0mYJrP735r
         6Z5w==
X-Gm-Message-State: APuU4Z8hXdGP4IdQTwL9MyTdRHQ23h02st6Y65YIbXx1Zk2cTRLFYijK
	owQ6fnaQDoXamfgi8604xyWqTF4fTJd/fpa5wsjDWZWu7YkrigTmiZkMYqNYpA37UaE=
X-Gm-Gg: AYBFou0AWmhMswvVkmr/deH5yWm03XpkCyfTgNpyF1T3no+EKrU0qvmXzMdO8byNvbw
	/279/IlTfskmg0tQFIxCzJGHWYnZg1whuHEko9mzbCbJw/EPy4tMoC/EUMrRoRv4KkP7/wjDzWP
	ZeL+ciOQYX7RZlMN3KnT9sh6uJwAgGAoG9DtCIjoRlZZ8lO/04LwTlsT9kL3BXmDm9ppcxROe4A
	3HcncqSFShyKrMIp1IhLokspC9uTXwp1kOdRUrdLEN3QJrB2usgF6IdisTCpTz8FtxWtZ+zl6By
	ygnjb/4Vu9bUItqXAD1z8FoxMl3FbCci9B22A9TJ6fPdKyQGqW6gqAkScGxjNPoWkKBFLqduUH1
	tVHBZLnN0o78kxPzy2npaJ7fhyRfJ1wgx6s0j1Xfak2UFwoLV/A2hc8oieipvU6SVAs/p72I3nN
	awtuoLN5klvkCNiIhqqecstY7WlyewNfom0e+aLW5JtlrgOaK+VfVVTMATT3dA9STZcoi/r5zzS
	D3Hw3P/jeXcbL+dshvRc1sUGiv8lk32pKO9Go8S8OVtzI7ppUWahxw6WA9zb6WDlzUPxO+a3LIo
	x4BEbV1tgHaU4QociTLXrBIgPitHWfpbEAwk9sDKv4a4Do4XzrodEA==
X-Received: by 2002:a17:903:19cd:b0:2dd:c053:b9cb with SMTP id d9443c01a7336-2ed67be851amr13551035ad.28.1794053844705;
        Sat, 07 Nov 2026 04:17:24 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f35asm12773555ad.49.2026.11.07.04.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:17:24 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 4/8] net: dsa: motorcomm: Remove local cpu_ports_mask
Date: Sat,  7 Nov 2026 20:16:25 +0800
Message-ID: <20261107121631.1040612-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107121631.1040612-1-mmyangfl@gmail.com>
References: <20261107121631.1040612-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dsa_cpu_ports() or dsa_is_cpu_port() instead for a clearer view of
code.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 18 +++++++++---------
 drivers/net/dsa/motorcomm/chip.h |  2 --
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index c51491ef4dae..8ab499611fbf 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1003,7 +1003,7 @@ yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagged)
 	u32 ctrls[2];
 
 	masks[0] = YT921X_VLAN_CTRLa_PORTn(port) |
-		   YT921X_VLAN_CTRLa_PORTS(priv->cpu_ports_mask);
+		   YT921X_VLAN_CTRLa_PORTS(dsa_cpu_ports(&priv->ds));
 	ctrls[0] = masks[0];
 
 	masks[1] = YT921X_VLAN_CTRLb_UNTAG_PORTn(port);
@@ -1159,6 +1159,7 @@ yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
 static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 {
 	struct yt921x_port *pp = &priv->ports[port];
+	struct dsa_switch *ds = &priv->ds;
 	u32 mask;
 	u32 ctrl;
 	int res;
@@ -1169,7 +1170,7 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 	pp->hairpin = false;
 	pp->isolated = false;
 
-	ctrl = ~priv->cpu_ports_mask;
+	ctrl = ~dsa_cpu_ports(ds);
 	res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
 	if (res)
 		return res;
@@ -1215,7 +1216,7 @@ static int yt921x_isolate(struct yt921x_priv *priv, int port)
 
 	mask = BIT(port);
 	for (int i = 0; i < YT921X_PORT_NUM; i++) {
-		if ((BIT(i) & priv->cpu_ports_mask) || i == port)
+		if (dsa_is_cpu_port(&priv->ds, port) || i == port)
 			continue;
 
 		res = yt921x_reg_set_bits(priv, YT921X_PORTn_ISOLATION(i),
@@ -1232,7 +1233,7 @@ static int yt921x_isolate(struct yt921x_priv *priv, int port)
  */
 static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
 {
-	unsigned long targets_mask = ports_mask & ~priv->cpu_ports_mask;
+	unsigned long targets_mask = ports_mask & dsa_cpu_ports(&priv->ds);
 	u32 isolated_mask;
 	u32 ctrl;
 	int port;
@@ -1345,7 +1346,7 @@ yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 			u32 ports_mask;
 
 			ports_mask = dsa_bridge_ports(ds, bdev);
-			ports_mask |= priv->cpu_ports_mask;
+			ports_mask |= dsa_cpu_ports(ds);
 			res = yt921x_bridge(priv, ports_mask);
 			if (res)
 				return res;
@@ -1417,7 +1418,7 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
 		return 0;
 
 	ports_mask = dsa_bridge_ports(ds, bridge.dev);
-	ports_mask |= priv->cpu_ports_mask;
+	ports_mask |= dsa_cpu_ports(ds);
 
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_bridge_join(priv, port, ports_mask);
@@ -2275,10 +2276,10 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	int res;
 
 	/* Enable DSA */
-	priv->cpu_ports_mask = dsa_cpu_ports(ds);
+	cpu_ports_mask = dsa_cpu_ports(ds);
 
 	ctrl = YT921X_EXT_CPU_PORT_TAG_EN | YT921X_EXT_CPU_PORT_PORT_EN |
-	       YT921X_EXT_CPU_PORT_PORT(__ffs(priv->cpu_ports_mask));
+	       YT921X_EXT_CPU_PORT_PORT(__ffs(cpu_ports_mask));
 	res = yt921x_reg_write(priv, YT921X_EXT_CPU_PORT, ctrl);
 	if (res)
 		return res;
@@ -2315,7 +2316,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	/* Except for CPU ports, if any packets are sent via CPU ports without
 	 * tag, they should be dropped.
 	 */
-	cpu_ports_mask = priv->cpu_ports_mask;
 	for_each_set_bit(port, &cpu_ports_mask, YT921X_PORT_NUM) {
 		ctrl &= ~YT921X_ACT_UNK_ACTn_M(port);
 		ctrl |= YT921X_ACT_UNK_ACTn_DROP(port);
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index d9425afc7bce..ab6f28d057cb 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -509,8 +509,6 @@ struct yt921x_priv {
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
 	unsigned int port_shape_slot_ns;
-	/* cache of dsa_cpu_ports(ds) */
-	u16 cpu_ports_mask;
 	unsigned char cycle_ns;
 
 	/* protect the access to the switch registers */
-- 
2.53.0

