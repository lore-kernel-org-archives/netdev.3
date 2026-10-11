Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B783B45FFAE
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723798; cv=none; b=IMo1JB2X6+RXCEy8okQbkvwdUeZq9Tne23ww2aH2qdKaZq3jqPICYjDUZYAM1NezvfygVCnwNRSJfdyuiX5CWywISKaPwdLxYKetihcGN+2Sq8WpV00yFPgkyXZF3ClVmGO8L0HWdD+4xaGF6y80WTjtnni+S5u+aASCMM20XnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723798; c=relaxed/simple;
	bh=BII9QMz3q7F9rXprLEsYTt6/oOQ+QYjmWw+VrsyhsDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAgeitjSvUACTDe8ARJQCiGRdpxmj9f35FXqjpccscXEsiNn9/hEaEiUzX0eNI0jSmy16WnSu32Pw5cyJsQ7ZXundjN0pASMTBbv7Utgrnyj0WlyACL131AqIA69EOAG3FBSaJQhZOlhn4vZzatuwVFrlUFRy6mjzGcMf/dkyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NpYh/Tt9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VnEsRnjC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NpYh/Tt9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VnEsRnjC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69B852BJ3981964
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gkPst5lnwo1vvWdHpGV8GLvk45koMW8TYQUaDxoPUlk=; b=NpYh/Tt9QRlftf0r
	kE0v2PsHUNE4ILuOI+tgRQSIsTcXARTd28iEz76A0D+/WWmlgC3g3fkRSYfwTh6A
	aPCfVKyEt67rlAA0jwASouwhHwtDsuT3dzlNCxnF8asxypnqY8tJA+YFA+ISjcxZ
	CmEjCjEltZmZqzY+JRDPuEIOg+F4eHV2d9gkq/aLs9v+naCfE18y3zEFJYUaZA7E
	aotDE/SY6UZPFypY2+VbDQly93mZlULbNWj2L/pIm0CYQUrVZDeSmsriaoTJelK0
	AA6YiJsaO2YtSZQFW3K2PM9ogz1+lDrThK0wRDJrXOrPKUFPWcB5Mus1j4z7iptN
	R4bFTA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7casb6cr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3552883bd19so923178eec.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791723795; x=1792328595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gkPst5lnwo1vvWdHpGV8GLvk45koMW8TYQUaDxoPUlk=;
        b=VnEsRnjCH9+sXGQb1cz4l5khMfcByiuH7a8S4sqbmPQBCDg35VifLoYoe36QIS5Rgi
         4Jf5KwS/nO9t2KdyKkBBgUj67Rk5udgkg5mNqHoh8dOIslIDbkPAqZkTF0c0SaKUlGTt
         DKYWHATblh6a/qrW/iIsxy15tBMgjj6OPGFMDpa6Dl2Dd8+f14KR43OkFzgj/6LeNMgF
         oUX+0yFfwFiNqs2SePXLnZEGnjGi+J+Eg+e5IIX1iV56E8EHOvY1t+lmFAU3KSW2Mpjj
         cJx/X5JXqW6xcwHg73ctxwapHVYf07/F/hXrFL85lHXPJGD58yjMYKZdlJ7bqAp3SI4Q
         03fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791723795; x=1792328595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gkPst5lnwo1vvWdHpGV8GLvk45koMW8TYQUaDxoPUlk=;
        b=J2LbY/uhesM6lffj3XKtsIJRY3nCS4FVQsT+5Yu9P7Syk/padZjc4IEd+FPnbqWIoB
         kPUWWhs5YXA5kXXl8+8IXJknGr5pIzX331oD7d5Zc0yzL3l1jvZGIh5e/P5mWlGRuYaC
         k39cUM9EDy/7NbAW/KZwe/zUqKDEM6Mcr3dxCoxjpSG9kTrM02YiwdTewVc5S+bk7ekh
         YqaJPQJ6EQ/bYAG2YKYColxrctpoCrCnINUxmN/RWuqCaHDDV7vTHrDzd4e29npZrUV6
         Ky14BJS/tCl6g0DaR6CkLEPbNbZUPwn68uG7KHfTBeJQ/qPP6Urklx34TBYlC++G7vMP
         mf5Q==
X-Gm-Message-State: AFq9FYLoyGh8OE8QkY8Uac/kuJBFqVi9HZLM+yfCfXQT+lJLcqOAL+Au
	fTEJB1f/ccoGjiJtZ9DQf0mFMFN16ApFkPpOcDn2srZrLhZ5Hdlx5Jga+eshycJLuao1sQ5J7rh
	1chVgalOx2y8oErcpmG+6vBg4FNYWEfmVXfj3iTazMCnFIPLHMBH/OR6qtK8=
