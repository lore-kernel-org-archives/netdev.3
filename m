Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014234;
	b=jVjPgWmRgEm32f8iVaq+Xw+91zEQl9eegI6TWtvitfLHyIdVxJJmGkQhkJjUoYm3dTap
	 09Se4SDZktrSOSzz8m5A1p8Ev1fREsM29v4TX8SoO0JzG48iCNg1l0jg7NlROyOas1+J+
	 I4k9saunE2pFxUo591caAGGiOS0JmO11bERxjmd2okS/WNHqBxajS6piScfMM7HOb+lD6
	 M2dubVlV91Q4b9ePaJDjXzIwCQxQtthrnBAsq80p2O0mPGOIXVHeH8Ruo0Mmm4B2wtyAm
	 PZaw73jYvvv0bQBh6F0DLKpYe8yhHqE95EewJQwqbigNAfyAT6aswxJAIDAm1DiCqYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014234;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=w9vT8yXNFTPu6Ue8rKFPc+BIeRC0NASUSV+4I1ZBNGQ=;
	b=lOkw7mIoWdWXD1KGTUOLekJIzv9gedCX5wtzVsQGB3U0TxXiHovn98lNPPpkmzX9Vs6p
	 4IfeDwqB6TH9X6IPSpd9J7XUf77Xz4ST5DNZia7YDewsQunM1OMSJJgQhayVvaKNWxXNQ
	 yii3ew6Fgu/mOYRXAbUemFDUwimEvWTETbIVjC8afZnd3Pat4+hixvtBxWMbErCJwqG8S
	 P/khagbPJv1qSCoxYSaaCPsMGj9Fd4f8mvAfOpa+4WkwH/27AmBBFzS72aKKjihGW6tqT
	 lpy3DWtLfBhTwXmdzFtaopvktUMgiV8yLK8gb9KqqFSw0FjG9chbUp5YirSu2uSRdDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EO+mXk5L;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eMMY87jC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CB60A2627
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A75CB60A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EO+mXk5L;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eMMY87jC
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAspar2168629
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w9vT8yXNFTPu6Ue8rKFPc+BIeRC0NASUSV+4I1ZBNGQ=; b=EO+mXk5Lz5FLLXjX
	HVQdlKor98Xebdy9/kOV6qz8DgTUBXZmn4uDnosnBovS/QGTQDn7+01mQrUwMYVU
	nt4yRXVLhs44W2ekxGeFWV3ovCC5OFKmdrCpbNgvXJDPzijk9YuE2FBL9B6HJLMN
	jEKLANIe9K35jVivIBkodPUYAZMJE3PfNkE5lH5LWSv+mDa5iaGOSC8euIKMlsDo
	08wnXCgypjjHy4p9Tg6jocXM9ncIUOMsw1oh80v4rOPyq8rRqlcYnu1We39dMa79
	XOQUxBYs2LOE8V4McV0PNIpyy0SYvMlGxNMHtlkVtUsDiEiKrer9jwX/qo9XSrD2
	3vFkGw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u60j0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d5dbso2391488a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014232; x=1793619032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w9vT8yXNFTPu6Ue8rKFPc+BIeRC0NASUSV+4I1ZBNGQ=;
        b=eMMY87jCrNtgkM3/WaR4sxm1TzM1UnWyPzRmMj6CSelRF3vZkGehBCohBpXEjFF8Sv
         YSd3wpXjXyYv3tVyS67w1DQ/k+Tjb51tbWVXIoz0dV5NMRgntxvXJWuvRVW+4gLjLcD5
         JW9P8h9Hd/FFC1qB2a8P4/2RFlSRGjz6MWU5nqFWsjrrIiXRvlXr8kbG3gyKV4sTx2km
         UNsOsOqQvGQxcR8W2ZTwkAddT24jY7DZRB9Mzbxr93P8xXLp04x3dS4jCrv7NMeEs9L1
         gWsWUqXNGOvqy6dW2Kpokth9L1TpNfmDXLxdZRU9uXHzGUjw9DdfzmswGL8qbQ3sUQJR
         ZiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014232; x=1793619032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w9vT8yXNFTPu6Ue8rKFPc+BIeRC0NASUSV+4I1ZBNGQ=;
        b=wfMURACFDDfHtr3jUw6vLnio5gGNSdi5rDHNieziTPtFY8lpPyzMGaR6TDtmyMaziJ
         +YIzyXeZInjog9dqgz1JiI4Lr7+Z/hPAafpGl9gpTsXORbTubfDkIf2LegoZbi1gBchs
         aRa6zaefGADYdZrtQHj53budp38M9vNlNHVP/Ut62RodPw9yDd/4XQnhoZlbDu9mGKBQ
         SqJVJcxEPLcGl4kjB1annQ7+FcQAH5vV98GEpS3WDwo+fV8cDlT9efUH/kP/rO/c/Kn0
         mRnBoVSq7UGm6rP5Iq/nSGEuuOYtLFe2Z08ZFDg8qd0nI51cn1lCCoTErFskOHAdRwBi
         aHig==
