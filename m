Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC62394EAC
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591228; cv=none; b=fRhIzFbX5d1yOd6NP0P+vAs0onaOhpBKI2n5jm8QTKiv3j15SB+5ojBVAuu896feskryfZYXq5yJLX6U3WcV9KBXSvqUf7+iAchxjDcx8maLsBLtcCsYRm6PVtmScJsx1p+sncocNt8wQsF0YmJMeu0N73xJVh6kNoP8c31mWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591228; c=relaxed/simple;
	bh=EOwMc4cnN6mjXx+lNAo0TmGO3icV95F/RHTdgA6irSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pucF8Txwg9PEtysB/BcaxjIXiL9XeZWX78Iuu0BlCNVFoTX+d6qfmvlpQQvo+dZOpmwvvCgpGFdd5lMtz6gdNXnPL2EFJDUZK1yu2GlA66Jlgio1AT4aaWhMimTdOZ9E+VhhGhnI3OmboveiDnmOG6GVSwazBU1R/bGOcX+jCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F5OqKnTt; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F5OqKnTt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9EFBF1A357C;
	Tue, 12 May 2026 13:07:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C13D60646;
	Tue, 12 May 2026 13:07:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C482C11AF8CD5;
	Tue, 12 May 2026 15:07:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591224; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NmRmaxENCbzVfYEf7DmKsuBOHPJgb9fR4nlBynu9nU4=;
	b=F5OqKnTtkoL6qd1sTpjIuniJq31GS4mXHmoerqH/JJRsO8ZPPMVUCxO115TlFV1WADlBiY
	liq9oFOtw/DD2lVdwhVRkgRnMRoFzT+cw09YUD4i8LEVTdlXUv4BiX5V/Mi2JVTfWW987H
	a1NkVC39OVhwXSIOxOFQSmil6FpdLDYBqhXROscn1tUneI/RbmhbviFsNpx+tOAzHhxeil
	7tffkYNU0jYikt7Ve9U9Fn6c8Y1pXgMKYpgLvf3i2ik5TyuQK2Kr3op5Du/xoYDb0BNqzg
	Kcb+AJYCcBZYTNahjA7VPJ35st9rj0H9cQVG6DRS6B1A22wkWoS3ssDNbLzSHw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 12 May 2026 15:06:36 +0200
Subject: [PATCH net-next 14/15] net: dsa: microchip: call DSA's
 phy_{read/write} to do mdio {read/write}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-clean-ksz-2nd-series-v1-14-c00f6ce037fa@bootlin.com>
References: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
In-Reply-To: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

ksz_sw_mdio_read() and ksz_sw_mdio_write() respectively call
ksz_dev_ops::phy_r() and ksz_dev_ops::phy_w() just like
dsa_switch_ops::phy_read() and dsa_switch_ops::phy_write() do.

Call dsa_switch_ops::phy_read() from ksz_sw_mdio_read() and
dsa_switch_ops::phy_write() from ksz_sw_mdio_write() so we'll be able
to get rid of the useless indirections provided by ksz_dev_ops in
upcoming patch.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f44974cf4e595..0d66592dff703 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2260,22 +2260,18 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
 static int ksz_sw_mdio_read(struct mii_bus *bus, int addr, int regnum)
 {
 	struct ksz_device *dev = bus->priv;
-	u16 val;
-	int ret;
-
-	ret = dev->dev_ops->r_phy(dev, addr, regnum, &val);
-	if (ret < 0)
-		return ret;
+	struct dsa_switch *ds = dev->ds;
 
-	return val;
+	return ds->ops->phy_read(ds, addr, regnum);
 }
 
 static int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
 			     u16 val)
 {
 	struct ksz_device *dev = bus->priv;
+	struct dsa_switch *ds = dev->ds;
 
-	return dev->dev_ops->w_phy(dev, addr, regnum, val);
+	return ds->ops->phy_write(ds, addr, regnum, val);
 }
 
 /**

-- 
2.53.0

