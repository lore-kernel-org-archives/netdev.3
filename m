Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3A3F5BDB
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230364; cv=none; b=mPgNXRhVVvaBu+Jr4FhqX/dFNOYLjj5QReOAfqW7QPynoDWbtSn0p9wRnORYGkS2ThSvBtQQmq84UDMP2vIzDdxogCGuSEDqUuUs1xutZfAkSQk1G5c4scdgBXJVTZlMetnglnekVxDXkXFKOyHbfYfwJmKfgxauxnzbFTHXi3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230364; c=relaxed/simple;
	bh=2bHle8usOz7stMcOKjPW6Ck+8BCsQA4wAp3DcdmEdaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6XUJdJbAbcvbXUNGK0jaWykU3ZQY06R/c+0foNUB5PjzJM7mVpcl3wlH/gy94ww1SG8T9t4shUpdldkRllFNJk+4ZyOCXXvBRysWZGhiTXNtXVszT7jk8lNVVjrQc+9nCDxIrrCXxSiR4hd3yygcxjjbPPeZ1oCOEbC58tKoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kxjV7dJx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BP2udElI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kxjV7dJx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BP2udElI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6o96W4003016
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pfckEl3IcnVkY7Pf4v4qvGlwsl6ZKzWvWMhQSdWe8vs=; b=kxjV7dJxLjfKltNO
	I9ZYvpzv8Uo+msNoR4Nu8NQXvYhOazPFTl/+h+0eVCyRBBu8pwohXTCrVzkN2QlL
	wrmA+EvPVbt1j1Lb2A36//RnGzTR+D8hpx0IvKX7Ya6xVlJ4I9MzpJQFOyiJvVHV
	Jb3sX+J4PkD24zKRZQKFKdkEdUwZVZmrPk6zIShs00cAwykU+lCNBMhxzAh1Fs3s
	HFM46dRTwJSN52QNMVBg8pdoI9ZE4dZkEoOrfOzxZzqMhReK6h1E69mEnPl+u27t
	HiUflN86VPH6AtCQNPQ6Mow6UGg4wLJvMRwbS1RRNIobJecxRanEv8oYuvwV7bL2
	fPcXdw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc1se0hyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:46:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3552883bd19so2584322eec.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 02:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792230362; x=1792835162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pfckEl3IcnVkY7Pf4v4qvGlwsl6ZKzWvWMhQSdWe8vs=;
        b=BP2udElIT+BoIzVdUY0iRQX3qduuv0DOdNgTfqVRxMXCfDnucuLClrleb9wDJ+M9Z9
         H8HFsk+AzoUrE0qzF0FZMzOeJbTqystVFvbPxtmcxcct2x4BhITc0IJX8hzmxTe6tvQ1
         et58RjjON9dOKOCDGNJC6S3E59Lm8jqOoe/pCANyo7Ffh/xE/CC8ZQuJ3piLQCNFaxwx
         1gnOAuoVaO6BaGDJFUDwIggJjFjCyPGs8gA6a+kVt51iKbdbrvZbtbw0/br0CDFwzAj9
         nB0LSWp8zWadKdHEVySiRI9A+GyDX4Hxv+I9d22NTqu8SeFO48F6dOMMnP/avfNH+W+y
         HvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792230362; x=1792835162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfckEl3IcnVkY7Pf4v4qvGlwsl6ZKzWvWMhQSdWe8vs=;
        b=wFbUATNZcOnUYLQgX7kTS/vIhWqGN7AnygP+ezFmSeh+42m/5thIOKyndcFdp/9oal
         j4pLGuAbRbyFoThkKxB7AcXRx4yW96icoXElYpuaraPLnzU7+rrJXo8ba4K7yjfXhgfD
         a5/sJeuHw3PjV4wquE9EqPEg1dpv0hsFZQGNqv69FpHhlckBIhXFAFW7oVAXKHqZHiIp
         gVmpAEdvT6TwFYLFzJIZUoGTXlXsYDkyISnxqeMPyE1kTg+iNNUFX2e9V9lpUihcrBVR
         Alq6cdy8S0DDAVxkRo5f3bkOmVlFtROgVBeNiEN9NWzmhbdt9znumbPXKZyvK5lfUhEZ
         m2OA==
X-Gm-Message-State: AFq9FYJRkNu7W3Paox52NLCaj+bqIbtTh8XywNdzSSLTOB/r7kDXVsS0
	WqKmDClcn589a/Eb87kMp00fXVsl0x0UGbepzZxqx0QwJ+/nZFy0ufQtE+PbavoRIWsmKt3RYOm
	Uum6NzGGLMXjvdtWSwUUFa/Y0nG7KUZ2EyhCTkLqgIfNBWusY02lm9larnC0=
X-Gm-Gg: AYBFou1itpA6M9iJEG4sibNCZw6loMXPT1MyBo8ML0IGiPXnVvXWph4W2/UlRxximI4
	IEQ8uyeUBH+KFRSmCTz6+Ny5SD+7DSwcTv/Dm+4HJO9Ay4YztwNi2SeRyLcqwUV006J4ExROG9f
	aFZyML7rZKG9LKJhlQs8ZIfB7+H2pa40bD8Izf1t2IO7MHCG+XOXIh0dpgtbEsNEGz7idS2mZ5Y
	8Ra/uTm0iwXkpRwci8Ctsv6RbiKhMssvBV2xyrFRcoL/vYTn6iHih3RzyQbQaACeCbUT6bf66q+
	syGSZGASotIybe/CaAgf5nSHx1UKI3gNMWj77XJGhRNwSaqMjiU07LRHTdbBuOvd3s6zrzaPbZ1
	sA9mDZLD45vww8ANsB4zPprR6oWfY3A==
