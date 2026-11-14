Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633002;
	b=4RhZrI0jxJJ+F2/ot29X0a+OY/EkUBnmdraaLzaOD0PxOi1mRBhRVt1NuXv92+BzEORB
	 TdrvjLuCv040bxBO+DFNEJklkWjUm8RLyRCgqteOgtMFZazovlYrgVbxYqDSxzunrY1kV
	 6dGch6odx/qwNwfR/OWvJfLBOSl843ggwMhUdOsjFwVXoGaFvRBFZB1Lz/3gBumCzNAEo
	 AnongeRwVpG7mTXDh+I909Mxt1+7OEjykzCHCBg7ECTgnP3BiONMS7clWD0ir+lznfmSF
	 OaA2xzPi02/sT4EvK5DV+QxjJGqtYCnhSB4+lRdba7q/hUPK9lfpff/+1rIEP2J/wAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VUh/PFi1lDb3micsC8D/BbCK473QFmrlieov/ej0JWU=;
	b=5ijAxDwJBCXmcplHDMU4JM0wmk/3bQuvqz/gwnBq/k+s6CEXB/pcAbmHanUtHc+B6Umx
	 4RR27roKedX1bW9jQwMSJMu9RMniyJiBxRWNkj/CuI9vnfBJdyINF9qVk2RVQc3D3138i
	 0eTDqmQfFWT8JkiPPRj8C37bq+nYKdqVY0RmPNafS78kdBkFE8jChViKghs9JLLve2r4L
	 +MGND8rlhzjPeFyS4EkPqJCm9IESgB2rIGWMd6cLfJE0lHqx7exe26cMEzNtxAxFws8dE
	 gLcMIFzPBoj6bT+OYNdhZ4rQououZdGuAjiuXHtISvqQyYvGR3jXb5onKykU7m9OmSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vpXcrQIp;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF360A2601
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 05:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0CF360A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vpXcrQIp
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b2eca6ac0fso16306a91.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 21:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633000; x=1795237800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VUh/PFi1lDb3micsC8D/BbCK473QFmrlieov/ej0JWU=;
        b=vpXcrQIpE8QmiuCYPGBGK9RQKIMyMiybG8Uli5btFf8XoUz1ZlpENF//fzVzuCfuMw
         iOgSjMxwidMCnvs+jdE5E3j4/HMVBdifXsAvIXlIX3EoIgSqvNZz/RvUpaW1L7+rWOEF
         GPrqv0RGU6YjxGRCplKrxiMD5tl+4eimQQS4Evib6ZX/GpN1lzz970z1vEQgSgONuCNU
         Zi8hmOn6AzUCslniyq7X8l9os0xrhbnFPgbpkAwLdOynUhzjYYdD8ev++4J1XgAVgrHy
         vmPYzScg26uhNDwtMaDhNIG5fV+3i/se9+BVmeBkqO8NHT+q9NJjmaTQ/45OgEPK8hmL
         LHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633000; x=1795237800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VUh/PFi1lDb3micsC8D/BbCK473QFmrlieov/ej0JWU=;
        b=Tedq2GRoI4ey8vzlSaAFLLRyOZU6zaYysC+C/kHgBZMYLoTC6zXZ1hMFdxjuavedly
         4+jPNAz9Bj+QrHCM2gTCRjTnt/8B4v0yCXFPmtRObeKCtGzHg7gk6Ojqt6ggyPDLFK0F
         WQ2UL1h/xqKPmdEwbyxpr3O+hi19/tg46KAjFR6A4wq6y4J4jlJbqkt+6u0uw3i04UdU
         d85HEZxogVIcazxuEcRZDMXreS0eSoVYSnDeGOTLgAsQXFXP9hloNQHLEz3HQvIQ0hSM
         +2TmQXkdL2fF8ViAjxjRL1G0jn0icVdp8gH2Z5vpoAdDrVJ+416j4ml4q57ejTrP1RNx
         C4Xw==
X-Forwarded-Encrypted: i=1; AL+hErEpPqOa2tJ7C1AMvltCUDuFsNeDMWFrOiBNyMeCnavO8qLueOatiSBiH+5fv49uPC8pKIYppDo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fnFhln8X551CKI6stDk3p8Ugu59C+sXfuZ7JlkJCcDV4JTgA8
	y5VY2TEWXPjCFPM2gtw2BV5i02j9HDAGKloJNdOTWC7lq2fjMDR1oF3IEUe6jrzL
