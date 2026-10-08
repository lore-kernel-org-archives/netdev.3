Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382814DBD9B
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471128; cv=none; b=UsoXU+BC10V2xb7XUiUIVgdcl5SchXwvdqFKowLecYNv+kNib2RXBcBBlW2KHoG8faCfYbY0tgwfFtbrYgvJ9jkGeU4yFUesgwvnosaARTKcbFbJFUEFm6U+sldMVOJ9DEEVPsMFrbVfrRmuMipsKdVQEXxuZhvhA0b9R7qIphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471128; c=relaxed/simple;
	bh=yo2wT2iDk6e10sLNY82zTxuUGNMJIU99i6T65VwR8HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jwck+ntmLSDxZhDaKcayvqX29wfB07SRKv7Je5yDevAcHG5baUAPBGQuwDZGaZl+IjpJK2Wm7QinbkVmDn2wXTwK1UR7w4/LtomW5k28KctZ68i1WjhZCfrbDFjX+VSrdrQe/KOJO28cnn7nWQyVoKYHf5vakV8e2ZApJD9iZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RJ3Cgr4V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VlK4Gge+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJ3Cgr4V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VlK4Gge+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVq1O3517900
	for <netdev@vger.kernel.org>; Thu, 8 Oct 2026 14:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wNkG3w1CtEj85sKzT6ezhw7fcrc9H/luVeYYfwa7dwg=; b=RJ3Cgr4VbK5qWRK0
	2yPrlEDDBGmorvdZbqblp/RW5m3xRRhi97wxnyM7Vc8aq+rGR7T32kABSY5OgSJJ
	Gl+eBLUb6EHTHnGh+uCBoD2MX+snfGsARjieRlCisJUPMJ9cxWah8qNTGG0CncpP
	XN9/IUax1PqrxNghRnaJOXHMDaGJ6LAakViFh3UxsRxhxbYM9Bep6Bxbh8pRnWRA
	DenmRfp6gEfJDscIOJBFHppu5lyxLIV5IkHti1rDIc/pcBIdPUn31knC66o6ac3P
	DDmL6QFVQiEAkUyY558Q+dUUTP1w2pgrh9p8Hh1eqfCYqY2DeaCGmYP/DazLGlHa
	UQbVuA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe83asg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:51:55 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-895241d7405so75863967b3.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791471115; x=1792075915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNkG3w1CtEj85sKzT6ezhw7fcrc9H/luVeYYfwa7dwg=;
        b=VlK4Gge+qDUDcLrYIFoS7JlPqb6Ea+Exhu9yc8y8Bv2KbRHmAMPZEL8dOnt0gRYxHk
         GKPPggTUw6oQTG6np2w+aurWcg+/F1DOqlXvnqs1vae7jEbpHazafgO/OhZQKvlEtWiQ
         UitIfiFN1K87qVmLBiHwfQw9yzAWJqgVdESGciwr5md/ixqnIDlQCR1gFURFaPk9igaL
         /RjGCI4NzgPFM4ze7qEdVft55pFIwYJXDfvxAG+5Jm4CZ3v9cUuU0Df6OsCPUFLHZojV
         LvYLhWfhSQqthBvGVkHw2gFfUkiBtVHoTk16M4rmVGw6Slv4JObquCsCnmOigYAyog+q
         OlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471115; x=1792075915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNkG3w1CtEj85sKzT6ezhw7fcrc9H/luVeYYfwa7dwg=;
        b=LL5QAqHImRfES9LbZc4wtaT2m8Bigp91tGzR2SeDo3wvr0jkzb0DuAAFiinKIGr/y1
         9O2w/C38AcoN0POeUzfViyblIdxcPVfaMoaJbGh99ZK1gT7iqotHJbfVV5tsW9d04ujr
         syx6C5TnprjGaDl164CoTcvWRGlkppCDg11c8vpMuOO+rsjaeudCZqFy3RKpG1gdLEEx
         J67a/NRfOxQRWMmyTq+LwABSh8hF49uTXMa2ULm/Zd0n/qw1PCuZMUc2Og9594viO6J8
         bC10BaAC44uWnOK/urKtfKv2fylbE56+yTk1PoQ3njjeFuLfQz/BeWUEoIs+puOa2A4h
         8t7Q==
X-Gm-Message-State: AFq9FYLZmY/txs/QS+BBCG8ICkrNtre9OF75dYgoJ71ks0fwgQ91l+66
	9ecsdARARbG+Uk/yIL3BeVKgG7xJ3Mds/ZxBQl2jRSoiyXlgKcfTlgLtqUUzImcyFNctY5b//w3
	wWIO4ZPQmWjg5dBcZD60XWTPItipIJ5dBUoOxQ2v6xKLZ2wGA+HOG4CoOGBQ=
