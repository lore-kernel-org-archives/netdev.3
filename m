Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014194;
	b=x9qYPuX2nn0aQdDWNiFLIopqpgV7tGjTmWCNLUAGfIArXk5uEIwnuYV8zx18ZQJtqMZ0
	 jFO0IfClbkdsW1dvQ4ymOVoKHcelqE5NmdNg2Nv/lA2Fk2K+7JF1yd1LX5vkL99Qg/x3w
	 LzC4gUOyhyKK3682bcHDUTZUFijlHiKhNBdM5HIA5yxDFiCVT9Vhd5DamKAUP3GbxNMXh
	 1gbfoulsC5b+ucPj1iZPMW2PRn4VRX3kpRtfPllUdn790Uf0vqi2TeHgu0Zik/dHsj0MT
	 lTnG6hvnWor35QriGVXejR2XLMQLfTcgFLQrOOCfWA2jPoTaBstWyDP7LnqQlKJUP5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014194;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vHGot6Ifz03WRWLIdDpMj7x0/Veb34RvuCZUlzZRN3w=;
	b=QDD1iZ3G6wQ1sepwud9NlBua5P5gsXLkswXVhjxczW7uRh1R+GiCyAjVNQq1YKIumlJ6
	 H6/+gQ3r2aGAY98vmhp8Mf/i/GPnimvPJuYMxLJFz8l2XTgAdUjEYelY7IFU9GQvCvMFs
	 IYqB2L0MBhi1GI4277Od4Cci3fnT+GO0Sk6juOImN5f0XVcTXrzPWceoQhNtsDGSw/+wD
	 v4Jhe6xBzYLEOGrHTNIzK1ZLbr+XMaa48lDHWo5KRgKcUZf0ywxfjntH6CDW9McuVCJVA
	 PLFmAgw/4qvx2dem8KchmVZtapzDmu2pf5n02YVx+ihtzw6Py7e4yHQWxzljgHvNLVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PSBdIJ14;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OsnPVI2x;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF24606A326
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF24606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PSBdIJ14;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OsnPVI2x
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAsvGC3561850
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vHGot6Ifz03WRWLIdDpMj7x0/Veb34RvuCZUlzZRN3w=; b=PSBdIJ14bS1Hp1tg
	oDM+hArGNQohRg7tl2vF0jYsC9Cq/365NOI92DKiVjYD8RBCFn8G5K9Ri0w2elCc
	3mwZI7DSPuiiL9VTrWE8xioJTSrszzCuChF1MpqiIA+edH+UpPU88rRYG/3lpzP1
	ty4lkf4JS9cDm7COpQpi7xtEZ+kicKyyrsRQYVbLb03Yp6XCHfHqlM3/ryYh/LJS
	QmrDJa/9oIFnwz+I5zu3DjABE6I9L8jyoUcxbthihG8mm8XtaHqWFWhLXGvFRQex
	NEadaHtiTp3O9rR5mNt1CYVTTBhqhoDu2sZQRAJlgpWRwUJZQBVkAJHFVnAnxBY8
	TiamZg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s90b4y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:29:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac6795617aso2563961a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014191; x=1793618991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vHGot6Ifz03WRWLIdDpMj7x0/Veb34RvuCZUlzZRN3w=;
        b=OsnPVI2xVUPa/As0N7Qs9373ZKgIXBga4Ronjgtr665nabD3URnkn+Dbl331GKAX2a
         GX9HEfiO/54xR+LtcnEpEhuuJBTEUlxgnmiT631KRG3mztOwx2/r//zXJeChmHGZYN1V
         ZxTBW3Q5rcJRaKoNiwQcEHQASo54yzhQombBGZR4Ra8PmgqQN2otQkop6lO91YBL2oh8
         0DvsWag/HjxGeI/ZRHcgMoDGXNg3lwhnAQpaMOFwXEPL6QEX9ohVqc6HFlXumbD7PpnE
         BrGMwrA2XVdw3PPowq86TZqoGm/hDDksPFZFah14JkKR2kl4WsJsycFdhBjKNMJXGrfe
         8e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014191; x=1793618991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHGot6Ifz03WRWLIdDpMj7x0/Veb34RvuCZUlzZRN3w=;
        b=hxL/i1sot0BXxVwD4f1YjJY1QQsn0WG1y3oQ9gdTh+9AuAXW2Q9T0hWBYdpEAg8IZk
         Ta6h5L9ypY5op0GFrkQnx89riJedZrfWhbNx2GVcaom0PUSTAbfxUeEmnciQGeuQ0jEE
         t8PS9xgthJ7uMX1dTkVXUEgHcOMuKeoUPPMNSmHeWurMGbuC49vDZW+zRDi9EAQ+qQWQ
         yyx35I/2yQ3okHt9/qcYkVToRBa8UJQ3knnp2TZXBg86gDq90phOOVlYrjlHV3kmTE5L
         AtHy8Dl1kKvf05g8jD/PTMfGGwkS+8djKy5cI8zt1zGzndAbxQm/TcwnyD3cp3rPi0up
         Ayxg==
