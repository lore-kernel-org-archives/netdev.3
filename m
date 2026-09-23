Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F53321C2
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125757; cv=none; b=eglIEuxvI9rd2Ixv9Dhr8O2m3Z+JZJAcbDzIasJkC4zABxKyrkIw67aAtX3HCJgBrC6ALggnFoibXxoTNYV5cmMkODdK/mNiuXTNK1wLWhvGT+0dWzoMnX5RAY83lZ/K+cAzgT0QfZuYXOYIG4V3pL4JWLImKxOVBaDFbR9NHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125757; c=relaxed/simple;
	bh=Q8l5Sr+CX7uKNMpGw/xh0jS3YpNEPwMl8DIF3WPxkQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZhV13QM5D63aPykI5SkG6hu8gRbhKb1TWpPrjKyo/akcT80kGw5JbmYuTypA14iHDhzYWDCd0C0MpeYvX00YehlX1R+pIMfAk4XdVuzpOect03XBY5ZhZT3UyPnGcBLwIXBHXCaX9aCsAfUJq5Ctk6B8rcSc/+4aRRLh5JMk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LKPQnTEU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c6hrxUVs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LKPQnTEU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c6hrxUVs"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI6t1l178657
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K+V4d/rmX1RfgJ2Ut7Vkc77bB1qBPbBYrKx0w8KPWPA=; b=LKPQnTEU4jO79erX
	LIHcPbAojlolH+N6LlS3USKcXKdqi5ubHBtHZIjpGJqMeqYIYj2DzL35cpciVTVA
	P3yFE5g9aVviM7dysJ0PkmFqJWyVKw+/4XmqSC3WdM6zdRBVp90OsreyyGgBBgWp
	secyn65iKQPm2Vv0eRaY0l5wUb5jT4Cj7TlvMQ0JzwsWE19IT9d/mySYRrGSnJXC
	QqvdWSTrrdKS0Co32OEkZ2ax55XaWNfDoEXhTuGpuT7EoaDHqlD6dViw/b79bEg7
	x4A0+hnhMtym94Y/PdGGSO42c5G/JoM4w+oSxfQ/T5krKkJZ524z4xoSYoYhoU9z
	Zwmx7w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guuec2v60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:09:10 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-143826c4a13so337633c88.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790125750; x=1790730550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+V4d/rmX1RfgJ2Ut7Vkc77bB1qBPbBYrKx0w8KPWPA=;
        b=c6hrxUVs2dxLBye65NqUykEifzEDODuqZcSrUTtzewek2BH3x8EJ2+geCjsiNqXY0K
         kLfgalTKDDHAwr4thWZjvHcSWgjxBUvUg0f8Ovqv/vpezg73be0Gb4WHf7HRkIoSORPB
         +mSyHB6Uo+BGTCx+cKjgDROp6LTkVRzWW1W19WsDJZpG08uf1ZCh4dYs6Ywjb3i7IevQ
         Q3oWQV27dAzqKf7i600dO6He9BpwqEG9DkDBS1CdvDoU3H1lI2T7EcuJa5cVUAGv881e
         oObZk5wlOfembi4fU29XLASqu8W/Hle13MEG/Ydc0gPNEoNpb/titRFf6cX9cVmZzVJl
         6Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790125750; x=1790730550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+V4d/rmX1RfgJ2Ut7Vkc77bB1qBPbBYrKx0w8KPWPA=;
        b=QFG1aTBUhLDdxQ59WVbPFAuYSVpcQRcckqGDevA0edVvPdRl1naAhotk6i6Pn+zMMU
         hFwtVaaD14OX9TSsyDNdQG9wQASc+bteoCnpzaEciLQDvYK+fpSpRBqX77fLJhYRnZSs
         ntHoedFravqTAf73ANy3BG43l6n3v7sBK7+1pJck1bVw4UEARmyAJpqtSjpJkIxGfNxT
         538zu1k/cfWnfcstdPgxrszt7fwKPjYYbK20pa03HlKAPIGU+SU2pzDqJv9G/za5y6Bq
         a83L6c+oq51PSrN7+kZX6Kdjw+znzK7CI4Zd20ViQPULpPb+agtKTEVzpDQaKGm3ceQT
         rj6w==
X-Gm-Message-State: AFuF++mVSTvFp+Cm3g32H2JkHjO8gthFCmkzF4x1M3/MxAG5ygz7cR1C
	h2tLNRh3gjuRS4w1jUNIfPnHC9qULwF0zaPX74GEpPeWkhBkZCWL2fHMhCiT0YeLiI6pCR+ZUHM
	vHexyPPlvtUpUsErjQ3t+vR6TLmprDIGXwhvKr/u2mhzpeRrzjCC7siuX6w4=
X-Gm-Gg: AYBFou2aNi3mTMkwM0XW3uxqqXmMeElOZot8eAdda+JIZmIWhqSqtPm3Ggr6syMhTGt
	jfj4xypcqkVVElxy+z8ntOEursBMSn/+LYdNXiVNwGXG3P3FXe9YFtAPMaFvgKM+ZxEBcQP+xHc
	Ws384Y77BWax/ERmYSSoSpUVqSUAEGBmYewu/ylr6ZiOFr6+Y9rX8JYjsdUEg1+rPNz3wfdqUc0
	Ad0L/66EsBkHuAmxHNuxch+3x/mrvcCNdLKC/f/kdIHTS3cHiJxIXLv3LajrusuFCHqXz2IdwbR
	adQW2hxYGQEJMqPxCz+NuSAqqij80Pzqm/ddsxpLYwOQFaVTZZjFtws8MVoH/CkPcYWtUoQyP4w
	jXPubM/BpyRn1j6pAwWgXJ5gly0tm
