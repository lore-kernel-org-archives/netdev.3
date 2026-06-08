Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1CF3C4557;
	Mon,  8 Jun 2026 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927824; cv=none; b=XknsJhbFKYgVHKDmJLFB4rI6YiwfM1d/+ewmE6ODbMRAUWqvS3cGdX3Xf3l8LT3Ek5ih4cstmuebdbrIP61ZlN9oeGrrB1Y1EefUOWU97C4o6P5Cf1gWUhrIlqLiasNgMmWqHMDbHjlGUTpeRtanwQ5DGWDsuNY+uNbLMbgBCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927824; c=relaxed/simple;
	bh=fEHEwXEoUDYte5vxo2ruOxaYtP9IzusrpbVVL0dP9qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XCev1EW3LxsA4qiOifur+JgXMev2d4Z2t5CDc/KsIeABoiR/5WaiwA86j7WN4rkXz+CBKn+QlcRAXsAqynKl33QydssU8Cn+MF734W6/DS6KxcCVdMdirY9FAd9nbFed++1VGuK3TD9bfZ9s+RdkAKy/wQl2+4HjU1wADPpRLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=z5MPr3zH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="z5MPr3zH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 66A9BC4FECA;
	Mon,  8 Jun 2026 14:10:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C1695FFB7;
	Mon,  8 Jun 2026 14:10:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC88A106A2958;
	Mon,  8 Jun 2026 16:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780927820; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BBtWvn1cViKIlEYxRrtV8pMaWvcQuKsWUQfn4agDogc=;
	b=z5MPr3zHV6YzsZeTu43a0dy5zqKLvkJkoNKB33qw3u4d2aOzNQ6zI3wCuSvLc6wmEFbUsS
	EIpFTGYtkzXHqErbalWSXsJdRt7COrxfuxWaYqeRIvErxaXB1IaPCnQweDNrKM/i+ayS9X
	lx+m9HevhI9j2c1lQOAe0AeHTzsyDrFRyZCJgxofTGHFicQn84neaJTjXa8m6FmUbIIt9o
	/VZkVbz4Ja641pq/AEDhfZN6vffA6zWTiVHFh/inAOmgE6EPjTzNPtPedN2fB0YjT5uQkY
	5qaR9Y1epHTug5hJS7Z7AE+ZbR4MQAwmHlmoHNURzjXKNw/1QizxlYr32NLo/A==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 16:10:05 +0200
Subject: [PATCH net-next v2 02/10] net: dsa: microchip: remove VLAN
 operations for ksz8463
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-clean-ksz-3rd-v2-2-6e61b7be23c4@bootlin.com>
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
In-Reply-To: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

From: Vladimir Oltean <vladimir.oltean@nxp.com>

KSZ8463 uses the common KSZ8 implementation for its VLAN operations.
This implementation returns -ENOTSUPP for the KSZ8463 case, which is
pointless.

Remove the VLAN operations from the ksz8463_switch_ops so the core can
directly return -ENOTSUPP.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index db08874eb025..93e0b3f60448 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1477,7 +1477,7 @@ static int ksz8_port_vlan_filtering(struct dsa_switch *ds, int port, bool flag,
 {
 	struct ksz_device *dev = ds->priv;
 
-	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
+	if (ksz_is_ksz88x3(dev))
 		return -ENOTSUPP;
 
 	/* Discard packets with VID not enabled on the switch */
@@ -1514,7 +1514,7 @@ static int ksz8_port_vlan_add(struct dsa_switch *ds, int port,
 	u16 data, new_pvid = 0;
 	u8 fid, member, valid;
 
-	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
+	if (ksz_is_ksz88x3(dev))
 		return -ENOTSUPP;
 
 	/* If a VLAN is added with untagged flag different from the
@@ -1584,7 +1584,7 @@ static int ksz8_port_vlan_del(struct dsa_switch *ds, int port,
 	u8 fid, member, valid;
 	u16 data, pvid;
 
-	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
+	if (ksz_is_ksz88x3(dev))
 		return -ENOTSUPP;
 
 	ksz_pread16(dev, port, REG_PORT_CTRL_VID, &pvid);
@@ -2439,9 +2439,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
-	.port_vlan_filtering	= ksz8_port_vlan_filtering,
-	.port_vlan_add		= ksz8_port_vlan_add,
-	.port_vlan_del		= ksz8_port_vlan_del,
 	.port_fdb_dump		= ksz8_fdb_dump,
 	.port_fdb_add		= ksz8_fdb_add,
 	.port_fdb_del		= ksz8_fdb_del,

-- 
2.54.0

