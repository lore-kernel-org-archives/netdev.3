Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746172;
	b=S+5ftEPdzA+H6ffivF1QWvwZnLEq9bMOA9Hvjlqg4j4bgGKssNw9A0Y18GEI6ElHOSEV
	 /gRK5S73azIE41GND7GejtKRPuT01dtZZwjQs096n4sqfY/sDkeQtQhXEDWqoSy0QbLn7
	 E+99QQe8IQB2FOLeSfP8aq+v4uO20hx+4oAk7IUFelLfz3rUl9DPaqKWiYE/5HS6An3BF
	 U5N63yrRSh2yM+1o5R8y62iJsz7QOe6b09Au/7X831ji6MdBZ1664Wn7Vp5tZhuSKv7r0
	 2LkfaQczyEXWqcm9c8eGaMgkEyWQx/RZPzGa9ucVcmaH22eVI9D6qZY2h7AVKDhrVqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746172;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dhJsyioNXqoe/67sGFvekH2yPgEUsEgy1mmIhMnO1L0=;
	b=AKAivgbPxXCJRbY55NoEEWgFPlMke7/3Oi/rq1fF2Hw3q82tyzQKTDRXyUPaaCQ9kVBC
	 q7g9bOzmuetyWNGriGlQS3sCDpBtvwWWYeGUo/dqVH9V9D2VmP6D3AlkwvjJ7wAFYSeuN
	 RdQyT5QyHuFinL7VksZ0i5IQZw88DW7gvtc9OK/JYhVx0t34/d/YOgu+YzbvNyFHeJICB
	 uE9hhqKRu2MQihb0QdABdD2/AnmJZCPQyfELgiOBUw4pByQDxRJa6KdhOt4Wv6II8g1TF
	 Chcct9fZcBmtdArOBDreH5MBPAzHFjX3h11lOVYU5mTc3ek46M0N2aCdAZxHdmAkuCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lXxyoDxD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2DI3gFd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB535606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB535606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lXxyoDxD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2DI3gFd
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FTsc2650380
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dhJsyioNXqoe/67sGFvekH2yPgEUsEgy1mmIhMnO1L0=; b=lXxyoDxDUmbcHWnU
	TjRNRkvElUEMP1zVwDpiQijjXn2RYNXJEgasCCHqmUmQOHE+gtso11hj+1/PKofF
	C96sCe5BWD4i8wcOFg9nZ1zAHipMheh8QHeTH4bURTvMnDB5r+ojYogKQ74RThbT
	1sa2y+x4zp3ULIFtKYJS5NiT/MCoaIb6se2Ri4jw/HwDANuiVNNlHeEs2Z0U2oSg
	WHn74nd9vccdRRICyrRvoXmBH9yCKNZ926VIPGL82+rpVZWIvKE694URVLSJ1iQy
	KmpYajY4nlC1TeWhh/7eGNYb401NaefqjTCNR6zUFLT/3sOQ5fzKb00QGhy4ROJl
	W8wT6g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjaw6r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5338974c0ceso18452171cf.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792746155; x=1793350955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhJsyioNXqoe/67sGFvekH2yPgEUsEgy1mmIhMnO1L0=;
        b=U2DI3gFd6ITm9DzrRgjI7PwkPtGtTgfY0FmOsBc+KizjHRAZzItEpH9F6d/+FaD2PI
         mpvFJu1yHuRfGrqDIHQrLmt2dRTwiKz001DciKH2c4gydD1sG2vNwc/6hpV8L8OpInau
         OsJctiotaNR1Wwn1l/mYYXXFI+Pb+zvuEKeh5NgALr0Z/8MnCVFM21l23XPkMR5CdyJQ
         MgAlOc4UYopa4aCsxTYbq1/SxlIjFjIxjRbUVerDXiffK0o3VcSOJGhpC8Y8kTJzuJFX
         bR4aasgxx85+HoboAYAJfeMAQJMOU4rwY+h5LrWDhMR78obaonHEwI+P8FgqkQY7+EJu
         yeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746155; x=1793350955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dhJsyioNXqoe/67sGFvekH2yPgEUsEgy1mmIhMnO1L0=;
        b=TWkX3y1b4Aln6AIfLkz8hgEoqFIZ+FsSdj3Xxbcp2KlVq8JPaCiTCQUH/BAXGT92px
         18A9ATp/CtWi6++xNdQCZLpcLXKUYyIZRP1VBnkcL+pH9dgTgnIUSHevVC41MPDcJe2q
         9CDV8fU0bUPXFo9UWXCjVCfCZGSYXiJGePWothbV0rOrxDF0X+zLXgPGpoS5kl6syxzr
         Ki+CoIwqMLhVCQg/Bh+4Z68TAmaL7Gz5XmGkceQDEPvvRiWVbi0nCN/87PBmJyBEPn91
         6hbzx/QNt7+BDkAYkw9D/TBy6BlhN/zPr5oK5/uDEUmRnRoZCjEvAPFEaY6gicptRZAu
         EvSw==
