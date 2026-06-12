Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD43F4110
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270469; cv=none; b=dcAQQykM1QQet6pE+joHUZOSEEchE/uaojvH0eU5xNaKUWIwew7iTa9hTT508hud5tZVTEMw0Owd7X0yLJfUB4FeG/7wJsgnxO0ilsBo5ZZr5z00BE94OKTzrNQTb9BrDuRv5vtxugIyMMb1OOc0E/dlm9iDHm140dftz0WNjUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270469; c=relaxed/simple;
	bh=X0Ai0achBf+ZwxyXQCLBkT4mksbIzc1fznSydl00GqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qi9D/Q5IQ0MnRGjpkIh9Z8RlDfGuJebWvQNJAuvfvH7gF6uMmlXQ5i44qxHnZ/jy71QkwbcSAro5/8R+HkXCKCwjmESCArAUJ76GAqdxmvdhd5SBNQ3bRbQG70nkrynfD95jGIZShpYfR2u9UEstSmTWthZMkNKEMYyCTHFUCTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ewQgfnCL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P9Xl72Qz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ewQgfnCL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P9Xl72Qz"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCjHwA3631067
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=; b=ewQgfnCLI68ej6Qo
	9OvW3Hi1cjrVzZolpkfEcfXgnbQl6gVVUQe/0Yp0LuwgvD0Qsc5IdUDcrmpsOF7V
	Z/vHzjH/RTaUpBynaPr3gFnmOdDpnUNPNDzQPhYR+o99ADjRTwBodu9jeRTtmWvz
	te2fZaZFzkN4i1pVF6a9pk9+tSgxqW+YMd+WkNoL7CrS0KCHdRVFHbfvKF7kvEZi
	wgOgDbXctH61qgfVv8uE9WrR9AZtA6dq0Dc9JuSq3QgoIBeREWczdf+29NpOtvH/
	dZPxZfyuZezJJmJ7EZ7SwhXPEK3ThzjcIIOlzKvyJhxy9QkoLOOJ1VYlLWUX/Yrz
	NCLHdQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er165bfch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:21:07 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-69da2d033c9so1014155eaf.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270466; x=1781875266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=P9Xl72QzhYLQXH/GBjYt6pTxXaZxUAwgL5u7OR3qDUVugoEEJtZftcymlbbYBGp/cE
         po5pwnoP9UU3t/Pq2SD679RUS5fifmLbihW06h7c72WZF1vKC04YXaQzNuB0oQkb1ReP
         y/AE8ZKaEYUx7Ns/ZAg67tHRAsP1BpN8c148s1F4iQC4rlNInUuYRQfjTSezvaKy2UqC
         k3j/kgDoAgcxhKLAJ4XVdlO51caiRh/AfVz4+P3PGenuM0/3Iv9+BTRB23XIq9X0m9TN
         vj3U1Y5//t8nGLTuTTx2yeQLLX3HOwteqBpKqkJOKFPOvlUoWZEPQb14J46uXbnZM8AE
         Thhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270466; x=1781875266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=Qn9WJKorRAGgNZDkeVizlXCxj08hfZEg62V12isLZFh3xDHnaJ/yC9LV32Bq0e4kyG
         gzhZ2XYcTKpmPakskezh5R0ZcACmX4HCGGili/nQzMBtCRdLt5LVnadQXKIvzy3i2Bq+
         0L2pxeQ9CkMfmjlz7oGyqr0XM0gsIR29tt52Facpbzj4bJv7CaGs7Bu36sr+78LvrWRs
         3ZTBUtyONSRPAbCC+PDtQA2tzGwtvNbiYctEq7wpk5SorKAl5ZaL9Qg8fZ0KcYjJMDBg
         54P6WDdvce1B4nyP77vSz4wY4fHXsH9K9SCG5VENJtQMJzxB0PIGTDVVTqQOhDIcqGzW
         IL0w==
X-Forwarded-Encrypted: i=1; AFNElJ+U+p0BDz681pMNlofwmDLaaeStrYmr6D0ocGJrRWskdZrxOxGoxmoi/2d2/i0kPyeg/PGLjAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyykCxzgQqBm0Q0r48dQSoIRPYmeyIIlUbARl3HeWKNyBcJFJjE
	COIsT3VT9l6/iOJzR/ZLBBSqYiyqjBbLxF4ENw+nn+txU3vRMoVLcpSF+md0Y4Gm8Yf+uNkj7L0
	Lkd6EcZqCn8zgDd6RubBblrM7nnAF+GfKqqgiBghSoSLgdY9WTY+AZciRaVY=
