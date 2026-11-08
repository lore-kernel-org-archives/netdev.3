Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143959;
	b=jUON4FzYhBYjNiyb6FQny6DkkUFpwHGEyV8MIzZLPB4cUjY+mhvoNCB92eziC7zO9mhT
	 b9uLApBS50wnNC9KCnHdeAeayYk5j1R2eB3glXUsSIAAed972DeFdFVM8EOSZu6X7o5Ew
	 g2LEm3b7I94T50kM6wpPKes9AlvQ7oQcxtuyiCxCI8fMQkaa7490PvY0piLyRjsdX82tL
	 z/8RT5xa2H9YyaNb2Vb/BhXI45jZq6NXebcq5GBuq3o8ysjOGZZLxxSlzG+cn2GA1x+7h
	 hI1ezIJX7/m5ECHiNUad3woQDzyujX9KAQQy/qe6ej9DLyBSKa1Hyrp20ilONaSruzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143959;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=p/lUPGTPC28aT7+PeAISrTjJA9eq7snKjsK80BxDrnE=;
	b=4JXhUyVyqKCbGQGwkPrMHe+HWUVmcRuzYs1HspCv8faIoP3sBW5pgGlgsuuHvcR//8Rg
	 Hs/3sCdNZn97GHvz96Hk4NvQXV+ZaYKdTdVfWAtVP1MYUs0qrOViakPjv4QDddE5mfafK
	 GmR1t7BPeBD33zJhV/0+/jcNtak5NOa00sZLpPa9riqrpVW41gUYcdCX72fmz7UolH4w2
	 5PCwsRAa8MAc0RExWLx0ZKrsaMGWisl2XqkNdKIH2aeEoFXy/DzO09DczLPxNz2g58ZuC
	 /xU4Y8mh0pKFBePj79U2t+L+NMfvTQQJWVbdYyCaPO4Mm7N15ZX/zi/SqGCqfxswPTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gZaDpRYk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AFPD2K6s;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052F606D801
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2052F606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gZaDpRYk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AFPD2K6s
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8AgaLb1873536
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 13:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p/lUPGTPC28aT7+PeAISrTjJA9eq7snKjsK80BxDrnE=; b=gZaDpRYkMHh0Ss5e
	j+StO+2Q5fi9WoSckpNGxZdDF7nzVTeNZG3ICQ5Aqx92+rKbMhNFVf0H8Ac76LYw
	1bWjeL67DpdGQRxyyurDaUoTI9J8s0vOW04e7+PEaxo/KqPIzUBc+EEjK0C8L15A
	PFC6yULyxht6u0e6joYzAp7U+pI0ui0pJnhua0WYL/+EV7IcttPR6DLGezdj/lZR
	fqoCBbZYnkR49cx3kk42FN8dVrEfXoMSStKoxr/fH3W9IzZgoxcD8WV2OTKwiYdI
	3j62I17vVT908+yM7AEKDJJWdXv+lT9YJB8RNNiS7HgyU+uajDT20N5CDHxeLjog
	JfBmxg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsujxb17g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:19:18 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1a5005fd0f8so201230c88.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794143957; x=1794748757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/lUPGTPC28aT7+PeAISrTjJA9eq7snKjsK80BxDrnE=;
        b=AFPD2K6sMXtvsgwhYwtNEeKEecgDvwpv1Nc50jnDKr9VdaItzEgN0TuzCSxhHx4Oc/
         rj/w8thcxtvSHkjcXuPa8qqlH9NjU4I1h3M67ScRZHnKjWBQqMiq6oKQjLDhH11iK1P3
         itW+i7+R6Qfqwids2cUPuZo/AMPteJaJ2EM1pVpM9PB65m/stfyVLVAEQeRpDE4XbtCV
         V0ZMMlLtul1CqbTC+RfIZd+URI0+LpoRyJ2kQFAQfJqTgWvfRLRplSXVb4OU67hbiKeK
         Wu4CFZdW9stRkIHvcvExQcD24Ul+AgKOYt10/9eAM3JD9ssFkMgOmvGeGm4jKM3PsYas
         jq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794143957; x=1794748757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/lUPGTPC28aT7+PeAISrTjJA9eq7snKjsK80BxDrnE=;
        b=1rb5JovcX7WvvQfLSnKoQEsLj/ZvflcpuZ4XXt6L1jYkDsZ6UbsO0pWc6NCP7y73EQ
         PvYoKbAnEGbE5Cp88N1fbOT8u3Jwtwjx5Sscb92smiAZ8hs3RWhwgyPJPSTnfyH8ZSoS
         2J4KlB0HU2oxC6MTOCT6NkIUzdSyvjWWJUz1snOKJzVl4x1CbQ/1q/iEhpvWUajOaGLl
         /vyHlq8H6y/xFKSlxB7GREZ4LcovhOuf5VxonG600eMwvLhPjdpDe7dZpvLt37oZH/q5
         Y5mLoVKy5Xve/Evxx0Lg03OXUdXEDjjPmDPnpdbtJvByBExmNONF4SB1TMH5G0yKV269
         DKAQ==
