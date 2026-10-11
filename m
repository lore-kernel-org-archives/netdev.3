Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0106459AFC
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723796; cv=none; b=CqsYbTYGcbCe1uk8IGYTz4V8oLhPbgSiDN87RS7weXiEnjt2xxbUc5noQXaDTOgyqw+gIpACfoUUNqFa/9ug/kmpGT1hKg8rAWAs+1YsdFnOmF2aWB95zG4ADX3AN6PNnAWoJLv8bbCsIoiYY/Ji+ydL66M+CqtUTgRuMUYE4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723796; c=relaxed/simple;
	bh=VNvt8gQu8Lg4Os/r62s18Lb+XGjG7ToKZw+3dX7hH+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T1hA1z42QxLdw5+eaGKDBvzdoGmpURulVEVQ24NGPOlycUECTHeZNvVSH+TA1gGvyrpHHokoGuriIKgSsa4JOjEDNom35mO+ecPtcKEdN09LUo5xzqthNO9dxy+x/C1vb7Sw5qVDxouSPvsq71Sq9t6mpPQOE8ZoPicYYMwT2Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MWvx9RcZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XQgCRkES; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MWvx9RcZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XQgCRkES"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69B9Oc914140619
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XDB+97tMKM27jruM2B3itkeFHs4Cs5suKrp3XzeD/9U=; b=MWvx9RcZbPc/mIQ4
	aLc57M5a+0z1d5kRl1g7EzNs0IiANXBKcI6V1K2nBSdPST+AtL5TNt8OxuVfrSP6
	PnDOUSAGtIIWYjySkdkP4hzneRfkIvev9dLiwOfux9K1sc1FYhd7Z41pc0C12F24
	FdrdXdU0X3VJRu6W83QOL5xTPrY+0p6jjKXIBxi3goqG1I6Ck8AvjbMxKEbGi3m3
	e94DeNbj2XKTVFxO0Ee2XLwGz6on5tv760IPlDlDEwGCG2aTTA9vM54xxe3jIJRC
	nPvDfNpOxqxfb0xMrFM84mKYrmnNc5blkP8S9lkwH/WUx1GiCdRg5USqy10JqM1i
	Dq6t4w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7casb6c9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2225705eec.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791723792; x=1792328592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XDB+97tMKM27jruM2B3itkeFHs4Cs5suKrp3XzeD/9U=;
        b=XQgCRkESRXj/olaHfI7b7q2XqyEhQDNNBbnjC1HDrjDbwhlKauuSsqWxrrdGty+xri
         ZF5Oa8NF5JOIC/quji1hCYwNAwK0cXIqyba7BWjFG8YoCQyG4jV/GPilsm01tRl2jShH
         qZnlhX0NYYTLk7tVSO4h2Did6f7+5GAoqhN0+2hbfnEcyx/gn/WCLVNzaJJve+4ZpvPs
         V5loSXjZMcn3DucmSSA7Rdmz+nbAY2kJMQOV7SfnbSs6RCHTToAoxiMaJbySCACCLGxj
         3Dx4g83X9gb6+h+smI9RBxIBrXzrSZVHJBkFP0INttB1BiYm/gDkiLlsk52J4jg3Mclz
         NjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791723792; x=1792328592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDB+97tMKM27jruM2B3itkeFHs4Cs5suKrp3XzeD/9U=;
        b=TRKREKzYIQ5qLm9zQReRWQXXMYF9qrPcqPNJKy+FkUSnNsnx2aVY8nP+HSfNaK4xGq
         XirPmB7Zi0GYyqOz6p8TWmKeZF9k6fskoqx/kePNy4NPOGi5UG67cQXRoJ2tKmjJjJnK
         BgVV65oNNh461ASHNDL3WUG6YtoJWOtx2ggEY/Q/Yf1R8mZyIRQnp3HItg7KN0ppvcwS
         PDKZxCprksTw8tb9qAvhKaSeGLdDZX/kXEel7W9uj/Jgxb9OmB0X0fuyjPrqrCgorWJl
         Fp8seAZdPfDoyNiigz2EniHXbCbs2A6y1o0OMZ3i26KpVYynU8zYk9TAfkT4ms+1uTE3
         pE2w==
X-Gm-Message-State: AFq9FYIon2z7kJlmTfoeGvBUD8WSLpkPAdjYmQ+xFpp1lPShCjjR+0VO
	DdkXaCx3wuLv20coQjhMqb4Z2si6lOBKNRVbib7WFofuLneE2siWqo9uuIL1VWOav47KmwLTQqG
	WTiN/mI5jzBVcnTpCDUl8VOQJKLFnaG68zWtc5cggqKZ8EBSOvyVTUF1tFXQ=
