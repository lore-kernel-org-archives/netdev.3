Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143971;
	b=mLy/KIenxg0vb3PSaoy+I00J4+GcX6e1oGTs9YKJZGfcoLIMD7VL9JhDaEhINpIrn7cx
	 Zb31qAadoTJTZeBpjsfQD/g+54JAaNFf5ogFuqikXsFyDCfng+6l+t7SjfkiPxe6kXYJl
	 Mq0EkEbt5HXiiB9CnLllcEMKoDZSyt8JphAuf4w4r+f+s8XSLLbqfPuHHJG/be6sUVsRE
	 +VnFwrJ1zXA64lPIvzRhdpa8ezOHd0xku7IokKScVONy67kxY4ELlcGNVPlAL0ODLHrUO
	 PZqhkvcf32Blfurnb4tGUBlrnYS5dHRGvi5EzkrS9zO1TOHyHAPeKlGLQ+KyUyKsYRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143971;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FXe+y/k5WlRUSpbCLSG5IK4BPoly0uOYpoUf4Rjaxf4=;
	b=bNUN/YTRN2ns36mh6tyhpVT1cY6AuRu6rgLFPugar18BCUJEHgmT74plbRS+Jq6dQP71
	 dS1HeMQMF4ujytulGST3USrK+74ojAxeA+TMlGtkmNup1DdOi7OBw6pwKfFZ+D5LxXsQ1
	 9fEqlMGcqdL9CCM627ZVL0vTQPXqQKXTn9OzARfvS8I+DBkdSuK+FlYj44k+IvIE1yJn/
	 JaePalHPJu4jQ3F4+nFIBOUAJVL9OLY2LlxiHU+GaKNNlilJqdGmONIA/obYylQRtN/cy
	 19LV3xV8s6zrURWhEBqqVQronMflb5wMvTNlYK7PE3JvAJsTvNGAtjLRXmU/aDoRUNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lp8FAaoB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gsVS0C9d;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204BE606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 204BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lp8FAaoB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gsVS0C9d
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8Ah5QN285109
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 13:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FXe+y/k5WlRUSpbCLSG5IK4BPoly0uOYpoUf4Rjaxf4=; b=lp8FAaoB9SkKnlU5
	6b9lscm66V7JtydxZcsJ67meybrZr6iDzXdbllf8cV6231qrNwTK6+WqrLQHb7Y+
	EnHh/+4lnMxSwSU+VBWena8DRvxNAdRM8/+KrMWqIu+RZXz7RprmpRcF/vV5/4WD
	pMps3aAMxhRboDy1xj/fgLuWgEeJstqgzUiKUQKzJpCZaUNj46PfUTq/rxXIXlA6
	7dXA08BLlIE0O1R2hbFn7a7kZjn4PIuUpYs4Uzfsl1OHCoRoP+k+iU8bUuyvpOH5
	iuHF5IRucm871I8wL0C9oCNc1gfa5Xd8OUMxOzkAX3Hw4hvcK8dqPsMTEl1/xmfN
	+Ulh6A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw99jsx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:19:30 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so513704c88.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794143970; x=1794748770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXe+y/k5WlRUSpbCLSG5IK4BPoly0uOYpoUf4Rjaxf4=;
        b=gsVS0C9dhvIPkevqFR87eUlwyxlD0CbXTRqLgiE8eoF3tZVmQDuGRn1cy9iYXn7I4q
         wKn4uJrWJDOMJsLvg3OhMzkA0IF/IsP6cA/FFj1rLyBRWZ96ELkAGvOM5McTWNBvsEH0
         LopKZyJpwSiQAM6bAJPsUwgqe0OIvx8/i8G4fgWWXF0Mf7S15n0YFiSqiX8KN/KWEvgc
         R74bnfBcb1h5THK+sqbq/XvOonZlmheFN4cFobKLae+SYvGB/8D/RT14BVSaYVUbBgAU
         6kyuUp+b6QM2V9yIa6IwAtLO9uS/x3lRulv9pyWwP12I8K9D8II/UulWqCE7JN1ab628
         caew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794143970; x=1794748770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FXe+y/k5WlRUSpbCLSG5IK4BPoly0uOYpoUf4Rjaxf4=;
        b=fEjLViju7QveextJNxUMqH3Xk/vPk3lYYQQC/FOquSGyfEJRF17lrbSBRp4Qlr43rx
         M1hVOCxyZMkPohqCIH+Zc4Ph4ogUppmV2m5bleTz2ujVbvRrcoL/3pDDrY2ISnwEdTjg
         cV4zxLnWD1CD9qApQZyLKo6x+dYpVY2GnPJRhXiiB527cAI6g2dZRpioQJFjjS/zm3V/
         w/aDOwWGG9GRHJrHZ0Gv3TnMF9kgi6Vj6qLWsie1fSJYrV8p5IrHYZo3VFRDfslM7H3W
         LHTuyEdxf5dLSvzMBp1gS5NToMRSUavnvp+LByPQdX/jihLi5E2N8sUYEOYFWSi9R3iM
         2hkg==