X-Received: by 2002:a05:701b:4205:10b0:13e:5a50:1e17 with SMTP id a92af1059eb24-1850ce9ee29mr3318605c88.3.1792230361868;
        Sat, 17 Oct 2026 02:46:01 -0700 (PDT)
X-Received: by 2002:a05:701b:4205:10b0:13e:5a50:1e17 with SMTP id a92af1059eb24-1850ce9ee29mr3318569c88.3.1792230361204;
        Sat, 17 Oct 2026 02:46:01 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm19450327c88.11.2026.10.17.02.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 02:46:00 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 15:15:14 +0530
Subject: [PATCH net-next v3 3/9] net: stmmac: qcom-ethqos: convert
 ethqos_rgmii_macro_init() to void
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-shikra_ethernet-v3-3-26a8beb44b8f@oss.qualcomm.com>
References: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
In-Reply-To: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792230324; l=1980;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=2bHle8usOz7stMcOKjPW6Ck+8BCsQA4wAp3DcdmEdaY=;
 b=QOBNjUqJrPp7d6DBkbNll45dJKWWoPDuA9jG9TR5UBDh+gHQv+n9pBRxzKj/0AxrjsTqZgZKS
 JPMRXXbf1exCvJmlgRIiyi19zvKQ6GzVuUPNOolfs4gFjlp5n2Inh3n
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-ORIG-GUID: 89xSzdoMGCE00uImIWD8pKMjwCHJy1za
X-Authority-Analysis: v=2.4 cv=A4z5rKWG c=1 sm=1 tr=0 ts=6ad343da cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=Vjzh3eGJV6Wj_RHhdNYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 89xSzdoMGCE00uImIWD8pKMjwCHJy1za
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzOCBTYWx0ZWRfX0ojJt74YKpcx
 E/XFSLZM1HEs3imWT0ohNEroIJYE+R1CK+4bjKTQvFvW01tIuqIU6aBl4sn80WvCBdoaNfCxRQd
 bWE6tVPWSyprqGWzI/mzYPTBoYvUwXc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzOCBTYWx0ZWRfX2E2nOMms/+3d
 svG8JenRH3A2fSZDP2yTKpMpooxNH4uFHJbpJVRzrWpSyW78FhcsBqioo6Y1WrHTPMNOhc/uhte
 4u2ZoDwYtJbtR8TO/97lMEcoPtUEmpYm35Hf1Q/zN8zjftEk30uapHAl/cMSP9YC85lrTDUuPRn
 y0V8iZ1Hyqz6H40B+HPtVYix779Mb60/5PjInufPs1zgE67h6qsPB/gMPxDkNEqh26uvN6ZrpE6
 B0x7D/eoNou+SUPylmhOotJmVmqZN1ISwBYwAnPQLEm3aHsD9M4Ha2V+5K1rRtCtJ+MwTR71jxD
 JKuQosms6GFJtR8xCgM1pQxewh9Il4YGprgkvFPN2OgcBbrTMPTb1DpIrxPBjhqhr6/2okJJ4dg
 nTQVlZ86ZV0WIcu215o9A9zMZ//frs9G//s3JbMLi9FRmz7LLm4rkWQlVmk/x2XNzDcZjeHyyb6
 nCkPd4G3xDz/Q/kj3ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170038

The return value is never checked by its sole caller and the speed
validation duplicates a check higher up the call stack.  Convert to
void and remove the dead code.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index ac7d6d3e205a1ab5b391def879d6f1033a0961b6..44270c25d874f72e7f971757fec659d36468c315 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -371,9 +371,8 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
 	return 0;
 }
 
-static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
+static void ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
 {
-	struct device *dev = &ethqos->pdev->dev;
 	unsigned int prg_rclk_dly, loopback;
 	unsigned int phase_shift;
 
@@ -384,11 +383,6 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
 	/* Select RGMII, write 0 to interface select */
 	rgmii_clrmask(ethqos, RGMII_CONFIG_INTF_SEL, RGMII_IO_MACRO_CONFIG);
 
-	if (speed != SPEED_1000 && speed != SPEED_100 && speed != SPEED_10) {
-		dev_err(dev, "Invalid speed %d\n", speed);
-		return -EINVAL;
-	}
-
 	rgmii_setmask(ethqos, RGMII_CONFIG_DDR_MODE, RGMII_IO_MACRO_CONFIG);
 
 	if (speed == SPEED_1000) {
@@ -479,8 +473,6 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
 
 	rgmii_updatel(ethqos, RGMII_CONFIG_LOOPBACK_EN, loopback,
 		      RGMII_IO_MACRO_CONFIG);
-
-	return 0;
 }
 
 static void ethqos_fix_mac_speed_rgmii(void *bsp_priv,

-- 
2.34.1

