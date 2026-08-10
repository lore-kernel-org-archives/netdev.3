Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D6304976
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786322574; cv=none; b=R5JtWxP1ARzZ8kAgT5MUCWr5n9j92U62biEFyCg5nE8g5Ata6kIjatHG50bNoND/M/WlmYr2aasfvhj9l5S4it88PWZs8OAWYFP+O09W3xbFQJSgZkrTRGrsU7pAU7NAKhxzUAXk3yJZ9eovNeKP1Mv7sdwp/rUfYSLQUYDKV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786322574; c=relaxed/simple;
	bh=7xxEO9iBqMmQrjs1cD1cY6/zkav8nUrrWhcmcweWbCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9K8K7ZpLHIgHpYDwbUZLyy8VjBsfM0TMH1P2yazx3VowEkQw+OIAh13+Ud3HldflpGU9hFiKXuRUKrN65PP92TLUEHXd8l+0Sw5/nAIEfsC3hqfE/9MkrcrMMSXCobdG3c9hSJ2tl6QnRaPAQTDJAsGDq155zjv9dgBiuKPkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mOIneIEx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NsPJwCpt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mOIneIEx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NsPJwCpt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679L716g4106377
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gm77B4g5P+NCS4VWYrUZVvsJNwJFQO7NHmxMjKiPJXI=; b=mOIneIExY8fWB6Ch
	y8PdQjkPcbrPh1O2YmIwHvKPg50p1jzAj13PhnHSUA/L2/sM+7kUtm13FmQBzfia
	f1hc1ybJsQf64WIihMGNatgK/MYdapjtW6LqoXy1z+zF9nWAykOUIV1qrX8UWA+W
	CA6L6B8z4DtJX0+2nm3DE3SYKjhy0LXeYt0Hw8JZJs6O7qNW1OSlFpNpgK5NJgB3
	0i0hWQ8z3iuj6zWyoFNyvvBfhM/OeeYg2z9J9nKRMFLUPbRoVvQpjHuoD15+M/nm
	y4l8A509IEWNWUkzP9H4zfNocKHlBXZotGHOKXuwzwGKKEgJfS9y2/xa2z3YQ3YH
	VflMuQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7bwgd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f0f45415cfso11370746d6.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 17:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786322571; x=1786927371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gm77B4g5P+NCS4VWYrUZVvsJNwJFQO7NHmxMjKiPJXI=;
        b=NsPJwCptjhyenFMiuUJdy9nlG75HJ1W/9mZpCy8oaUSxQAQdxkrabJZyMOG8/6TQHj
         HBM3dom/uuyt/u8NR5uYtms5XoZP53re5i2/0oIyNF2pq7zDNEwiYKosaImSyHpkePqN
         yj48xSdXVxnkPTcn/7tHJstuKLRSA7inZWiua9DcNy8YhnGsVX9zY5S9ecSxSaZ59tqF
         8jv30TIMkTdQVFUcrG40QiKHOKVgg1CqwxJBM9RVo6HFcoOQFK0lgUxaJmHrpkd+k4rR
         U6J9f547+kYU1VEAjFJ/I9LD8Wko3FuGRHpD9xE1ftUJ5eBiCZxwfW/11lRZS46pk/9D
         wqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786322571; x=1786927371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gm77B4g5P+NCS4VWYrUZVvsJNwJFQO7NHmxMjKiPJXI=;
        b=kIgg7Qrb2XZPi8hOsh0Ff5+SAduPVOaFkrQMMSXnkYzM6BKH4Prt0vXpjd/5XnFScZ
         vpsEPDJJq/pJjqmw7iBVThkfsf4rxgzZ6g9EdRQjkSE1JVaviLn83iciXvSmjkANSOVr
         HPsBmFfKhT0EmmaezlT3L/3EjyUoRMGA0/XGkTgMoEcJCee+jQIqpxjLjbESE82lM+2s
         C8fE4NG9YnnB6rT7m4AQgFCmEHhMtTEQdwoKrfjTQLIISqHHfbuWYqy/SfuVPkjXlTNr
         u9Ut7UtHV7w4VSYidohl+isLL03nz8i34xNPsrc0JFQ+2dUuVQeBDcrZ+XmiPPsQUcfM
         JBaw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0RHkoTA2Hwzs0zQAGFLdkfIvfWk/I2AGhq4vWKm0j/AIiCkwJ+cx/nphz/+tcQfsEHEfZa+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/m8252Rcp0Vj1lBEoD8xzJRm1ELcHhXYLC0FJyb/AQzNbL4R
	drNESzxQRj/7XGtbocIqRt7OT+MiH9xF3Ct7mHzel4G5fnpQslNF/ZR5MsMsnHlutdSXZ0PNMNU
	zarQ0X+N778RhFjUmSnz8HzXhUBEAj+MViTsG7XEqY6zlrFBhRT8xnsXsuYo=
