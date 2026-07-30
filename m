Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86883448B83
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427255; cv=none; b=fdyMi11RwjGVLDoBRZl6yVys2txpH4dyuHptyaq1DRQHAVIWQaaDHTZJjID0lKNaToZ2Gj3YhJdZhy9ABeX8Zquahvta7/Ef7z4TTcEnmGyCUoGZdVQn3TL8IJi2AZjpvazsotj6oy8aFY4D/E/mWmMwAXeEcCBqDl7f+4qaRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427255; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9mzmpv+JT5M9WgOj8bPXr5azxh56PWFciylV4N/+NgU3GJ4m5AdaoG3CFNYxPmVWPa17cFwtnQFp4XBvK1jH46K7p1kqvhI34LKE10eUZNVHq9LxIE80MVvu3gW78puZe8M7WiIKBW03nVORYLHimBljUdYk89Y1HTh0pEciv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mdc2lZTP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FwEh2Rts; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mdc2lZTP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FwEh2Rts"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQpVe1087253
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=Mdc2lZTPtt0S03NT
	RZN2LLYKd+6xXhFCtur9/pn9KUxEL/qAs2gSangnk3Eojs3/CX2/U8oIu1o6fKhC
	XroQfXn6jyxAvPOItfTXBxB6a8IEK4aVhaevupkro8jYPxWKsqEiumETD82FoNCv
	zojIrPoVqqom+od2/ljgKcP6kfMDX5SNaauAqJvwDWm2OmxejTT88jaqRV8dhhuA
	+pBxJQKtP7NAOOE4f5RoZyu1f2FUpYzK3pNhCbkmi4s+mx5iJ+i1z3qg4IrYqyDX
	v4V16C0fVnXQTebHonIJ1OlzTzv7K4oWtrb1v6u6WZahOxMwVdixSMnVEx8rgQet
	SXIImQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8n38cur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:00:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0f0a0760so47362231cf.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427252; x=1786032052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=FwEh2RtsJvEn+rL0U65zvFAXAB6V0NatDqywijX7iZHpu7tI60oLDKDe5c8a1F5/XK
         Jrb0MxWkgaE8O1UWl1JGWITTemCsUXIbV8PxYowcEaRj+iJwt34PIGEkBJT6fNB78KUu
         pJvRZ0J6VGI+KxoQIVJNylqSJ2dByCIlVJOZ9BWmzQeqO40mul/rpi08mFE8FEAieHJs
         Re7gE3x4ChjhrAD3pmYsMYG74GhhwBJH8gr5T5Lgom+H/zNKiuKsIZcguGLGYxinG4py
         ooYkrEHo1t+JLvMDsF+HwJC8DIFYeXt9yCtz1XGacJKQpDClyY/rsencnBWsQ18jPK4i
         FuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427252; x=1786032052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=Q6ylmWiQcOFeawmfs8C8DNeuBgmgff92EpGHWZwnDAaYrDPz2Jk48j19XiZVQDJgbJ
         kxbriWBZEllSVTYgI3rqAsB+mvz6GkMg8oN4Gkt2kMmz0K1R4iUWIfdZwnbyhCkn227R
         cPIQD5g5LJwfbM+9jptrz6L9PA6YYjIt4Bhoix134JXEFoM53zZ1EJeJ3c60ivcg5vaI
         C59S3hWMFLNN/g2rTpfUPVB21WsN00Q2H4X//uyVTVvPhOfIEpuZCuIy35vBlFTmgBxu
         He+6z1/FKzmm3o2fonCA/CirzqKcm0mt9KMK9U/cClClkFw3N6AkoQ3Wgqa8T0Z6eewk
         fGuA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+L+SFywbBuL/RtMJntSJLw9YufdQEF0pqtYOgTtQZucjCEEvfqAEL/hTCwLwvwkyvzXRN8EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiISeae0BSRG22POq49bhO8SF/7R7t3Udctr/OWCfknzgQI98e
	wRWVAqhyIp/UQVguS/XH3T357ncnhL6SFp9thh4+2gTokpX5wnjVEzOnyYqf+hmkZYGPqM4sVZu
	G+Y7aLKLiRzYELqtmHLC6X1yE4EETq7ophe0g+39LFNZBd2oVlSQmFSHb+as=
