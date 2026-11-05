Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884087;
	b=e+yijIELLxHter/NTc76wcwBbq11CfmhgGKkTcjFyY5WRASFZpENfc3hqBVl4pus7udN
	 agZVbaO7CZKMQxTdx/goz74k/fMUf2C2gBi1x+VD3HK0p+LM3q1cW9Q/ITCs57OUDz7Bz
	 gqzo1sJHozYKEIDVHMfCK8X9U3IaiVZZd1Ue/bA8w5Jtp/3DOBykmPLJwmz5u07/keUMO
	 XXRD3TfUr6vLSn/CbOE6ALNB4OD0lPAr2LjSSRH9NszXigdwMgDPvrx1HvNOM73wCT67h
	 KVCa5HEWvbILj1wYaCEMt2h2JhbsIZUeavpVIA9VsQg0owVEsmMps0jtxa2RUbviRZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884087;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
	b=10JehKKe3rRZ240ZlsPGGbsvP9KFO2norrOmcoBrHDK2OrOWQFgyikt3q4hem5U6/6Jp
	 rfa27V7aH7Rcy4xdgXFvilBc2WCqPPKDaCSIm7vxYDokiWFlYZJMKv2WsR5/bf8Y43NGb
	 FgmIlhJimr7FdSF30xHCeFcoecMGAzP6TIDeeTK38Sp0XelrFYPlLJfOFvXeNkiBnRLR2
	 79g81bv+6Uu8Z4qjhk0G2piSQWtkJsTkP3Iqyoj2S01hhwQLyiOJ61quxnQpDw0/S7tGF
	 tlyPBn/Z6E5tPtqxaiz/d4YW1/ATInnzJcMggypCUYxVO4+N8hTOgkQHPcY4j7xT25Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Of5qfoBT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JVnLdgok;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D12606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90D12606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Of5qfoBT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JVnLdgok
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tJPt1053135
	for <netdev@vger.kernel.org>; Thu, 5 Nov 2026 13:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=; b=Of5qfoBT2tN7w9SS
	eTfmrVcEdQLOeJ91QDApW8Q9Q4pmu3QFKUx3TLEJMqG3ONm5Yy57CYpyoFrobkJ8
	WtAWOsYmjaf/la3Zb7FvCsf4hcgqFv3zc6krJ+B1FlKFUNSzdRXWUkIlhhJstMKX
	JgPQoaf1ghM0u5rJX/6nx2LBSeY4+HnbiEj/HPSHHXGnrbT/N1VqBHcHnRiFtkGI
	+q4I6AmA79Lo50xLbVWEqTa7pGGOrq3uoxT+Z+uxXUgGBq+z5XIPxisa1r4NHd5B
	yTP6sCLSh5MuVT3lUBwe/x9CSG4t3g8UxETuoILb7cfw7G15prvoNHD1aCQbwnNY
	dW6aKA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq9f8tys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:08:05 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b30789c6cfso26544097b3.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 05:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793884085; x=1794488885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
        b=JVnLdgok5agBSKZUB8toVIcyAUIyoPGRkwTKUzo/zynSPCs57SRvRc1QXMB0/rvgnB
         fLYq7g0f1WllPtPCKQHPYti6wv9Ijcky9mCj0qvatvuJX9pd5BQTNhcaT1Lwll4qPqsC
         L3azSHHHaumB6WBI+XcpeNXGvd0q1udenIuG8dgA4F0Ok3+rDYJiwtMM99u3AeE9SmEL
         5Lz4i0Lr6zAnyYCT+zjA2LVJx9MlCcxkvuKOqLmiuXmoAsw/o2PY3FTHwIFgZvl9BGlV
         ntat4z1wwuUyFx86Yq0NLRr3DTgx71QUmA1XL3hNHlyTdCN1x/AebzGB9Aecj9Fm4TGH
         w3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884085; x=1794488885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
        b=vO+hrdj50x9JpWgGvsZ/N5fSPt84U4x69tlE6VN0HKbao/lxixXpb9A1Ys7/SIl97i
         vtpyb/Njz31EkXb/+bbTzrYYe/q8MOijBaCGB3SwVAOuA8YpkjJBq0gNCijZbdFsC+hA
         dxHPHrma2mlwKO26oTatLNn16qSl8cRF3HUWylmWJHhUxgjYaAVdusEK6K9rL1LITqGQ
         MEylSFvFsoUQj0Y30c7BL6DlUdvOEZMgDFKZfQWYLHh6kn0iUq1eVh33ZNU6R1tCHa8Q
         SquVzmMe8IHFtb7vrYu13O+8lyc1NVG8L4T0MD3662rlXZftf5icXXJe7e1xzaDy3W52
         70Ag==
