Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A46331A65
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125688; cv=none; b=jBpP+rOVwOJ4kwbklewS2n3ylo3Put4si4ok2OS6abZnqOFfPVaho8II7Y3seyzvo5BSGHan+OYy18UT2PuEaZwtgjp8LwasNQ0cjjjGROAYSJAa4nZDO3+0fZy2odDQ46Bo/Xg0sBsGoV3EHndlKcuDviKBpLNZhbBcoGzTVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125688; c=relaxed/simple;
	bh=Ci4TmBLiMpoXjBSFDZQyPnrK6xcPv6skVJDuumYU+gw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mHhPoC+3m+Nl7gWcPUJqarxZLrEzxwm2Fx6wFsuF66M24t3kmCcRe0mZQrZH8ssUJJ6KE1w4Tg+J1OeHcP6ls3CfWQHw+vGG8aPqoVYIIb/OI856fvIyu0cs1gia7JrBVl+eXwUAAhZuPAihd0Aweijb54xnIwG0WNJGGksltWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oy8ScgO8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PNH4gGlU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oy8ScgO8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PNH4gGlU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MN7rD51402064
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JGoyxRWmZCHMD3A/caoBoH
	DEKS871mDH4i6spaluJNo=; b=oy8ScgO8WcSKr7Nrz2gJkgQjzkDZz2WAwAHe3C
	ZSZ3MK0hlGGv7en1LCLhos7eKPog43BQLwYnlYwrf8R6AXfxa+toIGrNukXRnI9t
	Cbs7vCaPQSeTgNo8EtoYbZp7QxCvghiVcw3uOy+z9yYc5KI6l1+X80U3hgaU9MOD
	2xZrLsxH/WfCZPgyyiaPbVEsFLcH9TxEWwsp0kI6Bt1VEdUdXojEFUy/l+TJD2RV
	4+DeFkbktcGYhAh5i+CJEAyrX3SMC5/t/WlqxOjq9ewE6FhTYwyTz9lm3OEbqj8R
	RIbnYLyzPm+VOQ2WzpGIq/JF2c2lnvM47awYOTCUEbz8vA5A==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv3318aga-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:08:05 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1437272611eso587009c88.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790125684; x=1790730484; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JGoyxRWmZCHMD3A/caoBoHDEKS871mDH4i6spaluJNo=;
        b=PNH4gGlU+JX5JifY3dz454/hIXNeH+kTYRRNP9TiwhVuiTfwIVhmiLoDdlV2PfdSdu
         wR6l2xIPnjnaFAp8qiQKL9g/7dgJFXMkXX8XjdNLm8N5kuNZQDohd5LUXz23HSdkvNvW
         LhjwTAKIBs+jc/shk9ZopPM8YQeSaldMkSesilJ6JtN4p307x5GxwwO37fi5Al8Dh5xy
         EH0J7nWzSeg8k1AMmFFXvH1FIP2NCtXQsyczyootZgjGN+yhruVdkb7SkVHVUdJmQajz
         KvmvbF2K85LbM26istU1Om0IRyDGugtKawHNL4aEPmxIPCUlB6G2j8WF80Stw3aG+l/w
         eChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790125684; x=1790730484;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JGoyxRWmZCHMD3A/caoBoHDEKS871mDH4i6spaluJNo=;
        b=bGhSvoLE1AxQnNokuX7yfhGCa8pCWD80psfCBLnmtab8dy5vSNxoAD0HDszJHFZb+i
         lCpy+sx/qb8/BB4ayVNJOwt/d+t2kZ9ncAFa7UCKWAz8pltgw70IWkAXt+nqYr9u9hxA
         ddC04iwcTADNQYKnURc5SBfoGvADbM9gvPrmMLisArhfSftn+t7RUQEKUMraUbsyCY9p
         87qdSJIHck6P20hZ9rRdBgwGbUR3363340QtEs3HTXUeaENwjBM7xPYblazqTxsPdTVF
         4klOQQnOxlOpGYLcSs3O5B5x3d3IO+rV+LfC/GyM9JsSyjv+5qSWPwDVcQphRv8h7Yhq
         4iOQ==
X-Gm-Message-State: AFuF++mK0Tw1A4dHgIpJTT/MLV48/cU6izgtyPMBJRBpqDibMo18xQBK
	R6qjWEG/e2uVV5vAz8ZcShZ5l4BVJGhiqwTdJgcL7D84RpMT82kX+yv/RuZCxgQL9zLVbrSzaQN
	hL9NXdi4dXpbPIwQIq9RGKblR06ctJ6j3CZVjT3mxnx3nAGUNJVfPkRPBslY=
