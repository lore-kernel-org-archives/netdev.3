Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3583D9695;
	Fri, 17 Jul 2026 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271597; cv=none; b=p05W7hAc/sSuAbICaA0L62F+xmwNCiDVVn1RxXDenAv2LbCr/9GyyQaXgDkYARaA3bsjAVggV/IXYUgSvTYOA3n/MDcHQSGKD19FhRxrkEMbLuIEmtXTO+kvdacFz4i2K02NvBooEF9wCpPitO/pD5ywMz1ba9tZmcfKM9fAGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271597; c=relaxed/simple;
	bh=kFHCrQHc321zynVITXaL162igpcjTuOc6p+EGhQzzLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avVQN5mv16szSgb4VYGjWglpRhjSxt+TRhkBEIf41H9g/UoAYZVrni0HUawgE9FvPI0cwCW9QwjASJIB9MYiz1tRbBwqryogD/tjecZzg9DAhOwfGp9/Kyb714d4PzPa/foA9AnC3St8D6RlMjNfqLoiDDY627LePtDis+fin2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=kbFlxD+e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BNKZlXH0; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="kbFlxD+e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BNKZlXH0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id AF23E13002E2;
	Fri, 17 Jul 2026 02:59:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jul 2026 02:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784271594; x=
	1784275194; bh=uIIyMwAcqVkt+px899RrpC9+Fguty7npn2U4kEL+f9I=; b=k
	bFlxD+e6niwqY1tiKSQgm/1EIA4GgO5TGNo3Ufd6/kR66jIfwM2fFGBj0koX5z5q
	Dism3PjcU68iYVHm+MwOHuFBeb/u+RCTAabsxKjmuwSU/lBFzXmR7zFaZhhjnQok
	WlGfSgKRv69HuNf7nAe1YWbUlS1H6FlTbomB0aUqS5vVkMUsxUY320wAc2pYlz17
	Fpn3VFuSpAIm+v9mGCPFgWCCbtiAkcUxZb15EnoQihNu112G91b7MEDWQeSxabr5
	jijsCmstZiNWbRrjKYyiz7h1q8zTPJgwvb79HxF2XhxwmN9uvZ3LdjMMmKjvRfme
	JT+9YSHaJhcAJn+Z7w1ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784271594; x=1784275194; bh=u
	IIyMwAcqVkt+px899RrpC9+Fguty7npn2U4kEL+f9I=; b=BNKZlXH0gVneubIGH
	mFSun4XmlX1ytpbO6oONoaytREBXZ5TILPagxBvqFJjuFiljM3CdFT6Ycq9d0WsV
	A1NbxTPAaeyw4SEqr0Nq6msxm/ZWxrnkKrpJBoNH/fzCXXjeXZUgnDmiZ24gopvD
	ndrnswzJ5364Hfwkub3Jo+Km2/rU9DPEO3jvab9KMmZlMne5au17djpJf0BQyOSt
	I0XZEq+mg+nTuZ5GyimpRFQziTJPQTrqfEFgNX+bWWDOzy7pIneKRLDeuYpoPWS1
	Qi3Y9wxNhX+2xOvKjEwW9wZp6i3PB93XdbSGP3NQHAxQFgiIRyQwEjExfO3zaVwr
	onxHA==
X-ME-Sender: <xms:6dJZavRlkMW0NbTaeSeChRgGs5yGU-zIyQl5q1VviSg7AiYEVT82Jw>
    <xme:6dJZamUAuCKyf6FNzK5yoSmdkwoiSE2lU4fH6sqkCGydLunDAVisLxyJvlkfSTCpF
    GYU9AMYFTfTzZMGJk2HqMeIcxnDNwYsGrZrycf6WMTKTmpNXrDWwxM>
