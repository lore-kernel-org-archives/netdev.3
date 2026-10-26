Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014278;
	b=DB9kZznmftGgPztR+cLzDSFhvP83BjTf16RSTW1gbXNIDRNrUiMi7OEyso2ExLNvC5Al
	 NFI2aoflgWpWuG4QdcuzjWtn9mYli9qidgbivHcVWmX6+Itg5zBXYFN7DOG1kbfHnw4vJ
	 tTPf707CODe5WuPmtU9/1sn/gFysVoOh3DbNJhDJzX9ZJRUrPWhrqtWJnjkR81/ZIJMov
	 sWUUw+/T4v49FVqsgwB5aGKbg/Z7dw6NNm51wXB+Kwk5Qgh0ClbnEvh+M2vVmCKrDVVFf
	 +CgqrtcvvCsjUDh5Y4xGWz8FlgjIPNE0amr9nolPt9p0dkuekOWIaYh/vilT6mtkjhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014278;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dfWAgnXg4OH5Clvj7K/B5nMB8xGrzGYP7GIzT3Cmmjo=;
	b=PwzhO8JaB1FEk90cEcCZhHmJA1jXqNPhMvKJGqLYbhK2YvR+VD8UMROeRfKNixmuabJU
	 M7GpEaE0Do/yfbvgPQAmikgKR2neK7rnLUXLxFfRyK/EgiU8LmDTnXK7PUS78tARQhDJZ
	 JSkVu6+xuUn1zoh7LjEWpcA0aAJYXd297DcxX49CI/aVc46t1VCKEPvMrnr6d8OG/2s3R
	 v7xJZzs0jVno+iQUrUTOEBoFagFGmoJy/qew5fP2jbObG8Bmu0RdmnsTZIF8z+E4YoPyX
	 cFgP7BRI4YBgX9oQFTjZRXCF/hU1+d6Xwpz61zU4yosL27ZzaiULMq/s41jVaK1GZVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="CfQxc4C/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WkPpEYnF;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242AE60A3812
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 242AE60A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CfQxc4C/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WkPpEYnF
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtFiX4126973
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dfWAgnXg4OH5Clvj7K/B5nMB8xGrzGYP7GIzT3Cmmjo=; b=CfQxc4C/kewcTgE/
	Qv1d7WZrlMrN1mNjVUYktg8rKXaO+MniuiEVjqBweZpG8m5lmPGysCoEkLmNV+xm
	5/8fWVO2hq3iYArAubOuj2NJ4DP8N6zggHTeJPiz564yB4twCoJpxKE3NVqPcSut
	fovHAokjYqlTt2EAyzcoeGufiXS+O4NPGJuop8gZp+Q71K0Vo0JOMIlYqXMKlWTa
	nMDCnFFXK/28dbdEz/nS04MV8NkUiQipL9GMvo03JmqxCryK6+fw654eLK+Ua14u
	uIVniQcEEs/oyCdPKXCyOvUZbBZRUEUB4TrnPL7u0o/niVqVN8EtK8u1DPwx3I39
	m8PjcA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpt5y3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:31:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adcb81f487so4783280a91.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014277; x=1793619077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfWAgnXg4OH5Clvj7K/B5nMB8xGrzGYP7GIzT3Cmmjo=;
        b=WkPpEYnFcFNU7ej5dlx89hAl4uz+8lAS7V8S8D2nQmWY0vARSHfkmsuWkEAArwbN4I
         uw0oH5av1brBVAp6o15XZnaJZ6tDC0JqnXTAyBLtfJq0PBSzdJyA5ZR8xxbe869LXJ8Y
         0coZY/5zr/jLA+iIIsrencUxqFdj92fXTZsZeSf+I6t/6C20fzPd7jO71iYmeX4f7ifh
         xsdV3Feilymx8fXwYH7Cr13jvhH4zHBIYQVM2CH7n77G1aFyfxpdAzTRLP1I3RKXMubo
         ssFvf4klEuqmFlMa0nRCj7mVxA/fOOgAVYQeLqEj9PT+kooZY3r/i//K3X7aNVREEXmr
         eG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014277; x=1793619077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfWAgnXg4OH5Clvj7K/B5nMB8xGrzGYP7GIzT3Cmmjo=;
        b=QCYpDxUXopR+epnkQSsQaVmlYBFN47AAXuu/noMt4SASqG1i7TrMzOMdeOFfBm6/ok
         B3gOKzFY02v945vUD1G5Cm8mPaVh3E/lclCD/44Fifb3bNbVLRkhHRMNOuk/o19wRdbA
         ziw24DzNHNvD2ivmqAzCMyaH3AhpR+BWxRX4G6PIi3cujECGz8EzHtZyXyJNtkwrTRwY
         wh49BXNR2mvUEs9g0Qob8AsqWTB+Vz6OYAe92CqY5EewGHL3M4IMXD/IUMsj76wD9hRv
         V/0y4FDNyjQts81BGQ1UY+m8Z5NJcd69wMQQBmr5YOLaQfslw9ZSFdE/3/E569bNhGFy
         FiBw==
