Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490987;
	b=EMA+zbKBMxEN/6eNiKnVnG06RMHhO884iWWab1L/4imWj9f1p4qzVnTDBOHKw9ALEbIM
	 nUm20LsxkaMNw8LuDJiUAYoArKUj5TsKH5FBhY9PFFuRzX3c1EgVrxv8+mjHfNarJwggN
	 WKSgKzINICEc1gOE3Oq7liAHKO+aE8onZkl0lv0+YPxc73+exKgNq1edmj792QxAd4aFf
	 PnOI3fVc+b6E0QeQWjwEuabbymGPPHG8dckcVdwfjzMT9PxYRCUlf4wFhGsVVBFHjbBHN
	 k67ptjHUl/OGZUihhh7LT1HkE4Q5jHPxoWjfXamp2fqcgDdf8XdCptObRIh33AVV/Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WpqRCk5B5nzcn0n6jouAOMVgDxIdILw4Z1c/KOkDk1Q=;
	b=Nj2z1i+cLgBZnI/PTDuhbxy03OuLas3b6uM2ybsXvt3HQ/noY+8zZWl3QWYqijcIwEPg
	 39MITGslrxs91eMPfUoIhCSS961Z4wXBjdup8FADK2Q9/OyuqAyXhY1VdUKTWR5KzR/hI
	 yiWUQwR3T95gGwVXygJ7j0uHABeMfkXw5sUptLMYT5KOOnOQO8jWD/NBm0+0tD+qZ91qj
	 QD4aBklIb6AdmxKPX4bxLhtExuiMr+KR85kEJUvmOGNBKGeX4qkT+VHfAyDW2RRq3mDeo
	 ycKGtYcem7rX5oJQYPwv/Yg3oQch7HHHQZby2sVJ8kqHb1Cf8Dv4MtHsuoB3Y6P63LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lex.la;
	spf=pass smtp.mailfrom=lex.la;
	dkim=pass header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google header.b=gXVtT9P8;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78A606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D78A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google header.b=gXVtT9P8
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4c9abc1824so605781366b.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1794490986; x=1795095786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WpqRCk5B5nzcn0n6jouAOMVgDxIdILw4Z1c/KOkDk1Q=;
        b=gXVtT9P8NG4Y8mBnHBOSgiSMWHJhloOCqJbamVux/7OjkAWXpOFP9G4DG9cY+ilI2E
         irbP7daRSPbCbTSl0clmFcG7cPMelW2vHsn9MSnXy9WUGF6kGQv3ZMwHXBMqEvKdmI1Q
         BX3AIOkAVblge0WhthggOL6YUdfF8wHjXKGVTpMltpVkR13BHeJSnbxfR2xfT3PyB8Lz
         /rAKUMQrfYCP71VCJhayrU9wt1gozg6BxeLSya8R4f+ngOI5gqC/lX+X5bMo1sOOATuR
         zwAWg7QOfU4H3LaqSlyhrF5V1VcFdv+mf5sqORv052ju9qIcxcv0hrOcJTmAg3UoXCEh
         rR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490986; x=1795095786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WpqRCk5B5nzcn0n6jouAOMVgDxIdILw4Z1c/KOkDk1Q=;
        b=oJDuL2GKePeSuB1GlU+cFy8MoxJ68GUJkQOAPQCifziKsYkhVwn6NYsYoKN0sPY7iW
         prLsdov6iMl2kVwg7e9/Fqfg4r4gWoWUmZfZ+pd7hxANd+a4t8TBrVz2Vvz82V3dpbh/
         tLl8sPZ27Kf+AKsvY0yWj8HYdqzomS+mlZ73SFahxmsrzhi1rB1r3NF5eum+uvMrqKLh
         iG6lvoPt8qn4c8hI9aH/4NE4hGb4cLTfGP40ynuyn9HL1mgNbUxzdkiT7GN3hsHYqRvp
         wL8IEvmjK+60rVvi2vbgTbe2t/lCV6axxKfuHb80wvOs9+nshHgvR4DaM2V8WBfTLGnY
         Y1Tg==
X-Forwarded-Encrypted: i=1; AL+hErGL8QF9p3qL3A452jd9mPm2vUErRWeG5IsP+gHQUO3t1gPQ0OqPBTHVlSag+uBnSzoGtdrOQGo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RGT6UPeCFeIaQZl8UXpkjSXUbahnWF7J5vUca2Zxwztbd5F2P
	9OQ9qvYRgSoWaL+IkiSRSUGydEP6pY/MQ2cuJtlsa6FwUwZwWdjKepUEBPFctB+mG/Q=
