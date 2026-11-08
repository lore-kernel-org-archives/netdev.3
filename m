Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143965;
	b=w7osvRb41zkkIXM3+j85gScH05rpfi5ZVO+DFZVAmW4XgellZqp1gX1BRJQhKjRy2QjK
	 n77XU/E8Wx/rksKwrNuxYqzAWlsL7s7yz2jkBfR8fax0agFZWnnSsnRrngC576FcVImnG
	 tVWh+gPrMnj2Gi5GaDXIiVRcbT64ZwAWqa87BF2m/j4RUJ4uIMFPC/LnOL1xQ/Tpou75L
	 V2xQFOIkyLhySaEFgP/4wjbJw5yPKKdVEhxTwaZTCZoWIU9l8BUeRFgAVPXRZRf/cdT38
	 ge1Uluv6t5fdVFZxpAPHF9ThAf5AfOJpDMASzSMOgzX/F5qbpv9NPcYOSUqYwqRmuOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143965;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tycUGBo04V2tJ9M0m7P2ygrulrL8aOOxnCufNoWwtwQ=;
	b=2u7Yd0Dg9HVxeBnQyigmXgwcBigFQawi9061VGvRp1BeekIoWvghl5BPVcxU8SHgZV5q
	 E4aeowltYRxSjPkAX2R4mA126PhDDmLKiBeUCgVE+qV1CBA6bzrUI7odkWy8HQipfoYEG
	 zNu74EqFF5aHrTJscye/fJLf7nVgsX7Y6ll3WYaSWVz1GRCTfEFn8uGiW5WYpc+GParRC
	 QgjQ6c3Xmp2jthWbn+mH8DPIg2hXFt1UCiKtOfGSyibjmIYhScbzMZIrlln1LRpvGo7Tw
	 GKeKKlzceRyuceW2PERPev6njeNeyeuc6En3s+5PSosDJzCTmQqhTqXtPIjtsbI0h1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mJb+vQAK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cxvu3Xtz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71954606D807
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71954606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mJb+vQAK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cxvu3Xtz
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8Ag8x11858281
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 13:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tycUGBo04V2tJ9M0m7P2ygrulrL8aOOxnCufNoWwtwQ=; b=mJb+vQAK+qKuQ5vs
	Tsruf/KqugQbkXCuoGn/evxlOTchE1/QLQHwJBXXn169QltrYvv5wreM0ua0efwk
	T5vmFlSCSynprOjKS8/xdzHUiU7QlKIrfo/2D8c3wmvJvu3LTZ8hxQB0CESQYxBL
	nrBconEYbjucACCcu4HDt1c2eIVpbMpIeuU7/3IV5Pecj8MEJX0tHexTBS3vXBE5
	11422AiNv6kTlZXOBxwq7jyh/XhoocDCLOIFrmC9yyUXcEBTVI0vKCKXPl7HncCp
	RcNRA1cTFcz9PjZdJIuXdBVRgMWkacbLqVdWOJBWIBtwQO3Tvlmh+L40CsAB1ri7
	LI+zWg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsu06u432-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:19:24 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso218462eec.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794143963; x=1794748763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tycUGBo04V2tJ9M0m7P2ygrulrL8aOOxnCufNoWwtwQ=;
        b=Cxvu3XtzGCc5/7HWJ+EPA3OtQIY8A3fLLHQYSqEj+71QrML4dlQOF9kVArEoWjoKWB
         sB+LwtbxvvAEc5BUmGulQTMN72JkfZr0iK4HK4YUia68tXXuaqLH4SzcbsVxl1hr4oxt
         Vnqs2gDFKsWTmFKMlDN1auQAvptr5KCMNAn5IpppmOOSvdMXIHCIlu/lMaTLG3VetO/d
         6c1rosYtouuYd1fPKtN9s06USdetZrBk56wcwuQo7lTtMBQjeTcvbAYo8pP3cl+9SdMF
         +WXA3Sea+85gB5vIVrHupEARO5WWcp+2T73hSQ30RRcx4cz7+soh2TzHxUC5l+ZiVHAb
         1fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794143963; x=1794748763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tycUGBo04V2tJ9M0m7P2ygrulrL8aOOxnCufNoWwtwQ=;
        b=yYJtZwnlGqFflTpJwikAUQkrw3/Y4rgUV1PIaSUs2s3mtcObyQaLPw3ggVj5kl9cGx
         Sdwasv7dil2CxV1dPpZlMbMHz+98jzUOHrmqEWYURQ6TXlrL3OPu1j/663GIvm+ve6yB
         jkTR1wFLxvNAxuIv6tL/eZH2pbHMfSxsTGwuLxW5j34TnCgaXvKFQILOArfcpc7Aii6T
         x+87kvsivDjQEDzGYH7hhK9/TOdH/00VeCXHpoBrVp7H/z/RUQnWp1JgYPLO5FV5Ldp0
         JFSflQRA1P77iTu/QJZU4tK0EhTumCVhnbzUw7LxooHnC2U0i4LpigcvGQck7JfMRqQs
         7yAA==
