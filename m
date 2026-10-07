Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52144351C22
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398350; cv=none; b=hM+ujHvqI6luG2aNiBY5mousv8vPLDRhySbq7Q+taznNVD1Wb1pG7go7rXafNmPeQfR0R/KXkLSfGEqZVJmv3TSkBqkKC832ZnbU9PBqKomksMk1GNDAkRkhV+GlqOnX7Qzid7N4YLfy7gt3TSG/LOneumaLumLpn7TBnaOmXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398350; c=relaxed/simple;
	bh=D2ZtgQBWKQ5Iud3OZOgKL0eZGpuLy8bWlw4qlcJDpU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DFqsH17SPz+jLUtF7jtbgbJFcyqZDhWa7/dYv6x3M+s73AOKGtDHEig6ZYw/sRn3V9N/dn77+24mWsopUj39Vgz0vWP1m19UKRf+rLxJ0mw0goDb23ZGFbrEtVrIpOLjOFp6PkmMNSaXvI/U/t4+YW7Djts6cPFJMumqaqrN5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mPPZ1+pn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gMMem1i8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mPPZ1+pn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gMMem1i8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697IBh5s4077405
	for <netdev@vger.kernel.org>; Wed, 7 Oct 2026 18:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HORHFDrmI/BPkmzKwb7d3T8boR+07sV7F6A
	aiYBuxXs=; b=mPPZ1+pnO/DRbWx2a/GGFz+B9YxyfdzSVwmRQekU8pvjx2cmVCT
	MhSSrVJTxnFswZJyBO7MeHKUT1YQyP9GjiA7KKFlbJikQpYun5ZfKiMcsvRGUQu4
	iKgA68wvAPxVPlsDuF7RO+JsXLQyDGZGBc0u+tHeITZBOpQRrg6O6LVLlpEt7VnF
	8nCJGQHFgk08PnDd11JWlD5L/TrRSVohe7flmydpIMxiSU8AUpV7rzaJO691cIJ+
	PYSV60xg8ECFPRxHBOsIa0ppbiJEH1WvCoXreH05fp50bkUAf4kJ5/E5+jM+rHXB
	+2JqsNTPmnwN9zOb25aO2t5l6A4FmUUtdSQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c1s3nq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 18:39:08 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14fed306427so14972810c88.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791398348; x=1792003148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HORHFDrmI/BPkmzKwb7d3T8boR+07sV7F6AaiYBuxXs=;
        b=gMMem1i8dR9iOYqPdLGB8fS8sf1uFmWrQdUAel1IKd6lsdTO9AFdeAiPDMVlWCVHk7
         qH/bco8+VahziY9cI0Re5ad/+BOEAZm0afuCVaUpCrIZ85iNASQeB02SO7XZBEpHBk/F
         6jPJXCjvJU0uS/2IXhb7qRrx6NwGu3WrT6WvlvzK+tvV26Lxd8GcYjaqP5u0E2YtB121
         ezr3dOf29I9FWVw9weo0wuWb91/iUJSK7B4WpWiprMXvAvFNQKkOayGvbLOOWBct2743
         qch1LnadOQa/bcopbbhN8uZV8fp26H3xe4JSH2UEL0LLDVo/kE6FpjkUUDRLgElFtk2z
         Ry7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791398348; x=1792003148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HORHFDrmI/BPkmzKwb7d3T8boR+07sV7F6AaiYBuxXs=;
        b=qvnjTDK2MKxol49vlzP1xbMmvU+4a8y+YVDNM/1YGwoE5MSOUr9KaEAasMbiKOat69
         r7bpgmwKEfSZHVJixci+m5qEubvEI4uwDlR201Pn9ayg31UKf6Zw3Rx5fd1kMlUvYGyA
         5t92U9ZL2fAPW1pVB6lH0AIBY71rWvYF9HKqbx3q2y1z5AVAnoS+1TbZeFPPxHnpW6de
         cMkuD70Vvl8/qmdithavQVuzVeOJNrpsl8C3r9XS52dJMJub3cZ6VrpPo4w+zav7xBvu
         VP2zTFO3A8HxQo13QSyVlnBJJsdbnNO/VF+A3TM0dDrrZ+jtxHfyhbdiBj0721sNJOyc
         XwVg==
X-Gm-Message-State: AFuF++mlQmDm7CG2jFzWATNYOUR51Mb2o5NH/w/Z1B2ao2fYpB+742WM
	qcg5wWl2UTjBGCPunTUyaMdeiAjYGwFkVJbJvS76srQdTlnfK5ahasa5QRE0SsmXTy0Exs7+UEc
	FnaRZFePhdhrLnybLrUzj3uES36x5EVbN5I90eYSHF1/TUW6tld+a1PDxuAM=
