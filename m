Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074821;
	b=4gECjWjf7jG0yXBUURrjrBc/qLJl5vgreDAb9FPdGt5LtCJc56G9X5gR0u6tm0ANV+uZ
	 dmiPXzjbm9XCs4NhOttaXP/I8gO9x/TMAxwnD0LM3eBfgYayJqgEMiAMtfR+TEkJTUjP5
	 yFmOWbY5HtcSJAsPLSbjCBybMLtTRdJxAsacHVKDxYzVzGnHiBlncdjXWEuR9560zF0oS
	 hBJSNCvgQS/DPe0vdp6C87t86yKO4ehgM8l7jguyA5qMUfG71XwIj1xVJP5Vt+odJ124/
	 DtqSkA11AlviRBWhnX2fnd95ociaK7KTOSS1ruZoATUHnXwdpreWxfaeTlEe+EaymFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074821;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2H5Ad90S0fkIwIHF31nqLKj0/QNXL/xbvdffpwYqAhE=;
	b=1eB2nG6Xm8dXiDW/AEbJYBU7o5sQkWkRNBfs6jjY1qMECfqA16JbGuDEnliDD/9H3g33
	 WAHuQIh9K0fPZHM6qtEynUhCW/m8SabeAK+5dJAoNAAvqzukS7DuUI7AlO0Q7JEle4YFO
	 UA4aAPjbVoq4K+Kn3saXMUXtJIXpGItD3mezxn1sRs/DVUdfmf3QTrottL4rrQzwP05Pr
	 zmqi+dTm8qeww5zuDhNjWP5AdUPnY6ZOP6LEJpBWp+FFNtwQlkmKeAWsaNXMVz8Fefb6F
	 D5YGIAWirkKjnRTPws5NScqHo0ix7DS9NSHm7U1399PQ4IswKIIZcoS3kd9FK4/wHoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c+FXOOV4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YlVXrR18;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D6606A337
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 18:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E67D6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c+FXOOV4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YlVXrR18
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A7Ht4aG2893953
	for <netdev@vger.kernel.org>; Sat, 7 Nov 2026 18:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2H5Ad90S0fkIwIHF31nqLKj0/QNXL/xbvdffpwYqAhE=; b=c+FXOOV4P8LCuKF8
	9DYVHgim+w3rFMHfQZByV6EWS4my2MLU79ycnaWLfTibNV4kZP6snIGgMcgficp3
	2OWyTSVCusxJScLN093/538olFGoYQj1QjEd/l9wyJNZeDXwvvD9Mf7RjDLSIEog
	BOMLEMwMPduVZh86DZXVs6GGqa58mKk1YGEIcQGQ6FXRsaxeovfvBgSLktGvDpEi
	hn5rl1xW/uraHscCYLqUYqLh0VcNMyhIc3sOfyd7NHwkx6w4O3r0DZiYbg0qa4Vb
	lm5yn3QXem7VZUx8QLiNYi7J9QRDYaxC5CO1IldcdBRj8N26sLrRQ2nlrt5xmbaX
	lav3Mw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvresb73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 18:07:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-351788121cfso5318005eec.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794074820; x=1794679620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2H5Ad90S0fkIwIHF31nqLKj0/QNXL/xbvdffpwYqAhE=;
        b=YlVXrR18NxkBaSkupYMNuhlH9Tgln//HRUGwg0z8PQTW54gRptnACes8sPbqC1NGn5
         U4Qy9RpyZFuRhUvNORUUX3ZKxHSg3agXbNMF3vtDzaQgPWgNs7Jhfy61PWOjbu1OUX2E
         /+FiPrxOd8nxMu1hvpGAyj4B9Ru7CBNinapIOajlorjdEsUradNfzMPIbWaVgNZSR6KK
         h2fM1moWsOqe0MgfqC4sme0QlI9KhKgs9yzDwmi8wpTBHxt+D2eR3aF5dnPKkA9nCqFK
         tq9Zc7ZT7EAT85Qkhk0nwQ0OzKqApBt63le6x4dX341cimKPsbtH3mZIaVaXyDy1Rjua
         bdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794074820; x=1794679620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2H5Ad90S0fkIwIHF31nqLKj0/QNXL/xbvdffpwYqAhE=;
        b=fD7ra6QAq4SKi4ydAvfE3ueeShSvJQYEfNUDjIaY17XVQWy+EEz3Ri+rOiKzt5Gv5V
         5G11p6wZW0Gj1WMbHZaj4OvT5DbjOqFskU1ujR8SGvoHRJImDwGX2Z4gpDIvWnpnugUo
         LJL1BfoLc/9DkkES5wODzqHt0EOovymkN2iT1eAr1P4ejl9rwOAbGvRpTd1ANkxH3X/y
         OqWT5CpirS5KOF1YmN0kStLmjQXu31MxN9p8UXmdCcACFVjyl4Bu0coRIv2hSG+ieBtv
         Zwll0JIQSdJIcKRFiV0bXsaMBR480ca/iyek1GwnmekFHHbN8bLePY87J9SRgTcJZbQQ
         1CHw==
