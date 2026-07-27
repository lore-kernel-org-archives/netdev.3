Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025682D780C
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161503; cv=none; b=IKYoMkTKnehdK0di0cO/u8Eec+K3bKLlYaskBj8h+ox15zmH3V/7fGLIFzeVf5Sl6+qeAX/S5/u8kzF/P6lbz4f5usUryPbjeLIXDl6CY+bd/+kZ5b2/RcRs+3rSXYMJ1oHwjnw2KKJDcVHq/DVE7MBpT67l7SFZKvMQG3HcHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161503; c=relaxed/simple;
	bh=HW5o+7T8MhG/dED5+pmSN9kenQTmcJHxIQAMKcoKkwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/nE/uSpI9tP4AnYhKUDHB/Le79vr1/x5jrgczmU1eKOatco2qbEtt0F5B/kLcrTDR9E49mVQm/iJJdcR1KknhIiUA0YTQXSVyy32ZaytjEnGKFwVhb9N2xDsSZ01TWaEX35wAqJ/3x54vW1kCXNpKrvRL0rBo9MvJWwUIp95Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BLEQJvpB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kwqcGDjp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BLEQJvpB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kwqcGDjp"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlkIY4035356
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pq5KynjG+h3dOD+hNCrGLWYcr2Zxu6lNDSIRze/ZJeo=; b=BLEQJvpBRT3uJD/H
	ikz+og37OcjmaFCUb/fuzYUd4PCf35IWO0kQHT7BqE8FLt1MSaA1Azr0c08IOoPq
	gXHpH0ZRUxRsh9fta3wlW0JSFOHabhOQH5MynNxwfR9tJ9cTV7o1oupINAd7Mgez
	V2K7hp9sIWdVDezZL/PoI3RXVMD9LnBrZ0bDKr7cQEc6wyIZ0/jNOqla0iWx5Et/
	YdTFKFairL/RCe8L5Htae+0rOw+qZZBFxlJJlAZboblWw+w8Wd3OSJ4r2jAM26TE
	l/gvXKFZqUZV4jzJ5Oe9TPPsrkjFBvRowVJxRPBL37vMCFM2vfQaCZM8Dm0m1DS5
	lLxpUA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp30g1kd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:11:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so6809152a91.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785161499; x=1785766299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pq5KynjG+h3dOD+hNCrGLWYcr2Zxu6lNDSIRze/ZJeo=;
        b=kwqcGDjpOkbeAhjuzzmV2T98WGmfr3QntKKVQrJmyhYhUt+Dlp1co12BY/DOC7SpbK
         9FugsTFmUS0Rrnt0uUP7qUeTPn8Usa44aOFTHpqz5WiYfy5dmxzRrwX+FKO/KJlmX3G7
         L4Fi1MDzuWLBApGhDQSLRopaSgBmD5fFxK3mwSP84IdQC2LkbSqYpH9kXNsx2g98VAm1
         BTYjr/DEqje5hB803tQGHQ+N3UJv449aurvH+PVrvgcX25kAlE6eiOyz8Vda1xYJzD8d
         AmVDPBCp6/asbLHMJPadbX9J7NiCUJkfi3TMlkc0+ZLsI/Lzr7kgaEJzdFObbp+o7E5F
         Nyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161499; x=1785766299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pq5KynjG+h3dOD+hNCrGLWYcr2Zxu6lNDSIRze/ZJeo=;
        b=VvkJ3C6d9umczz8j15jsoE4tuI3e2GKTSCfdrwmuidYclBpwwSEt41az9VQSj4CTAW
         1mHfIbMoWvQ4lsOcqaL3VFCw3tqKV3mrTnEU1ubIj1D5Pg/MMqrR1mRhHgrm9lyXMQyr
         RdwAEZr+ucW6gcHFgq8cJ87IOUk+ZT62qCfAPSwasrwLfxIa1pp8ES6pjFrKIZjuufuB
         TDxEKuRBYDl5EM/U2NEMZjCVo2950uSe2jRtVSYQjQBLSvcU58ztVxYJ4ETRvcEAPckt
         G/esKQTCL+vvhw39sfvwvqcqFN3dVMDV/gu16PZ89dTpJfjaXiUuTQA7JevDGpbGSjfD
         jUPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYl9nJZ6JJIOVh0iswXTORiYGm2BSSKkIlCXCo4CH8OYSXfhkY2sz5ypxJtuES3pUWDIc4hfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxusRaMBZgOjxW1M2wDmPyBj0Yx1tnhkwAw2pKlqKFKhASeI4Ot
	n4xWXWhAq7SlWyM4rKNn1cAOxWGmVdqGM1Ec/dbYKGVMQM8PiLgUC28n3eKeyHokzl3M0hqNW9L
	HbhVu1Wg2LJuO7ez0XbiOhoFptv/TrSvn9i/FgwDpWK+H2vqDXbDDepNED0E=