X-Gm-Gg: AYBFou0S/7mOgihL8zCrCcPo+IESdfNJ9kbzbRaih/2h8BdpcUS8E076MsOdddTpuTa
	GLUg5fLnSkevFCcC2QrWWKIcHMlHuvJGY8tsBXH5hsyoQiy0c69HSrAC61V/huU2TOIWdB+0+EW
	S/jYL/zugXocwiOIM8wivqG6oFHNS0tUZvKV9bf09EhSyL2CmC03wOyjsDT85/0q+fQ8QSqFm1V
	HqMLKC5liZRafpEEnbb60KUBqTutw+RUNWxmT/vW/nzsl5OVmNk2/+nYGe/kR8Tlu2ewgg7Lb+I
	Goo5wRWf4GlkQGVa+cgzg4ipHXiCLVBBxY7N3UunahHYOsaNl3tUJvWAeQLsgtqEpVYe3lcsl++
	FA9QcNmtXYbS0tMMyXX64dRr5nuxNKtQaMsWwSeleokU=
X-Received: by 2002:a05:7022:7e87:b0:143:26f5:c617 with SMTP id a92af1059eb24-16a60347295mr12159835c88.32.1791723791348;
        Sun, 11 Oct 2026 06:03:11 -0700 (PDT)
X-Received: by 2002:a05:7022:7e87:b0:143:26f5:c617 with SMTP id a92af1059eb24-16a60347295mr12159766c88.32.1791723790535;
        Sun, 11 Oct 2026 06:03:10 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm27009074eec.3.2026.10.11.06.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:03:09 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 06:02:12 -0700
Subject: [PATCH net-next v2 06/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 BM buffer configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-qcom_ipq5424_ppe-v2-6-8c7b057e2c43@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723782; l=10523;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=VNvt8gQu8Lg4Os/r62s18Lb+XGjG7ToKZw+3dX7hH+I=;
 b=EACUXPRB2zIZFrZgHQZw7aXFVPlkdBSJJ/ef9sSddM2eyiWK3i17ZDfmwnVOUqKvJXhlVGqeT
 Vc3Ep8Qw70mAyM2iRxzfQyWwizAP2NoO8STmtM9pjiA0gD7C7e0COUT
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfXxOq06ZzEorcz
 0yxkxT+9mTshl8huMWC7Sr0cYtcys9AHvX8yb8w4xl9gBdx2giHWEapEqz47a5uYUvnjdPS3unq
 hhkyDWCJPOKQRxpS9NzxkopO/fhzIeo=
X-Proofpoint-ORIG-GUID: hMB_k9FCLl9ASeIm15VAHTRmwNeW-VtD
X-Proofpoint-GUID: hMB_k9FCLl9ASeIm15VAHTRmwNeW-VtD
X-Authority-Analysis: v=2.4 cv=eMWGH3p1 c=1 sm=1 tr=0 ts=6acb8910 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=hbDBTZp0xKPJ1oUTAGIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX0ej4X4MPXP/Z
 0T2kf2Ak79AdnkYoBbzhOsVBolFfMSmyK0DsEcNN43g+ivKylu16NLsiETFHfc1/iyO+xHaUlYb
 izEindWlZWOS1GX0oSSklTxYYOQC2xantYxiMqIDi8ia+rfRU2YTS8W8riuClLSgtn8rqW9Yr9N
 GK+b30ORQ8QCnrOHOjLoU8Q4/UDZrpHcwosLWQt4uZtKznD6uLA7/fODcgUieZwlmEwkYs6r/zp
 QR2DJlfjbnZEOjGwpJNLRRS9MHYg2XrdkNXP5sc+LHlV87oxWLUZ9q6+2GsRCc+ty+z20g91/ik
 uab4bAze0kgoGQf05WI7NfIVQesuO48Pfs4mMZhXpEnhL3AqY8YLnfGJvqFPoYj/tKFvxCGnks9
 STWifT/+lm5hvD5hv9rIjZ+UZ+IewxkJVDgr86HX7ZMk6SlmDcETGscco3sckZFsaxLkq4jMScu
 NkbEwYDvmzrcuXaAIxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110051

IPQ5424 has fewer PPE ports than IPQ9574, so it requires a different buffer
configuration per port, and more buffers are left for the shared buffer
pool. IPQ5424 also has more BM ports than IPQ9574, 19 versus 15, so some BM
register tables have more entries on IPQ5424, and some of them are located
at different addresses.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c        |  5 ++
 drivers/net/ethernet/qualcomm/ppe/ppe.h        | 15 +++++
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 79 +++++++++++++++++++++++---
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h   | 35 +++++++++---
 4 files changed, 118 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index f71b673b6f97..b144fd818998 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -28,6 +28,7 @@
 
 /**
  * struct ppe_of_data - PPE private data of IPQ SoC
+ * @type: PPE type value
  * @ppe_rate: PPE clock rate
  * @num_ports: Number of PPE ports
  * @regmap_config: Regmap configuration
@@ -35,6 +36,7 @@
  * @num_icc_paths: Number of ICC paths
  */
 struct ppe_of_data {
+	enum ppe_type type;
 	unsigned long ppe_rate;
 	int num_ports;
 	const struct regmap_config *regmap_config;
@@ -275,6 +277,7 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ppe_dev->regmap),
 				     "PPE initialize regmap failed\n");
 	ppe_dev->dev = dev;
