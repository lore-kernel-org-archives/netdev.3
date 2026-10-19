Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620144D98E9
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405691; cv=none; b=KyGBex/MBmbJpoRDwCFu2N3x8fATTUnb8QXQiaCbmijh7kfglQHV79BDEP9yEoH5IcBjozkAcekf+GQczkId980nQA8xmeCVU+Hs4lpOfTmrlnZu7aYC1a4C6nth2XY5dW/K63f9kTVg2AOL2KXU1J3Efj/CKYJRoxiLPMQUYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405691; c=relaxed/simple;
	bh=4uCD8zymZ8QSw7IPGWfLWxd+ItY5Mq5Iy0n06TS8Gkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/iU92P6s5NaxXDnPpaUdM7+MS1DZqki/KCBJpEAwo1sfD5mup+9yjZyR3f4wN7rkSjt54uSfQA4LYfAWwCrRwUWKY9T87lfSN8Lm4/fU9QUtwA9Rl59PZDQdX5RyH049f7IO2Oa2lDd27u8wf9ecJ043BZLd07L3iQTq66TK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YbRjSpo9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QFrPrRLb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbRjSpo9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QFrPrRLb"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P1Pm2041961
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XOjwLbg28Q+vFumDBFYnqqpMwdfyKRYsjAEc/lxHoxU=; b=YbRjSpo9DTliSwuX
	oZ1J6zIA311pzAf0G5cLmRh/ERT1J840Tz6hqf8uXOtRtwFXQCdhFOX27fG32D5L
	lIDe2fW0bialbLz7n60LSSz7PfAONSbX2N7qOk9nR629jNCsASF2DC80wuphNtew
	0MNH6L02w+Z5NzxGFjhS33f00NfrMZFpVzddgTls+pbdOG/2k82nQwdqm+nXVdxt
	VLi+RSI4zPyswVd39VrV41C9qlJV3eUXTpr3KRKjoqp9PqG+82jq3MzV3MJJ4uvk
	3if6Uu8/Aibq+rvHm2WF4sll+VkhHKpTis0TaycKpE+QKQQoqoKlxlEx7DioczMI
	ja2qQQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur298w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:28:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e8e16d22d8so29754815ad.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792405687; x=1793010487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XOjwLbg28Q+vFumDBFYnqqpMwdfyKRYsjAEc/lxHoxU=;
        b=QFrPrRLbkvMjfqHhjIpB9VSfoea7/r4LbgJRhzGDlC6k/sO5VpN2PAhvE54qID/Qlh
         MlC9ddD9qYinokUXMi8JJBAdSogDwzTMPPMXq5BgShIGPdOG7CxY6s/ZIH3Wp70nZCTw
         A45la+LZ2NpQMMEGuSttTcsMJWDM0Qt9kk1dVUw53yvAPcJBHmj8fxnpLr6twBVekNlR
         UCBmPmAZsHq6YM7DYopYPVCPk4q8YkhUc8VbZ+12D4Rn0sdXdjjjep2246mJS9XM72lF
         hRH1gD8RWeyboX9wX8UFx9c7FAIPYVVg19VLCJhvIN9D+gxaR7X5s3Bt7ZyTGLKxlqc+
         z/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405687; x=1793010487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XOjwLbg28Q+vFumDBFYnqqpMwdfyKRYsjAEc/lxHoxU=;
        b=HVvJ3em7PVYoVmeZhCPt89ZXI5htBGxr47njcs8e535AlQAmAuwThazN1An3cuICHw
         RdIIVzYSRKUvJbLMYWi1SMuo9ww8TctNOGtqBvpfPE1amKge0bTvLZmscJSa55tIJLVB
         Z3SmBT1eyBmi5WpW+mSlFnWJ7H0JIIbGj5SLq4XwPQ+4D7hQdH6O0jhh6b3pClSaWVKX
         CAGfFUuDlqLVS1oeQOkprdDLgaE08e29+550OyJrLzG43CaOSZyDsgPifjqnzD1uUz0c
         1Iyu4owgk8V5AzFTYT2FP1UJLWvhiOYicklYTrvfoEijYxVWBS90iTJ1oEX1QLSwYjqs
         4ajA==
X-Forwarded-Encrypted: i=1; AKwUvByPpwv0D9r3RkDrfVQQU/6BJcd6u5SCFhujJc8uuqmvpsxiwaejqPRlK5BHK4wwjMyaurBdOqg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK19lwa64QRaBaXYN5U6v6NHTAOhFXHCpmLxww/ahC6BaZMerUb
	JMx3nC5Xb9GwVY4z9stI9oRAMgwVs33+06ie9Rx0d+8xKVgJKWyoZ7qQf2izCvTlMHC2Mqlwgvk
	XfFJ9Uwdwxm2/Ei2QO/PnJbBwgQbfrhcpLS3rjUUsYbnC4sdF0DkvbYZKto4=
