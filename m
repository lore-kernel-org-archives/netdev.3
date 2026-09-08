Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12469552925
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879533; cv=none; b=AsDASjVsrHH8eWyAm+DKO2cY2j2dm6Xz0IwikRqEKlZCQEE8VG5dyxBpNrjB5/BRGeuJVgBxqF06f/2Dbk6ju7w7l31EyPDyEAZ9RFBXV63S3IlrNDi2zTZ1fe4Gx5NwKvRKVbkwckZyGU3gz0VVopTwrPeH7HBvO55PfXBrqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879533; c=relaxed/simple;
	bh=UGHFNsex6g8X5xVVwk+2JQcFTMSBk5UzaI5QwWng/ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rYbQewVu2Hkq0kReSXIKLehX1AKHNaaiTHB5p+JaTvmEMQMsUVct+AVMbd2w6W7C1/n3gM9lnpF5GOv5GT7+WNxf3Tf2gJEdt69FR5koqw2yb53I1QP398iKzMTbhkdLYPaGCLtP/5uCQ2yqDn8W6ENEsKhtC3ycKPOJyPur5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fhZ9/+Fc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hVt+oEJC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fhZ9/+Fc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hVt+oEJC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688EivPg3298153
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 14:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9gGv4RW/KPav2gQfSDhKD53xcmE10Fw9benIy8+8ItU=; b=fhZ9/+FcBma2UoTD
	yx8RiDGQeA89UBrkt9HPmeDQphCeVPkDcs32VvlWRAPLbF2a6j0sxvPqmQ9cLwOM
	UFUXxq3izFvQ1vHgFMoV6rgrni91hQ6lksUJA8i0aH2xd1+ahoZacW2K0BC6Xk7k
	NX2gru3rpj4ISqhJ58WWbSaRntSTLMIvZzJUqdGTW6weR3hxwXVTnBuUm/HJ3Fng
	V+MXtKLytbhBLNYYvjwopmM8PBfHDE0vB7pN8sLyYGKVVQkhHFxw9bdwMzVmO9mQ
	tds0I3JpTcfs0vgbQUclEiHvO67alIqeyhDj+CVCYpbBBUfQaxYylQMSH9UJzhDT
	LiuN0g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjhkj0wxx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 14:58:28 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97ca6578487so3467276241.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788879508; x=1789484308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gGv4RW/KPav2gQfSDhKD53xcmE10Fw9benIy8+8ItU=;
        b=hVt+oEJCUVb17O9n4xlUTCPgzNjpKJ85H5TSAU0RG3e0knhWlSkk2OLnXzhEmdwtBB
         aNH41PAR7Sw7M2+ZlhoZ8P6XRBas1SaOU33VuvdGUNZg6VbUUA4MyYKm9uc322TvHEWR
         4SEYtOvPTuNXFXj1dXofnJQe8ciKVnZQHBxO/5ZqfbYve+GuvkIWJV0+gN1OPKJt+YNz
         Q9Z6q/qXfonUuFsNOoENb91XxK+a05wO4uxatbClEslGP/vgzdYnv+4334qhK4YTZiCk
         xOh6vO5Lk2aDWqXqPiBcEbhFk1Iz6TCNtHuZbpfBHaXPEkRV7Y6DnD3+/Ewfl7/LMkyA
         cvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788879508; x=1789484308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9gGv4RW/KPav2gQfSDhKD53xcmE10Fw9benIy8+8ItU=;
        b=OfwMTPGXFKXrWoJaQNnrdErUxZgrqOaKwD5z0NbgQapRSUxhQKMr1nYuz/RZz5J2ia
         +iKEU9hLLjnd+C1Qe1MsGfBK2GyuuaN/zmxLknVCrAw34IBM9UChiOYZQySi0249YS9J
         A2bK515JVDeBip9TnXzZ4vFA1tuj4kC327weEmFRq2Ndh4tMV/tWKEZpAkWlvsjZciUn
         nvDzjTZRlQz8FnwrRzR3MbroBROnHa1z98k+gxwLW2lnA8MBJu8VqyJOfR1xMoJRkDbd
         D1gVflD3aa2YfN/ZPZ7RegVzQd3tP+ja9gHmNVkVz/iYLQVQGbtQrxi1+r/g+wR41mzK
         7PGA==
