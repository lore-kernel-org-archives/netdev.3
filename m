Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C7400DEF
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732572; cv=none; b=Do7EIBm3fOSs+kS+JGiX+iYnkP51Dne5pUtbnun6/+UUKppVjuRF2/F7zeqhwgLsVjbqu1mskAWIOAmi5uSC23xoLtQQwM77CRAuokGwv1Uv4al0YOX52Ihpdx2mLV8KFL4Png/KkSZQb6FhS+4wsPLNNzTe3e+OEx35tBpUiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732572; c=relaxed/simple;
	bh=DZwv1shl0TUtjDQMbmf7p8enNrlmK99dKcZ4kwPIp8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kh7Z/9aWvjXsUXi8GLQtGRdVDur+drV1wo9a987E8YZg39uX3+8d7TYoYp7Ftgm0mc6WBH7tfjaFk0KEC0j4iGenmge2tDMOo694D0Q1ITzXk6fPmFsVgmYDI3IFVIA8ZXnJ1Gl7s3wNlYyxF/p3qAm/I2HbCIR/r08/1iirhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ivU3f2kI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ti5b/xDH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivU3f2kI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ti5b/xDH"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAT50O2618919
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fv2kNiSYpp/mwiQNvruO0GBGKpPCowAj63Sbzft+biE=; b=ivU3f2kIK0Ljh76I
	FgOgCYj3RP56YFv9AeSp8Pg2gP9MTMQylPGFID9vV/P0u54+dfm0aXGjeoj2c1+e
	Mm0LGXDkpHmTCM/TustbjzABJArVMcOpvyjaP3GjioJeKXMbcZODrFSSDKJIztRG
	BFPNKPeBhDYX58UhXVsgkmPe2KVD+87RnT66AziSePEW+MkIban+EkyCyd4Z0ynY
	baJ04vKLBK76qZSBoxiQj1ODhCpBCkimbUgugOkD9C0JJbnDs6NbkU+rsGDkpUTi
	uY5aDFwETygNDofFmehsneUdpFbLuC6hcvBCltLOPApWikVOGijnsQEnvr6PjfUZ
	e1cCrg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkrb8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:29:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e538afe65so124223085a.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 04:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782732569; x=1783337369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fv2kNiSYpp/mwiQNvruO0GBGKpPCowAj63Sbzft+biE=;
        b=Ti5b/xDHNvuvkzfG1dm25camZrUkNoBOWh3YS5e0KlTSzgYc8DQ8fiqUzLcwJUK/Cj
         J5SF4ct0ygx6HKkXlKVx1uJvjDXcIM7zxuKXgKelLjG2vks9IiyAEsMSYhj9Kpii/aVv
         1InKtb6578Ep9L5CnDAs+nNEkbyJgHcglhZqXKIwZqOW3Clzv4cFYztTJq/3xUarJlrS
         ZY8I5DxkVAhIGFpiWf2zvRfxSKBUZ3DJEiHsIJwNoNmgt+EhQjbJ6QIcz8b+5lxhh2OO
         ERsVzRuQfoIMy5PE/1pk6EDo37kGpDreWiiUWASY/UAbynWLvUpVTXVrLAMngQe/9kfC
         Teiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782732569; x=1783337369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fv2kNiSYpp/mwiQNvruO0GBGKpPCowAj63Sbzft+biE=;
        b=KKDoRTzUxyGQKW4VFFYO3WTMBrDjamgHYMa5g53OmIu9CdgC9HBCssKExEQX9d0ibC
         Eys/SzhzUYW2/lcRFMmqoOwMf8fD3AGhIPuPfqstovw+/dUUpQeo5VTD/J6OVSdTO6Gp
         AURqM/BZEli15aGIeI02n2gQNh7c2tK/6rogA7cB1cl+Bip3T4/Ai6bbAH7epK5wlju6
         AQowBoc1XSFm9Acxsr/yLpQLUBtdx771NjW/fiKPw2L4VpggfEw+7zq+8LmkeDTYlKCX
         AqQsB0M7wzLdJAbvUU+m+yqwqrkd/a97OqBzeMAbfLViPJPu7Y+t2jlOXHjriUD5x4/u
         8gSw==