X-Forwarded-Encrypted: i=1; AKwUvBwOH9icqFynK5wb2BRac9A94T4HpVQKB95y7YiaT1GouEAA3gL21FgS6ZJrUs/K1Y8lLGw32LY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6/qIf7S4NCb2+x72dxQbddMkj623Yz4XFCa87jdyA6QRXsPwb
	Mrthq8EvCMkAV2jw73s7elWD+bqRIoh8vHfJwYHES6mrlbBOKt4yx+14t82qw/4LmXYtxOE+jsJ
	OR1CvMYOIRNT5057tDMOl/CQJGHb/neKO+f3Z0pM9v8Bv5sQaoMbrPWUtbV0=
X-Gm-Gg: AYBFou382HeptCEcrik/SlF/0AF6jSxrbnBkxqA1fguUfAqrmsK3RBwcyhdhfR9ovQf
	eppFt89L7jcZkH+FRwQ12mkKm7QLct6PNn0gKVPNTDanG288xcSm8/KxiMA6PcfD64mbQDG3RDG
	oP9t4FaQgfxrFa4S9d4y/Kzeta8tZfLERzbZTtzjlecPlESkt2EO0He99+IKPUzF9HhtMfKtzj6
	i4KcV8XTk9gnklpayUnlw5/VMD/9+BF0Whu9quk15ECdw2OW53xEfFCq/LR/TfUYmeYzphm9GuY
	4s5Djh00iVEyk7mFkaZ+75vBHd0VNzSeMynPl8AVCyCkr++9Yz284+i/uerqsYu0moJCJlzc/Mo
	FqjZYQ+Ei/QGa+m1ez8IN8tg=
X-Received: by 2002:a17:90b:2888:b0:3ac:b44c:2d84 with SMTP id 98e67ed59e1d1-3adea8966dcmr5277123a91.13.1793014191341;
        Mon, 26 Oct 2026 04:29:51 -0700 (PDT)
X-Received: by 2002:a17:90b:2888:b0:3ac:b44c:2d84 with SMTP id 98e67ed59e1d1-3adea8966dcmr5277090a91.13.1793014190683;
        Mon, 26 Oct 2026 04:29:50 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:29:50 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:59:27 +0530
Subject: [PATCH v2 01/12] dt-bindings: clock: qcom: Add bindings for PDM
 GP_MN clock divider
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
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-1-ff8e4bc8d567@oss.qualcomm.com>
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX+zkXPkvYm9d6
 eITABkaGSxzavfsIzvZEQTZku1L16fBOT0m85IRzPG5G7Xn2FyjrNwPS/pF8LF5GMQ/05RuJzkk
 SuxWiKdS72btPdldxCLxixBxx3dFvUXv2FnMViW7iJc+SDGLetfo+MFEAoP1mdWhBKcAsg0e8Bf
 rBFdZYNeViGxVJsy7Z/+pNseCuHTvChvqmjC4GJeuf+X4eYWmQWmUMNyspNfCKwigZy7GXplFV6
 2Kz+UMFYiavThyKLEuklft7eRYrdNrRkjNtdGwabeAyX3n5SjaY0di0eX8T+Uj1+mQ0Sc35YAQW
 ZHliUV6cHY3bLq4agWrc1WGO1rfVUDT0qlsOQsxosRcKrgSost1lJviTr85bLAl5/130MWrWM9i
 IvsbpHkJmMjah389yp629FJX6XZz7TQ+a2cdk6/VSC6hnZX3jAXlcaYC/cyAiCQQJjhYD99niXZ
 9SauDHXqr4vIttBClww==
