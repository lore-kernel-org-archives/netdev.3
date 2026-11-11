Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357011;
	b=ITsgl66PJi8/kTKPpGqQ+W4xkT01aa/S58Ogn/9ohXO3Ow1yP8wUOWvPkSNUYxrptX93
	 cD7nnmURyGBpogOBV8kRXVivpa5LWQRhToODG+sZhaOn7J2zBTl88gVQ/YluQhBziFJND
	 NMcO0nccX52iUlOv+m4JAVzCdnTca5cwY7EU2Xf7JFF7TcBAQJHnwvcHMvf4hROp3WjRm
	 TuhxK2mVQAEKCwEjQy0yucYkEPlGGEUfbUAK3oajMxWMSGXJBj6sowXj+RXkCn/S++Ykv
	 WHRS4CaIRBpzzFLS6LbMiG+sMHo9rHRgWpXpgyCfclilUdApDRLQuZrQ2saF4CWuucg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jPW4ngXyg6cTdezM/57s9UolQe7wlzejSFpNDi23C5U=;
	b=2NFmz73lHg4vXXXtwoTQISu6rBLqrjZW10dbwvkkLiTHfqZ7wFfh5uHJESpdmcH3xkj6
	 8iB5DV+w27CTveh/XyOauQgiCPth2eAAl3/wXdNroeme9OufHEkmZqCJ3T/cGYW6VSmHz
	 qvEyhlTtPYRhtvvMTlox29TL8p2oB+ZhD2kYf0b4kQg5huBem3Jz5MxFAJ6ZhG1uXGtS2
	 qtXzNqSRpNBJ5C6Op9B8QfD2nt8RkMZYOk1btRVt3Eiqw5mAx+avjqnTLRN0RPQtlZZiX
	 +A53Y6YmmEc0+sQK3Za+hWkZGt1ALMSeXBnB2g7827+OoMO+5NTQV+bX9JHnlvNsPpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OPwPDdys;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F0606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 276F0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OPwPDdys
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1247405a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794357010; x=1794961810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jPW4ngXyg6cTdezM/57s9UolQe7wlzejSFpNDi23C5U=;
        b=OPwPDdysdP7qPYtq5WHgl54tlwl5qA9toVgQA4dVp82UWlPZVQqBJgMJJtVUtc+YzH
         3zCFRqsyO5AVa4055y3f2eTmPdudak8BHbJ/7C2/9zQ2GXqKHnQvIqA9DnrDj5a0Gbez
         JrqZj9jfd6BNa0zF09V38QqnVXOf9aYcNLHy0i1dmYPupzFMsBzZoNaA9lhvA6j8ijRQ
         m8Ca5b3uubEKO6DXfMMK12Ry45RrMi+Yl290mjRRWofPcy+ApuslAhudEQZb4DW8Ur+4
         GvFVpvnXjEO61yOWHZ/AXefkXI1d6Lgi2mz3I6CHO3ODxSCMB/oUNEyfTWxrRVuoRWCN
         CmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794357010; x=1794961810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jPW4ngXyg6cTdezM/57s9UolQe7wlzejSFpNDi23C5U=;
        b=XCzbCQbHpCl4PJ6/t1pYkKlRzrottAlYtXsbnumk5yUpMuDL+OeRvP6iUzSM76D7C4
         0cIBQygdV8ahSPE5kzG7d+15uud1txWjy4GbanuAPCBMMRS8rkydDNsKjlTOL7pfHMlv
         oOnuCgKq+dvlsrM3buUm0QH6JtYY2fPLk/pKv8H3DTz4XxzE0CdAa/M6LpeWB3yo47cv
         8tRJjKl+jFe1F7KbC2HTNexzLaQbhUnkxaDfhk1ioG9gd0PQ5gk5ZIj8v2Nf6OxzDvk0
         dCnGLD82JuBy/A3pasI0c3o3F7B3rXSs7FE62UuZIlwQX1KEE7WQacUGyrws9Oqchc3v
         9oaw==
X-Gm-Message-State: APuU4Z/ngFwLNGO7mbxC2q8TGIt53EF37Lun08e5Up3GRJgt0q+ek9a2
	DaQ70ONHYr12dccPK8CTpMvQRUFjfio5+ND+uK2Im94ohG++Sf+VbcrcrDPODg==
