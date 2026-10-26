Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014248;
	b=brJVx0T00FKwoUABOdKBv/2pWYClW83f9Ms+QiuPHhhntaAVjgSUGZu22nalKygwHNVg
	 EWwAIyDqnaSk1+WaAMK2Dx1J3uu3Ug0lDM8TK00iQgndrb2Di3VNRfc5BMOjxj5fUlNcy
	 yF1+D52F0S8pTsZ2JnsCDeS7b9dSNb1IUXHMGxfkHKX8l1eDwe1otqxoYT3HQQeZ6kzKq
	 DF74arwMEOk4XR1L2oNuJOmm5+yMDm51Ia38ONtRi8lE2TnqTr/7nUXNkraTteewzuzzt
	 waHyEwuEnypyG3grWVf48UKJv4MWaAA9QeWdObD8FWTBil85PKjpcjEXwx3yLZl0BaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014248;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FFG9IQ8VMEFoUJD6bLeQT22wb+k51hz+E5W5jGAN8q8=;
	b=XJc6DQCl2QEuMIHXuDpe3EODByCM4X32VT19kxgoOFV3UsAW5T7hb2ZuJC6PYweAAIk/
	 aQpUPb2YFGFCQHm2rq/hHwQJKuSF4Y2p3hb5MCF77hihH0ml1CdeHwzZrg0+XmQ+wfySZ
	 j61FpLlFJMk2h48GOVUQNhJJMUgDBuQjvoXdfNslK2WdU+/mlZnU6EtgHQ3LCyYSuhouN
	 kChA7EE/8ls0GMXtRbOz57Z03vZ2BYRpQmC1frg3w/Rpqes+PJs63gqFoDLLbaD6Y8qyy
	 NVEKK2QXLlG6YaDfwOMtTHMi6Oj8ijctyMDAh0i1znsNY+Jlhun8sF0766odz6xdiIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iWBIaPc8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PSCrQCB3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069A60A263E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F069A60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iWBIaPc8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PSCrQCB3
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtI163085597
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FFG9IQ8VMEFoUJD6bLeQT22wb+k51hz+E5W5jGAN8q8=; b=iWBIaPc8dS3yeKG2
	4Uwi9SITvqMweKCDEwiqzl86IkjnUjwk8slr8qxPtH2nEfThNvbPWRKDOlD39ppV
	+T4noF8Tb8bv1rbLHQTarkwNe15cekDuUXg3T16wPxCMJB4T/XZ5uQsr9gK84CWG
	uVzCX18j4PDxStz+/4AspT2Sy6ImIdbznR+0Ohw83iqmCuYreDK4cBsYfLLCstKL
	YnYIf/wiMF1ZxyyuFeBioJ8s/b5WFm+bbdRREio/g2lvDB3/zYaJENjOWgisH8ic
	j0sxDlemfAzHNRTHf6aq1wPyAivAdPXkv7/CKWgTCFQnxqwBh/mJt028j/OR4I7t
	FTl8AQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3p4jb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab1e771632so3098364a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014246; x=1793619046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FFG9IQ8VMEFoUJD6bLeQT22wb+k51hz+E5W5jGAN8q8=;
        b=PSCrQCB30bV5MOxoznZNhsTQ/4TGN20wZkjWGTNgd9y9QND+QipGxfNTDzUx/1A93d
         mzmYFKI6i6oRCRNxUUmdfC3XaLqjrL3yDiamZQfZLLDFIZs+nDJRkXuUTVeIrUbeSfMS
         1ZHJuydsQCLtRB9AuObBREorbH0tPVbibw3Gr/seoZFTqt8OG+tm6Ugfd86/BG1ADIDQ
         Qvm+HfoT9o4eE/Bm7qTJfXMRjCI9NFOw9TbscYL6aYCLNgZuJxvl+pnyBwuzBePCoTNs
         +gtAF1qUqPSewPzIipoTSrJQPbYGob8wWRZECnvUPZAkwL45lfrqRBHF94xG1GDM9rka
         J/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014246; x=1793619046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FFG9IQ8VMEFoUJD6bLeQT22wb+k51hz+E5W5jGAN8q8=;
        b=dC5cuXDgrHRfB9zdTSMtFeQkYyyJWYFvIo0n2C0+yN6GTv2UtmnltU7syhHEdMcEVz
         TZbAo/Nw7Lio7IVx0M9372UHNr4j9sRrAKV2RRd2+JkH5EQOV3isbgGLC01zbo75SOm0
         d21aBY85oVVbDrhZeo2si4XcD4MnoD0rDLShFnad0KJnhav29xNjwfP5+k279OZKOVZG
         p5u8zJPdsR3H02DKg0o0EbDbliOnHAYmv3tav02cGdkKKHRGwDREaPN8cLvTKONM/LSH
         X1Klj7BGZ68Mtb4DDgpXmHLEzBZ8ojsAldduuP5Cof9//dCFK/+bhx8n/qMmsDABSlDH
         HLXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZXjpRqznOXEh4YHlYkSuqMDwVE3f0EsBd77hIFuRN/v2+/6SYsV6XVcDrX5j+RV1e7TxrNiM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbr5hAqxgiDHVi0qlUErTMT+o0JfekBlAssSjEgRcwcVWIxIHb
	7KJKTjSNVx92svtGliCWQRs9RkHSnnjQh4IkyG7KGbff4g4fZJf9O67XiBFqQkV1jBahmuQ4mDA
	V82fHwjSkR7k00B8bm3smW+PywPRsghkGdNf1x3AfFj83pIyqHV6YPAY2vbo=
