Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D7446050
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427249; cv=none; b=cOjmVIJR3bo3var8L3WJzuN4bPmwh1XTv1DRGtFzAzOmzLL4MgJCdko2chp5iYw8DWI76C88vF02tdF48WNtNYm5VKZ5i6tT6Bw/ss/rTH06vbWhdQFPL+bcgns7K+2bxagdtD+/K8DTKt3Pj/3O7qBEbkp4KPjxtS9Kwi3u3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427249; c=relaxed/simple;
	bh=rFLR77CJJYP1sKLFQ6gl8hLWfcBFJvASp2MjESWcdt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIU0jaEEnxcVuapIGn9RcQyN9tgnE0ncYQyMbdXwsSDTKFMcFjeceAaEO6dLWJ3+jB4Yom3oRu4LzKp8kR95Feyk7dyUOOzt1xa50UgVdY1OXigi8tiLMSs3GwiWbXvt7yxQg8Zi5sFiu89e4LsQ6/0IIZU9Sq8rT/GkfOSwFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dv93W4+k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hq5GYknx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dv93W4+k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hq5GYknx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQutg1225920
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=; b=dv93W4+kq74ezcsn
	PoGGxoSG5/baz/ImVuFoETwH6zagLZ5tCc+ntmZUwNhu9mrDn5l/aWdX+3RqR09k
	+qqDCr4MUFHFy2rPZp8wG4vW3hoQDx59OoBFCBpp69kYIrO8bHxv/0uRi1U5GXdv
	Ugw5LFDYcP/hHdAAxrIGONk2mCitPtV6mJXd0G5bL21EoMh6yhU+rkt+32uAL3GO
	Dx7bQgk3HLRrtq7QxCpVI8QG6nyEWp9k4X+OwJ5slZ3KmwCUAiAv1GCKNM0WAkR7
	cis9ttgsPcKrpB3KBWV4g004u3i7whUdRwaCue7TVmdnnOT+NKRa3xMNbpUtrbcO
	bY0fdg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8kn0er0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:00:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfe3fa93bso24627771cf.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427246; x=1786032046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=Hq5GYknxpa+8WbZbhELHY424WQqiH3+vUO7yuuKM3WLmFaiokAlCBEMxXaX/EQB2Ev
         u5WVd68noRRoYJqDEbZ2Ga4lJwJDbPQ+mDRRoBzHAiL07aHB9APbUTyboQmfUNhOL110
         B1C5cF5I4Bt0E2uquFgyxvj5y3nvJKU3Z9EMu48l2GunuPKeqDCjjuEtDNgirStQJ7Yf
         G5ArPKpQb4u+S8bmo6SQ/h81ZgpoZR9mN9XkjnzeMQs1Ji13CJan4q+xX8u7b/uXlBza
         W8SvN8SXio/4Un3nqo72OwrDZ49Pg22EBAbkCxjTQZQwGf6dvv37RzJ23xVOGL3OE28e
         K+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427246; x=1786032046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=ifk5pyVxzi4AcPTyyAjiLVLoWuLtMyxWKcNDx4eWcy6U9iaxfY/z2seauGzpM+VJ5t
         /6K1kFjdyrTmkHeNI+GhrMXH9mBU5gca74H04caynxtSjeTGPDGhDyhiv58bBV1aKSvM
         ri3urjYzLN/tDkQMnkvvK98Gkbi7tYLY8CSRRkNjPUJxJ58e8qqIRF5ubhSLgkK7gB0i
         xkQ4axiXbLLLq66TlnNkYtc6d+trbTjIXiyXb6LV5a5TcRoyHIFA8WDcUqXcpA/BmkFR
         6MsBHb3MPgtnClYuTVo47ABenGdy12nPuIup2WOnFAwKHnRaru+cL335bNTciDbXiLYa
         ojnw==
