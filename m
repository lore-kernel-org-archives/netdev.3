Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014187;
	b=zp68a/mGKl6xbWKdx/SXyWvAa/HAMNcDHUc/NIvuU4YSVM5acI9QVcQYqdLzBOqmB+xL
	 mAFlWmbMOCAlULmkzMtAEPJZtWlEld0WWUQ8NYC6hJa0XlPZ5ynf+u72dsk4+EQFTyFFZ
	 F9IeWPNDalvin+yOWJR/MMbipB9RZ0k6S7cr+oG8HXSSUPz37xD6i1skNMVKxACTrSe1c
	 CFOkU7tmRUEOe4waYq/0K3MDc4wsaMqRFk4FD0UtXyZrbWj+RuD5kvy1exa0+n2ajxKEV
	 fnHZ5JlfBWmKLHdTkEJzq+aE9Bm9u6SFQZ7VPItFTW+k5RhTHc2B77rOmurbFQlbl5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014187;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=EgS7rlrHOii3FAy2HYTyjWwgaqj9VRF1aAlcU4nCDOo=;
	b=s84Ci0to6hPvwV1gZUA5U6Y6Ei48CfArqnvzgLmo/lLeXzQxCSm5xJ9UxzDdq+jQUxQk
	 aUfYcTg9LT3xYkn7/JtCX6etRElTaabLfvdzEQOx9RPw7f8wb/uPOQ0X/zn7urzZ2bGFo
	 3gMESVeiXlLTGsWVDEG+5D40BKtZgNaQK+HxYjxPK3w2znKgIhVVLuvq+vaQ2xgQJiLz3
	 u9INHIBJk8eR8CTWgjis4gdc18ctgj5oOHsBpd8DdDVvUFC321XWuH49qtzGslD1nE5nJ
	 0DzEB35VImWPFJlG6ezZlbknI1PmPSxToxDjUXo4Bwlur6V0bELgPd4n6nPdDLLq9yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=blqXwfgS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OL8R2nuA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02C6606A328
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B02C6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=blqXwfgS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OL8R2nuA
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtOhn2009966
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EgS7rlrHOii3FAy2HYTyjW
	wgaqj9VRF1aAlcU4nCDOo=; b=blqXwfgSmGPnFecDf5eHP87wbJvjRAdQpGtJ1a
	thP2nefizXcBBGF+Ai3Pr9+omWsITyfH7UY/Zm/thYcfjODphgBUuRTN/0jtPRV+
	rs0dvOkXqlj3qkUYIYMZhdD+1257xDNKpcl1WSEuRz33zqmvOlbUulfdt03fXnNX
	Vwd/VDUOu7hWiQUUwqjNyDBadqN85oHRuBHP6xzLTF2CYmWyyDSE/VBeNiQO9t11
	RlcJRwQR2tCwsikGfbeZNCWoMDWigQl5NCW0FHCvZk1OuBh+epRkOHxOnzUxGysV
	yLNDSJhm0MNsawJ0reMK0iy6l84MEasDivVcq2K6SGrCvY8g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27x4u8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:29:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab1e771632so3097665a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014184; x=1793618984; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EgS7rlrHOii3FAy2HYTyjWwgaqj9VRF1aAlcU4nCDOo=;
        b=OL8R2nuA6WGlRM+lng7TdnKvHwNY6GPt/5UGr6b1KxGU2UPrCkhpp5GInH77I6RSiL
         32dX7sDCCLQWCdOjZuE40tFGSZ16YOqsxkWaSo3+Clf809j7KMRGoOiKmP+PLqqRzWYp
         lS8CUVYaYiha37A27yl3yOZ3PAJdN36VliXX1HlKAUmqLflq3irQ/Lagx1i9/3XQiVJZ
         iSRGyawcB3febcnv0AeOP8vb/+OLwL0+fBLREqZZaPrcN434U3KY7VlMC6zqmEUP6HMO
         IudssRwDQ1qx14zRINRvPwGbCIggDDLi3Rf4WVSSWa7d6h8te6IWvJhHZv7p7Mr4L4ZO
         WDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014184; x=1793618984;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EgS7rlrHOii3FAy2HYTyjWwgaqj9VRF1aAlcU4nCDOo=;
        b=CD/XBaOotMU9j6qGyEcg/2aTyrYGUv548Dge6yko5XNgbmeAUBWwSoTKisJkqRERh3
         MgeeyPOXwBPe4P/rJcMbkbLGjMxFBjUfZhf1qnzta4Ej9tW4Sxhe7YYKsNr56m9mziQ3
         psh4UU9MCRakxM7dBGmDwoYuv01rLZFEO8YHClhO43r2z5MRAaBTJR0USOADXyl04blP
         j1CFsQw2WO7z8DEB6bRpPb9jiW4+xmH6VAiIvOeDNeyR7cgeOCUHTmeB04tp5xs8TQIf
         euVXkV/fgKjFHxjJuWxCzcLfgynDHbohJH4yWjAYKbOi26a71wRHWJ5Ol9dDdwAj1CKh
         K3MQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxe+6gQT1Vuvo0DZOWk1B7RL+htxMbocsSlt3HBzf5YSqA8EQDVLmuiesMZviDQeLvICXZyqc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ81Tgg0yEPZVyvGvX7zMQo0P993przM2kOY6vt7bZWupichUU2
	6MCtmUi2Iafx2wdB3qw79KVel4KHiUXRcKbfnUtiqZY+rVieVUff5/1nwy8sn5zQ204aW1KE/9A
	d1ZbLpvxlFkkHCGZR6IrL4m0t7fj4WN0NT4HNNKaM0fYpGVeTRFG3KUVw3Ok=