X-Gm-Gg: AYBFou1LmvNdx8vtMCR8VCW7u95EelR/ROm9A5qQji+r893yFoqCb7aeBSvUm6n0CcE
	BScyM92atmZp3YpCNu9lGOW5crBaE/gw2VoA/4GzRDeJQxoCdkS9fszI+zbyrefe5cdoMU3o/3X
	rHGAVaBSsbnDQd3pwRKYyKLiFWUTqe1Q66sQMOIsNogTwP9NPyxw/0eWkoi74L1l82zBDiFDik9
	UiR6pw48Q/ytGf+DYnAGP06HpSP4B3o2ttb8P602ZxUee8X6EvvUAWrzGQc62+zSiKlkKA8oCyV
	rfhiGfoWLYt18eObExjKFE0ZKKBZB8J501uJH7c9a8pjmGg67gATi4XYSbktXA776an0IPOM+Ay
	F4jWoH0VRTMXWhwqbnMsTd1mDrjgrxbBZJUleWztlEQE=
X-Received: by 2002:a05:690c:6b01:b0:8ab:43f7:f052 with SMTP id 00721157ae682-8b05b14f3ecmr37153227b3.68.1791471115145;
        Thu, 08 Oct 2026 07:51:55 -0700 (PDT)
X-Received: by 2002:a05:690c:6b01:b0:8ab:43f7:f052 with SMTP id 00721157ae682-8b05b14f3ecmr37153067b3.68.1791471114524;
        Thu, 08 Oct 2026 07:51:54 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05ab62607sm20903407b3.22.2026.10.08.07.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:51:53 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 07:51:39 -0700
Subject: [PATCH net-next 07/11] net: ethernet: qualcomm: ppe: Add IPQ5424
 QM configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-qcom_ipq5424_ppe-v1-7-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791471094; l=2494;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=yo2wT2iDk6e10sLNY82zTxuUGNMJIU99i6T65VwR8HY=;
 b=zMFGULV+7xdX0Ow63GUf7TfLZPDSXZ5+oEoOI78/8/AVBxpjiCKvxvL9G7sjaxxggkQJDwZH5
 tjaSuTsbx5LC7bwghOs1qGoA/V0A+yVBpvQOOv9aN7/x1h9F00PN4cb
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1OSBTYWx0ZWRfX/eaXaMghaoKS
 Vn4j2j8bV+HyRearx2FQx6Hb3HbWfzQeUPVpTBYRAdbmPeow0IgmjuIx59q/x7V3HrXqiGG9G9R
 6lwrujyBHCwm8gxnBdR9RAv/7D1GZk4rBrnTJJY59cDPxij6ZTsLxkURwywAkZDTk/PStK+NnH9
 qXp2nh1d4sHmMkqVyOf07XRjZqXteGJyNgteUOM5eSrcpx139siE9U6pkUWgo7kkwtttNAaUI4W
 R8l1DCfDpJyVI6HnoCVliTOYLHoZmT1FtsJawFlhYPp/VMnYdRyLYLHzG8o+ETpAlnI8K46JNW0
 xxyX/bap0gaazO0nbV6y70Qbn505QSYg2fnzTIn0rbLlWlffQsLyI+jOuXYynmKKpZTYiSL+u+h
 nw1amt0cYVfau9P70VMPEcxOA82XG5fMs4O7H2MyphudFDO8pRshWhN27sP+tjqo0Kmc5FP0pDL
 ZWYUg6IAp5Igwtg4esw==
X-Proofpoint-GUID: mVhaauupNUKHwO3WPbOD43DojmTPDmPx
X-Proofpoint-ORIG-GUID: mVhaauupNUKHwO3WPbOD43DojmTPDmPx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1OSBTYWx0ZWRfX/+3llKP1RhA+
 svg5hh/OO0fuEI2ag1SqtJi3LNUMqxVOQ2MlX9q8/fs4CrpqXOB3hEL5riL/fh1OL5lZAGM/hkE
 bLTzOX8MXn8JC1iI9EC12hsWNz43wAU=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac7ae0b cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=fL1B1hGL9xWiboNnwmEA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080059

Multicast queues are dedicated per PPE port. IPQ5424 has only 3 physical
PPE ports, versus IPQ9574's 6 PPE ports, so multicast queues 284 to 299 are
not available on IPQ5424, and 2010 buffers are assigned to the shared
group0 buffer pool, instead of IPQ9574's 2000.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index 3afa57119323..dec8eed77253 100644
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
@@ -1547,6 +1578,11 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
 		queue_cfg = ipq9574_ppe_qm_queue_config;
 		queue_cfg_count = ARRAY_SIZE(ipq9574_ppe_qm_queue_config);
 		break;
+	case IPQ5424_PPE:
+		group_buffer_cfg = ipq5424_ppe_qm_group_config;
+		queue_cfg = ipq5424_ppe_qm_queue_config;
+		queue_cfg_count = ARRAY_SIZE(ipq5424_ppe_qm_queue_config);
+		break;
 	default:
 		dev_err(ppe_dev->dev, "Invalid PPE type %d\n", ppe_dev->type);
 		return -EINVAL;

-- 
2.43.0