X-Forwarded-Encrypted: i=1; AHgh+RqUvjGnsUmEhVU2Z6o6oIcMq9rzQN28SoXo+esg2jiLIe5ISLVt5ePr9ZD7uMutgshjUtGMmhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuQmEWqF0hZgP4BycUJndVScci/a2lqK3T0YNhrLMUwE30ftx
	vFmkO3woSFlgxk0ZYLBENPWvarx1i8p2sdc452/WuhVy+2KCftuaGUd/+M6sm9D6CMuvbAloky7
	rnIXsSK4Xj6s/zDH0WGlHf3e00vpmlAiZK47ZQzQejuB8+lQmlRrN95nYryI=
X-Gm-Gg: AR+sD13DyBkGmk/mDanOv+m/IeQVZ/0DYDkB7AGufvh5KZytPMUEN302RUOBU78JEcV
	wUfK+ip3E+Lwu1UB7AerFhbR02hgyv+w1ozinRGH5i1KQZZubpE2vBp7hVgzhAxJnhLOcCeXrvA
	Ijp324cDITst1TTXf9YIOSvn0zCyA3wgZUWDj+OfJj6goANswqjWNg6u9fx9V0QsydSq4Q8BTk3
	STk/Pswa8so0kSitsOucKKn/wcC16idDdH5qnUcPKmSNjRpIwykxZZTNEJs+Txu9NWK2kVe+acQ
	em6OFGek57PHWsBn5nzPzgIw/8jf9RjAmcD4G/xPgQBCoEu7eG2mhKirnsUJoBTtnELbHF8dOfY
	NVRjxvZ/ZjlKN31MBLhMZ195Yy06DEcnAKJF1veHjAPTsuQb7UcNmOrupjIKZHmMJk8VWxk+yHo
	AR/pS5BTFIR6yi7I69ZJG986hEzKBkrUlxjvXzkuKj42cyN54GWDke
X-Received: by 2002:a05:622a:511:b0:527:6d4a:192d with SMTP id d75a77b69052e-52b42cba100mr8220561cf.68.1785427246091;
        Thu, 30 Jul 2026 09:00:46 -0700 (PDT)
X-Received: by 2002:a05:622a:511:b0:527:6d4a:192d with SMTP id d75a77b69052e-52b42cba100mr8218291cf.68.1785427244656;
        Thu, 30 Jul 2026 09:00:44 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:43 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:32 +0200
Subject: [PATCH v9 02/10] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-2-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXxGtE22Bi/PuO
 kG7SxQDo2dV923kcH3rlw71+32JthrabSC9/v7Id5orttnsVbNIGgtvzpUQ9M6XE7/tuRDxfAbb
 Fiz7S1jY5qJPMaaDhADwhedp7SHVVpk=
X-Proofpoint-GUID: k2p8FQeqSGH2mWhC6Kqa0e6O1QMNSBjx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX8gBmZ12q1jp+
 p8t/dcImnwows6HMIpDurX9fqGVmxVLidIrdBI/CoDKn6JcoljAXKLacCrJ9DAK2A+V06EO4xKD
 xPQxw3kAZIQDXI1xI2JGXZ+0Tn6XYNjYDj8yl03qEE1q2xEgGnKP3ZLICOGnDiMwoBIozolFnmU
 AR0KmpaSNZ2Fu299SflPQl1t8MQAmv2xAcTIGCbCLsbX+3LXW6F2RznSzkVuCB83NNA7AhY2wvS
 zM5JHUjwX2XrkdA4h+gWLiAACvT624WVsP/VHLA6lwL9wC/Q4BnGDtxHhlgETUXtFLrTpR8LeiK
 dH1M3SrxhAf7CofFslxX6W7pl/jEW2t93cpNj1lcpFKBfaXy4i6KVXdvoQY34oV1Iv8QtDLikz2
 pwiMC4mdxmR616vKNC68HB/TEDROety6DqwusK7vbRJPMtxtHMo/pozJOurQXia2OTTLX2U0XQx
 z8/o9uxI+daIwUpyZwA==
X-Authority-Analysis: v=2.4 cv=V7NNF+ni c=1 sm=1 tr=0 ts=6a6b752f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: k2p8FQeqSGH2mWhC6Kqa0e6O1QMNSBjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index d4f4d72ee0d388f43437fc5a3047f90b464a5274..7f9d16cb7c14330e11ce7d567d585b5e47793bd8 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1

