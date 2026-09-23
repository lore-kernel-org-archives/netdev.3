Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69B95304B3
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200759; cv=none; b=ksVTEdLtVvxlvPRejps4rJsqL69xdmNSROB3JmElmKE5sIh2N2C7uWITExgsZNozKjhKIeX/4QgR3IZQ3RnHEn4OGB9EzwU30frw5YzM98+7VrkS1uk/N698DibRLUheLhfIKqfq4IbcGBnIindK+jld8AID3H3W57vV8IQna/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200759; c=relaxed/simple;
	bh=crfmY1UoAp0225g5YflMny9pd86Ycu6YBiZZO+PGdW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN4/I7BrCdwh7nFjrS/GTEG6EMH+D1FiXU0Gy7RscMjDESW2UugExVCe1/ZdY1AEtrMrp4YhEZLhgNae8xoKM9TYvtQNYT8+EF2OdpKWYy3XmGjDreWemI2uvEHjbaGU1xK1gv4JcKKXfli6Uuq3AdD5EjA5yh0vviKmQJkM9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/yvXsWM; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/yvXsWM"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so219808966b.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200756; x=1790805556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYVKcOWe7AV6XzPqKfhqiFAXADXl3H8Zz3CAushPG+U=;
        b=p/yvXsWMN+cy/+tDrmgeDBrbjBoFnYveCJIAhdS5OvkKVFsJw+ek/9dee3vA/jzHmJ
         DEeORK2Kaa9kLxNU1QFson5grqb8bUw7lvEU5jcQJGkLly/tRcid/wQ+I6TUnxeDA+AE
         WvR1o2QdvsWGZMGDlVd1OSn9TDf3EgJSFubHBTAGryFRBLXpAKkOYxaHz4a89/JPKZlS
         TgzkPFMhPaIGSjcwOVo4DRu1i5jU1P4MhvVS1m9MpzhiW1m1GIFxEuykKmQWiihX1cSi
         gKsXrmyVun1n4oe9MTGmD2Id2WJDnxZwSbazR64mz8V4NQfSqi5LVaL+zpodiqxrw3SN
         yKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200756; x=1790805556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SYVKcOWe7AV6XzPqKfhqiFAXADXl3H8Zz3CAushPG+U=;
        b=RymsPPDZmBr/kPnaNFXAzo20uPSS2p6R5q6h6qGsiTJAd6ElZZW9gn1iC07qzeHC31
         yUztA+fKy3ZjYh35xEv6Uf9mEtAwVjFX6lnyas9tMmOX4kl/NJHRDStguCuxA3cDGby/
         rlEEgLgepdypT6/ExdmglXlYsILlndN7trMzI7+9NQRyf/J/JVn2Dw3+kq0uQmoZMYqn
         RGzOIPPr9LLnwLRlbbXDGd8J1h2a1QqrdrebB8WuD6SwDjPDCo1VgsHVO/ZYpRmVSqo+
         hmf4ILsGOrNAZka3RYY1nJmtYPpjaYRw7O3/yrncyUFTZZWMZzBWyN1+WqTiqbfF4bBn
         id9g==
X-Gm-Message-State: AFuF++ley0vCiImQlFvZf/j9J3mv5Ekmyx+f5PLc1JUzSGaSQnEDZP3A
	dnaeCPt45OPQAltHZ5eA7zxVt5Ea2ioD9vuxc+ZolUUelaJ3vDc0eGSMrAPEffc892rjcQ==
X-Gm-Gg: AYBFou17uhBvpSPX6FK0x2MwA0h755zK8n1X1YjroBxJq+bVL9be9P8Ouu8soBsOnP6
	cGIMbhWXjs7MCvElQGJKXLWD2Aq4q2SKp8ILm+Ikal0N3MspLuEADQTmL/ZqLtTxStsT9rDfD4d
	YzJYAlGyeuTfbU8j0H7FK6un0Q2bpEbWZXpxxgYOFQU0VaK7Kf5JeWLq9CaLngSbnu6D/xHUqmK
	kJ6638d7beT9tmI7xCqDE2Kkwz/o+xv/Gt8aGa1SlL3JwuUxIp0ERFnrqvsvPw/0GBHO8BTxoBC
	n3NM8w5Akc2VDdDKEUlNIKxcpMGm3DL0bEIThAWrd3Vk3NtNIOtuCzm+OOznlANFIeyjcDglosJ
	50hSCIX0Yb8RQdwmndOJENtSb6QldKu6mv0oTHRyb2wJQQeN90J3VaJd9aGO2MFqbHvBf1FOHWq
	mbRDCr5IwKSGj2Wk/er7tU0G0Lll8Jw2mXLAu3FhBN4ELQ44JZkc+DOJLTFbUDjV+Xh4kBolR4N
	NuqsWzr6pPG3nfwGxJzp5oDyzSllGnc3e9XytAbF/DzWso23XzLFXocKQPrkdpaG/SLFdeqDDVQ
	OL/VRzzH4IoXdw2tkDIJN0ck0ONZNBY=
X-Received: by 2002:a17:907:6a16:b0:c1c:4e36:eec6 with SMTP id a640c23a62f3a-c2ac23c4e05mr37551766b.18.1790200755900;
        Wed, 23 Sep 2026 14:59:15 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6dcf0dsm197647666b.61.2026.09.23.14.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:59:14 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [RFC PATCH net-next v3 1/5] net: dsa: pass PHY flags when connecting shared ports
Date: Wed, 23 Sep 2026 23:58:53 +0200
Message-ID: <20260923215858.1653-2-yongzhao.derek@gmail.com>
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

DSA calls get_phy_flags() for user ports, but passes zero when connecting
CPU or DSA port PHYs. Pass the callback result before PHY initialization
for shared ports too. Drivers without the callback still pass zero.

Keep bcm_sf2 and ksz88xx shared-port flags at zero, preserving their
existing behavior. Document the extended callback scope.

This lets qca8k pass revision information and a SmartSpeed quirk to an
internal PHY used as a CPU link. The remaining patches supply that user.

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
index 7edfdd555..647f952e3 100644
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
index 9e5713015..f516fc396 100644
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
index d74981320..be8861a7a 100644
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
index 1f5536c0d..4db7e6f9c 100644
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

