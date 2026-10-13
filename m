Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0153F6AE
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919684; cv=none; b=qMyz9FmdE8QKOLaywhZQujIUMsdZGeUdwIuvfiSMZOoLhi8eI1AqkxFemoKsTxlVKUcZWcoE+1ox0AHpVmneKHCGEQKvTMtfA2NC+1LqQ9GmYPpuSOHneLX9lR3+EjY8ALugFBdrvs2P+y0pcn/SkuM6ICDKt+ch+1VUJ8TX0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919684; c=relaxed/simple;
	bh=xucrSKdY7RHaRI/nkBngy1nF3VmGw5oHTLPPGDCeYIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u5uqtrDXfrKD84dQqDD6kKZIMrcHE++nQM6D+o1Tl01p1yiSfhgfebnVwiPGmNNlCCM6A/eNmvhqk1Jrnp4bqK8NR+iVVGYj+Qs0kw+4paP36VrZSvcNcbLtCleS0mJMUNYOHIEPWQXxg/aXumq9K5zo0JzV4JN+0yQOkV91wMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqi3ZzIA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R5zOEO2T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqi3ZzIA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5zOEO2T"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DHRFk43017940
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2+k4ctYw0tM7rWPRbxKyU42iiDXNk6+I0nc
	8Mj/rlXA=; b=jqi3ZzIAx1kO09gO94XLKJ/BnI0sCk2YdIqPZu74a7GkhcLKnqt
	wVml33XvSLmoqwMCCjtKWT9fIR9mdsVTDRJihJgFsOBU7lAZ8tdFiXh7rNsLx9GU
	G9zEPU+8HprJ4zMNJI+6GP6m86SwdkoW5aLonjTQZJhSIdSWDzeZBoP2Kzmy+lkA
	B4bfjDkvE9YKbbWR5YJbYjQ21bX/KU5gjEl2Jw0ArUzCNb18dfr7jpoe0B9wnVVq
	shqJe42mEGJxwSTMOQGN0vGon/yaakxcie8XmBDNPNy7gOhMIshQOz0rSb0bQGhM
	FmY0fdJpv5FU+h/qK6jqKGpv4mW6Zz/y/jA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b0kyj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:28:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c5aef2a74so782738eec.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791919681; x=1792524481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+k4ctYw0tM7rWPRbxKyU42iiDXNk6+I0nc8Mj/rlXA=;
        b=R5zOEO2TfHpqmke88kU5Y3A0XVccUT+WeQ+Ifx2FjJ+gWwDqjswjIDMrt3VBUs6Fli
         y8K/gdNhPtLmvyA5FMz8jZ2ZBQmlzk8rQgH/KMFxXd1hm6DmQZcmB7y7JuTmxA1zwyus
         zX/Iok8CWDqJTDDZfZ9My07DfvfIef4wazchBgYZck5tPYJDvmrDfGbrbsF0/4g+k4Ct
         ZDfOrjHvdnn6E7rcDlfEumVnFO/Rbg7ZcUak7m5gBJtB8Jl3GEPk0RrQzA7nlJswXiD0
         YYptSAvjY2BsVxQiGNgpBREfaGRWpFFgAQJsazGs0GtUStuvE7B57bTmPq6ucfIk8KIA
         ZsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919681; x=1792524481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+k4ctYw0tM7rWPRbxKyU42iiDXNk6+I0nc8Mj/rlXA=;
        b=zd2Wj1j6sXeVcQdM3Iu26GUU+PyTSwMZbsI0qdnOaNKbyMmcTtdXsf8Jk/0mtG3UQ4
         K5WScnllvVyux0G6jXoygjP88s3Ww2+Lxw7Y0i8TUnlQ75TWhjrh/wR5ZGKXTahKMXA5
         mqI6RPUFDzu86hD2GZOxoEnhgMx8wEf3oK3VgKY8a6u3bxr6ZjxD7EfDIzN+DbZIpi+K
         2MtyZAFl4Hr/f7NoP0PEDYyloBKt/ox4FuwMjfRTm+tukmNqUyj049lVhHJOYS5FvJPm
         Ba+/rsCYDcuwLhuj17TGu8ykFlGQ2SlrMQxLvGehUHMm1Bhz+QFS6eNMcQUaHjPPTHPv
         6xew==
X-Gm-Message-State: AFq9FYII9C+4RP/BzmZqKxq7hO1gCN+5k8CtgyQMKKuMxPrsSyrilwPe
	5YkbQmkj8lnnpQTAKMjsSUAA6wmyGZxyImGygj9ARldFQ5IaxhZQUd4InOWbwlwcAl2CkjuqUr+
	Bkr2RkfPqYNuzhVLgt22z7RwVp14mlZCQoSX+nCtAlTxnkfJE3F41OikKkDqxfhQ+b8Y=
