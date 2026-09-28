Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50435502778
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633326; cv=none; b=O22tBeKCjafBSnHZ5bVbXJeuWqhi1Jo/Mr9gJ89TzNiJDHYsTtgKgSzx8NCPTMnSJ+rRKUS3VrmNcNPxKr/UTDfKu4wD3nCMNgMPkbvFjfkSHiykgrxRmFyOMKzjXxTQB0s4x0GkpgzbSLhqVakpO3R+a2qRVP6jbEcqR+d9Y6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633326; c=relaxed/simple;
	bh=FTOQlw5dyyb4osUpihmQoUDlMiX5zL7IS33ujQpW7uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnwJv+3OFS/GR1yPk5J6QqWmHXawM8dg7w5LHb9ktZhT2Y7m1RUFyN+GSV00Y8RP179G3p4m0p4Ia9cfMzjJWXn9/E57FXcvE+V8FGM/c5vCoExWq2v6xItUM/9j1zJDfzqziTZBO7L1abNxYv9+VnVVYm3paSqIEFPShTQoCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L24PZFNo; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L24PZFNo"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2dbdcb4f59so330975366b.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790633322; x=1791238122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q93m/hhLL7MRUrpvnx/dHnc3DUZc/IU6GQ/cfi+h2P0=;
        b=L24PZFNoMOwiUAf+6vb6C1b9B4wrWGvf6D147qewRAJJLdaxT3vN4jf6rIrfZgezak
         mAScQqXi1kFIga3QiMAh5ZiBv7kFR9fAhoHLsEUGtPcp0+WCWLV0CJmIht9RoD3MFjye
         L3HPkLj3ntfRnGgjdMlDiKCBKXH2KzTA6QgHURlsFyZlo4s4cwemDnLG4pXHk2aiYIzO
         Xkr6mkiH4Ps7C0XsYO99YB5jWyTYf907HEpbz2ZAckgRwst7H1qzpyENYMojSU98VV0P
         9AN23OU0em9qVtl61grXI1wGoGNYqxCBTHxudmqy5yYVvGi1rsAR4mBqEdYKJBcVrnJE
         u9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633322; x=1791238122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q93m/hhLL7MRUrpvnx/dHnc3DUZc/IU6GQ/cfi+h2P0=;
        b=h0UO6CBE53kB+uWU7uQeED6izf8b27KiLdMvYmMWKUlP87zpGbYaWBAUQPTpVKr6x0
         2CmAWQFcGmVUjH7almjagK+SFyKF8LS1JoXpk/WnWxwxThayC/g/rrxIcqXdWbRNqQsL
         IxnjTOEBTTDyhOw748DwGiOeumujABDb63ftzi/AWhzOSqWjUWY1KfN0aht9aIpLoSjV
         JMbcq122+mfHrobYVIqZdtEkniMolNGTWIEibDAlVXKSKMHThEZ2CC0xF5wQHaLH1dIi
         zrJ09jJ8J9TY1oftt3vYDwty3A8UzPCB1T0ikaL5dOZPkcVakWyhXxqWjbokzB8Ec1ay
         w8Xw==
X-Gm-Message-State: AFuF++kI+gU4xbsofqIYDNomXNgWrd9v28g/hG8V2frMTVt3jFq1f7N5
	4QscAOjoP1nL4dV963ZPuJIxPkQsij8FRVmzMActKvlkQD5tadyHzmA7ZECoSmnTsWj4cA==
X-Gm-Gg: AYBFou051UCh+6uq2o/6jUojOYqmD77UJ1q/PBrZgBRYeP4lppUahzQwkiFZuo2IQCZ
	dEfIFw9eyPar9lYTatDXNNG/W43BfIlseKYdNgR5dPwa8TUnH3wUqNxhSvOsjzvQj6oY1RYN75w
	hG5hzpvHd37vMgV2WzZy4e9WZqKirbpho7oH3ISNX6CmhJcQ3n11jX9CY1dgn/wzxBb+D+g+U4x
	lPGLLj0gaO3gAxvUDKp+E3ldrH1vkG47qplQU31e2YYHPHZibgv/386wGlJY42qsgQboE/4GTL2
	R4PUMA9LYGPHF4chDVjy5GyLQy+JJxtwonToQMwCK3VfKrEI/7cu8NIl6gWGFHFaGLUPgXNYwVb
	EuggnR+XDXqFjK7/4LaJnhos7mEBAOmtrrvt12xncaE1bNDuswWJW+PMK1Z1pdkRn0CJj42wnKm
	TdYentZpVMRxCKsy6LY+9mHAGhOz/iNnNuRNExSE2MXZ5PoSLt9wQVgPwQjSmEdZkXtIyEnABjt
	W7dqoAnNYF/DbnvlOogpZbDG4TZWhQTpA/x6tySX4N0tpb5os2F+vkz