X-Forwarded-Encrypted: i=1; AKwUvBxY8KuG/QrDoAzykd3kHAc0PS0ojHGEgWgXceqPqTMwo/yDoM1rx1C1C/CAhXfrh91Sg68QTxE=@vger.kernel.org
X-Gm-Message-State: AFuF++kddfaZsSbKc6pCRVKEKwR49WT+Kr9xs8y0/tz6AsEeD0ObG6ly
	GVtPDqGy8ZCM9woNrGBhSiInfwXSSn1cYxTG1cdUB0gos10XBOweY2p5OZr8tQBKfZ6dU/lmE80
	JeJ8Qwx08EIbKhSWmRg6QqPA0Xv8LC8ZpvZ48Yw8xbuHcl60pTwFAFBmH2y0=
X-Gm-Gg: AYBFou3iR1z6szjvdgYUeS+RCWKbBGBQxpgW+AoSzWXFhmBsnSJLzJ0hnGmnyy/5frg
	Mwwt6SDUsMQvAjf9+1+lWlJ2Y8ApIyHXEey3FI3Qiit5sRJh3lF1Jm+3xMVeKxKQRc8MBAQuzEZ
	QGsArxpO3hwzoA1WwVrqqQfAdTL7pgpTnH+OxoEmaSU7P5KlFOBDROwK9Y/goKszQqe/b0kWXcH
	nKP0l04ZwaKCsX0A43MaNA+wik1WII9Q2S8oD9j03fYvTgi+zE78taZK2cdlgHIZfWty8cPW8a2
	MsPpzvykx3t/g7KxpH6B2BF5uS6IEO3BRWyxxaBw6zxeuKN64z9XYdtMmF9WlZg7D4H/ahzuR5A
	WVUGqTsKlyYKPFpARLiLo6A3MgSON
X-Received: by 2002:a05:6102:509f:b0:785:e444:15e4 with SMTP id ada2fe7eead31-78a4a87d391mr13120751137.6.1788879507824;
        Tue, 08 Sep 2026 07:58:27 -0700 (PDT)
X-Received: by 2002:a05:6102:509f:b0:785:e444:15e4 with SMTP id ada2fe7eead31-78a4a87d391mr13120696137.6.1788879507318;
        Tue, 08 Sep 2026 07:58:27 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a2:f118:df09:fe51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485958f1493sm25191276f8f.37.2026.09.08.07.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:58:26 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 16:57:29 +0200
Subject: [PATCH net-next v14 10/10] net: stmmac: qcom-ethqos: add support
 for sa8255p
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-qcom-sa8255p-emac-v14-10-ec212b747a7d@oss.qualcomm.com>
References: <20260908-qcom-sa8255p-emac-v14-0-ec212b747a7d@oss.qualcomm.com>
In-Reply-To: <20260908-qcom-sa8255p-emac-v14-0-ec212b747a7d@oss.qualcomm.com>
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
        Bartosz Golaszewski <brgl@kernel.org>, Radu Rendec <radu@rendec.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6330;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=UGHFNsex6g8X5xVVwk+2JQcFTMSBk5UzaI5QwWng/ec=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoCJwh58An3JjyYLR5ghJ2POhmXpnXTF5Aq10w
 hRnRD+AS9CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqAicAAKCRAFnS7L/zaE
 wzzqD/wNB0EOmwihyBQoJBkeJGz5FMWpEG6G05ZmuQCOHJBy9yuRIA0IYpAFJVVh0R2xGt65Mvg
 1MQG7oQ7bg0XiCrgkvpaArONbBNaRUEi4WeY5A/T1wPbjryezG373hNq8XnABg7vAhdtGptqomq
 YhujFfNG/QyLg+WkyRF38iPSzX8T1psLo04+zwETWsIOi2WhAXlSDTLKX4oZ+2k3UIe6Ob1KKS+
 ewa90enAY9Vg59g59B3cF6jEIlS5/LrCO6k4ZD++QsILFYtDdc+dpPGiUK+ls/8fsML3plS4n2m
 uSu44VH/gsdF+kObPrTu/R1sRy6PBgBbm4bTIEoCcN/71l2wn0l6kqHk5/9GG612Li7g/X1shGY
 tVdJmX/vKlfW7FW8JNqeH+WCZP3+OOQFjh1tMNb4sP6UY9n8hQKZySXfoi7n9WE6hBZes71QzvA
 T03MzqHs/S1nQ7ehZI9T5+iVJcnRY/tFoQyiG83sLhuxiCQv4jVYsGo59yMM9loQAikUJBIb+jE
 /16rowut5V6Z717SIZLwK/vrUMGTHSzCSFSpqIsWcCllmDuIMtXUlcbbtIKJ6HlflhnH0vBdfcC
 ARn8vAY/QQLk8x2nI8QMFZoxMJSe2pvOr05TveDFArlHnjKoz4zMmM5AEo9Ml+4g2rrpRlP1+RT
 5in0Rpl5vuCYcHg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2MSBTYWx0ZWRfX84s+oK8tuleW
 l4b9a8edtBlTN78yVOn7rhue8UUYvK9grJUuUOTgwIY0/ulLHUGiR/MV0tS/neAEgC1feSnlKhw
 PiaPwruRtR65ld6iOl+E/LHfDUpMZhs=