X-Gm-Gg: AR+sD10Rs1MKpgFPbpNPmeu20hZfFruMI9T85N1yyzGRs907fU6RB5/sItFTDTi3D8S
	cUjLUeYLpCeUPXBaxFEuxZGl3cCLDI8uUTwXUZS/M4GqBQq8ahlVhCQ0P5syMIGEB6XHXgLROCr
	9SvRbgR9XRiG1vc102MlneUJ8SZGnWvSlcWFOnAKvPOpDIYN1U7CamkWN9NaE2Uz7rRnMWJCcjc
	2mmsmCABKBOvA4NuSvyhHl7njXV6kZ3ZCYkzH9urarsiX6KZgfM+bLJe1kNI1pyn2BBeXqlPMkF
	QO3Wwrv/8Y76r5NCF7GhxlNRwPgSBlrI5MZau2bIKD+34OJOla0XkVE1asr/iGMZmnkLZQbCoAC
	eueR4Gy45i13EJsWXeB7sF10naPzopg0=
X-Received: by 2002:a05:6a20:d50b:b0:3c0:9c1b:d0bf with SMTP id adf61e73a8af0-3c67e0b1d30mr8680643637.74.1785161499464;
        Mon, 27 Jul 2026 07:11:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:d50b:b0:3c0:9c1b:d0bf with SMTP id adf61e73a8af0-3c67e0b1d30mr8680592637.74.1785161499048;
        Mon, 27 Jul 2026 07:11:39 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm53438677eec.13.2026.07.27.07.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:11:38 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:40:57 +0530
Subject: [PATCH 1/6] dt-bindings: ptp: Document the TSCSS on Qualcomm
 Lemans and Monaco SoCs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tscss-v1-1-beed14e72510@oss.qualcomm.com>
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
In-Reply-To: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a67671c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=LvIppRi0fLrXIX5vxKMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNSBTYWx0ZWRfX6zns5wxSWX/w
 65jSJDx/oVSOh1wb+SuxTmiAqywPiCxLl0qXxBQHxXEF2Ote/BZX2C8MKa+1Yghw33MzMxaG+AL
 9nUe5mvP5r4rA9fKRQhQn/rp3ntPwp0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNSBTYWx0ZWRfX4y1T/zDzf6b8
 muh3IwQP3zVb8Yp21yuqAGcnxCMoC0W+lbBe+SRewKBF+iDNXoLIoD/dI0+Du3WzzvcyFUJ9iLd
 rTKOOP3tfOkick4b8qraNCL63ItA7cE1BV9EApSqh7auHS33i8WjulQ41dbm1SGeRGcyObg0Y5q
 DbS7JwqAqzwmz/p4kYpEnCUNhwhq5ZtFiymBhx6BydGK1Tmtxol/EBhLC2U/BNWVbX7vJiM6mS1
 sLPSfDsvpsuiII17YTGyXdiUaiWZv47nUuwf1y8EKSAad6LD/GG6RqM491woX7fALGU+u2F9sD4
 0g3i/9x3GJkcVyL7XONJxuFJcNM0/TCCMdM6El+NaUs8DM4v5VvKAu6x823yU1s5plRcOjDBVR0
 c3PKnJW9IKM/x8k4bCp2nNfkHHRzun+mjTsc74k52B8BQhf79/cfQTxxOUSh58JeUd66W89F1pi
 uqaG/g+tgnIX4xuuDVQ==
X-Proofpoint-GUID: ewwf1_0V6DWvajSLNONTW1riaoAuu8NY
X-Proofpoint-ORIG-GUID: ewwf1_0V6DWvajSLNONTW1riaoAuu8NY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270135

Add Devicetree bindings for the Timestamp Counter Subsystem (TSCSS) found
on Qualcomm Lemans and Monaco SoCs.

TSCSS is a time synchronization subsystem composed of two main blocks:
Timestamp Counter (TSC) and Event Timestamp Unit (ETU). The TSC block
provides a continuously running counter used for timekeeping, while the
ETU captures timestamps for external hardware event triggers.

