Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391271;
	b=IqkHDBztK6q3/6D1MpLXDwkP9VAlkQoUud4yj19R+sYapN6EbuRe5m3JVlUBK8jftP7o
	 hhRk3FtsGNHsh9SVhtVgx+faeF+dn2J1cHnUP2GadIzw56Hy9YGebMYZnGG1rPK9KdmeE
	 zM2Ph+WH6iOUQ/261g7RWZOV4Al7igbtemvyScnyPf1l4W9XBv1x9PoeZF3APB+GFq+HA
	 FdwwgHLPXBpVS2mFz8sr6Q/FeJaBEMseHoY8HGm/0dVbyeOQDUyayHDLYIImwo4oKKRZZ
	 srD7/qogou0r+V4yT0zMEmh6VC1hQTTBrwmZetZDc4SHesh8FENYDMLoUh5XJ8xmd2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391271;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
	b=Qglofksr3E+6g6I3pqtIIyls1AHK8n4jQHv9DeC4zDb9flkobe+Wy3LAa7lSnrK7GUO7
	 GUNqQ52a3H2t7J7nj5Pgqxs2Gk64N3KSZUbhaEO19gSIOt6lvDn1uJX58txs0HjO/HvjX
	 iRRYiY0yXKEUrQhEBjMX55p7ThAhUFYMPPiqf8AVD7wfZwQasav/MsD66pGuujXBsczoi
	 NFu8Fcew/OcLeWvHScyXiM7Mkrd689Yn9ZlUz4ICtUGGsOr/C6xKRALM0H34pvTIuhEiF
	 dMhjlGzpliiXmN59aDAJpHehQfRvOu7aZvGRNcYTpUMZ7Ls3PnlW0kVvsom8hpPS2TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QCwbsGiL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kRJNyJJ8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD160A5BD7
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64DD160A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QCwbsGiL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kRJNyJJ8
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KNnv3958987
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=; b=QCwbsGiL8deVshBN
	cKsOzIJQ73WyK29znFgl01Xga7/uvYUEIct+HpOK+0/5kHTK4MnBex1/1pI0OVHB
	b3mA00840N4d5bldQbmpq6bIpQ7kfD34OgtTDxuzMCz3UGIElEvQ464oqVZPi3x3
	mz/qUwxpTZpN1bnKMimTZr8DtNoXVQJzK7y4z8riN+BRA3x980sapxsOWy2Okjkw
	3jNTZtWfvuPmX3oEkGtYCP5lWJKopTF8cF6yfhcAdGoL7Zlu/yVHsEkq/76t8LVA
	+zpmnJ7I/DP9fhNTxQGR5Ajmb3lLGXtBB3P4XejoWrYygVzjMFxZcQzHxyk39kZR
	5Eze5w==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b3311m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:01:05 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-84586110393so3359476a34.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 02:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794391265; x=1794996065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
        b=kRJNyJJ85biOA/kKJTj60e5iBiRXfByfWAFvSaolxQmJlXBxm04riDm4Z2EzvI0wKg
         6PQA4+MQ/yTHu6OC5Z6NFcCRUsgXR55nss+2gPAEb/j9UOzHWF+zDH7wVn6LBjJPRq00
         PA6a0hWfPHZfVc75pYBIcKMNZ9iiQg9MUtDVOT2rtqFtGjBfQ4Q2Gfc61RZmm0hvjwxA
         Um7RBArQbqdq3BxAH4nmLZlkfE4+D88OTchpT8Fg6VEp8mZjSYnFvz5QaZSQl83Hr+Tz
         dYqUJAdG2rSSuBY2vavkuMWmYGIEH3Ef0u9b393zsbUJUuEG4ritq2T/7sbzfCFbnqVB
         Q39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794391265; x=1794996065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
        b=ilDMVAeTyaxuNKz/J64Fb+kl58dDfXXMT4L4AayHNy+vU9mL33ezlfmGrUbqDxFVgc
         guqohWjzzzpJcSlFL29gztLuL2fAOPanrkLTbqHxpS6nhHe/nHuef5Ep8wKBPXtUIVYU
         FYSCUgbPJeIxc5sMeX0/ccur8XGHljZkn8xyZaJAlFRs4mQiNrAhrs29cOf6rfluOZ0V
         5YMyn962nDuB3jbHVJ6RmowNryvFIJ38fJKOd6OsU9e1jdgCSPneoazlqFqN/9yll4jf
         ewHq8hwsGWm87nUGu+SwXpGlsNJUHzWPHYfEEn6KF+KkC6iDg/rac1fFehW3PQaYpUai
         hTzA==
X-Forwarded-Encrypted: i=1; AL+hErEMj57zMkLp+I0UFkpTXoS8OdubE1MNVaTvGFpCpak94hnpZd1EjsgF55Y6PTmYNvheZJgH94g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4LgILrJx1uoee4h6mSRIhSAlLwdaMoz6w+evE/EIkzPIY/r2/
	1+Eu26g2HzYJ1Wk0t4o9DlMw8fqbLnWyrLDFwHfWoeojvt+Os5MuMqYgegeSks4NXeIG/FyW0ou
	Zx4Iya07eq/f+D2UTqtGqFljZbvN3BtC1pvEmaY+1Cpgmhjmmh0Kxj4WwRXM=
