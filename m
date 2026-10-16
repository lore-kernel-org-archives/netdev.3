Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866F36403B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179516; cv=none; b=o8aJt53ORMSDHplQQ5jRnHeEYi07PsZwT864krtKX3bj7yQtQbEH1BfsaabrXnjoVIEiMc7oFVejbBZdmuo+lF52DyXbRUXF7P2gxuyAPXwnit0LIAEbMpaRvnOmb2C1rfuQ2WaJFJdb7jjUFhwGpE6swu3WruzBPevDm52nWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179516; c=relaxed/simple;
	bh=369BcXlwouHKov14aSY209TKJH58jvqib+z/yvVhBgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tJqP1ZJmkibBDt4AisVfvsKAiOnkcHjpXCo/ja2Iur29hajKyBseSSBYzZK/HEn5zza4f2Q9d3BPchL2jMgexHeIulh6oUWlqd1Ki6/cs/fxfqD/xTCQIPlcEwHduAMt9M6bgVAYTje7FYoPRqIBmMLO7dxpWoMxj6vSZHjk8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d2BVoisP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R7BrVbjT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d2BVoisP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R7BrVbjT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GG3Zws3260332
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 19:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=saxkIlCiRm98oCdv5a136rITpS+jtk+TC4p
	NKPpq7zU=; b=d2BVoisPlOZmnH6iLwLwxW7VAC7W3ceH0VXWd4e69HaMaMRqp2I
	mx5V5RNM0BPiaesoWwMd8/Uew4tqIe1UNKiVVu7VNLjNPw8PPHWtENow6ei7hSXU
	VFOaZoJMQl0DfRsndwgZKr/Gp1mdU1vPPZws/taJ434nK/N683EPHIJGQ8ejQnj5
	xigJNhQVaTDzTj3io9yLMvU8azSrDwba+occTC5CuvdiAsq4+EA4VCiKclLu2e65
	U3tpFn1SKwHbfOcjnkdHmQ1aLn0lleOcimoN6CgUXaZIXx1kcseRwoJtPD61206C
	e+SNhZUhBZ9az3hdB9QyCsrfkxbyyPmsgJQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq450sjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 19:38:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso322192eec.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792179507; x=1792784307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=saxkIlCiRm98oCdv5a136rITpS+jtk+TC4pNKPpq7zU=;
        b=R7BrVbjTpNRJZFe5dFtVahY92NkoP1RM5Gqx8aglDw9mQXSAYXGkuwmf7aPFgnQD1C
         WigmSWOBU5IJr1+2949BqUx3Ab8vIR8XfG3AaayAWnxAhGBP9ErR60z6OSn01v4zKUkC
         yV0DfFo6wQ2AovBf8oBZlG81eDZZr0zTVygReaAaNNCqfBcLokbHIo+833BwNj1YHhcp
         PvlINt+R3GuJAN+Lw343RIJOnTrZ69xmKh0KwUVFCKo8AfTduMw+wflafYn61R//v6/D
         iQMNYf/+asJ71x3VH225rrE24Ln+0yYvYB4UxQ1RW1qtVmL1qFl3BvncrVfvySPG9GYd
         g9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179507; x=1792784307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=saxkIlCiRm98oCdv5a136rITpS+jtk+TC4pNKPpq7zU=;
        b=d9B25YvY5b4Bewr6tGQ40BtsbdCfJHPvH0Vsz18yS/Pp9LFW5aIy6EXfVJ54rXk03a
         Q3K+GvvcS++37AOatAYeYVTGmmKpEfNWwd7hhULEDpEgA0rtrot964g4OfyTdxSKzKHJ
         /VQmChEqFjlIvuCNkdoWpf33e1nz3hbpuS9Il9HljKIzgpo9598YqkFiMsSG03Ys2XFV
         DqnqufhHO1V5felxBpKZmmZIdfWlnfDl3LszmWxWBU8ByFKfWYCeCmSEsNLiEWHni8A2
         r3Zcq58tHhn1CcicRDRnihVP0G4oxZbEIqhwbsY/sKBLIVSx0fmGvapDRht9DywlTkSy
         1vnQ==
