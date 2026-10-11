Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBBD45D906
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723796; cv=none; b=AQxm7fX3WZwt/it3TDL5geQti5y7nQU9cs24T6hCl2mUYKpBMjNhdZoFB7thyaPs7nQK1EPLM846S2AwTFDw+ARRCuASPd7eTMkgZnVJSjQcTGDeuqgdMsyLoDZiwkFOTaffAc4L0vSVJOfxak2lLgL1uYPKoFJn9rV3mvccSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723796; c=relaxed/simple;
	bh=PeIDZ9ZvLBn2ComBGRH5CSzm2sE8lWrroJLbFwf4FOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N80rCvEVhL993QUXkuhSgXrnNI0YFKr0qbGM2bwjrDX5EJ+2VXmq2KMkLmpkeh5bmYsELZPMMFb5+HO5VKJ37z/rpWQybLudlpbXi7GYW5QZnAcgTB8TyLbuUrkFp7G1qKQtshXe1bjiP8Y2zDudUD6OaC9Uxtqhtfc6G1P29tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJeNe53M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OsGaUa9J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJeNe53M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OsGaUa9J"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69B857ub4074780
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QrRL4B0nTOu0FNZfqLDv3k7qnligih+VKCyqZVW5V5Y=; b=gJeNe53MlDbh14gJ
	6PN8SivIAS2KMq6tybuvrhX/9UtEMfFlQdlXbjMDDGG1An5W0M+QqWZ6NV4/ke6Q
	hx1PQ1Mq2uCYJjCG9bJl4PgUhfHAurcOrknhUYXwPv4XUJr02AB3ziKxYsVy+6Uh
	9AWQ0c1UF614BILtsBAlCU4JPmzgAvD7eScWwe8uCSYEcwsHH/D26HhGFDGWbXoB
	6IY368soxm78VMKESoaplvN0gYGdXDrmS0iEk18RZHHJ+ntAvTkjOyd8kwxDJw5f
	Lmp8F79rha0FSV5XxjVG0GDLTpQoy15m0/aBhRzKUTeZtF+mfJVszEbwkCX8wgMm
	dvqXDA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7b2fbcnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so3655810eec.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791723793; x=1792328593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QrRL4B0nTOu0FNZfqLDv3k7qnligih+VKCyqZVW5V5Y=;
        b=OsGaUa9JV+DglH3lB7qVH2NAto8bZnmiNwNBurgVKrEqWPkd19Smve9rGbMJGDAiBd
         9nNlCwoCGW30u+K/iWioHjmqMXiokBrO8rSxpzIOX2rjvpz7oEHrUvglmPk4krvFFCL3
         dLpuQnmY6RTZ5XFCmvMEhW+L/pDP11nfeLJN4y3oIx+7G/4fensyd4q/WfBbxaTA6gcC
         ekcwjIbubIfJOogFtBoDoXkFwda8a6lc2TbRLF5PJbVGdoX88aptq0uqW5v0QAtVonC2
         YlIpEqPCGxHSJfvBt0J9qpqMWLpOySFvKSRULtY0x9lm+cUaQ/UcJEixPpdtEcpepUY9
         ZAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791723793; x=1792328593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrRL4B0nTOu0FNZfqLDv3k7qnligih+VKCyqZVW5V5Y=;
        b=nShM4tC//bHsqPB9lp5uPNgQKPOVNMGs/hcpmYOtpZNdO8Enwr9I5JTXuRZmPSZbLP
         bz0bOePgC9PhtPaom+8MxEAn2QV4tyRMJmZcbcexPe1aQL8rz+3bg2Hhs77Sju0NvyoA
         4jPWtq0kVDT8aHEZssAUzlxxNbZ7AK5YkqzCT+b3bxSN7TDWsPdPAGltnprhObU0F3os
         2rJf/hSmaMk0vQlJHcrtvmeYXsqt0tCmnyXZ8/OVuAL9L74jVmMsCv8eEZwikqPACqeu
         8pIo1lxYNMLVO4k9S1mFAZiif3rHxwDOp4DcNuIfwjy7J9eAgaV4IpVS/EV6imbIjfvf
         uxPg==
X-Gm-Message-State: AFq9FYJHA09gqmKBHwkoN7igRSbPjgAG/v9cFbQsxxsMCy+481AnBA00
	5YkOQII0epymxUZ7GgCrPCIxB4NOIeFEulXSrrCRBQw76wYv36Ut87DNf8p9LxSbGWFUIKgst4U
	dBvFyrAZo5TBMBKXHtTQfTnD492yRHywS5wi0MnR9oBSNPvyZt+ih/azERao=