X-Received: by 2002:a05:7022:3a08:b0:144:e246:a0b5 with SMTP id a92af1059eb24-144f91d6886mr1260868c88.40.1790125749237;
        Tue, 22 Sep 2026 18:09:09 -0700 (PDT)
X-Received: by 2002:a05:7022:3a08:b0:144:e246:a0b5 with SMTP id a92af1059eb24-144f91d6886mr1260828c88.40.1790125748487;
        Tue, 22 Sep 2026 18:09:08 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98ca0edsm1651831c88.15.2026.09.22.18.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:09:08 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 06:37:33 +0530
Subject: [PATCH RFC net-next 7/9] net: stmmac: support custom XGMAC
 register layouts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-qcom_xpcs_nord_emac-v1-7-4b1c682af70f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790125674; l=33913;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=Q8l5Sr+CX7uKNMpGw/xh0jS3YpNEPwMl8DIF3WPxkQ0=;
 b=hVX85UDmYnKhUdVI/yfVKuTDe9rYYSJ0CWjwr7c7bHJLZxBjMMAixPjQJxxIykCjCNMarExtc
 MLA2rk9/JLaDgHmJF9b42AHz+WbFGBmiVHpkLuPREDaQAjyaY/4JTFe
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwNCBTYWx0ZWRfX9GJTaKg49Cx3
 joupaIDX2WmfvAsTCS8K3ZgtNY69xH6wnXaRCVV+Yn0rz5Md8KiQlUVPTLdMl3hCaPrvMaIOpf3
 54z/erRK+1neJ/1jd4OEu7XKKAHIKhtioUHaq/2UeWSv2jl9mFaKyCll54d/w1cHtttQyvImpkg
 m3rbj8c75sikh3jI2vp/rgPJolfrnfcZZX2qn7vGEmp9J4SVxsTVZpYyoyd1AOTi71iwKv4dwFT
 nrQfS+31kkyxrnoMfNHqTrNzjzaUeks9qDjdOlGF7IiPcusxO717SKngqERLl0M6LQ1XIqxTU2N
 zIQ3qUCMrMNo4XA3wiHBQ0yAlc0pLbnQhLCpA6hC4be6Sbr1EUoP023R8EozDyxZnal6USbpt1X
 +vaLILx1bKZWd3PSpM+CUh8JjGGOCwk5cvXLF98dJOuoNYbt1haU3h5vrq/5gpFktUHUn54usgl
 fBOGA0REv40kmO+eQ/g==
X-Authority-Analysis: v=2.4 cv=VKdIDNPX c=1 sm=1 tr=0 ts=6ab326b6 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=5_JtQBAtEWauNnNKQqgA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: 3Rgx7v-AiBAGXJZ_sfFXc-x3sd5OZO4H
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwNCBTYWx0ZWRfX2/bICwcNwq0H
 FkYHQbBgxYgiLd8c0hqTrr1tzeL1T6gcMK4OmSiw6a+81k+rgqxJNykNfRqZ0p8g79AKG7VIE77
 K2lPsPgzUQiT2DKaSJ+pZppnZb0OHaY=
X-Proofpoint-ORIG-GUID: 3Rgx7v-AiBAGXJZ_sfFXc-x3sd5OZO4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230004

Some XGMAC integrations place their MTL queues and DMA channels at
different offsets from the standard register layout. Allow platform
data to override these addresses while retaining the standard layout by
default.

This follows the approach used by commit 33719b57f52e ("net: stmmac:
dwmac4: Allow platforms to specify some DMA/MTL offsets"). Qualcomm
XGMAC hardware similarly uses differently aligned queue and channel
registers.

Also allow platforms to override the timestamp register base.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  94 ++++++++++-----
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  34 +++---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 128 +++++++++++++--------
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |   5 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |  15 ++-
 include/linux/stmmac.h                             |  11 ++
 9 files changed, 193 insertions(+), 102 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 1729fb29ece3853584bc27ed541413bcba88c695..c6387cecaf5d93ef10c45475a533bf1d0a4e0b45 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -622,6 +622,7 @@ struct mac_device_info {
 	const struct stmmac_mmc_ops *mmc;
 	const struct stmmac_est_ops *est;
 	const struct stmmac_vlan_ops *vlan;
+	const struct dwxgmac_addrs *dwxgmac_addrs;
 	struct dw_xpcs *xpcs;
 	struct phylink_pcs *phylink_pcs;
 	struct mii_regs mii;	/* MII register Addresses */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d28897005cdc1c5dcbd3c2f737a6c967..331ba38abae66f03b69c383b30762c9a09735a37 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -365,7 +365,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	};
 
 	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
-				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS));
+				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS(NULL)));
 
 	/* Repeat until the timestamps are from the FIFO last segment */
 	for (i = 0; i < num_snapshot; i++) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index f8ab347f7b5b9e1b2df662785bb25cf875456088..22b476358a2028de862186c3d38295b2d48d87d6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -220,12 +220,21 @@
 #define XGMAC_CT			BIT(1)
 #define XGMAC_OB			BIT(0)
 #define XGMAC_RSS_DATA			0x00000c8c
