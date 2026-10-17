Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80847A87A
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230341; cv=none; b=GuXdTLvnX2m42iNl36ulc5Lxs7WhnX2+8sBZn7a9n3YmWsr3gqkiuH9m6/yK3Phb4P0U0dxC5jg/2Vnb0tkVQJ9H6lQaKdEYC0jJKFAM5ZtROSs+MokYfof9cPpy7j7nQTPsiIhVfgXrR5tdxBoAyQjGa5DuohdMhY6X0+tnUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230341; c=relaxed/simple;
	bh=IYXfTVPMCK/el0CMUANPRO8OaG4Oym+gcs0IAqN8PEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gvBKqAIU8Tm24X+NWpyb5ipQljx9YpUD6gYw0rE4gAvOCYirGivKDopZ/nhmNVmXqf7yWXd52RnrJ84duMC1KvnX3eGgv2nMCMq3w+6PbDsu0Xcw28C++W+JtWo+pY9sC0FzSErgXTIrCzCHRZLTQWAKufJPdmVfKK1UYPnbrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J7Bbt3X2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CttGRT6n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J7Bbt3X2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CttGRT6n"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6o2F04002854
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XMZcfz/11DnDHLN5NSRKwY
	jq0JKQ8gstJmfqFEICHQ0=; b=J7Bbt3X2LT9eYAy3C3H4CKUnK/KXG0ARnRqhbv
	DQ5QLIJ/y5x7/sniek3WAP9y+SBY8a78JAPBFcnGWLtVAuKBDKnfSd/HBweSEtz0
	UGoBQle51wScUN7pcRtresLvxTU/AdQUPHlqjlLcNjN+93JhKPTCBJPLr38+mqcr
	GjpuqczOD1XkhibkFA90XbC9/wre29B2QX/w2uXw/KIWEOYKVLORIQ71EuVGu1Si
	sSCJnhFgisbgyMnsEDKd4m/xm9YxaPQXCqC4C+WoBJXDonUCXEdbAQroN4tEifc3
	+vKsPREHgG19SZ/zUsrzDa93BiMd1lsoKJmOQC5m6eVQRPzA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc1se0hx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:45:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c5aef2a74so4348203eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792230334; x=1792835134; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XMZcfz/11DnDHLN5NSRKwYjq0JKQ8gstJmfqFEICHQ0=;
        b=CttGRT6nvRVqTV0ldnqiPZSvbeeowIaJC5n3PqHRrFVZM7km+3Uf/7DZK9N2bbrlrZ
         VobkMTkB7U/k6rZNVsSO2iNvsCztQ5iX9dgXcDd0r/2y0JTEfVLa4/TvJ0GSpq1CT35N
         fDZlFPw5ff259yixnFqmEQpHCqn+Z4VyFVCuudcEZhjlzBUmAtOQUYW2d/+9zoDpeIyo
         DW6hLa/e3mjrg/fxM05ZzuOB4AAhzZJ3zu3dLKJPy2YiPCov/gd7r4F56fP4lw9vTaXO
         s4XQvfJfqKiBWpCurr4QGDunBzk/rodmMulIZGsLXBkDvFA2omGElmHuRLj65bhFmNSa
         4KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792230334; x=1792835134;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XMZcfz/11DnDHLN5NSRKwYjq0JKQ8gstJmfqFEICHQ0=;
        b=RsEjcM+ADmdynZKTbIkIVIRUPnbLSQslnqcfRuqHmYpO2WRwU1H7jyPfNQql5IwOTR
         jBe+Fu1OeEaUqQRLY/JzVAfEbJJn0+EPt0XTvnyONdr45p7kID1jE+kYuBy7l21Kv6E6
         KhgtZbGCFc8kLdTbSmql+xK6mK8yZyX3sFNe4jK53ZDNvvr5nyz669tnxL7oyLPhC+i0
         fSsERwCWkc5cF2u5Dm/z9MD5pslrtX5cxjHw/JJDHhru/g9wWXAYjc+5Q6SZBd7x0PDH
         ud5QjKSkxy8swAtZHQn/MF8T9Dl8bkOMff2/hAKuiAjWkIFoO1o9yKwxnylrtaMbRMcC
         n9rg==
