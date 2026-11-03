Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700758;
	b=3BHe19BqW95CAjAiSlq9A8lTidcJD1tbqXsamK3iTDn/S8xoducslV4TqeS7MrK5zaGh
	 SvTf8E+1JuEOzoe2lFY5SY7Xy/71wX9QKZPz9M/gTVIVBrRAKR+sGrDGLrEQsAUh8LkEI
	 aALNJMljd6XTxSeIiOsu0TzI2OVOj+c+6pw8ABarRIk7C9f2WVuEL/nAGaoa3mFRTOV8X
	 /MyGlYYdZRx8iadVfomVGA81vl1vI4xxZc/MyHuM5fWV32ZkN/wOLh/LAjK/U7bwymw3V
	 bCEMNsequQ0yVaV9YoJ/f7CAD7i/Qt2qQfYQyLgncdxh0SgFtvOCvWVTQ4t8k0+9aoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700758;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4i3sIx5PFmi/QA+2lJ9qhcTbIsOgOaLUsN1CPUxpHWI=;
	b=4DJTqDa/h5RgPJZ+DF0cO1/NCFn1pOvORlXTU3Bfn8sbvZyVllMMQwm1kQZbDsjDPXtF
	 7tPXOqHltES83ZJKvUXFMil5OAyFDdbpTI+ILgADJ18RtjEk791QWEhwEw2jKQ6rk73TZ
	 s11Fntq71gE5zqfAsZ10Rn/zrTNRNrBOv6rN4t2HNnsDFqvwDRG34ad+vScwJhe8mS2XA
	 BZj01fkyaA3Iamny4QckRZgDMEqr36vtAPNNzVxFlc17rrDMV27ZuyuddHuCDcDLsZwEF
	 8RcF5kEsROZa7SBNRtrYGx+INf9xFmbQ5uXpgyUEp22BsQRRpcrUQjtKUtAkMnmsHkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jLwi4hn1;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CEF606BFA7;
	Tue,  3 Nov 2026 10:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34CEF606BFA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jLwi4hn1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793700756;
	bh=0TzXPCqhnAZdv1lntTYvhZMEiSWTRD2NSeGZbyDZDJQ=;
	h=From:Subject:Date:To:Cc:From;
	b=jLwi4hn1VF7BN+ljLF2VUJe+bnvlRAOjxPMqm7BC5MN9mr2xUsglKV4TITZVqTQx0
	 OVSsJIOBawzP/NcXSlfdEXbbrZqgQSOVd4e/5MjfgBKaDuQr8BBsgBBEV0wm9EPHz+
	 wHfK22nt0yXMjvuTHP8q2bIt7coUni009fLnMNy0nBcjlAGeXLhCCDeOrMTWt8fGuT
	 qt0BKJ1x+w6pzw+gTHmk4l7O4frn27Utam9Dz0md+7EOEBq1w/VdQ4FwSolIS+7EG1
	 NHzucvArAFq8gaCITtyTYUzBLx4MY0hLRiEEFZvaaHIPPOQjlBrGjG6gpuQ7XmdFMj
	 KvksCDQ22fMMQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 351AD17E0564;
	Tue, 03 Nov 2026 11:12:35 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net-next v4 00/10] net/stmmac: Add Mediatek MT8189 support
