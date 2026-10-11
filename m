Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA5469841
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723802; cv=none; b=Za5zXgHzvAjj1BqWsbhY6jnudCNW+ZViU6TGt9+NiG6ziC8gtiT3lmRSmjWeJ2FNTabF27Zj00wNeLth9vOhDptHzXFXIw8Z9xIZ3ENwprJ6hvGM2R1OEJtm8Sm3gtiG4qhKIVc8+0Trckf1wYyZUq0zXwH8XAFG9vCIK6v0/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723802; c=relaxed/simple;
	bh=f7UgC/h70IbjkbEhISDmBS8SrsPHSkVGFtcsHrdgTXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QyQp1lWhSx+Ci0NfP2kj4FgKBINfag8KSjMHB9f9A+nqNNcfufi3fG/gUqV819G7Dp+qVrI3PuE9qw84sGOxj9UEHXvjKxoVsklyfZlfKQCg7N7EXIWz66Y89S4POUf5KYUR1HawFs5w9M55B4Vp9w7ugEvqWjeNlOrGl5TFiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BppKAuIm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XO5+FDK+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BppKAuIm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XO5+FDK+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69B854k32971456
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NBuopFriM8namgE/M0OvieZauXK0tnH9bKnJIJbjJYA=; b=BppKAuImAKW0l/4I
	41g6D4VGw5nGytGv4pSeQaM0uUdnz3aODpPXny5djloCNkcJXL99ugP7CPX8HBrE
	+g8eWhDNmbjqW6kUCfbuBhjxJn35n8hRF0yOrJWCBFCwXfVpdKQ734cTy2SjgRNe
	lQlPGIN0o7y7hsKpHNmEapUq67QqtYC3Fq73jg1/XvWb3T1H2+rMNfs09ERthvjb
	IsOlSkEXdpSc3s3VvdWkyL1AG1CNREiaDv0SK3rJid4+U1l1kbqNAg6IQPt8W0wR
	7Q7PBfzphH8uQm0HLEqPlS6xQ9pCm/+qsglhjiV17QcUmMxeD6wvddxyzuNEmvgM
	WIf13A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk231ew-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35a04491c56so293857eec.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791723799; x=1792328599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBuopFriM8namgE/M0OvieZauXK0tnH9bKnJIJbjJYA=;
        b=XO5+FDK+T/ZXrwK1n1VaLaOWssPDYbEyh9vK+fjO7nEHLBSdROLCyiHn/G6rda00VT
         Im4vo2CU8wn1EjUC8MLA3N5Kendm0/Bf/VhOnxVVZRntN/OvQxtSJAGJQq02slOKA510
         KuvllTCHISNuhxOYiLE+o1nyU5VKoKUcD+eg0hhQpdftH1mghPIFdFW+5ZIFm2MYyfFq
         coAMApsq/VfZ3wj+MN8y1BXnl2TNx5Vs4FLQcZ7ZVQ+xti5YEbDH1iaT3N2UFwY3WzSR
         C2eVJAR6P79EyP3fDFdaEH9XnH+ECIe2wYIUq6intOznVEuDkQsUhAuH7/OoXBQzdcg7
         I1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791723799; x=1792328599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NBuopFriM8namgE/M0OvieZauXK0tnH9bKnJIJbjJYA=;
        b=ErKqmmYHw9j9PVu8bwAHT8O5J97ZMuiRkilPIkqBvwLwmLXyy/KepOKgDFeYZdIucn
         j42jrEveaEiMwCHNOHHUYTOPt2yVyYl7kIUnxylMRkQ0KDtIq5UEySnErM43q3R1VXTB
         ynY8DsMAOtqeGgR/8G/1xqiX6W5H+O1ooSIMfOxC3fIMs5VNGhAwlteI02hm3XOyQYnq
         zjQyRQhAiSBLuvtykmZXxHYT315S2ORhLl8RmyjXLna8I8rfSPcH4Hf7wuIFal352aY9
         sDtI6xshEsul2W9ka9Ew9qKtmUUw7e/SV528QmlJln9qZUUDXgYgAwq9+BdSpV61NBA+
         UV6A==
X-Gm-Message-State: AFq9FYIpTV5eqPZYbWCOY0/CWVkrm067r44DDugpN1Ae79fMRFhqoNqR
	PWYbDt+rbZbb+Dj2IhHRKaannJN6ZHL7JTGMCxR3+t44RbCMv0C5fONiQsKTl+UsB8/jDabKsTL
	zu4C39Mti0YCynhdlLGY8r7ZBBCVnNvpDdlAQxxvmt3MdRAWsH+c6GTs/e3c=
