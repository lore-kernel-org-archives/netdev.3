Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746159;
	b=AWUCmffp2yJNmTnFjZBYTYwQQ+CZZIV9CTkag8LBRckerxx6qkg2tKRG7PAMQbr5JsKY
	 eYCQGtegt5vE3eTC6KRgNKQrKn4oP96yKck8nUrqjYcyvef7Pdv+OAJrfrkGOSrU5RZ6s
	 s9RtW0mfhcahUuVlWzlWiTNI8IZi3qtwLmNHN4bsaMu5SXWZW5sBxeYHUZJU1xwz3SCm2
	 /isfIIscU+TNHVIuHkXwGys/giyB5p11jLzlkDWbMbhNAFeZMwuwMcDSU5bJP9ckiFtmt
	 fHnH3r2OUfQlxOWA7c4wbKsnsdv6bCkFpsxWhKPJ0SFKgmo+r+TYmpW6tChno3Ckfow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746159;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=znTnKbGoxNvTEI60Uy+kYg7/LZYXZIDam4RT35k9s2g=;
	b=r/UJ6rs1KXvajwZpWBl+l3jV3JaTAUcZ+45UiOH06eWIJTkoLJFQp2H8rKHzZDNzZcSQ
	 6Jj+Mr26CwvE/Gp0ctBKx/NbvnYpkS5MTRk9SlS/EUh+7n8kGX28q4m8P3LTqpKaOj+Zx
	 u2kuXzMDsvsAaotXv+ZehOOorrm8+P66A3twMb7tBQxzJVENwx6c7FPhZGnMjIu0m+aV9
	 o02nF6jza2jFJPaMROX/vU8Yn1xjUjkOpU/N6BXZQHTjOxPQRoiQDFhJDUxu7TUptrCIO
	 BV8u4PfhAgrxM1NV4IALSwnGENIIGizBYvH+/rWU1Wm61CLhMfoB0bnx7KrfBCX4cuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z56y3q9B;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kS0gauyw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B9606A320
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 998B9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z56y3q9B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kS0gauyw
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FE0D2092894
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	znTnKbGoxNvTEI60Uy+kYg7/LZYXZIDam4RT35k9s2g=; b=Z56y3q9Bc3mvG9H6
	os0qC+81dj+cRzeFOxuL2Xfbmc8nS6E6P25LmmN0O+a/LAK2z8+K8yHywqasjW/z
	ATixq2L+588zSnXf6kgx7QDd87g5posNtA8zSGVb1NFWgVaDlAtovkesBUYA3eft
	/oQldLab5wk5YhgcUIJZCYnfx2gTcLDv9oVUxYtZhdhkjZOW3rhLtFXOrE9zWVT4
	y3v87SVVxKGizozsAtharq1dDl6q0ulVU6BM+dJF6daO8sy2/V7nLaVgjAT38qBY
	h24ZdYhpKtrkcWqDhOqr8XGQ+Y97PNaPxsmoPvQjsR4w+TxjnYDLhinpiMwM3uUW
	Vm5yYw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftyga2m0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93caa0ce0cdso79784085a.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792746157; x=1793350957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=znTnKbGoxNvTEI60Uy+kYg7/LZYXZIDam4RT35k9s2g=;
        b=kS0gauywgFw04EntllkKIQfn6S8wdvStf8WMz/FMtzHdmVhb2/K9UcHZeRb46pWUZ9
         muzNTWzkkV10oxFMm4q4qs95RY1heLBww2aoXJb1AXsHjjp7yOIuxT+EmyKHCeDHJws1
         1IDS4O9BgQlcQiANO1zIRw6B0D05QwXxJVwPDfCfRiGRybF7PsWvONdzVh4qSjOSX303
         BENQdlXdxURvTqnyZrHb4xhQlBHTjnLpi+90xUaTxAoNqPKK8oxX2rIUU1+MzcYm5Zis
         gr8JDEjfgqSmyjduhBrejIn5Gx/WFzRZr+73YAYs3DgMeLt64bahQveiOS4zxERbKUq+
         mZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746157; x=1793350957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=znTnKbGoxNvTEI60Uy+kYg7/LZYXZIDam4RT35k9s2g=;
        b=vXvgsAbeG0Yk7XPAYs8/E64q7qQJ2u8kb22b7hjZacnVK6vrJbBs8s82tKQWKZnF9R
         h41nQrq3XA6GGnPltR3ze9X3Z/ebV84OsluBRLwynHDlaknQrk9GERAg42QrDNpIdhqs
         wB9CyPjupnlQmIrXAnmVZWpcC0sP3O9urlPaZNZxd9HkfYKx7pA2XWOLYG4Q4+KYF/mv
         qao6DvCQsSIvhXwIA6ixB3N3O92DSv0o4VbwY+7TmDTD8MefnLIKEfhj0GeFjfW6+fhH
         YWSLcqz/lCEPCHsetODhVdHneADsxGHPb7D1VaIrUfhFUGVGea8iyK28l+SJw4LjK4Ig
         Yr8A==