-#define XGMAC_TIMESTAMP_STATUS		0x00000d20
+
+/* Timestamp registers */
+#define XGMAC_TIMESTAMP_BASE_ADDR	0x00000d00
+
+static inline u32 xgmac_timestamp_base_addr(const struct dwxgmac_addrs *addrs)
+{
+	return addrs ? addrs->timestamp_base : XGMAC_TIMESTAMP_BASE_ADDR;
+}
+
+#define XGMAC_TIMESTAMP_STATUS(a)	(xgmac_timestamp_base_addr(a) + 0x20)
 #define XGMAC_TIMESTAMP_ATSNS_MASK	GENMASK(29, 25)
 #define XGMAC_TXTSC			BIT(15)
-#define XGMAC_TXTIMESTAMP_NSEC		0x00000d30
+#define XGMAC_TXTIMESTAMP_NSEC(a)	(xgmac_timestamp_base_addr(a) + 0x30)
 #define XGMAC_TXTSSTSLO			GENMASK(30, 0)
-#define XGMAC_TXTIMESTAMP_SEC		0x00000d34
+#define XGMAC_TXTIMESTAMP_SEC(a)	(xgmac_timestamp_base_addr(a) + 0x34)
 #define XGMAC_PPS_CONTROL		0x00000d70
 #define XGMAC_PPS_MAXIDX(x)		((((x) + 1) * 8) - 1)
 #define XGMAC_PPS_MINIDX(x)		((x) * 8)
@@ -285,37 +294,49 @@
 #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
 #define XGMAC_MTL_DPP_CONTROL		0x000010e0
 #define XGMAC_DPP_DISABLE		BIT(0)
-#define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
+
+/* MTL per-queue registers */
+#define XGMAC_MTL_CHAN_BASE_ADDR	0x00001100
+#define XGMAC_MTL_CHAN_OFFSET		0x80
+
+static inline u32
+xgmac_mtl_chanx_base_addr(const struct dwxgmac_addrs *addrs, u32 x)
+{
+	return addrs ? addrs->mtl_chan_base + x * addrs->mtl_chan_offset
+		     : XGMAC_MTL_CHAN_BASE_ADDR + x * XGMAC_MTL_CHAN_OFFSET;
+}
+
+#define XGMAC_MTL_TXQ_OPMODE(a, x)		xgmac_mtl_chanx_base_addr(a, x)
 #define XGMAC_TQS			GENMASK(25, 16)
 #define XGMAC_Q2TCMAP			GENMASK(10, 8)
 #define XGMAC_TTC			GENMASK(6, 4)
 #define XGMAC_TXQEN			GENMASK(3, 2)
 #define XGMAC_TSF			BIT(1)
-#define XGMAC_MTL_TCx_ETS_CONTROL(x)	(0x00001110 + (0x80 * (x)))
-#define XGMAC_MTL_TCx_QUANTUM_WEIGHT(x)	(0x00001118 + (0x80 * (x)))
-#define XGMAC_MTL_TCx_SENDSLOPE(x)	(0x0000111c + (0x80 * (x)))
-#define XGMAC_MTL_TCx_HICREDIT(x)	(0x00001120 + (0x80 * (x)))
-#define XGMAC_MTL_TCx_LOCREDIT(x)	(0x00001124 + (0x80 * (x)))
+#define XGMAC_MTL_TCx_ETS_CONTROL(a, x)	(xgmac_mtl_chanx_base_addr(a, x) + 0x10)
+#define XGMAC_MTL_TCx_QUANTUM_WEIGHT(a, x)	(xgmac_mtl_chanx_base_addr(a, x) + 0x18)
+#define XGMAC_MTL_TCx_SENDSLOPE(a, x)		(xgmac_mtl_chanx_base_addr(a, x) + 0x1c)
+#define XGMAC_MTL_TCx_HICREDIT(a, x)		(xgmac_mtl_chanx_base_addr(a, x) + 0x20)
+#define XGMAC_MTL_TCx_LOCREDIT(a, x)		(xgmac_mtl_chanx_base_addr(a, x) + 0x24)
 #define XGMAC_CC			BIT(3)
 #define XGMAC_TSA			GENMASK(1, 0)
 #define XGMAC_SP			(0x0 << 0)
 #define XGMAC_CBS			(0x1 << 0)
 #define XGMAC_ETS			(0x2 << 0)
-#define XGMAC_MTL_RXQ_OPMODE(x)		(0x00001140 + (0x80 * (x)))
+#define XGMAC_MTL_RXQ_OPMODE(a, x)		(xgmac_mtl_chanx_base_addr(a, x) + 0x40)
 #define XGMAC_RQS			GENMASK(25, 16)
 #define XGMAC_EHFC			BIT(7)
 #define XGMAC_RSF			BIT(5)
 #define XGMAC_RTC			GENMASK(1, 0)
-#define XGMAC_MTL_RXQ_FLOW_CONTROL(x)	(0x00001150 + (0x80 * (x)))
+#define XGMAC_MTL_RXQ_FLOW_CONTROL(a, x)	(xgmac_mtl_chanx_base_addr(a, x) + 0x50)
 #define XGMAC_RFD			GENMASK(31, 17)
 #define XGMAC_RFA			GENMASK(15, 1)
-#define XGMAC_MTL_QINTEN(x)		(0x00001170 + (0x80 * (x)))
+#define XGMAC_MTL_QINTEN(a, x)			(xgmac_mtl_chanx_base_addr(a, x) + 0x70)
 #define XGMAC_RXOIE			BIT(16)