X-Gm-Gg: AYBFou1C5lq+XpowxCjlGVKp2KUPoxAz2ni/2jYiB2nOIdB5hPGhj3l9Vc32FVOaN6o
	j86u6+AQubYeznQNWwRWZb0I9DAD9b4xUi+bmw7qU8TBcAgCrVN0uQ+HYnqyx/J5LSU8+6p8Hzh
	NFFL0fU3RP0NlzE/oYBhPDFJR7b0zPCky5CmucR8UX2BsYGxujqVkCCogFskRX/jQjc9btUvif5
	U1IKTdEFlHrEQE49ksa5bB/6IFt/Dsav3RiVLDuhzufLTWm/p2Uwoguz6rMLRggigOVCCswhjiJ
	/6sDM9pIpZ6KiilLx2NKQNzIWE0fUd9m3R7CEOAyjSlqAUltte2xfsOIdHxJe6OKISKRs0BvhD1
	hJ90lbyQioiuUWdSW2C+3uA7Js9eZ5vW/4aqVt/OrYaw=
X-Received: by 2002:a05:7300:fb8a:b0:353:82a3:eb86 with SMTP id 5a478bee46e88-35382a3ef76mr13179288eec.0.1791723798553;
        Sun, 11 Oct 2026 06:03:18 -0700 (PDT)
X-Received: by 2002:a05:7300:fb8a:b0:353:82a3:eb86 with SMTP id 5a478bee46e88-35382a3ef76mr13179235eec.0.1791723797975;
        Sun, 11 Oct 2026 06:03:17 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm27009074eec.3.2026.10.11.06.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:03:16 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 06:02:17 -0700
