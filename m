Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB53EF64A
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027131; cv=none; b=iRb/uS8dk7SWBoX42wLlO8Pqy5AZCNVe3DxADgGev5mRC8H6GLjsJ3me+TJpu1mPvN4sqNYqRRfDtE5nthFCmbpoLF1XqeFWXrY/7+sAOCBhP3n7Ug41qTQfZhr8/PxGnPdon9ZK760RQBCtJqa8MteP0Q9FQmYFzS2s07bid3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027131; c=relaxed/simple;
	bh=036KrKutK2s+JBYYvV0r0UOnKyUPsfS9tqtbriE+abA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OizVghmLkvgXFpbYGslhxv2eDIQDy67rOw79feOMs/64AKYxYx0pDi9WgmSnjwEjUWaQl0m7Sw8WqiJj8r27xoCjMbatlUHwMLahb8S+KjKf8pH6qMThDZNC5Hdi4SKpaBkw4KhurXRfw6aTfD/uJDSFqCxLzSPouUPHg1AuKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mbTS1Pxi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NiNcw2tz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mbTS1Pxi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NiNcw2tz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ne5C2104782
	for <netdev@vger.kernel.org>; Thu, 6 Aug 2026 14:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JU8Uh1sAxaXOEPqhB1RXVJGiUv22Sc7mcVDSZZfElb8=; b=mbTS1Pxi0LuRvOGw
	B4YG69hlkx2gjIGqX/GNaXgfcg+nm47kht9/dZYqeBkXlDDaAW6bJEN5TA5hBV8s
	nhNLGDafbeVWioOj/2WsdA/el7v8zGDUK5GUdOvX4nIYkH+CA8bHwLb3WTZc/zTI
	dGKKYl/Dc3h8vwG6+PoCF4QMhl+JARatBo0sYovrfLLj0j6DFZoXPk4ockY7D/SV
	4k6bFus/opI4VlNi7B4cLFBfuG5qOF7SWgnIN7XBjt7fPJxnUO0bfKkimah1ATzY
	pncyWycc92RH3Y/jda/2JdsmuZvjMs46wTx6/q5hNPQXAJjLw47d4ddIfuPEE1yy
	IPfDMw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvq731km5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 14:38:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52ce64c41efso37573361cf.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027128; x=1786631928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JU8Uh1sAxaXOEPqhB1RXVJGiUv22Sc7mcVDSZZfElb8=;
        b=NiNcw2tzWlcSjetDKlJW4mbKD4eH+2TYhgE77FgCeUiEYZ7CGI2b0PfVNFj1kLLX9+
         aB7/gcLMd3eAkn/lUlw3Lr83gwG6tHD8+ws6Y+ASOqyjpVU+p1EgERz1WsG9iZ2pS5p1
         1fSSoTFY/U5kKGsafebylUGOw5r5wMRFKvMYjYIkZifxY/o/z/D+of7Fns9y5UZ7RrfR
         t45N6+7mKfDoHz1iTacu2d4BWOcoBm2aRDeGOTIVGFhNIT5XtfuZm9O+xYnr0UJbsZPQ
         ibGpLFsJ1Da/3WE0KbBh5vPgts3VWWN6ogoefYmS0Tyy8UhJ9dixdNycHfSNZoPNniGI
         26qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027128; x=1786631928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JU8Uh1sAxaXOEPqhB1RXVJGiUv22Sc7mcVDSZZfElb8=;
        b=phU5k/M5ZlMjPQUQGWY7uxToV6IwCko2J+ja0lihXtJLY1wVsU7Oai/0MIjKlcDBYR
         beZdPn1fcfnubyDS9w7CzecQhjd7cAoTglz4VlCEtb32zMmCuVwuVC4ECoecL1Uj2QG7
         FUrRG232hQs6q6pPQMaiqneNqgMALsvzouaxjlUZ5qFmwZiOYa37OzWnendGD6hxuqvE
         kqTsH6iW/pl8X+KGYoV/JbI1LdCePDQJbnRZRQDoK51cqzmwsvi+5mOOeydwVLYN3ggb
         ahNxJNYpKjtHX1fwl2DKMAYgWYxQazA7wuefAYaX9ODNc83uvPiNay1djkV/krzUyheX
         uh+A==
X-Forwarded-Encrypted: i=1; AHgh+Rp3lfdEGzmDr2TJUkd01Dqm+16K+3DEFLkEDc3QtWji+Ad/wdYMXVaP3KFPj+z/kXw8Ij4NhXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKOGph/xSIcB/XomILfls631dAmUVavGgZLi8aNxt2GUG6cGc
	uNvEhZhLeRUzvoANOZjFSmqOZP6oEYi9MdtlpZnwRpZ1dJI5+8qaTRny530AHD9234C8SD6a7Cp
	/fYFWjlivAh6uhc3l3VHAnZIg5FsRWWf7P3HAIQnJCgy/0yKwAsuinsSBmCQ=