X-Gm-Gg: AYBFou0E0CSzpwTd+pHYLvM9bWHujo/NdGcT5hDGpdzvxl4fp2tXJXcXMYV0dqGc8o4
	ygOGbvyyjTjOQKASYwtjhKPRC2WGvsrngj+L2xPjU9ItuQFKWx4XxDgdIZwwwiudBoo+wzXmATa
	u0xzA+/KYTrkeB+stj6m2Q5TEievBiiAYgC8yws/U5HdzYTGDAnyMytvqKW9BtwmvwWibr3IShB
	B9oRRR5iOutqr9n2wZK8FXsDMRCXk82RbCx/uzRytEAMvGeqJqE6RbcyJj5uN2Ci8wJ8rsfViwc
	yQXX90qizCYS4zprI5BFE5PiLDmJ6dPzTDAJTwyxtkNMguC/UflQz79fkKUYxOe1z5ydIteOoX1
	fkXa1K3rFBcZqmo7zhwAHsNxaKuEhy8CT+cfgjfAzB0M=
X-Received: by 2002:a05:693c:23c6:b0:351:1f56:3a89 with SMTP id 5a478bee46e88-3537e00a83amr14354211eec.23.1791723794773;
        Sun, 11 Oct 2026 06:03:14 -0700 (PDT)
X-Received: by 2002:a05:693c:23c6:b0:351:1f56:3a89 with SMTP id 5a478bee46e88-3537e00a83amr14354138eec.23.1791723793895;
        Sun, 11 Oct 2026 06:03:13 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm27009074eec.3.2026.10.11.06.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:03:12 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 06:02:14 -0700