X-Gm-Message-State: AFq9FYJhq/O5S1hqTUl2njmpiE9mwaQHEGMLgulG53xOeKd0jwwVXr+2
	fDQ+4cjwCkWnxa5LnLkNdRbBcHvOGogl2f0L7bKur3pt7H0EiiLrs/HjAeAuzuu1OVjPN9XqWZs
	gKy2Tl2tOWjYo8yubt2dVzxRRKZRjjbWCm9yZ8XMuQ6hAcKEKMUQ+kyMKEak=
X-Gm-Gg: AYBFou0Mjn4CC20p+Gy/PRS/ys7CES3i5iF5wlQ6nyXGaoxTaFyJyTj4Ri+fmHiT1JS
	LZ7BqTKJctHjdgwg2uSTaH5/yCUyryznhHGJ+v5fiBQ/bntr3ECV+zY8YAPOFEeI2KcJkeN5B3H
	4P+jygXp1KJF49m35Tud0VRyNMZk2PwUADxMin2ujPsa4QWvw9zjVTikppTskx7e4VBquhrHxXh
	pHMpuB4FW1Ai3jZw8d31h+aef0ezMMHWZXaEUR2anl+pBjWt/ff/MygK4c7RBSgj1Yer4qz4p32
	/ZJutZs4Bs2Hyw93vaLb1Gp9CaZdhQShiWd43fnB/Qf9If9ZgkUUttWuUnhhJ3SsvwH0HTB2u9q
	FA+CVVFpZ4k9KmKmMtVM0okBWoa1hKQ==
X-Received: by 2002:a05:7022:ea44:b0:181:83c:5df8 with SMTP id a92af1059eb24-1851238b3e7mr3256404c88.11.1792230334199;
        Sat, 17 Oct 2026 02:45:34 -0700 (PDT)
X-Received: by 2002:a05:7022:ea44:b0:181:83c:5df8 with SMTP id a92af1059eb24-1851238b3e7mr3256364c88.11.1792230333493;
        Sat, 17 Oct 2026 02:45:33 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm19450327c88.11.2026.10.17.02.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 02:45:32 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Subject: [PATCH net-next v3 0/9] net: stmmac: qcom-ethqos: add Shikra EMAC
 support
Date: Sat, 17 Oct 2026 15:15:11 +0530
Message-Id: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdD02oC/23NQQ7CIBAF0KsY1tJQKLR15T2MMbQdhWhBAUlN0
 7uLxIVJ3Uzy82fezMiD0+DRbjMjB1F7bU0KbLtBvZLmAlgPKSNKqCAtYdgrfXXyBEGBMxCwhLo
 D4NCQClC6ujs46ymLB/RZMDAFdEyN0j5Y98qvYpn7r1qt1FhigiUnteBtKwjje+t98XjKW2/Hs
 Ugjk5H+Ms2aoYnpOmCsaQciOP3DLMvyBuIZ4qoGAQAA
