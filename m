Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E04EE87D;
	Mon,  7 Sep 2026 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789147; cv=none; b=NjloIxDs51vjCZTKjZQ6hhc1hyV6zeXR6a0pzYUYiwfJKnzsunLN11kqcsV+SjI1JIfiCP+XLYCl8cqKpI8no8+sdeZB3X8t8cjcAnR+m67MxOLorHTLrZMUH7g4GV7uJb37g9SsVNAW/etsLfdj9s4oWbTVgnOZyMylrQ3a6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789147; c=relaxed/simple;
	bh=VmmIwWAZs2XrvDioz2ricI1w5TvCiE3nFAqpoSKdN1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqJ2vf+xhe5XCJJ6UYTCOfrCLkBLtJF1kdrGdnNGXHguMwYf7KVOYZXJmYLYH/e/5PJxEMgUQkdUJixBKT1GJJc/RRPWl0K4WxUqhoicy4BK/UUqRFhp/nshKGLb1FfLttLVEu4rh0o1blBfgySxu7zZP6ViVWhmj+DaZ0rtxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=jEcXE4eT; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="jEcXE4eT"
Received: from email.seznam.cz
	by smtpc-mxd-8df7dc6f5-mtdcb
	(smtpc-mxd-8df7dc6f5-mtdcb [2a02:598:96:8a00::1200:70a])
	id 4ea4a271ce43c8ec4cd09c1f;
	Mon, 07 Sep 2026 15:52:18 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
	t=1788789138; bh=hO6PQptaqnXduKDymaVKrGlalUDM+bzewjF/ziNZ60A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=jEcXE4eThq0ndabPp4k2YJEUkrGEZStXPH8V1wnjFkEN/ijRr04HX/ZYkRcKcQv30
	 u9sZWVVvC1bGeVSC/9drQ2aY4lYjXmS5435R6UZ9rYf9wTERDRxgNGFSWLFm3pfGT4
	 mxM/kNA1ELgrCEHvEFijkL6W8Rwx4b/VavSvuCb6sbu2nqnbz/i4SPUCM4mnF8mkLr
	 J8oDJ/8rZ970aShRFe1nAdQC8/4T1MFpqfIUWOKHJAcINMh7UhHMt9MPCNAlqjnWQT
	 NWYVX+ECI7SngqA97FvEc4gEYrG4FTQjKhAnl4xeLmY4DZ2ehoiuQHNyt62KGfUpA+
	 Jjlexg+JujlWw==
Received: from arch-zen ([2a02:8308:b086:3c00:3636:4bcf:b8c2:e5cf])
	by smtpd-relay-6ffbffc97b-l7tfj (szn-email-smtpd/2.0.82) with ESMTPA
	id 7ac88cff-13b6-4dc0-ac43-2373edc9c4d7;
	Mon, 07 Sep 2026 15:49:47 +0200
From: "Jan Havran (Advantech Czech)" <havran.jan@email.cz>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jan Havran (Advantech Czech)" <havran.jan@email.cz>
Subject: [PATCH net 2/3] net: dsa: lantiq_gswip: handle SPEED_2500 in gswip_port_set_speed()
Date: Mon,  7 Sep 2026 15:48:17 +0200
Message-ID: <20260907134818.16670-3-havran.jan@email.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907134818.16670-1-havran.jan@email.cz>
References: <20260907134818.16670-1-havran.jan@email.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mxl-gsw1xx driver advertises 2500BASE-X on its SGMII port (via
supports_2500m and gsw1xx_phylink_get_caps()), but the shared
gswip_port_set_speed() has no SPEED_2500 case: at 2.5G every field keeps
its initializer, so mdio_phy = 0 pins the MDIO speed override to 10 Mbps
and no data passes.

At the MAC/MDIO level 2500BASE-X is identical to 1 Gbps (same wide GMII
datapath, same speed override); the rate itself is set in the PCS and
SerDes, not here. This matches the boot loader's PHY_ADDR_4 = 0x32A4 for
the 2.5G strap ("1 Gbps or above"), whose SPEED field is
GSWIP_MDIO_PHY_SPEED_G1 (the field has no encoding above G1). Share the
SPEED_1000 arm via a stacked case label. Its mii_cfg value is a no-op
for 2.5G: gswip_mii_mask_cfg() writes it only for the RGMII port
(mii_cfg[SGMII port] == -1), which cannot reach 2.5G anyway.

Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
Signed-off-by: Jan Havran (Advantech Czech) <havran.jan@email.cz>
---
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index 0e8eedf64d3a3..6150dc3ffb641 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -1339,6 +1339,7 @@ static void gswip_port_set_speed(struct gswip_priv *priv, int port, int speed,
 		break;
 
 	case SPEED_1000:
+	case SPEED_2500:
 		mdio_phy = GSWIP_MDIO_PHY_SPEED_G1;
 
 		mii_cfg = GSWIP_MII_CFG_RATE_M125;
-- 
2.39.5