X-Forwarded-Encrypted: i=1; AKwUvByUTfvSVe+ogS8ieK+vLLbJ89O6RSKZhObyk+ezYPD7QxI4lB/gR8SOyHKtExQ8O2b1kDz50iM=@vger.kernel.org
X-Gm-Message-State: APuU4Z81jOGj38BAJPrMXh/eWX+F0YcsSS0wL5oSiDgKMw2OrK+WtR3V
	potfOeZz7mN6EL3iIhnfbbccph9NYZaEFsl6zZonu3S3vLc8dWzVGjisK8QuPOLFViqws3KcC08
	A9xvTkog4iGRqAa1d1SKxOjXOTAOWq+YS4Vzl1sr4BYnzyM1vdfubxh1nJc4=
X-Gm-Gg: AYBFou0LNvBroVDpvRZACNfqhjfOM+pxWk1SOD/5V6mOYpEQkANGRF1qwlCRophmCLy
	VqGmMMW8AVFrcklXfptwWpuKCaihfnmET8+0Z/10+zZI6xQgfLY0QlyExKFkx8sfCDWjF4mYjIL
	HN4ZwOu0mCjQYulzMpO318rlqIETW/eNYmiFqzuEk6jYn/NfUbkfhgvDaLa9RY/m0lzpC/+OZM9
	zCNK2MMnDm/PBCCdYo8yeDfJQTuxB3Kz60kNGtwuV3bF2KxsDLuzuWuEVKbWjyBBiJ/+wPdWLfQ
	313117ZRYWkDWbwiWo8EeFf9PgpVUErBUGwMtQcFAs9ZVho5SBwZz4y2wFxXLcDtU5zIJOJxGon
	IAUlT27OKVer4Nin5W7Jy5vqZorPn3rwHt5Rw7yNtMS5YsRstW1Taztcg1mDGbhwp37AgkmMqsd
	G1J2cP+TW4ClCq2lmR
X-Received: by 2002:a05:690c:4992:b0:8b0:e680:616a with SMTP id 00721157ae682-8b2b66f45dcmr147056437b3.24.1793884085051;
        Thu, 05 Nov 2026 05:08:05 -0800 (PST)
X-Received: by 2002:a05:690c:4992:b0:8b0:e680:616a with SMTP id 00721157ae682-8b2b66f45dcmr147056237b3.24.1793884084340;
        Thu, 05 Nov 2026 05:08:04 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bb4406sm38915937b3.40.2026.11.05.05.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:08:03 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 05:07:16 -0800
Subject: [PATCH 5/5] arm64: dts: qcom: ipq5210: Add NSS clock controller
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
Message-Id: <20261105-qcom_ipq5210_nsscc-v1-5-d4fcb5c32b51@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884066; l=2069;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=V7tk6aEtOPhfOk+VPI7cIHGev2spKigLOSXp8SeaGFM=;
 b=NQZ0VnXNNs5TVcS/GfGIp8OMqr4bqDVVREAqgfRdanu4y70VLhmGeYPMpHa85TCG6ztA5t6gu
 bw6K2g89zZUBmx9UG19aSrHFqkgmyhdbqNUcRDDR5s47APAPUsRdBd/
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX1q8uQar6txY4
 lDm+7IBXy8zTNzUSc9D2F8UvhE5P4PvOJUq+7fvTS88OX2juNcCgTmp1iBlqmIDr6qL6AFFkCv2
 kPnrHmwNDAS4kCuVMGZxJqT1XQl/QUYDogXtfwWDypwOt1HDJ9LKN2EH2jg6pqzGZcjyAkglL4O
 06W05DKh+MPb2/hIF7WRyNiRJHPgt+YsJT/Xl4iE9eZIVCA372EgsAir7mvsLtgN/aLKeOnJQ6k
 tis7LHvpCJnqOLHuS3gqmBfL9M33C3CxBq9dfDlII6t9qFNckiqjScMOxn64xmaSYUNsnFDzJCg
 vf+XNli0GzXRafCK3dJvhVtPc1s6df53DM3AQYEnhO80GfmtPkmL1GJcij7iqnel6hskMj+3WWK
 nG6IIXbPudbb7RWw6nz1yy1agx+vkP4Fr6JEhELWTpLKZS1gReI9mQUUrwyk31BjrfUpwYMMNyn
 M3TzqHgsvZKPHgH4vyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX+X93HJqNhu1o
 YZmDUW7WxDWB2PNXOJI2LZPPpW9vTojdgT3fgGG2fC3jfMC9/8w7UoEMWoogtFJnkm5Np0rk/mq
 yaTRk2shuyTsHXEw0VIVuNKBs8X/7fs=
X-Authority-Analysis: v=2.4 cv=Vdhir1p9 c=1 sm=1 tr=0 ts=6aec7fb5 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6SnK136Pe_QpXSRpRBcA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: 1qBdDlpav6kdw-zOrUZPt_4WgKP3riI_
X-Proofpoint-GUID: 1qBdDlpav6kdw-zOrUZPt_4WgKP3riI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050052

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