X-Forwarded-Encrypted: i=1; AL+hErExHvFTuxWOGfaJ13YWNmSF005PyCBsfkULuSrgqi7QP+UZErYD+uNFqleQvSi/PeIUP+jb8m0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9op58lyr1v4FtfnMFA/cJCrkaH3gJ0nejQEhWiNRaC3kXJsEt1
	rH4mdr2La/0NpehME6m4U5iQbxvoM3No+BCAUKPYNRE4IASjAdNRA8RPVm2xBOSwFmcoIkvUWL+
	Jia+C0vKr/W1QMipTWccl46ig7Ut2NKWcTTIa22YVCU+bWRK7AwnRQZRX6I0=
X-Gm-Gg: AYBFou0A61cWVsy4kzAEyiSs980cyMUQwMh6zuXRjyYCf9G/Snh3xkFdJl/ORF8rpLC
	31OQDaljIxzjEnUhnWGvp0ybuHMiqPZIgt7N3yC4yZMZ8XtCXwD0MCam4x0KgG4M++Ut0tP+8gq
	np+GM58qZIuR2F11NX/FtoG0TMYtjFMwqZKvj2D82AbTuW751V3tDjWul3HC2vzWsoodR/2o7nS
	iZ6+CFSXlo9n0Kv7k8wk8/ztpEv6TX9gkYuJLz5eL28t5a+sTPofrRxfRRn+pN7ly0afDdf7kD5
	UIWRfHP0RNok3gUIDtOU0/Qp6IPRdb6CxoLT31KtQOGR9erV2yYila59cgAnpUdxfN60iaHQGnj
	3dTVIvyw9YnKFqI4RXYCA3NrobtkXLfv738rI5ezsI/RSoc63Zs0qBKIdTL1tj71prjRZmMAIjA
	iN580=
X-Received: by 2002:a05:701b:2611:b0:19b:39f4:88c9 with SMTP id a92af1059eb24-1b39fec9030mr1867717c88.10.1794143969476;
        Sun, 08 Nov 2026 05:19:29 -0800 (PST)
X-Received: by 2002:a05:701b:2611:b0:19b:39f4:88c9 with SMTP id a92af1059eb24-1b39fec9030mr1867689c88.10.1794143968780;
        Sun, 08 Nov 2026 05:19:28 -0800 (PST)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm5336980c88.13.2026.11.08.05.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:19:28 -0800 (PST)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Sun, 08 Nov 2026 18:48:30 +0530
Subject: [PATCH v2 09/10] arm64: dts: qcom: shikra: Add support for TSCSS
 node
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-tscss-v2-9-d5f575010427@oss.qualcomm.com>
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
In-Reply-To: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: TEec9jQSES7MRm13Ag_ENohcaWcqyxQi
X-Proofpoint-GUID: TEec9jQSES7MRm13Ag_ENohcaWcqyxQi
X-Authority-Analysis: v=2.4 cv=CMq/zhrD c=1 sm=1 tr=0 ts=6af076e2 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=gfsEk818mMD8xhq9cSEA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfXxh0tlQS47ooJ
 1ZuHZtijHIs4UE3ajcKveG8x0z0hFPkn9mFepDjRukUrIqmBklsS3UDJ3zv/yTw6FFinCcnKuB+
 yn0tkUlMTkwtFd3yA15Ss1s5lHuOo+mqc59h0U9YbaBZ8gB/NBu7xFLjZYuB86c1AA+IGE+zv6X
 P+pE3IDTndXEVCy2dBdpROiRcxrP8jODGsEB/uHWeR3AC4I7a3FY5Rcy6unhZYikNDY2M3JqPXX
 M0hil0/Al41iYQfvF+RDYtxaZXnjV6ZOKyVAPTkBc85XVOUEjholJLhQIhah0TauoFA2RW9tzCq
 aGkkU4VJBfr+6OBJ0ox747V9nWsaPdRKehmNnNXlwhqYqFv62ES1mU5aicyZqtkZwe/wj/cbF9I
 R/EmhEbvV9PRm79DNcrpz5l/+D9QFewKaVuJ1ZrzUkwfsVXS/FkdfU+VrUPxQ++JCJqjji+oDNM
 L1AeCnE5XOKCVvIv75w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX2IVc3CjK3ORu
 GIvUyw0Kh2/S7Pfk3qiBi3mkf54a8XOTms2hgP2elkZIuiDHIdZ72+9ToG1njHonZ1fietm2tYL
 y6ChnVXwVQksIog8AVTCl8bd19ayN/A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080052

Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Shikra
SoCs.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 2623e139196f..09aabbf447e0 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2481,6 +2481,18 @@ compute-cb@6 {
 			};
 		};
 
+		ptp@4b00000 {
+			compatible = "qcom,shikra-tscss", "qcom,nord-tscss";
+			reg = <0x0 0x04b00000 0x0 0x2000>;
+			reg-names = "tsc";
+			clocks = <&gcc GCC_TSCSS_AHB_CLK>,
+				 <&gcc GCC_TSCSS_CNTR_CLK>,
+				 <&gcc GCC_TSCSS_ETU_CLK>;
+			clock-names = "ahb", "cntr", "etu";
+			assigned-clocks = <&gcc GCC_TSCSS_CNTR_CLK>;
+			assigned-clock-rates = <250000000>;
+		};
+
 		usb_2: usb@4c00000 {
 			compatible = "qcom,shikra-dwc3", "qcom,snps-dwc3";
 			reg = <0x0 0x04c00000 0x0 0xfc100>;

-- 
2.34.1

