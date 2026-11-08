Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143934;
	b=nRfskCKYKGjkOs+mSV3NOFTvwS9QkFamh2CwgJ/L/ypOjS8USdn8YVfpQ5UF0p2VxWg4
	 RjgUCPCJmqjcOpgkVT9++RQ9ZaIPhg5v8vFaCZDauDR4K6D8IIOGXfMJBrPQLLXfybVke
	 BcLgy+UcoGGMT0jy2Oh5psi0jUsJBMZi06x98X36X3v7OHIv7Q/RpPdji1a/qLoHNLjrv
	 CMOlOkliOnvQctazuZsBuKfNdeVCttCijD2Sj2NbvuM1UE1AMJ+K6WyffFuZKJgJi4o++
	 dt0Uk2PDdOcnFOyKExK/Fe701+I2fUhEDZZ7N2SG4/PcZkhKUi/uBR1MPxbZq1A6fTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143934;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Fqo4nrGyAnBaLf6Z27KaPtJVcMK19bg0Ax5ABM4JHOk=;
	b=Fsi5Et4lIdo/n0et23SPgrWHely1UMPQ3vkD2dTtf4RRHYWFbobtYQa2T6dL5m3K0dYL
	 a2yyzYaUOT8dC+KxqTZLCpPjvZv1Y4EKxtwLYFB3vGMM/Wz6Gs0DY0Qr/PGC4JG4ThCYD
	 WSpBp1Qulh1YKzNOajD/n7Rbl8gbcpqdhIwT9ViijonIRDz3xvARBECi/YWcwO9C9MHh0
	 yRbczrX7cjBQllujafPgXfJDdj/pI9wR7KsN8wYxqNdbPqaj6tqKvIs+Jb1dAnbxghWuV
	 YdT3L/bgJzpXAWaXOCnuiWW3dgLJAKQYAYZAUPkt9twqSpnemui/d7YFVqr5LCub/rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QjpIq5Fq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IKeaoKOE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18530606D802
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18530606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QjpIq5Fq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IKeaoKOE
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8AfkdM2282887
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 13:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fqo4nrGyAnBaLf6Z27KaPtJVcMK19bg0Ax5ABM4JHOk=; b=QjpIq5Fq09/ZOwsS
	zp4uRdZudwfM1GBDxURkl4ClOx4GfO6VpBH88Lgs8mGpDnD0xJzrFFS/iOrSYu51
	/buocqrqZYo3Ya+tuGswXyiDoFLDGRWzjTn0LCsacqGt6CSSuDKph83HFEa0bLq3
	BHEEkAxrXL0XOKJanxY5AThCHYXxtu9kBiyvOSy0ix3z2ThBSRLgCZj9agY5YEta
	9QHp77zn43W8O47Kq4izQndnNb54WCMVB5h806QoRbimyCgmyPRFluvKWF3hFIxL
	osKUl27//iSt4rzDmleqLu8135Jdvz2NRsDQ3eXxxXaCcj5xjSrOMBXaErj/PYG4
	KGrtJA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hstxsb3w4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:18:53 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1aa0fb7f157so157092c88.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794143933; x=1794748733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fqo4nrGyAnBaLf6Z27KaPtJVcMK19bg0Ax5ABM4JHOk=;
        b=IKeaoKOE6+LVrcGDsPn9FMN/ua82fEz0L0PH0Il5HxjDRPCVT78PPb25oPxatUb4lS
         QshrqHoFk8Ps4lh9lagwvTgEfNtlx4fVBgAzsabFo1YTd1F3q43WhZEIr74NAChSbKX6
         BAUyG2WthWWjeKvg11duXlU61ojnVukY2uYtGVRC4qVz+hlEdCO7UqiqZsaGShBg1J5v
         QxU6cr1eEzynnaBuo4Wl5lhqhXFriR6AtHQ6hD7C9QTVizX9AEad7RS3kaeRmNIOin1h
         EJjraqMkTGoIPWkg6NSp2jXk8CW90r/h+HBhROgxvHsTQDDLraztWBVC4cYCF23+LpyN
         36iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794143933; x=1794748733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fqo4nrGyAnBaLf6Z27KaPtJVcMK19bg0Ax5ABM4JHOk=;
        b=HpYvdX3Jq8QGcl6Kpm/pn2IBQJ7Cdpkg9M0e6dye0dTG9ZQmiiNKcLKoytVrW1PhOP
         FdYPW5xrJorhNowev5RmU+cNH0hXzxo1zJOoF5AZwcVS8I+/89VNnp10Fh8mmyzN2ptw
         s7zAr3MuWtC7Xx3hj/ZvRBru7mAWp94l2CeXeJISc/np2fFrdeMp2ydQzsBvGjO4wB56
         f0FfqMh6eHabj+rcGFxAk8K5u4XRt1MWFP2FRm6qHCPXWnZ8OeazPv2JAFDmsH2Qwaa8
         EQ0rhoqiEi8RP8ukBHh6/uqlc5CcEZW9dVAWpJcSd+SbO1PRgTtaxt7EnMrASBEy48nn
         ZxSA==