X-Gm-Gg: AYBFou3uBA7/+xJYB+yFQO6+BcFdQ4JREgOL+BxG2PrHy64E6MpAimZgyBDdd604KXT
	RqK+sQnSf4jmuDdUNveOBdwn8yVuOLzpEhRRLVlEWd/y4zMJn6iPXOJj8ssmRmr/UEAj4o18e5k
	rKd0jeH++0zlS3hreUgNBIrtgDrJzwJmro/bg3T95kv33FJoeaWik//UzVYABmb5Ek5rDL8Zag9
	t6yRxql2f1ff8z+cZOoxWTk8Cm8KztZRyNjXimi93RYmkf1if6uH+sK6VTuWI2gZ5wV5fNL32ZL
	NDj+VhwyNcc6hPWBsA1kemAydnxxbcZIToAQWTDIEtUg5kUJhBcXRrK0jc5GSausOoLeLqVN3JY
	c6m1zgVXcJrzSLQvmafRD2fA=
X-Received: by 2002:a17:90b:6c8:b0:3ad:ba54:c3d6 with SMTP id 98e67ed59e1d1-3adeb3aa756mr3576432a91.1.1793014184353;
        Mon, 26 Oct 2026 04:29:44 -0700 (PDT)
X-Received: by 2002:a17:90b:6c8:b0:3ad:ba54:c3d6 with SMTP id 98e67ed59e1d1-3adeb3aa756mr3576406a91.1.1793014183889;
        Mon, 26 Oct 2026 04:29:43 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:29:43 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH v2 00/12] clk: qcom: Add PDM GP_MN fractional clock divider
 driver and DT support
Date: Mon, 26 Oct 2026 16:59:26 +0530
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAJY532oC/x3MQQqAIBBA0avErBNKQ7CrRIiNUw2ViUIE0d2Tl
 m/x/wOZElOGvnog0cWZz1Ag6wpwdWEhwb4YZCN127RKTJ2I/rC4b3aJ9gjeXlIYo5TRM2p0CCW
 NiWa+/+0wvu8HpzBdEGYAAAA=
X-Change-ID: 20261013-b4-pdm_clk_gp_mnd_v2-993396fc6cac
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adf39a9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6Szwu85aThXN4zbkuBwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: j-gFx7uLIAbsKCiQMilb9IhRI2RURdsl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX5atutfl2ZZMo
 IfBOEFNP3RyfUvcYGRo6ftMiM34FWpfztpfqXFOFQLStX/CIJP9WfElXDPYrx0v8BPRRMZDy0CR
 3GHpxSlx9WqDQq9WKI2rlAQviWnwdis=
X-Proofpoint-GUID: j-gFx7uLIAbsKCiQMilb9IhRI2RURdsl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX0zLWYMSF3qGc
 11GTdC+rkPju/gmqrQOKg8FamzlrVUDz/gmDh1fytI7fU/IaGnV8xPD3GcN7A4utMJ0wa40AFwl
 f/Bk2CbjcAaHjJMg5CGwK6vSa75Sa4pUot4pcsQkCPs0vpeSow4jzn+MKgBAXC6KoQ8L1M0M6rx
 3mS5x0PlxmAQ0BPZt7fbcV4VBZE+hIQdFXQ6S5ds57eDl1gfWoRB2dEL4Bp+PQ/8sVyhGBw8Ybm
 dmut8huON7ZR2iRmIGHAH8EzXmdVQXOl4AShwqXtgUD0E0vVHMK3ZDhCCmgHAVhsrsSVHbuVRU0
 dX0o35aMXlbPonNc/diZBWemP2Qv+lVOjUc/nABLJgsMEjDQzfNqVDuQ/ANClpXId+g9YN69JYG
 7YKVV2qzRYyvlgIcR4F3Sd098KV0WFwLetx4OQ5Oaa9bdOT6GaFjMvS28uc8QjGiSCsnCIxYh4f
 BvKRafCkE5q4e6v9EHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260045