X-Forwarded-Encrypted: i=1; AKwUvByMjy/I2zQjMx12i+pa30HbxRj3Uy7eWzWPLGFh2lrpcMPVcBZgM0NOrKySwznhflf8045yMyo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0kNgA9bqUYfHjYfhwLJMjEkKUJ8geYdIG3IdYS41nuJM52vcY
	ZmW1jGLGi039sOadWkgiyp1boF32IL75IybS8gPCOk4LpG/y+xsEWOWwqjvJ5ZFLcKtHduLgukj
	Z2PMkwoqivsL/hk4kcZHv8SffQ48I0Iwew4kIBKbqo1/JpirG/yRYRl60L+c=
X-Gm-Gg: AYBFou0cXWsC4aGgPnkqKpS9dveSux3KjdJhMApoW6yeT6wPR3GyZxM6Yd0lWmDa+kb
	JUNVhjgpcxa6PZA4z3XHorRZFly6+bCZobKSc6OyLhjyZBa0zG1UJ1sjzfeqdomszBOKqTSt2Lh
	8KsG718RmyQzPaqpzoYg02s2yo15tIywVRmQG+xEQFuTrgnEJGawCxKhWBpi0u9aUH13tvyj/cY
	MdQGoWRbi/W6yCMjQFEAK0QddhdYNGaFhm1spoifO3yB0jSZJ0SIwz1+JTd5emGzPE9SZxWKcnu
	hS2vH5xJWXlvM5cb5C1IqBxQbf0Jm6oAFX0cWeEIusuBxO/NOfw9957JLe1dIIRm3VjAYWQOn/Y
	juk5v6SpuxWuBvG68zdlJTknEjnj8
X-Received: by 2002:a05:620a:2614:b0:93f:2ff0:87ef with SMTP id af79cd13be357-93f6f907ccdmr305293785a.15.1792746156876;
        Fri, 23 Oct 2026 02:02:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2614:b0:93f:2ff0:87ef with SMTP id af79cd13be357-93f6f907ccdmr305290285a.15.1792746156276;
        Fri, 23 Oct 2026 02:02:36 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a215437d4asm23076245e9.3.2026.10.23.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:02:35 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 11:02:23 +0200
Subject: [PATCH 2/3] arm64: dts: qcom: lemans: make the emac compatible
 specific to the embedded variant
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
Message-Id: <20261023-sa8255p-emac-dts-v1-2-a34d778ce9ac@oss.qualcomm.com>
References: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
In-Reply-To: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=v/z8UPGfwZQDOXBUKeeQaSmucNsKbE50ggXggI4zSpU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2yKmQplFKpamswBSF/cPi31pfbnnLznTzoPhV
 pbLxmUt7feJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatsipgAKCRAFnS7L/zaE
 w89ED/9p6vlC6GR5iuJdH18UeXOi/+DMIC2pKbVCAd6P7HNLXATA+ZLvXppPEPFvhRm7ebeeGDI
 uolX4MN5bA4MoeYFRLypZ7U5yUBb+M/ELx9HlAaby04EDpKXJN3gA9VNR4vQV/wy5ptokr6pfoN
 IylqGQCTeMzZ5MkzIkYZ0PmG0ajWeMvAH4CnuKDzNB+7ROhdW9bSz9aS5g1Ykwgy3gryJ/iemnf
 zR/anQMAAxcQP24JD/EX52ixjwZXtfB3e1Tzz/Rk/Lna5vTF9lcOSeNc27aUwUeuxbbhxFm0t2R
 vw5JhRGfEAow2cMm7QJm1v1yFDkn31DYe/AZNbwj7GTqu16P8pzaDK0v6nKGUdk2nq6vsw0TkyG
 Sue5yujnsvRhn5SigsKDQPxLfyQeNJihCI6RMCkISKP4tOjjFaLuA2G9tEpuE8+qql3iRNmIB5C
 Kk/B0edjN3PkaedM+sEngm/kj2B2Y3S0zyoc8hC0nm8/CGg+ASW+/mp9doJDn7uMAVVUIM9yE6Y
 f+BMyH/fAEZqk/lNaeZpDTyQU/T2TZODeq5KLu/KxjLoIzviovdHLKnCspPu0pQB9CDgsZxpOd5
 bboT8niHnqo4uYBn0XZKi4WdamSn4lRZoMCAqWJM7y3HD+vBhBcqBibHah6vmLUppnh/L0Xq15V
 BMrBZ+IRYqaf3dw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adb22ad cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=4HppcabNkfReTd2MclQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX5BwtSbCZ9e6X
 Sr6Tn+ZsNJWwtqBRKPe5aikE9V/LGPvsTCf+k17zwg5SiGP+RtKkmjA5YqPHbkwcj9A16eDx+o/
 SsSqDfYXGoW+MIuhzLXIGCKt3BC0tpk=