Subject: [PATCH net-next v2 11/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 counter debugfs support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-qcom_ipq5424_ppe-v2-11-8c7b057e2c43@oss.qualcomm.com>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, Luo Jie <jie.luo@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723782; l=6180;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=f7UgC/h70IbjkbEhISDmBS8SrsPHSkVGFtcsHrdgTXk=;
 b=7FakvAT4U5+pTdx78jjxa39dmG9CMkX4uPYNTFnyhqLgsuhpGrqVPn8ZWERs4FggVOIw1UZMq
 icT7JHmCwFlD6tjraltC2qZ3dJU5Qmpfu+owY6qPO4txKpt6W/LnzNC
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-ORIG-GUID: E-06TEEqmJ-sjF6DNhb2CmvRUZqKQK5b
X-Proofpoint-GUID: E-06TEEqmJ-sjF6DNhb2CmvRUZqKQK5b
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6acb8917 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=76TLMYU0KGnaRKKVPX4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX2r2tjx7AEFfd
 kxGfrLEqw+ojDJIO6w5emJeB0zSHbzWtvCHeZ2F7mVGC3QImWs5R4J6lapM+2NqFrZxJcP9LIvt
 chmT63d1v1lA2i/3lvH23xMN5d70RPQt7NDVsm0YXvqO3IOMdVrCd/zHf+ORqvCU3x3v+2stPYS
 RsQvFps0Un/Sy2DOPPhfA0a6sdzfmiiwGu9U9zqs6aQ34G8AIps2cir7aEuMgCHsLfOW1+M4B8q
 8h/VYLQw04sl6D4XPw60RxioZ4fkmGYoS6ovLH+bjK+NmPcxGJfMBzSzGVCcKyAuhvv0aBjLz5o
 PEVds6sBv7awYDW5a+43vn1E8MyQrowoOFVg4J9vQ26pUrKrc7bcnhhc1FY/SSKZc1KWJ4iR29R
 m3uu6EocN2RLIK1OXVLHwSU1Hk6nQ6EZFyRTRLpNcLOcxh5kiyX8O07LQphHu+mUDsjwnHqgDUw
 wWy60TulXCYGe2KlD5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfXykhdObRye5rj
 e/T1CnY104lEcV0aOtseew/vpQyUed4fAPq7GeadhjGlequ/W8HvGeMKcyJ9FtpWZRl5RcLgYLp
 kdrC/4YFs0GoU1bD6sMECjODs4AA4jE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110051

IPQ5424 has more BM ports than IPQ9574, so the BM used, reacted and
overflow-drop counter tables have more entries on IPQ5424, and the used
and reacted counter tables are located at different addresses. The BM
silent-drop counter table on the other hand has only 4 entries on IPQ5424,
versus 8 on IPQ9574.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c | 14 +++++-----
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h    | 36 ++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
index fd959a76ff43..8d5a6fad8337 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
@@ -201,7 +201,7 @@ static int ppe_bm_counter_get(struct ppe_device *ppe_dev, struct seq_file *seq)
 
 	seq_printf(seq, "%-24s", "BM SILENT_DROP:");
 	tag = 0;
-	for (i = 0; i < PPE_DROP_CNT_TBL_ENTRIES; i++) {
+	for (i = 0; i < PPE_DROP_CNT_TBL_ENTRIES(ppe_dev); i++) {
 		reg = PPE_DROP_CNT_TBL_ADDR + i * PPE_DROP_CNT_TBL_INC;
 		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_1WORD,
 				      &pkt_cnt, NULL);
@@ -225,7 +225,7 @@ static int ppe_bm_counter_get(struct ppe_device *ppe_dev, struct seq_file *seq)
 	 */
 	seq_printf(seq, "%-24s", "BM OVERFLOW_DROP:");
 	tag = 0;
-	for (i = 0; i < PPE_DROP_STAT_TBL_ENTRIES; i++) {
+	for (i = 0; i < PPE_DROP_STAT_TBL_ENTRIES(ppe_dev); i++) {
 		reg = PPE_DROP_STAT_TBL_ADDR + PPE_DROP_STAT_TBL_INC * i;
 
 		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
@@ -248,8 +248,8 @@ static int ppe_bm_counter_get(struct ppe_device *ppe_dev, struct seq_file *seq)
 	/* The number of currently occupied buffers, that can't be flushed. */
 	seq_printf(seq, "%-24s", "BM USED/REACT:");
 	tag = 0;
-	for (i = 0; i < PPE_BM_USED_CNT_TBL_ENTRIES; i++) {
-		reg = PPE_BM_USED_CNT_TBL_ADDR + i * PPE_BM_USED_CNT_TBL_INC;
+	for (i = 0; i < PPE_BM_USED_CNT_TBL_ENTRIES(ppe_dev); i++) {
+		reg = PPE_BM_USED_CNT_TBL_ADDR(ppe_dev) + i * PPE_BM_USED_CNT_TBL_INC;
 		ret = regmap_read(ppe_dev->regmap, reg, &val);
 		if (ret) {
 			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
@@ -261,7 +261,7 @@ static int ppe_bm_counter_get(struct ppe_device *ppe_dev, struct seq_file *seq)
 		 */
 		pkt_cnt = FIELD_GET(PPE_BM_USED_CNT_VAL, val);
 
-		reg = PPE_BM_REACT_CNT_TBL_ADDR + i * PPE_BM_REACT_CNT_TBL_INC;
+		reg = PPE_BM_REACT_CNT_TBL_ADDR(ppe_dev) + i * PPE_BM_REACT_CNT_TBL_INC;
 		ret = regmap_read(ppe_dev->regmap, reg, &val);
 		if (ret) {
 			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
@@ -723,12 +723,12 @@ static ssize_t ppe_packet_counter_write(struct file *file,
 
 	switch (entry->counter_type) {
 	case PPE_CNT_BM:
-		for (i = 0; i < PPE_DROP_CNT_TBL_ENTRIES; i++) {
+		for (i = 0; i < PPE_DROP_CNT_TBL_ENTRIES(ppe_dev); i++) {
 			reg = PPE_DROP_CNT_TBL_ADDR + i * PPE_DROP_CNT_TBL_INC;
 			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_1WORD);
 		}
 
-		for (i = 0; i < PPE_DROP_STAT_TBL_ENTRIES; i++) {
+		for (i = 0; i < PPE_DROP_STAT_TBL_ENTRIES(ppe_dev); i++) {
 			reg = PPE_DROP_STAT_TBL_ADDR + PPE_DROP_STAT_TBL_INC * i;
 			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD);
 		}
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 089aa34b7732..d08ab02bdf79 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -18,12 +18,20 @@
 
 /* PPE drop counters. */
 #define PPE_DROP_CNT_TBL_ADDR			0xb024
-#define PPE_DROP_CNT_TBL_ENTRIES		8
+#define PPE_DROP_CNT_TBL_IPQ9574_ENTRIES	8
+#define PPE_DROP_CNT_TBL_IPQ5424_ENTRIES	4
+#define PPE_DROP_CNT_TBL_ENTRIES(ppe_dev)					\
+	((ppe_dev)->type == IPQ5424_PPE ? PPE_DROP_CNT_TBL_IPQ5424_ENTRIES :	\
+					  PPE_DROP_CNT_TBL_IPQ9574_ENTRIES)
 #define PPE_DROP_CNT_TBL_INC			4
 
 /* BM port drop counters. */
 #define PPE_DROP_STAT_TBL_ADDR			0xe000
-#define PPE_DROP_STAT_TBL_ENTRIES		30
+#define PPE_DROP_STAT_TBL_IPQ9574_ENTRIES	30
+#define PPE_DROP_STAT_TBL_IPQ5424_ENTRIES	38
+#define PPE_DROP_STAT_TBL_ENTRIES(ppe_dev)					\
+	((ppe_dev)->type == IPQ5424_PPE ? PPE_DROP_STAT_TBL_IPQ5424_ENTRIES :	\
+					  PPE_DROP_STAT_TBL_IPQ9574_ENTRIES)
 #define PPE_DROP_STAT_TBL_INC			0x10
 
 /* Egress VLAN counters. */
@@ -426,14 +434,30 @@
 #define PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID	GENMASK(1, 0)
 
 /* Counters for PPE buffers used for packets cached. */
-#define PPE_BM_USED_CNT_TBL_ADDR		0x6001c0
-#define PPE_BM_USED_CNT_TBL_ENTRIES		15
+#define PPE_BM_USED_CNT_TBL_IPQ9574_ADDR	0x6001c0
+#define PPE_BM_USED_CNT_TBL_IPQ5424_ADDR	0x600220
+#define PPE_BM_USED_CNT_TBL_ADDR(ppe_dev)					\
+	((ppe_dev)->type == IPQ5424_PPE ? PPE_BM_USED_CNT_TBL_IPQ5424_ADDR :	\
+					  PPE_BM_USED_CNT_TBL_IPQ9574_ADDR)
+#define PPE_BM_USED_CNT_TBL_IPQ9574_ENTRIES	15
+#define PPE_BM_USED_CNT_TBL_IPQ5424_ENTRIES	19
+#define PPE_BM_USED_CNT_TBL_ENTRIES(ppe_dev)					\
+	((ppe_dev)->type == IPQ5424_PPE ? PPE_BM_USED_CNT_TBL_IPQ5424_ENTRIES : \
+					  PPE_BM_USED_CNT_TBL_IPQ9574_ENTRIES)
 #define PPE_BM_USED_CNT_TBL_INC			0x4
 #define PPE_BM_USED_CNT_VAL			GENMASK(10, 0)
 
 /* Counters for PPE buffers used for packets received after pause frame sent. */
-#define PPE_BM_REACT_CNT_TBL_ADDR		0x600240
-#define PPE_BM_REACT_CNT_TBL_ENTRIES		15
+#define PPE_BM_REACT_CNT_TBL_IPQ9574_ADDR	0x600240
+#define PPE_BM_REACT_CNT_TBL_IPQ5424_ADDR	0x600280
+#define PPE_BM_REACT_CNT_TBL_ADDR(ppe_dev)					\
+	((ppe_dev)->type == IPQ5424_PPE ? PPE_BM_REACT_CNT_TBL_IPQ5424_ADDR :	\
+					  PPE_BM_REACT_CNT_TBL_IPQ9574_ADDR)
+#define PPE_BM_REACT_CNT_TBL_IPQ9574_ENTRIES	15
+#define PPE_BM_REACT_CNT_TBL_IPQ5424_ENTRIES	19
+#define PPE_BM_REACT_CNT_TBL_ENTRIES(ppe_dev)					\
+	((ppe_dev)->type == IPQ5424_PPE ? PPE_BM_REACT_CNT_TBL_IPQ5424_ENTRIES :	\
+					  PPE_BM_REACT_CNT_TBL_IPQ9574_ENTRIES)
 #define PPE_BM_REACT_CNT_TBL_INC		0x4
 #define PPE_BM_REACT_CNT_VAL			GENMASK(8, 0)
 

-- 
2.43.0

