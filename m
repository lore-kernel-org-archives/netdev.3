Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014227;
	b=qEahKl5ERwt2SckACcKgga3oSPtnUJQhO84afGp5CHmLUbIqulMTqZyfrYtiNTVqby1A
	 q12T8lx/UwIOBbVzn/8dEoY0a22cnXY6lphaNtC5z2NTz7dMSDK+JS2JkX1lM++3nHXBh
	 qQbbpe7xWH/KWHQl8+pvU7KpRdWzl7Pqbdo7vNNGqXm7hYR1j3bz9ODRlj+RnRZeHODlc
	 hbVR5pdX0IJuZL/Gavw90QS0od+LFrg6gsPEsXX2+ka/kDCteadUMhtOymD8r0SRuWVF7
	 aYpS4Rn5r+aNSrzn1+eeaZ6gbP+i6+eujNxpc/FV86+0z+Q9RSIokNvIDaQY81Xae1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014227;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1ESMzVuIUOfsBOdDJaEmGRNu6MjhYUn9ZY/PRW8TBJU=;
	b=lEmE3e9kb4mOjAMBsgB9qGMsbApbBVxCNOBwCvY5UMnWOYBkXT+U7mWTaWxm4TvA5lXs
	 wEaQ0rYEhqi8mT/XMQPotj7Z6pz6D+d0gdWhDuCMLye4CP/jrmdPWiZB5UsrcVxx1rQTA
	 mbgk+mAdOgVyxYf+LbQwIXYSiU3ywBuGd1w5Sy6rAi8z/RKuUJ441F7tGiYtzo/ZIgFT8
	 4K4bHdy8JZEg9BkhcifG4HtuWS/KGisF2FgIrtkYdqNIsnCXlCkKsW5j9epWdq9SEzRWk
	 R5Ndy5FZav2vfIcVFXWFTW8TuU6Gj4bMZCWgdAz/9K7LLqIdcXXKj+Fd4QkIaox/hnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o3h9M8bN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X+kgutvj;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D160A261B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D50D160A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o3h9M8bN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X+kgutvj
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAt7hb4126433
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ESMzVuIUOfsBOdDJaEmGRNu6MjhYUn9ZY/PRW8TBJU=; b=o3h9M8bNlWiM2sHT
	yMHVFZfz9+A2H56i90OElQKT7rXlSywlIZOK945W6NTvY/wxqxZW1g/S3fc18STh
	FN0O0tTgTfHqs8bYteDZqzxiH1QIB57my9uDSNLLUz1zX5twUfA3dA832TiADhlZ
	fk5tMAZmPJ7s1csIao3F+JgbwUgF3JRqFImX95uPHcOfu5sCFMvhFpY3bLRlzDyJ
	3oW1WTpn6voaV95CESMR4YNtw5jhjg2oQJjU0K2O90jNBBsEZ6QK1k/jNg8Vu/1K
	PYJlwHXK8nAYuONG5PtMzYEc9xBydvzzhbeOYauKpM+k6RP7OL9XoBGiBSE8VffQ
	IEl9qg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpt5v2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad91787a1aso2032785a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014225; x=1793619025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ESMzVuIUOfsBOdDJaEmGRNu6MjhYUn9ZY/PRW8TBJU=;
        b=X+kgutvjeWstrz3xdKP+4lUxQ2VkTjJtveTMDuddCZ8BR3zaBjh6HjSzOy80hJYYiG
         mesgjlDZVkEtKCiAkIgtjKAe1Dhx2v8ShhKE3W7CbkWt07Q+csnQ5vtvg8N1iIG+NOEx
         E5D5rfO0k/AWdIdjlAjtBG2VhcyvaPTlggNUeNH2mCG4sgvOA4Act1WBp/YUqY/585lV
         qKYQbPCHUZ0euBNhrli9Mc3h3uqmqNlCY67uFnenJGazi3uVDI46kWy6FM0PpinVN+LY
         DlAXQu3UoaPDTlc3IRvdxOTPAKZSm6q0MPvyzwm//RtiWPZsyFP7R31sBk9MePIGfhgg
         Nqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014225; x=1793619025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ESMzVuIUOfsBOdDJaEmGRNu6MjhYUn9ZY/PRW8TBJU=;
        b=J+UK29FymXtzbHWn5iKsa3aO7K5xe39E/ByYOC+XosBCl1RrjN6aPsVuNfzTYOqL/F
         jFkBQuom5owNkDH/0w9BmbOvc8m9WmImoh8llOD5eoVBRCTsHZa+8D96miI6J8SXGY1t
         l3YouF4qTKbXKbcu3OtzCm1Mz7gAbe+QVsP8C/BcOgXf9gxLAWl3z4s+GZa2hnp+gWWt
         Du4torELX2+MQQkOaSdRbKPOqlDTQzFVlVp/EcnTFwQ7mY+uHjPQBJv1KGjMbQwJT6pI
         4EXBpenCvsQZTvydGrp9XOn4fxNJP+hJdZ505kpUo0nKZMCKgHMK+sL9HfUDubG45v0B
         kX7Q==