X-Proofpoint-GUID: Y2e0SHhrgETZH1ZWdiRGaHhtODciHU8f
X-Proofpoint-ORIG-GUID: Y2e0SHhrgETZH1ZWdiRGaHhtODciHU8f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfXw4BQnUW9NyGV
 NvUuX2BpOrYRYTT/h3gn4sdF8E8IG/qMTMKFDimUAQQYYIQuPSxQWZTh17dYwpnagrG3CHWfv17
 wUc7TRuX8UWPUHTbODAM2Bcb9wgLeSu6U9yVSl6b21KjNX80thYF95IK881bbvmPXQAd1djBtMS
 xcOV2Bns5qiz0mKXwFDKLBOSJ1mT5Ruw+q7+0bJaE4S1ewdAxWjxLIJApxTwNJLC+GJ9k5RM8Mn
 Y8RX964BbU7A0JwPaMgGGWjSM9a6z9rkgrb6eBSgWSCHKpIWpaBVTgfp0pFOhRyrOLKZKluxJgG
 dbZdb/RwxheWGIr/dbYsdzlLuwbXTqULzSl0cGIw30VAFetj6BkzbG06D3UgxBUQ29FwVcsWEND
 UaMpAV7MFvxcHCrvqxwgM3HNyVOzUWLhgt/JkYEFw+vS6bSx5F0L4vPqQfjnnUdC4lEjSiNZwPM
 1li34JlPLFzz0z0zpCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035

The embedded and gearvm variants of the ethernet MAC use different
compatibles so move the one for sa8775p into lemans-embedded.dtsi and
make place for the gearvm variant to be placed in lemans-gearvm.dtsi.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-embedded.dtsi | 2 ++
 arch/arm64/boot/dts/qcom/lemans.dtsi          | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi b/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi
index 3733c0b7bace10cad656144b31d02bd8b4dbf3ed..630c40d21ecdab40ec59135cc667e4eccfd23554 100644
--- a/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi
@@ -458,6 +458,7 @@ &cpufreq_hw {
 };
 
 &ethernet1 {
+	compatible = "qcom,sa8775p-ethqos";
 	clocks = <&gcc GCC_EMAC1_AXI_CLK>,
 		 <&gcc GCC_EMAC1_SLV_AHB_CLK>,
 		 <&gcc GCC_EMAC1_PTP_CLK>,
@@ -481,6 +482,7 @@ &config_noc SLAVE_EMAC1_CFG QCOM_ICC_TAG_ALWAYS>,
 };
 
 &ethernet0 {
+	compatible = "qcom,sa8775p-ethqos";
 	clocks = <&gcc GCC_EMAC0_AXI_CLK>,
 		 <&gcc GCC_EMAC0_SLV_AHB_CLK>,
 		 <&gcc GCC_EMAC0_PTP_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index da740a0876d4adcff0bb9458564c868a6f406b0d..77e4f57778fd54e414c86a32f5b068239bee6d24 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -4386,7 +4386,6 @@ port@1 {
 		};
 
 		ethernet1: ethernet@23000000 {
-			compatible = "qcom,sa8775p-ethqos";
 			reg = <0x0 0x23000000 0x0 0x10000>,
 			      <0x0 0x23016000 0x0 0x100>;
 			reg-names = "stmmaceth", "rgmii";
@@ -4407,7 +4406,6 @@ ethernet1: ethernet@23000000 {
 		};
 
 		ethernet0: ethernet@23040000 {
-			compatible = "qcom,sa8775p-ethqos";
 			reg = <0x0 0x23040000 0x0 0x10000>,
 			      <0x0 0x23056000 0x0 0x100>;
 			reg-names = "stmmaceth", "rgmii";

-- 
2.47.3

