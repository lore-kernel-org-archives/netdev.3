Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143978;
	b=tcegqbz0APJnyngCAPseUZhhV2mfMskZAi0+N+v5eYHEGBmpGX1VqjbkU6VYD2xEKDmd
	 0vVKXYZq5f9jnPtLu/hTw4hthzc/CZiIZoFi7Y+Ra+/1tz8iJHCpbiZ18UxDEoCAx6AFx
	 MeUBJKk8oVhMI/eQ2IDDntoKtJV/Hz94QWDzh4IdgB/Nl/gk3QoKDq1s50W/hmHeh5826
	 pt4tM9+BJpuM4m7rX47TJUQNn7bzrUZerZ+396Ip2eb0WElpvAs2EkixOCwx2kgkdzp/+
	 SX398cNy004Mca7GZbV/z5U9Lf5IQJ1wZux3aqXQRKnkkEt5Cs0h11QSnrg3ciVdgVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143978;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=os3+Z3gmGPhuuIdUXa0F0UdTAjPYMsTLw1Ci60+60m0=;
	b=PdeAc7W6S8lA8fbswh66z/v7IfVwfpu+pCW3fH1NE8uSG/J5Gvz+Y8apratfHpyRRLid
	 SK3QLPQMmo3Q3VrMVvDtP9BEZBehGa5rUopVX9NKSCPKJ7WplGKcl5y/8S03mmnQqSLhV
	 hCMrEHNdhM8MvnTUIbCsmBtKoW+Flelq+HRcxWRhyfpqZ2nhqeWW5/XBQeK/zHKj/oDIs
	 wBALSII6jwQ7a3Zdox4hmmnw0FfDAQO0E1VD2Mekp+15hJrw997nE0ifadD7y7zJYliVU
	 brrjTsT4FdliqWQOPuozT8Tsj1D+ORua6a4mk0/OjctHDn1QwwQD0h2fZK/2pUROxXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oqOeAZcf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X+M8Lwee;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615F606D819
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B615F606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oqOeAZcf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X+M8Lwee
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8AgE1L1249914
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 13:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	os3+Z3gmGPhuuIdUXa0F0UdTAjPYMsTLw1Ci60+60m0=; b=oqOeAZcf1CEBgkNo
	osfPDYo2JSn6y4y7fric9epbL108442IsmosBfdD6B3zuzn9G7n1+chTak2rCo4P
	acnZWxaanxa0pzMhgcD926zyEH3ADJkBL/9gImOYXkPLjNAu7DIPXS4vbnGwqNRb
	MDIbXOrhYo4HkTxJHXOzF+APh5XKl2J2QMpHoNZTzwn7tnk1iBGCHr0EgN3m/IeB
	GdExYaGKmsFjHfVGW/N2sNhii2PWNqRXDBJdOwH+KGk5F0M6tmCrHv15GgjCAy0Q
	DCaSMr8StG6/27ncMjwFHZZM+UyDkdXSglPoXGZR8GQALPqQu6khytbj4kdIOGPD
	ibm0Zg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsv2uax2h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:19:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36cec75d8caso72059eec.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794143976; x=1794748776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=os3+Z3gmGPhuuIdUXa0F0UdTAjPYMsTLw1Ci60+60m0=;
        b=X+M8LweeeHu0BRPZnpXRxOSu/lsgE0c4EtkF3WPdg7cQ95kkkvQYoRg4O+aZDEzzMg
         y50E0qk7WL3pz3AweRW2RHVlNAYirWl/8NetZPxHFa0wZZyD4Pv3uV4n07sAptBjNC/g
         IVdreBGAtD7JVY4y2LcaGhBDtLWI0KXVyNFix3VF410JAzaSREi2AKzL7fnix8gEpHzO
         CmY/sjs0y0fRQtGxGLpT7D454AtuuB0MJRaBaemSHN+h5nxs8tWqJ/hsLsMA5sRuvwjp
         erd7WQFBLIj/RkUYOMEoV3yFjXrDVOES+ADTu8Rq8PAuhLJWkIr0XDyzpXhOxrKeFWwz
         itiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794143976; x=1794748776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=os3+Z3gmGPhuuIdUXa0F0UdTAjPYMsTLw1Ci60+60m0=;
        b=X2BSOlTl0Qc7lyECbn7ZLG3S2PxYpMqq8Jnr3/sO6RPFDvziqFntaFu2o0/ZpUKBuN
         ERzjqJNIpfXp77+V+RhQ7bMWckjVVRi87e8S/ovjZhqDHbEQr2EAApbsYdVbZoGYZTwg
         VMGjOJ5QjJ+ctAwquOKBpFirF6qOE0KL3E9+49lwTHgV3s4XbYfDXKxzVe6CfyzwCi2I
         yhUDPl1BP2qSpkjwrKYWRtw0oTHSAe5GwIudAtATEc6wONkpwwoVKUI62HkUoHRYJXKX
         zwrHOospkF8xjd6/WfkibaTdNj2KhGG5Y6P7iMnZ96C5MzteZGn8brrx9y/M7wFdKfA5
         3zQA==