Subject: [PATCH net-next v2 08/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 scheduler resource configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-qcom_ipq5424_ppe-v2-8-8c7b057e2c43@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723782; l=3976;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=BII9QMz3q7F9rXprLEsYTt6/oOQ+QYjmWw+VrsyhsDI=;
 b=wAQQsDfe0yCtBOzOIcB/VRiFA9V/e+sN6BRKa9g7FNbrBC4jNA8J4rpG8nD/nrJPXZbRa0ydR
 1mGsDw/KnLjDH36apV8gcKQ1PMnK0TVEa8iPMP2ybKGxEkl16Cn0cDW
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX0zhU8zUqtc0U
 Bc+9lNCrNndYEZDCocmtHaLtVt5v39eWK3an4KABvUrYurzA7mWHywRtK8JP+OzZbPJ9FQFJDmO
 K/D84Aouhdm8ch2Fi9ZOCDWBbuKl3ww=
X-Proofpoint-ORIG-GUID: jFn2XwjqMEHFEJ1dT7hkGuqkpidTeCjD
X-Proofpoint-GUID: jFn2XwjqMEHFEJ1dT7hkGuqkpidTeCjD
X-Authority-Analysis: v=2.4 cv=eMWGH3p1 c=1 sm=1 tr=0 ts=6acb8913 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=JGQ9ZE40oQCnb2Pkc9sA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX6bdGatuaASWi
 BzxuQFjzd8DSG3mPgjdk1WlRflRFKKuRx33a/koBn6nrmGlYqNA9L1QUb88odMe3Nu71Knl7LfE
 PbbzGcV+3bG8NqXjnYgZzd1X/lRwbez4DdrelsyDBlQPdbW8SbrOSQ/OOnYcODJ3CVqbt/Uf4jc
 VF+s1RZFgPs6jaIDyh/2+mrzXELo6FVoy21XX5wWnujAPFH2MXFSzFqsiQdtTQzfqAahVSWONoF
 PD5I72STAVPZMXdqF2v5rtkufkxRh+HjksOXHBS1D6/V8nef78y9UbAL6tsUvvfeNQ79obY78OX
 VlNpyV8xpuxtqEb7N0O2Arx0444VSRcBCHEwE9cWdZhrpp2NRLS3R9CX3f4gPFtz6QnugWBpTfP
 w2vsTECuKeF4ZBmzkHUZAUFqpO9Vp8PRohbZhMXQHfMQSVmBluCGeu0Y2EvkQIlCWiYuAWeXDIf
 F4EkfgKjdfVSTP1Ku9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110051

The PPE scheduler resources, such as queues and scheduler nodes, are
assigned per PPE port, followed by one reserved resource entry. IPQ5424 has
fewer PPE ports than IPQ9574, so its reserved resource is located at a
different position. Add the dedicated scheduler resource configuration for
IPQ5424.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 84 ++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index d2bd78853b98..01c92a5459d9 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -814,7 +814,7 @@ static const struct ppe_scheduler_port_config ppe_port_sch_config[] = {
 /* The scheduler resource is applied to each PPE port, The resource
  * includes the unicast & multicast queues, flow nodes and DRR nodes.
  */
-static const struct ppe_port_schedule_resource ppe_scheduler_res[] = {
+static const struct ppe_port_schedule_resource ipq9574_ppe_scheduler_res[] = {
 	{	.ucastq_start	= 0,
 		.ucastq_end	= 63,
 		.mcastq_start	= 256,
@@ -916,6 +916,64 @@ static const struct ppe_port_schedule_resource ppe_scheduler_res[] = {
 	},
 };
 
+static const struct ppe_port_schedule_resource ipq5424_ppe_scheduler_res[] = {
+	{	.ucastq_start	= 0,
+		.ucastq_end	= 63,
+		.mcastq_start	= 256,
+		.mcastq_end	= 271,
+		.flow_id_start	= 0,
+		.flow_id_end	= 0,
+		.l0node_start	= 0,
+		.l0node_end	= 7,
+		.l1node_start	= 0,
+		.l1node_end	= 0,
+	},
+	{	.ucastq_start	= 144,
+		.ucastq_end	= 159,
+		.mcastq_start	= 272,
+		.mcastq_end	= 275,
+		.flow_id_start	= 36,
+		.flow_id_end	= 39,
+		.l0node_start	= 48,
+		.l0node_end	= 63,
+		.l1node_start	= 8,
+		.l1node_end	= 11,
+	},
+	{	.ucastq_start	= 160,
+		.ucastq_end	= 175,
+		.mcastq_start	= 276,
+		.mcastq_end	= 279,
+		.flow_id_start	= 40,
+		.flow_id_end	= 43,
+		.l0node_start	= 64,
+		.l0node_end	= 79,
+		.l1node_start	= 12,
+		.l1node_end	= 15,
+	},
+	{	.ucastq_start	= 176,
+		.ucastq_end	= 191,
+		.mcastq_start	= 280,
+		.mcastq_end	= 283,
+		.flow_id_start	= 44,
+		.flow_id_end	= 47,
+		.l0node_start	= 80,
+		.l0node_end	= 95,
+		.l1node_start	= 16,
+		.l1node_end	= 19,
+	},
+	{	.ucastq_start	= 64,
+		.ucastq_end	= 143,
+		.mcastq_start	= 0,
+		.mcastq_end	= 0,
+		.flow_id_start	= 1,
+		.flow_id_end	= 35,
+		.l0node_start	= 8,
+		.l0node_end	= 47,
+		.l1node_start	= 1,
+		.l1node_end	= 7,
+	},
+};
+
 /* Set the PPE queue level scheduler configuration. */
 static int ppe_scheduler_l0_queue_map_set(struct ppe_device *ppe_dev,
 					  int node_id, int port,
@@ -1153,15 +1211,31 @@ int ppe_port_resource_get(struct ppe_device *ppe_dev, int port,
 			  enum ppe_resource_type type,
 			  int *res_start, int *res_end)
 {
+	const struct ppe_port_schedule_resource *scheduler_res;
 	struct ppe_port_schedule_resource res;
+	unsigned int scheduler_res_len;
+
+	switch (ppe_dev->type) {
+	case IPQ9574_PPE:
+		scheduler_res = ipq9574_ppe_scheduler_res;
+		scheduler_res_len = ARRAY_SIZE(ipq9574_ppe_scheduler_res);
+		break;
+	case IPQ5424_PPE:
+		scheduler_res = ipq5424_ppe_scheduler_res;
+		scheduler_res_len = ARRAY_SIZE(ipq5424_ppe_scheduler_res);
+		break;
+	default:
+		dev_err(ppe_dev->dev, "Invalid PPE type %d\n", ppe_dev->type);
+		return -EINVAL;
+	}
 
-	/* The reserved resource with the maximum port ID of PPE is
-	 * also allowed to be acquired.
+	/* The reserved resource, stored at the last entry of the
+	 * scheduler resource table, is also allowed to be acquired.
 	 */
-	if (port > ppe_dev->num_ports)
+	if (port >= scheduler_res_len)
 		return -EINVAL;
 
-	res = ppe_scheduler_res[port];
+	res = scheduler_res[port];
 	switch (type) {
 	case PPE_RES_UCAST:
 		*res_start = res.ucastq_start;

-- 
2.43.0