X-Forwarded-Encrypted: i=1; AFNElJ+c+4QavoayDD355IUzsWuiDoevLGycSOg0GG3hoAkEYEiAo57UJLSnoxnYydlD/oJjEF8yRrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWAOC05MihS9rSkQDV+YpsVcwMOHmn+5tU59ctEAQxDdmA9N0
	rhKGQ/cKPv4E5d5w/JS7il5ino7P3g4N6qeIjcLlu3cX+reHoTdzcDFQ7XITGSnKgn8SFh4cS/0
	GgKp1PlLl/AdxH5kfPbTXddQlVRN8qDG8eOB1/1zPkZTliCJVGHzldnpx4Aw=
X-Gm-Gg: AfdE7ckNbuEj+EDOKAxImNJiwOpcf4iz/zGoacoYtGbMYZYxXJUg1caLeWFOFXzNOxI
	pHmXWiVsXQKOwlTdLTJh492hwNIi8U6cZRRODPftXTXkw1HBTdiRo8cE/o0PMX3EuI2yU2jOlS/
	p1fWEMZ5md2jUO0dg2T9cXIM9RigUM6JISIc1SLEN3tjgAISIYiaAXPu8M1A3moCJ/Oszi8XrW1
	hbEgbepdudANLUIpf4Nneji8hOyhu8Qu4ZCjOhNUxiGhhUsSKDAbSDQKVD2YycYW+eP1JrnBaQZ
	P4oSe53+vffgN88ZZDvrV5ZjB5CRFr15azPUaGxkoLCYTo/0EecfVork92SPXkZxf373VXxpl1e
	TducK3vlbQPHyXL/G3cBnw+Kr9UFZF3W26Gj5Obxy
X-Received: by 2002:a05:620a:690f:b0:92e:4927:2002 with SMTP id af79cd13be357-92e5f3fb821mr49158385a.39.1782732568812;
        Mon, 29 Jun 2026 04:29:28 -0700 (PDT)
X-Received: by 2002:a05:620a:690f:b0:92e:4927:2002 with SMTP id af79cd13be357-92e5f3fb821mr49152885a.39.1782732568285;
        Mon, 29 Jun 2026 04:29:28 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46d86960983sm41936351f8f.4.2026.06.29.04.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 04:29:27 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 13:28:51 +0200
Subject: [PATCH net-next v11 5/7] net: stmmac: qcom-ethqos: reuse the
 address of ethqos_emac_driver_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-qcom-sa8255p-emac-v11-5-1b7fb95b51f9@oss.qualcomm.com>
References: <20260629-qcom-sa8255p-emac-v11-0-1b7fb95b51f9@oss.qualcomm.com>
In-Reply-To: <20260629-qcom-sa8255p-emac-v11-0-1b7fb95b51f9@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Radu Rendec <rrendec@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5525;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DZwv1shl0TUtjDQMbmf7p8enNrlmK99dKcZ4kwPIp8U=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQlcBg3lJHOpD/iyl6NxqPQJAWAsttTGTu2YSg
 nXJOqFfix2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJXAQAKCRAFnS7L/zaE
 w93XD/94EURjyW92Q076vBk3y/FNJtMGv4PTfXVgN61+BGM7eBjjR70guIJ2GORayVk5wHwenme
 4bVyHsbZ4O+QdIbtu5yRxclXseP3of3/gdFi9N2p4T5JPZZj4ol4nJqXTlqlYP4p90hOmYijtwa
 Lp4U1/8Tn5eNBVFUAI3EER4xHN2AMlePB0JZz/P0KHIkAr3CYcI3AVktwt+lZ8t6rly7e7p4rFY
 mxStSGpMg+ynQYQKVjjq+aNOa5as2A38SE2oYM82nn+lJ59muOOI+dI9TStwO1kR5e06KKdYKZi
 VvjmeWd1Zh+AxfU4xNkN7KVMCRR7uER1lJ21Ve/4VlHEKWLkBK48HvITsgCFjaPJ3nBfR1fm3Pg
 w9/83fOXXWrjO8GorHFPBnLwd4Y+JBRFWC0vModu4ZPzPrAKGYfkY00Z2xUhFncg0FdV8t1zLoO
 komFrMYihlGM6sMzyOeo5B7QpALzxlZBKzCUzh2F+3wLpALLgw0lrvAJhORgQLChTva1206Ko5D
 9sMZQQylfsMBhoPgFojLMoFDAYtRDYdpW61i0LhpDMxie+/5DTr4SFbfLAPI1fiq/306luqvEIC
 Bxt41nrp4i9PHW7iULBhTzqoTqAtwc7LV3l75poXpja5Hdz9TrIIG7mRMgxIyGuB9iu9qQyBL5s
 /l6XJFHBczkbAFA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a425719 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=uYDRVFWwO1WiFYTZPIgA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: x_JzF46qENkIFm4fssh9kKmC2E_Rdonv