X-Gm-Gg: AYBFou2hz0TNzHRzaNqnVBvRYk5LjpNIQLOgeBXOInpOULJrAhM6TZjnPcu9LkIBPEM
	CvqrRh44GKIn6q0hRnVDCF/S7MyLXcdNjsRZ4qB9A6VhSsaX4w26BHsmobKAulfyTyTkV11Go0w
	Wn0nqnDIs7UKHqpBDq9quMqAZrbCg1cVXrQhbwd/r3G3yJvrN2KlxluXpiGS5FD3iBoHyauHwL4
	KuWjG0fB27JlQlpId7HioNgCUJY5puwveLHP3TZUyQddad4wASMCW6CA4f4Z5VJzpJbD+jF6Bt/
	g4QHrZCfyoB9asirvABdYzQNVlACIg3OBp3KwfjZATR51+mIAn54ecA2FFyQK2G9AIfMQluwdgn
	Tyl2442n4/e6nqot28amiFzdiodVkrQZ/G33A+4yUvi1YRLEUp6m3mxVVau8kOp8=
X-Received: by 2002:a05:7022:7e0d:b0:144:eb46:c3f with SMTP id a92af1059eb24-161fd7106admr3845784c88.2.1791398347568;
        Wed, 07 Oct 2026 11:39:07 -0700 (PDT)
X-Received: by 2002:a05:7022:7e0d:b0:144:eb46:c3f with SMTP id a92af1059eb24-161fd7106admr3845740c88.2.1791398347007;
        Wed, 07 Oct 2026 11:39:07 -0700 (PDT)
Received: from hu-scheluve-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-161684ba3fdsm8156055c88.12.2026.10.07.11.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:39:06 -0700 (PDT)
From: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>,
        Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>,
        Sarosh Hasan <sarosh.hasan@oss.qualcomm.com>,
        Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Subject: [PATCH net-next v2] net: stmmac: dwxgmac2: enable L2 split header support
Date: Wed,  7 Oct 2026 11:39:05 -0700
Message-Id: <20261007183905.2582759-1-sagar.cheluvegowda@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jBIhpAHKuLE82lcFvbU2w6tJ3hsbKl2e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX/FFU6CBImgj2
 THuazDfkg4yBUY8e6RHxCRhlvFFBRs9favvcVi5gFqmUbqHjhFvlD4T9BiUfpW+jSIA02+iGDKx
 z1UBOAfSsgV52iZDEQ7/I0WcHW7HvndEIVBO4CjWJ3zZQavXLUdn9MBtw6Aq5EjEIQLTVlS2zxw
 U/EIrgRy2TTv3E6OT3gICB3QhLruzh4gDMxOcG6PM1VRYzXf0t/8BC301uOT7azctI8EQk20Wfu
 smpFPugJsV9JWNqzi6bulWxW/fnVfb6WwxyAOW/Q2uLR/MjZGO+tzUgFp53f/pO9IhQsFeG6x5X
 YA1ANq9aS/JODg1ACMs4c1ONcxJT2j4a88ka5sdHQFaMps+uQ+8G6sFYvR1RzzdeU/Tcs5G+mVS
 MzNRzf8lzBCJQ2goavoz+suEeilzfUL9BqmHPWO8wNccfuoOj5Sg+AnqysgAEqntJe0SsyAq3tV
 UTjTu6DYjET07LdIy2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX+kB6sLyTR4hc
 DoSS2/jKrAnN5W4a//sey61gRaQTX1ryO1Crq17BlBNfTxHPERjivzhUbKPcUeF6+IY+BeGy/F+
 nhTdC9KUuk1Jz/viSSWUvIHHj/cGXzA=
X-Proofpoint-GUID: jBIhpAHKuLE82lcFvbU2w6tJ3hsbKl2e
X-Authority-Analysis: v=2.4 cv=NatzRGD4 c=1 sm=1 tr=0 ts=6ac691cc cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4efHNOip1X5BxVcu0mkA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070074

