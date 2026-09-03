Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0EB33A9FF
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461648; cv=none; b=rQocs5/3kU/T/so7lReby833F76FDqKY/Sr4qExTVyZNISB/Khb3DX3y8DEghSZs+cPkNK0XLUK9c1vSdKgsG1CLHyeVH1s5T94VIpBzRBWUXCqQ565G9WhefdYtQDgpV32KIIcpxj+i+m1fAWPMZCbCt202IXBvKFG4u07K3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461648; c=relaxed/simple;
	bh=jkQki04nla6n2qSli7OU4B/MaOggI1fMv/5WEisQM20=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fEUS7sAf/QHcABwsNtnF05vo0e0YUQrINk1nu2JZYJALg6gOrLJWYvzpbJMXKdI/Vs+qHusFTSdUTuF6C/u1wVFc6/5szCZPU8jOeiCwJO49thcfKcaLPWU++xYmw8bo1+dHe/tnKeJ8P2XmJkJkmu5HXYc+mmXbaa0PAnrHjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OOUVLY6j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QQDoD37C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OOUVLY6j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QQDoD37C"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G38qp927717
	for <netdev@vger.kernel.org>; Thu, 3 Sep 2026 18:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YfIfvoK+FI2vd7dzKE6Ouv
	+LdM6/QML+2NPw7na16ZM=; b=OOUVLY6juR0atG1ZKT98zwH8K7kbnOLYTthPRH
	hUeR8qtXF7HMDhYGa7fK8YN0fgPJtGOfl0ncNqcopeU4RrTS1ebWt5h/S1fuBf2Q
	NY7tgqkOOdE7n9BJxkFSRFPn8izdUt1H2LsynnQmFa4oMBYoO2ClW6cDV45x4TTw
	qd2MNFcjJ4pnnoYsZ1SrPDXjuVkVeop062q4woV4/kzYFIDhwRLU1WHujKZfxVBW
	mHZEOCypZ8x5k6hkQNgi/6baQKTiwsmNb+G8+IbkRIv2LCoJ5prLG+0JpDY8/GWs
	3jWjkEX1q+kv8Z6snC2k02tK9Y9/0dTl5EzCe6Q2jMVAD2WA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx2bqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 18:53:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cacd6d37edso2319835ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788461637; x=1789066437; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YfIfvoK+FI2vd7dzKE6Ouv+LdM6/QML+2NPw7na16ZM=;
        b=QQDoD37CW9uhUT1+SUfkKEMTzqTbmys+vR+8MneTJ3jHz/xgxz9gh+3v6FNyt91sN0
         XMw/qV1wOHEjYPbVBW95oxzm1dnBljPrnlp9RH8KY0NS/ABgI9nnOc1r1Wqdl3xkwSUv
         czTlirhIg0hn7epz7ki6qwHkUAslkcEn1qZtb1E/xk8YhUsGug9CM2yKtYL+7lRi/wVs
         DwpSISQil7JxncNbsVuP8M+nmNwzDIr6Oo7eylFTb/05KvHJA6kzCAd3EZdc+ERSc3/Q
         1lwjijummSJLQnLgTRCy2MJdXH6ABmhuo8ukGlwTJqW6IQ/KfIZQRpznQwqLhvPAg0jm
         D37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788461637; x=1789066437;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YfIfvoK+FI2vd7dzKE6Ouv+LdM6/QML+2NPw7na16ZM=;
        b=lmOon2s6QENp3thnBIP7mhgANbdd3lxLYMnlmgU8nGSC7B19Rp93bDYVuF0tm40vRr
         pnlrArHDcryzzrCs5YQH2RjJ4yuP2S/VgacVEBuGhzLm9Aeci6YNcogKv9t+9jzmvG3e
         tNcke8271zK0iu7s1NuECUHhgVuCezMLDj9TXW8UY/c4h/ElHa+1AOt90AP/4Mi2uBvO
         2Xfq1FHvBEBPjQKgsLwDDBuOgKzxCxLsqcaKMeQcaYN4KKTZVOSUOhs3HweQ37hoJMbz
         k/A0fWc77a6z5tmGJ1b72kWrUAB24/yML4QEFT5UOQqc172u2po0f/QRVpWO3Ur5ZdFN
         0f0g==
X-Gm-Message-State: AFuF++kOAgFc0l4k17roSivf9rni+a28L0iO/c3nUnxgGw1nas0uvQQV
	hIbmyXyb4xYXmRlZEwXzCrNcREEBu+JKSUD3zsW9YrBM8OywcDCkXPCvBmfTndiwuIlkaV/8br2
	tGmanI60i5UG7rZMxUyiOMdEbqm5SL7SgDWspxKgLv1tyRUbpKE8V9wqS+Zk=
X-Gm-Gg: AYBFou0CP1ry+uSX/1OCJ8QpO2+ku8slUylfAs+UN8kyOJXlk2qsakDnbNcw0tF0VTV
	H7hRcKmzV5YhICsoTgrrE5A32Pd1Il2+6fnMkautBS3618Ja5Ih7nJND7ihC9jqUUH5Cn0dPgjC
	63ERURkjpzBY/wBwMsIJutftLkpKgMe/oSLSH4pnO3MRnvwzFQmAaJZqMBsC3uJ9BuUEYhTsXXs
	8aePrQxkPo7yowCQJc+agHp2j3LVpGd+D0JQ7HgjKRd2cVkbC8Aa7XKMRa5A67xOsFotA/i+A53
	QXMrr8cWwi2lJRHJTfw4EEF8UMryGvnI+K1tICy8mH/CKnlw85KWdQeaPFltiSjHbqw2jONzfq/
	d4H4m+HB7r2/H8ci0LcloH4W4uTrszQ==
