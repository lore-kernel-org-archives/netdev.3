Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852B42047D
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119283; cv=none; b=a71h5Nkf/LhmVPOzddo1Z4qs6F1BpZspI3rg0KnsjyRR3ISoLnuMKvuhxATLn6Dsb6RmnvnWRL0tlmabkXM7PDuZ9VKD8EoSmpXnrr3S+Cjymq8/fa3wCkBNS347iROi4cLQh3UsQ8pXzL+Kxm6HkS7k7m00VH4euuVFkc4dF1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119283; c=relaxed/simple;
	bh=vzN5qPK0jh9oC1yOXE6jWapsnLnsrVL6dc8xtHXtOfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iMyfioUNMV+EyLqAP+rucfXEDptmrcO7biY/H2vSIHYknP1ky83eWbKnEuKVu+CeF+AnN+uvJTmlNEZCDhVPQ7+0eKTRlDidBBF8ku+wP+uwmQcqEo+81dtWbOjqpiyKbXEj49gyYjmEHjie34bPwQCjGAToY2PQQKXHWZI8VS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IJvRXpf1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fn17T6Ru; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJvRXpf1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fn17T6Ru"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MN8WtX1403441
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 23:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VtcrGr7QFfAuzbwfIUY9IDBuJPZMtK5x9cA
	Yxd1I2pI=; b=IJvRXpf1WNoAkaZX5n1A6aY0t73YP9dAGq/Mhf99BKMATayiJrJ
	zzeXNMDEHxKDXCFVJxj71TujtMcbtVXYNyqBbYYsPYPixcE0yXWV57dBopo+YsPL
	wBUM1fBmoC5+M+To7bgbELKW9mSSym23RdaPs5a5/xNXkiljRr0zTXLCFoWL0Ftv
	zAn/8hXFtYSVuK1xQ1vySdDnTbuMWg7WQz1tpXhE9yCVlzFpIdgkk8mXL0OIDSSC
	EyQ4g/CqrOZRWyBXmXVyWpdHOBd1++23eCXYvnztlOdszlS7/wWAtJQZmJs2HWgJ
	bURuPFnjuUQVDT5aUBGifDJoURp0tM43qhg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv331817y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 23:21:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3284bbaa89dso1173008eec.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790119279; x=1790724079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VtcrGr7QFfAuzbwfIUY9IDBuJPZMtK5x9cAYxd1I2pI=;
        b=Fn17T6RuS2FV2C8+QH40ZIIy8BAhBUOOtYVeC/K4X7nOg7Xmq5Hl+XPp2O/oe0Xlo/
         m4EpfjZjdszK0UEotZoWEWzaW/x7X+vYnLbt4oL8pltAGwOLBuodBpvu4Q07wCFOdTZ/
         MRcc4DZ7120K+Czv3w0kyjZSi+gk0UqXizSj15PgC7lR0RVKuSUqZsOHQQjp388fa2KQ
         6vV5ozkLHCe+qYrjrvVrTOPh4yXX11EFjM74hrc1NzB9rv/G9E/NDAFbBQ71lLrdFwsi
         vugIYxR20uDjOGAWX1E1mELeCTklOfEJ7h7ExJS5IMjanDj92VhFoZskUflzS/wFTf0h
         Xe3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790119279; x=1790724079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VtcrGr7QFfAuzbwfIUY9IDBuJPZMtK5x9cAYxd1I2pI=;
        b=yBnaGy1+3YRWrQn6ajxJMUuU//EIDmkUwhW1B1yplavAIhN7LTgjUO1OLu/bLIhJRc
         nGzMaLR3MhD74weQ+RdxNM1GDu062a2jqF7tgVUbUHsv7JqfS77GF/ZTAcR7gcFwgaiX
         U6hhhn/10YUPwv0iZwgySKwLqBKcj7kplo8uL5hgnpAW0rPjE2svJWqj/KmPAdt8YfCV
         Z10ganQVal8X81CXYHw4zGmEPkaVXqnN6QFT4hcP/4hl0JnvBR7rpP0xDV4JIAcJunJd
         EML26XOfPSWtWqUg5jIhCMelfSAueCbxzJKvmaNb+I9Zif9kJWYDT8QjZ01hcCRSa7nb
         1wiw==
X-Gm-Message-State: AFuF++nw5Zc13fpzv/IfUkTJKvELN1bpSm1khBCJUSe8pbuiJViYtXwv
	5yzJkCvLyFqZYA76u7oo1yZZV5xrXqr3y9x47aBAZ9M8Cy/ZYYz6dfKfDXKfViVHCgBx5x70OI9
	gndeAWrY3hnrZ8TiKAvl62A5XBy8kZfR6EosIOMl4XqUm4Sl5iVwQo1KMLuQ=