XGMAC2 doesn't program the MAC extended configuration registers
needed for L2 header splitting when split-header mode is enabled,
so tagged AV packets can't use the split-header path. Configure
split mode (SPLM) and header saving (SAVE_EN) in XGMAC_EXT_CFG1,
extending the dwmac4 sequence added by commit d10f1a4e44c3 ("net:
stmmac: Programming sequence for VLAN packets with split header")
to XGMAC2.

Also fix the RX header-length calculation for split-header
descriptors. Per the XGMAC2 descriptor format, RDES3's L34T and
L2T fields are only valid on the last descriptor (LD set); on a
non-last descriptor they can hold stale write-back data from a
previous packet. Read the header length from RDES2[9:0] directly
for non-last descriptors, and only consult L34T/L2T on the last
descriptor: RDES2[9:0] for IP packets (L34T set) and RDES2[9:2]
for non-IP packets (L2T set).

Finally, disable the variable-length preamble when L2 splitting
is enabled. A variable-length preamble shifts the position of the
Ethernet header, making the L2 split offset non-deterministic.

Co-developed-by: Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>
Signed-off-by: Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>
Co-developed-by: Sarosh Hasan <sarosh.hasan@oss.qualcomm.com>
Signed-off-by: Sarosh Hasan <sarosh.hasan@oss.qualcomm.com>
Signed-off-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
---
v2:
  - Add XGMAC_CONFIG1_SPLM_MASK and use it in XGMAC_CONFIG1_SPLM()
v1: https://lore.kernel.org/netdev/20260922232116.889630-1-sagar.cheluvegowda@oss.qualcomm.com/

 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h       |  8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 12 +++++++++++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c   | 10 ++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index f8ab347f7b5b..fb29dd489714 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -167,6 +167,12 @@
 #define XGMAC_HW_FEATURE4		0x0000012c
 #define XGMAC_HWFEAT_EASP		BIT(4)
 #define XGMAC_HWFEAT_PCSEL		GENMASK(1, 0)
+#define XGMAC_EXT_CFG0			0x140
+#define XGMAC_EXT_CFG0_VPRE		BIT(8)
+#define XGMAC_EXT_CFG1			0x00000144
+#define XGMAC_CONFIG1_SAVE_EN		BIT(24)
+#define XGMAC_CONFIG1_SPLM_MASK		GENMASK(9, 8)
+#define XGMAC_CONFIG1_SPLM(v)		FIELD_PREP(XGMAC_CONFIG1_SPLM_MASK, v)
 #define XGMAC_MAC_DPP_FSM_INT_STATUS	0x00000150
 #define XGMAC_MAC_FSM_CONTROL		0x00000158
 #define XGMAC_PRTYEN			BIT(1)
@@ -434,6 +440,7 @@
 #define XGMAC_RDES2_L4FM		BIT(28)
 #define XGMAC_RDES2_L3FM		BIT(27)
 #define XGMAC_RDES2_HL			GENMASK(9, 0)
+#define XGMAC_RDES2_NONIPHL		GENMASK(9, 2)
 #define XGMAC_RDES3_OWN			BIT(31)
 #define XGMAC_RDES3_CTXT		BIT(30)
 #define XGMAC_RDES3_IOC			BIT(30)
@@ -441,6 +448,7 @@
 #define XGMAC_RDES3_CDA			BIT(27)
 #define XGMAC_RDES3_RSV			BIT(26)
 #define XGMAC_RDES3_L34T		GENMASK(23, 20)
+#define XGMAC_RDES3_L2T			GENMASK(19, 16)
 #define XGMAC_RDES3_ET_LT		GENMASK(19, 16)
 #define XGMAC_L34T_IP4TCP		0x1
 #define XGMAC_L34T_IP4UDP		0x2
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index 6719ac6e395b..65ac5403ec58 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -292,8 +292,18 @@ static int dwxgmac2_get_rx_hash(struct dma_desc *p, u32 *hash,
 
 static void dwxgmac2_get_rx_header_len(struct dma_desc *p, unsigned int *len)
 {
-	if (le32_to_cpu(p->des3) & XGMAC_RDES3_L34T)
+	u32 rdes3 = le32_to_cpu(p->des3);
+
+	/* when FD=1 and LD=0, HL is RDES2[9:0] */
+	if (!(rdes3 & XGMAC_RDES3_LD)) {
+		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
+		return;
+	}
+
+	if (rdes3 & XGMAC_RDES3_L34T)
 		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
+	else if (rdes3 & XGMAC_RDES3_L2T)
+		*len = (le32_to_cpu(p->des2) & XGMAC_RDES2_NONIPHL) >> 2;
 }
 
 static void dwxgmac2_set_sec_addr(struct dma_desc *p, dma_addr_t addr, bool is_valid)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index ff83858ebc1f..0a9c787305a4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -561,6 +561,16 @@ static void dwxgmac2_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value |= XGMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
 	writel(value, ioaddr + XGMAC_RX_CONFIG);
 
+	value = readl(ioaddr + XGMAC_EXT_CFG1);
+	value |= XGMAC_CONFIG1_SPLM(1);
+	value |= XGMAC_CONFIG1_SAVE_EN;
+	writel(value, ioaddr + XGMAC_EXT_CFG1);
+
+	/* Disable variable preambles to keep the L2 split offset deterministic. */
+	value = readl(ioaddr + XGMAC_EXT_CFG0);
+	value &= ~XGMAC_EXT_CFG0_VPRE;
+	writel(value, ioaddr + XGMAC_EXT_CFG0);
+
 	value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
 	if (en)
 		value |= XGMAC_SPH;
-- 
2.34.1