X-Gm-Gg: AR+sD10utWx8AoJjFmuXyIFAqz557lowaPrdl/b5DLWlczOKCcePI5XRu7PPUdKSpKD
	5yv5oECyyRac2gy/1YNMawbEYylH0e0iYIHj5LR+hYx4ceiL134hSUJcyHiMCIHflHoA5PkCkQ8
	o4NvJPboXEn85g+VPnPj2s0H21yluahZ0rRuXq2nkYcOb+8SGYeoq4JJDwfdv6tlvXfJB6g76ow
	EYw4mv6YT5MzO/o2AiEVJuuCDk7CSeh2EoIRX9jOqaPIRCx4hCmK6Ni3l43zjvyTHgVij6B5/lU
	pF0jDQfWev4FLFjNYtqWAk5+/TxFtsaf+4uoFbgH251PFMvhhXy/VlFOt7JVO70pNwXQvkrMeo1
	z7noFAwERIMD4q3qNxo8B7QiYuTvhEz7qX2W/MdA6my81EEKPR6UZx5p6am/qJues7881H+oiWl
	qQkfSe2rP+T0JSIA==
X-Received: by 2002:a05:6214:540e:b0:8f2:4100:8613 with SMTP id 6a1803df08f44-90a343439damr205018846d6.0.1786322571092;
        Sun, 09 Aug 2026 17:42:51 -0700 (PDT)
X-Received: by 2002:a05:6214:540e:b0:8f2:4100:8613 with SMTP id 6a1803df08f44-90a343439damr205018556d6.0.1786322570694;
        Sun, 09 Aug 2026 17:42:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3d56sm1679742e87.69.2026.08.09.17.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 17:42:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 03:42:34 +0300
Subject: [PATCH 3/8] dt-bindings: usb: document the Prolific PL2775
 USB-SATA bridge
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-msm8974-onboard-usb-v1-3-08a805768328@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1969;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7xxEO9iBqMmQrjs1cD1cY6/zkav8nUrrWhcmcweWbCY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeR571JSJk2hyke7aAQqlgTqEQwipVpf+VATv2
 SZjs/USoBKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCankeewAKCRCLPIo+Aiko
 1aURB/sFK3YSPiJDdwwKQKfzmbyEcQlchSXjCPt8Ax7u3lcFw4Cgc/NABFjH+6dOCvXZ1CiuyNl
 1lXemRKaOO4fibenIVojQQOmT5L+2sp3uQ2qfClB017Yl3mxBcRsK48srIUN+Z2YvO4edJzuBZL
 IWVheDl0IB6XAJSQbsK4AhVUlk1a7k5jxoTm2cdma/91eJzV9TIoHuf5rBSh6nF3eZgGzn768s8
 ElVhL7nFU9O0X14mauZRKSfIHgUWtbE2Ai1bOBqYeVv23TikRMxRdpmLM2TrHsuNiueIMJHc8G4
 TkT4qSL6ScX1w+6OH+Vu/XTq7m80/iY/8x5Am6kbYf/W5BXt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX13J6kpUhma+q
 6xG/sSFSfdV6FwZn7Yb5wWZHG10xMF28nE9tqMno2hM0kySvFumGFsyurKa0EvDHrHqubgASjBd
 M3R5NnebimFyYPAOy3TiCoLkeudGTnI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX6v8LD+AV003o
 /SDdfN479rfA7SskeK0ynbZTY95TPKWwQf9kJKUwgsDY8fute4YyJ775j7dYhPPx8awLihRO8ZP
 lBArCt2o8wqTNI5qW4RNw/HSBfp2Kda89SKP0yoz88/hLCiB5IL/k2dKVW5N00DXz6mI+FZDITn
 ZtZ6+j5kVzSn624iDDoCRzhgTSYX5QPAdDgME5s2m9fQU2X7t5jJYjq6EOl43mJjCtEvk6Jvvff
 2cyR6HoAZmKysLiCthBajvgNqOZK9m/nE8A5rVPHdUhYOm3TaPtvVDiHab37H0Yr8RiT12GPkFv
 tOg5TzEYqtAV0bCATohu/Bt52gsv8cwdI36kCcxJPDgugf1r3EEPkCsW2m+7J+H2svjH2Nn3Nr8
 up+hUx5+o8ouvcJM8dhnfooFLwgZr8l0Jdnm9kJFaS8sFrXGe5RKe+pUrBO7YrvzmlgYke49Ct0
 3gZrfNv17Z/YHKmYllw==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a791e8b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=XqfhFsZh2exzjFNJnAMA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: GnnCFHmzgJmbRG-FriufYURNRAk8F8sR
X-Proofpoint-GUID: GnnCFHmzgJmbRG-FriufYURNRAk8F8sR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100003

The APQ8074 Dragonboard has an onboard Prolific PL2775 USB 3.0 to SATA
bridge whose RESET_N pin is wired to a PMIC GPIO, so the device has to
be described in DT for the OS to release it from reset.

Add a schema for the hard-wired PL2775 (067b:2775) with the
reset-gpios and vdd-supply properties used by onboard USB devices.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/usb/prolific,pl2775.yaml   | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/prolific,pl2775.yaml b/Documentation/devicetree/bindings/usb/prolific,pl2775.yaml
new file mode 100644
index 000000000000..5af8b4f5ee64
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/prolific,pl2775.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/prolific,pl2775.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Prolific PL2775 USB 3.0 to SATA bridge
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+
+description:
+  Device tree properties for hard wired Prolific PL2775 USB 3.0 to
+  SATA bridge controllers.
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    const: usb67b,2775
+
+  reg: true
+
+  reset-gpios:
+    description: GPIO connected to the RESET_N pin.
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply of the controller.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        device@1 {
+            compatible = "usb67b,2775";
+            reg = <1>;
+            reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+        };
+    };

-- 
2.47.3

