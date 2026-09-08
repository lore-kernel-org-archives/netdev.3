Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515A378D8E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848626; cv=none; b=XObB/3wa9+iWpZMG/GAusfcIhl8aROHD9E7DQBpDuVqF6o3AY7ADkMZjkYa7nSTGmmvIFvUus/dtbVvTyRrEUqsv+GxSGnGiWMJWXKtkekPOjkLL/vCw7PozQPQkEhsstq6Mf0H1sefRBDFGT8OTFcwiaX0Sr6EacHEU/QAsZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848626; c=relaxed/simple;
	bh=9gpvYZiiK++7fxFQKJTx+k6/ozmAgJ952XedouNhT/o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LFIT/UXrob0JS84BXnt3H5O3gCxbWBwVqz2LPamCARkD/uSQl7gderxsZ5lXNgnUNPVm7XfRvoPRB0a9xW73fwosw9Ovw6mPKqD00Ev9vbdA35f2IYOZLWB0k8qw3ZQaesq+3NBKAeB1epWhGrlbKwtHoUM+Q3WyndIhx++RTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o0HMIsTW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JVOeiEcD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o0HMIsTW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JVOeiEcD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886MBOx1521769
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 06:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5LkBz/6+6EbGMarTpjWjMr
	IiSvDbCV1mNMUZslHPIt0=; b=o0HMIsTWgg/AOpgaCl4VuHQB/5sa833g4xyNVa
	prCMDlvSRJi6jgZ+9peM1zoFVbhv2W8NSjh6DGYQQjkNvyrB08fCzGbM5WUXrD9y
	HiREqBAC6d83XM4u4Oq3QFTd9JOq8O83uBW2XAuni/Qb5EewsEsFhkLfn55L5dMA
	ZzOOQVgHG0IfBMccPLa2PC5gwG72S8R3Tg2q7Kgmmh33cYw+AYqmhpq/k7K5HR4r
	XY2cO1KKstv4baq+CtLhFqDpZvOpYy/xuhv2NSsG4oYYMRQahxfyQoFMft+MfjA/
	b7UfiNJtj6SwYHhTUJwTbhJ2GkFAVGFT3wAoTX0uzLapsY+Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj077j8yf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 06:23:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1a439db36so4228030a12.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 23:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788848623; x=1789453423; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5LkBz/6+6EbGMarTpjWjMrIiSvDbCV1mNMUZslHPIt0=;
        b=JVOeiEcD3/zSNbNl7uYA9gyz5J35B/MR6HpFiPU79hEZonwpdkVZaVJmp51zlpqfY+
         867PhQ2l/NxdK+dKa93ssa8YklCKIrhxzp/DoQfJf4F8Cj9sirPP/iT4kBi1bTBOlRBf
         DCT+QTeR8YLAuvEvCFY3qDnGMQ8aomBIT3VcU/4Tx+54MOOJ8yZpEqGQOxJpFnUpdspC
         509cg7Rvz+WZJgRUmc+CB9IInZUkTscKRbiYKK6z2ikbM2CQW71pTEAILPeCIDp9AKvD
         +wVKah9ALzgrsbZgpAex6m5yFk43arxbu9xndEop8VxpqKYCAYxFR9RPqKgRHfSEeOHp
         cgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848623; x=1789453423;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5LkBz/6+6EbGMarTpjWjMrIiSvDbCV1mNMUZslHPIt0=;
        b=YuCmoBF8LZTO2hpwDJp5RCGiEhUtKyJGGOrg2nT2SVhVxjVKhhC2brYhb35pfhyE+L
         q0y47osd3bslVKJWy/l3Wc9cumXOz6STkN2lIhiwnbF2pN9h570HLdyubrgRlNV92OQr
         XmFJYQ4C+ST8RmBlCWfEzhHYQl8LcRQR1KUvcb+c7KRCxt4TwJVczI53DAj5LTR3X3IF
         Yl1ZWiSDjYug2WpHnN/Ted/9hQ7QQOXgzf8KLYgxDYu5LShCzQghJ0HiZ7NDaIzzE3pZ
         jcSbZkFGx2XybSA1FijkmTvKGrRJc0EdQFGSr9pTXPpKw/YtURMvPhndNGon7PvmHahb
         swpA==