X-Forwarded-Encrypted: i=1; AL+hErE981eMdKir4wqZN07Rqk2yWkhCFddfu965EbcvJ4pdsL+vmrqKqaPVag4xR87fkTBoybS4m68=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SvsnJqgeA9bux6Njm2XmMd0fUjHnvFQV9XHvocWmKwmAFki4j
	+CvZtzMhLlxA/j6MUxtAmQWdAt2fPvNjVbZy00/pKNvzXTsABLtPnot6PkxuU9gQJUJWpmE+ukx
	W89NRENYBQtXPPGlkx1mUwNvsXvTRRl5V9yZC538+XBbR3oGf5VsA764io4U=
X-Gm-Gg: AYBFou1OOUKhm60+p9fzSC+8YI0Jz/5tZEwmJdG9VOz/diEZXT3VVQHmJlIObzknuZ2
	eRZJe8TSESMXQ0jCiG7BcrN1Fn+MYsnEq35JwX9AdIEogbq6Lu5hQrETsSMwTVjEExnAuG8kbmj
	Er9KCot7ZtQS/wV3+U9jUK0LoKBxh7goGCmlELHM/IYF6gc1SLMevyOO46mpGciAiyZ8WoHd6hK
	2xqdl3OkSG37FmGz9qgrhAFznGVRCsBe8QF6eDUtIrCUH+0sSE+wL00cyMrnxK4Y4h3T1nDeABT
	rejWo3WSWvbGENTQ1sGjZXy/JTPg/7qwTXSRTQbxuFfc7fjdReQSgZKlZFh/yhMn9e1CJ0zJ866
	7fEQJ9xAFSmLDi6e9qT0lcRdErG2Nf355zJN4Q+hDaM5EW4Uou2lrHTAu74qEG4WpkotU0lPI
X-Received: by 2002:a05:7301:71a8:b0:369:ff7d:840 with SMTP id 5a478bee46e88-36f76c138camr9067084eec.21.1794074819355;
        Sat, 07 Nov 2026 10:06:59 -0800 (PST)
X-Received: by 2002:a05:7301:71a8:b0:369:ff7d:840 with SMTP id 5a478bee46e88-36f76c138camr9067032eec.21.1794074818692;
        Sat, 07 Nov 2026 10:06:58 -0800 (PST)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a47esm24710212eec.6.2026.11.07.10.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 10:06:58 -0800 (PST)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Sat, 07 Nov 2026 23:36:36 +0530
