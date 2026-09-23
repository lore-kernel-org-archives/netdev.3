Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70DF544D46
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176520; cv=none; b=cuodj1BNxzknFL38Fw07uT8evaBjIp4PDerl2C4CkiXgoIbdP1ZIY9owynTXzDJ6QQP2Snz0aE3OVNYcNnKO5Ll1+4XhsQthNKfZpDnPv0feQt9ifwsJ0GP4iyLgSO7XdmwuAKdeqilIjxSNCe4+QN7GLKRhKES/JirZojkClnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176520; c=relaxed/simple;
	bh=Rq+TDPdqhF6BqR973VgYSIdLvxRoWPIkY3OnfX0xzLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e6DxEZelQUl0OylNFUG2AcbZNlFU7hg06uik1MR7xZ7+1p81y2/g/yygrXpEbpBZHnT1B0saiNg86VbS4WB8Bn3ispjprII81qwdEHMGrx8sNbFxQdY8yMPQiPC01ITCgfOlu6cqAsC3JL8SNw4c0DzchssgE/0+lVM8wVyQ14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oaYnBI4F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=De9iBdy9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oaYnBI4F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="De9iBdy9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NDKxID2056510
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RyU4Ifafpyh/FLtyPoayXjzPbwMU/X5o2UFaqrYzldE=; b=oaYnBI4FY86JFFj3
	NUUpWuY4PVq1DwIYGrcirTaLqvcQk/tmiNCY6/X9tXRqfDyhxo2AxQmecmdOPRo+
	6XoTmN005WvzxmivYvjDXyhSSOLn7TZEm05ri3XmUUtOpRhIQ4DRmS+q5BjFm1GY
	EaVVKxuos1j8XiiBf0t3znXt9blhwYVawv9yR1Qq0y2VD6pxmqEVd+9oIwpiNwlQ
	dcrF0fIILFrB0X+oABM5Qc/qSuZjk4kTc/ElbGTRrjhVpnzhRxMK4o5MyHvVbcu8
	x1zwYIk7NDQnfqHz851x0gX00BMUOi2nxJ63Frq30NfAsKsXZuOPyXSEyshW9Tps
	aIbaTA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv0hf1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:15:15 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c96449cbb2so401701e0c.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790176514; x=1790781314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RyU4Ifafpyh/FLtyPoayXjzPbwMU/X5o2UFaqrYzldE=;
        b=De9iBdy9y0ygNr73fnG0W+WeNmlLfBeoWVEzWeBVU1brMji7z2IgbnIpJQZ790Ll2R
         XDSXg5ZOMbmpO9MwrLYUy+9ZfH4bU8nas1kAotnQ6LEfqvnsoPXGnYP70oQJ5wKKQp2p
         7UBHR2GxFF7g2X7wbGTNbzXf8TiQmc4t1sIycRj3kSnP+B2kwfDAd5WRcG/VrB6pmeDK
         X6T+Csqt90HwX+ULKBcHWihESkE/oAB+yQWwh4TPerRsEDXKMZQervYYExwpFcWGQ4Er
         fKzJPDrNYpFNxliwCt6aA/fegNzOgYlNKDRBirDNCRogG0bbibN2ku3lclZRpKzCimNn
         LuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790176514; x=1790781314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RyU4Ifafpyh/FLtyPoayXjzPbwMU/X5o2UFaqrYzldE=;
        b=W4DF3c08uAeWNs0O41Qv5KoHwde5yGx8pqJsqXSpK38cO4aD+WgEAcXoQ2mIp2jNr/
         I6Ute4h+Ntbj9eMR48yn78SPrYS3To0525sofGUOP/p2wPPDt3z3l2ScLgx4pAwoPluF
         kLwpPDGwadslFtZpFmXFqN3iNRCJNpuMdVWurTpQ3T6PUKNibWDRG1V86cj467OahgFF
         2JZDZe+nc25YFsXLDq0ji0+Uo/dq+5fB9rbMwwUm3w3LmiqmToGQKoOZIntPEExUG4fw
         qvV9YYQ7T0eMl3jNyN/D15pMHtxP4mN+Zf1Lq9LXbYR29zeTAdCrOqt+SRuf5JxXkyew
         OQIg==
