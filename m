Received: from gz.d.sender-sib.com (gz.d.sender-sib.com [77.32.148.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12805346E6C
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184974; cv=none; b=qDlLEoN02GhX4FNtmUFoIBffVt00UzClK36/ZgMdsUlAXUcyVAzizo/nIAyCtPmQ8jU4NWTlVe1DRQ/9sqNfia+0AGBZQ2IpLjtC300PmKUxhL2ozaHpJrtZgsLJ0WsZGcYSXdISGtdQ5JYcs6GVPExpK7Pc97xGJi8oPCJC6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184974; c=relaxed/simple;
	bh=PQyNIlOEDm66wivbis+FB0+y9+2L7VT5AXJF6w23/QA=;
	h=From:To:Date:Subject:Cc:Message-Id:Mime-Version; b=rbRTW1X4ngmR7+qtAKcp9adI1bXmNdsiJdRAhHOYEhJ0dy0OSLJS+j/KuXbuY1txRRwgfPkrI/cZmzaXbT0OAbnZytPK0y/TPJIOaQWe66azy+O1s3RewKt2lvzuKEo0M7U9lPrmPTWYGaykuTPjIoWO7M+dDBFOdvoqoL6BGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gz.d.sender-sib.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=Q5ZlqCaa; arc=none smtp.client-ip=77.32.148.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gz.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Q5ZlqCaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 q=dns/txt; s=brevo2; bh=YEZA28DCAkovTIOKhUBwjAgpO1kMhVmk8JXg7hYn5rw=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=Q5ZlqCaa7H4WKaRCsC/JwZcT5+KA4RIvkWyFhFuGCMrSYPJu2KJrILvl7CMOMPfmA/t+m08BjrWY
        PdAULQ88ZStHcnQVN6WTvihNtFXpxve7LSYTYYdaz1wjgjBY0kPYF4HjYOOf3UUqNUYUZj44OXv7
        ZJG8e5z+kyy41YuK5zSM5eCPEmR3PYtQvWfOt6w9c0sHxttIbou5I+mYHXAgwT+LpSLulgEa+bl4
        roDl/Z8sAHrFBih6IMiugwm3rDEANS5jX/KoV0goCWPZZXmMf/+k6/VOh3yvHx9tS9HvRqpYHnXk
        6UAYDGQDskxISybQaV9/2s+ixIrjeaIr8q3FTg==
Feedback-ID: 77.32.148.26:11677070_-1:11677070:Sendinblue
From: "Jiaxing Hu" <gahing@gahingwoo.com>
X-Mailin-EID: NDg1NjE3NDAyfm5ldGRldkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYwNzE2MDY1NjA2LjI0NjYyNjctMS1nYWhpbmdAZ2FoaW5nd29vLmNvbT5%2BZ3ouZC5zZW5kZXItc2liLmNvbQ%3D%3D
To: <andrew+netdev@lunn.ch>,<davem@davemloft.net>,<edumazet@google.com>,<kuba@kernel.org>,<pabeni@redhat.com>,<heiko@sntech.de>,<mcoquelin.stm32@gmail.com>,<alexandre.torgue@foss.st.com>
Date: Thu, 16 Jul 2026 18:56:06 +1200
X-sib-id: ZkMGWrb7DRvtdtg_na1qu0_X1MYYsVQPZHsCmoV5RSAAZYxowEb5EBfR7CT9KzxV6Cd-f96mxN45D_yozb5GXq4R26W1v-fDe4Rg9601F6KC1qcwq93g-9gHfWrLNkGA4XJwkEMvJS5wJVzdbzZjfyYWb3EW0a_FG3BTemKviJeBA4H-CQ
Origin-messageId: <20260716065606.2466267-1-gahing@gahingwoo.com>
X-CSA-Complaints: csa-complaints@eco.de
Subject: [PATCH net-next] net: stmmac: dwmac-rk: enable the reference clock for output mode
Cc: <netdev@vger.kernel.org>,  <linux-rockchip@lists.infradead.org>,  <linux-arm-kernel@lists.infradead.org>,  <linux-stm32@st-md-mailman.stormreply.com>,  <linux-kernel@vger.kernel.org>
Message-Id: <02ef3409-4078-4c3a-8c17-cb1a7f1f07e4@smtp-relay.sendinblue.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable


rk_gmac_clk_init() only requests the refout clock group for RMII. The
ArmSoM CM5 has an on-module YT8531 RGMII PHY with no crystal that needs
the SoC 25 MHz reference (clk_mac_refout), so in RGMII the clock was
never enabled and the PHY did not respond on MDIO.

Request the group whenever the SoC drives the clock (clock_in_out =3D
"output"), not just for RMII. The clocks are optional, so other boards
are unaffected.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/e=
thernet/stmicro/stmmac/dwmac-rk.c
index 8d7042e68..dd060e4b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1112,7 +1112,7 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_da=
ta *plat)
 	bsp_priv->clk_enabled =3D false;
=20
 	bsp_priv->num_clks =3D ARRAY_SIZE(rk_clocks);
-	if (phy_iface =3D=3D PHY_INTERFACE_MODE_RMII)
+	if (phy_iface =3D=3D PHY_INTERFACE_MODE_RMII || !bsp_priv->clock_input)
 		bsp_priv->num_clks +=3D ARRAY_SIZE(rk_rmii_clocks);
=20
 	bsp_priv->clks =3D devm_kcalloc(dev, bsp_priv->num_clks,
@@ -1123,7 +1123,7 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_da=
ta *plat)
 	for (i =3D 0; i < ARRAY_SIZE(rk_clocks); i++)
 		bsp_priv->clks[i].id =3D rk_clocks[i];
=20
-	if (phy_iface =3D=3D PHY_INTERFACE_MODE_RMII) {
+	if (phy_iface =3D=3D PHY_INTERFACE_MODE_RMII || !bsp_priv->clock_input) {
 		for (j =3D 0; j < ARRAY_SIZE(rk_rmii_clocks); j++)
 			bsp_priv->clks[i++].id =3D rk_rmii_clocks[j];
 	}
--=20
2.43.0