X-Proofpoint-ORIG-GUID: QRIbu0rgtj96ersu87wC3wl4K0HvIKtT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX4maUG9Wr23/0
 2PLQqMNSCiNd9czcP8+TnmrNFpLwgAkAkxa78ZfxNKoCZ6b8xo7wEMkbL7mMfWWCCWe3Fr09ueD
 2Y1NByXuKQ5/H+aSy4AZ0wcUAiSkDk8=
X-Proofpoint-GUID: QRIbu0rgtj96ersu87wC3wl4K0HvIKtT
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adf39b0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=nhq6iwPr6d6TsRTX7tUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260045

Add device tree bindings for the Qualcomm Peripheral Web's PDM GP_MN
clock divider. The hardware generates a fractional output frequency
from a fixed input clock (typically TCXO4) using the relation
Fout = Fin * (M / N), with duty cycle controlled by a separate D
register. The clock output is routed over a gpio controlled pin.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,clk-gp-mnd.yaml | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,clk-gp-mnd.yaml b/Documentation/devicetree/bindings/clock/qcom,clk-gp-mnd.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8141f392c5d70acfc42cf1ff4b1722e1eff23afa
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,clk-gp-mnd.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,clk-gp-mnd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Peripheral Web's PDM GP_MN Clock Divider
+
+maintainers:
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  The Peripheral Web's PDM GP_MN clock divider receives an input clock
+  (TCXO4) with frequency Fin and generates an output clock with
+  frequency Fout = Fin * (M / N) and a duty cycle controlled by D
+  and routed over a gpio pin.
+
+  The divider is configured using three registers:
+
+  - GP_MN_CLK_MDIV: holds the M value.
+  - GP_MN_CLK_NDIV: holds the ones complement of (N - M).
+  - GP_MN_CLK_DUTY: holds the D value.
+
+  For every N input clock cycles the GP_MN produces M output clock
+  cycles. D is the number of native clock cycles in which the GP_MN
+  output is low, counted over 2^13 native clock cycles.
+
+  Hardware constraints:
+
+    M <= 511
+    N <= 8191
+    N > 2 * M
+    M < D < (N - M)
+    M and N must be coprime (no common divisor)
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,sc7280-gp-mnd
+      - items:
+          - enum:
+              - qcom,sa8775p-gp-mnd
+              - qcom,qcs8300-gp-mnd
+              - qcom,qcs615-gp-mnd
+          - const: qcom,sc7280-gp-mnd
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PDM XO4 source clock
+      - description: PDM AHB bus clock for register access
+
+  clock-names:
+    items:
+      - const: pdm_clk
+      - const: ahb_clk
+
+  '#clock-cells':
+    const: 0
+
+  assigned-clocks:
+    maxItems: 1
+    description: Parent clock phandle used to set the input frequency.
+
+  assigned-clock-rates:
+    maxItems: 1
+    description: |
+      Rate for the parent clock in Hz.
+      Supported rates: 19200000, 9600000, 6400000, 4800000.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - assigned-clocks
+  - assigned-clock-rates
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    gp_mn: clock-controller@88d3000 {
+        compatible = "qcom,sc7280-gp-mnd";
+        reg = <0x88d3000 0x1000>;
+        clocks = <&gcc GCC_PDM_XO4_CLK>,
+                 <&gcc GCC_PDM_AHB_CLK>;
+        clock-names = "pdm_clk", "ahb_clk";
+        pinctrl-0 = <&gp_mn_pin_active>;
+        pinctrl-names = "default";
+        assigned-clocks = <&gcc GCC_PDM_XO4_CLK>;
+        assigned-clock-rates = <4800000>;
+        #clock-cells = <0>;
+    };

-- 
2.34.1