-#define XGMAC_MTL_QINT_STATUS(x)	(0x00001174 + (0x80 * (x)))
+#define XGMAC_MTL_QINT_STATUS(a, x)		(xgmac_mtl_chanx_base_addr(a, x) + 0x74)
 #define XGMAC_RXOVFIS			BIT(16)
 #define XGMAC_ABPSIS			BIT(1)
 #define XGMAC_TXUNFIS			BIT(0)
-#define XGMAC_MAC_REGSIZE		(XGMAC_MTL_QINT_STATUS(15) / 4)
+#define XGMAC_MAC_REGSIZE(a)		(XGMAC_MTL_QINT_STATUS(a, 15) / 4)
 
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
@@ -353,28 +374,43 @@
 #define XGMAC_TCEIE			BIT(0)
 #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
 #define XGMAC_DMA_DPP_INT_STATUS	0x00003074
-#define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
+
+/* DMA per-channel registers */
+#define XGMAC_DMA_CHAN_BASE_ADDR	0x00003100
+#define XGMAC_DMA_CHAN_OFFSET		0x80
+
+static inline u32
+xgmac_dma_chanx_base_addr(const struct dwxgmac_addrs *addrs, u32 x)
+{
+	if (addrs && (x & 1))
+		return addrs->dma_odd_chan_base + x * addrs->dma_chan_offset;
+	if (addrs)
+		return addrs->dma_even_chan_base + x * addrs->dma_chan_offset;
+	return XGMAC_DMA_CHAN_BASE_ADDR + x * XGMAC_DMA_CHAN_OFFSET;
+}
+
+#define XGMAC_DMA_CH_CONTROL(a, x)		(xgmac_dma_chanx_base_addr(a, x))
 #define XGMAC_SPH			BIT(24)
 #define XGMAC_PBLx8			BIT(16)
-#define XGMAC_DMA_CH_TX_CONTROL(x)	(0x00003104 + (0x80 * (x)))
+#define XGMAC_DMA_CH_TX_CONTROL(a, x)		(xgmac_dma_chanx_base_addr(a, x) + 0x04)
 #define XGMAC_EDSE			BIT(28)
 #define XGMAC_TxPBL			GENMASK(21, 16)
 #define XGMAC_TSE			BIT(12)
 #define XGMAC_OSP			BIT(4)
 #define XGMAC_TXST			BIT(0)
-#define XGMAC_DMA_CH_RX_CONTROL(x)	(0x00003108 + (0x80 * (x)))
+#define XGMAC_DMA_CH_RX_CONTROL(a, x)		(xgmac_dma_chanx_base_addr(a, x) + 0x08)
 #define XGMAC_RxPBL			GENMASK(21, 16)
 #define XGMAC_RBSZ			GENMASK(14, 1)
 #define XGMAC_RXST			BIT(0)
-#define XGMAC_DMA_CH_TxDESC_HADDR(x)	(0x00003110 + (0x80 * (x)))
-#define XGMAC_DMA_CH_TxDESC_LADDR(x)	(0x00003114 + (0x80 * (x)))
-#define XGMAC_DMA_CH_RxDESC_HADDR(x)	(0x00003118 + (0x80 * (x)))
-#define XGMAC_DMA_CH_RxDESC_LADDR(x)	(0x0000311c + (0x80 * (x)))
-#define XGMAC_DMA_CH_TxDESC_TAIL_LPTR(x)	(0x00003124 + (0x80 * (x)))
-#define XGMAC_DMA_CH_RxDESC_TAIL_LPTR(x)	(0x0000312c + (0x80 * (x)))
-#define XGMAC_DMA_CH_TxDESC_RING_LEN(x)		(0x00003130 + (0x80 * (x)))
-#define XGMAC_DMA_CH_RxDESC_RING_LEN(x)		(0x00003134 + (0x80 * (x)))
-#define XGMAC_DMA_CH_INT_EN(x)		(0x00003138 + (0x80 * (x)))
+#define XGMAC_DMA_CH_TxDESC_HADDR(a, x)	(xgmac_dma_chanx_base_addr(a, x) + 0x10)
+#define XGMAC_DMA_CH_TxDESC_LADDR(a, x)	(xgmac_dma_chanx_base_addr(a, x) + 0x14)
+#define XGMAC_DMA_CH_RxDESC_HADDR(a, x)	(xgmac_dma_chanx_base_addr(a, x) + 0x18)
+#define XGMAC_DMA_CH_RxDESC_LADDR(a, x)	(xgmac_dma_chanx_base_addr(a, x) + 0x1c)
+#define XGMAC_DMA_CH_TxDESC_TAIL_LPTR(a, x)	(xgmac_dma_chanx_base_addr(a, x) + 0x24)
+#define XGMAC_DMA_CH_RxDESC_TAIL_LPTR(a, x)	(xgmac_dma_chanx_base_addr(a, x) + 0x2c)
+#define XGMAC_DMA_CH_TxDESC_RING_LEN(a, x)	(xgmac_dma_chanx_base_addr(a, x) + 0x30)
+#define XGMAC_DMA_CH_RxDESC_RING_LEN(a, x)	(xgmac_dma_chanx_base_addr(a, x) + 0x34)
+#define XGMAC_DMA_CH_INT_EN(a, x)		(xgmac_dma_chanx_base_addr(a, x) + 0x38)
 #define XGMAC_NIE			BIT(15)
 #define XGMAC_AIE			BIT(14)
 #define XGMAC_RBUE			BIT(7)