X-Forwarded-Encrypted: i=1; AL+hErEzXVUkGZ7+t3Ifm97+7z8yy4DqzJyu1Oc7iaNRmvjw0gDrrh6kjB+Lf1I0G4DhkaTlTQoiVzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UZt3wxK3Q0djnveI1JUwq414H5CPL7bxfTENwwGVRuf4Hqs5Q
	h7LR0d3/0pc2WOZqOc1e8AA/bCXAN34oE9MUePIp47IRe8wySG4VJJxkvPD9iZijP7qeldhHW3D
	OfZoz3zEytrqdikFJpEWRP5TAFHOrQUAHtmfYdzLYOYnTgNye07VCoUdBSRs=
X-Gm-Gg: AYBFou1o713HuxBtgawSH9BxlIAcH2cyhjlwA9xP8kjqcDQ7oO4kK25pnaYwkgkQXFh
	nsB/ET7cN3PXyZ+C8M59PSHrBGfP5uBkrWDmDP8MCb90qi+HvY8EEuJl+bIxCHkAtYvEjHlSsnO
	KwgOSyA9PJOEOpCqhZjX8WU7Tnh2nqV3C+NBhdHuPBKztZs6nKBDu83qGw7Fg8kR3p6kTzxJUnn
	eEJBHiKyhCM8AtxRYMsgBMn2XVrPjpCqJzJ7uwym/bnPU8ZQOpQnybvIfDjj59/Xs6y/dgAWGQw
	tFcX2L7lFSus09s2FEDIG6s+bz2mJyyQNhFLtpfSXK9WgZm54CocR0rBNQJnW4D/BzUGoBufr/S
	a3Sh8cN8CCswnfxuFkf5CiSgT+/rc73SJfRajGT1bgZ49Fygi3SIpCiOeAg2SLoZ6ZMjVG0+00Y
	vune0=
X-Received: by 2002:a05:7022:5f11:b0:1b2:4e2c:6838 with SMTP id a92af1059eb24-1b39fe879b7mr1875877c88.15.1794143957030;
        Sun, 08 Nov 2026 05:19:17 -0800 (PST)
X-Received: by 2002:a05:7022:5f11:b0:1b2:4e2c:6838 with SMTP id a92af1059eb24-1b39fe879b7mr1875834c88.15.1794143956331;
        Sun, 08 Nov 2026 05:19:16 -0800 (PST)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm5336980c88.13.2026.11.08.05.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:19:15 -0800 (PST)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Sun, 08 Nov 2026 18:48:28 +0530
Subject: [PATCH v2 07/10] arm64: dts: qcom: monaco: Add support for TSCSS
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
Message-Id: <20261108-tscss-v2-7-d5f575010427@oss.qualcomm.com>
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
X-Proofpoint-GUID: tovhqkN0_Ihl_ri9W4qNAfpapUgGbBHu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX/PnTl4kRkaVy
 MaLNNFXdAm7ruaUVimxnGR4CzgB8Y/ar/VWbXeurREgRtPBK8fAsBloIhISeo/E9RiMDAIuGe0U
 TWBk3hAYqYqP1kB36b4qm+fBw7Nt1zDTSPd24XRoQuGoJiJOccAciuJqspMKh3C0WWTIufeHFcg
 5ToYOIwiPMc0Mm1bFphG+wQ4h0ujvfOAYw4UGFwMnjzCQ9Qi7pVjD15rlZtLKBbHcnBcC5Dt9lw
 W3utfrHaM9uYY3atzdrgxjhhL263R2PHf17/a/LJNycURTDHmYyNAMzdO670F0ERnaZ56bkoYNm
 YXiOjoNiwf+ENZUY6KmEklzqq9VYSMkGMU/z0ubWMhj63fYMbWltBCdFXE+Ek9HkcVx/CClDm8j
 PjUc3HLx+sohDIV51mq7Fpm3UbcMC+WRS5alr6hwcHgSLGV61H5eSZ5CHxNeSGsDJcbmnygllaw
 ssBnuNL9TE4wYU1flaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX0zed/4ZJrLxl
 mBiLW43YnZmHGsyI7ui+RnkMOq9O3fe32OmoiSDWisT6G8oM/VbxIvNRD5TWI8W4i5NShbw4kUG
 KGACt4fUjv2gLKXil9xgTD/2jjnygIA=
X-Authority-Analysis: v=2.4 cv=TeIDJhQh c=1 sm=1 tr=0 ts=6af076d6 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=03a50ROZyo0H9j-jB2QA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: tovhqkN0_Ihl_ri9W4qNAfpapUgGbBHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080052

Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Monaco
SoCs.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 35fbee63d4c6..b87ba4b3a5a6 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -2628,6 +2628,18 @@ pcie1_phy: phy@1c14000 {
 			status = "disabled";
 		};
 
+		ptp@1c80000 {
+			compatible = "qcom,qcs8300-tscss", "qcom,sa8775p-tscss";
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
 		ufs_mem_hc: ufs@1d84000 {
 			compatible = "qcom,qcs8300-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
 			reg = <0x0 0x01d84000 0x0 0x3000>;

-- 
2.34.1

