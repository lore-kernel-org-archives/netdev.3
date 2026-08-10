Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85232DEA68
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786322567; cv=none; b=LhUB4dKlwx6d+OuMMg35kO5m1XzHQRZBdOOTD4Ov5hvGLQSsCIC+FbgBnikFwFCfoQfULO6DoADZb0nJ/Kd6JVtQQD7rHGECOSXLN527R8wOf60wvTNA0SZ6OHSrOhXozo1wSOO6VHPGreAcfasc5C/kLxoJaB5Kie+CnrhILFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786322567; c=relaxed/simple;
	bh=XH9q/y6n0YYgQgp/Q2mx0eNIcicMKwlLjlTfyiTRa34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Emd52w7akq6mE26sWk+rHBMNzBv2FUnHvHL81C9KRw+Fp6VYXggBgqvWel6Z3v7eCKYrXm2/2858XC9Qw4hHyHKqZMFP49F6JNtP+p4fE+zQ+KZyw2nbQDWSTPWPnu9/zqD1iUHhYpLPc0sl7UwtDcJP1U0ajaCX/1qvGpvWlsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMc3I/Mr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ix9CCDWh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMc3I/Mr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ix9CCDWh"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679L6uSa3778355
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2MkeqS8Xm/u/rmFehJE2DuhmOxprgWDkQayQ76BCyLE=; b=DMc3I/Mrrfzi5E4b
	LzFUvxKFSkKRTcn0834s6ayo7B4Lws7E6OYu6xttyd4NJdHzc9mEw0yRV6Wi/jZ5
	Qn5lVhATbnPuI2JtG+tpnq+TmPdh8DeyRZV9lMJz7VuRflaun3FU4G7OFwmu8f3c
	UeKLJfKMlbXSKwI9uwjDDVWOSEfOWDEvoA9TMQOhpW15sBBH82qUvXw+gfucg1RC
	ZDkukMCLiAXWJC1bJ81KSwZZEQ/tw/HhkzIQPAjtWJqxgWjcUU1fugskSeINHBgS
	Qk5a8RBDDNXut4vWQS4P2j0HqlXOQbtKliwb2rAn0jKQQEOaPzq+KAJ7mgqpMd05
	YfM48g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvhvbt9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21c01cf3so25725701cf.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 17:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786322564; x=1786927364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2MkeqS8Xm/u/rmFehJE2DuhmOxprgWDkQayQ76BCyLE=;
        b=Ix9CCDWhXuOhpImCXvdJes26lSRpOkozTtpNUcBTGdLD9GEi/+LIXVvicDQHDV+Sx2
         OJx/cnIUT9mlVzzwUMv2JJozIaMXOoVS2AO3cnXHIxaOTcJWRCm2QimpK+vP1r/6lXDl
         EDqfD1+Rf5bC6LnYEa86ODjryfhd/Ysw1HtxJFsecRDPP4U7UC+xzkp5gD8zh+T0YjNI
         /aMiDmTnn3es1n4pkE4D14bOQi1tya8t1NmMKJ6DXAhhMZBQYE3L02oj38sMZ8O35mcw
         hINq2QLux/mDgQC92RrRGpROc18DKX3835fP9Ehc9LUxorTS2uP7SKn3byVKv3lPAQAZ
         HenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786322564; x=1786927364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2MkeqS8Xm/u/rmFehJE2DuhmOxprgWDkQayQ76BCyLE=;
        b=pPMzbh+/jNRN7lsDxVp100RglQVLFaHnEIUfjhsZvAKy1XhdtqFQDhRTbOeG3ZQ9Yz
         o2mCuSA0Ua4zcxKKCmu1EDdmSkpi0eNecXaphYRM1THgLudraCDNs5RfG/4GfYly6V9T
         qYu0VpnyJHL29hlRe7MBxzL1ini0DkrkJmU7/6vHwtpZTfvgLCxwDqXaoOq41Yf68Ibz
         8MGNKgQcL1ecy/Y6Yj6ZORcol/Vtuv39AkYQQ95aXLKJzy/tKidKmqaqsE+FrtVUCI2P
         cJMHsT9sp9mj6BSqkCTe5/qU2EuS2z1i9nJN6v7IqULwijUE7zJU/lITWu+NvmivQaqW
         +ZAA==
X-Forwarded-Encrypted: i=1; AHgh+Rq/A6kQH+XYULTU9Qe3oATQoHVINwnQGBfHYvgG5koDDjn+jYXcN0+zF1P2qQEZFuo5Hr8SHXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7B2qJayNdsJjvI/Gc3AbzmsNewWgq5Iv5NWSEauFrw/R+XEji
	x1vrylGNizzxX1AdB2t3iys9hvkmwVnUfG0NNftEI/mXmq2d/650KD3ouV6ykK13Urlnc7jVwio
	lQuRjsZ5woZa/+IGRKjId6mMbg4QYedGTVaThA3iASDrhlY7kh/a78YlFISA=
X-Gm-Gg: AR+sD13l6P34H/8cbcyDFeZcearHUoVmXrKg4uHFPtepiucoTBLMrI2QXML8eyyhmIW
	2mp3RLzghUsNQh22a5HiKzkqrqaIHlNc9BUVel0HOuQUIkkGOlZqRBxF4ByTItFwByNaQ5udQ3Y
	sBmI3i1v/B7JqNKiNoaoVbfpq47YXsxXYm++mcUCb3NcOAGkSOAmLSoKGHYPTOdnnyM4ZJSl6Qs
	2ulxzPrrduvC1VfxuvU5XFkyawnq/IX9YfrixLZdwXoWoJcg2/ZpV42V6XBn2WtnBPUGCuJu+MD
	ShNYJZ7tZXlg49Cg2pSK7kt7XRgpT5K8xHnrwUHc+a0dYGgbApGTVRggJa7yVhBz3TFojmySmGs
	3/Xk8gcHe8Q5EivXMyyBJLvEv6ESdfo/DQXGuA6CLp+gQqntrn9AOPdK+QVTsRp69DENTa2lm8/
	cawR/pIcHEza4Vrg==