X-Gm-Gg: AYBFou3GAAxv3uhBMxChVTMx7zTncO5XYZtdmgzv0JGwn0h9x9tP/i/kceGj5XyxwEs
	QR72aX+DErHOwAryVVR1/HYjuvNvP/MYVpXaKV6kSUvfR/5ls4FSrrtNvfhZMHyk2CkSH05CHZh
	+EGBRa3tA153MRuDY+cPtk0Yb6RhGYslgQMNIsZnaf6RdEDpL+ZlXa75mIaAZx4uEWbrAAPYv9Q
	SOpL9ZbtWiNn0d1jQ88i8Thq5mayn8ro+rpslKrnU3iTgqp4LzTGvHoFWF3xwhIPJeVb8ZmvZU3
	wLGSNsEd9+F2JPSpfw7MFPORF3OHAQRTZq/iqZWg8jLajwdTRNJ1DLBthZ38keBpMCENuDefrmY
	rotxvlX0g0Vh+df0CwO6eSx0/yY+zx2EbHJ1znHzpVPo=
X-Received: by 2002:a05:7300:ce13:b0:35a:3045:3aff with SMTP id 5a478bee46e88-35a3054a74bmr1119322eec.29.1791723792820;
        Sun, 11 Oct 2026 06:03:12 -0700 (PDT)
X-Received: by 2002:a05:7300:ce13:b0:35a:3045:3aff with SMTP id 5a478bee46e88-35a3054a74bmr1119286eec.29.1791723792096;
        Sun, 11 Oct 2026 06:03:12 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm27009074eec.3.2026.10.11.06.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:03:11 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 06:02:13 -0700
Subject: [PATCH net-next v2 07/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 QM configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-qcom_ipq5424_ppe-v2-7-8c7b057e2c43@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723782; l=3638;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=PeIDZ9ZvLBn2ComBGRH5CSzm2sE8lWrroJLbFwf4FOU=;
 b=bM/zT2AcQmX617BTGIoNHu/47WPJEbVZcE2X4by9igjYnxLouiT0hpXOtFaOQP/ec2/IHnbOR
 aZ0mf8ux3jsAgPzwl4BrhVhRCG+D3tiTnvkD2vcOvaIixfBJinYzUQG
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX7SU4BM0+cYv1
 QdThpgsBjP8Cyd6iqci1wp4mALcD/5DdE9Rond6w875CHpU+IEOHQ0KSQMdDfKP2xbIatpcIStZ
 DWco6Kxr7tnMrNL9jXrKrtMDBfkZQ+4=
X-Proofpoint-GUID: nA3cAwv5_EkfqMsiTR6PL1ynxc6e_T7f
X-Authority-Analysis: v=2.4 cv=NddzRGD4 c=1 sm=1 tr=0 ts=6acb8912 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=9QRhiHdFDdAkXRKojpMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX6YQ8SyEWU241
 1gpWhq9sd6En0VUSsjDxsYvBf7h+Wx2TC1ci+caMtHP0owXojEjxRK2EscF1Uz/yK85z+w7Lmdk
 DZ0qzsSVQQDtzgCCeO6lpLBoM+jfg9BPzMTR38aurSwrY3kQTB4MARQEyrGiW8OA/am7hBG1HFG
 6UMbkMjJyYWCBBByB8Zs7p5n+5oblmWLMQ6M4NR5TVvrjAbKNxWVcDN15v8NaIu9rxuXz25Hmdz
 cSOdHlL0mw1qqtehx2mdZvFRmsyc3fQqQXKe1r5O5cUIDZ6B0R3V7N/fPqbiksWAcVUcFdG2TCu
 cYN0ZuYZ1+KVGCDAZJmbN8uUfJiSA/pyiqmTxeCnQn1e0QD2H6kAnsJSx0NBtfGfZdjT/zF4gN4
 vMmhhGRHW11JfZwG44OkVyUIYoTKr4mrRLuJxTVo/yVeeEaav06NWWTH57ZoBtVGcDYzVWpNxym
 wOThho8Fz2ZFaZNStfw==
X-Proofpoint-ORIG-GUID: nA3cAwv5_EkfqMsiTR6PL1ynxc6e_T7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110051

Multicast queues are dedicated per PPE port. IPQ5424 has only 3 physical
PPE ports, versus IPQ9574's 6 PPE ports, so multicast queues 284 to 299 are
not available on IPQ5424, and 2010 buffers are assigned to the shared
group0 buffer pool, instead of IPQ9574's 2000.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 53 ++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index ef46e9b133fe..d2bd78853b98 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -314,6 +314,37 @@ static const struct ppe_qm_queue_config ipq9574_ppe_qm_queue_config[] = {
 	},
 };
 