X-Proofpoint-GUID: JVJuMzfSEtVYXh33poyXS352ZY0_eklR
X-Authority-Analysis: v=2.4 cv=VYjH+lp9 c=1 sm=1 tr=0 ts=6aa02294 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=MNMbB-VoU2yS88OP0PEA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: JVJuMzfSEtVYXh33poyXS352ZY0_eklR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2MSBTYWx0ZWRfXwOBmEL2cQ86l
 ocTRx1K20r5bIMRaQkVk8OlAmdiogIc3Rt5Jb5Zb6Sjl/s7cazym7YHc+gw61bISsaYvJEhfnqW
 fIJTL6pWUehfvdbwAI2x1C9X8rMhp4vu30gPwsrQ1NwiVvk7glkC8CTa+y1LcpHIaZZLvE+ZHEQ
 JMRYWzA++AkBXMsLCFy5t2My+m7Ws8OLG+KFmFI/CjCnPY6H/Ca3u0jZ3+WFHHStds1d2pS6+rS
 e1F5KZ1Kc/PEqKcJGta0gaJRneAkKGLVYeRjfu9m3tJWnG+VdWAmWdaZVoKhRK9TzRhyw3jHGam
 8sUw591+dxIhK858ynWBg24lN0V2SVGrRzUOMVKk3wJClpQZzUAKxYCcSk8xPqrYOdiRUqTnX3D
 7vWMGJykkQ1qymsvBAXe5unIfgT6HmL5mb1fX5I0XoXTwgxQl+xJ9yL+CLIf5FuMEdefNzB+Nbq
 J6GzErpUR6DHarspIFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080161

Extend the driver to support a new model - sa8255p. Unlike the previously
supported variants, this one's power management is done in the firmware
over SCMI. This is modeled in linux using power domains so add a new
emac data variant and a separate setup callback.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 107 +++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 509a5368e69a8fa440bf3b4f58f7b09a683558f3..3d4bc950a72ac0d0d9515bf9148e865463ddc0a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -98,6 +98,11 @@ struct ethqos_emac_driver_data {
 	const char *link_clk_name;
 	struct dwmac4_addrs dwmac4_addrs;
 	bool needs_sgmii_loopback;
+	/* Fixed PTP reference clock rate, used on SCMI platforms where
+	 * firmware does not implement the clock protocol allowing linux to
+	 * query it.
+	 */
+	unsigned long ptp_clk_rate;
 	int (*setup)(struct qcom_ethqos *ethqos,
 		     struct plat_stmmacenet_data *plat_dat);
 };
@@ -108,6 +113,7 @@ struct qcom_ethqos {
 	struct clk *link_clk;
 	struct phy *serdes_phy;
 	phy_interface_t phy_mode;
+	struct dev_pm_domain_list *pds;
 	const struct ethqos_emac_driver_data *data;
 };
 
@@ -207,6 +213,8 @@ static void ethqos_set_func_clk_en(struct qcom_ethqos *ethqos)
 
 static int ethqos_hlos_setup(struct qcom_ethqos *ethqos,
 			     struct plat_stmmacenet_data *plat_dat);
+static int ethqos_scmi_setup(struct qcom_ethqos *ethqos,
+			     struct plat_stmmacenet_data *plat_dat);
 
 static const struct ethqos_emac_por emac_v2_3_0_por[] = {
 	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x00C01343 },
@@ -311,6 +319,30 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	.setup = ethqos_hlos_setup,
 };
 