X-Forwarded-Encrypted: i=1; AL+hErFujtmI4AQ1kbSacOBfM0KD3mSHeRKV6yoHmK5nJSloRjb36ETrAWNAyAANBcnngT36pdcUK5M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Gi84yzubZxc2kb1zg/MtQzwMX/zBpGTTzZbLEoWrKHxkxWhEf
	2A+Y/2CiYsY6wY/BVn+GNsWj1ZIlQsrFtjgY5eLItMN9omEHydwrl8qahuO32esDzpSQF7L7at2
	4KKZnwRSViRroYoVSEiQnBuaOLe506T5uuWyY2rQanynbLTZE1ZCs7vdk+6A=
X-Gm-Gg: AYBFou2DWMbFL6R7RJ5NU25koShuKAojqSGQzblMJpkAIZK5y/41xgZUdCyIcdCZTGZ
	xQEqU5f07Y3I5xBjSIbgCMwdwkkWeIjQoLJCiZZdLX9O87piy34DiK3pFwtBQhHsTzwSOSu7SLG
	Cp5dbLv0eWwq1kSrzDTnJinAPbpJfvCT/4VfsMNzsjkoE6UkjlNXecId28VJbhsTn4o8T9iba/m
	OixGEXZNp6rONAMu8eACQtfoYZrS9rwU/9jB5GJMHICMnx4krblyEsRAvbmcDZfYuGelUbRoWz6
	EpVuDMRuuGfC7nsCJXrf7TRu/tnMGqolQqevTzUPzZaTbmJdsF8kB1YkYwefahvhgK9U0h5a1Ga
	rUcOMlDJh3/n4TEFtYPl8OBxVxFLNKf/QqhrxIJsBODbWNYO6Q5otaDAUY/v2MpMeljHn2+4Jp1
	I1CdA=
X-Received: by 2002:a05:701b:428a:20b0:194:e9e5:11b0 with SMTP id a92af1059eb24-1b269b0c10fmr6631576c88.14.1794143975516;
        Sun, 08 Nov 2026 05:19:35 -0800 (PST)
X-Received: by 2002:a05:701b:428a:20b0:194:e9e5:11b0 with SMTP id a92af1059eb24-1b269b0c10fmr6631545c88.14.1794143974998;
        Sun, 08 Nov 2026 05:19:34 -0800 (PST)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm5336980c88.13.2026.11.08.05.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:19:34 -0800 (PST)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Sun, 08 Nov 2026 18:48:31 +0530
Subject: [PATCH v2 10/10] arm64: dts: qcom: nord: Add support for TSCSS
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
Message-Id: <20261108-tscss-v2-10-d5f575010427@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: fmVVUJjMy28Di8PfiNmrULj24epim75R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX+5aZaHtZPfXs
 WVZ779bxAPJ/WHBM6tYpu1EYQYwgUxHbhQXaAU9RUGuf+VuFtKNojntnSZYohDH2dcyS8iy0DR8
 V1G29FZ/a3dgfJFv28xGQX+eKk4JXB8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX7hYSyRDa0Z/g
 FlIIRmbDn6kOabvxLJGmUj1KZKqLXKkfBn0zAbYxJh8NLTukMuy34WhWfZkVQWrXWhGNH4pt8BQ
 NpbvOm9MTvBmaNdCprHxLUhqH+0tk/hkvUAs0dORFsZOX6WkGT26/jwusdYSsEC95kaRaxW8TI2
 lnXrUuBnBgNpyebbs70TkWozsb6QZPLPtOvOOURX/gtvqED64wTLnTSFuQ9TM8hMP2R2TQZAxXd
 ARVkt8A42DdZu7N/Lnnjhe3GzwZ2qsroAZijjwCqD6ElJ/WqvCxfp0E9EAFe1rG1PvAecTCRhbU
 zxq/xTf08jpRL5d7K45JIQutDpFgA0YDuVKw3sfMpq0RhbIdizPUsuFzv579CdlkmCypX+3BgbI
 7sdogfRhIKcXlr1PJj/1x6ghxvYoGntgeRaNxgzPF2P1u1AoNa2vl3lmeGgnwGVv6A6B/8bqkEo
 RALSLm4pXQZmJcXFINQ==
X-Proofpoint-GUID: fmVVUJjMy28Di8PfiNmrULj24epim75R
X-Authority-Analysis: v=2.4 cv=f+rdl+yM c=1 sm=1 tr=0 ts=6af076e8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=CYmVgZtmzWouJOFkMRAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080052

Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Nord
SoCs.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/nord-embedded.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
index 1ab7d9bc3cfe..1d5f27336f73 100644
--- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
+++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
@@ -736,6 +736,20 @@ pcie_data_inbound: interconnect@1c00000 {
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
+	ptp@1c80000 {
+		compatible = "qcom,nord-tscss";
+		reg = <0x0 0x01c80000 0x0 0x2000>;
+		reg-names = "tsc";
+
+		clocks = <&segcc SE_GCC_TSCSS_AHB_CLK>,
+			 <&segcc SE_GCC_TSCSS_CNTR_CLK>,
+			 <&segcc SE_GCC_TSCSS_ETU_CLK>;
+		clock-names = "ahb", "cntr", "etu";
+
+		assigned-clocks = <&segcc SE_GCC_TSCSS_CNTR_CLK>;
+		assigned-clock-rates = <250000000>;
+	};
+
 	ufs_mem_phy: phy@1d40000 {
 		compatible = "qcom,nord-qmp-ufs-phy",
 			     "qcom,sm8650-qmp-ufs-phy";

-- 
2.34.1