X-Change-ID: 20260903-shikra_ethernet-ae7bee5e804e
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792230324; l=5696;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=IYXfTVPMCK/el0CMUANPRO8OaG4Oym+gcs0IAqN8PEE=;
 b=ioR6csnsJjP5p1t3JOpR3QmMOEtM7iEG5xSslMTKkeP1bLZ2CK60dEg9coNaeJ0xD92rmPXMv
 Bsujezmf7QABhibFvmlczlo6A6SR9z8A0OYYj6Z1ef5kUZQ2Q9TPvMB
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-ORIG-GUID: o5FPjZ812PVxiSJ4KXAJp1CfFwpzsugI
X-Authority-Analysis: v=2.4 cv=A4z5rKWG c=1 sm=1 tr=0 ts=6ad343bf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=ee_2aqc6AAAA:8 a=EUspDBNiAAAA:8 a=oTwP7VKmK1vJnwN5z0oA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: o5FPjZ812PVxiSJ4KXAJp1CfFwpzsugI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzOCBTYWx0ZWRfX1GIcNJrnuaRI
 +JM/RCS2LtBDYC8d5dY1opH4uXuiN7zGaaxkJhsVwChlbppaYxQsU3nLqvHE4zNaitC6QAyouCa
 0q2+LXjZSL34UuXDjzPCAKbCI0hef04=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzOCBTYWx0ZWRfX0IB7WxcfcjhJ
 QYdNBoSKhqVdkqIB8dHZ5wJ6wlRlu+h+DAv9Hy234+QQJDes3lbyhT4FYs5++HJFqtb6m99Ggj0
 8y+NH/sPXLhhFMjzAlZCZdCsvLJKZ1270AKwddispDnw9x2+a5c4T2rQ5NTfvwghzh5gxJNnMrM
 YLdVFfqjy+6OpgDAWjFfQWNDge8dAlKE078AH0qg5gwiIURqK/xpSmWOkGis68xAjx58Q0yPWez
 8bDWWSZrHTthx/WJUyZlBdTnKevUhUvAwSwxdLPAIilEhht/cDx24CHURgeXDKDHIB+YVRLViTT
 I3yArUCAbkKcn81q7Adv5y1YQPom0DjMF75eHhRi/7yODWi7rVleG51M2RWq7qHZ9fdKQK8dChr
 /HCUOhP/cz2tW1XhYCrR9TsDtPk6MWF1N7YHWj5l+uFFQ0anL7nlDJqLaWRIjsrxmZBE/qZXOQV
 tFcDEO81zSwa9FfH4wQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170038

This series incorporates feedback from the RFC and adds the dt-bindings
and driver changes required to enable Gigabit Ethernet support on the
Qualcomm Shikra SoC. DTS changes will be sent out separately.

The series has grown from the RFC and can be broadly divided into three
areas: PHY power supply management, proper support for RGMII ID mode in
the Qualcomm ETHQOS driver, and Shikra specific clock dependencies
required for NOC access.

1. Shikra EVK boards use a GPIO-gated regulator for the DP83867 PHY
power supply. Patches 1 and 2 add supply management to the DP83867
driver so the PHY driver holds the regulator vote at probe. These
changes are largely inspired by similar work done for the QCA8081 PHY:
https://lore.kernel.org/netdev/20261015143849.483339-1-elder@riscstar.com/

2. The generic RGMII fixes from the RFC remain. As suggested, an
additional patch now emits a warning (patch 6) when the legacy "rgmii"
or "rgmii-txid" modes are detected. A new change (patch 7) now
initialises the RGMII link clock at SPEED_10 on probe instead of
SPEED_1000, dropping the unnecessary 250 MHz source before link up.

3. NOC clock voting (patch 9) now uses dev_pm_opp_set_opp() so the
required VDD_CX performance state can be propagated through the clock
controller. The Shikra binding (patch 3) is updated accordingly: an
if/else block constrains Shikra to exactly six clocks and requires
operating-points-v2.

Testing:
The following boards have been tested with this new (proper) handling
for RGMII ID:
  - Shikra CQ/IQ variants (with the TI DP83867 PHY)
  - QCS615 Ride (with the Micrel KSZ9031 PHY)
  - Talos EVK (again with the Micrel KSZ9031 PHY)
  - Talos Lyra EVK (TI DP83867 PHY, this board also has a GPIO-gated
    regulator for the PHY power supply)