X-Gm-Gg: AYBFou3VAKO0lPlZZx9kAZ+kBwXy9cbCRC133t9RKYTKvvZVDywmq/URm4949lWwrjo
	jwvXs00inw0Rn470IieH27S0Ckr/yOaFGYZTlTMn8V8dLSYaR/PXT713FMYCTYhX/oRuxgO4D57
	PhRB1o0yXNdfnsZ0HYXS5I0GMyvn+aZJeuHNY2wTYTw8R9ugTsv07WtoXkSkHHO6yePh9/C8unv
	8rEuU2DeFLUjlKQIwdxhvkkeR/AGB5eLC3w7XMstNeeZeAnWgti44qpD33Cd2VUpcy+6f0ZDKB0
	YrhI3KAiRh61sXMq2dyWcCzsnfhvQ0r1TwrzoXbNkfvbCvlzsNO7coWEIbjWJBP2d9EfhDessNM
	Lsxbr0FX3Vm+KJL8zaxpnw/g=
X-Received: by 2002:a17:90b:6c8:b0:3ad:ba54:c3d6 with SMTP id 98e67ed59e1d1-3adeb3aa756mr3577924a91.1.1793014246484;
        Mon, 26 Oct 2026 04:30:46 -0700 (PDT)
X-Received: by 2002:a17:90b:6c8:b0:3ad:ba54:c3d6 with SMTP id 98e67ed59e1d1-3adeb3aa756mr3577891a91.1.1793014245696;
        Mon, 26 Oct 2026 04:30:45 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:30:45 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:59:34 +0530