+static const struct ethqos_emac_driver_data emac_v4_0_0_scmi_data = {
+	.has_emac_ge_3 = true,
+	.needs_sgmii_loopback = true,
+	.dma_addr_width = 36,
+	.ptp_clk_rate = 230400000,
+	.dwmac4_addrs = {
+		.dma_chan = 0x00008100,
+		.dma_chan_offset = 0x1000,
+		.mtl_chan = 0x00008000,
+		.mtl_chan_offset = 0x1000,
+		.mtl_ets_ctrl = 0x00008010,
+		.mtl_ets_ctrl_offset = 0x1000,
+		.mtl_txq_weight = 0x00008018,
+		.mtl_txq_weight_offset = 0x1000,
+		.mtl_send_slp_cred = 0x0000801c,
+		.mtl_send_slp_cred_offset = 0x1000,
+		.mtl_high_cred = 0x00008020,
+		.mtl_high_cred_offset = 0x1000,
+		.mtl_low_cred = 0x00008024,
+		.mtl_low_cred_offset = 0x1000,
+	},
+	.setup = ethqos_scmi_setup,
+};
+
 static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
 {
 	struct device *dev = &ethqos->pdev->dev;
@@ -756,6 +788,80 @@ static int ethqos_hlos_setup(struct qcom_ethqos *ethqos,
 	return 0;
 }
 
+static const char *const ethqos_scmi_pd_names[] = { "core", "mdio" };
+
+static int ethqos_scmi_setup(struct qcom_ethqos *ethqos,
+			     struct plat_stmmacenet_data *plat_dat)
+{
+	const struct dev_pm_domain_attach_data pd_data = {
+		.pd_names	= ethqos_scmi_pd_names,
+		.num_pd_names	= ARRAY_SIZE(ethqos_scmi_pd_names),
+		.pd_flags	= PD_FLAG_DEV_LINK_ON,
+	};
+
+	struct platform_device *pdev = ethqos->pdev;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = devm_pm_domain_attach_list(dev, &pd_data, &ethqos->pds);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to attach power domains\n");
+
+	/*
+	 * The SerDes lane, its clocks and the MAC AXI/AHB clocks are owned by
+	 * firmware and brought up through the SCMI power domains above. The
+	 * MAC wrapper itself, however is in the kernel's register space: the
+	 * wrapper bit that loops the PHY TX clock into the MAC's clk_rx_i -
+	 * needed because no recovered RX clock exists yet - is not
+	 * configured by firmware. Without it, clk_rx_i never toggles and the
+	 * DMA SW-reset polled in dwmac4_dma_reset() never completes.
+	 *
+	 * Map the wrapper and program the same loopback/functional clock bits
+	 * the non-firmware platforms rely on (see ethqos_clks_config) so the
+	 * RX clock is present by the time the DMA engine is reset.
+	 */
+	ethqos->rgmii_base = devm_platform_ioremap_resource_byname(pdev, "rgmii");
+	if (IS_ERR(ethqos->rgmii_base))
+		return dev_err_probe(dev, PTR_ERR(ethqos->rgmii_base),
+				     "Failed to map rgmii resource\n");
+
+	/*
+	 * Register clks_config to run on every subsequent runtime resume,
+	 * which stmmac performs after the power domains are on but before
+	 * serdes_powerup() and the DMA reset. This alone isn't enough for
+	 * the very first reset done from stmmac_open(), though: probe()
+	 * fakes the device into RPM_ACTIVE without invoking the resume
+	 * callback, so whether clks_config() has run by then depends on
+	 * whether the device has already gone through one real suspend/resume
+	 * cycle in the meantime. Call it here explicitly so the wrapper is
+	 * always configured before the first DMA reset regardless of that
+	 * timing.
+	 */
+	plat_dat->clks_config = ethqos_clks_config;
+
+	ret = ethqos_clks_config(ethqos, true);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, ethqos_clks_disable, ethqos);
+	if (ret)
+		return ret;
+
+	plat_dat->clk_ptp_rate = ethqos->data->ptp_clk_rate;
+
+	switch (ethqos->phy_mode) {
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+		plat_dat->fix_mac_speed = ethqos_fix_mac_speed_sgmii;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -843,6 +949,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 static const struct of_device_id qcom_ethqos_match[] = {
 	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_v2_3_0_data},
+	{ .compatible = "qcom,sa8255p-ethqos", .data = &emac_v4_0_0_scmi_data},
 	{ .compatible = "qcom,sa8775p-ethqos", .data = &emac_v4_0_0_data},
 	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_v3_0_0_data},
 	{ .compatible = "qcom,sm8150-ethqos", .data = &emac_v2_1_0_data},

-- 
2.47.3

