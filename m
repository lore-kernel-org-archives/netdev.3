Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884079;
	b=s6w6V/QlfE8EgmAedKRv9BIEaCZS+oYmrlvPlg+uwVcFp5c6qBy7Kblxwh0t6Y+aw0uD
	 9dTinTMcD0UB619ZNBnYyqrQqAugTgvMLz1sVBFM1hvP0+4c2GH8g1LhG+8V6FpnTFz6/
	 i5NEdqikIyjW31XvWAu+yE9zPNHhOcVVXC/R5ITBEdOwga1+QDOkFn/VPrCIc/dytVAAt
	 EdZ5EqF5FVi6xovgN0hKCc8MHIK68C16SCy8YNnzoBHDXA1ZqZ3xxHXb5uFub8dh6QFOb
	 5XHTNAJs/okARTHkwKU4r+w49fWJAlWvflQQ6z1YhhsJ2gSEGsw6ohufdecZYCsHWpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884079;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Bxy4cfAf042PiXXoQRywKNCGpgVupBVLw8AvprKIGyo=;
	b=iNwuL3O6KQ+jIPYI84MPOFhaa8u8xqhn2wGvb8YNTYg4138CIZ6ru2DBbrg/RGwI9Y2h
	 N+voVyXB5dLYfi7oyVggbUXbEwvG45dn4m1hjbAr+0LQAmAcPX4ymWZrUT3/DwFAP5zz2
	 lk02OJn8Sh3oy5mBD5So9wi+TubAGxjd0QSzJr5X70O7Eztu05Wn4MswogMQjhBi0h0gP
	 SB4mdc3YcKccaqbmlfZuc6s76qMetzrI6OqG7lfF1GtA+qFvxk/UzQr212G6YTjFwCYsN
	 NvEp3ugTLQk2zhw4hJuYl0qYioSlqH7av3cUnfdx5EseivlZp+CnvcFpK4H168ahgfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iWI9qNq1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bZ+zZ3BQ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF7606D804
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1CF7606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iWI9qNq1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bZ+zZ3BQ
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tHEq082977
	for <netdev@vger.kernel.org>; Thu, 5 Nov 2026 13:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bxy4cfAf042PiXXoQRywKNCGpgVupBVLw8AvprKIGyo=; b=iWI9qNq112thdf33
	0XDVH+gA9LeblzYLIjo0mSPHZFhVVVuc4SbxnERXyWgs3laqK/FLPlI9FNKKevMO
	z80lAFzy1sM0bAl2Z4HSAroLCbSAb29i/DHKFOZuBdRYapf2yxdN+WaQZtSXnfmc
	tU7bp6rgXV7lL6SPi5+1d3uEfXQ6EfKxkmxyc6AbwntXE10Gy3M1la1pD7nqzXiv
	W/OXUGr4kEyDoBbbr2nSD2ugUeO/BlJqXl6/vzkKiQQNcX6vaki6LVLk32MzjQ4e
	G77ODg0FeWryDXnHcgnbA1ppCa9pzyniUnOOTT6MSxvjpWOmVqx+94rtGDAuOktp
	sqGbeg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p0wsm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:07:57 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b2fd108b28so27754717b3.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793884077; x=1794488877; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bxy4cfAf042PiXXoQRywKNCGpgVupBVLw8AvprKIGyo=;
        b=bZ+zZ3BQ8kekoA04GN8iDJwkmEtuihQKu/1w57J5amMOqbVgSRQ54MqK7lD/AuabbY
         ARDqFUIhlOii5YNnnVRjFFLGwBjnsIAtTxAd9NpCHGmqF5TZMgfryukGXZ5KrEBQtPy3
         K5KhaUeogLVCoZl68ZYqBkQB/u2mZNIPBj4s5j3bgGfyJ0y+aQl8MBXJDtEY8cB6thXq
         zVPX4g/za1Xve9dacUQyNXFn4ZXRkKnbcyJerXvOMamjbMI+eDXVj1G+twdVwTl7zSmZ
         kQL3m8k7L7BE5tHKzgFvvPVDkzWLBFNXrwvHvXOxcWuejyxDtISlTfixXohZigyIDO74
         TAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884077; x=1794488877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bxy4cfAf042PiXXoQRywKNCGpgVupBVLw8AvprKIGyo=;
        b=vjHihovJV6yVPCKmWM4I2gASGnn7+tsPauwctAFO4+sK9ngHskoWZW7Lf14VZk95Vd
         io/Gzq9uobX7FeGe8KikuhtMjPsv8qLlNsiCDuDw4aKfAEdxAc0EVonl4z7tRqkGVhJJ
         TaAvuQoNaX+XwisQmv2ww7HALX2XgNKctHrDgflUlLj0Rjo6+9ShsnQSgTEbrrMXnxVP
         dojvlLB/Qmr1K3FmPXttB3EXBC21Lm9mQsnOef1/96XETZcyJZRUCZ+fHVjk3+2z+PnM
         0YI/3T3z/aP9njwYB1nfZixQeN0Sh3D7A4F2W0OOk+u3vih+PAREYbKPMv2uQkcGjR8Y
         LuwA==