Subject: [PATCH v2 08/12] pinctrl: qcom: qcs615: Add gp_mn mux function
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
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-8-ff8e4bc8d567@oss.qualcomm.com>
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
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: oAxN6F4Dnq5mcVnAsHLgWVsW8Hhqk2iJ
X-Proofpoint-ORIG-GUID: oAxN6F4Dnq5mcVnAsHLgWVsW8Hhqk2iJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfXzpxAC00fChuc
 YyjMWI5YdXbxeYT832wOGA1p/pE6+u9p4fK2iB4gj2Gh79c0E6xwqgS0qK3ylFoeQanmVUktM/q
 29Wru8NmI8mSAcjTtSxosP4Jt8oXBbo=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adf39e7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=lqpqssICSlazahQHq3gA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX9wuCoArv2lS7
 WqaMgSFtALG+0r8tMKsZVZS3jkt7oFQWiDXPFQ5F8aDDWxNUXGQRT04DDidmAC6E2LSKM10y9uP
 doyme07ZDYB4BBAIyE18OcVqPWVgFK8CDNMo5yMgqz2Co2s32LtlfLlj3cf2V+jms1Al0sqYQ9X
 B3ZEYD1nd3uDbzIMt2tq90sjp+3RpOK50UxPhtlHLaPPOjErXwoCktspr37M2ow/2rFEjV4la3f
 OdhHVOkUTF6DaWB0WH3kN69azua96fClK22YJgRCsS4/1rFwn9cuL3bFN+3NQtRdEU2WDV30SD6
 PCYW93p5JvmgwVVgGjCHp6hYlmSu8ZmLFBUm6HNOohg1fOsqhPaV2kECOJ/YJFaQ41DMkWpdcpb
 0jvxsrVVNrIAZgztcVvS9DNahZH1iQ9tJwwEysSDeKnGZhWBVauxR0KGqwUD38fRbMLSzEpd0+g
 4koEj/6vDcgX0fd7VQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260045

Add the gp_mn pin mux function on gpio29 of QCS615. This exposes the
GP M/N divider clock output on the dedicated GPIO pin.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-qcs615.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcs615.c b/drivers/pinctrl/qcom/pinctrl-qcs615.c
index 0e7df184122b5b94756a233a009ec0dd3675816f..169323635d39a7c3441560feb002e9e03a577515 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs615.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs615.c
@@ -404,6 +404,7 @@ enum qcs615_functions {
 	msm_mux_emac_phy_intr,
 	msm_mux_forced_usb,
 	msm_mux_gcc_gp,
+	msm_mux_gp_mn,
 	msm_mux_gp_pdm,
 	msm_mux_gps_tx,
 	msm_mux_hs0_mi2s,
@@ -581,6 +582,10 @@ static const char *const gcc_gp_groups[] = {
 	"gpio59", "gpio78",
 };
 
+static const char *const gp_mn_groups[] = {
+	"gpio29",
+};
+
 static const char *const gp_pdm_groups[] = {
 	"gpio8", "gpio54", "gpio63", "gpio66",
 	"gpio79", "gpio95",
@@ -840,6 +845,7 @@ static const struct pinfunction qcs615_functions[] = {
 	MSM_PIN_FUNCTION(emac_phy_intr),
 	MSM_PIN_FUNCTION(forced_usb),
 	MSM_PIN_FUNCTION(gcc_gp),
+	MSM_PIN_FUNCTION(gp_mn),
 	MSM_PIN_FUNCTION(gp_pdm),
 	MSM_PIN_FUNCTION(gps_tx),
 	MSM_PIN_FUNCTION(hs0_mi2s),
@@ -929,7 +935,7 @@ static const struct msm_pingroup qcs615_groups[] = {
 	[26] = PINGROUP(26, EAST, cci_async, hs1_mi2s, jitter_bist, _, _, _, _, _, _),
 	[27] = PINGROUP(27, EAST, hs1_mi2s, pll_bist, _, _, _, _, _, _, _),
 	[28] = PINGROUP(28, EAST, cam_mclk, agera_pll, qdss_gpio, _, _, _, _, _, _),
-	[29] = PINGROUP(29, EAST, cam_mclk, _, qdss_gpio, atest_tsens, _, _, _, _, _),
+	[29] = PINGROUP(29, EAST, cam_mclk, gp_mn, qdss_gpio, atest_tsens, _, _, _, _, _),
 	[30] = PINGROUP(30, EAST, cam_mclk, qdss_gpio, _, _, _, _, _, _, _),
 	[31] = PINGROUP(31, EAST, cam_mclk, _, qdss_gpio, _, _, _, _, _, _),
 	[32] = PINGROUP(32, EAST, cci_i2c, _, qdss_gpio, _, _, _, _, _, _),

-- 
2.34.1

