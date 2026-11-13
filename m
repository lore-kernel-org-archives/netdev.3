Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569359;
	b=cpn6bYwPk4CwPUdNE98QLtn9ZgQupoVv1uHC6rYl0csaa8ZB2QNb6sueqZYEKGSps61g
	 l0lFjrZ7lrDkkTbuWXwMqsXTg2ecio804/gzEngWk3Cgz0cczLCEDj2Z/W/lqxKysTQqA
	 pS/u9IT/p3c6Pua5Jy9FNdX3jUh9G1phiowCN6kCbo0qyDTmvoASISfI+3x9tkahniXWB
	 3tl1/JiItEntspiGIjMv4TGN169M2g0o4mucrguqU57h2qKhnbpwdDiU7rYEd9alWo/tj
	 mKz+NvCZsiV2BOtgd4ROXa3s0X7LLajTHem2n3Qwqeu9tFSfatSKOToaBDC92ogGPPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569359;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=u8FvNfswkOVPTwhgzzkN5Geh04e4dFjuMzX81XvTAgI=;
	b=5nE/EKDZKMgvuUr9Dt37DvZzAGW3tz3AOMotG2Sj8JzZtGqBT8vPBURKp/a+Q1U7H4R/
	 1F+nO2uPqRieMAbIZLTQgqdebkxNmf/K+K4c2wuiLDV4EDhvS7MMQIBIZU9uZ8Q6Cm28v
	 /vfB23uxN3PxPXxCE0i2TB6A04D8pVpifqK5LzLuYt5wuJ1pNa5Z77GR2Y6peA2saStH2
	 fBNgLzB3qeswCZU94qFDirPwt5lBsZ0tt9jQsIImKHyGkVcQaLP1xBtkOefgbFENugPUF
	 frN+NMSomB3H1cJo0wCXtDfvIukEjOv+8nUf5E64CPpxtNMNQ67pYaH+afqdULde5og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SIaktGig;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J57EmNE1;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942CC606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 942CC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SIaktGig;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J57EmNE1
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8V9a9074775
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u8FvNfswkOVPTwhgzzkN5Geh04e4dFjuMzX81XvTAgI=; b=SIaktGig4Ulyjbpl
	yVDFpkvpJaHCjB7zqY+a+shxvuMgq3MAhvhHRJWRNV94DPdpdWkCjoaLtYpbpkxj
	w4JFTTD29P36dtKOTpPxmagFzKvQiuXf2jyXAlRVOlR/p9tpbyA1PROt9MK4dSTe
	yKujlXiz/DFgxoRVq2f/PhR2pLgpcXBrh6bfSuUYDTljZVMc7+GOCUbR+4sQTSox
	8Gblv72xy0eGZ/1TFe3dhtNp9fNRw5iBSrDXcZZ+BjJajyIv/wuwz+LTHHCq90JO
	zGz2y/8as6zZGQBYIyLRm00lWZYH6YmbeDsTllqyiihxPdcinTMrLBWP5MT/ceBk
	TIQasg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufj2q8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:29:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f479b9819so1051779eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794569357; x=1795174157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u8FvNfswkOVPTwhgzzkN5Geh04e4dFjuMzX81XvTAgI=;
        b=J57EmNE1W+tSwslP2x93kejJICU6JQlURDUvHAPdYZlFOMi8RyJwi3Mr7PF3VCHuPK
         tlakEAAUHLunImyicnuBZUiWjxa5YuALOsS/5arQqsvtRUIaXc4yTKiBm6aMxGKeLIdC
         f6ER8XhGaHs137SyTexuC1lxxSsP/u5MtlGZBOPi4ZMMtZGEl9S7joksnU7vSE82qEO5
         M6avlpznf0Raj+C8nVniEu0/5+lbAIR2F6IJ+yKpio1NqGKU6ErQKgmrNpTtkNJjAwSj
         BfLxZEnwiiUb/vK+zBjEspeokR+xqQ2utMFDwtxZ5PG/02mPjqNZVKv8vDyQGnixCxCx
         25sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569357; x=1795174157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u8FvNfswkOVPTwhgzzkN5Geh04e4dFjuMzX81XvTAgI=;
        b=rjD1j6fYhQKyT9Ew043sWOsHbGsi2jCKxpytSC++WFFm8U73bhC2zeOzjeGbRENmDw
         ctiEZB3BNOEOX4b3+Zp9BnCU8BL8rHBsQsJEuWis+q3g8Utt2DwqE5dS6YvGJ+6M19lD
         D9Fn4D5mk4+VLROS8oMRge7rrQWRIwujcSu2bi95OSklFHnGfxNLDNuiwER+Scd76Cj/
         gQnxt+TG8BUkLrm8nIyu/q7bL6UKKS1Flz8HGT1saOZyfg5EkJvCpAebUvB3ujw5ULgu
         R2f3ce+cmbdE0E2+UORXLLyHSJBroADxszE5bt4L/4KHasHFGn4TSrssZ8iS6h+9yUP7
         2eWA==