X-Gm-Gg: AYBFou2Aw3xo7CV6rvIdsv2LbqpifrgRQG6iAEA3ui9nUSDJ4V7x6yq7YisdvS5R6+Y
	mKS1jl5t/+dCGEPL34kffgG6tHC0/oRnC7emXgPRY3smdAetYedpYEl8mTVbt1HhjYZiaRE/GSw
	loIXlwmi0dKyougZlVgbBL2q7UWCCMNRqfGrbdW+KMNrN4y0aSZvRL8GQZXR5mFqcj5IaSEanc4
	xh5DOiBOVvq+KKLkF24mdvFpW1uVmzeoEQ50WrYlaHXRSkQWEKacgu26S4HuVISagcIRKfXn3k4
	ot6RcpQpCUtRlvRu+7Xp5lTTpK+11WXWSBDRg/tD3WbwGgdFgg5GZVuNnadtR/6xy6PvjAvY+Il
	dIJ8J+M+dOwROwqm1M66K1jCVUHTutzCCnF2pNdMsvrtduYzUvpEBcH2jsu8eDw==
X-Received: by 2002:a05:7300:4715:b0:33b:bfb7:31cc with SMTP id 5a478bee46e88-33e8c53b8a7mr892282eec.16.1790119278477;
        Tue, 22 Sep 2026 16:21:18 -0700 (PDT)
X-Received: by 2002:a05:7300:4715:b0:33b:bfb7:31cc with SMTP id 5a478bee46e88-33e8c53b8a7mr892254eec.16.1790119277903;
        Tue, 22 Sep 2026 16:21:17 -0700 (PDT)
Received: from hu-scheluve-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7c63bsm1289746eec.10.2026.09.22.16.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:21:17 -0700 (PDT)
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
Subject: [PATCH] net: stmmac: dwxgmac2: enable L2 split header support
Date: Tue, 22 Sep 2026 16:21:16 -0700
Message-Id: <20260922232116.889630-1-sagar.cheluvegowda@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y5EA3K0bpScVsg67Vfc6Rx5zt4XMWM72
X-Authority-Analysis: v=2.4 cv=HdaB3SE8 c=1 sm=1 tr=0 ts=6ab30d70 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=oyhHvXrwYuR4Cusx70sA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: Y5EA3K0bpScVsg67Vfc6Rx5zt4XMWM72
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwNiBTYWx0ZWRfX3xiUztQHqRU/
 oV70sNrAc52umvE3BmkCx1GfZ9NOjsayWuX+8jubAcyMPKcBBSh34jhp921nR1lJPzs1Q7Tds9v
 J6ZsJZTA72sCvGRBi7wd3a+tsbPj/9a0ApDRdpQz+LLwAcWbMuMQ+5CbuOLqkIbGVBQzSBvvbWX
 lkMEgVcpikBdNFGGAyrZrQw9ydlsWiPG6bxZzQ0DXVqF2ZhtlnFMVMPgEUOMct0Gd0JhXkTcKii
 jwFFINHnGwYV8jrTIOvAM48O3p14jCrd3nROA7B/e5fd2W2ahUgt/VPypmGutalk0HK3vEEN1O6
 QNyUpu2BNjV0pOXAY5d/C0wd9DATqYI7WRvTH/2thHwLbi/MyfFeppdTj57QCDtYo3XA/RK1MXl
 c2N+9kSJ90V2PcXefMcttZzPpJCaPz2eRoGPoQbOAeCNGe8XmS0Tna0tAj8BUNS8F3TO5ZhQr0c
 WZdSwa0ykg8g9heMT5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwNiBTYWx0ZWRfX2l26l7EIZaC2
 0Th3SHvzYlif3x09IxqCW37pWpojep7wO5YoUpYCftWT2gCmmwiVP6svgD7uCApDbrwcs9WZLdA
 NG9d6q/A4UNjgOqS17FmyjRdDITvGF4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220306

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
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h       |  7 +++++++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 12 +++++++++++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c   | 10 ++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index f8ab347f7b5b..3ccd29ea7ab0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -167,6 +167,11 @@
 #define XGMAC_HW_FEATURE4		0x0000012c
 #define XGMAC_HWFEAT_EASP		BIT(4)
 #define XGMAC_HWFEAT_PCSEL		GENMASK(1, 0)
+#define XGMAC_EXT_CFG0			0x140
+#define XGMAC_EXT_CFG0_VPRE		BIT(8)
+#define XGMAC_EXT_CFG1			0x00000144
+#define XGMAC_CONFIG1_SAVE_EN		BIT(24)
+#define XGMAC_CONFIG1_SPLM(v)		FIELD_PREP(GENMASK(9, 8), v)
 #define XGMAC_MAC_DPP_FSM_INT_STATUS	0x00000150
 #define XGMAC_MAC_FSM_CONTROL		0x00000158
 #define XGMAC_PRTYEN			BIT(1)
@@ -434,6 +439,7 @@
 #define XGMAC_RDES2_L4FM		BIT(28)
 #define XGMAC_RDES2_L3FM		BIT(27)
 #define XGMAC_RDES2_HL			GENMASK(9, 0)
+#define XGMAC_RDES2_NONIPHL		GENMASK(9, 2)
 #define XGMAC_RDES3_OWN			BIT(31)
 #define XGMAC_RDES3_CTXT		BIT(30)
 #define XGMAC_RDES3_IOC			BIT(30)
@@ -441,6 +447,7 @@
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