+/* Multicast queues are dedicated per PPE port. IPQ5424 has only 3 physical
+ * PPE ports, versus IPQ9574's 6 PPE ports, so multicast queues 284 to 299
+ * are not available on IPQ5424, and the buffer pool assigned to the general
+ * 'group0' is larger here, 2010 versus IPQ9574's 2000.
+ */
+static const int ipq5424_ppe_qm_group_config = 2010;
+
+/* Default QM settings for unicast and multicast queues for IPQ5424. */
+static const struct ppe_qm_queue_config ipq5424_ppe_qm_queue_config[] = {
+	{
+		/* QM settings for unicast queues 0 to 255. */
+		.queue_start	= 0,
+		.queue_end	= 255,
+		.prealloc_buf	= 0,
+		.ceil		= 1200,
+		.weight		= 7,
+		.resume_offset	= 36,
+		.dynamic	= true,
+	},
+	{
+		/* QM settings for multicast queues 256 to 283. */
+		.queue_start	= 256,
+		.queue_end	= 283,
+		.prealloc_buf	= 0,
+		.ceil		= 250,
+		.weight		= 0,
+		.resume_offset	= 36,
+		.dynamic	= false,
+	},
+};
+
 /* PPE scheduler configuration for BM includes multiple entries. Each entry
  * indicates the primary port to be assigned the buffers for the ingress or
  * to release the buffers for the egress. Backup port ID will be used when
@@ -1535,12 +1566,28 @@ static int ppe_config_bm(struct ppe_device *ppe_dev)
  */
 static int ppe_config_qm(struct ppe_device *ppe_dev)
 {
+	int ret, i, group_buffer_cfg, queue_id, queue_cfg_count;
 	const struct ppe_qm_queue_config *queue_cfg;
-	int ret, i, queue_id, queue_cfg_count;
 	u32 reg, multicast_queue_cfg[3];
 	u32 unicast_queue_cfg[4];
 	u32 group_cfg[3];
 
+	switch (ppe_dev->type) {
+	case IPQ9574_PPE:
+		group_buffer_cfg = ipq9574_ppe_qm_group_config;
+		queue_cfg = ipq9574_ppe_qm_queue_config;
+		queue_cfg_count = ARRAY_SIZE(ipq9574_ppe_qm_queue_config);
+		break;
+	case IPQ5424_PPE:
+		group_buffer_cfg = ipq5424_ppe_qm_group_config;
+		queue_cfg = ipq5424_ppe_qm_queue_config;
+		queue_cfg_count = ARRAY_SIZE(ipq5424_ppe_qm_queue_config);
+		break;
+	default:
+		dev_err(ppe_dev->dev, "Invalid PPE type %d\n", ppe_dev->type);
+		return -EINVAL;
+	}
+
 	/* Assign the buffer number to the group 0 by default. */
 	reg = PPE_AC_GRP_CFG_TBL_ADDR;
 	ret = regmap_bulk_read(ppe_dev->regmap, reg,
@@ -1548,15 +1595,13 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
 	if (ret)
 		goto qm_config_fail;
 
-	PPE_AC_GRP_SET_BUF_LIMIT(group_cfg, ipq9574_ppe_qm_group_config);
+	PPE_AC_GRP_SET_BUF_LIMIT(group_cfg, group_buffer_cfg);
 
 	ret = regmap_bulk_write(ppe_dev->regmap, reg,
 				group_cfg, ARRAY_SIZE(group_cfg));
 	if (ret)
 		goto qm_config_fail;
 
-	queue_cfg = ipq9574_ppe_qm_queue_config;
-	queue_cfg_count = ARRAY_SIZE(ipq9574_ppe_qm_queue_config);
 	for (i = 0; i < queue_cfg_count; i++) {
 		queue_id = queue_cfg[i].queue_start;
 

-- 
2.43.0