X-Received: by 2002:a17:907:c614:20b0:c2d:d9f4:2c85 with SMTP id a640c23a62f3a-c2dd9f42eaamr230323366b.41.1790633322375;
        Mon, 28 Sep 2026 15:08:42 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:c07a:9093:1956:b4bf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bcacfsm345002466b.74.2026.09.28.15.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:08:42 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH net-next v4 1/3] net: dsa: pass PHY flags when connecting shared ports
Date: Tue, 29 Sep 2026 00:08:09 +0200
Message-ID: <20260928220811.1880-2-yongzhao.derek@gmail.com>
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

DSA calls get_phy_flags() for user ports, but passes zero when connecting
CPU or DSA port PHYs. Pass the callback result before PHY initialization
for shared ports too. Drivers without the callback still pass zero.

Keep bcm_sf2 and ksz88xx shared-port flags at zero, preserving their
existing behavior. Document the extended callback scope.

This lets qca8k pass its switch revision to an internal PHY used as a
CPU link, so the PHY driver applies the same revision-specific
initialization as on user ports. A later patch in this series adds
that user.

Assisted-by: LLM
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/networking/dsa/dsa.rst | 2 ++
 drivers/net/dsa/bcm_sf2.c            | 4 ++++
 drivers/net/dsa/microchip/ksz8.c     | 4 ++++
 net/dsa/port.c                       | 6 +++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 7edfdd555f0..647f952e397 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -668,6 +668,8 @@ PHY devices and link management
   on its own (e.g.: coming from switch memory mapped registers), this function
   should return a 32-bit bitmask of "flags" that is private between the switch
   driver and the Ethernet PHY driver in ``drivers/net/phy/\*``.
+  It is called when connecting PHYs for user, CPU and DSA ports. Drivers
+  should return zero for ports that do not need switch-specific PHY flags.
 
 - ``phy_read``: Function invoked by the DSA user MDIO bus when attempting to read
   the switch port MDIO registers. If unavailable, return 0xffff for each read.
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 9e571301518..f516fc396c8 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -709,6 +709,10 @@ static u32 bcm_sf2_sw_get_phy_flags(struct dsa_switch *ds, int port)
 {
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 
+	/* Shared ports previously received no PHY flags. */
+	if (!dsa_is_user_port(ds, port))
+		return 0;
+
 	/* The BCM7xxx PHY driver expects to find the integrated PHY revision
 	 * in bits 15:8 and the patch level in bits 7:0 which is exactly what
 	 * the REG_PHY_REVISION register layout is.
diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index d7498132064..be8861a7a76 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -3076,6 +3076,10 @@ static u32 ksz88xx_get_phy_flags(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
+	/* Shared ports previously received no PHY flags. */
+	if (!dsa_is_user_port(ds, port))
+		return 0;
+
 	switch (dev->chip_id) {
 	case KSZ88X3_CHIP_ID:
 		/* Silicon Errata Sheet (DS80000830A):
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1f5536c0dff..4db7e6f9ce5 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1666,6 +1666,7 @@ static int dsa_shared_port_phylink_register(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
 	struct device_node *port_dn = dp->dn;
+	u32 phy_flags = 0;
 	int err;
 
 	dp->pl_config.dev = ds->dev;
@@ -1675,7 +1676,10 @@ static int dsa_shared_port_phylink_register(struct dsa_port *dp)
 	if (err)
 		return err;
 
-	err = phylink_of_phy_connect(dp->pl, port_dn, 0);
+	if (ds->ops->get_phy_flags)
+		phy_flags = ds->ops->get_phy_flags(ds, dp->index);
+
+	err = phylink_of_phy_connect(dp->pl, port_dn, phy_flags);
 	if (err && err != -ENODEV) {
 		pr_err("could not attach to PHY: %d\n", err);
 		goto err_phy_connect;
-- 
2.43.0

