Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014256;
	b=tzQdrAiRsgIxA2lFWr37888KaWA1NBpqDZDGnnX2APaDQzg6Tsll5OhU4OY6zySok/o+
	 TIpLkLxX7J9CuA3760RsY8edsx8yrC3Xry9ZiJngC0RAjLKuPe4sNgdzPmvJZbo3RX3YM
	 ytikPRGx59GEiMfKxaMkh45kfkqZz2cTKWg78G3N4wgeMvvQBqYKn0KE5fexnzZIN2zZ6
	 UQKdpj+mAKg3pawLh9HC/w98bEYgdDyUe2ZbCTasFNyFkdPHNlp2UIXf2RoLc1wLdVcYj
	 /yEMXic9apSq5UnbJc6z+/mUuMO10+3o27OLh6NN6O/ZZAs/cCcwaPJJbnpeueK6dlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014256;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Vy6MWzt+u7Epen91rEvUfbd4N+vYN7gd/DRRZU9dBVo=;
	b=VDUf4QH/J6/TBRBqq3ThTnZBnWv94BYLwOsE04A9djsTl25L2eIWu46YxmeFXKi9gQdJ
	 yXUfoWkiWy8qYhM78BmtsMcbJ6rre6uOHc6dIpjVaC6SQDERvI+SsizsoWjUZ12qUJykk
	 kay6lC1Pzqnej7hua4mt6T2sVfI0Q6c9Ggv1ICqkjkG7/332abJRJFZxUCWDoKvPARj7Z
	 0nhz1SKw5UJp1Cj8lVU5ViIus8wFijgo65/Zj2M9T90JRV7oBVh27HGwxeFM7dJgcdDWf
	 AE+gpN8OlRqluxKX7i0VI+aHJHcqQLyCCbx5/wNFSy7W1/jzEhoGKgHXWQJper5IjtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=npaCX9jt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B5M9QUX0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8760A2605
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15D8760A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=npaCX9jt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B5M9QUX0
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAsm6N2168527
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vy6MWzt+u7Epen91rEvUfbd4N+vYN7gd/DRRZU9dBVo=; b=npaCX9jtYxzYT5Zt
	t7JV3UfqfK/8A2WwX5npM8A8GheMCA+qj+c3P1NesESmYtTssFoxz6b4+uHeBRYB
	MQdKYlRY5jKKRc92oQ3Y+9CoYXD40WPyHnAURMSfEvePs2h6bFQe5ShF1QkSV9bt
	hGD/AP7gXGbyhWeRuATFmp5KoD2WAF6vgKgHU4u/3pxpu8CrfwLHnJAKvdK1lLmp
	z0P+FZXpHNqfy89HCnX/waWyrlQ5SqForeAAnhpT1gfzezJC33TMkqvbzbshzi+9
	guAIn1wCZKyXU5vb/FPwi/Qh7c1sMuHy/x+7u0eqFAk1Djt/gzTvT+nMnBWV6uEI
	7xLAwg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u60j26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so3510186b3a.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014255; x=1793619055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vy6MWzt+u7Epen91rEvUfbd4N+vYN7gd/DRRZU9dBVo=;
        b=B5M9QUX0JGMgRE84M896uv2k6Q/lz0+zdEUMc22BZS0RUFWPl2um7bbjjZfAloBC7T
         ID5B0tpzFouSZFFvx7zdVQTSoanL/x1b2MIARjxBOEpvuD9vE0tAQq1NBWLOhmGsieLz
         q1GbbU1w4YnM3yFPYt0ToFQ+wV3V4KV5rrIOf5QMpKksD5Pt+qX7AjNVC15Yqy5p/KmE
         83AKEHiwkAn6v+lZ/KOql/1l05B1pSxify5pDf0nvHrQcgJH7NkjaDsrA2pn/jBcehWW
         5stxqgQJ0WuVKcpM5RT4XxWjEpDIJc/Hp8qur0R4FFcbGoTPoZlwbcvz12dZBTY9w/UJ
         gOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014255; x=1793619055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vy6MWzt+u7Epen91rEvUfbd4N+vYN7gd/DRRZU9dBVo=;
        b=fmez7aW3wwv35+xf/toIGDAf5jK40ONvntiaEpDhbs8K4I1X0kaIlG2SRPpWV0nT5q
         CEmkhyyrVOgMjlGnY9CsJaewS9gsFJZcf9hSzbLqCEMrdm833AkgdRp9k1eWjgCdjfch
         NQw11PZtftjVzrf+oXC7JXmPrtBEbPcIH5TTjcg8ywEcr09lRV279AgQUjsOtdCITv2g
         xEpqfXyDqoMD33BhlBhX2jc2Cgd9QKJbXafirlsfnsM+YTInYiPXI0x5X2pcKjVzD/vb
         nODLBJGTMv3FGNKss7nukGCK4bydl4FvWrM4GLi0Dv2E9JCCqXj+GvvVpxhT5p04rTWB
         Oy0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzwngd9utMbO6Xvuu03JECa+IeoeR43KR5a3il9UzrxP8rJpZsHt29x96zFw3Ab5B3qbpo7lqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLwKvKCtP/FPuNRafxZBt2jb0R9LH4IxevSoRAEc048zNQiHwh
	NT73QzC0xCLnrIOzbV3HDLaH3JjcGaSsRyMW0HHsKMEmGpRidIgTmDWwrjk4nIVYCRMFAklPtw6
	UbodOhXwZLdHNP46J/3jV2Dypt5vUIrNuMPlgtXjpL8qUNif5NzjAaL7txEs=