X-Forwarded-Encrypted: i=1; AKwUvBzvxpH24KiDDDQv2wi0tPbQeQdzERbopy53ykSKfW+hpneFxj1YMGG0SwyDxcLIrHj7pAXFyb0=@vger.kernel.org
X-Gm-Message-State: AFuF++lqyfcPesQz7z28Bry/nAEx7FZeCs3WinBceXDMqNbaLw/xNVbY
	rnitGDvguaX6kUzp/AFGAsauUsiUzxdOOXky3mw0I6NE73F16Hm1lT+z9ZfIySfg4B7R27HDKxP
	/2BH3LlIEqPcPN0ppsynCVak30TIymuVdcVTLkL2a/iv6tJz/i2immXu/HIf0R7Q6Xb4=
X-Gm-Gg: AYBFou3s2f7rzTjRMVFdXjB7FDR7igO4Aq6r/RUwjHQsh37nGKydrVfovxb/cajaEk8
	0Zk8df4XM+06s2RsMFznYtkDOX2vEPRiyRhl8gu1wbp3FUCzmiRQJ0Kt3KxB5G+tlMs7NJjX7So
	8L2x6VQGhdYclU+g7J80Ge3FZycgNfkd5KcqgOAIp1wQJEOlzPeqe/VacLf81GZbldF0ArkLd5E
	URXEeEu4US0h0egTrO3cc9dCO+Ta9VHHTmJ82gIUh1/7X+XQSkT71IHcCVHlpOB0sU/SB1b0Eh5
	TX8DgNb5Nfe67WDSDVnq3JGRfJSCemhINOh2DldJgjmqB09ZoGKD1CXAt3ItWwkHA+JIwRjEC+A
	kWk0T06+rikfk+UzIOX66Wc1nf/EOWg==
X-Received: by 2002:a05:6a20:e607:b0:3d3:ae51:181e with SMTP id adf61e73a8af0-3da3a16ab56mr42582289637.26.1788848622866;
        Mon, 07 Sep 2026 23:23:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:e607:b0:3d3:ae51:181e with SMTP id adf61e73a8af0-3da3a16ab56mr42582205637.26.1788848622316;
        Mon, 07 Sep 2026 23:23:42 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm26266297c88.8.2026.09.07.23.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:23:41 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Subject: [PATCH PRELIMINARY 0/5] arm64: dts: qcom: shikra: add Ethernet
 support
Date: Tue, 08 Sep 2026 11:53:29 +0530
Message-Id: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOGpn2oC/13NzWrDMBAE4Fcxe65gLTmW5FsPOQTaUnIrIQRJn
 saixGklNRRC3j3ODzn0OMzsfkfKSBGZuupICYeY436cQv1UURjcuIWI/ZRJsmzZshF5iF/JbVA
 GpBFl05csmLWGaXRvLdN0+Z3wGf+uX1f0vpy/LF4Xb8/LD1rfyoSf30kq98UD6qo7o/4zwkF7Y
 AbDDbqDvCjeZYiw3+1i6SrNjQwm1FZh1reqqa3xOui29V45roOBAhiS1qfTGfdTAav1AAAA
X-Change-ID: 20260908-shikra_ethernet_dts-0077e847d990
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848616; l=2801;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=9gpvYZiiK++7fxFQKJTx+k6/ozmAgJ952XedouNhT/o=;
 b=BWNdle9xwzgMQXU+Fng3OrQQKVZCffhPMemmrtLubzjbmjkz1Qo9DHZLLqp+1B7NDbw1dJ/c6
 Feg3lLCRwFQAYAmzRzDFnUFWV/RhMGTbsx0iWkLz4EqTDUTslssilHA
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA2OCBTYWx0ZWRfX4K0D1C1uBgjn
 Uv+2Ycu2zZaINs+aGo9C+NNfRA5L6R3gSNT/NdRq2rDfLNahW60TrMbMAlIW3aMGvsMdopNJz9J
 Bd1TFY8IOtGXT5aqnZJ4IgOEQ0hsWa2dKjaONKN7dtD5UJ1uSjaWCLseu04wZ1ov/kTsxTrqKAA
 I5nmrYk5vqoe83RJe1aHuLbsdx0buI7vRIht17s7LyWOpZT3Guw8X/Kg9Y5annbMvKqKkV9e2SI
 Fc/EXL1FXmWa3JdkSQG/RktiO1n2n+8FKqbDzzOquovMx4RsEE/UGAOoEHGP3NA6JiPRXlpHRbB
 jvO82SnT/+CrmO7EcDhSFAEhtyevIE6OUyqmquD14bNUq/BsJ5YyDhDiJPKfK/XlU/MN7UmKJHT
 dmNX377QyhlA3ehfke0rPcfXmm2WpSfA07728KdyJccl/Lz6riCUkOynjpjPK9TJ0XbAJT7vf/N
 llPbHDyvg6/izL7zwtQ==