X-Gm-Message-State: AFq9FYLfABk7EL3Xb/3P0WscywhwYGwVotQ+aNbymy00uYd/4g0Ii/9u
	V3QQTIPgfyzlNJZ4VeG0QcjsNCC7b4NxQLRBaelJ7ALcie0vQ/tsKRcoZRYLEl26Px9eKAitPIF
	ge13xKFJ4UfdVvfy0E4GG706PNZiQC1FSI/YHiuhVTaLS/wsi5Aizhjr1pgo=
X-Gm-Gg: AYBFou0PPTtVX8n9Onnv3ReW0jWN1ESGlrLpLCqV6PztHWTl2j4oLFKOlZefJ+wTiQy
	VuDrtBJwdNSLJStiISinf0WDBV06lGTFSRv1tGiL49UIDIBEqoIHRg3MpdCm5rio/PGMF/TLwa6
	ozXt7J2k2q2FvIL/wRmNNCUKmaKWEc7+UZee0bk57Isx72mHoKQ3ecTA5V1od7h0Tw4MnE6A599
	qUlKPaLSskuGWFN9TMHPaaPfucDFBHbPJzwowyGT1J5XVzvLIpkGTCn8CUSypspoxmnxiP1oTtc
	Nqy/S/ZzFRkMY1ir9D9LYZkVtKi4g9cAXwRJTJ4l/4/UxBHl2sv8jlVgiXc1F8SK9KUZfgfi0Fc
	3Ik7LiFiIUus/UD0zjFUdjF9XAQlDPK+Pqi/fbVHfh1YXAnZJlyC8dQNv2YDNWHE=
X-Received: by 2002:a05:693c:6311:b0:35c:9631:f389 with SMTP id 5a478bee46e88-361a136acadmr995294eec.17.1792179507168;
        Fri, 16 Oct 2026 12:38:27 -0700 (PDT)
X-Received: by 2002:a05:693c:6311:b0:35c:9631:f389 with SMTP id 5a478bee46e88-361a136acadmr995136eec.17.1792179504724;
        Fri, 16 Oct 2026 12:38:24 -0700 (PDT)
Received: from hu-scheluve-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm8960205eec.4.2026.10.16.12.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:38:24 -0700 (PDT)
From: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
To: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, j.raczynski@samsung.com,
        k.domagalski@samsung.com, k.tegowski@samsung.com,
        cs0617.lee@samsung.com, abhishek.chauhan@oss.qualcomm.com,
        lorenzo.bianconi@oss.qualcomm.com, sarosh.hasan@oss.qualcomm.com,
        hongmei.xu@oss.qualcomm.com,
        Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Subject: [PATCH net-next] net/stmmac/dwxgmac: Extend MTL/DMA support to 16 queues
Date: Fri, 16 Oct 2026 12:38:23 -0700
Message-Id: <20261016193823.2711773-1-sagar.cheluvegowda@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9trHsMASQ4BXj7FT_7IVazpVqdOZBLqk
X-Proofpoint-GUID: 9trHsMASQ4BXj7FT_7IVazpVqdOZBLqk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3OCBTYWx0ZWRfX/TQPEng1z/af
 0+atC+SwsOBFf+m7xiLzJa7dn7PQ4CHAQKbPPTwuFmWb91hYsgqdoOip6wUvZjmWV0+3DUwl2eZ
 Xjwn9Z9o/frKswrROcqA717C3wLWkcmGIzBXjjQa5pmeDHis/mMHnZ266fnJHGoU3Kfx4D2MQpN
 8us3lskltV/Zc0ERBdJnkH/XU0xajgI7A2n0PbE2KlhfdadYjaNxoeDj7IfVWeFc9i3CSOA6Om3
 uyd04+VtS5REmriR6lOjvcKlEavA+d0x9GCD83qUIzt12hX2ZULl3i7CfsLvFFpGaehF6Y/cz3o
 TOvJqqATwF5mNhoqw/3EIZE3s36utwXuBB5kBwlv2MBDw2cvzine3IiEbltx6bw8YaPUk97UcHE
 tbaqLki6Yyr9k12b/kUDMtYU5dD8C6BSKNIkRbqtl0/R45LO8QWCzBQDSWTbp1OknbBCKSTZhSK
 aneg+h0ri2S6Fr6njFg==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad27d34 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=x3-vh77kN9uJXWvyjNsA:9
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3OCBTYWx0ZWRfX78hQNmQmzXam
 36bSWwHX71K3VwnUfLJXQNf++l8Ns7BURMm9KwqJQwE3NA0aalvNAURoAddpweZi3gz7VAT7jDd
 l1ZcvM/lr6Flj7kKfnspU9c1iSMn/HI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160078

