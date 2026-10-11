Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE51B87C9;
	Sun, 11 Oct 2026 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791679891; cv=none; b=eBAggIL/6ZEWiAfhZJ9trVSylfcC2Td9zfSK0cwRAGAoLXk7gQA35DEfFa2m6Dj5jU4/cETovsP5LNIaoBqlwNPac6CYaGQaMt57N6kY8clWihPGc/rpFWP1x2+aTD0VSW7fOQtvZ80+08KyfOPjXqSrbAWMbiJ+PbBTKtouT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791679891; c=relaxed/simple;
	bh=DcxkDcnvlybE5aprTjKgL+Sw0SO1onWzZZMQyEUG5Ok=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fCTJdzSeHIfmE5c0sAc2LFrqhapOttvE3NV2nct1OEiIb/buxGeLqZDmDb1XlXZ4QGuxACgwGeYQoBRyDc2UOlglyy9DBN9au21jqAQpuVcP1jQ+D5RkLPrAe789njpJRVbgoq05hOLo19WIYL+5zPOcZ9AylWyriSekC1VWd2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xFhmX-000000005u9-2N0t;
	Sun, 11 Oct 2026 00:51:17 +0000
Date: Sun, 11 Oct 2026 01:51:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: sfp: add quirk for TP-LINK SM410U
Message-ID: <172a4fed74d35b1be51f4e8aba2222aa33845b08.1791679663.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The TP-LINK SM410U is a 2.5G copper module which is based on RealTek
RTL8221B, but doesn't seem to offer any way to access the PHY over I2C.
Add a quirk to disable in-band which isn't supported by the PHY.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/sfp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 2b5528ae930d1..a2aaffeb2063d 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -652,6 +652,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("XikeStor", "SKT-2.5G-100M", sfp_fixup_xikestor_2_5g),
 
 	SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_S("TP-LINK", "TL-SM410U", sfp_quirk_oem_2_5g),
 };
 
 static size_t sfp_strlen(const char *str, size_t maxlen)

-- 
2.56.0