X-Forwarded-Encrypted: i=1; AKwUvBzZbRVvOqaggqjraHUJSQDhUOX6CIL8624+bfQk4FYbGWMkuMQk62+qAgBJzs8F71xgJkoTxEI=@vger.kernel.org
X-Gm-Message-State: AFuF++kTml7+h+s0H9RIBmw4wZOwLBN8frMoEKdowmD9yaS+h33ZM4Jp
	wPZU7C8+bxWzpq0nB00WnvPFtQmpnF5bQWKV2AK8kFpmQTKT+GQa1fx8pY997Zn96+QmY378Kgj
	vqr5yrPhqhug3Vi0rJSaTD+Y17zO5ZlJEqZZYSGzqAakzBdHgrWZ/+gZ0KAM=
X-Gm-Gg: AYBFou1qaL+gBatIXkRmM3eY6MHtO2PycgtT01r7VBM6btys9Na2MYvs1H8wbInldI5
	R0miffKkMWzgPSqAs+uCGlWqstfmFlcYvZ7kVNy9xpFiM+ulJh/ORTVhi/86BdRO0h/3Ig1q3C3
	0QW8wAfn0oah8X1Al0Ztxg4rCWRoiErFzbOmQLOTVNNV0u6d/vkkesRJQDddpktNqWqeoG8mJi8
	DzZUoJCPggFZI/yFxmvfQ0OBzMwmm7FDiG4zT7RLliM57z0MjZAnhqoofkmKeHzLeO5O4Fovb8g
	ZFhVCHqkcMTMIYm1umHS43vJd3Dk2yj8G5BkPwlrOFgnTFxBmgsiihd39xsqoi63f8xXlYwBjet
	7cU9kgK7IJ5hfAAyIQMLN9uLOXJG1
X-Received: by 2002:a05:6122:e442:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5c9f15a8529mr3242470e0c.7.1790176514338;
        Wed, 23 Sep 2026 08:15:14 -0700 (PDT)
X-Received: by 2002:a05:6122:e442:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5c9f15a8529mr3242398e0c.7.1790176513783;
        Wed, 23 Sep 2026 08:15:13 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:34c6:dbd6:5b58:a3fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4054fsm55126325e9.3.2026.09.23.08.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:15:13 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 17:14:39 +0200
Subject: [PATCH net-next v15 5/9] net: stmmac: qcom-ethqos: set serdes mode
 before powerup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-qcom-sa8255p-emac-v15-5-e82f33720737@oss.qualcomm.com>
