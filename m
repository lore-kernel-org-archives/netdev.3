Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014272;
	b=vWsuTodn2T5FcIb9EUMlI8khGJ+2soVTpNc5yzOXqYGMh3Yxq9X1uySq69pkpTsqmX/z
	 Pj2TB8VkLFVhggtmkNsV2k/Q5HTcg2E+szx/fRolvHPm6U2ko1EDW7bKsF/cfpLajMkkM
	 n6j9GWwd5CM2UEtMI/mbV1xJthxXIAryE400b4u5MM6inTlCh2D95L2mW2tt4gKetBt5R
	 toM50Pnid1RIlZu8Xz+EjXky3O3LT0plzeYU9pUyyYk3cIWBje7uFWLxW4QonmaoNtyLu
	 H1sM5B7gwnD9B8mAtLEe8nJCyxojTCIcqme0SSLAjvDnNp6NHShGjl5aQojWSkH697g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014272;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PN5PQEqoM03ThjwzMKni5i44sYywLhtbqVb5oQyGOvM=;
	b=rxI38PQtKS0cdMgOrXUk3rjqJpNj7/ugcFP3aQTscErUgplUT8VynX7CXY3ZWBgFF+iE
	 8R2NilhnKZF0YpAUp8EDoxyPX6aHHoVFiJYGL6xcM5rQ2A/pLSqKIfqcxHusvHQ4FGLF9
	 JULiJ22oi6K5v4duIpp39+C+Wm/C3yLQiNifPWUICElIsXt7iJar/2yrLqvdbysUri93M
	 mL2xiK5aDedeq8dmuRnj3bv1MRvJwIY9Ckz2e/aEYVQWxADFZKzrfx+oH/31L8oCzzSKY
	 aEsC6CQ8hDxBJs/QQyGDbtjwd0UEgyat+mpXOSJQ7/v27FvbhK9EOBFb8pHbBFbvTPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="O7RW/zIC";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="jx/zhB2i";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98360A3824
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E98360A3824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O7RW/zIC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jx/zhB2i
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAt7bp4126426
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PN5PQEqoM03ThjwzMKni5i44sYywLhtbqVb5oQyGOvM=; b=O7RW/zICp5ljs+ax
	SoMTMgPqRK8nN7vWGWf9AhDVKAWbLURmQdBvAe3JTu56NjBlAdlhECA4qJOZw2FL
	2Wt/4y0vapLJLJSgdwy4dCYK1iKo5D7T+m2IgIm9nzj4TdgDzA3FOPgpZYcw3Pxo
	Is5CuB74z8yz7R1X9cfRePmjk7JXJnn24jNFfEB2LzVdQ3VKlkDW4qGbyB+Crqdl
	0ILwSPkKgCkunyzAHDwFicoJtlVssmo/WznG+dMHxnLKxmIGaxJFOdeZE/u1+XrH
	tY7pZbp/8SCRca9NE2Z/2BZSHXH6vK1T2K1b7HHE2vi1iRA/2dCQ5rW/5EoAjsvb
	dTpP9g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpt5xt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:31:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so2677725a91.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014271; x=1793619071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PN5PQEqoM03ThjwzMKni5i44sYywLhtbqVb5oQyGOvM=;
        b=jx/zhB2ilzFQ8iNmNi3ieTRp16TCFlpanAqsjzkDevrlqtiqHqLqKr2XsbzplX8ful
         PruhOUEK6lf9hDfAW+Se6x3XpJxLZmquFKLUB0j51YMog8/Q1yYBmwgBnl24SMRwEMld
         p7pVxPu31fxta3wv4mqHEN/JTVUE0EwQaKay+SOXfFEEFXPVg8X61dfQoZVbtCGOy1z0
         o9EXESsrZ8WvFcKLVAjjDZOnYzWheqVQOifiivkdishddnkpZLwXkwg3g1tdpuZ3azOP
         0BpIami5z4NtxL06CBAlQxg3D8gl6AqY7kBdKY9/v0V427x7FdPPXMwjpGP/lavr9JUr
         /rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014271; x=1793619071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PN5PQEqoM03ThjwzMKni5i44sYywLhtbqVb5oQyGOvM=;
        b=q0ob9a69BKMYfyLYXUIt8fltt7VOegQXFfSislbDnSV62AuBVA6DqehJgtPslgOzRH
         0mDbLot+HapNQzgI/poTKdVkEIYv9z1fKU0glz1eQWLzN0A4egZFOFTNpDBh69RdGCj6
         DzogHrSZULi9K7EfsloPQ5kdQUGjyQ9+03wvyCMOIxkPjBvAn7G+o9oPSTLol9GG7SiS
         uUozDqn4dCiZdRtnuJvlX1sb4dd9VV7/mX6VJlYzpjUfBEeyQ1diygt3gPNM1OunX1xc
         Q5s0XBwM/yhrdxuWqmpAG1BCPoxUq40bodWTxAFHs3o3NUvrf/myEhdWcjw3eU+j5VEB
         h2Iw==