X-Forwarded-Encrypted: i=1; AKwUvBy6FbIrnxB25SiY5YZiziICT/S1JoubbiViQzSyAwZUjEYe0i4cKaPhijGVx8pCXhc98r/5tSE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiSobhJbSZj5/2aSiZmta/tNrSh9eEKFydv3KCeEEO0GGLOsrL
	M3ctgxCM+2+0pe4mFhms9+Kk0s2XgjkPfFomRax1tnWyEr8NokTkm9fITFL4CuSDmioPDDs7X/V
	6lTiHfKggsaUHaZlnCj/wvGSnaMQd7nwcZxngla/RyJc7iyeZCmQq89SRidw=
X-Gm-Gg: AYBFou28s6Hr8qA2wAXDgA8ff4fuT+pYO7S8E+qvQUsNyNhNTtfAERQSw19XyIK2+EU
	L/bCIl/auwIrm3nMKAZPtY1s10OGk253d2F9KUZuo7Rn/+3poreJ4I6wwT077EusW/V+MXqH8/S
	pLJUh6MZZjUDuvQ7tv/knJzhcTJSuHGiM+MtjBgQtRlhhKJxSjWE8nHm0FMWktIIvN7gjjqxyLn
	ELNw62D97Z2lpgVP4eeVkJm3ZWbM5F2mCx5ZqgQxhCe5BCtYlfFUkbFt6y4hVBXVqPLhMJ9jU1f
	BBRYVq65QC5ljRLg1tvCMD+HsQ1s2v1FzFP8V33daBcaRPo38dfCj95rc5MZk5JPKkhtNAv/qD6
	IEyCszw3uD2zB4JwSz3lq0rk=
X-Received: by 2002:a17:90b:3904:b0:3ad:9ecf:2b88 with SMTP id 98e67ed59e1d1-3adeaae5caemr5476467a91.19.1793014225145;
        Mon, 26 Oct 2026 04:30:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3904:b0:3ad:9ecf:2b88 with SMTP id 98e67ed59e1d1-3adeaae5caemr5476426a91.19.1793014224693;
        Mon, 26 Oct 2026 04:30:24 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:30:24 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:59:31 +0530
Subject: [PATCH v2 05/12] pinctrl: qcom: qcs8300: Add gp_mn mux function
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
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-5-ff8e4bc8d567@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX7HrBoq1JGXra
 z9sHMU4Mw34K/0TYyYGfhjnot2Qfw2iI0HnpWSsheeJ1s93cstlit/x12Xpuinh+0E36MheCFpy
 Dcf1yNj5xWPp2lQyorzk+sBfHLsHVb4=
