Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F033F5A8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461701; cv=none; b=q8BX6gYWnpN3izhjGM6XjA5Pfn7Ntkkx1l641dmWwvo9wTs1rlEvglfrqaa6UPV8A03OAo2wWK7c+iiruCyvTMyB04HM8mnl4iFpCJVwhpAwiUqUIWj11PO1iTKZSD5c8pCi4fGy3wOYzxj1rIIIrf/lTvSf4I2ZkpfFFf3myj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461701; c=relaxed/simple;
	bh=NBTqBhye392K1VYn8d0VzVca9aW2/O/mLmzqGu6EcfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Orf+MtQmI5Vn0THfYJoNdL37ah3J9UwqPrSTLIbAhnqRZKEDv/IECnMFz8cY8/G1t+zFBDE7ZWhjBWL+4h8qbodQgmL3z3eEU3wg7jTazcuYv2zQtW0KFVbgw3TQeeUwF68pk0CzGPOdAsC6BQNzeak3Zd+qui+6wwGt7Wkp31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bmhM9tdj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hl6sP7iH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bmhM9tdj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hl6sP7iH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G3r521091730
	for <netdev@vger.kernel.org>; Thu, 3 Sep 2026 18:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4yNYglhW1QFSU5SJ+MYIp50snQakRJQqdoTsNwGOnW0=; b=bmhM9tdj2jqm7G6T
	27Y3mutqMaRxG3zMDedlThsxvqK42jBaeaD9ofSNEXZylyW7zziij+p9sQE3W6qa
	4Wre5op4L91Ayjk5OmB4+dQ/E1+X1Yypho6rrKkkuh0zxl14mOEhvjl5NAqDt8UH
	atuN85rTsNEE9Y1uAHfKrT1zCnQaG0JvNdVvF0MwlCFtyZNhaKcTxe9RR9MXezC5
	bpMc1zzdJRW2cwbmjKQJlrd9DuxFNDJAEQzPxhkWb20a0ofy6G6oDn/IW2oYwqd5
	/yMN7fpuXc8NOvw9h2bXUFATvqW5CHGcEW+beOTI/9KcrhtL1HbUb31S9Kw4m1YZ
	5flx7g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekk27g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 18:54:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso236838a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788461692; x=1789066492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4yNYglhW1QFSU5SJ+MYIp50snQakRJQqdoTsNwGOnW0=;
        b=hl6sP7iHwwVK7IIoWDCoY4n41luaP0CB4KmSeVKN8bfG6KbuEomWaP+gZiK+c3R2Bl
         rL8pQ9N8Hp9OmyR3/+gbO7SbAgPi82j/XYY0geswKz9Q6hJujiPOiUzFmO2Nq3qVBSAP
         J7cWFL6Hb41rifk+193kudoS8cbiZYWnBoAlwYkraGJ0P/Cq0Uu0zB9PG31JwxcxOKek
         uLKAMH1dMlJmA+WG31m43H8ak+CG0rGXmSsgCLsCbJ7obUQ8hMVkJXI7h8ivGjzGCLvW
         RvROk2TDQ+tZ6LbTdrCawuZkNVlcYCO3ljZUcesd4l97lK0ZMcu4PX4ZE6E03SvqGItB
         WS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788461692; x=1789066492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yNYglhW1QFSU5SJ+MYIp50snQakRJQqdoTsNwGOnW0=;
        b=WgsNSypZdlw1H9tBo4wv5uVAf13AjnjXTHGgz1rBasoGFZTY1GvG1pyRCbhYRlZJnq
         4U77hFuRJj6uh9VKoUteQLeviZyUvvEQIVEHoJhsx3+grg+8p1FVmXk9J5MpJNIcJOWL
         gmLscTVZkr3pR8HDtMTg5o8IDVxMo+rVdzA2pfwjCzYwr5P2ecoq1F4i0a3V9q0y94GO
         V1V/z/DwpTfiWDcMfYSpO5lb6ojiS8aU2ydS3YmRhhUoNV32u8SQFeAARDAsOntVfK98
         klCxh6tjAbpzaOhLyR10tvlcNu+jlsG6bfT3B/BvdVQ5X7LLGNCl7cjcuyPFYt2XssTP
         na5Q==
X-Gm-Message-State: AFuF++nxg/mNcf5abzm54nb+5uK0IoI1JXhXKeungh4iI3Ws01fkxhIQ
	c2P2Pc7np5rxbh8x/0LBms0Rw7ClbftFwXM5n1CY2AkJ3ctPSy+kQQF4JsAQHhzsJzKDcdUUFGs
	SF1vJktPFm6mOlgRbXQbMxena8VZAMV0+VWahYYh6fN9xxX941mxd4XQf1a0=
