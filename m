Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07FB28AB0B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161509; cv=none; b=fffwGTf1YMtKpWP4v4scXsFgulG50dn5yQC2YXuZg03hY9RRMzFuhxlNVJ3dUFtcr5qSEoiusOHH1V9cWw7E1t9ZRHuzhYHCr1XylCrEWVc+o6aRwsJ1gNkffIGCEkBylGjM41KxoGaIrNn4VpGGC5v/GPUDCQ5gVw9voK0zFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161509; c=relaxed/simple;
	bh=hMCvPgBPB3q9MAdNcGHYbIRCM3IAMI96J+Q0IZtiLy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFuxlByhSmhoQGxlpdUGuKUQAcHLgBQZUs6jbpfyVrleNa3J8/tq0GVVBV5KmvanplqOQ4EAmi4hwNHFpBwYigrcw+3jEnjoayECyOYZ/h1uiVpta18+U/wmW5g9A6u7UDdrmR2aMhTpXPg9RbB+6R+mihCDo0WLgIENBTud+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NuU61zqi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S5LPPuKD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NuU61zqi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S5LPPuKD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlvjd3787534
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x42XRV/b+7FIQ3y9QK+srSnj/CLDUIWtj9CDTSVpPG4=; b=NuU61zqiqq2V4LDG
	YqpwxlTM/ewh4kAkgGhQm4kIPOL27ilJaRl485OLGByUiBsF+SVUh+c4ZJVrNy93
	Znx7V1lnLEdeKLEyvdOPNuJXfK1c+s7W2y7r7GaZRLUj+P35RhaAhoiPHPAhWiV/
	c+kWdhvQVPRlmp62THn07X3NoU6wT4m07d8mKjSPv8uH4JCwzR9++VHxLtw4dX1J
	uGGnShy5Cr3vtNcTYHlezyYRPpgKM9TB1Kwhq7S8MfjHzl21VoNdTpE54bhSdNoV
	Bn4U2q5LJUwsuOFD9KOwdNH2p36hpxY7ATnO5Td/BT0QmtBPPywBYlaUgZmZnvmZ
	6kQ3dg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2ha0f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:11:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so3226546a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785161505; x=1785766305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x42XRV/b+7FIQ3y9QK+srSnj/CLDUIWtj9CDTSVpPG4=;
        b=S5LPPuKDHiNNMeGyUvNOt09HG6/3jRZBVnnNQUPsK33l6+3YZ2dpGkirxaOuQAwJSY
         NCG46bntYviLWsoO6Ox4epkxALaGMO5j12pBMFdxC4lVWu4MAkXSOiwik1vWw7dvcgPi
         QnygolIIAbrxZrsy4fR5XtuZa24dGZss5OHFdNG+Gsm/vmuafFZYcnHoMWcp/OfpTOXM
         Tlr8uvEqnJqBVDLaSKAvJWEL8yWWqQnbo6w9PUbG+LdR2Hi5XvfVsaF4OLuUz/3x5cJc
         dO1SBXFuXLtHJKl8CVYFEox53vrqnbyLlekUwturr7JNmlOOjgA9NtFdbu0i4amLKG/6
         RiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161505; x=1785766305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x42XRV/b+7FIQ3y9QK+srSnj/CLDUIWtj9CDTSVpPG4=;
        b=GXZXnsRtpprCJ6D6+FQqIVF0qhX7xyZCENKyRwJ3QtpI2U3U//tw2NtSM7bD8QvJlZ
         ly2vL2hkzhyWuJlkb4Mj2zccCWQaTQZUaT/+PI5owokMeFenmD0Q19p2GIpsTWGik4ME
         yYKNjeByTeyKMb/HcGi6DRpM4RKuIywHhyv6PsqiDgwTA6N6DncUtbsZ2gEje+fk6fap
         js+zf4xphvbeW7bqbsJjWcmOVxMN+iCa24iHjRvuHrmDgq538tESxjMkLZtz0WwCXfyU
         VDtoPpE49vStyIJOqg8nSSW0j3fIpzHAUcIUhQ5W7S1V1D3c0cPwv4naK/drzg7a36l/
         KIUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqh0AVwGF1OaQw/sor/w4KTAQ1V+qkP9xXk7IOmGnbtsw5fO460I6HIG0mYcgAhlX85G5WYOLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXAkwC3LHUwAuMCceTW6SoaLia+WDrtxl+tyYU2Dg5JdDOaMLu
	Bkza5bpvNcffbJXKfRkbwgIzv0BJ17dPZHr51qD3gEdIc5cvYgFRC9sDzPHnraMCFSc8tzn/IHy
	AW7e8Da4NaERWL/aq4oOLEHU1OvvGqRt4cK633Z1dS/yQoAWGCZZigIajuNs=
X-Gm-Gg: AR+sD12/BacBfb0U0T2NOAjEt9wuyPj9sEH7sBXEqHoUgoBAX9FZp25YnN1pf9VwGKu
	6BtUlCYHIR5T9SiqrnymrKzdU27xQMWoV1DmdhIhweA23hZmO961Fgy1HGLo5VwuIL9MHB0umcz
	gOP3c9NUSHiO2UW1c3jKt+hqF3+V72LZJHgaump+IfrPr7wT1M0ze3udskKA/5W4ZZfAwm0UJ19
	FfRC8pO4HoWPBk1j+Vrtm+1XWXZgovOF2zfHrQTebABlBWRQMEcCg+TUFyY+Pr0CTtS/JZXJM2I
	HOLUmuyHtQTAeLBtzWNyIgclHczT1uh3DeXCssIQ+MNKQ446zB/E1NvBYwqLGu4W8hdgD0Yeifa
	MYzIopqB5Q05mKAuA6tOG2Bw7cuExy3A=