X-Gm-Gg: AYBFou3+tRT3zPwm2d3nzhtMUrOOhGDlzCoB099FPmIhsxJkzVTD5ZQhJ+0V5qwdXV1
	xn/IYA1pJrHwgzkLf7zqvJ5LPjdEx2uMLpPR54NZ+BkEkR9HqAcUCtGmxKgkVW12cJWojmrDO90
	IFaSLJWpWuoOQgbQkM2E3sMDWaH9Fre/Y6OYeX4fJgT+xwEk35nLc+ohUD5A1/bM+wAHC98+Idx
	x1g5gurscjfmsEsFZD46A9rQT2Ox89K+HPUGUlHRhKePDiBgjUXwBAul/TVD8Dl6GTkPdOyp3h+
	oBvoLCsyNR1u/ELdjYm4juYcm1gyE5Cp5PoEznTdTNaIuc77PwlVy+wx7WRmjYh5beg5e8QY4GV
	hLd2JPzZMylZz9DzSIWeY+ZUQ6r0/
X-Received: by 2002:a05:701b:4206:20b0:143:72b1:9004 with SMTP id a92af1059eb24-144f91721cdmr1164655c88.45.1790125684381;
        Tue, 22 Sep 2026 18:08:04 -0700 (PDT)
X-Received: by 2002:a05:701b:4206:20b0:143:72b1:9004 with SMTP id a92af1059eb24-144f91721cdmr1164606c88.45.1790125683728;
        Tue, 22 Sep 2026 18:08:03 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98ca0edsm1651831c88.15.2026.09.22.18.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:08:03 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Subject: [PATCH RFC net-next 0/9] net: introduce Qualcomm XPCS support and
 add Nord Ethernet plumbing
Date: Wed, 23 Sep 2026 06:37:26 +0530
Message-Id: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4ms2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNj3cLk/Nz4ioLk4vi8/KKU+NTcxGTdpDQjS7PUJBOLVJMkJaDOgqL
 UtMwKsKnRSkFuzgp5qSW6eakVJUqxtbUAGdwXLHMAAAA=
X-Change-ID: 20260923-qcom_xpcs_nord_emac-bf296eb48e4b
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
        Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790125674; l=5546;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=Ci4TmBLiMpoXjBSFDZQyPnrK6xcPv6skVJDuumYU+gw=;
 b=mPxelajzt4OzX4pwVyzuH4GuJc8WRk1XziZsAh78ZzoDSlH+Sw2qgtHAh/OPsxsRKrG/uUVCD
 Z/SVyHwWktMApVUGkKJaJr5KgP68GKcGrNZ/RTXr98xpWBnXoYn4V5s
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-GUID: YbErjHx0D1b94YV-WpBRWzjU6WNJkMdA
X-Authority-Analysis: v=2.4 cv=HdaB3SE8 c=1 sm=1 tr=0 ts=6ab32675 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8 a=_sE-PX45xJdWcABC03UA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: YbErjHx0D1b94YV-WpBRWzjU6WNJkMdA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwNCBTYWx0ZWRfX3jhnGiqk8VGx
 0RmfnXkX/kc6b7mjRy+quotZoO1QunoLw4u+BW7a1oIu59YADQofpHDBII4nIEfY90WL4exchJ9
 +YA30xvj1wLoiOfv59wYlYQfayd+LdkSX4+wioDM4AW7Gpl/RvpuLmFvksuq6TwQT8zgCzK5/Ys
 +ZAsLWg852BjYzHes7W08QIB5sRLUtk1yauTWl7I21qGGwF4XDR+LrCgTjIO6RwSOkEWRnxjdzZ
 ArqMPrs3kgqlzbYSMM/kZmXLqKplVnzp52o/gY0XQvoCqLk7V+5jFCj+LD0qWNg81tdE1XAu5PX
 8bLVNqsJYznjB3UA4lxVguHXCFkMQ9sc8biPMR1gzd+BI93HGe/TDEJuCHDGSKpO8I4jp8sWVqK
 7KWZIbg1wIKnNWJMyg3IOQR1uJoR+ipYYN60WprxZLrckCjul73AgoKVEed5Hoqmvauq/WnyLM1
 ZfmKqwHsdJmTQVcP4aA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwNCBTYWx0ZWRfX8t0DPryxgWFK
 pDATI08E/3pax+EAeeHoxJaNFth3kLGMNohWUB543ENVVoyjNgjYB2uanj2Hb0ksKCgiFC+eVpF
 WmbWgXTVfq/nSkznTL6nYptOlGZRQts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230004

Hi,

This is an early RFC which adds the XPCS and ETHQOS plumbing required
to enable 10 Gigabit Ethernet on the Qualcomm Nord SoC. This is the
first time USXGMII together with an external PCS is being supported by
the dwmac-qcom-ethqos driver.