@@ -385,9 +421,9 @@
 					XGMAC_RIE | XGMAC_TIE)
 #define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RIE)
 #define XGMAC_DMA_INT_DEFAULT_TX	(XGMAC_TIE)
-#define XGMAC_DMA_CH_Rx_WATCHDOG(x)	(0x0000313c + (0x80 * (x)))
+#define XGMAC_DMA_CH_Rx_WATCHDOG(a, x)		(xgmac_dma_chanx_base_addr(a, x) + 0x3c)
 #define XGMAC_RWT			GENMASK(7, 0)
-#define XGMAC_DMA_CH_STATUS(x)		(0x00003160 + (0x80 * (x)))
+#define XGMAC_DMA_CH_STATUS(a, x)		(xgmac_dma_chanx_base_addr(a, x) + 0x60)
 #define XGMAC_NIS			BIT(15)
 #define XGMAC_AIS			BIT(14)
 #define XGMAC_FBE			BIT(12)
@@ -396,7 +432,7 @@
 #define XGMAC_TBU			BIT(2)
 #define XGMAC_TPS			BIT(1)
 #define XGMAC_TI			BIT(0)
-#define XGMAC_REGSIZE			((0x0000317c + (0x80 * 15)) / 4)
+#define XGMAC_REGSIZE(a)		((xgmac_dma_chanx_base_addr(a, 15) + 0x7c) / 4)
 
 #define XGMAC_DMA_STATUS_MSK_COMMON	(XGMAC_NIS | XGMAC_AIS | XGMAC_FBE)
 #define XGMAC_DMA_STATUS_MSK_RX		(XGMAC_RBU | XGMAC_RI | \
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1a88cbaed70ca18bbb714681569ede863f7130e5..d1099a1cf9ea56661e2beceeaa3f1938e51dfb3c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -234,11 +234,11 @@ static void dwxgmac2_prog_mtl_tx_algorithms(struct mac_device_info *hw,
 
 	/* Set ETS if desired */
 	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
-		value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
+		value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(hw->dwxgmac_addrs, i));
 		value &= ~XGMAC_TSA;
 		if (ets)
 			value |= XGMAC_ETS;
-		writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
+		writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(hw->dwxgmac_addrs, i));
 	}
 }
 
@@ -246,9 +246,10 @@ static void dwxgmac2_set_mtl_tx_queue_weight(struct stmmac_priv *priv,
 					     struct mac_device_info *hw,
 					     u32 weight, u32 queue)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	void __iomem *ioaddr = hw->pcsr;
 
-	writel(weight, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(queue));
+	writel(weight, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(addrs, queue));
 }
 
 static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
@@ -273,18 +274,19 @@ static void dwxgmac2_config_cbs(struct stmmac_priv *priv,
 				u32 send_slope, u32 idle_slope,
 				u32 high_credit, u32 low_credit, u32 queue)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 
-	writel(send_slope, ioaddr + XGMAC_MTL_TCx_SENDSLOPE(queue));
-	writel(idle_slope, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(queue));
-	writel(high_credit, ioaddr + XGMAC_MTL_TCx_HICREDIT(queue));
-	writel(low_credit, ioaddr + XGMAC_MTL_TCx_LOCREDIT(queue));
+	writel(send_slope, ioaddr + XGMAC_MTL_TCx_SENDSLOPE(addrs, queue));
+	writel(idle_slope, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(addrs, queue));
+	writel(high_credit, ioaddr + XGMAC_MTL_TCx_HICREDIT(addrs, queue));
+	writel(low_credit, ioaddr + XGMAC_MTL_TCx_LOCREDIT(addrs, queue));
 
-	value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue));
+	value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(addrs, queue));
 	value &= ~XGMAC_TSA;
 	value |= XGMAC_CC | XGMAC_CBS;
-	writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue));
+	writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(addrs, queue));
 }
 
 static void dwxgmac2_dump_regs(struct mac_device_info *hw, u32 *reg_space)
@@ -292,7 +294,7 @@ static void dwxgmac2_dump_regs(struct mac_device_info *hw, u32 *reg_space)
 	void __iomem *ioaddr = hw->pcsr;
 	int i;
 
-	for (i = 0; i < XGMAC_MAC_REGSIZE; i++)
+	for (i = 0; i < XGMAC_MAC_REGSIZE(hw->dwxgmac_addrs); i++)
 		reg_space[i] = readl(ioaddr + i * 4);
 }
 
