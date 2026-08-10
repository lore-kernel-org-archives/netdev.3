Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BA2931E3
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786322563; cv=none; b=UOLzfrbKi88dA3HXOLBSTY+H9uEAPwbM1l53Uz6FVWY4RGclswtsLs0IBhWZ+czFUOD1sgcpE+TDeferKbI+6OUvFK4HJDejun4FRGuEljh37LPUzIptQYh1OyGSWTKsMB1lW1tvk8o9ywM/C6GipciYSqpAqGc1ptmYJqD+xlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786322563; c=relaxed/simple;
	bh=o6cPBYqmfAyO1nQGAWMNIPJr4TcWhPmZALAkvjJ3MlU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UsXXRXCWMrGG3DTuw5CWbGB0I+UMxE6ULojx3OLKe6lhQ7RAXt/J5VYYnBEg6ZDXdYdP7exAshV4qW8VqhpA50WgWlHUvqq5nWnhDWB0ajDTNCm1H+lNfeAr3YustWLEkLUfc5tZSLmiM4GQYvrY1Ux8yRNl9yaMndEncDyZ07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mmgaXIdt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H2syNZ/E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mmgaXIdt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H2syNZ/E"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679LD1894103028
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CBXJXiur59WDEq3KDTN4bT
	zmvgmx2u4KL8wGFuM4+gA=; b=mmgaXIdtJ41XC7aMaYA/AbnaIomqCe27sfXYlk
	6yKMSbEwewZiLwCPHEQ5S3bG57zuX2MJqGazMbsSAgUcgfzCOAqzDS1o6keXdF/S
	YtGUuBtgB2/K9IrL6kUm7/lLe3Xdb2KQunt/C5gl3pypUHaO4MyYYKA+TF2jvc5F
	zqaaup6kQDbT72eMDdw43bDnW7RYmybOGsZ+AfTPNLjm2NR7y96wW8h057bLDSDx
	kigcpXW5KzyFQpZsAiMlHeHqwV3OK5TE8PVPq7gsw368xIMm2FhXRQNh05TlSi9F
	47mUr86tSATe7h3X3IUvdZeT4JcgQt3wb/tZwx6S0g3kdGmQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy18xr93f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-904ee4473a8so11039746d6.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786322560; x=1786927360; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CBXJXiur59WDEq3KDTN4bTzmvgmx2u4KL8wGFuM4+gA=;
        b=H2syNZ/ErAdhACtsh5k5YDy/9KucWu/6fTvijTDKpMvmxiScAq3unljdtzWHTVtABE
         mmLpVkJrfURqPFzcCuL93vd+O153VTLoCgC+Gf0zC9NoOywynWVmf4AnvwDrnrMI7oe0
         wm2gmvAc3meQoN7+q4FqJ0IE+fAp0lcwpZJ5KIq4twctzV2kOcuMscsIe48f37wbrOZJ
         2Gig/0RVB5fCeQ/GWQxWhvKg69Hg9iJsF9LN8bR9lMhHkLbaJ5Smgi+HsASUbk+R8Zyf
         D5xxoIB6T3R1c7HUHRIPrZEi6Zx2Ir/2/rFadjRd5wALEeS5OM8nucPeZpfPOsFZoHH7
         ungA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786322560; x=1786927360;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CBXJXiur59WDEq3KDTN4bTzmvgmx2u4KL8wGFuM4+gA=;
        b=ZIb8ulNharKV8eJ9V/AoA8mxm66wFInebr2LpMz2bIkEBsoqSBuLyIui1/9Saxv9FC
         3mtaHbtaJ36Y4tc7lxGIPyR8QPflEsDus3eSor74IsJdVPnpW6/nkXwg74f0k1U/8qTT
         CeuGQP5WQNrOLWKtDFAjOP8RxYtmLgXtirxSs6JK34H++nO8cWfRenJKZ23CABFoSi4x
         wlY89H7mcLC/0ZZP/dHajnBPHhbhsuMYFh8esZGjuKGUjOHg0CqModjdlOP8+tWLaRLa
         smLbSEAT3jDRD+sjVombvJJupNioh5gmaVjsVbjeoSFQ70uGH+46YXARCRQ8E+F1vJxQ
         QQ8g==