Subject: [PATCH 1/2] dt-bindings: clock: qcom: Add I2C and TSC clocks for
 Nord
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
Message-Id: <20261107-gcc_i2c_tsc_support-v1-1-433d02972d7e@oss.qualcomm.com>
References: <20261107-gcc_i2c_tsc_support-v1-0-433d02972d7e@oss.qualcomm.com>
In-Reply-To: <20261107-gcc_i2c_tsc_support-v1-0-433d02972d7e@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA3MiBTYWx0ZWRfX9YcassNEr7Wc
 0x8mlUuu5CfOJ+a3bsFg1VIOTG441mO+zm1RPx/uIbjheiHweIMn4UOGtaZlc5DcZS8zlSzPQxp
 MjG3GIYyuPasjigDIPQrNFFwGdxoyX0=
X-Proofpoint-GUID: tUOqjKsY-03qSjk8cdYYzcec_8nTcl24
X-Authority-Analysis: v=2.4 cv=FrKQbGrq c=1 sm=1 tr=0 ts=6aef68c4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=OfrIayanZ0Hpx6dNCfcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: tUOqjKsY-03qSjk8cdYYzcec_8nTcl24
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA3MiBTYWx0ZWRfX3w5cjNSapQ3h
 uaPzhwRwSL5uuVANtUb0YHUobha8rf60Ocd/se1HIcYzAKqHQdsevq9tyRcWNzwu/3Ei38lTTf7
 E3bXgR4RueRFK2+OHFTvYlW0fkGQB3TnhOjaafk7Q/PLIejcOCp1UjpXK6UhbXyJPAJQZyLrxxO
 cB5aKBjr4MN/UeUgl7ekkljlxTU0QsklaXC/3wsUo/KDHD2+8rTTnw+95Y6woZrbnfvEanOw6PQ
 fpJ1Lv2JXNNH2vjvZHhoPT3UKdbcX9x1askmnrFhugEipynnqm3GUlsvpqwfTulNDoXkU2/p5Do
 MOdh042jWRj2gPtFLqJxFRiDMOvohdjgwHfXsKAL/gcV7OdOw3EAaZweLQcJK5ZRmKT8RWotLbe
 rpU5Ybly2tJiiDA1K+v9Q7kmqXihaWC8gexjJZ1Yws3pA+pHU3XqKzNPuHqe0ThWZTaEV/zhISc
 D4fj3T4hkcJQV5AX1Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070072

Expose the I2C slave and TSC subsystem clock and reset IDs used by
Nord SE GCC in device trees.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 include/dt-bindings/clock/qcom,nord-segcc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,nord-segcc.h b/include/dt-bindings/clock/qcom,nord-segcc.h
index de4539b999850294926854a45db2997043c74f2c..921b216103da703818fae4d4a572a6a5288e1513 100644
--- a/include/dt-bindings/clock/qcom,nord-segcc.h
+++ b/include/dt-bindings/clock/qcom,nord-segcc.h
@@ -86,6 +86,15 @@
 #define SE_GCC_QUPV3_WRAP1_S_AHB_CLK				76
 #define SE_GCC_EMAC0_CNOC_APB_CLK				77
 #define SE_GCC_EMAC1_CNOC_APB_CLK				78
+#define SE_GCC_CNOC_I2C_SLAVE_CLK_SRC				79
+#define SE_GCC_I2C_SLAVE_AHB_CLK				80
+#define SE_GCC_I2C_SLAVE_XO_CLK					81
+#define SE_GCC_I2C_SLAVE_XO_CLK_SRC				82
+#define SE_GCC_GPLL1						83
+#define SE_GCC_TSCSS_AHB_CLK					84
+#define SE_GCC_TSCSS_CLK_SRC					85
+#define SE_GCC_TSCSS_CNTR_CLK					86
+#define SE_GCC_TSCSS_ETU_CLK					87
 
 /* SE_GCC power domains */
 #define SE_GCC_EMAC0_GDSC					0
@@ -96,5 +105,7 @@
 #define SE_GCC_EMAC1_BCR					1
 #define SE_GCC_QUPV3_WRAPPER_0_BCR				2
 #define SE_GCC_QUPV3_WRAPPER_1_BCR				3
+#define SE_GCC_I2C_BCR						4
+#define SE_GCC_TSCSS_BCR					5
 
 #endif

-- 
2.34.1