Co-developed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 .../devicetree/bindings/ptp/qcom,lemans-tscss.yaml | 198 +++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/Documentation/devicetree/bindings/ptp/qcom,lemans-tscss.yaml b/Documentation/devicetree/bindings/ptp/qcom,lemans-tscss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..4cbe4b00ff7dcacbd8cc111e2b4b61ebce7104aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/qcom,lemans-tscss.yaml
@@ -0,0 +1,198 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/qcom,lemans-tscss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Timestamp Counter Subsystem (TSCSS) on Qualcomm Lemans and Monaco SoCs
+
+maintainers:
+  - Imran Shaik <imran.shaik@oss.qualcomm.com>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  Qualcomm TSCSS is a time synchronization subsystem composed of two main
+  blocks - the Time Stamp Counter (TSC) and the Event Timestamp Unit (ETU).
+
+  The TSC block is a timestamp generator that maintains a running counter used
+  for system timekeeping, and is functional with just the AHB and counter
+  clocks.
+  The ETU block is optional and captures TSC timestamps for external
+  hardware events, each ETU slice binding a slice identifier to an external
+  event selector. Support for the ETU block requires the additional ETU
+  clock along with the summary interrupt and slice subnodes.
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,lemans-tscss
+      - items:
+          - const: qcom,monaco-tscss
+          - const: qcom,lemans-tscss
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: tsc
+
+  clocks:
+    minItems: 2
+    items:
+      - description: TSC AHB configuration clock.
+      - description: TSC global counter clock.
+      - description: TSC ETU clock.
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: ahb
+      - const: cntr
+      - const: etu
+
+  interrupts:
+    description: Summary interrupt raised based on external event for any of the ETU slices.
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: etu_summary
+
+  assigned-clocks: true
+  assigned-clock-rates: true
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+patternProperties:
+  "^etu-slice@[0-9a-f]+$":
+    type: object
+    description: ETU slice configuration
+    properties:
+      reg:
+        maxItems: 1
+
+      pinctrl-0: true
+
+      pinctrl-names:
+        items:
+          - const: default
+
+      qcom,etu-event-sel:
+        description: Event selection value for this slice.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      qcom,etu-slice:
+        description: ETU slice identifier.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    required:
+      - reg
+      - qcom,etu-event-sel
+      - qcom,etu-slice
+      - pinctrl-0
+      - pinctrl-names
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+
+allOf:
+  - if:
+      properties:
+        clock-names:
+          contains:
+            const: etu
+    then:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
+      required:
+        - interrupts
+        - interrupt-names
+        - "#address-cells"
+        - "#size-cells"
+        - ranges
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      tscss@1c80000 {
+        compatible = "qcom,lemans-tscss";
+        reg = <0x0 0x01c80000 0x0 0x2000>;
+        reg-names = "tsc";
+
+        clocks = <&gcc GCC_TSCSS_AHB_CLK>,
+                 <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
+        clock-names = "ahb", "cntr";
+
+        assigned-clocks = <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
+        assigned-clock-rates = <15625000>;
+      };
+    };
+
+  - |
+    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      tscss@1c80000 {
+        compatible = "qcom,lemans-tscss";
+        reg = <0x0 0x01c80000 0x0 0x2000>;
+        reg-names = "tsc";
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        clocks = <&gcc GCC_TSCSS_AHB_CLK>,
+                 <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>,
+                 <&gcc GCC_TSCSS_ETU_CLK>;
+        clock-names = "ahb", "cntr", "etu";
+
+        assigned-clocks = <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>,
+                          <&gcc GCC_TSCSS_ETU_CLK>;
+        assigned-clock-rates = <15625000>, <15625000>;
+
+        interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "etu_summary";
+
+        etu-slice@1c91000 {
+          reg = <0x0 0x01c91000 0x0 0x1000>;
+          pinctrl-0 = <&cci_timer0>;
+          pinctrl-names = "default";
+          qcom,etu-event-sel = <1>;
+          qcom,etu-slice = <1>;
+        };
+
+        etu-slice@1c92000 {
+          reg = <0x0 0x01c92000 0x0 0x1000>;
+          pinctrl-0 = <&cci_timer1>;
+          pinctrl-names = "default";
+          qcom,etu-event-sel = <2>;
+          qcom,etu-slice = <2>;
+        };
+      };
+    };
+...

-- 
2.34.1