X-Forwarded-Encrypted: i=1; AHgh+Rql3GBCjJw05xTXXcBeAHKzxBAMpBLeVo+HXoSELNCq+ubSsovWigSB8tDDub+FI8ppOrkdgrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQfuDjj9k1k8sgSJpNp3Dy3zX7ALN0jxLCubXj3+HLv5/KL80M
	FrHBrr9NBe2iJtvSC5Gfkx1o8CuH34UeUQRge5AUUtwiwdLO3gxXdUBpOVpmKHL0duoF9Nwolkr
	asniw4bd2xh3bHf7WwYCmFudgrElrP9Y5XyZCVW9PXr7+zhBu9V+QLCFGYNg=
X-Gm-Gg: AR+sD11gMU+UevVq94OGe9O8S+G//gUiGfrTUr0/5W4pjvA3pufL3KK9P/2AOqk5GBS
	2MIvc3vUIHf5H3btAQrp3xETQ+VFwWQiflJz3o/vf3bJumBUUpC79bH9xRSwuTYFuJ8FOgsyBrN
	gBklj7+GPdTAfzqxVgWk4KrpUKilOXn7k+FgE2ePXujzcXcTC3Wvjzi43E4Qxv1Vc6jvvPUpQ++
	KefWx3d2a/RdkJPb5hi5gPQzwa4yj2rVUKCRVJAh3e8rbQ9tEhqqTVG1ICy0HjZMyfpB576zQOX
	2d3J64CqcE9f+ycCzDGlp7tZjxA4hVyY5XS0iSfoF8O+mfyuhGAd3QiwZ906M5zWJKsPT8Dy3Nw
	DqljCXGuX9GW7XrmtWXUgc0KTw0FWoKfiFsG8eW44mFNGPtnSPrEETiG91THxY9/hSL6G9BhvN6
	Wk6PiB2DBN9Q4cQg==
X-Received: by 2002:a0c:e085:0:10b0:908:92e3:a37 with SMTP id 6a1803df08f44-90892e30cf4mr269774116d6.32.1786322559944;
        Sun, 09 Aug 2026 17:42:39 -0700 (PDT)
X-Received: by 2002:a0c:e085:0:10b0:908:92e3:a37 with SMTP id 6a1803df08f44-90892e30cf4mr269773806d6.32.1786322559489;
        Sun, 09 Aug 2026 17:42:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3d56sm1679742e87.69.2026.08.09.17.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 17:42:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/8] usb: misc: onboard_usb_dev: support several devices
Date: Mon, 10 Aug 2026 03:42:31 +0300
Message-Id: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgeeWoC/yXMQQ7CIBBA0as0s3YSirUFr9K4KDDqmBQMU4xJw
 91FXb7F/zsIZSaBc7dDphcLp9jQHzrw9yXeCDk0g1Z6VKZXuMpq7DRgii4tOWARh9YEbY/jcNK
 TglY+M135/bvOl7+luAf57buCWj8jgLYudwAAAA==