References: <20260923-qcom-sa8255p-emac-v15-0-e82f33720737@oss.qualcomm.com>
In-Reply-To: <20260923-qcom-sa8255p-emac-v15-0-e82f33720737@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Rq+TDPdqhF6BqR973VgYSIdLvxRoWPIkY3OnfX0xzLQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqs+znmxfJ65EaHdReTe9c8RxTkoxpSJy+BciHI
 ooUHTBSphqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarPs5wAKCRAFnS7L/zaE
 w7eGD/9me0usFPzjz9Ap74v8M7uevU7NNQu8WYdLzpmJBCHqK46zb9X3Qs31qUKCdGnsbihLbjr
 i7C+wf7iDiXNppsWiIlCGYG4rcfZr4DVYR31Lynd5rZ9PcdXo0M7xf2aFf4DsojYNa9fye3g3do
 TSI32h1enIQKeNqFocyf8COvMtqtaAdDYXnQOFzIfulM1+e5AWjLLse+e+ppmzj3tu3PJUlkjEw
 s/RVWFLLFDAhl+1Qb13GOnrTJjMPrr+0gb8aAX0ApIh21VxiWlk/lkP/UMboIQjsDMyr/0E5Tk7
 1M+nCLSLRLuJPVpgimvvWmeQWrc8t6tE+avihxWVQjF1yPTWqG6YnG5PPmhJK4visB5CI5gE+Qr
 3eI0RmGvllLQifmGqzMC6ivwn3DI5Fljv5hug3bePkXBkjR4eF91PptFTM+rRu4LU1RdWwKYpCU
 uTYPakyKgugnnE3+ga/iY/SfTfJUJaBscMdUW6G4VE3rDiM+0hg3onBrwKkxQ6iWwFqM81uTgJ6
 UdOBGv9yzdFuevJdpJe7T2JDJ32Zp+zGmbdn6jr6OAiyxz8uUgq+bYrYSCeB/jXsDjUtvQ+1Mbz
 PHjDsbKrjzuRXy32lDmtrXX0dukM9pTbcJN2PXKbKJJjF5Y3FtYhPaHU4ryuGcX9Lr9HyNGtWWX
 PHxpgsRslwWmWhA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MCBTYWx0ZWRfXxUByrp9gsj5a
 WrWo3Ap1A0VCoB1M5XbtrvTDEE9DPGX93wfjqK2dIIemwo3k9MNduov+BQ4ycggG/wCl6TWs3xj
 a9Eg7pJRzPMGg7+AWtA+/oQSHZPs67sQnLamEkALlig/4aMkeaIurMzg9BwC6gq08IL28D3G7zE
 n+suKrxQrZ+0SY9iDVCZoHndDi4iiq6vfhYmU5ii68WMu91apS7PjqvHD/6+oOHxQc+q7iV5cYF
 WY5Y3mLl/CgUCbxkCYXEUC+c47LoQxNXwG5PDDjsNq5+B7gWdVHAbZIsPcJicbRbtwlLge9i5le
 KaM3+dxTglaFRXfo8xtAw9AbyGxzst1MH0SVpVfn2W8Yu9Mn/4j+Ye2ZfZyP8aFP7dhM+/36VA7
 AnZT0XuIaSxLtsUCwMW6L2V2IDSieUGNnq+xMfNxfvLYGWF5XOgFVTPl+c/jdR0xtxaGQbet7bO
 lcT1I4yFjPjdhJDhJrg==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab3ed03 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=lIIuVyqIMTwqdMfQNTsA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: Q3GkK48gZ1Y-NjMddtdPyEdtqMbSE6XH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MCBTYWx0ZWRfX7lERBvYar4FZ
 BbJGViHqregWS08IKrPKj+GNDcEB0BD4EIawGQhFBA+wgMeWSxhTWk4yxKnJFAj3QgJXCdV+Nkl
 tffTM+eDRL3GWvvhcTwyyVz+KdItmtc=
X-Proofpoint-ORIG-GUID: Q3GkK48gZ1Y-NjMddtdPyEdtqMbSE6XH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230060

Call phy_set_mode_ext() before phy_power_on() in
qcom_ethqos_serdes_powerup(). This is harmless for existing users but on
SCMI systems this is required for the PHY driver to select the right
performance level - which translates to the link speed. This is done
ahead of adding support for the firmware-managed EMAC on Qualcomm sa8255p.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index ac7d6d3e205a1ab5b391def879d6f1033a0961b6..47b70b5e706f221c01f1c0ae3b1acafae6641165 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -601,10 +601,19 @@ static int qcom_ethqos_serdes_powerup(struct net_device *ndev, void *priv)
 	if (ret)
 		return ret;
 
+	ret = phy_set_mode_ext(ethqos->serdes_phy, PHY_MODE_ETHERNET,
+			       ethqos->phy_mode);
+	if (ret)
+		goto err_out;
+
 	ret = phy_power_on(ethqos->serdes_phy);
 	if (ret)
-		phy_exit(ethqos->serdes_phy);
+		goto err_out;
 
+	return 0;
+
+err_out:
+	phy_exit(ethqos->serdes_phy);
 	return ret;
 }
 

-- 
2.47.3