X-Gm-Gg: AYBFou2nbagD8pKjsgvwfJ4XVEv+pLvYW0yCvUp0TdvQkjC0JyGJrGjl5L/NPOR5qZ6
	HA9aYYkMDEqhrUilbgisqwoLLVc84EXCEga+zQE1aqDSmaanYW3YA8wMnbVC96HCfQD2HPEgM37
	edTQgirbtSQdAYVlj/ztDou5lDQPbDf0wU1v80S4/QmfT9UPlTtU2uWuhVT0aD0feANdo4IOf6a
	tKHaYGA8axiEK26BHc7VNzyCrVWMvUJXYMCLTaRLEcdfqhBvIawiua+zL9Y2kWhgelgIxQL7EyV
	ayGwdO4UjxJLPUvWsoRdxFDd7xYW9dNvIdKnkJknERpCSReO2dRPmPEyRLw/EytIacXbLZpTUfg
	e6z62+MvqzSKUEHhfARrCsPCSt14f+8LuZJNz2A==
X-Received: by 2002:a17:902:ccc8:b0:2e2:dc50:16a8 with SMTP id d9443c01a7336-2e9a6a06d58mr60633465ad.27.1792405687262;
        Mon, 19 Oct 2026 03:28:07 -0700 (PDT)
X-Received: by 2002:a17:902:ccc8:b0:2e2:dc50:16a8 with SMTP id d9443c01a7336-2e9a6a06d58mr60632625ad.27.1792405684608;
        Mon, 19 Oct 2026 03:28:04 -0700 (PDT)
Received: from hu-gthawre-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d7ef1sm36359785ad.3.2026.10.19.03.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:28:04 -0700 (PDT)
From: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:57:33 +0530
Subject: [PATCH 2/3] arm64: dts: qcom: lemans: Add Draco EVK SoM platform
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-lemans-draco-final-changes-bringup-v1-2-dcabe94f1074@oss.qualcomm.com>
References: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
In-Reply-To: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Kishor Buchi <kbuchi@qti.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792405669; l=11297;
 i=gopikishan.thawre@oss.qualcomm.com; s=20261019; h=from:subject:message-id;
 bh=4uCD8zymZ8QSw7IPGWfLWxd+ItY5Mq5Iy0n06TS8Gkg=;
 b=+rgkG4yzCdZziVc2RPwLYsOtXbEfD8qzJmMIBD1fGMVmAhmkRSZE+fB6Kn4STpCyqhuzwcIDO
 9BUFyIsdVbKDhroYI+PeyIQ6E2x0RmJg6Q9B6apzb04/rsTEr3Au+Fs
X-Developer-Key: i=gopikishan.thawre@oss.qualcomm.com; a=ed25519;
 pk=l7diN2ZWn/39T24vZixhPPrGDEUF6RKc19MsWZubM6s=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX5bPoJpH/gy5C
 G66yJuUSw8xr2Fd3suRABDNaTR6AoPVlZodHx93D2X4dyjmzcabDUiV11vJ/5+brIL2n64/I+XK
 J4ZqefvRxifglnQ6QeVqvT1FU/7ZQdY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX2XZnrHc2RJLh
 br/PQQM1pBtMigHi3f4tW4zEBRXZRePVKhl2p9BYTAD0BNtC+FoyevqMOltvqc2VAsy8P5A0rkd
 9Vbe2Fp608JYzA7GxwMeHMjuFt0Mo6sLw5zANXcURK3ivzSKkTgOSIo3r6bU2qH63GO+P4Cphs2
 W0nkffTHT3VVkavFLjxPOegF2Yzztr6p5W0i37pdqaOOnAEJLbjJsa8/6H8dhAmUaqKGtuzScy+
 DBz9XdvDeMH6hXu48nwJhok6b/n1RWVYy6CokcRM99DOGxvP7LMs6abHH8wuc5ymSOe+FXXsgYQ
 8shauT+LKdBooUgT9A06gXsMmn6PwDP9aI7FlXRBFBxQEslQMRzLs1l14XCKYLcMM6sSoQU/D92
 e6m5X7d8Hft/n4fJkO0GX2KXw3oXCth2kryWpQefyJf8wWCeX0cC9epUQoOS/uPhA0Wq4zaXqhN
 X5gYpmAPQVAwR7guITQ==
X-Proofpoint-ORIG-GUID: uggMiVqunlQgtxgLYsqVtp057PFTvLvN
X-Proofpoint-GUID: uggMiVqunlQgtxgLYsqVtp057PFTvLvN
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad5f0b8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=uYN2XYQzZ670T4YDsrIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190041

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
 arch/arm64/boot/dts/qcom/lemans-draco-evk-som.dtsi | 401 +++++++++++++++++++++
 1 file changed, 401 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-draco-evk-som.dtsi b/arch/arm64/boot/dts/qcom/lemans-draco-evk-som.dtsi
new file mode 100644
index 000000000000..6b7971bcdc93
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/lemans-draco-evk-som.dtsi
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