This platform was somewhat tricky to work on, with several new pieces
having to come together across the MAC, XPCS and SerDes layers. Any
feedback would be appreciated, particularly around the XPCS modelling
and the generic stmmac register-layout changes.

The overall hardware path looks like this:

  +------------------+      +------------------+      +------------------+      +------------------+
  |    DW25GMAC      | ---> |  Synopsys XPCS   | ---> | QCOM SGMII PHY   | ===> | Ext PHY / Switch |
  | + QCOM ETHQOS    |      | + QCOM wrapper   |      |    (SerDes)      |      | USX/10GBASE-R    |
  +------------------+      +------------------+      +------------------+      +------------------+

The series can be broadly divided into two areas:

1. Qualcomm XPCS support

Nord integrates a Synopsys DesignWare XPCS, but exposes the PCS,
PMA/PMD and MII MMD register regions through separate direct-MMIO
windows instead of the standard contiguous or indirect XPCS mappings.
Patches 1 through 5 add the binding, generic platform register-access
hooks, the Qualcomm MMD-to-MMIO translation, and the runtime-PM handling
needed for the CSR clock.

The XPCS also uses Clause 37 control and status for USXGMII, while the
generic XPCS support currently handles USXGMII using Clause 73. Patch 2
adds the required Clause 37 USXGMII configuration and link-state path.

Using a small Qualcomm-specific access layer around the existing XPCS
core was the most straightforward way I could find to model this IP.
The core already uses synthetic IDs for the NXP integrations and has
vendor-specific hooks for other XPCS implementations, so this series
follows a similar approach. I am very much open to suggestions if there
is a cleaner way to represent the non-standard register mapping.

2. DW25GMAC and Qualcomm ETHQOS support

Patches 6 through 9 add the Nord ETHQOS binding and driver support. The
Nord integration has sparse, platform-specific MTL queue and DMA channel
addresses, as well as a relocated timestamp register bank. The series
therefore adds optional XGMAC register-layout data while preserving the
standard layout for existing platforms.

The ETHQOS driver then selects the XPCS provided through pcs-handle and
adds the Nord wrapper programming required for USXGMII, including the
EEE clock vote needed for PCS link-up and the platform-specific SerDes
loopback control.

This series has an obvious dependency on Jitendra Vegiraju's DW25GMAC
work:
https://lore.kernel.org/netdev/20260402213629.1996133-1-jitendra.vegiraju@broadcom.com/

I understand that a v10 of that series is planned. While bringing up
Nord, I also needed a few fixes on top of the DW25GMAC series. Those are
not included here; I will share them separately with Jitendra in case
they are useful for the next revision.

Testing:
Initial testing was done on the Nord Ride SX platform, where both
Ethernet ports connect to the on-board MV-Q6223 switch using fixed-link
USXGMII at 10 Gbps. The testing tree included the DW25GMAC dependency
and the additional fixups mentioned above.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
Mohd Ayaan Anwar (9):
      dt-bindings: net: pcs: add Qualcomm Nord XPCS
      net: pcs: xpcs: add USXGMII Clause 37 autoneg support
      net: pcs: xpcs: add custom platform register accessors
      net: pcs: xpcs: add Qualcomm Nord platform support
      net: pcs: xpcs: initialize runtime PM as suspended
      dt-bindings: net: qcom,ethqos: add Qualcomm Nord
      net: stmmac: support custom XGMAC register layouts
      net: stmmac: qcom-ethqos: support external PCS
      net: stmmac: qcom-ethqos: add Qualcomm Nord support

 .../devicetree/bindings/net/pcs/snps,dw-xpcs.yaml  |  17 +++
 .../devicetree/bindings/net/qcom,ethqos.yaml       |  57 ++++++--
 .../devicetree/bindings/net/snps,dwmac.yaml        |   2 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 162 ++++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  94 ++++++++----
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  34 +++--
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 128 +++++++++-------
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |   5 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |  15 +-
 drivers/net/pcs/Makefile                           |   3 +-
 drivers/net/pcs/pcs-xpcs-plat.c                    |  47 +++++-
 drivers/net/pcs/pcs-xpcs-qcom.c                    |  86 +++++++++++
 drivers/net/pcs/pcs-xpcs-qcom.h                    |  16 ++
 drivers/net/pcs/pcs-xpcs.c                         | 126 ++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h                         |  15 ++
 include/linux/pcs/pcs-xpcs.h                       |   2 +
 include/linux/stmmac.h                             |  11 ++
 20 files changed, 707 insertions(+), 121 deletions(-)
---
base-commit: 6598456d72e48d779445bfec8f72114747f8b8d7
change-id: 20260923-qcom_xpcs_nord_emac-bf296eb48e4b

Best regards,
-- 
Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