X-Forwarded-Encrypted: i=1; AL+hErETq2kpb1jceW8rDdioDvY+bhH0iv37I+WYMAEsPB7gCz7VqWW4LAaOSX+zicO+S+3+zJ22FeU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hgyYCvk7G0Or1+laZBVcAm4BuQlX1zll1G/4hSxmngn35bHxp
	6vA0oZUM4kRYDfetQxPxB/X2yQSkoKpN1fxJgwUin/QnkCD8rYdGjP7o6U4kHyiEDO9zUjDMOOy
	utNMTnppHF6ixjTkKqVrbfCT6kt8KJPIH2to0zRqlTxaqcNlpBQIefxT7JzE=
X-Gm-Gg: AYBFou0XNwKwtbG5iank2kosiEFVuGyeMF/YPYbsVEAWeM4KKRBAtvrqsnPdQDtT0PK
	Gv75jftfVhqvaUTrxtw7yRpMW0sqfj6obfs+OU8dkQwggsDRzg+Y+ijcLv0fEqcGaHZnVMcy0CU
	nCLLwAy0X7wl6tyaKAXVTxUxMqrQk8YSfi2Wnp7AV4KSGS1MLUxxOblF/vu58g/XE5C7ftdQfHU
	60etNAOp95lvpXLls8sxXTwIsvG0p/7PNxNin24f8NIkLYtqgHYeXY5GrFeOD3fAyN7X5ZCGyqx
	tWniAFeT1Wzsn1Q528tj8+2bd5Ty5NdSDVbMJI82CYP5y95U/OyMxENH5jaYYrOOHTPW8aHocWc
	YB8uZUiiLKZL8F7JovXwz5cWf85Vjb6Y9lbBy6rcUt95cI59PS3HhV1oQsXEDWmtRHTw85ruAgu
	K/BWM=
X-Received: by 2002:a05:701b:2802:b0:1b2:46ca:242e with SMTP id a92af1059eb24-1b39fecac22mr2104857c88.14.1794143932147;
        Sun, 08 Nov 2026 05:18:52 -0800 (PST)
X-Received: by 2002:a05:701b:2802:b0:1b2:46ca:242e with SMTP id a92af1059eb24-1b39fecac22mr2104817c88.14.1794143931442;
        Sun, 08 Nov 2026 05:18:51 -0800 (PST)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm5336980c88.13.2026.11.08.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:18:51 -0800 (PST)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Sun, 08 Nov 2026 18:48:24 +0530
Subject: [PATCH v2 03/10] dt-bindings: ptp: Document TSCSS hardware on
 Qualcomm Nord and Shikra SoCs
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
Message-Id: <20261108-tscss-v2-3-d5f575010427@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: igWfUACvpREvaKuf4BujQf8RYui9tacr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX3VtkG+HtLMUp
 u0pclKGYypNCCKI+J5SuWKUEJExPaQ4NOPtIjvSIOWEUvvxoj4DXAi/LFbnnJhHoLiTOr3dYFRf
 bEHSdjJYxhNFmfB6S76yU1Timk4eYnU=
X-Authority-Analysis: v=2.4 cv=dZMVTnXe c=1 sm=1 tr=0 ts=6af076bd cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=nKCL-24MKaImGustjYoA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX/m/BtVdznCGF
 Thp3SwFbIOIs8BgHqBr3Fo+Oe4LMkKX690Nf2NVlwZW4MHXVJvFKvuR29GixnpRoceONrbp7tXc
 vJeDvmZJFHWPL7ZWWrLZGlv4z7boENWejOoNhFko5wKoWgNMT4wHVHGV0WT/N8Zz3nuGGw3yhFe
 cLvsTnbAy4c8GLmPIrJZQG3aP4IgZBbWJY7FiCfc7RGrN+WtdlkPMuY4VboutDbxGoMENWR2Npb
 rmENTx3K26JjNqPzlMk//YYXWi4wO8ZYo87gp1jJ8dQxtiDsFtnHXL6uSfHhZi/OT4bB+6oXmcj
 wgNqaR8RhXuBdXgY5s1n+cNoIyZDPhQsVY/y5JKfEXrxGVCIFryNmVSoTOE2gTyOo/mQdJLC7kB
 ONloEAWD1aAUXsVgJTlZjLzk1nQx5BKT8GiIOa9WeCub3i3FJtuia6KbK7bJeMkpMpyx3hm4Rzo
 fy26Etr57ltGXMlnN6Q==
X-Proofpoint-GUID: igWfUACvpREvaKuf4BujQf8RYui9tacr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080052

Add Devicetree bindings for the Timestamp Counter Subsystem (TSCSS) found
on Qualcomm Nord and Shikra SoCs.