X-Forwarded-Encrypted: i=1; AKwUvBxPyXIf0iXBy+sNT5zVkqblq+efHO0Rj66muCH9jDsu2VIxtAESSh7cconRVDFM8feIIr6XJvo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoKPawhdMF8OC80ZdlnERipFJ5ewP8rY19J1FL2Oz4wQ+WSU44
	ahAFNK30DbwmRNKbodxhP01FzM+bCFh9ldeN4+U1eemkDrUNUYFeKAOzKx+kO+kucYu5VJRQNMq
	G6MnhDz+so8M0xN9/+8kzfh1e2G7tVIVwm0YIzP07H7JltAlinc3EtukauNs=
X-Gm-Gg: AYBFou3IxNglO+GFrfrmwNF06X06EdmKf746/QczRGh8Z+WB4pMXqjd170Qnve2V/nc
	n7PLNo4hJT2/o0O7hbipfEYg/oVyKwe+VuFUCDr8ntPLt/N/IVKYrGdMkU4crNTDfSucE3+RxhW
	nD94Fr7Z1yYBjdViwaEJiEBZ3/rfmsPspApdMuSELmKKJ6K9lWw/MA+BMchGTCwO3swVwvsYk3X
	zwNQNIhDGMLY9jOpSbQ1ipJ7Rgfuf3SivCupzM9DsXTjWrK/FM4ANQmOBQcSlhDtRIrbetRxzVM
	Hw++jXNOuJX1RKMDWRebIKaCd5kjTKaPQRBf9sXu/wz/UE/nQWXLqY53kZ9mOZpS1pGmg6uzsyn
	wEETUF6i40yH1AXYSe7e6GU6JVsqc
X-Received: by 2002:a05:620a:2b83:b0:93e:53fd:413b with SMTP id af79cd13be357-93f6f842247mr289308285a.59.1792746154860;
        Fri, 23 Oct 2026 02:02:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2b83:b0:93e:53fd:413b with SMTP id af79cd13be357-93f6f842247mr289304485a.59.1792746154390;
        Fri, 23 Oct 2026 02:02:34 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a215437d4asm23076245e9.3.2026.10.23.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:02:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 11:02:22 +0200
