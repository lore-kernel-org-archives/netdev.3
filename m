Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014265;
	b=rZPZWj9OuA+Og+UYkTQ8jySQK0DIqNY/nqBPJDF1PFNkWEC1d1uruxYBI+WuNorBY/IN
	 EeWabkjLkrKaUxzBvlNWKg9wCDxGEPyqgpRZyU4ivQaLFw0FdZ1Jd2JB7vkdvkZfJSyh7
	 vdosLq2ZFNCZ2xJWXt/JY5LAi1/a5x5qmztT1HmiJh3XvG8OAC2gKT76qXPRE7yyNpyZN
	 K/qTlX2IZ1ZTNVDKK4O67euf404/BAoXohP1EzhRvEINSDQy31VysMpt/duNd5pdM2uxf
	 oBsmyGXZfI72JZFY/EdfWq6GhyyE2SUZYKo4nuojaTyOkTMWk0euSF4pF6b1/HYcLRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014265;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1u7BOZ4HXoiDpqQfE+eys0BaXB4J5QVKelBVG2AU3rk=;
	b=R4FUKnuGig26LF0MztN+qgsxACB6ayy/Igv9GZwBZc3ovdosb1PNhv4q/J95j183hIYW
	 fCaAamvGpYoRVRpN0n9W9Ktm3RBlT+oVkASZm3G05euj5grYhLd1clvPUaW3o5jTB2PkU
	 hGt+QlZkDehvoAg1hO1ZdJiV6GRddw+IVomeTnInnr2t2NNQHr+uRyrAWyPUkxaxTv/JI
	 nJZHorkUne2jd+QrVDXzxtyWrFrENopgElxktDIIvFnYEZIz/b7lxAnAqugYmCs0K0WfK
	 Lf4cqOJI72A8W7r3G7s3JeewSRADTjyhjzB0sb9jv8ZpCWPk0s6H5/28+DQxsLkLUHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HtLNkUTM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e2o3+m+K;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F18606A337
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F18606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HtLNkUTM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e2o3+m+K
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAt2bJ2733255
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1u7BOZ4HXoiDpqQfE+eys0BaXB4J5QVKelBVG2AU3rk=; b=HtLNkUTMolx1qtB1
	TW5/7L69PCVG1AC8+nEv8EkukyHyRQJNQb40yUZKsJ5EDYqw72mO+fOSfRLbv0Ac
	zntv23IX5ptpf/UNZH1u9Nv1zjveEE6vBRXzEYa3J8aGU16C12cN9HH7k0ouPM21
	9NrCuCcws56R8cAXOFnt4c0xEw0nflWVMIRPGcWFcplZQZR/k+uRt1S2wbtNLs+a
	zH4FARObvu24avwUyZePi9mVCBUszUwSl9CXTDH/ctx0VbZ05WQesT4mBkMeDa46
	LZF66kpm7M3t2hxvp7tZyMJ0jMihkIyxTitXK/g7z0Vcd4BtWdbr6YP2ZIi773M4
	Cfi8hg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp8dma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:31:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae1d132d52so766548a91.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014263; x=1793619063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1u7BOZ4HXoiDpqQfE+eys0BaXB4J5QVKelBVG2AU3rk=;
        b=e2o3+m+KipyRkTqtdXlramFCzv8r8fxjwX+pyT5R06B4lEgJkSYV6/S+tmIwm3h8Vl
         swjzELFX2X+eFS2irzOdIrNiMfSbB5zT4D006UULbfbkDpUPf0AQ03MLe5IVrByBtRd+
         WctOZaq2xilOuegxSsMPZtuwo7s+QiulxYY1WbCsCaFuFG98RK+3YhMKldBF8ZMTmPMI
         Cn3Y4dwZlFvWb4uQTyw6yxTiAFoS1EyYTpUpKLiJDf/xpjY2yHvJNr9wpVWF8YwayQGD
         q3y95QRGb8DUvhOnM1DfONg0g4iGhHnTKLErYCzqnxLuZF1WapZe6qT7BqEPtZuh0pBR
         v2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014263; x=1793619063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1u7BOZ4HXoiDpqQfE+eys0BaXB4J5QVKelBVG2AU3rk=;
        b=b6WqGLOqdDPBWqJYCWAGOiU08fGiqXM16C+zxVeOXRQoYFFzdPZDMPoZipyhE9b20a
         h6tlLDQnQOmC7EEQLtIoKz8hwD6gHuauK6Q8wmvKDy0lRQgoczO03ssMiSoBzYGOL2gB
         eVWE94Gvij47pVFdEK5+kAEYWQhf2TQ66XvllbRgv/1ZwMEoiTcXBsbRabq/3w7LV8qF
         PjVk0jvkRkHVqzdXkHA7F8cNQo9p6frYEaBK1l8NqCJU6k/NbnshNI0cxbXBbw3l9qjc
         MYz5tAmfzNocnjVayZ1Q0OsvuN020nrToJnLQzO/V0JhlIScx9nPW1n/tS3+ailDdz05
         WPGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbvRj3FXPooDI0aCwj77uqs5x4JPRIg29YAJLdjKtOIYhevQ0u9gxgVlHLor1JGx+5jnHx62I=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2MMekTNvFd2TzO5dTsDda6BIeSNbNtoVWzzO4HCBozAFHwxzK
	GmhXImrIS9IPwbGb/ZVgM8YWDaQ9ArsO3wxVIp5hFkjbLTorK/DVCAHhi39CoDUkSxegHduCX3e
	GZ8YHaUJdqnhY1DZZts1PAdkq/VSyTXEDhKKsmuFJyOAsLEU8bxpgQemT6cI=