X-Received: by 2002:a05:622a:64b:b0:51a:329:e802 with SMTP id d75a77b69052e-52d0b29a339mr256082661cf.41.1786322564146;
        Sun, 09 Aug 2026 17:42:44 -0700 (PDT)
X-Received: by 2002:a05:622a:64b:b0:51a:329:e802 with SMTP id d75a77b69052e-52d0b29a339mr256082281cf.41.1786322563756;
        Sun, 09 Aug 2026 17:42:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3d56sm1679742e87.69.2026.08.09.17.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 17:42:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 03:42:32 +0300
Subject: [PATCH 1/8] dt-bindings: usb: ti,usb8041: document the TUSB8040A
 hub
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-msm8974-onboard-usb-v1-1-08a805768328@oss.qualcomm.com>
References: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
In-Reply-To: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=XH9q/y6n0YYgQgp/Q2mx0eNIcicMKwlLjlTfyiTRa34=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1alXPWLGz5vl9U+WrOVn3VPMXPVIjmhexsP+q7mzdwty
 lwgNnlWJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmsv4cB8OCgC+/8r8HCt0W
 cO6K272jM7S9o8FhlsjKLGc+y3aRWU+X7OhoaNvusP2GhW3z+zdu7XIrZ2Rfq07ztjM98Ll8sYP
 yAWs9HufNwht/6qnklNzga9DpfbwkIvO7ay7zuZLJlXO593wKTbA8xvtt/k+RhYn+118d3bi+ec
 IR0xeyczX36/v8WjQ/XzRV/vu9HZlXZBdKvWIvb9aKDGneV9zJLCphb7fdpJPvnbZF9teVvVHzR
 d5e9i3ne2JgpvxNpyZl6sfpIc6WbacvCt6xMnJI4Ite2lYl/cavXW3H2oUGoRGqTTfZZGI6a/LV
 vQPOZfoyB0bvOGb6kLew02F9svWldf6uiyrPbM7JfvwcAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=eqbvCIpX c=1 sm=1 tr=0 ts=6a791e84 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=8f9FM25-AAAA:8 a=e_ZJ_HNLQjvR_73SufcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=sptkURWiP4Gy88Gu7hUp:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-ORIG-GUID: zpfSjipAkjcX0v_uf9odIf4KPdbSMdeV
X-Proofpoint-GUID: zpfSjipAkjcX0v_uf9odIf4KPdbSMdeV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfXwpvuDjxhbrZp
 UvKQ/E6IvL+tne8OiZs4f7/kj2pvH0pQGfOEdUXJIkmNjEH7j4yH1PkPyDCMiMedT0FWxwY2gao
 TYbIJoYl4KFtXu0tGNX5jvgyKVKdC+Ws4yGb7WqlCk1xlRmlEj2r5cZnbU+XNO9hu/9xsfClPjN
 UE4/zccSVAAJCRBCGDA5h4FYpR9tYoHPqSGRelnRIzv0V7L3yVLbHXt/938x7Pv+m9ffpjlmvle
 2nVmJxEoYgaHGYD9Js2kAKJX26PbJTrIFViQvQYJlGciyCcGCPgZcD76bO0O82BJg8sj4cuImm9
 ndRf2HedG9/V3Xm4dqPKNCBmtcQBGKIiHZa+YANaOkeD4o9n0I1fbviFDmJU6lAAxKAtoAWii2M
 aBX6ub6hPSHyml4eSJQ931oKjx9LeJwm1DTx4SE7/FREi2SMIgqw57GErOhWAEt0xB2vUV4SiUR
 AeAnFluddpJYdtyU2Yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX1uMtczpx0gR7
 i4xhKxodFBi0eRn6rI43CiE/IqpPKAUhD5o6IxFlTK9nPix/SW3jAtYLMd9QP0fhlDX7rHCjfkF
 3ofxouGXoGCKNg8Xr12ljTCpJCM5rT8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100003

The TI TUSB8040A four-port USB 3.0 hub is not documented, so onboard
device nodes for it cannot be validated.

Document it next to its TUSB8041 sibling: the same reset-gpios/peer-hub
properties apply. Besides the datasheet default 0451:8040 / 0451:8042
IDs, also document 0451:8041 / 0451:8043: the configuration EEPROM can
override the product IDs, and e.g. the APQ8074 Dragonboard programs
these values, as seen when booting the vendor image.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/usb/ti,usb8041.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,usb8041.yaml b/Documentation/devicetree/bindings/usb/ti,usb8041.yaml
index 07e13fae640b..a7ce487090a2 100644
--- a/Documentation/devicetree/bindings/usb/ti,usb8041.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,usb8041.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/usb/ti,usb8041.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TI USB8041 and USB8044 USB 3.0 hub controllers
+title: TI TUSB8040A, USB8041 and USB8044 USB 3.0 hub controllers
 
 maintainers:
   - Alexander Stein <alexander.stein@ew.tq-group.com>
@@ -16,6 +16,10 @@ allOf:
 properties:
   compatible:
     enum:
+      - usb451,8040
+      - usb451,8041
+      - usb451,8042
+      - usb451,8043
       - usb451,8140
       - usb451,8142
       - usb451,8440

-- 
2.47.3

