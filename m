Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1333374F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125762; cv=none; b=H4Ab3wnEzhfPJZT30rApYc9DFv121kSF+9FQvcmHSH9EbVVetSX5iQGmpAUFcSQvReufnECvhYroYiVvQiGNT7ljitFWfsQYNjTXAvBaFPsqIa0BiHTE+Dmgot44XFfWO1Gs1ZzL8jUe64gVcH9ikyDCaYLGyoNxD/6Ts8aQyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125762; c=relaxed/simple;
	bh=LAj5wFs1I2UH5hJ13rqJNCQ7NMV5AqqbqBxmaYQgJ7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTyn2UBh76DzaGEsPwAQLivL40/BJ9GEM+rf+F+6o69xzR2v6141ad5w9R0RV1bc3DOp8N1enEedHNzBotq9aCyEE0B2IANRqqMdwigjM0BahzabHP6KCuhH1LZLt1eIS2rQJmxA4cdbhiKqEwHJaf5xO5TDJBFhgabBeTvOmcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F+gUVo5Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RXQuIkIb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+gUVo5Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RXQuIkIb"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MJBidD3897608
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tz6NKk6ALui7Z2B2Ol5dUKWciABAFYV+RUGiS1O4Xo4=; b=F+gUVo5QvSVJHOHX
	ZC0XibfkbzqKvdPYhB9DweD9Cngp8njlE06E2oWZ++EdQv81quKDpY/gfrMyyVUO
	PfiPZtEFAcJC0UsiLvmKRKQN2k8j0RV7Le8repx8hDPfeJAMWiSCjGxlMNxPzOZY
	yfrRG0vwGz7bNfA7cTUam5ly5lKlITDfEpB91Ghsz2Z9yhlu6c5zEr1tNb7J5Zho
	a7Tdy9ULD49WR4et8Ty84e42ZLSZJtcrp/rB/W0NVRGC/xchv9J7GPEaeovS/9Cu
	74TP4aFlexjODhUZ0dfWzymv2wzLJx53XDKFQLhOuYh9ms1gSrV9EqPnxHOcGnUe
	1VqwjQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma1avv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:09:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-331b2ec616fso1497824eec.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790125758; x=1790730558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tz6NKk6ALui7Z2B2Ol5dUKWciABAFYV+RUGiS1O4Xo4=;
        b=RXQuIkIb6+bdSZjebr0s0Ov+K0XquETDrxUseDyhWT1UJ8TG66TFmtXgvi5odfEOr7
         V7IiKdrDsKfAjlilRbpStK+uuNhTR0Vt2NOnFwSXLxraieTqb5pWffujUjgHCc3F22Gk
         woCrwgBTngh9QnAKFLJzkA4/xSwenIBBgZRg1WKlLkJ6ZUl/rxZZiCJAX/ZyZK/GqZyP
         PGrOxvYhZNtrGzNa132GO5kkNWYxBxImbDyAEjArLUzFxrsCMqR4zRNppHI56BtyzNUT
         Q+alPduK4GSJSlq1MEIf7nn5ICGft0niBAAeLZSitQqnHcoVXWpGLx1QW7zOTEpYL8EV
         /r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790125758; x=1790730558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tz6NKk6ALui7Z2B2Ol5dUKWciABAFYV+RUGiS1O4Xo4=;
        b=AhGLwX4rr5IHhkJp/PKNQCOekywO8KfIbF0r6jFxwudWxv1T1xGDXwsWf3Sz72opxZ
         iwDYx7XMK6fwwu/A8sIi5ASC3wfikrLacwCmMhdTCEqTfgnICGBqrJLYaOK1KnwX2Htn
         bhqoFKWbqhFrIdk0dzaMI/x89bRhjZQzHzWU5z+sxflsGCc2umKqcI7ZCr12+0+eJzz/
         LdoOvjJ/PhLfMeY100EWQk5EBrXrbJAjQtwzFBy2Td/DGDkiinshsMtKb1FK24S+jWR+
         aZfkCytazkjQ6FalcDBYL5O6JyxpiMmfSQ8XKNPY+xtm4UPc1czl+OIAXG7JPRpnVg1y
         615g==
X-Gm-Message-State: AFuF++nK6+xVNUY+Z/7F/40YKNV1lvzXYq8pwRtrMvoPULgOsKi44PIH
	mW2IBaen/6Fv1ht7dogPQJ2GdnBa1ZMvQ5InbqcoMNkqVzlm/uOqY+bngYo1MVqb2nrpZVgJcPC
	57SOAGJj6jj018Mv/0b09hH1XcQ60YGxBSTjs6F2Lcq/VIGy1rDmfjY4r2JE=