X-Received: by 2002:a17:90a:ec8d:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-39b261002f5mr871680a91.6.1788461636433;
        Thu, 03 Sep 2026 11:53:56 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8d:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-39b261002f5mr871599a91.6.1788461635851;
        Thu, 03 Sep 2026 11:53:55 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ce1csm778829eec.4.2026.09.03.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:53:55 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Subject: [PATCH net-next 0/9] net: stmmac: qcom-ethqos: add Shikra EMAC
 support
Date: Fri, 04 Sep 2026 00:13:42 +0530
Message-Id: <20260904-shikra_ethernet-v1-0-a50765996035@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6/mWoC/x2MSwqEMBAFryK9NpDxO85VRCTq0zRClE4QQby7G
 ZcFVXWRhzA8/ZKLBAd73lyET5rQaI1boHiKTJnOKt3oXHnLq5gewUIcgjKoB6DEVxegWO2Cmc/
 32NJfcDgDdff9ACahDhNrAAAA
X-Change-ID: 20260903-shikra_ethernet-ae7bee5e804e
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788461628; l=3811;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=jkQki04nla6n2qSli7OU4B/MaOggI1fMv/5WEisQM20=;
 b=+v6PObHonz99GSWe5CJUTp4vTnsVNRrUqDxzeSCcBd55iqpEKpmYtvJpryC0nK95B/4Ukb36O
 2eXo90saUhfA0WMBEkqoiEMtjiI0FLhNEETdWF8B+Jd0c0jgxd4MZis
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-GUID: LZYLeY0e4aLMjovuSAmH7hbCgAMVtVYp
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a99c245 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=ee_2aqc6AAAA:8 a=EUspDBNiAAAA:8 a=aofnmw3WZ5OT6iA2A7UA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-ORIG-GUID: LZYLeY0e4aLMjovuSAmH7hbCgAMVtVYp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfXxVoQEQLxTGl2
 4l+AQgFKtptDss/kxb0ZqzrC9uMq+wGkG0mu4GGb+yc2k4ncWi9Y1ovtJw7aV6t8WNb9amhaVYT
 fs0iiPEvFsE8ZM8dEYVLXeObGC1rum12wxVctUZpTGKPXlntchgZb/dSllpT6566729aGZgLNJd
 j6SPmY1OVtZD4bjzH4jy3d+e4JNJ6ZJxC5jEtZTk+GWSDPmd3Np0rA8xQMmcUb0JJB2sMb349uA
 ozNRUtnP+inkq6/C+fAh6fCitg9MFSlvTmaAWA4A9BLeEVsPyAVFuF9Q9sO0yeM9iU/9a9egA4A
 jHD8ESTVyrApd6nHWvPKH5iJNabL/gRJEqKySiOuW4t8ZtJ+rLMcd9pEp32p7lGQ6z1F/AOeZQH
 03vlQ2jGFU+zrfzEbqOd28nhzHglHWpndn+irTV/Q1HrulBBSsR7J/+wYrQGL6GJ9EW56M+gDeX
 TSUH3/8lXRjDiT6kUrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX4JCBPvUaJ5D/
 O2mRhKSbx9uHATgz4w/66pcPU2K02s+CGNqnDeaEJAqt86xWdd/N/bVgzkRTpZ1I6HNr1L+Jnle
 lENheqqhnIVe00aeMHyOW+IvSDnEa9g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165

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
https://lore.kernel.org/netdev/20260605010022.968612-3-elder@riscstar.com/

2. The generic RGMII fixes from the RFC remain. As suggested, an
additional patch now emits a warning (patch 6) when the legacy "rgmii"
or "rgmii-txid" modes are detected. A new change (patch 7) now
initialises the RGMII link clock at SPEED_10 on probe instead of
SPEED_1000, dropping the unnecessary 250 MHz source before link up.

3. NOC clock voting (patch 8) now uses dev_pm_opp_set_rate() so the
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
      dt-bindings: net: ti,dp83867: add supply properties
      net: phy: dp83867: add regulator supply management
      dt-bindings: net: qcom,ethqos: add qcom,shikra-ethqos compatible
      net: stmmac: qcom-ethqos: convert ethqos_rgmii_macro_init() to void
      net: stmmac: qcom-ethqos: fix RGMII_ID mode to use DLL bypass
      net: stmmac: qcom-ethqos: warn about legacy RGMII PHY modes
      net: stmmac: qcom-ethqos: set initial RGMII link clock to lowest speed
      net: stmmac: qcom-ethqos: add per-platform NOC clock voting
      net: stmmac: qcom-ethqos: add Shikra EMAC support

 .../devicetree/bindings/net/qcom,ethqos.yaml       |  50 ++++-
 .../devicetree/bindings/net/snps,dwmac.yaml        |   2 +
 .../devicetree/bindings/net/ti,dp83867.yaml        |  14 ++
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 211 +++++++++++++++++++--
 drivers/net/phy/dp83867.c                          |  32 ++++
 5 files changed, 293 insertions(+), 16 deletions(-)
---
base-commit: 7042c8c193e5d634198b7c766bb3a01c8e3ee0e2
change-id: 20260903-shikra_ethernet-ae7bee5e804e

Best regards,
-- 
Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