TSCSS is a time synchronization subsystem composed of two main blocks:
Timestamp Counter (TSC) and Event Timestamp Unit (ETU). The TSC block
provides a continuously running counter used for timekeeping, while the
ETU captures timestamps for external hardware event triggers.

Nord additionally has a timer register region used to generate a
periodic pulse in sync with the TSC counter.

Co-developed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 .../devicetree/bindings/ptp/qcom,nord-tscss.yaml   | 186 +++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/Documentation/devicetree/bindings/ptp/qcom,nord-tscss.yaml b/Documentation/devicetree/bindings/ptp/qcom,nord-tscss.yaml
new file mode 100644
index 000000000000..9d49e66a35c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/qcom,nord-tscss.yaml
@@ -0,0 +1,186 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/qcom,nord-tscss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Timestamp Counter Subsystem (TSCSS) on Qualcomm Nord and Shikra
+
+maintainers:
+  - Imran Shaik <imran.shaik@oss.qualcomm.com>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  Qualcomm TSCSS is a time synchronization subsystem composed of two main
+  blocks - the Timestamp Counter (TSC) and the Event Timestamp Unit (ETU).
+
+  The TSC block is a timestamp generator that maintains a running counter used
+  for system timekeeping, and is functional with just the AHB and counter
+  clocks.
+  The ETU block captures TSC timestamps for external hardware events. Each
+  ETU slice binds a slice number to an external event selector, and a
+  single summary interrupt is raised for any ETU slice event.
+
+  Nord additionally has a timer register region used to generate a
+  periodic pulse in sync with the TSC counter.
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,nord-tscss
+      - items:
+          - const: qcom,shikra-tscss
+          - const: qcom,nord-tscss
+
+  reg:
+    minItems: 1
+    maxItems: 3
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: tsc
+      - const: etu
+      - const: timer
+
+  clocks:
+    items:
+      - description: TSC AHB configuration clock.
+      - description: TSC global counter clock.
+      - description: TSC ETU clock.
+
+  clock-names:
+    items:
+      - const: ahb
+      - const: cntr
+      - const: etu
+
+  interrupts:
+    items:
+      - description:
+          Summary interrupt raised based on an external event for any
+          of the ETU slices.
+
+  interrupt-names:
+    items:
+      - const: etu_summary
+
+  pinctrl-names:
+    minItems: 1
+    maxItems: 32
+    items:
+      pattern: "^slice[0-9]+$"
+
+  qcom,etu-slice:
+    description:
+      ETU slice number for each entry in pinctrl-<n>, pinctrl-names and
+      qcom,etu-event-sel.
+    minItems: 1
+    maxItems: 32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  qcom,etu-event-sel:
+    description:
+      External event selection value for each ETU slice listed in
+      qcom,etu-slice.
+    minItems: 1
+    maxItems: 32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
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
+        reg-names:
+          contains:
+            const: etu
+    then:
+      required:
+        - interrupts
+        - interrupt-names
+        - pinctrl-names
+        - qcom,etu-slice
+        - qcom,etu-event-sel
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,shikra-tscss
+    then:
+      properties:
+        reg-names:
+          minItems: 1
+          items:
+            - const: tsc
+            - const: etu
+        pinctrl-names:
+          maxItems: 8
+        qcom,etu-slice:
+          maxItems: 8
+        qcom,etu-event-sel:
+          maxItems: 8
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      ptp@1c80000 {
+        compatible = "qcom,nord-tscss";
+        reg = <0x0 0x01c80000 0x0 0x2000>;
+        reg-names = "tsc";
+
+        clocks = <&gcc_tscss_ahb_clk>,
+                 <&gcc_tscss_cntr_clk>,
+                 <&gcc_tscss_etu_clk>;
+        clock-names = "ahb", "cntr", "etu";
+
+        assigned-clocks = <&gcc_tscss_cntr_clk>;
+        assigned-clock-rates = <250000000>;
+      };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      ptp@1c80000 {
+        compatible = "qcom,nord-tscss";
+        reg = <0x0 0x01c80000 0x0 0x2000>,
+              <0x0 0x01ca0000 0x0 0x20000>,
+              <0x0 0x01c87000 0x0 0x1000>;
+        reg-names = "tsc", "etu", "timer";
+
+        clocks = <&gcc_tscss_ahb_clk>,
+                 <&gcc_tscss_cntr_clk>,
+                 <&gcc_tscss_etu_clk>;
+        clock-names = "ahb", "cntr", "etu";
+
+        assigned-clocks = <&gcc_tscss_cntr_clk>;
+        assigned-clock-rates = <250000000>;
+
+        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "etu_summary";
+
+        pinctrl-0 = <&cci_timer0>;
+        pinctrl-1 = <&cci_timer1>;
+        pinctrl-names = "slice1", "slice2";
+
+        qcom,etu-slice = <1 2>;
+        qcom,etu-event-sel = <1 2>;
+      };
+    };
+...

-- 
2.34.1