X-Forwarded-Encrypted: i=1; AL+hErFhn9DxGV379+VwWILSkdR0Tj4O5uc5ExymjttrC2toQ0WS/ZAC9eAtXeUBTO4mRPM/gIOHkSQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bxaQym1oi74sNhGMPB/PhelcvfYZGlCFTnXth25y4S9O3BGfk
	bJ7pjFvwuF21INAKvfBaNtYmref7M4KbH0xnlnxrQ0V2DKIYE15++uxPS0vVMTg3wFslGSijnC5
	QabO4uTAfZuaovLFKk8y73WaO4RBMmaHaOkuHnOd4+qL2mFh4inb1Jm2cO3g=
X-Gm-Gg: AYBFou17zQHoVxXqDLVuZ38QrNNOngA70AR2cryx7ttrUMeIVPkyz19HwSv608eTKtD
	N+KXZ9/FazSZwYPBtiNVF3Z2ZfYEJjNYISGEnmfVcdzqM4ejEIte4pdQSo/LG41SI4eDNSw/GHA
	CaugpVvD05WfPe4f5hncpXBdKflIrwch1tRWJx5nW/q7F+kWK93hba3DOKyKoDIE69T/3ZNO6Q1
	F+pAu32ddR3UUjUtKsg92sRQEdR0atSc1wvDiPLfVDTi63auBZvGl3hPSCrZ5nmohG2KDm1ITUk
	tN8wkWrNs0seQk9QfzOIxN9y2L77m8Lh/AOnFhHpAZsKgUq8swVtesKW8lWhMZr7WiaV5hSpY8/
	uxn+UDH787ySqjQVVoQ46s+LJI9ytY5CDKvphP3Dy7ch5oxNsW4WfIf13bHEzcNI+7Bn6ox2vFj
	eUC/Y=
X-Received: by 2002:a05:701b:260d:b0:1b3:90f4:499b with SMTP id a92af1059eb24-1b39fdada84mr1929533c88.0.1794143963119;
        Sun, 08 Nov 2026 05:19:23 -0800 (PST)
X-Received: by 2002:a05:701b:260d:b0:1b3:90f4:499b with SMTP id a92af1059eb24-1b39fdada84mr1929501c88.0.1794143962553;
        Sun, 08 Nov 2026 05:19:22 -0800 (PST)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm5336980c88.13.2026.11.08.05.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:19:22 -0800 (PST)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Sun, 08 Nov 2026 18:48:29 +0530
Subject: [PATCH v2 08/10] arm64: dts: qcom: qdu1000: Add support for TSCSS
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
Message-Id: <20261108-tscss-v2-8-d5f575010427@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX0Cy95UyXP99x
 0/I7kMLKThHN1gow/TvBHLcld6HU17aBQHX5/wPTgokjl5XpmxmdWeDkZRwoycgLf2/igUMLHGd
 KUyOEKXM145NcFfsENsyQQ+NVUWqVAtE0jXAHj3hT+FI9QXpCXlYNU+gEZaMc4EksF/iKr7hcje
 GIVI08vzU4Uz6vBt5GYNAAG8D/1rwDFtHa6tJ89X69k1wfdvhHgleC75UPAvi5X39ZQ5tT2BPiZ
 NZpc99/WyLmjMXxjcomo5G3LFzHaNeEVH+jvUOWSXxpLT4UAFCMT7bkpMXGN3txdQ0hHCZY0jrk
 wedfRdE1a2xF3ZSO3s0nB8ypp1OsyFf0Nt5gnf/Df7xQilqPZgNJ4Xkq5U/nsA0t0OPq/KDpPfs
 Fup/QioGhJBEtj5B79BN6aFXs9wGLHV09S9Cmh4sS6VzmCYZGXpOe8yxpqe7FP4b7hPRTXoxpyg
 0PejWKs2NEeLuKBc5ZA==
X-Proofpoint-GUID: MiLROY-SBKpOQMa3Km3Lhua7c3Wr3RX5
X-Authority-Analysis: v=2.4 cv=IJGXmQvG c=1 sm=1 tr=0 ts=6af076dc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pCDFdeNEuqTB-y8mxvIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: MiLROY-SBKpOQMa3Km3Lhua7c3Wr3RX5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX+5X7xDxPKNOQ
 1G4+YBXXVOlm38IrZtIkToISoNboIZBTE/6YaiQzondCXzx+U3ETXzhvOPfe5cwUSNRCku/o+pf
 kaO1O28M4nSgPgAjeYND00JcQCx+sHY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080052

Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm QDU1000
SoCs.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 3a25b5100836..0f4028c41b2f 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -877,6 +877,19 @@ system_noc: interconnect@1640000 {
 			#interconnect-cells = <2>;
 		};
 
+		ptp@1da0000 {
+			compatible = "qcom,qdu1000-tscss";
+			reg = <0x0 0x01da0000 0x0 0x2000>;
+			reg-names = "tsc";
+
+			clocks = <&gcc GCC_TSC_CFG_AHB_CLK>,
+				 <&gcc GCC_TSC_CNTR_CLK>,
+				 <&gcc GCC_TSC_ETU_CLK>;
+			clock-names = "ahb", "cntr", "etu";
+			assigned-clocks = <&gcc GCC_TSC_CNTR_CLK>;
+			assigned-clock-rates = <500000000>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x1f40000 0x0 0x20000>;

-- 
2.34.1