X-Forwarded-Encrypted: i=1; AKwUvBxViC9xR1flSmWdbY79vf7EfkMaOFoJz0Wswv6vBSGt5yDeS8k/0+bTdCeoMaBZPaHPuYNqcGk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJu1Y/Fs9SQZlctMPUDObPjBMp/0ZlKLbEETU3meOPOGOP7V+QY
	oRymwch2hg/I6iiVhxR4290XFpOLsZUkgYhkSkkt/jKosK2Y/yVNAwvfMaO9K5/MLM8UblkdL5q
	naF7H78Uw6xH7BKwLCnJ/2LRCbrGeSKJBiqSkvRHt/PQZEoY6SKK3qGowIwc=
X-Gm-Gg: AYBFou1sUJ9pHZ2YjJHxFVukyHbMpQr5rKeHGszM9Y+eyCTosynPDjItmkOFA8hCaLT
	40CAWMsywrLGjIscy9HtPSoXbmGk2wuXLRkoob46Zt4RzHNAbRnh1Hn76f+a8WV3c/btzl6xyBK
	c5yPXlqrAjMAGtModYPHI7lOlauDs89n8uumG286rqa93Y13HdxC2hq8mr5JmX7WKXqWs92DTLl
	f41mIn76RSMq8+jeY/lAozEWxx/xVvzQRsX9uMQkaeX00+rsl459xBXKY7qK7eULB/YB+m1iZ5H
	CScR0FPCqblHhBRliWJVGKwcC9ya9IxcvwmB7/QRPaDY44qHbj591udCJybsF0LxWbPyP1AGuz8
	QrRGnBIS0h9tpBy9h6KS0x5M=
X-Received: by 2002:a17:90b:2686:b0:3ac:9d14:feb2 with SMTP id 98e67ed59e1d1-3adead2e19dmr5437995a91.35.1793014232112;
        Mon, 26 Oct 2026 04:30:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2686:b0:3ac:9d14:feb2 with SMTP id 98e67ed59e1d1-3adead2e19dmr5437971a91.35.1793014231659;
        Mon, 26 Oct 2026 04:30:31 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:30:31 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:59:32 +0530
Subject: [PATCH v2 06/12] pinctrl: qcom: sa8775p: Add gp_mn mux function
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
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-6-ff8e4bc8d567@oss.qualcomm.com>
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: 0CdjBOVUtAgu3-vhBA0noXqkdjksXdL0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX+dCaV0DWkVeA
 NSXqN5OaTqSkSWWb6r4rXIVbTpl1EJ9K7yfuLs6MeJJH/OAUtj1vGANbiO7tuLgnRrGR3qUDDwm
 +2B+1Oq6G+klZ7/vcst6KYHkjFQxSwFxpazXRGsknfbYxrrwRjGXp4nPSJ3pYyl2QGl7BuTo27Y
 m82Rx5lnkc1BhuefpBwvG8iFyoQk5D+VjisIQGzu+s1JEOuWe43+xWtgwsnWQDE2dHcmTmm1XtD
 kspzVcw3e4JDwcsrXCr/GnwZaHDj6ThZ96MRKwwM+qZsvQ/ynNG7mqI7xsZa/bNwAbHGHvmZ2iv
 dUeoH4kEcYyY3Cqmz0TvRnUZ8qTRJDvKQh3WSI8TVLXRbakRixOrjsJ77WY7o5FgssIMbTmxorU
 Z3ONE2rm53+9OPbUkqoRc8Ry7YhGQk55Ym5pNb1+t8q/IzYxDLNfvK6R4mUc+i0TttoHWztidSc
 0op95PsofJDgPn9dBKA==