X-Gm-Gg: AYBFou3Z+CvOiOwX4kudpdCmjyTsrRxp1Gfh48YbgrD/9hWL3MonqFnJNmrhXO4AYcM
	99R2cgVpV92iHhJqCd9k+AI0GO0H4NFsf57s0GY3SZssQ13J7vzoYGCK2GFxJ4M63lRsp75Hhq/
	YLsaKhZZZlzDZlJXwNRiCiTK18jXer0+tWYGgamp6g2RpAUVLGyTkU8OZnFRTfydEvTpYnaSUtt
	bFHkNnrBKEW/x5JEjYYh3CwrKv/C/W5HKMQzXGbFL+deIqkQ2YmJpTbwKqmvVt1Q2OmoPzn6I7a
	F4C0dQ1wJeqA5a+ceMs3skUtMjy8YqJ3B28etjycR5yhpHRKXp01HIo3nwxCwa7AU7j7eiBnDMn
	bsqVJ/HNNRyCgGyOMsqZk42M=
X-Received: by 2002:a17:90b:4a49:b0:3ac:9d83:8861 with SMTP id 98e67ed59e1d1-3adeb0f8d94mr5582110a91.67.1793014263385;
        Mon, 26 Oct 2026 04:31:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4a49:b0:3ac:9d83:8861 with SMTP id 98e67ed59e1d1-3adeb0f8d94mr5582076a91.67.1793014262860;
        Mon, 26 Oct 2026 04:31:02 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:31:01 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:59:36 +0530
Subject: [PATCH v2 10/12] arm64: dts: qcom: sa8775p: Add GP M/N clock
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
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-10-ff8e4bc8d567@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX3JMNJWsPgIJ6
 D7Byb884qLQJKEOUA8gkVlruIID6/lcHKEK/CJw/eI/l72nAqK02L1KrXSJeumWXgqra+4j+MnH
 leQgFEyEF9NaNX3ZYwEiziL+l1pcIJT+mNqqpa94TRKOCXhjky44ridF9wx2VaNxp0Z/c+3KUyc
 4eV2/s/Quu5+wv2bt12f3cOaKVdTRWASjYmuykCdaNIDZlBjnIetmzI5VEtI8YtdF6Q3rquMzpl
 X44P2wxMa7qp6wNP4xqNLXV8UkpkSXrFfvlPg0wAOdO+aYbB8nKNcq5NFwtkAoPTTuf9XN90g71
 0x7zRlVm2TewB59TTNVRRNHuLTA4kL0WRlblCqLD1hj7Vb+iadso/J1+yUjrT5Cg4yWi3OLqyf5
 6Aj/G4z8SwtUfzSIgi+S+cpeuFr5xreflEKPCGRSrSJzkRMIX9MJPzH+8yVhtrFUAX2n46CL3nw
 78oXsNok/P8x3bIS1jA==
X-Proofpoint-GUID: XSJpx12gWt0V2pycXw3aPUOGqtEJ9PqX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX72usgK4b28q0
 LtQUey3QCpgADRlE/JVkZMg9c8uEiAkCrMmB8tO+E+a134d75NZ54cMf++nW+KgnPqNYVdJ7ZNi
 n8W9zTvlRW9/Ftl7Ddym3txcer4F+Vo=
X-Proofpoint-ORIG-GUID: XSJpx12gWt0V2pycXw3aPUOGqtEJ9PqX
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf39f8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=RQSmaMWm8AJIs-iJKlYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260045

Add the GP M/N clock controller and its pin configuration for SA8775P.
The controller uses the PDM XO4 and AHB clocks from GCC and routes its
output to gpio35.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 1fdb72fa5518446ba2ea582e8362e86bba75c379..4132d288e3a16ab0a6d8b6d0816e85671bd25c73 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -4348,6 +4348,20 @@ opp-384000000 {
 			};
 		};
 
+		gp_mn: clock-controller@88d3000 {
+			compatible = "qcom,sa8775p-gp-mnd", "qcom,sc7280-gp-mnd";
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
 		usb_0_hsphy: phy@88e4000 {
 			compatible = "qcom,sa8775p-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
@@ -6017,6 +6031,13 @@ dp1_hot_plug_det: dp1-hot-plug-det-state {
 				bias-disable;
 			};
 
+			gp_mn_active: gp-mn-active-state {
+				pins = "gpio35";
+				function = "gp_mn";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			hs0_mi2s_active: hs0-mi2s-active-state {
 				pins = "gpio114", "gpio115", "gpio116", "gpio117";
 				function = "hs0_mi2s";

-- 
2.34.1