X-Forwarded-Encrypted: i=1; AKwUvBwLxMwUxAZymsLp7HFZu7G/28ElHfsQv91rkYvQsEytB75RjR7xgmI1ToYH1aUh9hYGqFTs34E=@vger.kernel.org
X-Gm-Message-State: AFq9FYI74wFbm3fSd2Xv6a7ahmEac9p2R06Pz2pa0dBNCG5c3k+mshX0
	g3C7yiyVBGgYzDb/kGoRJWZJ97P2n6IhEvZr9ERwMRQcjT34eLwFWZJu2gH0qBEmP31Xsq/ccIU
	+vnwnUUpWPArEg0t6SD5i9xLe0TqZxlu1W2CDBzHxbgGYQoK1Z6Oes4Zjq6w=
X-Gm-Gg: AYBFou3AsSbWG0ZaECD/SYEcs7F+ISDRCjiil0+HUVfhgE8Rc0GaKKr/amGvQ8zTob2
	Trl0ol0a69nX5xTAaEjjCaZOlL2shGGoyqNiK++Epr9X23VsQNa3LHc+p9QLZCPUO6h7WVAxMc0
	bKjoCHPg6CtlVsEY5g0Ie7fi0NpQDF745GzdkM3BOe6rYbAHR+Z+/sdo+WvS3n8KWwR9mvA/X7K
	sDO+6UYPugS8EZ5cKHUb4YgWmUjnEA73/rPa4NzKZ+nJwH58bmcA6mNxOdOn0UkXCihFkDoNB2z
	5ehLrOs6baWHaVZFmqsRFPSpWDEG9za4I3LYUNGac1LxHwGKkMG3th78aqACJeUoWQdcf+OnLAH
	krkFawNEmQgSBNF2kUkP4NSU=
X-Received: by 2002:a17:90b:4d0b:b0:3ab:a3ee:33ad with SMTP id 98e67ed59e1d1-3adeac04b22mr5611289a91.22.1793014276933;
        Mon, 26 Oct 2026 04:31:16 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0b:b0:3ab:a3ee:33ad with SMTP id 98e67ed59e1d1-3adeac04b22mr5611246a91.22.1793014276253;
        Mon, 26 Oct 2026 04:31:16 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:31:15 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:59:38 +0530
Subject: [PATCH v2 12/12] arm64: dts: qcom: qcs615: Add GP M/N clock
 controller
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
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-12-ff8e4bc8d567@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfXxbZHuvgujKob
 /jmtJu2R7EbKYWgqvofDmPJPQEYCGotywA0tm1UtQERJDd5vQu7E1ehcpQvQtYWidJmWNqcb/zZ
 EKzRY9ht6Yz+S+5yWw/ohqv4VsMWxoU=
X-Proofpoint-GUID: qx-vKUU1QnEo7kv6x_2fxlZLPI_rBuoY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfXwSLJckgZ/SN3
 NPoSCa01mOaHVr04sN9XT6V+6JUD4OnXCWK8+DtHeq35K2rHzCld3ERJsrXOGpDbZb9Lk013r2F
 D6dqwhhA5sYaxzSrVI9hO9ydkWiAFK9l4+baxM1EmAR2ninwprkEvIxqfxMRbnf4eQ+Uaym2WFQ
 mf+6N6Ld2CCcmMZRdjDhem3X10uqMg+Fy7kH4Qsp/iUTDhtpge7glJLIfizOrBg25M8oAlGOtcR
 7eFipun+YV/Z7bDsYRxllED9N57mm4+ZEzSgJDSvrRit6BDMvWxi6KqlVU8vis7Z7FczX7LhUKp
 D/OQVXl6ulTBGbiahVgbQAA7CS5yjEcnpxw47iGcz9/6GBSCRqgOnBR59u/TTmzsMb0H8WbT6Vd
 nrc5RAXobvbBOGa7FDlbrI354m3KdZI1xPLG1tqv7rsNJW6JC08PnBhuePYEYknGw9i+66fFTT9
 TwhaMKDFGbPNR077wzA==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf3a05 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Sk_Ya6Pm9egUDeeQrokA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: qx-vKUU1QnEo7kv6x_2fxlZLPI_rBuoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260045

Add the GP M/N clock controller and its pin configuration for QCS615.
The controller uses the PDM XO4 and AHB clocks from GCC and routes its
output to gpio29.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 8ed6f2755705c38796698747dfe7bba1afd1859e..c415e782804ca8c9d09670cb8c8cd2353d796b23 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -1611,6 +1611,13 @@ cam_mclk1_default: cam-mclk1-default-state {
 				bias-disable;
 			};
 
+			gp_mn_active: gp-mn-active-state {
+				pins = "gpio29";
+				function = "gp_mn";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			cam_mclk2_default: cam-mclk2-default-state {
 				pins = "gpio30";
 				function = "cam_mclk";
@@ -4028,6 +4035,20 @@ opp-202000000 {
 			};
 		};
 
+		gp_mn: clock-controller@88d3000 {
+			compatible = "qcom,qcs615-gp-mnd", "qcom,sc7280-gp-mnd";
+			reg = <0x0 0x088d3000 0x0 0x1000>;
+			clocks = <&gcc GCC_PDM_XO4_CLK>,
+				 <&gcc GCC_PDM_AHB_CLK>;
+			clock-names = "pdm_clk", "ahb_clk";
+			#clock-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&gp_mn_active>;
+			assigned-clocks = <&gcc GCC_PDM_XO4_CLK>;
+			assigned-clock-rates = <19200000>;
+			status = "disabled";
+		};
+
 		qspi: spi@88df000 {
 			compatible = "qcom,qcs615-qspi",
 				     "qcom,qspi-v1";

-- 
2.34.1

