Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212128AB0B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161496; cv=none; b=otPYhXZeS6xT0aL6TY7NFm1Gw3H4onoIw/gvhgMoXmdAvtCb/4CLLjTCCMpr94d0hzTMqb65w5AL0Ok7ZLHBPHqEsI8OUbJx1wuRPxKSy+A87zm/aIO34ZKy0dAj5MRaCXNgzgVn+X/0gn3JOyy/7MXX6M/AbxVNwvJaWM6QAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161496; c=relaxed/simple;
	bh=WX/HUVlkihtjaAfOHkVv2QOvxp7kvnesEbLy9B42qaA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MnRybWDR5FoYuTjBIiFOMPtTIXN2xXIz5g5ouGKhYMrEb4ZNf+/X60iHXmmqJGIFwhQEiwZsQXH6WgsXnbdrKF7j3nZW6Nd7wYMeRZjaku922LXmopaDFRR3tM5JdqvBAtS3Bkmff9Oe4nlnOolpD5O6z6/X2aQKGOonD8XY0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lO5gGtW0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NLrmSuPx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lO5gGtW0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NLrmSuPx"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlZmq4115069
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=n1ZvqmBecKIUfWjejUXdis
	nwel44WshaBYPprFz7jRo=; b=lO5gGtW068TJbVpCNw08m4DoqUtStf0ynRPqLi
	m6Fx9CTD9oqTyfkbUHiY2zaBBxImGhAF8934WrpWwCYMPNI2+eUvdMIfiDmLk6+S
	LTTdPpJzDRqlndXIxiiX+YmLBcJZ38hDS3Azqfc/XMpxnFbHWBoOvbsVAA8o+YWn
	Kyd5wA9e4LOSLHGSY/HvWJ7WA8BQH+zGxBDdLCeClPTxa/Nsyjd0eW+3ZXyHU0yT
	KpAPbjYK+MpgKCw1x0MfQ9xuWQ0fAstRpGwl0+wGXDQoTRYWui23JNzyms2Y7jIr
	CNidpVTj242cE5k5xSovQCkDgv1n5+GiK//pZN/xAToAxFJQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mrs3c7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:11:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca124bf0189so2533521a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785161493; x=1785766293; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n1ZvqmBecKIUfWjejUXdisnwel44WshaBYPprFz7jRo=;
        b=NLrmSuPxn73No0m93heah2dSiv7scZOTQLdyvlw6wLKiL6IoMhmySRl7aTvcyQQs0p
         2vXGnp31CB4VrUkgqOWsFAcjeFu2dW16vxujnfXdzw01wziXZfXIgaacQMkfvowqoQ20
         TLkBbXzktHqo8t5cxvvvDbirk00HO8xCFLM3Z1S+sU8NWNZCWX32o7SCTXTs6YO27x5m
         Dhe6O0MItxHqkjbt453rBw9BfoOFYrGMZimxZB/nEPZKC3Zqi8d5okV+ooLwZVVCJbAY
         W0z+aieUJ1N6nvqmIE82gd+KeO8YIVYsvaMiDuEGNBpS1wluIfBwre6LyyAtyzu8E+Tr
         YzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161493; x=1785766293;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n1ZvqmBecKIUfWjejUXdisnwel44WshaBYPprFz7jRo=;
        b=f0BVUHApQaGZUMcH1u72Da03HUkp76s2FUySUQEnXH/W8ZiR8mPp12OONZN7u74Lbd
         P7GmPAy2FNioHZwz9eM20Qun7kOf1FNKo4v8IOP+L6dWp0kV1M0Yh38PSV8zhIAs5/wp
         5T8NFKznAShBuHUqgTDKNADpu4zNMWTHWjB2PugqSuVNSHUICUadl6iR7ZQvw8Vlddxf
         H2Yhorg4/45hTIpSMeJf6Ymww2I2vyPB8eNik4PFpXvN7cvXUQzmiQkdJGuR+ZDf4V7k
         4/BwtLwuKEe0TgrsWROx9gqO8GIlDUSssV7YZKqZpSfxo4tM3gxWnLVJYibROHe5Gpgy
         M0YQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhjDhYZCX3GS3u1AYajgpVwSDscc/mcFaoBFxmBQr5Y1FI+CBwkXJHJ91Rq0K9DXM9UxLEDhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/NW8SXcy9P5XnW1frs6rSk2D58QPKgjKmKCGs6PhkawHa9LIz
	/t+GcS80SX/s2X/2q+p3ugrjMifMjDuw8I/39FPFiQkCUvENkFdvw2q2E9XnBsLjn/zPsfztAE6
	8pdfFAS6+145FjXPrTUlJ0d+SWiuKLIa3G9Yxj+IGUqZJfIdlrwA+TimT+ZU=