Changes in v3:
 - Remove #ifdef CONFIG_OF from the dp83867_power_on() function. This is
   a result of the recent discussion regarding similar handling in the
   qca808x driver:
   https://lore.kernel.org/netdev/atCSWZQAyqvz62_K@aspen.lan/
 - Clean up the -ENODEV handling in dp83867_power_on() and use a boolean
   to identify if supplies are provided -- Lorenzo.
 - Patch 7's commit message now says set_clk_tx_rate instead of
   fix_mac_speed -- Sashiko.
 - Add a new patch to abstract away the common dwma4_addrs for different
   versions of ethqos rather than duplicating them -- Lorenzo.
 - Use OPP table to set both the required clock rates and power state,
   update ethqos bindings accordingly to specify how the clock rates are
   described in DTS -- Konrad, Lorenzo.
 - Link to v2: https://lore.kernel.org/r/20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com

Changes in v2:
  - Collected Maxime's Reviewed-by tags.
  - Updated Patch 9's commit message to explain the double enable vote
    on the "stmmaceth" clock. Open to discussion on how best to handle
    this.
  - Wrapped regulator vote for dp83867 inside an #ifdef CONFIG_OF check
    to avoid adding an unnecessary 200 ms delay on systems where
    devm_regulator_get_enable_optional() would return 0. The change now
    mirrors the QCA8081 patch -- Sashiko.
  - Fixed ethqos_set_clk_tx_rate() to double the rate for all PHY modes
    other than RGMII-ID -- Sashiko.
  - Moved warning about the use of non RGMII-ID mode to probe instead
    of fix_mac_speed to avoid spamming during each link up event --
    Sashiko.
  - Fixed error unwind drops OPP before stopping link_clk -- Sashiko.
  - Fixed OPP vote set in probe not cleaned up on error -- Sashiko.
  - Link to v1: https://lore.kernel.org/netdev/20260904-shikra_ethernet-v1-0-a50765996035@oss.qualcomm.com/#t

Changes since RFC:
  - Two new patches add supply management for the DP83867, replacing
    the gpio-hog approach for PHY power -- Konrad, Andrew.
  - Use dev_pm_opp_set_rate() for the NOC AXI clock and require
    operating-points-v2 for Shikra -- Konrad.
  - Warn on legacy "rgmii"/"rgmii-txid" to encourage DTB migration --
    Andrew, Maxime.
  - Updated binding document for qcom,ethqos and snps,dwmac.
  - Drop the duplicate "axi" clock from Shikra's DT; use "axi-noc" and
    "pcie-tile-axi-noc" as the only additional clock-names.
  - Initialise RGMII link clock at SPEED_10 rather than SPEED_1000 on
    probe.
  - Link to RFC: https://lore.kernel.org/netdev/20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com/

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
Mohd Ayaan Anwar (9):
      net: phy: dp83867: add regulator supply management
      dt-bindings: net: qcom,ethqos: add qcom,shikra-ethqos compatible
      net: stmmac: qcom-ethqos: convert ethqos_rgmii_macro_init() to void
      net: stmmac: qcom-ethqos: fix RGMII_ID mode to use DLL bypass
      net: stmmac: qcom-ethqos: warn about legacy RGMII PHY modes
      net: stmmac: qcom-ethqos: set initial RGMII link clock to lowest speed
      net: stmmac: qcom-ethqos: share common GMAC4 address table
      net: stmmac: qcom-ethqos: add per-platform NOC clock voting
      net: stmmac: qcom-ethqos: add Shikra EMAC support

 .../devicetree/bindings/net/qcom,ethqos.yaml       |  55 ++++-
 .../devicetree/bindings/net/snps,dwmac.yaml        |   2 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   1 +
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 259 +++++++++++++++++----
 drivers/net/phy/dp83867.c                          |  32 +++
 5 files changed, 297 insertions(+), 52 deletions(-)
---
base-commit: 8b71f1f5a28347cefb1a4711c4eeb492d5c619fb
change-id: 20260903-shikra_ethernet-ae7bee5e804e

Best regards,
-- 
Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