X-Forwarded-Encrypted: i=1; AL+hErHcxRkCChRF65zN9A9OnU1FQJuqV93ZEhIH/R6g8GPNH53/ZmyY9+tXH+RlLGF7qX7dKkOLV7Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VQoGBJEgYXFje3IqcykxsmHeyf6zgIkYWpHDbb6QRW7do7Cm7
	Yzd0yMdmQWBGU2MxXCas0Ufs/DgxpoDGZ42wbQEeFvHv6e+wHZBaSFJd+moD2uyAy9+nqJxvSh1
	YFpFPZeRoVSmefIgP63VORU2kHuFburTUI7IEd+bLP9ldzpTyoHigQxuh5I8=
X-Gm-Gg: AYBFou3oySBmWMEqTKdPvNvR4wgelonjlEq+C4HZYYCW0YCUl1IRNveph52aO0aWT7h
	+LCJT39yA2/niJ5WKH1Q3M7kBMfsxecRrH8HmnrRDzjJvMNNvlR6j2KpUDLBJdUop+6W/8mBqO3
	p/MUf6U02Yg8Y00lc8mX5gJb2Ih2aEL5M5YNl61JorKrt6F9m9FZAvzBRz0tyzEA0PfDVB3Fz5V
	BSasoTAsU6yWQ5JpAW2BaRjoXcaiaL+j0bHYpKsq3+LeczP0ZTS0pU9yTvkQdyKS/rDg+i/0ENh
	YVF8lyGouNkkjZFaR7Lgs5zGYie12fIIxjfOQdAqFJFVYuv4VUnFzmiQWCNnXFL6zdAgLoPmoQK
	1RlWh2CJjUcoG1ZoYdUrD5rdCEKJvbOiJ24/eDkq0p4q3qfzazE8x6bVmoD4I1jQoSzDcvW9+Wc
	Q1osC/4p6O+Q==
X-Received: by 2002:a05:7300:5609:b0:379:4197:5eef with SMTP id 5a478bee46e88-3796676be4amr1964960eec.8.1794569356824;
        Fri, 13 Nov 2026 03:29:16 -0800 (PST)
X-Received: by 2002:a05:7300:5609:b0:379:4197:5eef with SMTP id 5a478bee46e88-3796676be4amr1964925eec.8.1794569355989;
        Fri, 13 Nov 2026 03:29:15 -0800 (PST)
Received: from hu-gthawre-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d73dsm7342924eec.2.2026.11.13.03.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:29:15 -0800 (PST)
From: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:58:58 +0530
Subject: [PATCH v2 2/3] arm64: dts: qcom: lemans: Add LeMans Draco EVK SoM
 platform
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
Message-Id: <20261113-lemans-draco-final-changes-bringup-v2-2-3ae8cd1c9932@oss.qualcomm.com>
References: <20261113-lemans-draco-final-changes-bringup-v2-0-3ae8cd1c9932@oss.qualcomm.com>
In-Reply-To: <20261113-lemans-draco-final-changes-bringup-v2-0-3ae8cd1c9932@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>,
        Kishor Buchi <kbuchi@qti.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794569340; l=11285;
 i=gopikishan.thawre@oss.qualcomm.com; s=20261019; h=from:subject:message-id;
 bh=HprjikKTPhnWkSnXIBD9lEreMMY8DrDYRG2cU3ayUy0=;
 b=zt0829CLFrgdzJ6dvKWgtRIIsFTTPhBqDRomMrQ9d594pJR2dNewgliGvdViI7Jz7gszmmKKL
 EzbNB3QiAi+BoDuNHHGj3ojF2zXXY63FxbQKg1XZ6pQpLF9YdoUs+aP