X-Gm-Gg: AYBFou1cf29gHCqzHE4X3NjMIcK7QfdghcrHq+wmDiWaLGZmTbXvAHyfNz4cIxjWaqC
	zid5JsgMsI3eBvyBMf3ZwomyxM4hNVtBfUlAUV11BxRgYQDe4soCAl9mKJkebjOIXnstPHFXNjW
	MAmRFWjLCCGi+TII4bs1G/oAvKVt6rI/hnL7T6JdkQ4Fj7x1jN5bG2sxkvxI/6jKnfIyWPXA8H3
	/IRuq7r14WUku+n2DWS1zFwGVLzwcNaaB5UeGZAVb04pV8s9AiUqjLcrzYCh9WLotTK1RQNDLcF
	HH2/n5HsyqGNbvwxwzyLSK9gV9DFkRpfNw3ofDvZqV4cRgY3pJM3W5WibrAwjHk/Scp2vaNzXBh
	Zd4ezMvRNgHiceeP/FtcT4IE=
X-Received: by 2002:a17:90b:2689:b0:3ac:9d26:5532 with SMTP id 98e67ed59e1d1-3ade9a35ef8mr5288324a91.3.1793014254517;
        Mon, 26 Oct 2026 04:30:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2689:b0:3ac:9d26:5532 with SMTP id 98e67ed59e1d1-3ade9a35ef8mr5288290a91.3.1793014254037;
        Mon, 26 Oct 2026 04:30:54 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:30:52 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:59:35 +0530
Subject: [PATCH v2 09/12] arm64: dts: qcom: qcs8300: Add GP M/N clock
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
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-9-ff8e4bc8d567@oss.qualcomm.com>
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
X-Proofpoint-GUID: hr19dGtj7SD3hJwtC6Zp-TORhaS-twOh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfXxVX8iGvHhGyZ
 3kg7bDbxoKmPybndgVMK5lY/5B1owQDoBiFDPX8ecCUDi81qPznl8Wc3NpbngEjXnw0jSV1yXyz
 ghIClPgPC/gGRi+J2FlLkAGfy7QBf0t8xdfVnEYk23UVp2HZbQ4NHYRjYlnGYVf6BGV26K8RNKT
 7RGGgudzUl3HmXY1AQd+bSzIpGfu7VHsQymApupy+EHKM57lHZSZkiXdSdqMn/XJDzGF14DVufI
 Wcy+s1vEFHv1in4MYdmPj/BDTi0JQAE14WhDohWklamR1LJDng26KY9nQftGHDFV+Na1qt88cZv
 BvwK+A5G7B6r7h/duTzRv1Y8lci/D1Pc9M7/PUXvK8UEBQU96cOITEA4NNTQa4/BvXKY4BUZW2d
 MbH+sVpU0+wVXJnneYf+c08UPN+5lwX7PqB/pH8wkJ5/cMir0GE76dvbCBbjqw6fW4pY2suQ9Ac
 WHae24Nryww729eWXZQ==
X-Proofpoint-ORIG-GUID: hr19dGtj7SD3hJwtC6Zp-TORhaS-twOh
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf39ef cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=JIsdQxy8wyWm9aXyvGIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX0Ll5C+CpCb3n
 E+sBWMyuc1RsSS4Lodr+Zf7yYQdI+z7It4tLORiH8KV6iMlVglwpMeks+3/6zPv+A8kqkfhsDak
 GHj47EoSMTNVhzR/vEnnUPZ8cpC6uEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260045

Add the GP M/N clock controller and its pin configuration for QCS8300.
The controller uses the PDM XO4 and AHB clocks from GCC and routes its
output to gpio32.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 35fbee63d4c652005dae9b93bbb8f6a28b48be3b..e122f70eaf20c65df5854e644887ad16da94a7ec 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -4891,6 +4891,20 @@ sdhc_ice: crypto@87c8000 {
 			power-domains = <&rpmhpd RPMHPD_CX>;
 		};
 
+		gp_mn: clock-controller@88d3000 {
+			compatible = "qcom,qcs8300-gp-mnd", "qcom,sc7280-gp-mnd";
+			reg = <0x0 0x088d3000 0x0 0x1000>;
+			clocks = <&gcc GCC_PDM_XO4_CLK>,
+				 <&gcc GCC_PDM_AHB_CLK>;
+			clock-names = "pdm_clk", "ahb_clk";
+			#clock-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&gp_mn_active>;
+			assigned-clocks = <&gcc GCC_PDM_XO4_CLK>;
+			assigned-clock-rates = <4800000>;
+			status = "disabled";
+		};
+
 		usb_1_hsphy: phy@8904000 {
 			compatible = "qcom,qcs8300-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
@@ -6457,6 +6471,13 @@ dp_hot_plug_det: dp-hot-plug-det-state {
 				bias-disable;
 			};
 
+			gp_mn_active: gp-mn-active-state {
+				pins = "gpio32";
+				function = "gp_mn";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			hs0_mi2s_active: hs0-mi2s-active-state {
 				pins = "gpio106", "gpio107", "gpio108", "gpio109";
 				function = "hs0_mi2s";

-- 
2.34.1