+	ppe_dev->type = data->type;
 	ppe_dev->clk_rate = data->ppe_rate;
 	ppe_dev->num_ports = data->num_ports;
 	ppe_dev->num_icc_paths = data->num_icc_paths;
@@ -302,6 +305,7 @@ static void qcom_ppe_remove(struct platform_device *pdev)
 }
 
 static const struct ppe_of_data ipq9574_data = {
+	.type = IPQ9574_PPE,
 	.ppe_rate = IPQ9574_PPE_CLK_RATE,
 	.num_ports = IPQ9574_PPE_PORT_MAX,
 	.regmap_config = &regmap_config_ipq9574,
@@ -310,6 +314,7 @@ static const struct ppe_of_data ipq9574_data = {
 };
 
 static const struct ppe_of_data ipq5424_data = {
+	.type = IPQ5424_PPE,
 	.ppe_rate = IPQ5424_PPE_CLK_RATE,
 	.num_ports = IPQ5424_PPE_PORT_MAX,
 	.regmap_config = &regmap_config_ipq5424,
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
index 27458f0bc206..33b876d2e079 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -13,10 +13,24 @@ struct device;
 struct regmap;
 struct dentry;
 
+/**
+ * enum ppe_type - PPE device type.
+ * @IPQ9574_PPE: PPE device of IPQ9574.
+ * @IPQ5424_PPE: PPE device of IPQ5424.
+ *
+ * PPE type is used to identify the PPE device of the different
+ * IPQ platform.
+ */
+enum ppe_type {
+	IPQ9574_PPE,
+	IPQ5424_PPE,
+};
+
 /**
  * struct ppe_device - PPE device private data.
  * @dev: PPE device structure.
  * @regmap: PPE register map.
+ * @type: Different PPE type on various IPQ SoC.
  * @clk_rate: PPE clock rate.
  * @num_ports: Number of PPE ports.
  * @debugfs_root: Debugfs root entry.
@@ -30,6 +44,7 @@ struct dentry;
 struct ppe_device {
 	struct device *dev;
 	struct regmap *regmap;
+	enum ppe_type type;
 	unsigned long clk_rate;
 	unsigned int num_ports;
 	struct dentry *debugfs_root;
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index 2f4f59280647..ef46e9b133fe 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -230,6 +230,56 @@ static const struct ppe_bm_port_config ipq9574_ppe_bm_port_config[] = {
 	},
 };
 
+/* IPQ5424 has fewer PPE physical ports (3) than IPQ9574 (6), so fewer
+ * buffers need to be reserved for per-port purposes. Out of the same
+ * 2048 total, the rest assigned to the general 'group0' pool is
+ * correspondingly larger here, 1650 versus IPQ9574's 1550.
+ */
+static const int ipq5424_ppe_bm_group_config = 1650;
+
+/* The buffer configurations per PPE port on IPQ5424. There are 19 BM
+ * ports supported by PPE. BM port (0-15) is for EDMA port 0, and BM
+ * port (16-18) is for the 3 PPE physical ports.
+ */
+static const struct ppe_bm_port_config ipq5424_ppe_bm_port_config[] = {
+	{
+		/* Buffer configuration for the BM port ID 0 of EDMA. */
+		.port_id_start	= 0,
+		.port_id_end	= 0,
+		.pre_alloc	= 0,
+		.in_fly_buf	= 100,
+		.ceil		= 1146,
+		.weight		= 7,
+		.resume_offset	= 8,
+		.resume_ceil	= 0,
+		.dynamic	= true,
+	},
+	{
+		/* Buffer configuration for the BM port ID 1-15 of EDMA. */
+		.port_id_start	= 1,
+		.port_id_end	= 15,
+		.pre_alloc	= 0,
+		.in_fly_buf	= 100,
+		.ceil		= 250,
+		.weight		= 4,
+		.resume_offset	= 36,
+		.resume_ceil	= 0,
+		.dynamic	= true,
+	},
+	{
+		/* Buffer configuration for the BM port ID 16-18 of PPE ports. */
+		.port_id_start	= 16,
+		.port_id_end	= 18,
+		.pre_alloc	= 0,
+		.in_fly_buf	= 128,
+		.ceil		= 250,
+		.weight		= 4,
+		.resume_offset	= 36,
+		.resume_ceil	= 0,
+		.dynamic	= true,
+	},
+};
+
 /* QM fetches the packet from PPE buffer management for transmitting the
  * packet out. The QM group configuration limits the total number of buffers
  * enqueued by all PPE hardware queues.
@@ -1413,7 +1463,7 @@ static int ppe_config_bm_threshold(struct ppe_device *ppe_dev, int bm_port_id,
 
 	/* Assign the default group ID 0 to the BM port. */
 	val = FIELD_PREP(PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID, 0);
-	reg = PPE_BM_PORT_GROUP_ID_ADDR + PPE_BM_PORT_GROUP_ID_INC * bm_port_id;
+	reg = PPE_BM_PORT_GROUP_ID_ADDR(ppe_dev) + PPE_BM_PORT_GROUP_ID_INC * bm_port_id;
 	ret = regmap_update_bits(ppe_dev->regmap, reg,
 				 PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID,
 				 val);
@@ -1431,25 +1481,38 @@ static int ppe_config_bm(struct ppe_device *ppe_dev)
 {
 	const struct ppe_bm_port_config *port_cfg;
 	unsigned int i, bm_port_id, port_cfg_cnt;
-	u32 reg, val;
+	u32 reg, val, group_cfg;
 	int ret;
 
+	switch (ppe_dev->type) {
+	case IPQ9574_PPE:
+		port_cfg = ipq9574_ppe_bm_port_config;
+		port_cfg_cnt = ARRAY_SIZE(ipq9574_ppe_bm_port_config);
+		group_cfg = ipq9574_ppe_bm_group_config;
+		break;
+	case IPQ5424_PPE:
+		port_cfg = ipq5424_ppe_bm_port_config;
+		port_cfg_cnt = ARRAY_SIZE(ipq5424_ppe_bm_port_config);
+		group_cfg = ipq5424_ppe_bm_group_config;
+		break;
+	default:
+		dev_err(ppe_dev->dev, "Invalid PPE type %d\n", ppe_dev->type);
+		return -EINVAL;
+	}
+
+	reg = PPE_BM_SHARED_GROUP_CFG_ADDR(ppe_dev);
+
 	/* Configure the allocated buffer number only for group 0.
 	 * The buffer number of group 1-3 is already cleared to 0
 	 * after PPE reset during the probe of PPE driver.
 	 */
-	reg = PPE_BM_SHARED_GROUP_CFG_ADDR;
-	val = FIELD_PREP(PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT,
-			 ipq9574_ppe_bm_group_config);
+	val = FIELD_PREP(PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT, group_cfg);
 	ret = regmap_update_bits(ppe_dev->regmap, reg,
 				 PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT,
 				 val);
 	if (ret)
 		goto bm_config_fail;
 
-	/* Configure buffer thresholds for the BM ports. */
-	port_cfg = ipq9574_ppe_bm_port_config;
-	port_cfg_cnt = ARRAY_SIZE(ipq9574_ppe_bm_port_config);
 	for (i = 0; i < port_cfg_cnt; i++) {
 		for (bm_port_id = port_cfg[i].port_id_start;
 		     bm_port_id <= port_cfg[i].port_id_end; bm_port_id++) {
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 746dfbb5a682..441e8e04a80b 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -386,17 +386,32 @@
 #define PPE_PSCH_SCH_CFG_TBL_DES_SECOND_PORT_EN	BIT(16)
 #define PPE_PSCH_SCH_CFG_TBL_DES_SECOND_PORT	GENMASK(20, 17)
 
-/* There are 15 BM ports and 4 BM groups supported by PPE.
- * BM port (0-7) is for EDMA port 0, BM port (8-13) is for
- * PPE physical port 1-6 and BM port 14 is for EIP port.
+/* There are 15 BM ports on IPQ9574 and 19 BM ports on IPQ5424, and
+ * 4 BM groups supported by PPE. On IPQ9574, BM port (0-7) is for EDMA
+ * port 0, BM port (8-13) is for PPE physical port 1-6 and BM port 14
+ * is for EIP port. On IPQ5424, BM port (0-15) is for EDMA port 0 and
+ * BM port (16-18) is for PPE physical port 1-3.
+ *
+ * The per-BM-port tables PPE_BM_PORT_FC_MODE and PPE_BM_PORT_FC_CFG_TBL
+ * are at the same address on both SoCs, IPQ5424 only has more entries.
  */
+#define PPE_BM_PORT_IPQ9574_ENTRIES		15
+#define PPE_BM_PORT_IPQ5424_ENTRIES		19
+#define PPE_BM_PORT_ENTRIES(ppe_dev)						\
+	((ppe_dev)->type == IPQ5424_PPE ? PPE_BM_PORT_IPQ5424_ENTRIES :	\
+					  PPE_BM_PORT_IPQ9574_ENTRIES)
+
 #define PPE_BM_PORT_FC_MODE_ADDR		0x600100
-#define PPE_BM_PORT_FC_MODE_ENTRIES		15
+#define PPE_BM_PORT_FC_MODE_ENTRIES(ppe_dev)	PPE_BM_PORT_ENTRIES(ppe_dev)
 #define PPE_BM_PORT_FC_MODE_INC			0x4
 #define PPE_BM_PORT_FC_MODE_EN			BIT(0)
 
-#define PPE_BM_PORT_GROUP_ID_ADDR		0x600180
-#define PPE_BM_PORT_GROUP_ID_ENTRIES		15
+#define PPE_BM_PORT_GROUP_ID_IPQ9574_ADDR	0x600180
+#define PPE_BM_PORT_GROUP_ID_IPQ5424_ADDR	0x6001c0
+#define PPE_BM_PORT_GROUP_ID_ADDR(ppe_dev)					\
+	((ppe_dev)->type == IPQ5424_PPE ? PPE_BM_PORT_GROUP_ID_IPQ5424_ADDR :	\
+					  PPE_BM_PORT_GROUP_ID_IPQ9574_ADDR)
+#define PPE_BM_PORT_GROUP_ID_ENTRIES(ppe_dev)	PPE_BM_PORT_ENTRIES(ppe_dev)
 #define PPE_BM_PORT_GROUP_ID_INC		0x4
 #define PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID	GENMASK(1, 0)
 
@@ -412,13 +427,17 @@
 #define PPE_BM_REACT_CNT_TBL_INC		0x4
 #define PPE_BM_REACT_CNT_VAL			GENMASK(8, 0)
 
-#define PPE_BM_SHARED_GROUP_CFG_ADDR		0x600290
+#define PPE_BM_SHARED_GROUP_CFG_IPQ9574_ADDR	0x600290
+#define PPE_BM_SHARED_GROUP_CFG_IPQ5424_ADDR	0x6002f0
+#define PPE_BM_SHARED_GROUP_CFG_ADDR(ppe_dev)						\
+	((ppe_dev)->type == IPQ5424_PPE ? PPE_BM_SHARED_GROUP_CFG_IPQ5424_ADDR :	\
+					  PPE_BM_SHARED_GROUP_CFG_IPQ9574_ADDR)
 #define PPE_BM_SHARED_GROUP_CFG_ENTRIES		4
 #define PPE_BM_SHARED_GROUP_CFG_INC		0x4
 #define PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT	GENMASK(10, 0)
 
 #define PPE_BM_PORT_FC_CFG_TBL_ADDR		0x601000
-#define PPE_BM_PORT_FC_CFG_TBL_ENTRIES		15
+#define PPE_BM_PORT_FC_CFG_TBL_ENTRIES(ppe_dev)	PPE_BM_PORT_ENTRIES(ppe_dev)
 #define PPE_BM_PORT_FC_CFG_TBL_INC		0x10
 #define PPE_BM_PORT_FC_W0_REACT_LIMIT		GENMASK(8, 0)
 #define PPE_BM_PORT_FC_W0_RESUME_THRESHOLD	GENMASK(17, 9)

-- 
2.43.0