X-Gm-Gg: AYBFou0m4u7mZweqKvNCOsyfS/xbnOAnxSSKfy7j6udZ+we58Ogy+ZPmeWK5Vb7EILH
	thAaOGHAL5l5L1/DdwnaWyXC6OsHUiar++4EaHNpM+VVYbccm0urankj54vAsN1ZYpd8czLR67H
	qWHwaXWeHKIlmnzOFP8R/ucfJsJuUAQm4l6l1mH0Brjkf7w+lmKWzRIWhlRRlGsPSwb9zTO7Bl7
	0iNKYtXBTfKC+VznhZPjHCSulFmkUnUcsnOQTL1LKVskGyasdbsVs07/e8sk0i/wpJ7G19NqGKi
	GrumcMTk96VzTgi+i2MxY6h6DVMgscOUUD7GIyN956oSNfmxpuRtEQEIaxySrdcfQx7RJu3k49V
	1RtrjpnszJRpJjS+bW096bDhHFa3VdVoIcGYY6srsO29IEqwkeuNN5dYpi4XRQg==
X-Received: by 2002:a05:7300:da15:b0:359:6382:5e52 with SMTP id 5a478bee46e88-359638267cfmr13096816eec.17.1791919680990;
        Tue, 13 Oct 2026 12:28:00 -0700 (PDT)
X-Received: by 2002:a05:7300:da15:b0:359:6382:5e52 with SMTP id 5a478bee46e88-359638267cfmr13096776eec.17.1791919680365;
        Tue, 13 Oct 2026 12:28:00 -0700 (PDT)
Received: from hu-scheluve-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm60000008eec.9.2026.10.13.12.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:27:59 -0700 (PDT)
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
Subject: [PATCH net-next v3] net: stmmac: dwxgmac2: enable L2 split header support
Date: Tue, 13 Oct 2026 12:27:59 -0700
Message-Id: <20261013192759.776537-1-sagar.cheluvegowda@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6ace8642 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4efHNOip1X5BxVcu0mkA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: INo_WVcIGI-RwiGLgBmL6FPSQFLYwuFp
X-Proofpoint-ORIG-GUID: INo_WVcIGI-RwiGLgBmL6FPSQFLYwuFp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NyBTYWx0ZWRfX8UsTgZuCvIsE
 yi1jw6ZlHdyH6zeG1P5dEst7GowHacs1uZ0gvuEDi3/OQOi6j9O1JQZqTzjchAgk2m2n5jbajhG
 xeu55QO1vwkczrkTiffBZCFgioGUR8NwbCKXSvYO89bVNccxySHcZr/zt6O/lGQCrDCZFIdipPM
 9v6egCcIsolTNcI6I6Za9zBd7tvpQycXc5URRb+TTV+vFIerxv5/2+SUymejT2im9yRDfnHiWgc
 XpHv7uy5kRZJlDgs6VSjr+5ccsuk0Uwp2dxaq3JgVZvKJkiu2vkEP3NSRsCeBnICV+GFqAu1kLt
 X3P/DiA+qAxeh7l2z68XSXIKRKm8bN1KbFZuBKLiSlwCzotw2BvYkRukQIyuqMlJwAe7n3rUsey
 cHwErRIbDrDwypbOM8TdBNRI7ohd6rfjjYFeG5HN6ZIvUv+LhzF4kzet1XOvFwBtt5ALbqTq1Fs
 qMvF9eiAsb556Tc/meA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NyBTYWx0ZWRfX3ISl6gz5Lonn
 soWgik+fxACJqyh2t1fOK3d+EfYjIGmEIDc2RFVDZYZe36HWJ1yQc/2MRY0Vk+ajL3+gwsL3IB/
 3tqtmF53XK7M0zvRgkvwXU3VakOZSl8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130077

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
v3:
  - Use zero-padded 0x00000140 for XGMAC_EXT_CFG0
v2: https://lore.kernel.org/netdev/20261007183905.2582759-1-sagar.cheluvegowda@oss.qualcomm.com/
  - Add XGMAC_CONFIG1_SPLM_MASK and use it in XGMAC_CONFIG1_SPLM()
v1: https://lore.kernel.org/netdev/20260922232116.889630-1-sagar.cheluvegowda@oss.qualcomm.com/

 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h       |  8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 12 +++++++++++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c   | 10 ++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index f8ab347f7b5b..7d1a7802a131 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -167,6 +167,12 @@
 #define XGMAC_HW_FEATURE4		0x0000012c
 #define XGMAC_HWFEAT_EASP		BIT(4)
 #define XGMAC_HWFEAT_PCSEL		GENMASK(1, 0)
+#define XGMAC_EXT_CFG0			0x00000140
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