X-Change-ID: 20260810-msm8974-onboard-usb-98d293645270
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=o6cPBYqmfAyO1nQGAWMNIPJr4TcWhPmZALAkvjJ3MlU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeR57p3nX3GNlwd4psv2SF8WQY7zDH9y78rSrG
 fYWhIxEBvaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCankeewAKCRCLPIo+Aiko
 1Rv+B/90wT6Opjrub33+F91zcqq/z8CixmOXkPF1PDDjor/QPtKVuLw+6EDdY/E+iVPDkcy1f0J
 A/kqNXhZvyEH+zP8JEL7EtJtb8qCmkpf1vY7ZQTXcK4ZjJisJB1s9+HdBolo0vUIYgcX2B6Lmii
 8RJDZZ9AQL8Eh3J+6UccbrsfNrGNUMtqtpGH42NjR20JcLXJbI9qOiq+0GXXKKxBwUn7Qj/a+5M
 Qv4GeCK8sao1tHJqrrQxiTTKFODQVAMe2IXE8x21o8DanZXQ2BeGoI/LkyZ9bGvYO4jMbguTNF6
 K7lPO+rZaz3kLTjAwFX34/3eDE9gvFhi4i1GSoWi5kjhUWrC
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX3tI0hrIB+CQ/
 Jhz4jOIbDNJGpjURy0yK2OYPRArb81VTAnHOeQAOMznj9rFeSX2szrtK6aKyZhEi/w/AEJMDgXV
 dZCHHkvNGwV2bVe5hC1CwKdK37msyuE=
X-Proofpoint-ORIG-GUID: QbPndMbWPpoD83C87m9ZWvH-wohQdUSC
X-Proofpoint-GUID: QbPndMbWPpoD83C87m9ZWvH-wohQdUSC
X-Authority-Analysis: v=2.4 cv=bfZbluPB c=1 sm=1 tr=0 ts=6a791e80 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=EXsK5QSkjY9s1esHV-QA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX+9RuA/CA7PIP
 qyjoU8fVmNPY678ii8PXYLNzYT3VnbjXmSNnym6lKGV/QdTCJ1M+D0ynilYSwQXsHMDxfNsFrQG
 cel+absSb0UD1N9WdYFPDjxi/jkFbiQvALDkNiouYaM7uJwr2KgfxDC1qttyJVW4oypndCWc7se
 UC21yuNZOW3UDDaMWxF2kRAsA691o21cxpgwGASyjYTrg9FMJzFCRMgL5m5ta7NH0ZAcZX5lLQa
 U7Pf5f+FiR1WEtDMV8BJSb/2fFH+iJcp6pI9+8LMLSEVyjK+a/J38wrr7Xc7SD/fAwfBCQ1+Sd2
 6c/WSJgt/++mERgjt9p5wEzzXj+MPpgy6vix/JqTbSNvv6FHgr63WmandDRLj5FaH07I3bQ1Z8I
 lgj0/4ZLvTlc3u9V1GxjpHD1Z50VNaOJcGVXkYgyL+oRfByo4uon6z5kj9KTxhPnYjyLN6q1DAs
 x2wHbE5G04m/Br37gsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100003

Describe and add support for several USB devices present on the Qualcomm
APQ8074 DragonBoard device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (8):
      dt-bindings: usb: ti,usb8041: document the TUSB8040A hub
      dt-bindings: net: asix,ax88178: document the AX88179
      dt-bindings: usb: document the Prolific PL2775 USB-SATA bridge
      dt-bindings: usb: microchip,usb2514: document the USB4604 hub
      usb: misc: onboard_usb_dev: add support for the TI TUSB8040A hub
      usb: misc: onboard_usb_dev: add support for the ASIX AX88179
      usb: misc: onboard_usb_dev: add support for the Prolific PL2775
      usb: misc: onboard_usb_dev: add support for the SMSC USB4604

 .../devicetree/bindings/net/asix,ax88178.yaml      | 10 ++++-
 .../devicetree/bindings/usb/microchip,usb2514.yaml |  1 +
 .../devicetree/bindings/usb/prolific,pl2775.yaml   | 51 ++++++++++++++++++++++
 .../devicetree/bindings/usb/ti,usb8041.yaml        |  6 ++-
 drivers/usb/misc/onboard_usb_dev.c                 |  9 ++++
 drivers/usb/misc/onboard_usb_dev.h                 | 28 ++++++++++++
 6 files changed, 103 insertions(+), 2 deletions(-)
---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260810-msm8974-onboard-usb-98d293645270

Best regards,
--  
With best wishes
Dmitry

