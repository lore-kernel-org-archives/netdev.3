Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D692C15BB;
	Fri, 16 Oct 2026 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146720; cv=none; b=TjB5sIBtcFP1DV4kWLiV6gOAuoJ6haUy+2UdCrzRfRwrCJwbvT6QhVCBYBxc43VPwvEGWXbSe7khaaUCfJqhZ/5UdA51qvZiM6P2H8BBU5NugAPbo3dCQuRj4OibXrDs8oULLdFdzM+F+ZrAG5daBiEsRWuMLjka4F7NhkWIobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146720; c=relaxed/simple;
	bh=zumrvlMufacpBL+t1/9JMnrcup7QYswF3CVBRJj8Blo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iDYJi6MEbojDRN1NMCHVKZ1abYP/M7EEDBy1N/+45WAxrAe7KxARVpQwlwWodbjHhMNgPa/vpcAgKXig4LbWk/juzawh9EpAdQz3WlQ5ybQgHAZmLjeQcnPHvnt3CZekZCiKy3rdJ+UZY9ORwCzCtL0Uiwzuh1V8gHppfVvBLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mXcJfPoW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mXcJfPoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1792146717;
	bh=zumrvlMufacpBL+t1/9JMnrcup7QYswF3CVBRJj8Blo=;
	h=From:Subject:Date:To:Cc:From;
	b=mXcJfPoWjuLxgUML8sEXUtkuI63lxTyOjoPC8fmsbkeNq6vYfOZv1fg0VLahpRtd2
	 WJ6Yh6wdKAGbV2rsvR4oRywj4yKktTm2EjxV1Bm/vqriOhL9hEPnLecBYW83MDe78S
	 u/Lcasl1ZY3IYI7Nl/NOfmZZt8/V5K8wMzvWERAqnh+bsvtP1M8AylfPvrm8QiIjSK
	 Seicc/2mvDPPNtGEVqM5BGCGc9kEJl+XY7DtJzrjRnmFGJdBfok3p5prVBw5jGm3fe
	 5Tr5rEg/KMiBw25hKTadqRUdH7ZRnFKvjMTYmTHOjtG4KBPwaGa6oeDBQkZpqXMuf8
	 RIwSbAYgty1Ww==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E30A17E04E5;
	Fri, 16 Oct 2026 12:31:56 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net-next v3 0/9] net/stmmac: Add Mediatek MT8189 support
Date: Fri, 16 Oct 2026 12:31:04 +0200
Message-Id: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOzU7DMBCEXyXymUX+Sx33xHsgDht7Qy3qGGwTi
 qq8O5aphITU42hmvpkrK5QDFXYcrizTFkpIaxPqYWDuhOsrQfBNM8nlgRuuwH9FdBDJB6z0BrF
 OYrJgPS6k7KTtKFjrvmdawqVzn9lKFVa6VPby62T6+GxD9WbPWAhcijHU43CYFRlljJ7E2POnU
 GrK3/3gJnrh9sXc+bIJ4CDMovRIiA7Vk0vnM84p42Ob6dRN/pGs1PdIspG04rM32o+02P+kfd9
 /AKHcoj9CAQAA
X-Change-ID: 20260703-dwmac-mediatek-mt8189-9dafe3984951
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146716; l=4158;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=zumrvlMufacpBL+t1/9JMnrcup7QYswF3CVBRJj8Blo=;
 b=ZQhCbUkZrEMjGd5BTitKBa9L/WRb+azHxAgOBy1ypPWUVvAv8RLzQ+ff8CzGXHjgK6iYoonLZ
 7a+Ng6mQJNbCiCBInbB0xos2dly3W5500CM/PknLi9EYtAJmpj+hR17
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

This series adds the Ethernet support for Mediatek MT8189 SoC and its
variants (MT8371, MT8391). These SoC integrate a Gigabit Ethernet MAC
with RGMII/RMII/MII interface, with a similar design than previous SoCs
such MT8188 or MT8195.

This series is based on net-next tree (sha1: 6b3e73774815).
It has been tested on Mediatek Genio 520-EVK (MT8371) and 720-EVK
(MT8391) boards, which both integrate an Airoha AN8801R Ethernet
PHY, with hardware enablement series ([1]).
It has been also tested on Mediatek Genio 510-EVK (MT8370, variant of
MT8188) and 1200-EVK (MT8395, variant of MT8195).

[1]: https://lore.kernel.org/linux-mediatek/20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com/

---
Changes in v3:
- Rebased on net-next (sha1: 6b3e73774815)
- Added Reviewed-By trailers in patch 3 and 5
- Added patch 1 to fix unit in rx/tx delay property description
  (Sashiko)
- Patch 2:
  - Reworded patch description to add clock list details
  - Removed the specific MT8189 clocks list so the axi and apb clocks
    are also described for this compatible too and reworked the clock
    list and number check
  - Added mediatek,rmii-clk-from-mac as not allowed for MT8189 (Sashiko)
- Added patch 4 to simplify TX/RX delay handling in mt2712_set_delay,
  as suggested by M. Chevallier and modified following patches
  accordingly
- Fixed in patch 7 tx_rgmii_delay_stage_div null case and register value
  in mt8195_fix_mac_speed (Sashiko)
- Added in patch 9 the axi and apb clocks to MT8189 clock lists 
- Link to v2: https://lore.kernel.org/r/20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com

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
Louis-Alexis Eyraud (9):
      dt-bindings: net: mediatek-dwmac: fix unit in rx/tx delay property description
      dt-bindings: net: mediatek-dwmac: add support for MT8189 SoC
      net: stmmac: mediatek: simplify TX/RX delay handling in mt8195_set_delay
      net: stmmac: mediatek: simplify TX/RX delay handling in mt2712_set_delay
      net: stmmac: mediatek: add RX/TX delay stage divider in platform data
      net: stmmac: mediatek: add PERI_ETH_CTRLx register offset in platform data
      net: stmmac: mediatek: use TX clock phase shift in RGMII mode with 1Gbps speed
      net: stmmac: mediatek: add support for TX clock output enable feature
      net: stmmac: mediatek: add support for MT8189 SoC

 .../devicetree/bindings/net/mediatek-dwmac.yaml    |  58 +++-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 363 ++++++++++++++-------
 2 files changed, 287 insertions(+), 134 deletions(-)
---
base-commit: 6b3e73774815910a39d8ca75b9ad7df963f61d50
change-id: 20260703-dwmac-mediatek-mt8189-9dafe3984951

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