@@ -336,18 +338,19 @@ static int dwxgmac2_host_irq_status(struct stmmac_priv *priv,
 static int dwxgmac2_host_mtl_irq_status(struct stmmac_priv *priv,
 					struct mac_device_info *hw, u32 chan)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	void __iomem *ioaddr = hw->pcsr;
 	int ret = 0;
 	u32 status;
 
 	status = readl(ioaddr + XGMAC_MTL_INT_STATUS);
 	if (status & BIT(chan)) {
-		u32 chan_status = readl(ioaddr + XGMAC_MTL_QINT_STATUS(chan));
+		u32 chan_status = readl(ioaddr + XGMAC_MTL_QINT_STATUS(addrs, chan));
 
 		if (chan_status & XGMAC_RXOVFIS)
 			ret |= CORE_IRQ_MTL_RX_OVERFLOW;
 
-		writel(~0x0, ioaddr + XGMAC_MTL_QINT_STATUS(chan));
+		writel(~0x0, ioaddr + XGMAC_MTL_QINT_STATUS(addrs, chan));
 	}
 
 	return ret;
@@ -1143,14 +1146,15 @@ static int dwxgmac3_rxp_config(void __iomem *ioaddr,
 static int dwxgmac2_get_mac_tx_timestamp(struct mac_device_info *hw, u64 *ts)
 {
 	void __iomem *ioaddr = hw->pcsr;
+	const struct dwxgmac_addrs *addrs = hw->dwxgmac_addrs;
 	u32 value;
 
-	if (readl_poll_timeout_atomic(ioaddr + XGMAC_TIMESTAMP_STATUS,
+	if (readl_poll_timeout_atomic(ioaddr + XGMAC_TIMESTAMP_STATUS(addrs),
 				      value, value & XGMAC_TXTSC, 100, 10000))
 		return -EBUSY;
 
-	*ts = readl(ioaddr + XGMAC_TXTIMESTAMP_NSEC) & XGMAC_TXTSSTSLO;
-	*ts += readl(ioaddr + XGMAC_TXTIMESTAMP_SEC) * 1000000000ULL;
+	*ts = readl(ioaddr + XGMAC_TXTIMESTAMP_NSEC(addrs)) & XGMAC_TXTSSTSLO;
+	*ts += readl(ioaddr + XGMAC_TXTIMESTAMP_SEC(addrs)) * 1000000000ULL;
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index ff83858ebc1f33aa8092a2d83018bd5f96b7eead..65d5e2a828076563a1c7368124ddda226bfffc7a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -47,13 +47,14 @@ static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
 				   void __iomem *ioaddr,
 				   struct stmmac_dma_cfg *dma_cfg, u32 chan)
 {
-	u32 value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+	u32 value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(addrs, chan));
 
 	if (dma_cfg->pblx8)
 		value |= XGMAC_PBLx8;
 
-	writel(value, ioaddr + XGMAC_DMA_CH_CONTROL(chan));
-	writel(XGMAC_DMA_INT_DEFAULT_EN, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_CONTROL(addrs, chan));
+	writel(XGMAC_DMA_INT_DEFAULT_EN, ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
 }
 
 static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
@@ -61,15 +62,16 @@ static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
 				      struct stmmac_dma_cfg *dma_cfg,
 				      dma_addr_t phy, u32 chan)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	u32 rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
 	u32 value;
 
-	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
 	value = u32_replace_bits(value, rxpbl, XGMAC_RxPBL);
-	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
 
-	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
-	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
+	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(addrs, chan));
+	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(addrs, chan));
 }
 
 static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
@@ -77,15 +79,16 @@ static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
 				      struct stmmac_dma_cfg *dma_cfg,
 				      dma_addr_t phy, u32 chan)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	u32 txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
 	u32 value;
 
-	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
 	value = u32_replace_bits(value, txpbl, XGMAC_TxPBL);
-	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
 
-	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
-	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
+	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(addrs, chan));
+	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(addrs, chan));
 }
 
 static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
@@ -118,16 +121,18 @@ static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 static void dwxgmac2_dma_dump_regs(struct stmmac_priv *priv,
 				   void __iomem *ioaddr, u32 *reg_space)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	int i;
 
-	for (i = (XGMAC_DMA_MODE / 4); i < XGMAC_REGSIZE; i++)
+	for (i = (XGMAC_DMA_MODE / 4); i < XGMAC_REGSIZE(addrs); i++)
 		reg_space[i] = readl(ioaddr + i * 4);
 }
 
 static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 				 int mode, u32 channel, int fifosz, u8 qmode)
 {
-	u32 value = readl(ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+	u32 value = readl(ioaddr + XGMAC_MTL_RXQ_OPMODE(addrs, channel));
 	unsigned int rqs = fifosz / 256 - 1;
 	unsigned int rtc;
 
@@ -149,7 +154,7 @@ static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value = u32_replace_bits(value, rqs, XGMAC_RQS);
 
 	if ((fifosz >= 4096) && (qmode != MTL_QUEUE_AVB)) {
-		u32 flow = readl(ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(channel));
+		u32 flow = readl(ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(addrs, channel));
 		unsigned int rfd, rfa;
 
 		value |= XGMAC_EHFC;
@@ -178,16 +183,17 @@ static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 		flow = u32_replace_bits(flow, rfd, XGMAC_RFD);
 		flow = u32_replace_bits(flow, rfa, XGMAC_RFA);
 
-		writel(flow, ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(channel));
+		writel(flow, ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(addrs, channel));
 	}
 
-	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
+	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(addrs, channel));
 }
 
 static void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 				 int mode, u32 channel, int fifosz, u8 qmode)
 {
-	u32 value = readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(channel));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+	u32 value = readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(addrs, channel));
 	unsigned int tqs = fifosz / 256 - 1;
 	unsigned int ttc, txqen;
 
@@ -225,45 +231,48 @@ static void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value = u32_replace_bits(value, txqen, XGMAC_TXQEN);
 	value = u32_replace_bits(value, tqs, XGMAC_TQS);
 
