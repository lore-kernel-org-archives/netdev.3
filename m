Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3B4562BC
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723794; cv=none; b=YEe9PpCxkUjqFtiGh67eGLYYxHbgm0ZWUrtIir+VXnOI3rmreGPGiq3Y8i3zSNmK/6ZniTQX2YONseT5jlmmWdrofi7ba7/TO/esqZMXEjMMuJ0qdNvCnAFa+ICh5UhDF5gzaIaOEo47AX0pNiswKuGNdJW0FB1WNZN9FirQwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723794; c=relaxed/simple;
	bh=mp6D0oOUv26EDKVfLKfYz3oxZLckyUzpTBMUv8dvbIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NvfZWvC5VAeODbjJc/WpAbAJzmPt9B+alBTkizRkeKKMfUjgAeGExBj6MbKf7eeFUIlvy24ZJdgDCJVYH1G++sOX/uwerLHlbLyFGnGdNlmo2SM12T0WLu5BvzQlMcVsszRteBhdKkdqt66DAKOBVDoIi8Ea0wYZNeexTI9Sfms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/oqtk0P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HTEkiHlO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/oqtk0P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HTEkiHlO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69BCgnRt342535
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CZaooxuxjYQ15OV3P2JEWTKRaG38C44w+UoENix4JvU=; b=L/oqtk0P2iut+5Gn
	P5HdIVYHW7W/tknTpzNoFnNXQlWxfB2G1GfVn2QxlHwfdgPTKlcf7rgkVXMpsmZm
	LvncMigu07NxVc+jp7BF4UswCZ1FkGWXTFh+bI2haY5unJPXg3jjz5Xxtzb/jnEO
	6GeaeGpnUZ1CxwV4UIKlaqRF+Ru1sx6IHZZH2EYvFTQH8VcmKSa/mFJzB5hKGEqW
	Oro/EOwWZbh5LN2jQq+NgEPtwlfKRw4XrrYQDNImu3iAF7TqQuJ6DGLqL9PQmqw6
	I9gVGM2h5bjfboO8UgJhH42SlwV8poeSFt0lou5nnHYvhlQpC38qUqqgj5w8QE2v
	CglDAw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7casb6c3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2225682eec.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791723790; x=1792328590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZaooxuxjYQ15OV3P2JEWTKRaG38C44w+UoENix4JvU=;
        b=HTEkiHlOYIPZJQHxu1sX2mQ6pAVWUq5JZD1BYaoxLM73RhAXPIb9cvVHMSQ9AWCpEA
         eGTk1qmUw6/lCB51oju9xPkRnTWmwITUFB5e8Kw07cKOU3Z76FbbhYQ4rHjXErHWj+7T
         U5vxUKzy5G4JRX5xlreFuQAgv8xiZ7DdpI+swIpiSlSjltonXPQOSG2K0+BWVyJ4bzNf
         R6IPcmopgob4DI7iWRMZKXDw/Qo1ncmrVYre2VrwnuDP8YgE0ofXt9koVc53UR0GA/nC
         rShNVdImcFKSpaL2HoIWByeCq3oUY+C3oK+CC/Vce+zqh7Ca++UcVXXKPHYV5j58Vyki
         U0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791723790; x=1792328590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZaooxuxjYQ15OV3P2JEWTKRaG38C44w+UoENix4JvU=;
        b=JYf/SHvGTAMD3ReBD07BhrieewL7cYYqmYm4em8RgvxzZ24iRic3o2WVpOirjrv+0y
         MezxGdKuheDjH3dKLC34zFhpOQtSup63DWZ6nZ11h4GzxCBnfDghDwrmfPA+vvmXueVt
         H54CoqyBEe8QAG8fZn1vn3JvaMXM5kOzJvXqKQM8oKqbrO0eodPQfRx+8io0mN/cJTW1
         r8+NpVgPYN+EIxyZupchc86SE34tR3v9Gu5oH4BjcgMIT+WzR+Tiect9AEzcoqc7D5og
         qd5Av9th/5kDc6STgOpbouyCSpnncdEdmhY4/s2GmpJC4t/JXVasxkTcZHs3y5X+kxQa
         UBDA==
X-Gm-Message-State: AFq9FYKlxVw7nJvNmIm+rVwiUz/sjdWmyBY+E2+9niiFZXebBLq6SR0w
	b71eeCRNgvNxrtCC+uUo+fXPBpBAUebhlvC3g7zIBCq6dppqkYrbNuWb69I2Vxj5S0oE6MA7uVI
	g0SCj9QGXFuSWooMPBHMX6Vqkm1GsN4WfGwNKHbfRCMPtUAA5wJlt/o9wvFM=