X-Gm-Gg: AR+sD10RN2AI2B1O2YA8Tcp+2cLFMpPeRZ5L0PZGuf2rM+DKtv9oBBqLxQdUtfLdINk
	v4B3VdwZ7BkB8Ca3unhu5aRV2aYyXlvh6LHXNIz8Ij0MtdsFkLU6cZIN1/iVOCodNftoLh/1J4h
	9clPZWoG200zDkMiXSGJla7+Ack+RvoM9IHIgCzGF7JxUOixduYKFBcaeCHY5uZSEdhJT0DR7OF
	JIbGGamz5qEA0wDW3QYAmcA1B9CBMFmwS446xwTXf4d/RBydI4/B4a4iaRK2kvpXrfOdyCclxBb
	6QApPpqOrg+dwF6joQ0aH2sSxT9R8v9J3mT35Cn1IVZLOd4d54cHdqO1lpxipSQtoVHGmceNySR
	db+yXXNyopIgKAvUN+Lhi1AmjBQegy1zOGS7bIOdLMQ1zDczt2uUgmfw7MXna9lWpMM3RqyxEBD
	ZpXGLWIqw4n3EYuWzmcQ76X8l1xkKHysKMnMVTtXa8JpHxsxgLlckc
X-Received: by 2002:a05:622a:1e12:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b384c7d14mr37918311cf.27.1785427249389;
        Thu, 30 Jul 2026 09:00:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1e12:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b384c7d14mr37914671cf.27.1785427247300;
        Thu, 30 Jul 2026 09:00:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:33 +0200
Subject: [PATCH v9 03/10] dt-bindings: bluetooth: qcom: Add NVMEM BD
 address cell
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-3-f72935817dbf@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Ar/eGu9P c=1 sm=1 tr=0 ts=6a6b7534 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 7V9reGrK6HSt0Dj_rGaYovCSBVruUK3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXwMWIwg1Acboy
 QDqwg0RStSP1eqPwa77+Vl7c4oXkDV8RvJNm+p1eMJHYas1QCVZdveyFF2zv6e7RCQALgk5Qmqd
 9UJEUs5ISoIlxR3q0BboU501HlCcg+u+5rofmUoxrFY5CkRzF57uZNmONghJ5ScWOHV0gid1cdv
 Nnlonh1iL6hpLHxNZnaa0v/Mqr6sjxuHLkOYEnOIrckuwCEeP/K+n5g/tiqxPBreQWtoTjIP0sR
 YE0mK54iwfUDYzFowOJs4+BbzH1b32Q/RrJVTWx3D6cu8Lbg8SSlrbDb/iJNCfxB0K31ZlNoFoQ
 hpEEONXyKrW6SCMT9iflYBfvWy1JY8tLjluqZ3TKsjJFiUZmaLRRiultgG1G51Diso5Qxsu5q/1
 DngH2hBcWrU/JMKBuLc8TQz8+/IC+2QiTPYttoVTZUnoq/V5gzH9AYVUofh0t461Mwlo7J1GoXe
 qeqrEHCb8xLpi8dtRYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXwZb2ZTTEiCP4
 RTTuTIuikak5wv6zGuKZhzW+5m3fzVBRfzAZnhZe7cp0rU8IqiqbSGLr5X1gkn5itBk7eSkI9rJ
 bP0+x09uWVWFdGrix1tcDJZucUEMCQM=
X-Proofpoint-ORIG-GUID: 7V9reGrK6HSt0Dj_rGaYovCSBVruUK3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1