X-Gm-Gg: AYBFou00Zvcx6roIt2F+O9vYs1uIZZYNWhpVWgH7Xk7fKQN/9NF2Jqlg1CMbmVflAR4
	Xjc+SrztHNQa8lzk2QTYBUirfJ89IGuEwjmWmJZfp16C06PwhuChnk8Zf335XkoI33GJcQ1QOLe
	mDWscu5RWJ338Q4F4iWRG8LGjf4JWa1e/qcfCOoMCmWIb+xaZZYEcfaW6RWb59V1zHtqtCoeJej
	FlDFkTv4sGOvtFbLBYXdXdRwI+k+kVRisv7ZSVaB4Liqiy1kZk4CskcmHHg7xcgo+3HcFV+mXvt
	BZL43+m/0eOz0DBvqgNIgjnbTXOrIcqa/D/VyVGnPWPMBrwOuQTiSleSUl32Qz/P4dIBru0dyvo
	swtZbO9v/cWP9AupdcUiyKOjApxQk
X-Received: by 2002:a05:701b:4251:20b0:13b:3c3b:8dbb with SMTP id a92af1059eb24-144f92e1ee5mr1179650c88.23.1790125758232;
        Tue, 22 Sep 2026 18:09:18 -0700 (PDT)
X-Received: by 2002:a05:701b:4251:20b0:13b:3c3b:8dbb with SMTP id a92af1059eb24-144f92e1ee5mr1179627c88.23.1790125757807;
        Tue, 22 Sep 2026 18:09:17 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98ca0edsm1651831c88.15.2026.09.22.18.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:09:17 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 06:37:34 +0530
Subject: [PATCH RFC net-next 8/9] net: stmmac: qcom-ethqos: support
 external PCS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-qcom_xpcs_nord_emac-v1-8-4b1c682af70f@oss.qualcomm.com>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
In-Reply-To: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
        Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790125674; l=1930;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=LAj5wFs1I2UH5hJ13rqJNCQ7NMV5AqqbqBxmaYQgJ7Y=;
 b=S7vtbiqiefxlbFM0z0Jl/fHy99gKVoxAVcyz1bdUtdY3C1YPU2yxhMAQjFEusHLu3GKoZtzIy
 MqIesOTniX+Do4jykMzcZtwr1jEv2oipCUGo7KR+yeCQsri9K378CaB
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-ORIG-GUID: IFiORmYnK8matofTQyQaxixd73umvJN5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwNCBTYWx0ZWRfXzK5N6/rftyHo
 rnsBZ7NNnRUwkgdct5hEnYOSi27SOc6YXv4QlPqhRBFpnb0YNG8bjPrboi+8fX5NsGAxq/MArJe
 3kH77IHyZUgKFu03esY6T1ldOmQtpKg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwNCBTYWx0ZWRfX9EQ/ikrfU5K4
 VI9zE68OJFrUbD25WHzxevPvQw0JnH7xPW/YLZOAzB0dtXHGkn5NtDc2aTd4H9xYxhtFOmu69VX
 PEX4hAmWOXluwj+INoCNUu6s4WTbpjy43a5Mf9CXLgedZnVMPMNvDtIVFwNTbNfmfaFiCpMgilC
 se5pQELgxr3Ye4XyD/BxAe5W8UF6SXg0t0hqmDeIBxNTWqXOPYoXcpDntf2HVVyllaiTGzIkkz5
 txMiXq6+4M1hOFS50UiuHQ4pGmGCjngJH7E+fbnSpHauryELt6FZp0TwQrj0hfkR2o/r1TAzwzy
 NZQ4AC1BAcyUGE2Bb8buxdsWm7nRzIDCH+53uFyuNomVFDVeoIYHHtskSLgkXehTPOQe1kFUbBo
 8635ccuqOklg6EeQISA9q8e2GChqt6JvUWIC58r5hX4d8It5b8v7JTex/evU/Ies79MLj5jOqY1
 3naunT05hpQBJAmEiZw==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab326bf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=yWFGLV7Fs-RTi3Yw6F4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: IFiORmYnK8matofTQyQaxixd73umvJN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230004

Select the XPCS instance initialized by stmmac when firmware provides
a pcs-handle. Reject interfaces that are not supported by the selected
PCS.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index ac7d6d3e205a1ab5b391def879d6f1033a0961b6..a99a78880c0fb7858e90b6212b37ebfc7fccaf84 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -7,6 +7,8 @@
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
+#include <linux/pcs/pcs-xpcs.h>
+#include <linux/property.h>
 
 #include "stmmac.h"
 #include "stmmac_platform.h"
@@ -681,6 +683,21 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
 }
 
+static struct phylink_pcs *
+qcom_ethqos_select_pcs(struct stmmac_priv *priv, phy_interface_t interface)
+{
+	struct phylink_pcs *pcs;
+
+	if (!priv->hw->xpcs)
+		return ERR_PTR(-ENODEV);
+
+	pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
+	if (!test_bit(interface, pcs->supported_interfaces))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return pcs;
+}
+
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -794,6 +811,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	for (i = 1; i < plat_dat->tx_queues_to_use; i++)
 		plat_dat->tx_queues_cfg[i].tbs_en = 1;
 
+	if (fwnode_property_present(dev_fwnode(dev), "pcs-handle"))
+		plat_dat->select_pcs = qcom_ethqos_select_pcs;
+
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 

-- 
2.34.1