X-Gm-Gg: AYBFou1jn/tZrGW/bq4JOx1j++V0d8raQWWxwJfKOg1Z6rTXUGQeBxVmLE2ut3FHanw
	8KVYhTKkKsELzsoyQaJswdTHFI9T79NlR6TlE7L8Nyjwir1W0vJJDt/LxO5ZumkZPZm19vIy6CJ
	YDDmegEJR+6BanhlnItylqmAEc0GjQAcaO3nJPzANwaEp0aCs4I/YyvdzVAAqd0SVdqnkzUZ9S7
	nMJFhgE1LZiNjR6CfEIJicc5+O9Y9FU5cE5fU0phHG9dD5B9Gtx6IjIuQkngL4RugFcwwyA5mRg
	NypkzWyXjfQJhTAgUXHe/mkThVMOcmUn57KwJL5ulhyTq5WDULrHri8rKLRbtpOSv3FbM9VIgFl
	WwMp4fki4cfZm4NUdP4Q8KWbbRT2OFJJ1MPAgL54lL3M=
X-Received: by 2002:a05:7300:d10b:b0:34e:e479:723 with SMTP id 5a478bee46e88-3537dedaa75mr9124353eec.5.1791723789993;
        Sun, 11 Oct 2026 06:03:09 -0700 (PDT)
X-Received: by 2002:a05:7300:d10b:b0:34e:e479:723 with SMTP id 5a478bee46e88-3537dedaa75mr9124306eec.5.1791723788712;
        Sun, 11 Oct 2026 06:03:08 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm27009074eec.3.2026.10.11.06.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:03:08 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 06:02:11 -0700
Subject: [PATCH net-next v2 05/11] net: ethernet: qualcomm: ppe: Add
 platform support for IPQ5424
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-qcom_ipq5424_ppe-v2-5-8c7b057e2c43@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723782; l=7410;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=mp6D0oOUv26EDKVfLKfYz3oxZLckyUzpTBMUv8dvbIQ=;
 b=7du5iciJCLaD4AWO2FkeEMoSJS51nQjjOvg8Y1mZBVe/Pa3GClfz4pJS200IzpzmcSqbd7Xzf
 l4HmInvrQjABK5YlnqpvNLOUfDgGXIOyINOguvPdNvlnKG2ZuzpC6+L
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX13b+FqJFONDW
 nctB20N8ojyk3ni8ZPd4jNKSs4SMuVDxXdBY0Ff380hjVESABhKJRlVS5TvDfT3jWw9Nb90hmCv
 B4wZpgegWX8el8Nqydcms40sAQKUrtk=
X-Proofpoint-ORIG-GUID: v921RlyB_OqPxmeC7PJ8mldkg0iZJAh5
X-Proofpoint-GUID: v921RlyB_OqPxmeC7PJ8mldkg0iZJAh5
X-Authority-Analysis: v=2.4 cv=eMWGH3p1 c=1 sm=1 tr=0 ts=6acb890f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ofAQdJVYYEMyJCF-WxoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX1kAEEY3m5oJo
 iZLkiOFmMVL/P3f4mdIjTEGViG19+zYlwCKhjnuk93qaQLwJ7n6sK9msN+vumdBB0LZYPkXDUK9
 1SthXf7Lbfym/ELso+IOTWhu2G0l98zVCHZ3G3aPW+E+D5kF1f3HxcgDt5NyVatWqPqj9g1FVgW
 A3V9gwWMdDkfwtSdhEtpozLtsBQDNLJ35/VQSQzcb+W1wN0DP7n/fYQmnH1v3yXmWpp63kj/a5U
 F3ZtwcyCRcWo5NpYENatt0LOth/ctYpuENvEM77d7uovODrD4G1xqWsX3oWN9RPr2SMIk4gnh/z
 8VIOINUq+BCBJU/wYhWxSxE0J+Cp+CW3r70xajQnLnZBQUYbzGszaujnGHL3CbOslf+4tqBv/SY
 FwdZeH/OruFWi197TwwtN71K3t5aTUHgr2m0EgWPedv8+xHeEKlz3ZSdTAnDJ1/AlnSHO5FaL5+
 j6mOKDr4HCpl4VJ3xXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110051