X-Proofpoint-GUID: Wm3qGrhY0dV7McZI21VSKP3yJGShuuAk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX83BC2SBjuWRh
 m3z5UeTXeVqekGV9bJcK94uE/I0uVgAw2URtw5dLZ+CxO14+6hukOchnSCjUcmErFrIzYzHL0Lr
 C39C3tgVedF3u+4/3/KOWMzsk8+aDg79PPXT3mJeypAVk/YRwZ4qwg4aDK0fBlmjhFosAeEGv+D
 LRanN2toRyAs6dfl8HkafQtU3LXSD5EfS3A94K5NlyjdbftNwgdmyWABKytgU+MH6P/F+m/tSpT
 7VPQixXJ1ce8boLpq9ajNj1bhSEVBC+rjWlfHcOlozYR/fd8nLcgRztlbykyWD1OqgttwHEh1WF
 m7d0ZV0LN0+VPVcIgj+ihIvM1Hc9fEmAVcyzHuUcPti83GbuSYNYIseXzyj3hcmm3UAADxWdVJk
 +KQQ28awrVQD9WXqgBv3oVYKfW1FV+otT6rVY0hgwnK+qYYrIgT7mMgz7UAaNhIGqRaB662d/lj
 fXr0nR/YNeoG6w2cEig==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf39d1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=kPUZkI3t5WzYvoQfP0wA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: Wm3qGrhY0dV7McZI21VSKP3yJGShuuAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260045

Add the gp_mn pin mux function on gpio32 of QCS8300. This exposes the
GP M/N divider clock output on the dedicated GPIO pin.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-qcs8300.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcs8300.c b/drivers/pinctrl/qcom/pinctrl-qcs8300.c
index fec86818c51188a0949e268382fb0c5de3f66f1a..349369fcdf18342b27067b91414eacbe378224e7 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs8300.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs8300.c
@@ -424,6 +424,7 @@ enum qcs8300_functions {
 	msm_mux_gcc_gp3,
 	msm_mux_gcc_gp4,
 	msm_mux_gcc_gp5,
+	msm_mux_gp_mn,
 	msm_mux_hs0_mi2s,
 	msm_mux_hs1_mi2s,
 	msm_mux_hs2_mi2s,
@@ -651,6 +652,10 @@ static const char *const gcc_gp5_groups[] = {
 	"gpio76", "gpio77",
 };
 
+static const char *const gp_mn_groups[] = {
+	"gpio32",
+};
+
 static const char * const hs0_mi2s_groups[] = {
 	"gpio106", "gpio107", "gpio108", "gpio109",
 };
@@ -955,6 +960,7 @@ static const struct pinfunction qcs8300_functions[] = {
 	MSM_PIN_FUNCTION(gcc_gp3),
 	MSM_PIN_FUNCTION(gcc_gp4),
 	MSM_PIN_FUNCTION(gcc_gp5),
+	MSM_PIN_FUNCTION(gp_mn),
 	MSM_PIN_FUNCTION(hs0_mi2s),
 	MSM_PIN_FUNCTION(hs1_mi2s),
 	MSM_PIN_FUNCTION(hs2_mi2s),
@@ -1062,7 +1068,8 @@ static const struct msm_pingroup qcs8300_groups[] = {
 	[30] = PINGROUP(30, qup0_se4, cci_i2c_scl, cci_async, emac0_ptp_pps,
 			tgu_ch3, _, _, _, _, _, _),
 	[31] = PINGROUP(31, qup0_se4, cci_i2c_sda, cci_async, emac0_ptp_aux, _, _, _, _, _, _, _),
-	[32] = PINGROUP(32, qup0_se4, cci_i2c_scl, emac0_ptp_aux, mdp_vsync, _, _, _, _, _, _, _),
+	[32] = PINGROUP(32, qup0_se4, cci_i2c_scl, emac0_ptp_aux, mdp_vsync, gp_mn, _, _, _, _,
+			_, _),
 	[33] = PINGROUP(33, qup0_se2, qdss_gpio, _, _, _, _, _, _, _, _, _),
 	[34] = PINGROUP(34, qup0_se2, qdss_gpio, _, _, _, _, _, _, _, _, _),
 	[35] = PINGROUP(35, qup0_se2, gcc_gp1, _, _, _, _, _, _, _, _, _),

-- 
2.34.1