-	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(channel));
+	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(addrs, channel));
 }
 
 static void dwxgmac2_enable_dma_irq(struct stmmac_priv *priv,
 				    void __iomem *ioaddr, u32 chan,
 				    bool rx, bool tx)
 {
-	u32 value = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+	u32 value = readl(ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
 
 	if (rx)
 		value |= XGMAC_DMA_INT_DEFAULT_RX;
 	if (tx)
 		value |= XGMAC_DMA_INT_DEFAULT_TX;
 
-	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
 }
 
 static void dwxgmac2_disable_dma_irq(struct stmmac_priv *priv,
 				     void __iomem *ioaddr, u32 chan,
 				     bool rx, bool tx)
 {
-	u32 value = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+	u32 value = readl(ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
 
 	if (rx)
 		value &= ~XGMAC_DMA_INT_DEFAULT_RX;
 	if (tx)
 		value &= ~XGMAC_DMA_INT_DEFAULT_TX;
 
-	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
 }
 
 static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
 				  void __iomem *ioaddr, u32 chan)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	u32 value;
 
-	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
 	value |= XGMAC_TXST;
-	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
 
 	value = readl(ioaddr + XGMAC_TX_CONFIG);
 	value |= XGMAC_CONFIG_TE;
@@ -273,11 +282,12 @@ static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
 static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 				 u32 chan)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	u32 value;
 
-	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
 	value &= ~XGMAC_TXST;
-	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
 
 	value = readl(ioaddr + XGMAC_TX_CONFIG);
 	value &= ~XGMAC_CONFIG_TE;
@@ -287,11 +297,12 @@ static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
 				  void __iomem *ioaddr, u32 chan)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	u32 value;
 
-	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
 	value |= XGMAC_RXST;
-	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
 
 	value = readl(ioaddr + XGMAC_RX_CONFIG);
 	value |= XGMAC_CONFIG_RE;
@@ -301,11 +312,12 @@ static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
 static void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
 				 u32 chan)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	u32 value;
 
-	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
 	value &= ~XGMAC_RXST;
-	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
 }
 
 static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
@@ -314,8 +326,9 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 				  u32 dir)
 {
 	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
-	u32 intr_status = readl(ioaddr + XGMAC_DMA_CH_STATUS(chan));
-	u32 intr_en = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+	u32 intr_status = readl(ioaddr + XGMAC_DMA_CH_STATUS(addrs, chan));
+	u32 intr_en = readl(ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
 	int ret = 0;
 
 	if (dir == DMA_DIR_RX)
@@ -354,7 +367,7 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 	}
 
 	/* Clear interrupts */
-	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(chan));
+	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(addrs, chan));
 
 	return ret;
 }
@@ -483,105 +496,120 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 static void dwxgmac2_rx_watchdog(struct stmmac_priv *priv, void __iomem *ioaddr,
 				 u32 riwt, u32 queue)
 {
-	writel(riwt & XGMAC_RWT, ioaddr + XGMAC_DMA_CH_Rx_WATCHDOG(queue));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+
+	writel(riwt & XGMAC_RWT, ioaddr + XGMAC_DMA_CH_Rx_WATCHDOG(addrs, queue));
 }
 
 static void dwxgmac2_set_rx_ring_len(struct stmmac_priv *priv,
 				     void __iomem *ioaddr, u32 len, u32 chan)
 {
-	writel(len, ioaddr + XGMAC_DMA_CH_RxDESC_RING_LEN(chan));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+
+	writel(len, ioaddr + XGMAC_DMA_CH_RxDESC_RING_LEN(addrs, chan));
 }
 
 static void dwxgmac2_set_tx_ring_len(struct stmmac_priv *priv,
 				     void __iomem *ioaddr, u32 len, u32 chan)
 {
-	writel(len, ioaddr + XGMAC_DMA_CH_TxDESC_RING_LEN(chan));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+
+	writel(len, ioaddr + XGMAC_DMA_CH_TxDESC_RING_LEN(addrs, chan));
 }
 
 static void dwxgmac2_set_rx_tail_ptr(struct stmmac_priv *priv,
 				     void __iomem *ioaddr, u32 ptr, u32 chan)
 {
-	writel(ptr, ioaddr + XGMAC_DMA_CH_RxDESC_TAIL_LPTR(chan));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+
+	writel(ptr, ioaddr + XGMAC_DMA_CH_RxDESC_TAIL_LPTR(addrs, chan));
 }
 
 static void dwxgmac2_set_tx_tail_ptr(struct stmmac_priv *priv,
 				     void __iomem *ioaddr, u32 ptr, u32 chan)
 {
-	writel(ptr, ioaddr + XGMAC_DMA_CH_TxDESC_TAIL_LPTR(chan));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+
+	writel(ptr, ioaddr + XGMAC_DMA_CH_TxDESC_TAIL_LPTR(addrs, chan));
 }
 
 static void dwxgmac2_enable_tso(struct stmmac_priv *priv, void __iomem *ioaddr,
 				bool en, u32 chan)
 {
-	u32 value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+	u32 value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
 
 	if (en)
 		value |= XGMAC_TSE;
 	else
 		value &= ~XGMAC_TSE;
 
-	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
 }
 
 static void dwxgmac2_qmode(struct stmmac_priv *priv, void __iomem *ioaddr,
 			   u32 channel, u8 qmode)
 {
-	u32 value = readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(channel));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+	u32 value = readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(addrs, channel));
 	u32 flow = readl(ioaddr + XGMAC_RX_FLOW_CTRL);
 	unsigned int txqen;
 
 	if (qmode != MTL_QUEUE_AVB) {
 		txqen = 0x2;
-		writel(0, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(channel));
+		writel(0, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(addrs, channel));
 	} else {
 		txqen = 0x1;
 		writel(flow & (~XGMAC_RFE), ioaddr + XGMAC_RX_FLOW_CTRL);
 	}
 
 	value = u32_replace_bits(value, txqen, XGMAC_TXQEN);