Subject: [PATCH 1/3] arm64: dts: qcom: lemans: fix iommus SID mask for
 ethernet nodes
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
Message-Id: <20261023-sa8255p-emac-dts-v1-1-a34d778ce9ac@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=23zIhhjG8pQRTvWHr3LJ96wEHqil9xLHbjMCYkHD1FE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2yKmO6d4+s9JqHLmKoIpODEaDepUxCKmf8PJL
 1w5h6UACPmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatsipgAKCRAFnS7L/zaE
 w54ZEACEpGL3pZO5XBAbCX9VJxyYpEPSPtxS5TGEz1AbtEDT7hmcPpXMu3Kp8igAKvd9n8CFkEA
 iJZeIrqdLuGnhN22hkew/SvCvXuRDasTxBMGDNPJoZqD/oqKj7iS/A3tBFbwBaUNoNxwbRNedJt
 d+wR3XUbIRkwH9L1aMcTNLRy4oHpKkt93+RMhmF4zF+S46F3qMdwMWgnczM8ZADVcyhhBvY1vsT
 KlLGO36NpIUBigutL8M282Ybm0NhPqs8as5hRhl2BnkmFWnvqmqs2QrT5k/+jxl4viizSQ6ANfr
 t3mkxr69pp51GpFIBXuDTHMw74dZq/bEW+EWneUJFlogC5fe6N/xN2GlDs5cdh5vBFRjsNdRGxf
 OAIqC/qUbd/dMtpYiYMlrszeTGYaICOuQXFAoChCxizQ/taE/tP/aVBa317EXwOwAtT+IS8Ne2w
 T8d2zDOd2c3/1Na4KQNPx9m4czPBIRh6/zwQrmcqf6ABFBFi+5+YT1moPaG+hI3KBb+Fm6SVLlv
 fKu8synfqG8KQof38DWGx8zLSHDA6wjOLdrcydm+FYvrWRygUb9qyuHNtUtwwthZ9cFhg/cnZww
 r/ELRwB79Ej9GTMydc1Ro75zuFCD34PcgLIjCyhfxjKMorSwDdCbA9v+uSnr2zWqvGitherxrNi
 ATPklPe84iD9fgw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: IeZCVykMC29xO2KSuOhfP9eIGwxFY4Y2
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb22ab cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=jHMX-OgH2kBFWhD5V08A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX6GDvPvLr0Ewe
 qsFugdVZHoITGH1IALYve2g35LCCnNrVpLz5eB0RQFhvbOrFwmQpiAHB+O1vgn2oErjWeBTgVv7
 uJSZ0RN/86dpPivmEuiuSXc0WV+QyWo=
X-Proofpoint-ORIG-GUID: IeZCVykMC29xO2KSuOhfP9eIGwxFY4Y2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfXw3u3pFrWSp17
 HqiWpS1SeFIKaWo+YUR8a4FbXbnbnR9hMlYCUt3jw/EZ4v1mS+l6WD0AJzaeeuTjNRgEEV6kAdC
 M35L5Z2DGtY8+0D+0+2v+vGHNAc7sET4GN9lWCESjjG+0oIVY04wivoAZrSz7qXjQKEifn/NdBP
 pXyFV7iTFZtczPk9r2guGLBGtwKf9i8Lb7JQkSxzTrnQ/s0IWPBumWe+WkSXgnaawqGn93hxYIp
 abzLXrhSQlKYBJbZYh7/5y6g0gAXyz8BsLSCu+pVJQsulZ/K4HAKH4Ikz4ziqfnyMFGNlmpBUeV
 lA5bS8aqLxYa3X9iYCiT0H9AYlUIKCSz3+PBSSMolRZ8M3lvu2X//jd8+pecYmn/cAci0iDGlih
 f0i+4K6XTr0Mlae8UMkkIZhXQuf9yXywxj/Y3FBOwTB9UAVdGBYVCaA+LwOBj05h/Xp2xn2Kc3b
 87+esGkRia3N9OZLzww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035

The iommus mask for ethernet nodes is wrong, it makes the SMMU mask 16
stream IDs per MAC. We should actually only use 8 SIDs. This has
triggered a crash on sa8255p after a boot firmware update. Use the
correct value of 0x7.

Fixes: e952348a7cc7 ("arm64: dts: qcom: sa8775p: add a node for EMAC1")
Fixes: ff499a0fbb23 ("arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index c71b1a48c3832bb40abbfb7d771634f4d197b0e8..da740a0876d4adcff0bb9458564c868a6f406b0d 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -4395,7 +4395,7 @@ ethernet1: ethernet@23000000 {
 				     <GIC_SPI 781 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "sfty";
 
-			iommus = <&apps_smmu 0x140 0xf>;
+			iommus = <&apps_smmu 0x140 0x7>;
 			dma-coherent;
 
 			snps,tso;
@@ -4416,7 +4416,7 @@ ethernet0: ethernet@23040000 {
 				     <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "sfty";
 
-			iommus = <&apps_smmu 0x120 0xf>;
+			iommus = <&apps_smmu 0x120 0x7>;
 			dma-coherent;
 
 			snps,tso;

-- 
2.47.3