X-ME-Received: <xmr:6dJZauZwICAickm7FAz-MwwjbTxFQqReKFnFtb8Yg0rbmMwe8Ct1Nou4NQIJ2lmefLEG4Tn2H_sLTWsF9EE>
X-ME-Proxy-Cause: dmFkZTGLHoAYSuSv1o2npO99y2j4JkxLBJgWvGtMoWzVR091WtPJ1Xci9p6O9uorqIXytS
    qgiXLBX5pDi0cPzeDICNt6t/BjVh6mt6bhnC1C9CdJS3gO9mNnV/Rt+6btcqroSenMILop
    voSGMzPtXFidDk7Dp2YoPeT50jUo5Q3onDmNotbFDoLJF/D3BCYCo8e2eP7pyPHIz2TSZC
    jsi6aJHydnCg5nKTF+BekS20EeckpNO8KO0n0tfCCCM8qMgu4tlj8ReyNRU5j9Oz6Mh4EJ
    V2sIjpMsj8gCmoVqK3xuHwBHpYYmhbaxejpxfiWeEKyUfqC8zJxs1qeJl6zVpKllXpKBAI
    QmsQGq4Oe2fjIaSKONDkMpKaNQ/2YbfFu+2VjSH2vvfAged8qiT9ds2xi/eY8zrSKZo5Xg
    UiVX3GqojPDOBM5zZ44nwJ3/64hUfSF0NyO0S9a+k1v9yw3TIJYTc/GX/JoTQKYnQ8mI8d
    ZRrfCFDUtkEYgHzp5cp/a06g33DHbP+MqCfQqXKerG2CIgRGWJjesR2pQ5WwJuJMOJIbbP
    8hDmdi8p4vh1jVXx/McSWsg8az8VLn1glcMKnFg8y+1I71PNsBw33mFvn9tgej2PaYXO66
    orGyfrxUtH0EjJh49PqzjQoD+mJcjYaIbMqNePw3LkPCO/j1Nwx+Z5O5Q8qQ
X-ME-Proxy: <xmx:6dJZav7zzDpx9N6eKLYUKPJIIt1uIQDJfiVTzcKYxfpnhqLixBzYAg>
    <xmx:6tJZavwyntRMBuSkL4nk0MHdy82GjmMvr76P_DfHVPiRPBn4icWJ5g>
    <xmx:6tJZagpp4AJeO4OtthoY967j-nEFoE6ltw8BcpmchyHkmWlXpg5RKg>
    <xmx:6tJZah3zIilp_R68NwDQ8hC60IKKl8m0ir457Jst1g43Buc1OOywUQ>
    <xmx:6tJZarXOw0kr_HPfYTZIKSmSO_ZfZq9RlpAezsULLPC-3Z4JNTNQCL1L>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 02:59:49 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	heiko@sntech.de,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH net-next v2 2/2] net: stmmac: dwmac-rk: enable the reference clock for output mode
Date: Fri, 17 Jul 2026 18:59:33 +1200
Message-ID: <20260717065933.2629501-3-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717065933.2629501-1-gahing@gahingwoo.com>
References: <20260717065933.2629501-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rk_gmac_clk_init() only requests the refout clock group for RMII. The
ArmSoM CM5 has an on-module YT8531 RGMII PHY with no crystal that needs
the SoC 25 MHz reference (clk_mac_refout), so in RGMII the clock was
never enabled and the PHY did not respond on MDIO.

Request the group whenever the SoC drives the clock (clock_in_out =
"output"), not just for RMII. The clocks are optional, so other boards
are unaffected.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 8d7042e68..dd060e4b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1112,7 +1112,7 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 	bsp_priv->clk_enabled = false;
 
 	bsp_priv->num_clks = ARRAY_SIZE(rk_clocks);
-	if (phy_iface == PHY_INTERFACE_MODE_RMII)
+	if (phy_iface == PHY_INTERFACE_MODE_RMII || !bsp_priv->clock_input)
 		bsp_priv->num_clks += ARRAY_SIZE(rk_rmii_clocks);
 
 	bsp_priv->clks = devm_kcalloc(dev, bsp_priv->num_clks,
@@ -1123,7 +1123,7 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 	for (i = 0; i < ARRAY_SIZE(rk_clocks); i++)
 		bsp_priv->clks[i].id = rk_clocks[i];
 
-	if (phy_iface == PHY_INTERFACE_MODE_RMII) {
+	if (phy_iface == PHY_INTERFACE_MODE_RMII || !bsp_priv->clock_input) {
 		for (j = 0; j < ARRAY_SIZE(rk_rmii_clocks); j++)
 			bsp_priv->clks[i++].id = rk_rmii_clocks[j];
 	}
-- 
2.43.0