-	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(channel));
+	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(addrs, channel));
 }
 
 static void dwxgmac2_set_bfsize(struct stmmac_priv *priv, void __iomem *ioaddr,
 				int bfsize, u32 chan)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	u32 value;
 
-	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
 	value = u32_replace_bits(value, bfsize, XGMAC_RBSZ);
-	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
 }
 
 static void dwxgmac2_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
 				bool en, u32 chan)
 {
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
 	u32 value = readl(ioaddr + XGMAC_RX_CONFIG);
 
 	value &= ~XGMAC_CONFIG_HDSMS;
 	value |= XGMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
 	writel(value, ioaddr + XGMAC_RX_CONFIG);
 
-	value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
+	value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(addrs, chan));
 	if (en)
 		value |= XGMAC_SPH;
 	else
 		value &= ~XGMAC_SPH;
-	writel(value, ioaddr + XGMAC_DMA_CH_CONTROL(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_CONTROL(addrs, chan));
 }
 
 static int dwxgmac2_enable_tbs(struct stmmac_priv *priv, void __iomem *ioaddr,
 			       bool en, u32 chan)
 {
-	u32 value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	const struct dwxgmac_addrs *addrs = priv->plat->dwxgmac_addrs;
+	u32 value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
 
 	if (en)
 		value |= XGMAC_EDSE;
 	else
 		value &= ~XGMAC_EDSE;
 
-	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
 
-	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan)) & XGMAC_EDSE;
+	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan)) & XGMAC_EDSE;
 	if (en && !value)
 		return -EIO;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 265671170bf6e3856263fdcf99afbf3eac79a211..fdae241e5cf49a8d7a15aadb67d40700ab5b4429 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -368,8 +368,11 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	mac->vlan = mac->vlan ? : entry->vlan;
 
 	priv->hw = mac;
+	mac->dwxgmac_addrs = priv->plat->dwxgmac_addrs;
 	priv->fpe_cfg.reg = entry->regs.fpe_reg;
-	priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
+	priv->ptpaddr = priv->ioaddr +
+		(priv->plat->dwxgmac_addrs ?
+		 priv->plat->dwxgmac_addrs->timestamp_base : entry->regs.ptp_off);
 	priv->mmcaddr = priv->ioaddr + entry->regs.mmc_off;
 	memcpy(&priv->ptp_clock_ops, entry->ptp,
 	       sizeof(struct ptp_clock_info));
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 1cf0f8820b337a0d7a9aa23c7d9b34e3f5616dad..82ce81fb6a18b66f2028a5a7784f0a3b9317b9bc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -351,8 +351,9 @@ static int stmmac_ethtool_get_regs_len(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
-		return XGMAC_REGSIZE * 4;
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC ||
+	    priv->plat->core_type == DWMAC_CORE_25GMAC)
+		return XGMAC_REGSIZE(priv->plat->dwxgmac_addrs) * 4;
 	else if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 		return GMAC4_REG_SPACE_SIZE;
 	return REG_SPACE_SIZE;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index c889204a7aa5d2e74f7834ed1a22252e6c51ca36..1190b8854132915905773796f07503a9bf1446a0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -265,9 +265,12 @@ int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
 	if (!num_tc) {
 		/* Restore default TC:Queue mapping */
 		for (u32 i = 0; i < priv->plat->tx_queues_to_use; i++) {
-			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
+			val = readl(priv->ioaddr +
+				    XGMAC_MTL_TXQ_OPMODE(priv->plat->dwxgmac_addrs,
+							 i));
 			writel(u32_replace_bits(val, i, XGMAC_Q2TCMAP),
-			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
+			       priv->ioaddr +
+			       XGMAC_MTL_TXQ_OPMODE(priv->plat->dwxgmac_addrs, i));
 		}
 	}
 
@@ -288,9 +291,13 @@ int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
 			preemptible_txqs |= GENMASK(offset + count - 1, offset);
 
 		for (u32 i = 0; i < count; i++) {
-			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
+			val = readl(priv->ioaddr +
+				    XGMAC_MTL_TXQ_OPMODE(priv->plat->dwxgmac_addrs,
+							 offset + i));
 			writel(u32_replace_bits(val, tc, XGMAC_Q2TCMAP),
-			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
+			       priv->ioaddr +
+			       XGMAC_MTL_TXQ_OPMODE(priv->plat->dwxgmac_addrs,
+						    offset + i));
 		}
 	}
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 00be2df63d2206a5865bd29333f2f3ba3442962a..5bb904030ef99ac91f66fabaa6c2159da1ec8811 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -188,6 +188,16 @@ struct dwmac4_addrs {
 	u32 mtl_low_cred_offset;
 };
 
+/* Address layout for XGMAC MTL, DMA, and timestamp registers */
+struct dwxgmac_addrs {
+	u32 dma_even_chan_base;
+	u32 dma_odd_chan_base;
+	u32 dma_chan_offset;
+	u32 mtl_chan_base;
+	u32 mtl_chan_offset;
+	u32 timestamp_base;
+};
+
 enum dwmac_core_type {
 	DWMAC_CORE_MAC100,
 	DWMAC_CORE_GMAC,
@@ -358,6 +368,7 @@ struct plat_stmmacenet_data {
 	int msi_rx_base_vec;
 	int msi_tx_base_vec;
 	const struct dwmac4_addrs *dwmac4_addrs;
+	const struct dwxgmac_addrs *dwxgmac_addrs;
 	unsigned int flags;
 	struct stmmac_dma_cfg __dma_cfg;
 };

-- 
2.34.1