X-Gm-Gg: AR+sD111YEJy+lNPnZUZlrgY3PsoqwhkqzeHxcafJRHBIae76YH5L+G7fzBnhpV0mY9
	bhXo6s6JnKaqjV53mw1D5iWNLRLAsexHMtv+HelkerbH/Ljh3wbsOgT/1IP0EddbydGyfrz5OCp
	XcR+U2Vk56PnmyKNneV6KJfyx9RljrsrMCWIvuuoLU8oQlZaeCk+pYNI47kbOYylK9YYHWUHE49
	hHdK/c6GuR6w85WrxRcRf9aU7KxiamP/PxWvvbVMWDA28Ek8SYrQXQx426stekszdt7U9pm3ox4
	rDj9/Bj2lqWRZlLR5+edpkJq78YwAn10vp7YAxO/AWB73MbLaoX+U8jSd3DhaK3qUkSwzQ1/YZW
	9EDk4wQZq353oxQ+KPCVTBTW9PM+4k2Tu3miyJMfeLyS5IQxYw+3kxwv6fFpybuUgUeUo6CMC08
	L4N9l/NzJhkdGuHILqDUuptV19WYF9O4gk96uwD6UGfaSvIejKcA==
X-Received: by 2002:a05:622a:22a2:b0:517:2c1e:8b6 with SMTP id d75a77b69052e-52ce61e7a0dmr167527291cf.38.1786027128479;
        Thu, 06 Aug 2026 07:38:48 -0700 (PDT)
X-Received: by 2002:a05:622a:22a2:b0:517:2c1e:8b6 with SMTP id d75a77b69052e-52ce61e7a0dmr167526851cf.38.1786027128119;
        Thu, 06 Aug 2026 07:38:48 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:38:47 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:34 +0200
Subject: [PATCH v10 01/10] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-1-be598b2a5606@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX5RoewJ7XIiZm
 of1CfO2iF8i9A+xrmYXCiaa2Au+5eF+m1lHeaVg+3CEqOp60VdeYEO6LcwwysUo3ENIS8ofMpam
 chg4JrXTGSFDaX0D7ubuKKGbK4W99+30ENSBsoJIUhh5bRRk0TAxmNOrpzLPmyX2mwTPdR1CSWS
 sCq+AKmL301cxdXWV3JbKQIVWfuPN8COt3CSeOW92vyL3K2C5N+CnW34s8NO2UbTPyeMLDHlHvp
 LhCUhzU+BCZzm+WcTNk2DThVdJ6OFPFdsln8RLHffQsbzbsSPEqRtgbi1LGgKT2Pi0Ox984ZjIy
 DUT/QXRF7o5ArClHmzeXHtUwv7G/ueo5gXAz0d8EwIlnCe7DT9DX0T9jRdrs5XI/TDm6xS3kSZ6
 NDaRQICQlGErned8YLtfPlN6vL9H9AxVq5XBNMYrHNBYiNvS7MxywecdJHPeEKXpPzx7515gpMw
 krV58BxWspetOfgrAzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX0C3Wrm3wQfs+
 jCSRsoGWz4TGnlI2mN5mrQGhFtwCFWgc8lz5wpbIiUWmBSVeYXoKeWow9sfJWG9hdSJ1601tXfV
 9oLbK2mcYaP31vLyy7Wq2y4ufbedi8k=
X-Authority-Analysis: v=2.4 cv=EeH4hvmC c=1 sm=1 tr=0 ts=6a749c79 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VqbvvwzL3cOeFLaalA4A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: pkA5fsu517IbG1MLxc6JpwoYZRD00_Ss
X-Proofpoint-GUID: pkA5fsu517IbG1MLxc6JpwoYZRD00_Ss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

Allow an eMMC hardware partition node to describe an NVMEM layout so the
partition can be exposed as an NVMEM provider. This lets a partition
(e.g. an eMMC boot partition) store device-specific information such as a
WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
cells.

Accept "fixed-layout" as the partition node compatible, in addition to
"fixed-partitions", so the layout can be described directly on the
partition node.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b58a5fdbee218358 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -38,7 +38,9 @@ patternProperties:
     properties:
       compatible:
         contains:
-          const: fixed-partitions
+          enum:
+            - fixed-partitions
+            - fixed-layout
 
 required:
   - compatible
@@ -86,6 +88,25 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-layout";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                mac-addr@4400 {
+                    compatible = "mac-base";
+                    reg = <0x4400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+
+                bd-addr@5400 {
+                    compatible = "mac-base";
+                    reg = <0x5400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+            };
         };
     };
 

-- 
2.34.1