X-Gm-Gg: AYBFou1J8SvqYvOSn6m7UmuXGGClVFestQ8nVjJIXbllq1jmcQNKXGxsimgV+FiMEGd
	NZ+DIjHpS05AwKrYxqjnVe3q/jeKFXCtaBEjALIe/Vsatzw6XFd32YTxkWjCTQTQcolDrfe3QiY
	EKDK0kibh5+4TJSSofqmmHbd7bamrFZ+QtytNnV7GoyYoYTTdSvqA5GNugPpjPy74Vmlq5O/gvj
	FYvEtcnD19Vz08jjVBWIfCIKoo/owc101/wsbZLEQtTYN9Jp/dTWBn/KUUFDRxvyjwRWCE78iVd
	ugtTUwaK+cHmfey+JDA/rEOKLzBXEfC8AQjjY+NlYbSMV7l76/nDA1nYLgWIZ9ULtyWvXSo2ZdL
	/EborcvScOwU+NzVGwYcPW67AKlE3uQ==
X-Received: by 2002:a17:90b:1d52:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-39b2612eb8amr773787a91.6.1788461691712;
        Thu, 03 Sep 2026 11:54:51 -0700 (PDT)
X-Received: by 2002:a17:90b:1d52:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-39b2612eb8amr773621a91.6.1788461690575;
        Thu, 03 Sep 2026 11:54:50 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ce1csm778829eec.4.2026.09.03.11.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:54:50 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 00:13:49 +0530
Subject: [PATCH net-next 7/9] net: stmmac: qcom-ethqos: set initial RGMII
 link clock to lowest speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-shikra_ethernet-v1-7-a50765996035@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-0-a50765996035@oss.qualcomm.com>
In-Reply-To: <20260904-shikra_ethernet-v1-0-a50765996035@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788461628; l=1138;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=NBTqBhye392K1VYn8d0VzVca9aW2/O/mLmzqGu6EcfQ=;
 b=XG6OG86F6AP75Xr/1HV4kKPEVE9c9n7Ucn6qBz1XILjvZck4+RuFYA28UG0ao+qFKjm8Qgtgo
 YOhobDDsRmVADfjFTp8bHa/dwplCnyCgS1YL5fI1Vv81CiN51J51n0j
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-ORIG-GUID: pxom3OWOQw5Njiq977ZiJApKYqz4dszj
X-Proofpoint-GUID: pxom3OWOQw5Njiq977ZiJApKYqz4dszj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX8eAxdmH3p9FU
 hdBIKQDLpN102TjLmJlxCwGx+zugecrq9rswU/YlAcapgqRuBVb4f3Bg4lqtc93mLYXPZ6C8sR4
 +D0QUXsO0plgzST47UTvJ4PYt4/2aXF2qeaf2bJNTjMcOvnhQTJQD9eAGgmuDpSsseArCCwT2J8
 2nZsTUfcP2mIxRvpl4YF2JjYTnGAZp+xR3Ujd9fLPsKdapE6QuvxsHcGjzY+G1E5vwmH2/NMhSJ
 8n19jbcifjWNoCfqtIotWV1LyqPi3/ANCAY9hZSPWufsDunif3hKGfZOub2mLMeJXp6Ff/j1HyE
 dklIrrxHaayK57hle8xurJlVDCgFk77LQkELa8djm5xTyFuo7TIAHLOBlD943LHrciJ1ZoYDTRV
 rlSKjLd8dD2JrZPjTBYcAdOcmixAY1GEb4j+vfEGgl6z7CFmpV8RLSLZaq0Q50msT3XTEZLlfd7
 5FooKE7gxH+lTEebBuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX5A+I00GKXoHw
 d6GwxX1STYpEzfLsKoRUJUkT98xmvwN/Tb4HS3620lqAaaBvYg7j2xOqQFsB/YP0ZWGjLi8O/l8
 fvS7hV3iOq+8WK6Hw6CAFrvb1uK9s+g=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a99c27c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dsjofxfk3bnWsHuiCQUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165

On probe the RGMII link clock is initialised at SPEED_1000, which
translates to a 250 MHz source clock even when no PHY link is present,
drawing unnecessary power.

Initialise at SPEED_10 instead; fix_mac_speed updates the rate once
a link is established.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 2ca2f03de30174c9771fdc517c0e21e3b392ad76..4f9bef662c5796ce3cca64b19a595bcdbebbf336 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -814,7 +814,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 				     "Failed to get serdes phy\n");
 
 	ethqos_set_clk_tx_rate(ethqos, NULL, plat_dat->phy_interface,
-			       SPEED_1000);
+			       SPEED_10);
 
 	qcom_ethqos_set_sgmii_loopback(ethqos, true);
 	ethqos_set_func_clk_en(ethqos);

-- 
2.34.1