X-Gm-Gg: AYBFou1XuZ1WqmOHQXoYezWbm5Bh3e113NXF/SU4bgFzqKId7rCT9KRpCueOb4zV6BS
	vke18E4xG1guIaKixyATCaTRb+l1MRBUluQbAGuBKFPgdJtJWDTeRpIUNl9V8zvplQo4RCK3hOn
	8yOs1wMP0XoaJmTqkzIBCSkTeP7OBV1M9PxlG9KJaPg5wPobhgzQa8A8r6JNMnQdr/iK2fg7Rta
	hIGs7eKwhMkPVsn/5MxIRTZd0q2G2B9BAEKkOmBxRvVq30UqUMnsBn+NRylZKdGRvdH01t4cs7M
	jE0ilcTNKAflK0e8gMOURHQTYX68mqXXsufWKoBPQEcNSWoWkkIMC6Het8RYmnyzuJnhE2qVp47
	8MPHcOpo5gxZF8swrJDiUd0mhNmLUGV/5UPIqGk2HW0dyvJJ8xumCIYPae6gIWhVKkjizzBX4yr
	7L09I3zJml1uoSVMXC
X-Received: by 2002:a05:6808:1924:b0:4d6:92b3:5c8d with SMTP id 5614622812f47-56b98d27ee0mr1503263b6e.67.1794391264842;
        Wed, 11 Nov 2026 02:01:04 -0800 (PST)
X-Received: by 2002:a05:6808:1924:b0:4d6:92b3:5c8d with SMTP id 5614622812f47-56b98d27ee0mr1503211b6e.67.1794391264180;
        Wed, 11 Nov 2026 02:01:04 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504c276sm4686111b6e.4.2026.11.11.02.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:01:03 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:00:57 -0800
Subject: [PATCH v2 3/3] arm64: dts: qcom: ipq5210: Add NSS clock controller
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
Message-Id: <20261111-qcom_ipq5210_nsscc-v2-3-7e2c1dda3ed2@oss.qualcomm.com>
References: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
In-Reply-To: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Luo Jie <jie.luo@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391255; l=2069;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=V7tk6aEtOPhfOk+VPI7cIHGev2spKigLOSXp8SeaGFM=;
 b=FPdGwja/I0to/ZmRBr9rXIX0wX/bDKAU1xK3bC9dhG0h/+sBG00vXJCbM1eQXFpMhieJc78+d
 zQqoysUX1hbBKJPSNke8FUNppPMjsVdX2VfHSwBf+OW8jJwOM6o7cRU
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af43ce1 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=6SnK136Pe_QpXSRpRBcA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfX00Tc/fqS3Yk5
 r66XzRHG10/BnVwQRCQ8uyVUKv2KivrWkF5+djgAN/knxMB1A/7l3/DWHZmPahLv3fhXzgxRQ42
 Qjc3znjP4M936Kds+zxCND760IJOBGxgmd0p9aM4t2J6sDBYVgXc+PqEXDPsJ5aZHHnD+dX45jD
 MCs0rqHYg7eoZh0d7SScOQDJmc8Mzfb56KPCaD+12KKuEdA8DsoxH2ZvlOUBO6AaXQMrWLztWca
 0K57tiQk5CEEp9FQNKEJXO1uB7zcZfZDWazNNPJScZBHuBz64JCma1yqtIFYyeXKOnaw8FIxqHp
 Wz5u9gFjLKELq/SzUACaHTrdS9RpEdj4Ed8c7SVbvkceu0cm+8suMGIl6c4zEkcwBMBPAVeqYp/
 2etcCMEx0wq+RdhwjZJxUOquKZC7AvJ3XTwNFVTuUYx9MKsHfS7OMZZbAvD+WX5p9P/nz7Hy7bh
 xCO/jQapsfAM33kTg1g==
X-Proofpoint-GUID: lvBDbt6bzp6j0wuUErT-pv53Kr5qyPRE
X-Proofpoint-ORIG-GUID: lvBDbt6bzp6j0wuUErT-pv53Kr5qyPRE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfXxc8J5lTeqH+L
 INMd1F3+4LUnYNo/1Jw1ULYhpqI82lzzRBBBhlPKoVgah8rFBC3inm0eHaJq/6+DVKaM2Z7ufzM
 2T6gy9FwlxYLeuTOO7iBOig1JzkByGc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110039

NSS clock controller provides the clocks and resets to the networking
hardware blocks on the IPQ5210, such as PPE (Packet Process Engine) and
the integrated EPHY.

Note that the CMN PLL output clock names are reversed with respect to the
hardware block they actually feed: IPQ5210_PPE_CLK is wired to the NSS
hardware block, and IPQ5210_NSS_CLK is wired to the PPE hardware block.
Documentation is added in the DTS file to call this out and avoid
confusion.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5210.dtsi | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
index 0c1ede0f73b2..11915f8eb156 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
@@ -331,6 +331,46 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		nsscc: clock-controller@39b00000 {
+			compatible = "qcom,ipq5210-nsscc";
+			reg = <0x0 0x39b00000 0x0 0x100000>;
+			/*
+			 * Note: CMN PLL output clock names below are reversed relative
+			 * to the hardware block they feed - IPQ5210_PPE_CLK is wired to
+			 * the NSS hardware block ("nss") and IPQ5210_NSS_CLK is wired
+			 * to the PPE hardware block ("ppe").
+			 */
+			clocks = <&xo_board>,
+				 <&cmn_pll IPQ5210_PPE_CLK>,
+				 <&cmn_pll IPQ5210_NSS_CLK>,
+				 <&gcc GPLL0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <&gcc GCC_NSSCC_CLK>,
+				 <&cmn_pll IPQ5210_EPHY_RAW_CLK>,
+				 <&cmn_pll IPQ5210_EPHY_RAW_CLK>;
+			clock-names = "xo",
+				      "nss",
+				      "ppe",
+				      "gpll0_out",
+				      "uniphy0_rx",
+				      "uniphy0_tx",
+				      "uniphy1_rx",
+				      "uniphy1_tx",
+				      "uniphy2_rx",
+				      "uniphy2_tx",
+				      "bus",
+				      "ephy_rx",
+				      "ephy_tx";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#interconnect-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.43.0