From: Jakub Raczynski <j.raczynski@samsung.com>

New datasheets for XGMAC (3.20a and 3.40a, depending on product)
support up to 16 MTL/DMA queues. Before we increase max amount
through macro, prepare dwxgmac functions to handle that.

Queue numbers above 15 are not valid for this hardware. Callers are
expected to bound them, so reaching the default case is a programming
error rather than a runtime condition. Use WARN_ON() for it instead
of a netdev_err() message: the callback has no net_device of its own,
and a message-only failure in a void callback is easy to miss, while a
warning with a backtrace points straight at the offending caller.

Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
Co-developed-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Signed-off-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
---
Patch 2/3 of Jakub's v2 series:
https://lore.kernel.org/netdev/20260601162537.553512-3-j.raczynski@samsung.com/

Jakub has confirmed he will not be continuing this series, so we are
posting this patch on its own. We need it for Qualcomm Nord, a
25GMAC-based SoC that implements 12 MTL/DMA queues. Jakub's authorship
and sign-offs are kept.

Changes vs v2 2/3:
- Replace the netdev_err() + return in the default case with
  WARN_ON() + return, following the review feedback on 1/3 against
  message-only failures in void callbacks.

Tested on Qualcomm Nord with 12 queues: the MAP0..MAP2 registers were
checked to hold the expected RX queue to DMA channel mapping. The MAP3
register (queues 12-15) is carried over unchanged from v2 and is not
exercised on that hardware.

This is needed for XGMAC-based hardware with more than 8 MTL/DMA
queues (Qualcomm Nord has 12).

 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 21 +++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index f8ab347f7b5b..6d4affbd34a1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -257,6 +257,8 @@
 #define XGMAC_MTL_INT_STATUS		0x00001020
 #define XGMAC_MTL_RXQ_DMA_MAP0		0x00001030
 #define XGMAC_MTL_RXQ_DMA_MAP1		0x00001034
+#define XGMAC_MTL_RXQ_DMA_MAP2		0x00001038
+#define XGMAC_MTL_RXQ_DMA_MAP3		0x0000103c
 #define XGMAC_QxMDMACH(x)		GENMASK((x) * 8 + 7, (x) * 8)
 #define XGMAC_QxMDMACH_SHIFT(x)		((x) * 8)
 #define XGMAC_QDDMACH			BIT(7)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1a88cbaed70c..563d29d72543 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -257,9 +257,26 @@ static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value, reg;
 
-	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
-	if (queue >= 4)
+	switch (queue) {
+	case 0 ... 3:
+		reg = XGMAC_MTL_RXQ_DMA_MAP0;
+		break;
+	case 4 ... 7:
+		reg = XGMAC_MTL_RXQ_DMA_MAP1;
 		queue -= 4;
+		break;
+	case 8 ... 11:
+		reg = XGMAC_MTL_RXQ_DMA_MAP2;
+		queue -= 8;
+		break;
+	case 12 ... 15:
+		reg = XGMAC_MTL_RXQ_DMA_MAP3;
+		queue -= 12;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
 
 	value = readl(ioaddr + reg);
 	value &= ~XGMAC_QxMDMACH(queue);
-- 
2.34.1