IPQ5424 integrates the same PPE switch core as IPQ9574, but has only 3
Ethernet ports plus the EDMA FIFO, without the EIP FIFO. The PPE clock runs
at 375 MHz instead of IPQ9574's 353 MHz, and IPQ5424 requires a different,
smaller set of interconnect paths. The register space of the unavailable
MAC3 to MAC5 must also not be accessed on IPQ5424.

Add the platform data per SoC to describe these differences, and add the
IPQ5424 compatible.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c | 132 ++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 3c301e609d3e..f71b673b6f97 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -18,13 +18,34 @@
 #include "ppe_config.h"
 #include "ppe_debugfs.h"
 
-#define PPE_PORT_MAX		8
-#define PPE_CLK_RATE		353000000
+#define IPQ9574_PPE_CLK_RATE	353000000
+#define IPQ5424_PPE_CLK_RATE	375000000
+
+/* 6 physical ports, 1 EDMA FIFO and 1 EIP FIFO. */
+#define IPQ9574_PPE_PORT_MAX		8
+/* 3 physical ports and 1 EDMA FIFO. */
+#define IPQ5424_PPE_PORT_MAX		4
+
+/**
+ * struct ppe_of_data - PPE private data of IPQ SoC
+ * @ppe_rate: PPE clock rate
+ * @num_ports: Number of PPE ports
+ * @regmap_config: Regmap configuration
+ * @icc_paths: Interconnect paths per PPE type
+ * @num_icc_paths: Number of ICC paths
+ */
+struct ppe_of_data {
+	unsigned long ppe_rate;
+	int num_ports;
+	const struct regmap_config *regmap_config;
+	const struct icc_bulk_data *icc_paths;
+	int num_icc_paths;
+};
 
 /* ICC clocks for enabling PPE device. The avg_bw and peak_bw with value 0
  * will be updated by the clock rate of PPE.
  */