X-Forwarded-Encrypted: i=1; AKwUvBzaS8RrFOSB4CZYL8gA99OHWuF9U4NII7eumF8tmHqSYMMAhm9OKg6e2NEijNunoryDNDMB3xI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRS2eDjzzkXbC0nHzMNcZOIadhYfDgo1ajDFwfqxXhNh7QTtjX
	soGerJL+dKSeRzJrohWVjtB35zHThR07p0F51C+AOHC6pjJ1R/w2GO/m9Bam6KEnfW74K0++CXT
	6UcRLECCr6po4IXg6AGYN8tG5uhS93gjTwlwlqInsu9Qc45hiU9vK37xOAJg=
X-Gm-Gg: AYBFou25w7WGWGre6jo3Z2AqD1vyoG/ODeBPM7e9wuOvyiOFO+cBtGX/zZViYYLW3fK
	/yvYbnq2drCMai5ahCyn8FymruLJb81Y9INKy0n5asTnSAg0rDH/Op9YHiApRbNAq1pCv6EKlBL
	G7aN7UqlM2pUEmXFB1IxwFfuH+AsNY8XYBENpDnJFlk43UwCHHQbPyRaTy9iXuq8IfvO96WYNi2
	fZOLWUalaykUB0I7DdFwErLKYiKkaFdBLhK/M+Rutz//2IRwee+zaoI5JaTxoehr+EYKWA4TZNC
	/hfvHDo5BG0APjX5C3suAkJgUTENFqjMIeKHD4+F+lm8F+hwe915qLnhb7njpkBerCwVgiDK+6u
	HexCSZJ66Q3CBou16Xy2I2kc=
X-Received: by 2002:a17:90b:2d86:b0:3a0:9fe0:3aaf with SMTP id 98e67ed59e1d1-3adeae70769mr5826687a91.48.1793014270743;
        Mon, 26 Oct 2026 04:31:10 -0700 (PDT)
X-Received: by 2002:a17:90b:2d86:b0:3a0:9fe0:3aaf with SMTP id 98e67ed59e1d1-3adeae70769mr5826620a91.48.1793014269630;
        Mon, 26 Oct 2026 04:31:09 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:31:09 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:59:37 +0530
Subject: [PATCH v2 11/12] arm64: dts: qcom: sc7280: Add GP M/N clock
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
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-11-ff8e4bc8d567@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX0MrzNzijxOED
 /i634tMYDIpJjs0rwXzYJFqbjgRjVBgba4TSKcSM3EupO7IOwMborDGy3VtE38FsM/lyxoDGvlZ
 GDvnnxbsXU19TUt+keK5XlqzO4tf9ZU=
X-Proofpoint-GUID: QYBLQnv-yAP-WmZKHEThOX-wsZdgcMru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfXy6RkNsPg2do1
 c3qLO2jak/njKC1CRZtA4Q+W99fDkBxpEu7F7pxCHr7HwFvGonQ4s5XJrdXZkGj66N9urFETF63
 fFtxpJ+ErINNLpNSpgSac6EUUVP7bmvg3jFnbqq3ePB93SeuJjD3XCD1CGqIsPSEMS99uHGc4HD
 jk4FXonfAXBP3gltb/5ofw+CDzG0xoeb4i3Zrj6XCa7ccxnFR+DdKv3aBFLHMV5JrrIzGDOJWD0
 cu+OYcFjAkwEKWCIsxHa28gr41u4wMHYpchtjp2+AqXdXyPS+ElmYN5Lq45H9LcW6PX15SdmL62
 HLVceRlGamYnP2FUdd23g9ZW8yF1mgGweqIlJrY4U0ih2crGRuR4wZPQtSZ/fz9gUYTGu4jQaHs
 VCQwZsmsTrLUNlOHOa3hvDhGMkzJYCKRodSYQ+/3NYjP99XRty3yjeqtyxrzuIx2mjztrT3gRKy
 ydaJs/8VGtCOZFL0xnw==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf39ff cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=zpsMDwxbIOh_EP-Phi8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: QYBLQnv-yAP-WmZKHEThOX-wsZdgcMru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260045

Add the GP M/N clock controller and its pin configuration for SC7280.
The controller uses the PDM XO4 and AHB clocks from GCC and routes its
output to gpio60.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 8c7523602d2719775b8f5c6a8cef138a93292721..de27a051ee3b0e9046ff97b8e6fe0164985d7b17 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -4442,6 +4442,20 @@ usb2_role_switch: endpoint {
 			};
 		};
 
+		gp_mn: clock-controller@88d3000 {
+			compatible = "qcom,sc7280-gp-mnd";
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
 		qspi: spi@88dc000 {
 			compatible = "qcom,sc7280-qspi", "qcom,qspi-v1";
 			reg = <0 0x088dc000 0 0x1000>;
@@ -6653,6 +6667,13 @@ mi2s0_sclk: mi2s0-sclk-state {
 				function = "mi2s0_sck";
 			};
 
+			gp_mn_active: gp-mn-active-state {
+				pins = "gpio60";
+				function = "gp_mn";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			mi2s0_data0: mi2s0-data0-state {
 				pins = "gpio98";
 				function = "mi2s0_data0";

-- 
2.34.1