The Peripheral Web PDM block on several Qualcomm SoCs contains a GP_MN
fractional divider that generates a clock output from the PDM XO4 clock.
The output can be routed to a dedicated GPIO pin for use as an external
reference clock.

This series adds the binding, a runtime PM-aware GP_MN divider driver,
and the GCC, pinctrl, and DT support needed on QCS615, QCS8300, SA8775P,
and SC7280. GP_MN controller nodes are disabled by default so boards must
explicitly opt in before the output pin is muxed.

Changes in v2:
- Add SoC-specific compatible strings with a qcom,sc7280-gp-mnd
  fallback, map the 0x1000-byte register region, and document the PDM
  source rates. [#Konrad Dybcio]
- Use runtime PM and pm_clk for AHB register-access clock management,
  rely on the pinctrl core's default-state selection, and generate the
  output-clock name. [#Dmitry Baryshkov]
- Enforce valid GP_MN duty-cycle constraints and report high-phase duty
  cycles through the common clock framework.
- Add and register configurable PDM XO4 divider clocks and their public
  IDs for all supported SoCs, allowing the source rate to be configured.
- Split the pinctrl changes by SoC, retain Reviewed-by tags, and combine
  each SoC's pin state and controller node into one DTS patch.
  [#Konrad Dybcio]
- Correct the SC7280 output to gpio60 and disable every GP_MN controller
  node by default. Add QCS615 support as well. [#Luca Weiss]
- Link[v1]: https://lore.kernel.org/lkml/20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com/

The series is organized as follows:

  1. DT binding for the PDM GP_MN divider
  2. GCC PDM XO4 divider clock IDs
  3. PDM GP_MN divider driver
  4. GCC PDM XO4 divider clocks
  5-8. GP_MN pin mux support for QCS8300, SA8775P, SC7280, and QCS615
  9-12. GP_MN DT support for QCS8300, SA8775P, SC7280, and QCS615

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Taniya Das (12):
      dt-bindings: clock: qcom: Add bindings for PDM GP_MN clock divider
      dt-bindings: clock: qcom: Add PDM XO4 divider clock IDs
      clk: qcom: Add a driver for PDM GP_MN fractional clock divider
      clk: qcom: gcc: Add configurable PDM XO4 div clocks across targets
      pinctrl: qcom: qcs8300: Add gp_mn mux function
      pinctrl: qcom: sa8775p: Add gp_mn mux function
      pinctrl: qcom: sc7280: Add gp_mn mux function
      pinctrl: qcom: qcs615: Add gp_mn mux function
      arm64: dts: qcom: qcs8300: Add GP M/N clock controller
      arm64: dts: qcom: sa8775p: Add GP M/N clock controller
      arm64: dts: qcom: sc7280: Add GP M/N clock controller
      arm64: dts: qcom: qcs615: Add GP M/N clock controller

 .../devicetree/bindings/clock/qcom,clk-gp-mnd.yaml |  98 ++++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  21 ++
 arch/arm64/boot/dts/qcom/lemans.dtsi               |  21 ++
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  21 ++
 arch/arm64/boot/dts/qcom/talos.dtsi                |  21 ++
 drivers/clk/qcom/Kconfig                           |  15 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-gp-mnd.c                      | 333 +++++++++++++++++++++
 drivers/clk/qcom/gcc-qcs615.c                      |  20 ++
 drivers/clk/qcom/gcc-qcs8300.c                     |  20 ++
 drivers/clk/qcom/gcc-sa8775p.c                     |  20 ++
 drivers/clk/qcom/gcc-sc7280.c                      |  20 ++
 drivers/pinctrl/qcom/pinctrl-qcs615.c              |   8 +-
 drivers/pinctrl/qcom/pinctrl-qcs8300.c             |   9 +-
 drivers/pinctrl/qcom/pinctrl-sa8775p.c             |   8 +-
 drivers/pinctrl/qcom/pinctrl-sc7280.c              |   8 +-
 include/dt-bindings/clock/qcom,gcc-sc7280.h        |   1 +
 include/dt-bindings/clock/qcom,qcs615-gcc.h        |   2 +
 include/dt-bindings/clock/qcom,qcs8300-gcc.h       |   1 +
 include/dt-bindings/clock/qcom,sa8775p-gcc.h       |   1 +
 20 files changed, 645 insertions(+), 4 deletions(-)
---
base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
change-id: 20261013-b4-pdm_clk_gp_mnd_v2-993396fc6cac

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>