X-Forwarded-Encrypted: i=1; AKwUvBxSL6Byjc95L/xb2fxA7cA9OIloxU3WYjX45CZ5OKIxUvHc1TC7pMzGNJTUSP4eFDedRHs+Fsc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nXBIr52611wfANOdXCJUuqbMkI32f+V7kdWkh5pj9dfwYy+OW
	4RhAPQAuFSwDNZwDawS0qz8O4uda9rCzxIdjbhPYhQhyuAnBYB9uqA0gEJWGMUpCBUkbqtpso9D
	7nuxIRfD09jaZkWpX0tG8pNo2z5YPLrlDp8j9d8pQUkgTwTNWI5YRq7fexpg=
X-Gm-Gg: AYBFou1KJ0NEkfU0VW0iMHdxbcuG0r7Zot4MW/7K9casM3SWfuMquSrz9t+7kNmb2Ki
	v7GlzUAyJ52oKoVm4Dn/8P4KPr6oMODc3gPdp7V2/6GHJ3U7XGtjcg/Jg29FH6kIF1iDgPJ4eEO
	tvU8poWc1hAoGgwGNg0HD4oqauGNLB/VysQcbhDEpssVY9nmRRhMQZrZZeZjDz5tBFdqxcFnZ0t
	SbkJgdfbJMO/f7LZ1eWNT6MF40BsMmFinlI5IJpdiGRfw+iL+/cZW3If0Qt/Svb4Z82N5x8CQJ5
	pveBy3Kjdar+UPNxS4bLulydH9D6tN7Vefif3GSku9GaEg8c5VgY79Ayz88AzNtAg3aVeuPH9tJ
	6GpSuiuRBT427BO84CU01pMEKj9aFq3UU994AtOoSM9to8TjYg1pIpaRNw7N43JO9jU5Hsy188i
	Js+JX83s5cKbec7Jsw
X-Received: by 2002:a05:690c:c510:b0:8b3:2870:3231 with SMTP id 00721157ae682-8b328703cd1mr16269877b3.95.1793884077032;
        Thu, 05 Nov 2026 05:07:57 -0800 (PST)
X-Received: by 2002:a05:690c:c510:b0:8b3:2870:3231 with SMTP id 00721157ae682-8b328703cd1mr16268357b3.95.1793884071062;
        Thu, 05 Nov 2026 05:07:51 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bb4406sm38915937b3.40.2026.11.05.05.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:07:50 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 05:07:12 -0800