X-Proofpoint-ORIG-GUID: x_JzF46qENkIFm4fssh9kKmC2E_Rdonv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5NCBTYWx0ZWRfX+ISz7eQKa3he
 9smtSZI6gINYfTDKoMtNhorrvufAtR0zNi6k35jqEjVXDOPkNjltgdEGWdo6XbIXNha376aD3fu
 E+8SjoYC/LyhyCTxVpQsGY2SCXenOYAkh7k7uOrjpEcicQLOMpqoJfvc7WWpP8fjfu5G2cqoo9l
 ZmlJzWl/fSu3rW2dPEZrhHkOWTJEByJZTr6DsnF0G++eeNQQu43GwLsYJfK84umW7Fg0zUamI8r
 CHyuwHOM+2TuVVNkCN86JHNDBYkovodzuvOGosF1rdIQbqncf54e7cMz/lw+PL1HDuTudzLxrXo
 yNdBtRyt64qbAIrYWxSogBxGGdzU9kzwpbALZEDsuxRlzdkbHg2RYLb2UuJJJPU87C93aP06xN1
 FFqUIzsRqhsS9pTfjEsQpB7XFANedyusWRqVe+e19Xe9ClNB4RqB03by11+I1bwSvz+rmfAcWZZ
 BHuK9zpVhsmD5T/Y9qg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5NCBTYWx0ZWRfXzD6v2DXPNuSM
 u1OaKjshTPSu21iIVrcC/Eyq08xwKnkUz11JXrtywRmHo4N+eQWTjDOTMOT38P44Ro1+iPAFbaY
 +VT3IuN0d+YsahMLavEcsOJHbb1Fmhk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290094

Instead of needlessly copying the fields of ethqos_emac_driver_data into
struct qcom_ethqos, just use the address of the former as a reference.
It's .rodata after all. This is done in order to avoid having either two
calls to of_device_get_match_data() or having to extend the latter with
another field when adding support for SCMI.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 37 ++++++++--------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 47b70b5e706f221c01f1c0ae3b1acafae6641165..fa3447b90315672d706d5ce7d710bdec6214e4e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -103,12 +103,7 @@ struct qcom_ethqos {
 	struct clk *link_clk;
 	struct phy *serdes_phy;
 	phy_interface_t phy_mode;
-
-	const struct ethqos_emac_por *rgmii_por;
-	unsigned int num_rgmii_por;
-	bool rgmii_config_loopback_en;
-	bool has_emac_ge_3;
-	bool needs_sgmii_loopback;
+	const struct ethqos_emac_driver_data *data;
 };
 
 static u32 rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