X-Gm-Gg: AR+sD1187Au1uR8JFHE29P1P3NUsDJ7JE0MG91FkJqNO6+NI39tjqdvCNE7vCvBFdd6
	CT/p8+AGVxMXyZm6lWz39mpkF5Cb3odlNO9vrN9wHhJ1I/YTtldMUopn16aiGj6YpYoGahDFutr
	vi8/Xe97qbO4QMcWAsWlcSfXR5N5dFmdYrn6sqNMAZ1rtVRuFxEDHcnP7m2j2wtMeofGfPSJl5j
	XRm3Dlk3B/wsWRZo8qSvF7pSGcs+akKEMtBdGsx9ucqvfhI5N0ELJ1EvuRsVa5UaynfPUkL2zIa
	nfB822ejZ13r2iDq8HijVHKbJbpP4cHD4+AiUdlPgSKiqlq7HP9njV3+xsB+gOmilvhuzWu9tUD
	XBlMTeW85idG1xCOrJEOtfHCzCePpZi4=
X-Received: by 2002:a05:6a20:9188:b0:3c3:6e84:ace8 with SMTP id adf61e73a8af0-3c67260e031mr10448012637.23.1785161493085;
        Mon, 27 Jul 2026 07:11:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:9188:b0:3c3:6e84:ace8 with SMTP id adf61e73a8af0-3c67260e031mr10447982637.23.1785161492631;
        Mon, 27 Jul 2026 07:11:32 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm53438677eec.13.2026.07.27.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:11:32 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH 0/6] Add support for Qualcomm TSCSS hardware
Date: Mon, 27 Jul 2026 19:40:56 +0530
Message-Id: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPBmZ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNT3ZLi5OJiXRMTwxQLE5Nkw9RUcyWg2oKi1LTMCrA50bG1tQDCDfz
 9VwAAAA==
X-Change-ID: 20260705-tscss-441d844c1ee7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNSBTYWx0ZWRfX4KwZRcIECueL
 EDNElrfX8+CYYEgKjlHGZkJtPb1oW3H6Yg0PXw3oBSP1t7FbaO6a9AvPCgF5B0PuHxP2N+xpjqf
 pTqrNYD6MZYOXAhzPbnYRLYZv6Fo5Wk=
X-Authority-Analysis: v=2.4 cv=UYBhjqSN c=1 sm=1 tr=0 ts=6a676716 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CuubQGV2Owguao5XfqgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: ctTp6qrhRuiqzkoogU1WYlo6-xZ0b7rF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNSBTYWx0ZWRfXwKC4FyjB1rNu
 p/Z30xbCuFc8A3PHrLW/KobyTghiQ8jD+db2J5FtQFwCUbvKwRsTNZS3ESaE3w4ZIomaiwjGoIG
 YfoOzBTHJW7UptpbKL7MGnv04FAP6E8w12Lcvv+ACfmVF6Cf4oBF9nUJeALn0EdTOg4L7X72Q9y
 WloeBpDN6k6Y/2Mv5cSejLZJX6eRW+QAi5KSnwIe8Dark8izc9z1Yl75VhgL0H9f0KPRBx+x/Fi
 w/nxAI/e/cRya3hhPJw1024KkFKMy3ZHQIAZ3RmdHRoqwmkk3iV/Q9N+hegeeNHhH+vYqEkGqWz
 K7tAbINAy9KBNFky43i844XMWslP305X5U758LFpPi5CGdHi4Tl3BZ+R3GiQ4skfVBebeUpzq1P
 AHdOmr7fVC/giI/H2Rjn5j/Ih+N5iWKqWYyUqf3giAjvwmaW/jEiY3WS2ZC1GFyKas/nNNXW7DW
 AN+cJ6NJOOhd+jjOWrQ==