Subject: [PATCH 1/5] dt-bindings: clock: qcom: Add NSS clock controller for
 IPQ5210 SoC
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
Message-Id: <20261105-qcom_ipq5210_nsscc-v1-1-d4fcb5c32b51@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884066; l=12138;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=OHhmxjAaFrk/KrSfVg+GuvTHorpv3eRxfNre0pIomoQ=;
 b=39vtdtAAl6Wi7EkyISXKlqYqt0K9FLtLEFarSVPATywIMsSs9jBns0kU2KjNHJgSX7j46UR9A
 1jCWBkhmOjOC7Dv9HxfAUA2VJLNqq/dyhiJrAej/jLacirJwtjTB4rY
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aec7fad cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=U5FYPQ0ST96qNyfkX9wA:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX4iAuNySSJvca
 /LA9iwfzjAUfku8mwOmqm0O5zwnNDNKLc+ogiNKO2xl8g31DjjQn1DsLtRL8oK+5xU2Yyp8zMKL
 YHzBobtZGvpMv0Q2jhRHrPmVP4oPcZ+y3LruseAp/lvdcW82oYmeQow4TGUeXtoaiYVXB3cQdVu
 t87a07vuzvJlJ7VWVHO5qXw8F/1wFMrDpEXG+XB1P6K6VOeOZaSTd79zdq1p9HWFBD0xXfhmNAI
 8LvgB2Lpruq98jLvDzkFWM205YWZjhY+V4R8xbBFJGxjAh70ht2WBOI9GncIWkx8/RtqFOpbBnA
 ElHQqoV6jaUQ0FDkKvRNtYe41ve/FTaX0/vqikpyRI7T87X+99dK716J/2ja/lt97DaCFFGDWk3
 bE2+JJJpVWaItA83oDRdSl1LW9ymocvVv93KT1tNmR5WZ3Y9einaQIOCTlT3izzAPAtzZSrNufv
 ufMeN1RQqDlDIXwc2uQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX3KwQUQAtKTTk
 1Am0kRfyptvFlgebwQiWrOXgxVgvBRB/FuUmjaQS7J9onV4F3RyB4fRyrnGnHyb9r9eiJb0fiTz
 4mw2J7jp01cA5CbMCq/oT4zBXydwaX0=
X-Proofpoint-ORIG-GUID: elLwcVf9HM-SiCxAqdxoq8p8OKLqDRTN
X-Proofpoint-GUID: elLwcVf9HM-SiCxAqdxoq8p8OKLqDRTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050052

NSS clock controller provides the clocks and resets to the networking
blocks such as PPE (Packet Process Engine), UNIPHY (PCS) and EPHY on
IPQ5210 devices.

Add support for the compatible string "qcom,ipq5210-nsscc" based on the
existing IPQ9574/IPQ5424 NSS clock controller Device Tree binding. IPQ5210
additionally exposes a pair of EPHY-RAW Rx/Tx clock sources used to derive
the clocks for its integrated 2.5G Ethernet PHY, so extend the clocks and
clock-names lists with "ephy_rx" and "ephy_tx".

Also add master/slave ids for IPQ5210 networking interfaces, which are used
by the nsscc-ipq5210 driver for providing interconnect services using the
icc-clk framework.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 .../bindings/clock/qcom,ipq9574-nsscc.yaml         |  47 ++++++++-
 include/dt-bindings/clock/qcom,ipq5210-nsscc.h     | 106 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,ipq5210.h    |  18 ++++
 include/dt-bindings/reset/qcom,ipq5210-nsscc.h     |  60 ++++++++++++
 4 files changed, 228 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
index a35bbc7b1924..dc7d90a99dc7 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
@@ -4,24 +4,28 @@
 $id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574 and IPQ5424
+title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ SoCs
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
+  - Luo Jie <jie.luo@oss.qualcomm.com>
 
 description: |
   Qualcomm networking sub system clock control module provides the clocks,
-  resets on IPQ9574 and IPQ5424
+  resets on IPQ9574, IPQ5424 and IPQ5210
 
   See also:
+    include/dt-bindings/clock/qcom,ipq5210-nsscc.h
     include/dt-bindings/clock/qcom,ipq5424-nsscc.h
     include/dt-bindings/clock/qcom,ipq9574-nsscc.h
+    include/dt-bindings/reset/qcom,ipq5210-nsscc.h
     include/dt-bindings/reset/qcom,ipq5424-nsscc.h
     include/dt-bindings/reset/qcom,ipq9574-nsscc.h
 
 properties:
   compatible:
     enum:
+      - qcom,ipq5210-nsscc
       - qcom,ipq5424-nsscc
       - qcom,ipq9574-nsscc
 
@@ -42,6 +46,9 @@ properties:
       - description: Uniphy2 NSS Rx clock source
       - description: Uniphy2 NSS Tx clock source
       - description: GCC NSSCC clock source
+      - description: CMN_PLL EPHY-RAW Rx clock source
+      - description: CMN_PLL EPHY-RAW Tx clock source
+    minItems: 11
 
   '#interconnect-cells':
     const: 1
@@ -63,6 +70,9 @@ properties:
       - const: uniphy2_rx
       - const: uniphy2_tx
       - const: bus
+      - const: ephy_rx
+      - const: ephy_tx
+    minItems: 11
 
 required:
   - compatible
@@ -77,6 +87,8 @@ allOf:
           const: qcom,ipq9574-nsscc
     then:
       properties:
+        clocks:
+          maxItems: 11
         clock-names:
           items:
             - const: xo
@@ -90,8 +102,35 @@ allOf:
             - const: uniphy2_rx
             - const: uniphy2_tx
             - const: bus
-    else:
+  - if:
+      properties:
+        compatible:
+          const: qcom,ipq5424-nsscc
+    then:
+      properties:
+        clocks:
+          maxItems: 11
+        clock-names:
+          items:
+            - const: xo
+            - const: nss
+            - const: ppe
+            - const: gpll0_out
+            - const: uniphy0_rx
+            - const: uniphy0_tx
+            - const: uniphy1_rx
+            - const: uniphy1_tx
+            - const: uniphy2_rx
+            - const: uniphy2_tx
+            - const: bus
+  - if:
+      properties:
+        compatible:
+          const: qcom,ipq5210-nsscc
+    then:
       properties:
+        clocks:
+          minItems: 13
         clock-names:
           items:
             - const: xo
@@ -105,6 +144,8 @@ allOf:
             - const: uniphy2_rx
             - const: uniphy2_tx
             - const: bus
+            - const: ephy_rx
+            - const: ephy_tx
 
 unevaluatedProperties: false
 