X-Received: by 2002:a05:6a20:1602:b0:3c3:a140:9380 with SMTP id adf61e73a8af0-3c67da110cbmr7593814637.16.1785161505445;
        Mon, 27 Jul 2026 07:11:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:1602:b0:3c3:a140:9380 with SMTP id adf61e73a8af0-3c67da110cbmr7593784637.16.1785161505023;
        Mon, 27 Jul 2026 07:11:45 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm53438677eec.13.2026.07.27.07.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:11:44 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:40:58 +0530
Subject: [PATCH 2/6] dt-bindings: ptp: Document TSCSS hardware on Qualcomm
 QDU1000 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tscss-v1-2-beed14e72510@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNSBTYWx0ZWRfX4/+BVvzTuNza
 xnMJcSywlhGEPnCyzfpKr0j9vRpiyUto4uBWOXx/64dt6kL3uU1l5O0R8aKrJi/Om8QUAw0vI06
 eycUBu/hktqPUHJquLaXwwKts3Xbps0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNSBTYWx0ZWRfXzSQO9urOecR2
 n0k7sfrO0EMj2/zzBiPzQl1/QPCQ8luWeFwOQ0k2RGFxi4Ffr0vYdUmtnZcdTYhwa+Vv4mBnCMd
 9hp/zcSKCP9I9Uk0HYYm+ZeZPtJr5XVjDrlDhniy7I1+7d2zFWoZYuXZH1Oy41/pkcspCeWo4/3
 CIVV10s5KFKDXbXnThTZt7wituofvzPOxqJ0wbUpq7W6xnVDtlMqVgoN3o2VJSQ2sw764K7k14H
 4g/2swVb5e2qcakU40M3XUSqTI4SnbKRLtLuSYFnk2JQaPcz7Ah71fSrVPaP099TRRMxUHaFuQk
 gVKyiO5Hx5ReeVLVF6YAwpmb5nJFFikNOqcowrq569PkbhwgTyZRW2eo6ioCddelhROfrvMxwRa
 ma/AYv+73OPZFVb3cVxJywwiziQlTcOzBSE+Z6suQemql7Dd9P5DS3o2TjX/Cp6f1g1HJ2fWWxx
 KgFjt8jiWo7ntY9rPDA==
X-Proofpoint-GUID: Bo8X8ZrKdE33ZYiNRYJaSrZWqtARGuSq
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a676722 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=-YqWXAWF1hLJgJDcJRIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: Bo8X8ZrKdE33ZYiNRYJaSrZWqtARGuSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270135

Add Devicetree bindings for the Timestamp Counter Subsystem (TSCSS) found
on Qualcomm QDU1000 SoC.

TSCSS is a time synchronization subsystem composed of two main blocks:
Timestamp Counter (TSC) and Event Timestamp Unit (ETU). The TSC block
provides a continuously running counter used for timekeeping, while the
ETU captures timestamps for external hardware event triggers.

Co-developed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 .../bindings/ptp/qcom,qdu1000-tscss.yaml           | 187 +++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml b/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..39387614ef8939b7840df2f0d5640b9e142fb4e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml
@@ -0,0 +1,187 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/qcom,qdu1000-tscss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Timestamp Counter Subsystem (TSCSS) on Qualcomm QDU1000 SoC
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
+  clock along with the per slice interrupt and slice subnodes.
+
+properties:
+  compatible:
+    const: qcom,qdu1000-tscss
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
+      interrupts:
+        description: Per slice interrupt generated by ETU based on external event trigger.
+        maxItems: 1
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
+      - interrupts
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
+        - "#address-cells"
+        - "#size-cells"
+        - ranges
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,qdu1000-gcc.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      tscss@1da0000 {
+        compatible = "qcom,qdu1000-tscss";
+        reg = <0x0 0x01da0000 0x0 0x2000>;
+        reg-names = "tsc";
+
+        clocks = <&gcc GCC_TSC_CFG_AHB_CLK>,
+                 <&gcc GCC_TSC_CNTR_CLK>;
+        clock-names = "ahb", "cntr";
+        assigned-clocks = <&gcc GCC_TSC_CNTR_CLK>;
+        assigned-clock-rates = <500000000>;
+      };
+    };
+
+  - |
+    #include <dt-bindings/clock/qcom,qdu1000-gcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      tscss@1da0000 {
+        compatible = "qcom,qdu1000-tscss";
+        reg = <0x0 0x01da0000 0x0 0x2000>;
+        reg-names = "tsc";
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        clocks = <&gcc GCC_TSC_CFG_AHB_CLK>,
+                 <&gcc GCC_TSC_CNTR_CLK>,
+                 <&gcc GCC_TSC_ETU_CLK>;
+        clock-names = "ahb", "cntr", "etu";
+
+        assigned-clocks = <&gcc GCC_TSC_CNTR_CLK>,
+                          <&gcc GCC_TSC_ETU_CLK>;
+        assigned-clock-rates = <500000000>, <500000000>;
+
+        etu-slice@1db1000 {
+          reg = <0x0 0x01db1000 0x0 0x1000>;
+          interrupts = <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
+          pinctrl-0 = <&cci_timer0>;
+          pinctrl-names = "default";
+          qcom,etu-event-sel = <1>;
+          qcom,etu-slice = <1>;
+        };
+
+        etu-slice@1db2000 {
+          reg = <0x0 0x01db2000 0x0 0x1000>;
+          interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
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