X-Proofpoint-ORIG-GUID: ctTp6qrhRuiqzkoogU1WYlo6-xZ0b7rF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270135

This series introduces support for the Qualcomm Timestamp Counter Subsystem
(TSCSS) hardware, a time synchronization subsystem present on Qualcomm
Lemans, Monaco and QDU1000 SoCs.

TSCSS is composed of two main hardware blocks:
 - Timestamp Counter (TSC): a free-running hardware counter that provides
   continuous timekeeping for the SoC, and is functional with a GCC TSC AHB
   config clock and a global counter clock. The TSC counter resolution and
   supported functionalities vary across SoC variants.

 - Event Timestamp Unit (ETU): an optional block that captures TSC counter
   timestamps against external hardware events. Each ETU slice binds a
   slice identifier to an external event selector, and the ETU additionally
   requires its own clock, pinctrl along with either a per-slice interrupt
   (QDU1000) or a single summary interrupt across all ETU slices (Lemans
   and Monaco).

 +------------------------------------------------+  +------------------+
 | Global clock controller - TSC AHB/CNTR/ETU CLK |  |  EVENT_IN[0:15]  |
 +------------------------------------------------+  +------------------+
                          |                                  |
                          v                                  v
 +----------------------------------------------------------------------+
 |               Timestamp Counter Subsystem (TSCSS)                    |
 |                                                                      |
 |                   +----------------------------------------------+   |
 |  +------------+   |         Event Timestamp Unit (ETU)           |   |
 |  | Timestamp  |   |           0x01C90000-0x01C9FFFF              |   |
 |  |  Counter   |   | +------------------------------------------+ |   |
 |  |   (TSC)    |   | |               ETU Slices                 | |   |
 |  |            |   | | [Slice 0]  [Slice 1]   [...]  [Slice 15] | |   |
 |  | 0x1C80000  |   | | 0x1C90000  0x1C91000          0x1C9F000  | |   |
 |  +------------+   | |                                          | |   |
 |                   | +-----------+------------------------------+ |   |
 |                   +-------------|--------------------+-----------+   |
 |                                 |                    |               |
 +---------------------------------|--------------------|---------------+
                                   |                    |
                                   v                    v
                         +----------------------------------------+
                         |    per-slice IRQ  (OR)  summary IRQ    |
                         |      (QDU1000)            (Lemans)     |
                         +----------------------------------------+
                                             |
                                             v
                              +-----------------------------+
                              |   Interrupt Controller      |
                              +-----------------------------+

The address offsets shown in the diagram above are specific to Qualcomm
Lemans SoC.

This series currently covers only the TSC block driver functionality; ETU
driver support will follow in a later series.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
Imran Shaik (6):
      dt-bindings: ptp: Document the TSCSS on Qualcomm Lemans and Monaco SoCs
      dt-bindings: ptp: Document TSCSS hardware on Qualcomm QDU1000 SoC
      ptp: qcom: Add PTP driver for the Qualcomm TSC hardware
      arm64: defconfig: Enable Qualcomm TSC driver
      arm64: dts: qcom: lemans: Add support for TSCSS node
      arm64: dts: qcom: qdu1000: Add support for TSCSS node

 .../devicetree/bindings/ptp/qcom,lemans-tscss.yaml | 198 ++++++++++
 .../bindings/ptp/qcom,qdu1000-tscss.yaml           | 187 ++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi               |  11 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi              |  11 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/ptp/Kconfig                                |  10 +
 drivers/ptp/Makefile                               |   1 +
 drivers/ptp/ptp_qcom_tsc.c                         | 413 +++++++++++++++++++++
 8 files changed, 832 insertions(+)
---
base-commit: c5e32e86ca02b003f86e095d379b38148999293d
change-id: 20260705-tscss-441d844c1ee7

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>