X-Gm-Gg: Acq92OF7d+bjv+zPtPBD3burl4ToYEAr6sokj7EiA8XZFGtyKm/Zi2X0LzHn0Aq+jjv
	7ycARzsZR02Y3WJR6SCt+vfwZG5+SJ9C2Kn1ebe/DDcha8r1QhOdI1vSaxF9Igvf3e64Fh9H5Kc
	9Egb42WANcL6yyn1vNrX3SdPS0AocEGJOHzUw01XS8yzGaiPa/MUPKQVo00kVhntgFS3TDyKzFe
	1VyhNww7ZGx+huEPE0zjHlLZLxbL2lfYU0uGCV9txwJTCnEYAU+MDa5N/Ce+GTKPUpNH47KevpZ
	ZaoKyZ2IUBwnC0hqLVrOFKnxMHtW6nttNzypOb8XVu4VorgPbenAF7uA99U1lAoqIAyurT5NljB
	GQx+GNobFzSnV3eXUaQJlbGqM/sgA/MdVrN38ifyQQksZ3fBYnPHWFDg63Kc5RohBUgdbmQHqY2
	SM3KFGcubIrdGTXmgU0I7p3Ar+YAg1H33Pb6xtICP+6es2GcIY50GjCDEOoEElJX080ZwKeBLZ
X-Received: by 2002:a05:6820:6ac5:b0:69b:196a:de67 with SMTP id 006d021491bc7-69edc38e930mr1694309eaf.0.1781270466074;
        Fri, 12 Jun 2026 06:21:06 -0700 (PDT)
X-Received: by 2002:a05:6820:6ac5:b0:69b:196a:de67 with SMTP id 006d021491bc7-69edc38e930mr1694292eaf.0.1781270465641;
        Fri, 12 Jun 2026 06:21:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:02 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:54 +0200
Subject: [PATCH v5 2/9] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-2-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX6NnR22DY3Vac
 sanw6xdnvHaCtcz2Jn7/lMsN/wR5iTN6BiMJ9cPVJYWFW5wUK6egFI2cA+VjQdlvpv0IGrsH7LK
 p2H0n32TeuQwiueVO6d8P1YITWoAU7mnTpA5ys+aYynNCpKI7ifIZJYT+Dk5LNpjpbmzFGIPoAT
 is06vsh1+xa2RYhcESjxLwSol2AZFgfCMO8eHYtz2Ba2x5ebIn/WB47NcNyonlAcNro7yLvvsur
 IMQuTrnRNmhjJBrnY8VE3aBquEQseS/Bm7S0kafg7XnNa0G0W/LSJZu5blMshoGWW0H1LjdGeL2
 pEHOCbR93U+gZUiV/5gFFVdg5XhvoLhXQz8/A/XBlMMRlP30xWIzi5Yb3Gs+Qi3QFapYd8hvHIv
 RZMYQODqislpiAVL0hbW32R+ZrFsb3MMTz5+kIH1bxtIWfNg2nBKWU+ksUs/LItTC5PCqCnS6Kv
 5QL6Ml+T5KF2htCS+LA==
X-Authority-Analysis: v=2.4 cv=LNpWhpW9 c=1 sm=1 tr=0 ts=6a2c07c3 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9i5gzfhGLSn5NVSMExYA:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-ORIG-GUID: 7f4DWF-eeB6-L5dT02kq7vakUCArRk2o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX07LkQ1SRyEHs
 R5wiIwouKBnz4s/jfXYkXe35yoMYJNffzdDXSCHL8FTa8H2AJFWgq1JMSI9V8CrOJVpk7NPXsw4
 GuZwWp5zD17xV04vFxZjRFF6K/6E4Rs=
X-Proofpoint-GUID: 7f4DWF-eeB6-L5dT02kq7vakUCArRk2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..ca907ad73095925b234b119948f94ae81e698c86 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -40,6 +40,9 @@ patternProperties:
         contains:
           const: fixed-partitions
 
+      nvmem-layout:
+        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+
 required:
   - compatible
   - reg
@@ -86,6 +89,32 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-partitions";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    mac-addr@4400 {
+                        compatible = "mac-base";
+                        reg = <0x4400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+
+                    bd-addr@5400 {
+                        compatible = "mac-base";
+                        reg = <0x5400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
         };
     };
 

-- 
2.34.1

