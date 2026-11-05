Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884084;
	b=Pb6DewTgjfMKrEKq+EtGKtUYVCugWQQk+zvdHtQmULp0bmn1jCpKNto8o3N8sARdvsiE
	 I6ToTGWSw3QTf7JHm+uiDU8ST9FJjZlboiJXKWwQdvQe2i/7rhbWb6qrdSE7sisEgylQx
	 2xfy2CTVk0fpHSr9dzlkNbH0LqDjuyiJJZkLHCCBcMOhsx+1xEv3CximNW0vLn1mA/ZRO
	 JS+cGlmftK9j5ixQgxzoo4+zCp0Y0rOXnOlowGEOYGy6HzyvniY0mtQJMCjQ3SOJgH68B
	 9k6Uj9XwGYFPDsuOEZAz/OQ30LEvS0mhwgOSoB4H/XhvvGbGXTizQCZP/2DnpxzP4EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884084;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yTGW40gwwxPzKGaZzuQ61MAtSHFXdlURtLrq2mZDOeo=;
	b=pVQZCH4U+4z1i5jab9fbTqGXzUEw48lYLRz/6k1dVSwrx0/G64U7idL1i3rtL9onuSmK
	 /0f+frQ5fdbwsmtbOT3GsHFwgr8hf+wHSzvfXELFhHp3qXYalghJJKphsY/tllZDR72x/
	 4C0c/Ock8EIwSMCxyONZWiusR4TYMgaO8sK13pwFkXXC/fJmYVrTXfR3p7ylnYrRzLt3S
	 BPIZ96I7+/nxFQvPGF2lLYtSCQRiFht96+meNg5L/tMWMvydr6yjXCvLUPFiiZQQXkGnk
	 LQJN44oQeAbcvLF6wRajuHk9K8XvGmD+dlKV9ser4m+zcWJxGzhCKChcATAY6yQsoLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eaZzr4ca;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N08j2xod;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C479F606D838
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C479F606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eaZzr4ca;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N08j2xod
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tiL13532116
	for <netdev@vger.kernel.org>; Thu, 5 Nov 2026 13:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yTGW40gwwxPzKGaZzuQ61MAtSHFXdlURtLrq2mZDOeo=; b=eaZzr4caNfA80xtp
	g2HsggaQu97xrwVSS20VSQ8gjMwCd5sDmo5XHW8UXEsKgVVjgJuvuTqzutn37+Ef
	C94rOF7ZBUfUMOVrp7s82MyN0agJRballvBhbUcq4+lt3nuQWCb8e9qCy0IVAco9
	u6H2sdFqEecNCdwoW/cltn7Sbgt30zXGEUlbt7KsWrxHJKGxWjZfd4e/s40nk1aC
	k0VLx5JU8dBb35xIsllywrJpD5jCQ7GpSZ9eB3WCn7bMHGUdWut7dGYTFyQ6HrMx
	0yAZ5j5Thy9iHsxe4Jfq+HyIzoiu2f7KUHkJDmiRyCmTO0dTzW0NLa6ih15GvQQa
	q3AtxQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9ryg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:08:01 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b304fbfa2fso16961817b3.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 05:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793884081; x=1794488881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yTGW40gwwxPzKGaZzuQ61MAtSHFXdlURtLrq2mZDOeo=;
        b=N08j2xods7OqEbTkgctzIPuFCUMrU/paJZfPRGnSKSn+khp2itY3yxzllgIvFOP9jA
         J6oVNXBxl/HYLFwsCNSp83pCHDJeOT+OkKvZy/xyEXMB7HxQg1UJ/lKSoiKTHdRWBfxD
         NLaVYjPXy5GTiQJWnkHTmicHNX2Ss8zEmyPia9XwnPIXM5HpOMUL0gWbzmEOAGgdWAZp
         02gyaWZFELSV5Kk+I0H2dr69KAoO9/khnAkupiIgI7tu7KzJhmeFiIraSl0cCV/idJoh
         QEHpfFrheLZvzumwyaLlDT3ErTF2nxpivrcvBHSaBOU6wkK45ETpgIlrTh2obBsiNHcV
         +giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884081; x=1794488881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTGW40gwwxPzKGaZzuQ61MAtSHFXdlURtLrq2mZDOeo=;
        b=rjrTTfIW+fx+xGM26CEJnaVwjTFqKstXYdrMG/fe7Mov6l8nZHPKov8DzuYfFok10e
         hWT/p2BRKufnRaNiOdFab001yV6Cz1p5I/rAa7rVNyQZLykxZdhLG4c7wpbESFPj/ogo
         i0HbCfHlu3vGrsog+TRLXMla24XikplSTsxPdPpBGbmodYdbhW1zl7M/7ILPEl/LxpAe
         VBg68h6iGCl2rqGDcvBdoWWSCMOms1iPI3Ap51Onn479vT6+Krfi5Hnom4wLOsnTKXX9
         4e2q12yDJM5pjrG5Tt3RvkOAz7lePRv46R99hJ0ZpKvwyxf2xQkzZ3zx6d8EZSRelTJk
         U/iA==