X-Gm-Gg: AYBFou13Bw9WJgNNQitBQdVGjavpqlVPDAGBmrFCoUyEsEKCfHgLx6Cplvk0/ilUPyW
	p4N+4h78pS1KvVHe2nOQBhRvWa8Vd9cLLcq/KwNUJUTRZ9x0IY1lcG0Cbmv9jRU8x5Yb03Oy8Ka
	QxQz3aC2yhnLTUWGXjmNTyeoa6pfWpgX8Ft7KYxv2l/TtjzRm0SuQ6IXMdYOu1OwFE8jH59yw4R
	XlzRoOHc8qX4wElCZJ88/CAIpclW4KDYBCqdMXnVTn7wyEPm/S1F80OwGff35neMMLql9rkkLzt
	ZaG62rWBWYvjmSTPbSAsabWe5dk/irU16GD/+Hzr5ATr6FdeFJ9EZIydyPxXTkUGaUNw/LKush6
	FKUKB0wAbWSTDMTOmfckTU/zJeghssYmkxQ0FDFSxRBwGAXIkMlPYxYYtrVrS8+rPKFMyoau/eq
	vlji51taJqBciZ7+ezLvckW/2eN69hxl1cQFanPXTR3uZfEPW6/auYHT3ajtIp4fnquwR6Sacr2
	lcTIIeXDFv5QOeKkKt3GKmWzn/OcTHJCjRjGJok+AHKpHvfUTQN5ZM4XdwEbJoR8Flf1wUgIlT4
	MsJQ0wHYT8ubgQ7nQ4Og1qKWxKHy1A==
X-Received: by 2002:a17:907:c13:b0:c4d:4be1:4197 with SMTP id a640c23a62f3a-c5066c986f8mr488046766b.41.1794490985681;
        Thu, 12 Nov 2026 05:43:05 -0800 (PST)
Received: from remote-01 ([84.17.55.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a6930sm349138266b.5.2026.11.12.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:43:05 -0800 (PST)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Lucien Jheng <lucienzx159@gmail.com>,
	Albert-AL Lee <albert-al.lee@airoha.com>,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net-next v2] net: phy: air_en8811h: use firmware loaded by the bootloader
Date: Thu, 12 Nov 2026 16:43:00 +0300
Message-ID: <20261112134300.4188612-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
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

On a Keenetic KN-1012 (MT7981) the EN8811H sits behind a port of an
MT7531 switch. The driver has to be built in there: as a module it loads
after DSA has validated the port against the generic PHY driver and
failed to set it up. Built in, it probes when the Ethernet MDIO bus is
registered, before the root filesystem is mounted, so
request_firmware_direct() fails with -ENOENT, the PHY stays without a
driver and the port never comes up, although the bootloader has already
loaded and started the MD32 firmware.

When the firmware files cannot be read and the MCU reports ready, keep
the running firmware and let the first .config_init() restart it, so the
PHY starts from a freshly started MCU as after a download rather than
from whatever state the bootloader left. Nothing changes when the files
are there. A board that relies on this must not give phylib a
reset-gpios line, as the pulse at registration stops the MCU. The
AN8811HB path is unchanged.

Tested on the KN-1012: with the bootloader load the PHY binds and links;
without it 0x8009 reads 0x0 and the probe fails as before; a rebind with
the files present downloads them as before.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
v2: read the status into a variable instead of wrapping the comparison (Jakub).
v1: https://lore.kernel.org/netdev/20261017180251.3618606-1-f@lex.la/

This replaces "net: phylink: wait for a PHY that probes after the MAC"
https://lore.kernel.org/netdev/20261006124731.1528963-1-f@lex.la/
following Andrew's suggestion in
https://lore.kernel.org/netdev/b175c750-104a-4859-a137-09de78a6d8bb@lunn.ch/

Developed with LLM assistance; tested on hardware as described above.

 drivers/net/phy/air_en8811h.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index a03d63dd4ac9..d1de58c3c294 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -518,6 +518,19 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 	return en8811h_wait_mcu_ready(phydev);
 }
 
+/* No firmware files, but the bootloader may have started the MCU */
+static int en8811h_use_running_fw(struct phy_device *phydev, int err)
+{
+	int status;
+
+	status = phy_read_mmd(phydev, MDIO_MMD_VEND1, EN8811H_PHY_FW_STATUS);
+	if (status != EN8811H_PHY_READY)
+		return err;
+
+	en8811h_print_fw_version(phydev);
+	return 1;
+}
+
 static int en8811h_load_firmware(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -526,11 +539,13 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 
 	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
 	if (ret < 0)
-		return ret;
+		return en8811h_use_running_fw(phydev, ret);
 
 	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
-	if (ret < 0)
+	if (ret < 0) {
+		ret = en8811h_use_running_fw(phydev, ret);
 		goto en8811h_load_firmware_rel1;
+	}
 
 	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
 					 EN8811H_FW_CTRL_1_START);
@@ -1214,8 +1229,8 @@ static int en8811h_probe(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* mcu has just restarted after firmware load */
-	priv->mcu_needs_restart = false;
+	/* drop whatever state the bootloader left in a running mcu */
+	priv->mcu_needs_restart = ret > 0;
 
 	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
 	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
-- 
2.53.0