X-Developer-Key: i=gopikishan.thawre@oss.qualcomm.com; a=ed25519;
 pk=l7diN2ZWn/39T24vZixhPPrGDEUF6RKc19MsWZubM6s=
X-Proofpoint-GUID: 52h-W2XC7IEX-oUY-1211t3Ufn8swSYF
X-Proofpoint-ORIG-GUID: 52h-W2XC7IEX-oUY-1211t3Ufn8swSYF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0NSBTYWx0ZWRfX+v51F3IptOLD
 8qxquQJefL/9rGlcB5v3o5t/mCm1Ed/C2rxSuBPQU0esNPde64nV6ooSQtSrGvw1O9rEeMe9u5z
 ItHnSo/tMlKuFT6jv5/ShyDTZbLwzbkqKJQf4cPbT0/hGi+e/Brvx3FTqLvoMpLZ2r+VBXGXstp
 oY2TIw3DLHVuEiDnP5zm2xTYE1zvsZukI/Vqh6XSLqMAceybqY+DEYykD6bz7GKAHYYYUAsMljF
 /50L46MI39LBJiV0ZdrqrBQCZWVWQzALhG/NusOYIsugQpOJN3JlQskYALOt/vjYltGo7kNYihE
 j4aj2mVjhbl7B+bqZX4JVORiyHZhRZ3w9CXwrd2QCGD7IlVK0NIGwPol/kkDRFd6Pr6YSLbwtnP
 f6+xEj1uDQOxSkkGJvdULRbYziCbBT2N7jkcXsT5DKpXRCnxRRjgxy/KWFYflltJL5WjepDBTvE
 Cpwy/I9C4vrFySQHFTg==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af6f48d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=uYN2XYQzZ670T4YDsrIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0NSBTYWx0ZWRfX6FN8dY43dibG
 pZyze/0Pbsk9f45ziHksQFv0zmnM9eq6iArsYrIu/wbQd1hNWqlkrg/me455Xn+FDBHBfEHA2QP
 RWFiSpCOA0/g+JfDCMp8vYlvrVDKVjk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130045

Introduce the device tree for the SA8775P/QCS9100-based LeMans Draco
EVK SoM. The LeMans Draco SoM is a compact compute module integrating
the SA8775P SoC, three PMM8654AU PMICs, and essential connectivity,
designed to mount on carrier boards.

The initial SoM device tree includes basic support for:

- RPMH regulators for three PMM8654AU PMICs
- QUP firmware paths (qupv3_id_0/1/2)
- Remoteproc instances (ADSP, CDSP0/1, GPDSP0/1) with firmware paths
- Debug UART (uart10) and board clocks
- UFS storage
- USB 0, USB 1 (host mode) and USB 2 with HSPHY and QMP PHY supplies
- GPU (Adreno 663) with ZAP shader firmware
- Video processing unit (iris)

Co-developed-by: Kishor Buchi <kbuchi@qti.qualcomm.com>
Signed-off-by: Kishor Buchi <kbuchi@qti.qualcomm.com>
Signed-off-by: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-draco-som.dtsi | 401 +++++++++++++++++++++++++
 1 file changed, 401 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-draco-som.dtsi b/arch/arm64/boot/dts/qcom/lemans-draco-som.dtsi