X-Forwarded-Encrypted: i=1; AKwUvBxyseIPCNAPcwiFZEVtF3NsGX3VMEG+efJnhZUy7x3qh7BJAX/Pn2xNM4GyuCCAnnYBOnNUyEM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gQAmrCC0wLJMaehfQeLvz2DENW8g0VbBQoIkspOlwkfHkEzRG
	3O26hYOifg1QNRCGUOVftbvLoms8AvsAmy/sM9BDV+YBKjx1N3KAEN3VPVSp7SlaY5gVvV6M0r6
	pLe+ysSUcSWpsgNM49wuJ5zNBTwMpadgQSu/DM0xQOu82b1tdTpV8SPFmAgA=
X-Gm-Gg: AYBFou0bv3VIx/CAr2iJg64SiehGOIQohltGtshnqpWJIgmxJrwoUzXZr2pRv/PfsSD
	0wJu9TlZuxv7eSXQK5hgiHgBd6WCN73xUx2mHr9n7rNp66hP9KqJtXCDmpWmo/CdsLsAr/08ojX
	+KNokOEAE9IbYRDbkOHlvvPAltn73/VyQyTFJKQ5rXEZgXpeoAaf2V4LkDlVyg3C2g2O8f0kJjl
	7nOTP4cF6MwfNpmP2zImPi6UKEmXYBPUnfBJ3l+fwduLOenZD7rvXpKWuZ9Cz/Tkild4qfbvc+l
	xUfv96ozfbcZXUmqrzAl1HckRl1rRhO4c3UCt4NhrAh8wjHYfhrfPiKHvIXmIE4Exgyz9+JMVx6
	bxazW43bgj7Untf/HoOw7xNVDbWG6bbRiOvzhR4JpKabrB6pw63J8nIRKf8jiEvpsG0pzgCjDbu
	dFwKcauALnkoZt85aa
X-Received: by 2002:a05:690c:e3c3:b0:8ab:42fd:2cc2 with SMTP id 00721157ae682-8b2b65acc18mr115156067b3.3.1793884080904;
        Thu, 05 Nov 2026 05:08:00 -0800 (PST)
X-Received: by 2002:a05:690c:e3c3:b0:8ab:42fd:2cc2 with SMTP id 00721157ae682-8b2b65acc18mr115155817b3.3.1793884080451;
        Thu, 05 Nov 2026 05:08:00 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bb4406sm38915937b3.40.2026.11.05.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:08:00 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 05:07:14 -0800
Subject: [PATCH 3/5] arm64: dts: qcom: ipq5210: Add CMN PLL device node
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
Message-Id: <20261105-qcom_ipq5210_nsscc-v1-3-d4fcb5c32b51@oss.qualcomm.com>
References: <20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com>
In-Reply-To: <20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, Luo Jie <jie.luo@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884066; l=3090;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=zgBS2poww2eN6YQuXDkYZD4TT7J8e+5Ik+8ytF15e2I=;
 b=UdIpfLGICBaQV6HoxWOkTqQoES5p9W316Z1SYI826I/noIEYzLwWuMevLT5YLOFBisc173p9/
 f8meW0iEpsyAG172l8qgabRvvW8HrrZtom6UnsPuWtdEZYVeBI6hdLi
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX3GOa7ZkWeg0U
 I7sL9pg5+rVzeXt2xWA2UVklskF22JlUXky0TRrG3cR694BRrmKAPJE5iSpZuEj10WqOtcAZv/9
 5zTf6gDi72BkhwcMgl5akM4CcBvRnLramvEnsVS7eIFTEuXHHD3f5ncCNAMLfmGovdNRTHJxIS6
 Qve4kZauF2jbawszVuSghQMhSYq1b20nkKzIykqTeiGUi0i6HbvKv46ApkqgMK8VobSN1wqX6L/
 zaUmBaW7Kk90aRZAO3PWMcOjP0rHmM3vYVwbnJfA+wQb1IH7r+hBqKzVY/IW0oHlK4m2/KA0X+h
 VHHAV+y3ghRSYiDtm9ISB07Wvg/bKl5R1Wrn53Vj2mJb+aYHSvs2cC8E/2zB8ENSZSsjxKtYdq8
 DTrKSaj3xiF8FGpKvjcXLG8e38E8S0Jy3/RDs2B90P7DxZ8X2NwvGfIAPrqWc15WZdpurHShA7t
 w7ZA+WsayZrJjnvYqEw==