X-Authority-Analysis: v=2.4 cv=Xbe5Co55 c=1 sm=1 tr=0 ts=6a9fa9f0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EtmUyxdyGpvgt5L2qVsA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: ja2DDKmTSXTLkqyvaASbneQfEuzi7k2m
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA2OCBTYWx0ZWRfXy3lO/RcX42F6
 XgRSoK752dPF7a56ySaGtHcqEY5UtQLdjwZ76DvO/Z/21pGbN4/QeJqATmXM/fWISFNKxC/oxNa
 1pdxNQmUsZLGFamHPetQ6w/adLc+5lE=
X-Proofpoint-GUID: ja2DDKmTSXTLkqyvaASbneQfEuzi7k2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080068

Hi,

This preliminary series adds the DTS changes required to enable
Ethernet on the Qualcomm Shikra CQM, CQS, and IQS EVKs.

It adds the two Shikra EMAC controller nodes, enables the first
Ethernet port on the CQM and CQS EVKs, enables both ports on the IQS
EVK, describes the DP83867 PHYs and their GPIO-controlled 2.5 V
supplies, and fixes an incorrect GPIO reservation on the IQS SoM.

This series is functionally dependent on the driver and binding changes
posted here:

https://lore.kernel.org/netdev/20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com/

I am hoping that a preliminary DTS series makes the review of the
driver, dt-bindings, and board-description changes easier.

Changes since RFC:
  - Model the PHY supplies as fixed regulators controlled by the PHY
    driver -- Konrad, Andrew.
  - Add the IQS GPIO reservation fix as the first patch -- Krzysztof.
  - Move the Ethernet pinctrl default states to shikra.dtsi -- Konrad.
  - Resolve property-ordering issues and add missing final newlines --
    Konrad.
  - Link to RFC: https://lore.kernel.org/netdev/20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com/

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
Mohd Ayaan Anwar (5):
      arm64: dts: qcom: shikra-iqs-som: fix GPIO138 reservation
      arm64: dts: qcom: shikra: add ethernet nodes
      arm64: dts: qcom: shikra-cqm-evk: enable the first Ethernet port
      arm64: dts: qcom: shikra-cqs-evk: enable the first Ethernet port
      arm64: dts: qcom: shikra-iqs-evk: enable both Ethernet ports

 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts  |  46 +++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts  |  46 +++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts  |  90 +++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi |   2 +-
 arch/arm64/boot/dts/qcom/shikra.dtsi         | 266 +++++++++++++++++++++++++++
 5 files changed, 449 insertions(+), 1 deletion(-)
---
base-commit: 7042c8c193e5d634198b7c766bb3a01c8e3ee0e2
change-id: 20260908-shikra_ethernet_dts-0077e847d990
prerequisite-change-id: 20260903-shikra_ethernet-ae7bee5e804e:v2
prerequisite-patch-id: 218773849d643c66166408f849566323f3d466c2
prerequisite-patch-id: 8973e6e7fa7b09e09705913a37035c1bff8ad385
prerequisite-patch-id: 6686a8aef5f4f729892d0b3ce2e75816fe874f82
prerequisite-patch-id: 2ba77f9b01c8bf2f22589361e005805c28353f6e
prerequisite-patch-id: bf25cc81677cccb0740f26a4fb3ed8fdd2e240d8
prerequisite-patch-id: 5333cc3ebc07361084298168344d230b234e8795
prerequisite-patch-id: c1ef6e429b44f3227554e8c50cc2dc9baaa54cb7
prerequisite-patch-id: 0b2817da8c502234bf2867f9985f488389c519fa
prerequisite-patch-id: f5716827eca798a78fea6a40b3097e52c14c1e81

Best regards,
-- 
Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