@@ -189,7 +184,7 @@ static int ethqos_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 static void
 qcom_ethqos_set_sgmii_loopback(struct qcom_ethqos *ethqos, bool enable)
 {
-	if (!ethqos->needs_sgmii_loopback ||
+	if (!ethqos->data->needs_sgmii_loopback ||
 	    ethqos->phy_mode != PHY_INTERFACE_MODE_2500BASEX)
 		return;
 
@@ -322,7 +317,7 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
 	/* Set DLL_EN */
 	rgmii_setmask(ethqos, SDCC_DLL_CONFIG_DLL_EN, SDCC_HC_REG_DLL_CONFIG);
 
-	if (!ethqos->has_emac_ge_3) {
+	if (!ethqos->data->has_emac_ge_3) {
 		rgmii_clrmask(ethqos, SDCC_DLL_MCLK_GATING_EN,
 			      SDCC_HC_REG_DLL_CONFIG);
 
@@ -352,7 +347,7 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
 	rgmii_setmask(ethqos, SDCC_DLL_CONFIG2_DDR_CAL_EN,
 		      SDCC_HC_REG_DLL_CONFIG2);
 
-	if (!ethqos->has_emac_ge_3) {
+	if (!ethqos->data->has_emac_ge_3) {
 		rgmii_clrmask(ethqos, SDCC_DLL_CONFIG2_DLL_CLOCK_DIS,
 			      SDCC_HC_REG_DLL_CONFIG2);
 
@@ -432,7 +427,7 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
 	rgmii_clrmask(ethqos, RGMII_CONFIG2_RSVD_CONFIG15,
 		      RGMII_IO_MACRO_CONFIG2);
 
-	if (speed == SPEED_1000 || ethqos->has_emac_ge_3)
+	if (speed == SPEED_1000 || ethqos->data->has_emac_ge_3)
 		rgmii_setmask(ethqos, RGMII_CONFIG2_RX_PROG_SWAP,
 			      RGMII_IO_MACRO_CONFIG2);
 	else
@@ -456,7 +451,7 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
 		 * in practice this becomes PRG_RCLK_DLY = 52 * 4 /
 		 *  (2 * RX delay ns)
 		 */
-		if (ethqos->has_emac_ge_3) {
+		if (ethqos->data->has_emac_ge_3) {
 			/* 0.9 ns */
 			prg_rclk_dly = 115;
 		} else {
@@ -472,7 +467,7 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
 			      SDCC_HC_REG_DDR_CONFIG);
 	}
 
-	if (ethqos->rgmii_config_loopback_en)
+	if (ethqos->data->rgmii_config_loopback_en)
 		loopback = RGMII_CONFIG_LOOPBACK_EN;
 	else
 		loopback = 0;
@@ -495,9 +490,9 @@ static void ethqos_fix_mac_speed_rgmii(void *bsp_priv,
 	dev = &ethqos->pdev->dev;
 
 	/* Reset to POR values and enable clk */
-	for (i = 0; i < ethqos->num_rgmii_por; i++)
-		rgmii_writel(ethqos, ethqos->rgmii_por[i].value,
-			     ethqos->rgmii_por[i].offset);
+	for (i = 0; i < ethqos->data->num_rgmii_por; i++)
+		rgmii_writel(ethqos, ethqos->data->rgmii_por[i].value,
+			     ethqos->data->rgmii_por[i].offset);
 
 	ethqos_set_func_clk_en(ethqos);
 
@@ -511,7 +506,7 @@ static void ethqos_fix_mac_speed_rgmii(void *bsp_priv,
 	rgmii_setmask(ethqos, SDCC_DLL_CONFIG_PDN,
 		      SDCC_HC_REG_DLL_CONFIG);
 
-	if (ethqos->has_emac_ge_3) {
+	if (ethqos->data->has_emac_ge_3) {
 		if (speed == SPEED_1000) {
 			rgmii_writel(ethqos, 0x1800000, SDCC_TEST_CTL);
 			rgmii_writel(ethqos, 0x2C010800, SDCC_USR_CTL);
@@ -538,7 +533,7 @@ static void ethqos_fix_mac_speed_rgmii(void *bsp_priv,
 			      SDCC_HC_REG_DLL_CONFIG);
 
 		/* Set USR_CTL bit 26 with mask of 3 bits */
-		if (!ethqos->has_emac_ge_3)
+		if (!ethqos->data->has_emac_ge_3)
 			rgmii_updatel(ethqos, GENMASK(26, 24), BIT(26),
 				      SDCC_USR_CTL);
 
@@ -743,11 +738,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 				     "Failed to map rgmii resource\n");
 
 	data = of_device_get_match_data(dev);
-	ethqos->rgmii_por = data->rgmii_por;
-	ethqos->num_rgmii_por = data->num_rgmii_por;
-	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
-	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
-	ethqos->needs_sgmii_loopback = data->needs_sgmii_loopback;
+	ethqos->data = data;
 
 	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
 	if (IS_ERR(ethqos->link_clk))
@@ -784,7 +775,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->dump_debug_regs = rgmii_dump;
 	plat_dat->ptp_clk_freq_config = ethqos_ptp_clk_freq_config;
 	plat_dat->core_type = DWMAC_CORE_GMAC4;
-	if (ethqos->has_emac_ge_3)
+	if (data->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
 	plat_dat->pmt = true;
 	if (of_property_read_bool(np, "snps,tso"))

-- 
2.47.3