X-Gm-Gg: AYBFou3qHMafc6CKee4FMCjDfibGdhfETR6SbZ4YqRbyqRmpC5QI0SjMNT6BJXz3/NT
	T4kaz6syk9+7VBna7KIyIG4aY5Iqlr4z1nVbJR1RvqMWDzYF9kwKaEtC1DfPitJ8+ruKkH6F9Nr
	4y7VWLShT+owFQbgvgF2RrPipkp3XACzk80Rts5X78F0YpI44/m1CYlNfoEf+I22Ro/Q/zU3RR9
	Fxhs1WaJd8P3hNd5Y/gCLogbmjqqxHe7kjqEe9b984jseaxCEZOyxlsOo+u3nsYBWrZAeOBwR5D
	Mr0VQFZlXcOkFhgMrMlpddTFPLAl5zUNuCBxnJCqjXNKnUfaSHIoh6UCSEQmU8MWlQeksktMOZi
	0xhmOln/64jkYhbBUzRAA4vMIpbgj6BCrJ2tiFfBRiJKAus4bj90F1YmQOXP1GGytQI6BsyzBQl
	on7wtl1g5XZ/BL2KejwEnRUVZI3A2tXOoWwhXu2gCULt0AbN5vFmMgEych5B9QgcLQfC3ZI6ads
	YxBz2bOQ1AdcBhb3788LasoIi6HhiLkvBunKJ2gP6Ac8nMZgRVOVFugvMuzSLyv0JS1h9awq1YV
	MHJt+PZ/VlOtufAuZrAh6WCdOXCEUsuK07yWbLaspWj+6IdRYuUi712pWPHIDBMGJidcO2rzZOc
	yn9p/qNQNY9kqBsnVU8HhLRhYrxR40aviZnfzRwM6A2a6WKJXbxImQ27AsWc+SGL7dApBqTotR2
	sMcw==
X-Received: by 2002:a17:90b:388b:b0:3b0:b36b:66fc with SMTP id 98e67ed59e1d1-3b182fdf9a3mr671597a91.63.1794357010270;
        Tue, 10 Nov 2026 16:30:10 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17dba5ed0sm1693588a91.17.2026.11.10.16.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:30:09 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ibm: emac: fix fixed-link speed and duplex
Date: Tue, 10 Nov 2026 16:30:08 -0800
Message-ID: <20261111003008.960305-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Since commit d99b408ed8e5 ("net: phy: fixed_phy: remove not needed
initialization of phy_device members"), fixed_phy_register() no longer
copies the fixed-link state into the new phy_device, phylib fills it in
once the PHY state machine runs.

EMAC never attaches or starts the fixed PHY. emac_init_phy() copies
phydev->speed and phydev->duplex right after registering it, so it now
gets SPEED_UNKNOWN and DUPLEX_UNKNOWN and emac_configure() programs the
MAC and RGMII bridge for 10 Mbps half duplex.

On the Meraki MX60, whose EMAC has a 1000 Mbps RGMII fixed-link to a
QCA8327 switch, every transmitted frame reports carrier loss, the
switch CPU port counts FCS errors and nothing is received.

Take the fixed-link parameters from the device tree, in both the
"fixed-link" subnode and the legacy property form.

Fixes: d99b408ed8e5 ("net: phy: fixed_phy: remove not needed initialization of phy_device members")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 36 +++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 9fa18ad99f4d..f097b6e49eeb 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2696,6 +2696,40 @@ static int emac_dt_phy_probe(struct emac_instance *dev)
 	return res;
 }
 
+/* The fixed PHY is never started, so phylib never fills in its link state.
+ * Take the link parameters straight from the device tree.
+ */
+static void emac_fixed_link_state(struct emac_instance *dev,
+				  struct device_node *np)
+{
+	struct device_node *fixed_link;
+	u32 prop[5];
+
+	dev->phy.autoneg = AUTONEG_DISABLE;
+	dev->phy.advertising = 0;
+
+	fixed_link = of_get_child_by_name(np, "fixed-link");
+	if (fixed_link) {
+		u32 speed = SPEED_UNKNOWN;
+
+		of_property_read_u32(fixed_link, "speed", &speed);
+		dev->phy.speed = speed;
+		dev->phy.duplex = of_property_read_bool(fixed_link, "full-duplex") ?
+				  DUPLEX_FULL : DUPLEX_HALF;
+		dev->phy.pause = of_property_read_bool(fixed_link, "pause");
+		dev->phy.asym_pause = of_property_read_bool(fixed_link,
+							    "asym-pause");
+		of_node_put(fixed_link);
+	} else if (!of_property_read_u32_array(np, "fixed-link", prop,
+					       ARRAY_SIZE(prop))) {
+		/* legacy <phy_id duplex speed pause asym_pause> */
+		dev->phy.duplex = prop[1] ? DUPLEX_FULL : DUPLEX_HALF;
+		dev->phy.speed = prop[2];
+		dev->phy.pause = prop[3];
+		dev->phy.asym_pause = prop[4];
+	}
+}
+
 static int emac_init_phy(struct emac_instance *dev)
 {
 	struct device_node *np = dev->ofdev->dev.of_node;
@@ -2730,7 +2764,7 @@ static int emac_init_phy(struct emac_instance *dev)
 			ndev->phydev = of_phy_find_device(np);
 			if (res || !ndev->phydev)
 				return res ? res : -EINVAL;
-			emac_adjust_link(dev->ndev);
+			emac_fixed_link_state(dev, np);
 			put_device(&ndev->phydev->mdio.dev);
 		}
 		return 0;
-- 
2.56.0

