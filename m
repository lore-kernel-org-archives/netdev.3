Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143952;
	b=ssKwtq+y0kSsLy+ko4xLNdMGBD18zVCdbC1D4MhCcEp11v1J2cG34p3Xikd+xX4uH7dg
	 zoZPBLEZ/aRfFWzRg0h9pRgnVHytGAiY7R9s0h3SlH8gGkZOH6sD2CoD48iLA+lkLb/D8
	 zY9vOZbqRi2ah4QrVhm0rVP2Y/7hNsMzRW9NadGO0u73M+FaEstrAvDDOd+Um3WToMes9
	 Y6efKGN/OtSF3jgaTEOqewRQ3H7PghT58pStI4ztZpLMvYTlZKEL9Ew5a3cx9HW0Iqzgx
	 cPiocph5Feaq0uh5MK48/acc3lMyyCw03IT+XtZdwZbMLMDNkhFRhimIMWScdoYZHhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143952;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vgpTIWVKL9fxj/Y8qEh6EoiYPWef4bzE6JMDE0rg0qU=;
	b=e9Xv6zEX/MpWWkFxuGD5KTfdendZYCAR71iXarqiy67s03QalPFcocb3Dsi2B0U0J70i
	 cByLJVeaQiW8CXEu3te1C0SU3iwJIRWDzsJ0FHQTKSul88fQygXPfKNVo6jQsNkucH4ZG
	 bH+GoVfLB6UT1T6mt6UANdYxGqIesiMrcC/KDMjdxv0u5M1S35jBUBaX2SUMWLs1VKWz4
	 L6m0ES0xBmf3CeL9iQOR18C5asOCWSaee7s261cDxs6hHDwxa/9VY1ED6mnv3s0PNWYn0
	 joG4Fyt4pybRGzmqWTQCVGYS2TYUzdP1XyZloHWrmqXhPaRpBzaINLq9kxrhj0pBpeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DAu2P4N0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jiXxBruu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F493606A332
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F493606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DAu2P4N0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jiXxBruu
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8Ag84j2209328
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 13:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vgpTIWVKL9fxj/Y8qEh6EoiYPWef4bzE6JMDE0rg0qU=; b=DAu2P4N02RQhm6JY
	WykbkYkBjwjNzqQPYMTZJw1er8ZwU4u24Ng6aGkUNw6q3Etuhg8RwfJL8cGGvCJF
	TTjFoNjcfAUBBBWy7+a+QnHxCt+69EtElmmxEB4gc09hSwHgpgEJgjwiA184883G
	aoItqCQp6Zu4mUIlAEpi8w4Tz0Owyq867P7n7Kq9o5Nb2bhMjJ46YVJIZTEF2F6b
	2AK+g8w0nvpHy1d5v7lYHtH0LPeBNLNbIVLvn/KCg8FVL9QDw6qCHzWj0cLYgiuG
	ntUuAnCbH+af6AvG1ibUCVP/K0DiYLYQTFPNzWjD+BWB/l8YIp7jt9eleCuFb+sP
	03BchQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsspf39xg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:19:11 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1af203073e0so133912c88.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794143951; x=1794748751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vgpTIWVKL9fxj/Y8qEh6EoiYPWef4bzE6JMDE0rg0qU=;
        b=jiXxBruu9Y/CeGVYbaF5Il85TojS5XNv6xEKiIxOxQ/3f1ukZeK+l267oWvikNTPW3
         16XfM67mdbjdwXgqa7/J1uixDcaalo48Hs+Jt3V48RGHPwRs5DBzHZ4EaanS2So5xuaM
         HE0hmnbMkzbUFtJAknzDhY3FNw7dDR6mmVRwZC+bn3rDUdR9SCyUSgSHz+FO0KvRNR4K
         9qe26sjWk3iFKLgBkO9yTN75g2kZ6g4/CkuVKHX9qMjbp3vv3AriT+juR7UjqVOaL+57
         Rl8+wMFkuCaLPxCdMzcuS0U+5liuAfDB+6x3gpk3JRkz4Xpci9hzECahdV2VM23wKbJk
         ckEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794143951; x=1794748751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vgpTIWVKL9fxj/Y8qEh6EoiYPWef4bzE6JMDE0rg0qU=;
        b=iZYkN7e4nIiIzWSWxNFGVJc3JTx8K/o6mjxQu7dG3ZKdrbKmkQI1qFYrZGzorpps1q
         IJTh8xpSDa3CWC6MPsAcbkVXjbvLOvUO9tSqqzInBRrj/3TIcHJlAA8emdUUV9xS+Ikx
         dEzsox8veies11jnMi6ncFHDjjjDvLt3xi8hE+XozLSS3LbiZisOf6Fw4hG3L8XYcIbk
         xUqBU7lZfYOfF42zSnt01CUHm1No035w+EXkdZ2418rPmh3AxlZF57ski9FZYKUQTY1X
         GnAwPzRbxXGSfglKJDbScu2HvlHD8KRusaNxYYkuo1d0aVgyFC4zHZokMfk3aPB1SjwC
         8Zfw==