-static const struct icc_bulk_data ppe_icc_data[] = {
+static const struct icc_bulk_data ipq9574_ppe_icc_data[] = {
 	{
 		.name = "ppe",
 		.avg_bw = 0,
@@ -62,6 +83,34 @@ static const struct icc_bulk_data ppe_icc_data[] = {
 	},
 };
 
+static const struct icc_bulk_data ipq5424_ppe_icc_data[] = {
+	{
+		.name = "ppe",
+		.avg_bw = 0,
+		.peak_bw = 0,
+	},
+	{
+		.name = "ppe_cfg",
+		.avg_bw = 0,
+		.peak_bw = 0,
+	},
+	{
+		.name = "nssnoc_ce_axi",
+		.avg_bw = 0,
+		.peak_bw = 0,
+	},
+	{
+		.name = "nssnoc_ce_apb",
+		.avg_bw = 0,
+		.peak_bw = 0,
+	},
+	{
+		.name = "nssnoc_nss_csr",
+		.avg_bw = 100000,
+		.peak_bw = 100000,
+	},
+};
+
 static const struct regmap_range ppe_readable_ranges[] = {
 	regmap_reg_range(0x0, 0x1ff),		/* Global */
 	regmap_reg_range(0x400, 0x5ff),		/* LPI CSR */
@@ -108,7 +157,36 @@ static const struct regmap_config regmap_config_ipq9574 = {
 	.max_register = 0xbef800,
 };
 
-static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
+/* For IPQ5424, there are only three Ethernet ports, the register space of
+ * GMAC/XGMAC 3-5 is unavailable.
+ */
+static const struct regmap_range ppe_reserved_ranges_ipq5424[] = {
+	regmap_reg_range(0x1600, 0x17ff),	/* GMAC3 */
+	regmap_reg_range(0x1800, 0x19ff),	/* GMAC4 */
+	regmap_reg_range(0x1a00, 0x1bff),	/* GMAC5 */
+	regmap_reg_range(0x50c000, 0x50ffff),	/* XGMAC3 */
+	regmap_reg_range(0x510000, 0x513fff),	/* XGMAC4 */
+	regmap_reg_range(0x514000, 0x517fff),	/* XGMAC5 */
+};
+
+static const struct regmap_access_table ppe_reg_table_ipq5424 = {
+	.yes_ranges = ppe_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ppe_readable_ranges),
+	.no_ranges = ppe_reserved_ranges_ipq5424,
+	.n_no_ranges = ARRAY_SIZE(ppe_reserved_ranges_ipq5424),
+};
+
+static const struct regmap_config regmap_config_ipq5424 = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.rd_table = &ppe_reg_table_ipq5424,
+	.wr_table = &ppe_reg_table_ipq5424,
+	.max_register = 0xbef800,
+};
+
+static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev,
+				    const struct ppe_of_data *data)
 {
 	unsigned long ppe_rate = ppe_dev->clk_rate;
 	struct device *dev = ppe_dev->dev;
@@ -118,15 +196,15 @@ static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
 	int ret, i;
 
 	for (i = 0; i < ppe_dev->num_icc_paths; i++) {
-		ppe_dev->icc_paths[i].name = ppe_icc_data[i].name;
-		ppe_dev->icc_paths[i].avg_bw = ppe_icc_data[i].avg_bw ? :
+		ppe_dev->icc_paths[i].name = data->icc_paths[i].name;
+		ppe_dev->icc_paths[i].avg_bw = data->icc_paths[i].avg_bw ? :
 					       Bps_to_icc(ppe_rate);
 
 		/* PPE does not have an explicit peak bandwidth requirement,
 		 * so set the peak bandwidth to be equal to the average
 		 * bandwidth.
 		 */
-		ppe_dev->icc_paths[i].peak_bw = ppe_icc_data[i].peak_bw ? :
+		ppe_dev->icc_paths[i].peak_bw = data->icc_paths[i].peak_bw ? :
 						Bps_to_icc(ppe_rate);
 	}
 
@@ -173,12 +251,17 @@ static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
 static int qcom_ppe_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct ppe_of_data *data;
 	struct ppe_device *ppe_dev;
 	void __iomem *base;
-	int ret, num_icc;
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return dev_err_probe(dev, -EINVAL, "PPE no match data provided\n");
 
-	num_icc = ARRAY_SIZE(ppe_icc_data);
-	ppe_dev = devm_kzalloc(dev, struct_size(ppe_dev, icc_paths, num_icc),
+	ppe_dev = devm_kzalloc(dev,
+			       struct_size(ppe_dev, icc_paths, data->num_icc_paths),
 			       GFP_KERNEL);
 	if (!ppe_dev)
 		return -ENOMEM;
@@ -187,16 +270,16 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return dev_err_probe(dev, PTR_ERR(base), "PPE ioremap failed\n");
 
-	ppe_dev->regmap = devm_regmap_init_mmio(dev, base, &regmap_config_ipq9574);
+	ppe_dev->regmap = devm_regmap_init_mmio(dev, base, data->regmap_config);
 	if (IS_ERR(ppe_dev->regmap))
 		return dev_err_probe(dev, PTR_ERR(ppe_dev->regmap),
 				     "PPE initialize regmap failed\n");
 	ppe_dev->dev = dev;
-	ppe_dev->clk_rate = PPE_CLK_RATE;
-	ppe_dev->num_ports = PPE_PORT_MAX;
-	ppe_dev->num_icc_paths = num_icc;
+	ppe_dev->clk_rate = data->ppe_rate;
+	ppe_dev->num_ports = data->num_ports;
+	ppe_dev->num_icc_paths = data->num_icc_paths;
 
-	ret = ppe_clock_init_and_reset(ppe_dev);
+	ret = ppe_clock_init_and_reset(ppe_dev, data);
 	if (ret)
 		return dev_err_probe(dev, ret, "PPE clock config failed\n");
 
@@ -218,8 +301,25 @@ static void qcom_ppe_remove(struct platform_device *pdev)
 	ppe_debugfs_teardown(ppe_dev);
 }
 
+static const struct ppe_of_data ipq9574_data = {
+	.ppe_rate = IPQ9574_PPE_CLK_RATE,
+	.num_ports = IPQ9574_PPE_PORT_MAX,
+	.regmap_config = &regmap_config_ipq9574,
+	.icc_paths = ipq9574_ppe_icc_data,
+	.num_icc_paths = ARRAY_SIZE(ipq9574_ppe_icc_data),
+};
+
+static const struct ppe_of_data ipq5424_data = {
+	.ppe_rate = IPQ5424_PPE_CLK_RATE,
+	.num_ports = IPQ5424_PPE_PORT_MAX,
+	.regmap_config = &regmap_config_ipq5424,
+	.icc_paths = ipq5424_ppe_icc_data,
+	.num_icc_paths = ARRAY_SIZE(ipq5424_ppe_icc_data),
+};
+
 static const struct of_device_id qcom_ppe_of_match[] = {
-	{ .compatible = "qcom,ipq9574-ppe" },
+	{ .compatible = "qcom,ipq9574-ppe", .data = &ipq9574_data },
+	{ .compatible = "qcom,ipq5424-ppe", .data = &ipq5424_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_ppe_of_match);

-- 
2.43.0