X-Proofpoint-ORIG-GUID: 0CdjBOVUtAgu3-vhBA0noXqkdjksXdL0
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf39d9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kPUZkI3t5WzYvoQfP0wA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX4cGZNY+kik1B
 wRZTKqtZ1EgKSTJJa1cu1od5A/9kAdhobzqdMyW9rXw2ycZuXKTEIaHWydabWLMPnxzhfrutprM
 wq9uVCQhJ9rAve0leWpBozxItqr55Jw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260045

Add the gp_mn pin mux function on gpio35 of SA8775P. This exposes the
GP M/N divider clock output on the dedicated GPIO pin.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-sa8775p.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sa8775p.c b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
index 5dbaa50cbff008a2605876eb329496d305735700..d299f47a0bd4ab1a0cd0e553ba50f9ec1e035686 100644
--- a/drivers/pinctrl/qcom/pinctrl-sa8775p.c
+++ b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
@@ -480,6 +480,7 @@ enum sa8775p_functions {
 	msm_mux_gcc_gp3,
 	msm_mux_gcc_gp4,
 	msm_mux_gcc_gp5,
+	msm_mux_gp_mn,
 	msm_mux_hs0_mi2s,
 	msm_mux_hs1_mi2s,
 	msm_mux_hs2_mi2s,
@@ -828,6 +829,10 @@ static const char * const gcc_gp5_groups[] = {
 	"gpio34", "gpio42",
 };
 
+static const char * const gp_mn_groups[] = {
+	"gpio35",
+};
+
 static const char * const hs0_mi2s_groups[] = {
 	"gpio114", "gpio115", "gpio116", "gpio117",
 };
@@ -1230,6 +1235,7 @@ static const struct pinfunction sa8775p_functions[] = {
 	MSM_PIN_FUNCTION(gcc_gp3),
 	MSM_PIN_FUNCTION(gcc_gp4),
 	MSM_PIN_FUNCTION(gcc_gp5),
+	MSM_PIN_FUNCTION(gp_mn),
 	MSM_PIN_FUNCTION(hs0_mi2s),
 	MSM_PIN_FUNCTION(hs1_mi2s),
 	MSM_PIN_FUNCTION(hs2_mi2s),
@@ -1361,7 +1367,7 @@ static const struct msm_pingroup sa8775p_groups[] = {
 	[32] = PINGROUP(32, qup0_se4, phase_flag, _, _, _, _, _, _, _),
 	[33] = PINGROUP(33, qup0_se4, gcc_gp4, _, ddr_pxi0, _, _, _, _,	_),
 	[34] = PINGROUP(34, qup0_se4, gcc_gp5, _, ddr_pxi0, _, _, _, _,	_),
-	[35] = PINGROUP(35, qup0_se4, phase_flag, _, _, _, _, _, _, _),
+	[35] = PINGROUP(35, qup0_se4, phase_flag, gp_mn, _, _, _, _, _, _),
 	[36] = PINGROUP(36, qup0_se2, qup0_se5, phase_flag, tgu_ch2, _, _, _, _, _),
 	[37] = PINGROUP(37, qup0_se2, qup0_se5, phase_flag, tgu_ch3, _, _, _, _, _),
 	[38] = PINGROUP(38, qup0_se5, qup0_se2, qdss_cti, phase_flag, tgu_ch4, _, _, _, _),

-- 
2.34.1