X-Forwarded-Encrypted: i=1; AL+hErEoIVrrM5WGqYLnl4PsDv6NUe8JWbBIGauHHmLhEd24THQ5genwKGzsKirRExzDarIU6LSNyJE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LiaZA5d+CeP85YFF92UOz8pdY1ENKtRbIklOSgLp9PPQBsmpC
	VnBUN4k0yHm/zYQT8nuqa7oeL4I9bdWvIABaWF4EvtJpmOxbX6Cz7MByF/O/hD7+zXipQpJm08B
	7vDyJM8K+YRzEC4St2+4GR1EAqvlqvALAiI39Ffr4dBmFbqKiQoGul5/ScI4=
X-Gm-Gg: AYBFou149ISaCG7kDQsD4CtkU6Tpx4R7cFmFy58pvI3WgWWBeiThKmoCtmXGzfR/Frz
	xIdHQ0nyFLOsryvUyU7xihHksacM4SxKZ0rEx9vs1CCcTGPS6/uuJEtswYJxH8qZSQOgOOkM7Uv
	zrx0DnzMKC7TYF30ESZlWyp298ZUlODOFZOJOu92O9HGBQMRy+P1V/hi+BGex/3iEOaN0Zkg468
	yWUmaiWm+81oAdZjE8//zwB0idQv+UqaWpEIXcY4wVX9iTLEHLf6pwE+g8PaY10xchxyG3L4rLI
	9MKSgRTILq162kY3pDYAYY+mkHv4NYuakEIAI0mvImUMnsHOGIY88FooNTeVXrwsIPqYVVe2rpd
	uX2IJx2j1vflmJe/qAtiK2WXVEhM+GoKAjSp/l3zAaTMdfTHLP3OLlNkSC8i1YY3VUwzYXfib2e
	6L2kE=
X-Received: by 2002:a05:701b:4252:10b0:1b2:40be:a929 with SMTP id a92af1059eb24-1b39fec24cfmr2288470c88.14.1794143950660;
        Sun, 08 Nov 2026 05:19:10 -0800 (PST)
X-Received: by 2002:a05:701b:4252:10b0:1b2:40be:a929 with SMTP id a92af1059eb24-1b39fec24cfmr2288427c88.14.1794143950085;
        Sun, 08 Nov 2026 05:19:10 -0800 (PST)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm5336980c88.13.2026.11.08.05.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:19:09 -0800 (PST)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Sun, 08 Nov 2026 18:48:27 +0530
Subject: [PATCH v2 06/10] arm64: dts: qcom: lemans: Add support for TSCSS
 node
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
Message-Id: <20261108-tscss-v2-6-d5f575010427@oss.qualcomm.com>
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
In-Reply-To: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX3VPuusxZt+QJ
 PHK0K3e9a5v5+avzmAbq6A5VQbrKSafti6WcyWSDtQRzFEFPI64mHr1ijjtyVo3nibkCpAORhKJ
 P1SgoCIQxp1DQUfCriCI2+DPzDZvVN0=
X-Authority-Analysis: v=2.4 cv=LJzz05W9 c=1 sm=1 tr=0 ts=6af076cf cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=cV2z5tzyjUHL2YBgtoMA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: U_-yFxYDGx6WQENb8Yky_nuvRx90DNz3
X-Proofpoint-ORIG-GUID: U_-yFxYDGx6WQENb8Yky_nuvRx90DNz3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfXwAhwC6GJrbLR
 VGVfhqTwHLarLD+H5hIj19aRlyoOX229o+ZtWTY0xBXK4+8idRitlPpV+uBZKHxK1wfdUGcDo2x
 qwUZ5BAEWQJcjp+coe5TyQeQ11CQCa+GTZP4xJ0Fmpt4T/sjcGxR71RYPIzlOMdgtoxGSMGdhha
 bxibKOGadVQ+vCEkUCDmRgbtLhxNEpcd4kKngRbi4Xeh3xhGq/GSQGpKJ9rmSZ8WU4SC2NiVEHC
 ar/RbjPfopf4C+ln9/5hHoE99cKyLLarGvw0jDmsIRF2lnWP6qpqUb0JUFx9P7CULqgKOj4RVOR
 mU9PfKnQfHqb3FT4UuEcXfUbhebwM2SqZRaOX108jzDLUY1HDmStTWJP/nuYEv+PAcy2ZsLYz63
 1rhs0Dg76ZdMwoY7z5v9B/oyYc9ppgaT6rGQhL3/ZFHaQ65za8lN9cyRZqMUHtLyE38tW6n4xLr
 h/wj2r16JmaVmPaEZQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611080052

Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Lemans
SoCs.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 1fdb72fa5518..4c76c820cacb 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3022,6 +3022,18 @@ pcie1_phy: phy@1c14000 {
 			status = "disabled";
 		};
 
+		ptp@1c80000 {
+			compatible = "qcom,sa8775p-tscss";
+			reg = <0x0 0x01c80000 0x0 0x2000>;
+			reg-names = "tsc";
+			clocks = <&gcc GCC_TSCSS_AHB_CLK>,
+				 <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>,
+				 <&gcc GCC_TSCSS_ETU_CLK>;
+			clock-names = "ahb", "cntr", "etu";
+			assigned-clocks = <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
+			assigned-clock-rates = <15625000>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sa8775p-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
 			reg = <0x0 0x01d84000 0x0 0x3000>;

-- 
2.34.1