diff --git a/include/dt-bindings/clock/qcom,ipq5210-nsscc.h b/include/dt-bindings/clock/qcom,ipq5210-nsscc.h
new file mode 100644
index 000000000000..62ead8d9b076
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,ipq5210-nsscc.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_QCOM_IPQ5210_NSSCC_H
+#define _DT_BINDINGS_CLOCK_QCOM_IPQ5210_NSSCC_H
+
+#define NSS_CC_PPE_CLK_SRC			0
+#define NSS_CC_PPE_SWITCH_IPE_CLK		1
+#define NSS_CC_PPE_SWITCH_BTQ_CLK		2
+#define NSS_CC_PPE_SWITCH_CLK			3
+#define NSS_CC_PPE_SWITCH_CFG_CLK		4
+#define NSS_CC_PPE_EDMA_CLK			5
+#define NSS_CC_PPE_EDMA_CFG_CLK			6
+#define NSS_CC_PORT1_MAC_CLK			7
+#define NSS_CC_PORT1_RX_CLK			8
+#define NSS_CC_PORT1_RX_CLK_SRC			9
+#define NSS_CC_PORT1_RX_DIV_CLK_SRC		10
+#define NSS_CC_PORT1_TX_CLK			11
+#define NSS_CC_PORT1_TX_CLK_SRC			12
+#define NSS_CC_PORT1_TX_DIV_CLK_SRC		13
+#define NSS_CC_PORT2_MAC_CLK			14
+#define NSS_CC_PORT2_RX_CLK			15
+#define NSS_CC_PORT2_RX_CLK_SRC			16
+#define NSS_CC_PORT2_RX_DIV_CLK_SRC		17
+#define NSS_CC_PORT2_TX_CLK			18
+#define NSS_CC_PORT2_TX_CLK_SRC			19
+#define NSS_CC_PORT2_TX_DIV_CLK_SRC		20
+#define NSS_CC_PORT3_MAC_CLK			21
+#define NSS_CC_PORT3_RX_CLK			22
+#define NSS_CC_PORT3_RX_CLK_SRC			23
+#define NSS_CC_PORT3_RX_DIV_CLK_SRC		24
+#define NSS_CC_PORT3_TX_CLK			25
+#define NSS_CC_PORT3_TX_CLK_SRC			26
+#define NSS_CC_PORT3_TX_DIV_CLK_SRC		27
+#define NSS_CC_PORT4_MAC_CLK			28
+#define NSS_CC_PORT4_RX_CLK			29
+#define NSS_CC_PORT4_RX_CLK_SRC			30
+#define NSS_CC_PORT4_RX_DIV_CLK_SRC		31
+#define NSS_CC_PORT4_TX_CLK			32
+#define NSS_CC_PORT4_TX_CLK_SRC			33
+#define NSS_CC_PORT4_TX_DIV_CLK_SRC		34
+#define NSS_CC_PORT5_MAC_CLK			35
+#define NSS_CC_PORT5_RX_CLK			36
+#define NSS_CC_PORT5_RX_CLK_SRC			37
+#define NSS_CC_PORT5_RX_DIV_CLK_SRC		38
+#define NSS_CC_PORT5_TX_CLK			39
+#define NSS_CC_PORT5_TX_CLK_SRC			40
+#define NSS_CC_PORT5_TX_DIV_CLK_SRC		41
+#define NSS_CC_PORT6_MAC_CLK			42
+#define NSS_CC_PORT6_RX_CLK			43
+#define NSS_CC_PORT6_RX_CLK_SRC			44
+#define NSS_CC_PORT6_RX_DIV_CLK_SRC		45
+#define NSS_CC_PORT6_TX_CLK			46
+#define NSS_CC_PORT6_TX_CLK_SRC			47
+#define NSS_CC_PORT6_TX_DIV_CLK_SRC		48
+#define NSS_CC_NSSNOC_PPE_CLK			49
+#define NSS_CC_NSSNOC_PPE_CFG_CLK		50
+#define NSS_CC_UNIPHY_PORT1_RX_CLK		51
+#define NSS_CC_UNIPHY_PORT1_TX_CLK		52
+#define NSS_CC_UNIPHY_PORT2_RX_CLK		53
+#define NSS_CC_UNIPHY_PORT2_TX_CLK		54
+#define NSS_CC_UNIPHY_PORT3_RX_CLK		55
+#define NSS_CC_UNIPHY_PORT3_TX_CLK		56
+#define NSS_CC_UNIPHY_PORT4_RX_CLK		57
+#define NSS_CC_UNIPHY_PORT4_TX_CLK		58
+#define NSS_CC_UNIPHY_PORT5_RX_CLK		59
+#define NSS_CC_UNIPHY_PORT5_TX_CLK		60
+#define NSS_CC_UNIPHY_PORT6_RX_CLK		61
+#define NSS_CC_UNIPHY_PORT6_TX_CLK		62
+#define NSS_CC_XGMAC0_PTP_REF_CLK		63
+#define NSS_CC_XGMAC0_PTP_REF_DIV_CLK_SRC	64
+#define NSS_CC_XGMAC1_PTP_REF_CLK		65
+#define NSS_CC_XGMAC1_PTP_REF_DIV_CLK_SRC	66
+#define NSS_CC_XGMAC2_PTP_REF_CLK		67
+#define NSS_CC_XGMAC2_PTP_REF_DIV_CLK_SRC	68
+#define NSS_CC_PON_CLK				69
+#define NSS_CC_EPHY_RX_CLK_SRC			70
+#define NSS_CC_EPHY_RX_CLK			71
+#define NSS_CC_EPHY_TX_CLK_SRC			72
+#define NSS_CC_EPHY_TX_CLK			73
+#define NSS_CC_UNIPHY_PORT1_RX_DIV4_CLK_SRC	74
+#define NSS_CC_UNIPHY_PORT1_TX_DIV4_CLK_SRC	75
+#define NSS_CC_UNIPHY_PORT2_RX_DIV4_CLK_SRC	76
+#define NSS_CC_UNIPHY_PORT2_TX_DIV4_CLK_SRC	77
+#define NSS_CC_UNIPHY_PORT3_RX_DIV4_CLK_SRC	78
+#define NSS_CC_UNIPHY_PORT3_TX_DIV4_CLK_SRC	79
+#define NSS_CC_UNIPHY_PORT4_RX_DIV4_CLK_SRC	80
+#define NSS_CC_UNIPHY_PORT4_TX_DIV4_CLK_SRC	81
+#define NSS_CC_UNIPHY_PORT1_RX_DIV4_CLK		82
+#define NSS_CC_UNIPHY_PORT1_TX_DIV4_CLK		83
+#define NSS_CC_UNIPHY_PORT2_RX_DIV4_CLK		84
+#define NSS_CC_UNIPHY_PORT2_TX_DIV4_CLK		85
+#define NSS_CC_UNIPHY_PORT3_RX_DIV4_CLK		86
+#define NSS_CC_UNIPHY_PORT3_TX_DIV4_CLK		87
+#define NSS_CC_UNIPHY_PORT4_RX_DIV4_CLK		88
+#define NSS_CC_UNIPHY_PORT4_TX_DIV4_CLK		89
+#define NSS_CC_EIP_BFDCD_CLK_SRC		90
+#define NSS_CC_EIP_CLK				91
+#define NSS_CC_NSSNOC_EIP_CLK			92
+#define NSS_CC_CFG_CLK_SRC			93
+#define NSS_CC_NSS_CSR_CLK			94
+#define NSS_CC_NSSNOC_NSS_CSR_CLK		95
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,ipq5210.h b/include/dt-bindings/interconnect/qcom,ipq5210.h
new file mode 100644
index 000000000000..44f8d35a372a
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq5210.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef INTERCONNECT_QCOM_IPQ5210_H
+#define INTERCONNECT_QCOM_IPQ5210_H
+
+#define MASTER_NSSNOC_PPE		0
+#define SLAVE_NSSNOC_PPE		1
+#define MASTER_NSSNOC_PPE_CFG		2
+#define SLAVE_NSSNOC_PPE_CFG		3
+#define MASTER_NSSNOC_NSS_CSR		4
+#define SLAVE_NSSNOC_NSS_CSR		5
+#define MASTER_NSSNOC_EIP		6
+#define SLAVE_NSSNOC_EIP		7
+
+#endif /* INTERCONNECT_QCOM_IPQ5210_H */
diff --git a/include/dt-bindings/reset/qcom,ipq5210-nsscc.h b/include/dt-bindings/reset/qcom,ipq5210-nsscc.h
new file mode 100644
index 000000000000..0616a3623897
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,ipq5210-nsscc.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_RESET_QCOM_IPQ5210_NSSCC_H
+#define _DT_BINDINGS_RESET_QCOM_IPQ5210_NSSCC_H
+
+#define NSS_CC_PPE_BCR				0
+#define NSS_CC_PPE_SWITCH_IPE_CLK_ARES		1
+#define NSS_CC_PPE_SWITCH_BTQ_CLK_ARES		2
+#define NSS_CC_PPE_SWITCH_CLK_ARES		3
+#define NSS_CC_PPE_SWITCH_CFG_CLK_ARES		4
+#define NSS_CC_PPE_EDMA_CLK_ARES		5
+#define NSS_CC_PPE_EDMA_CFG_CLK_ARES		6
+#define NSS_CC_PORT1_MAC_CLK_ARES		7
+#define NSS_CC_PORT2_MAC_CLK_ARES		8
+#define NSS_CC_PORT3_MAC_CLK_ARES		9
+#define NSS_CC_PORT4_MAC_CLK_ARES		10
+#define NSS_CC_PORT5_MAC_CLK_ARES		11
+#define NSS_CC_PORT6_MAC_CLK_ARES		12
+#define NSS_CC_PON_CLK_ARES			13
+#define NSS_CC_XGMAC0_PTP_REF_CLK_ARES		14
+#define NSS_CC_XGMAC1_PTP_REF_CLK_ARES		15
+#define NSS_CC_XGMAC2_PTP_REF_CLK_ARES		16
+#define NSS_CC_NSSNOC_PPE_CLK_ARES		17
+#define NSS_CC_NSSNOC_PPE_CFG_CLK_ARES		18
+#define NSS_CC_PORT1_RX_CLK_ARES		19
+#define NSS_CC_PORT1_TX_CLK_ARES		20
+#define NSS_CC_PORT2_RX_CLK_ARES		21
+#define NSS_CC_PORT2_TX_CLK_ARES		22
+#define NSS_CC_PORT3_RX_CLK_ARES		23
+#define NSS_CC_PORT3_TX_CLK_ARES		24
+#define NSS_CC_PORT4_RX_CLK_ARES		25
+#define NSS_CC_PORT4_TX_CLK_ARES		26
+#define NSS_CC_PORT5_RX_CLK_ARES		27
+#define NSS_CC_PORT5_TX_CLK_ARES		28
+#define NSS_CC_PORT6_RX_CLK_ARES		29
+#define NSS_CC_PORT6_TX_CLK_ARES		30
+#define NSS_CC_EPHY_RX_CLK_ARES			31
+#define NSS_CC_EPHY_TX_CLK_ARES			32
+#define NSS_CC_UNIPHY_PORT1_RX_CLK_ARES		33
+#define NSS_CC_UNIPHY_PORT1_TX_CLK_ARES		34
+#define NSS_CC_UNIPHY_PORT2_RX_CLK_ARES		35
+#define NSS_CC_UNIPHY_PORT2_TX_CLK_ARES		36
+#define NSS_CC_UNIPHY_PORT3_RX_CLK_ARES		37
+#define NSS_CC_UNIPHY_PORT3_TX_CLK_ARES		38
+#define NSS_CC_UNIPHY_PORT4_RX_CLK_ARES		39
+#define NSS_CC_UNIPHY_PORT4_TX_CLK_ARES		40
+#define NSS_CC_UNIPHY_PORT5_RX_CLK_ARES		41
+#define NSS_CC_UNIPHY_PORT5_TX_CLK_ARES		42
+#define NSS_CC_UNIPHY_PORT6_RX_CLK_ARES		43
+#define NSS_CC_UNIPHY_PORT6_TX_CLK_ARES		44
+#define NSS_CC_EIP_CLK_ARES			45
+#define NSS_CC_NSSNOC_EIP_CLK_ARES		46
+#define NSS_CC_NSS_CSR_CLK_ARES			47
+#define NSS_CC_NSSNOC_NSS_CSR_CLK_ARES		48
+#define NSS_CC_DEBUG_CLK_ARES			49
+
+#endif

-- 
2.43.0