X-Proofpoint-ORIG-GUID: 6csZgyzDhX5qIcIAytKF1ZR7eWxENdVb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX3bVVTQo06AAs
 DRzqqW2aXXJC8pzLR20gGTARD/4rphzKeGzF7I3C5pE4cFHEfxuOHwvqVwQgPLWwAGJ2Byihyqe
 n1rOFGk3SEWWcURRXRuFSXAmGzKzjgU=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec7fb1 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ihdlGfXGyWBHLSVGZBMA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-GUID: 6csZgyzDhX5qIcIAytKF1ZR7eWxENdVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050052

Add CMN PLL node for enabling output clocks to the networking hardware
blocks on IPQ5210 devices.

The reference clock of CMN PLL is routed from XO to the CMN PLL through
the WiFi block.
XO (48 MHz or 96 MHz or 192 MHz)-->WiFi (multiplier/divider)--> 48 MHz
to CMN PLL.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts | 15 +++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5210.dtsi       | 26 +++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
index 941f866ecfe9..61a53361138b 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
@@ -20,6 +20,17 @@ chosen {
 	};
 };
 
+/*
+ * The bootstrap pins for the board select the XO clock frequency that
+ * supports 48 MHz, 96 MHz or 192 MHz. This setting automatically
+ * enables the right dividers, to ensure the reference clock output
+ * from WiFi to the CMN PLL is 48 MHz.
+ */
+&ref_48mhz_clk {
+	clock-div = <1>;
+	clock-mult = <1>;
+};
+
 &sdhc {
 	max-frequency = <192000000>;
 	bus-width = <4>;
@@ -77,3 +88,7 @@ &uart1 {
 &xo_board {
 	clock-frequency = <24000000>;
 };
+
+&xo_clk {
+	clock-frequency = <48000000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
index 2cdc10529c48..52d851a0dc2b 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
@@ -3,8 +3,9 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,ipq5210-cmn-pll.h>
 #include <dt-bindings/clock/qcom,ipq5210-gcc.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/qcom,ipq5210-gcc.h>
 
 / {
@@ -13,6 +14,12 @@ / {
 	interrupt-parent = <&intc>;
 
 	clocks {
+		ref_48mhz_clk: ref-48mhz-clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&xo_clk>;
+			#clock-cells = <0>;
+		};
+
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -22,6 +29,11 @@ xo_board: xo-board-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 		};
+
+		xo_clk: xo-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
 	};
 
 	cpus {
@@ -130,6 +142,18 @@ soc@0 {
 		dma-ranges = <0 0 0 0 0x10 0>;
 		ranges = <0 0 0 0 0x10 0>;
 
+		cmn_pll: clock-controller@9b000 {
+			compatible = "qcom,ipq5210-cmn-pll";
+			reg = <0x0 0x0009b000 0x0 0x800>;
+			clocks = <&ref_48mhz_clk>,
+				 <&gcc GCC_CMN_12GPLL_AHB_CLK>,
+				 <&gcc GCC_CMN_12GPLL_SYS_CLK>;
+			clock-names = "ref", "ahb", "sys";
+			#clock-cells = <1>;
+			assigned-clocks = <&cmn_pll IPQ5210_CMN_PLL_CLK>;
+			assigned-clock-rates-u64 = /bits/ 64 <12000000000>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5210-tlmm";
 			reg = <0x0 0x01000000 0x0 0x300000>;

-- 
2.43.0

