Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6223346BE;
	Thu, 24 Sep 2026 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234665; cv=none; b=mw5+rR9oAh/pWSXY982PSQeOVyPH5jzdOaNsgKq4Rk/Zfi3IOBid+PxYAO1kOxuCTKvDeXlsRM8KHRYrycJYfGwnHoW0IpeBsbSINW1MIFFXb+u6VC5/FIS8asry8tLYjF4Cd1uftA/hyz3APChiHhnXkVEtdLbGToDQdZFGyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234665; c=relaxed/simple;
	bh=1y3x23f34J6dSnPAWBv03m8McFVIedvOuJSGLlwRbQE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cAvqg8M2e0CORMD665FUckYExCoZLvWtlc1HOtAOuatYkGWEfHnYDFrj3oKAFG6wmBCMF/RtdtJfRgZQMAHbgQN9/sMrYK2pDBGr0nBfkoK2AJHsGRYUwX5QVL8VcOjxDNtZlmh2fV1ds8pMPtgdINubQP2yLozvOQtX3ZmHraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BpNLuSlu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BpNLuSlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790234653;
	bh=1y3x23f34J6dSnPAWBv03m8McFVIedvOuJSGLlwRbQE=;
	h=From:Subject:Date:To:Cc:From;
	b=BpNLuSlu/iJ5dfrdnB1uOkNGfRZDvhvd00IPSn54rSz/MNJo2+kWnx7XywiAiCyuX
	 poEEoou0GyVE0SAkxsWxSS+uW0G8zugq6ZmBvqIAWsSXFxJQvz6CtGrQvdv1md3eTv
	 VJJ8Uu5XRacd1LIrhhJqv8LiRcrVmMOC4xWJM1jZSHbTM79QkFQYxI1c4qJKSOTKcd
	 HVEsbggL9m7p74SE9HGNDAgaZgshGh9brrTwGCV0ZM5gpP6iKWz6JVs9a3BmCpW9HC
	 hFp8903hZmGgOv36sV1DtmkjkBXATb/qZXVvToAYk4TRsZdx+yq6Lq77KuFVHjhbBs
	 s2Q2bvs1ZkRoQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1CA3217E0074;
	Thu, 24 Sep 2026 09:24:13 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net-next v2 0/7] net/stmmac: Add Mediatek MT8189 support
Date: Thu, 24 Sep 2026 09:23:23 +0200
Message-Id: <20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOTW7CMBCFrxLNuoNiOyEOK+6BWEzsSbGK49Y2A
 RTl7liBbZdP7+9bIHF0nOBQLRB5dsmFqQj5VYG50PTN6GzRIGu5r7taob17MujZOsr8gz5roXv
 sLY2set30rYDS/Y08use2e4KJM078yHB+O5H/buUof+yBEqMJ3rt8qFqpLe+1koMUW/7iUg7xu
 QHOYit8WLp/WGaBNYpuVE3LRIbU0YTrlYYQaVdu4Lyu6wsistfe+AAAAA==
X-Change-ID: 20260703-dwmac-mediatek-mt8189-9dafe3984951
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790234653; l=3138;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=1y3x23f34J6dSnPAWBv03m8McFVIedvOuJSGLlwRbQE=;
 b=dc/cU9HL5r6uNwpt2Qd66PMiC15uiDrPEMbq1iDLDwS8j9vlOUPlMa+CSYxibMAx5kX0VBTwt
 ltUELoSJ/qhCfOdGEzwstse+2zQkZc3X6TYNsThAes8GRMOmmKoVRGs
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

This series adds the Ethernet support for Mediatek MT8189 SoC and its
variants (MT8371, MT8391). These SoC integrate a Gigabit Ethernet MAC
with RGMII/RMII/MII interface, with a similar design than previous SoCs
such MT8188 or MT8195.

This series is based on net-next tree (sha1: 528de6832b21).
It has been tested on Mediatek Genio 520-EVK (MT8371) and
720-EVK(MT8391) boards, which both integrate an Airoha AN8801R Ethernet
PHY, with hardware enablement series ([1]) and additional devicetrees
patches for enabling their Ethernet interface.
It has been also tested on Mediatek Genio 510-EVK (MT8370, variant of
MT8188) and 1200-EVK (MT8395, variant of MT8195).

[1]: https://lore.kernel.org/linux-mediatek/20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com/

---
Changes in v2:
- Rebased on net-next (sha1: 528de6832b21)
- Dropped "net: stmmac: mediatek: rename MT2712 and MT8195 variant
  methods" and "net: stmmac: mediatek: add support for TX deallocation
   adjustment feature" patches, present in v1 (M. Chevallier)
- Patch 1:
  - Removed rmii_internal clock from required clock list (A. Lunn)
  - Added MT8189 stage delay divider values in "mediatek,rx-delay-ps" and
    "mediatek,rx-delay-ps" property description (Sashiko)
  - Updated commit description
- Added patch 2 to simplify TX/RX delay handling in mt8195_set_delay
- Added patch 3 to add RX/TX delay stage divider in platform data
- Patch 4:
  - Replace MT8195_PERI_ETH_CTRL_BASE by MT8195_PERI_ETH_CTRL_OFFSET to
    harmonize the variable and definition naming (A. Lunn)
  - Added Reviewed-By tag
- Added patch 5 to add the TX Clock phase shift use in
  RGMII and in 1G speed
- Patch 6:
  - Reworded flag and define names to explicit a bit more what the
    feature does
  - Updated commit description
- Patch 7:
  - Added the new definitions and needed fields in platform data
  - Updated commit description to add the info about MT8189 RX/TX delay
    stage divider and maximum values, and remove reference about 
    stage fine feature 
- Link to v1: https://lore.kernel.org/r/20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com

---
Louis-Alexis Eyraud (7):
      dt-bindings: net: mediatek-dwmac: add support for MT8189 SoC
      net: stmmac: mediatek: simplify TX/RX delay handling in mt8195_set_delay
      net: stmmac: mediatek: add RX/TX delay stage divider in platform data
      net: stmmac: mediatek: add PERI_ETH_CTRLx register offset in platform data
      net: stmmac: mediatek: use TX clock phase shift in RGMII mode with 1Gbps speed
      net: stmmac: mediatek: add support for TX clock output enable feature
      net: stmmac: mediatek: add support for MT8189 SoC

 .../devicetree/bindings/net/mediatek-dwmac.yaml    |  87 ++++++---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 211 ++++++++++++++++-----
 2 files changed, 224 insertions(+), 74 deletions(-)
---
base-commit: 528de6832b2194ae0b1d62b0925e0ac6cad1087c
change-id: 20260703-dwmac-mediatek-mt8189-9dafe3984951

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