X-Gm-Gg: AYBFou00hwFvbKMbWdcwIoDVARBE/mUTG0hNFKqd/+TGqEXqybrgNw7z1JJWkCm6CqQ
	Hn7TaAyTGS+5r+ErZdl6zuXGHLg2kBX74s03v5kNyB1yFNT9c4a12rA+nNGJpilJ1aEod5K4W7R
	pLAxE2mFCbj9vxFNhndqJfK7ObfbuLmJLNLr4tyu2AgH+zkP9R9i1TtwzbMbN71ylTndcGY8muM
	uhanRuri+Nt0Mr4fYV/IRa6coF5s99neOZqRwwdbMWd2/gwzpzpzUNXomDgCZidf0o9/AuEOuWA
	jRfJz29iOpRQZX1gZjCMbvPnCUUswxzW8w2ANBxoJTII+gnEiIWW3+Xub8T/aKTSiTkNS87bEfE
	0w7Nr3qv6ZSkd0REoloRJJQ+kQizmWsoltSAmeFafisrSRpkihC5NM0XgRDpDB7b9gXV6v0gmp9
	BemswNbdd9ovrpWysxrCiGajON8PxaJ7byex/vbMlH+ZHD5qwLwcOVRpKs+BjSPucC1+NJ2tdfH
	ZSK+GS4mpmKwhahJ47lQvEOITWhUw4XjVhBKlWgs6rNKfsJdIZ3bh6TKDcb3wCnOZCXqXZkwvQ6
	qsP8dlGGskZlJCnQfEd1q7XGZAEumqM/x7n9RSdnPZwdE8wnrAzs
X-Received: by 2002:a17:90b:3146:b0:3b0:9a13:c5d5 with SMTP id 98e67ed59e1d1-3b1b0b57dd8mr4332886a91.16.1794633000237;
        Fri, 13 Nov 2026 21:10:00 -0800 (PST)
Received: from fedora.lan ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d257a0sm12776577a91.11.2026.11.13.21.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:09:59 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Andre Edich <andre.edich@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH net 2/2] net: usb: smsc95xx: propagate MDIO write errors
Date: Fri, 13 Nov 2026 23:09:54 -0600
Message-ID: <20261114050954.275495-3-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114050954.275495-1-artem122novak@gmail.com>
References: <20261114050954.275495-1-artem122novak@gmail.com>
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

The MDIO write helper currently discards register access errors,
and the MDIO bus callback consequently reports success even when
a write fails.

Return the error from the helper and propagate it through the
MDIO bus callback. Continue treating -ENODEV as success during
device disconnect, consistent with the MDIO read path.

Fixes: 05b35e7eb9a1 ("smsc95xx: add phylib support")
Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/net/usb/smsc95xx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index f85ee5f8a539..52035c160f4b 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -215,8 +215,8 @@ static int smsc95xx_mdio_read(struct usbnet *dev, int phy_id, int idx)
 	return ret;
 }
 
-static void smsc95xx_mdio_write(struct usbnet *dev, int phy_id, int idx,
-				int regval)
+static int smsc95xx_mdio_write(struct usbnet *dev, int phy_id, int idx,
+			       int regval)
 {
 	u32 val, addr;
 	int ret;
@@ -255,6 +255,12 @@ static void smsc95xx_mdio_write(struct usbnet *dev, int phy_id, int idx,
 
 done:
 	mutex_unlock(&dev->phy_mutex);
+
+	/* Ignore -ENODEV error during disconnect() */
+	if (ret == -ENODEV)
+		return 0;
+
+	return ret;
 }
 
 static int smsc95xx_mdiobus_reset(struct mii_bus *bus)
@@ -306,8 +312,7 @@ static int smsc95xx_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
 {
 	struct usbnet *dev = bus->priv;
 
-	smsc95xx_mdio_write(dev, phy_id, idx, regval);
-	return 0;
+	return smsc95xx_mdio_write(dev, phy_id, idx, regval);
 }
 
 static int __must_check smsc95xx_wait_eeprom(struct usbnet *dev)
-- 
2.56.0