Date: Tue, 03 Nov 2026 11:12:05 +0100
Message-Id: <20261103-dwmac-mediatek-mt8189-v4-0-c86c14fc50f4@collabora.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQzU7DMAwH8FepciYon02zE++BdnASh0WsLaRZG
 Zr67kRhAgnRo2X75798IwvmhAs5dDeScU1LmqdaqIeO+BNML0hTqDURTPTMMEnDxwiejhgSFHy
 lYxn4YKkNEFHaQVnNSd19yxjTtbnPZMJCJ7wWcvzuZHy/1EPl3nawIPXzOKZy6IzrwangPNd9m
 z+lpcz5swVceVu4ZzE7WVZOGeUmSqURwIN88vP5DG7O8FjPNHUVv5IVak8SVVKSuWBU0Bjtf5L
 8kTjj/Z4kqyR0/ZJwzkep/0rbtn0Bsy6ctowBAAA=
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793700755; l=5597;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=0TzXPCqhnAZdv1lntTYvhZMEiSWTRD2NSeGZbyDZDJQ=;
 b=j5i+d75ricLzUd8rrv57THjEU0yDR1kthxZORFcAxxqwSioD3LOuB+bIf4ycV8XT/OHlgXeaz
 toaRLsHFjC8C8k7eZKzPjIBH7KRIh8lqR17fRStihJQTwpWTlL2kII3
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

This series adds the Ethernet support for Mediatek MT8189 SoC and its
variants (MT8371, MT8391). These SoC integrate a Gigabit Ethernet MAC
with RGMII/RMII/MII interface, with a similar design than previous SoCs
such MT8188 or MT8195.

This series is based on net-next tree (sha1: 7b6ab4dbc156).
It has been tested on Mediatek Genio 520-EVK (MT8371) and 720-EVK
(MT8391) boards, which both integrate an Airoha AN8801R Ethernet
PHY, with hardware enablement series ([1]).
It has been also tested on Mediatek Genio 510-EVK (MT8370, variant of
MT8188) and 1200-EVK (MT8395, variant of MT8195).

[1]: https://lore.kernel.org/linux-mediatek/20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com/

---
Changes in v4:
- Rebased on net-next (sha1: 7b6ab4dbc156)
- Added Reviewed-By and Acked-by trailers in patch 1
- Added patch 2 to add deprecated flag in the mediatek,tx/rx-delay-ps
  vendor property and update their description (A. Lunn)
- Dropped in patch 3 mediatek,tx/rx-delay-ps description changes
  in bindings and patch description (A. Lunn)
- Patch 4:
  - Used single delay stage divider define for both RX and TX case
    to simplify implementation
  - Added MII delay definitions 
  - Dropped Reviewed-By trailer due to changes
- Patch 5:
  - Fixed MII/RGMII delay stage divider inversion (Sashiko) 
  - Used single delay stage divider define for both RX and TX case
    to simplify implementation
- Added patch 6 to add the standard internal delay properties use
- Patch 7:
  - Renamed delay stage divider fields in variant struct (M. Chevallier)
  - Simplified patch implementation by using one delay stage divider
    per mode in variant structure and commonizing delay computation
    in new single private function
- Dropped "net: stmac: mediatek: use TX clock phase shift in RGMII mode
  with 1Gbps speed" previously present in v2 and v3, as suggested by A.
  Lunn
- Rebased patches 8 to 10 over previous patches modifications
- Link to v3: https://lore.kernel.org/r/20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com

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
Louis-Alexis Eyraud (10):
      dt-bindings: net: mediatek-dwmac: fix unit in rx/tx delay property description
      dt-bindings: net: mediatek-dwmac: deprecate rx/tx delay vendor properties
      dt-bindings: net: mediatek-dwmac: add support for MT8189 SoC
      net: stmmac: mediatek: simplify TX/RX delay handling in mt8195_set_delay
      net: stmmac: mediatek: simplify TX/RX delay handling in mt2712_set_delay
      net: stmmac: mediatek: use standard internal delay properties
      net: stmmac: mediatek: add RX/TX delay stage divider in platform data
      net: stmmac: mediatek: add PERI_ETH_CTRLx register offset in platform data
      net: stmmac: mediatek: add support for TX clock output enable feature
      net: stmmac: mediatek: add support for MT8189 SoC

 .../devicetree/bindings/net/mediatek-dwmac.yaml    |  52 ++-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 374 +++++++++++++--------
 2 files changed, 278 insertions(+), 148 deletions(-)
---
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
change-id: 20260703-dwmac-mediatek-mt8189-9dafe3984951

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