new file mode 100644
index 000000000000..6b7971bcdc93
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/lemans-draco-som.dtsi
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "lemans.dtsi"
+#include "lemans-pmics.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart10;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pmm8654au-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vreg_s4a: smps4 {
+			regulator-name = "vreg_s4a";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1816000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5a: smps5 {
+			regulator-name = "vreg_s5a";
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <1996000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s9a: smps9 {
+			regulator-name = "vreg_s9a";
+			regulator-min-microvolt = <535000>;
+			regulator-max-microvolt = <1120000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4a: ldo4 {
+			regulator-name = "vreg_l4a";
+			regulator-min-microvolt = <788000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5a: ldo5 {
+			regulator-name = "vreg_l5a";
+			regulator-min-microvolt = <870000>;
+			regulator-max-microvolt = <950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6a: ldo6 {
+			regulator-name = "vreg_l6a";
+			regulator-min-microvolt = <870000>;
+			regulator-max-microvolt = <970000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a: ldo7 {
+			regulator-name = "vreg_l7a";
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8a: ldo8 {
+			regulator-name = "vreg_l8a";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9a: ldo9 {
+			regulator-name = "vreg_l9a";
+			regulator-min-microvolt = <2970000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pmm8654au-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vreg_l1c: ldo1 {
+			regulator-name = "vreg_l1c";
+			regulator-min-microvolt = <1140000>;
+			regulator-max-microvolt = <1260000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c: ldo2 {
+			regulator-name = "vreg_l2c";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1100000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c: ldo3 {
+			regulator-name = "vreg_l3c";
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4c: ldo4 {
+			regulator-name = "vreg_l4c";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5c: ldo5 {
+			regulator-name = "vreg_l5c";
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6c: ldo6 {
+			regulator-name = "vreg_l6c";
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c: ldo7 {
+			regulator-name = "vreg_l7c";
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8c: ldo8 {
+			regulator-name = "vreg_l8c";
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c: ldo9 {
+			regulator-name = "vreg_l9c";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <2700000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pmm8654au-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		vreg_s4e: smps4 {
+			regulator-name = "vreg_s4e";
+			regulator-min-microvolt = <970000>;
+			regulator-max-microvolt = <1520000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s7e: smps7 {
+			regulator-name = "vreg_s7e";
+			regulator-min-microvolt = <1010000>;
+			regulator-max-microvolt = <1170000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s9e: smps9 {
+			regulator-name = "vreg_s9e";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <570000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6e: ldo6 {
+			regulator-name = "vreg_l6e";
+			regulator-min-microvolt = <1280000>;
+			regulator-max-microvolt = <1450000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8e: ldo8 {
+			regulator-name = "vreg_l8e";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sa8775p/a663_zap.mbn";
+};
+
+&iris {
+	firmware-name = "qcom/vpu/vpu30_p4_s6_16mb.mbn";
+
+	status = "okay";
+};
+
+&pmm8654au_0_pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	firmware-name = "qcom/sa8775p/qupv3fw.elf";
+
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	firmware-name = "qcom/sa8775p/qupv3fw.elf";
+
+	status = "okay";
+};
+
+&qupv3_id_2 {
+	firmware-name = "qcom/sa8775p/qupv3fw.elf";
+
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8775p/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp0 {
+	firmware-name = "qcom/sa8775p/cdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp1 {
+	firmware-name = "qcom/sa8775p/cdsp1.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp0 {
+	firmware-name = "qcom/sa8775p/gpdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp1 {
+	firmware-name = "qcom/sa8775p/gpdsp1.mbn";
+
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32768>;
+};
+
+&uart10 {
+	compatible = "qcom,geni-debug-uart";
+	pinctrl-0 = <&qup_uart10_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
+	vcc-supply = <&vreg_l8a>;
+	vcc-max-microamp = <1100000>;
+	vccq-supply = <&vreg_l4c>;
+	vccq-max-microamp = <1200000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l7a>;
+	vdda18-supply = <&vreg_l6c>;
+	vdda33-supply = <&vreg_l9a>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l7a>;
+
+	status = "okay";
+};
+
+&usb_1 {
+	dr_mode = "host";
+
+	status = "okay";
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l7a>;
+	vdda18-supply = <&vreg_l6c>;
+	vdda33-supply = <&vreg_l9a>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l7a>;
+
+	status = "okay";
+};
+
+&usb_2 {
+	status = "okay";
+};
+
+&usb_2_hsphy {
+	vdda-pll-supply = <&vreg_l7a>;
+	vdda18-supply = <&vreg_l6c>;
+	vdda33-supply = <&vreg_l9a>;
+
+	status = "okay";
+};
+
+&xo_board_clk {
+	clock-frequency = <38400000>;
+};

-- 
2.43.0

