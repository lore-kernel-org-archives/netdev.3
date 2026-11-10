Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312541;
	b=XCs5m7HfeY3DaYViEXIN/Vu6RrDv05O9JNZ4A4TTk9LfTeY/zjX6QKc9u8O2tQBZFSeK
	 bpJqCIVd3hj+RJhr7RZ12Vj841nYc3cBrIn5ePdEuT6Xdm+fOGHsqw+XdEEJRGnOrnk0i
	 31Ocip8yxKyTf90SWMd+e1z+G/aGilId98lJ0zq1z6ei4Q+G5CsG9uDGzZWMjyNNorZ+e
	 wKBXahCtp+DGHUt6eS3rUOZNSVMKlWtkAlQu5ayWUZvb8MyI3dQ3c7s1vlbyK3YdOkJkx
	 Bi7P80WrhiQioZ3rqYNesEdD9gomq8Dq9sNe95ZNx2lQdH06YvOKEyQlulKEJ9vuf1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312541;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MSLoVk874f54dyaO5Erk/rLRwG/Enessr1TXDHq51u0=;
	b=Wfct6PiRYzSNTaOUN6YtSvCKkg1qUpUNN/FpGJ/8znY47duCHw3EB5j6xgAr6R+H67Iv
	 LFTIClOD5oniwQ+hJCQT7apuKHesQbtgJEYS1uyQ95ocWGx/pTON5Dlsxkj7aBlwREkne
	 JQog3qVXdS4zcbKy6sHd6OTKrfLQVnP8DQvwU0bhr2KkBky8lSR8OxHI0+u7jo4KL2L9Q
	 J306LgPMTlgVX0Y4n7Dph4nmQwqeCtFsfY69dYV21EJIqNnWESOQEQB8pV/L7KmB+YIQU
	 zSJZr9j23XZ+kPqLASQwJPAcdiWC1jY3uIAB8lkvj7sQspX8D12Ku368b+DDMaCO8Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ivIfBkg6;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002360A380D;
	Tue, 10 Nov 2026 12:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B002360A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ivIfBkg6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794312538;
	bh=0dtvKEKu/71R4CYmq7iaHMNTzXKLvIiGByglTAieoOk=;
	h=From:Subject:Date:To:Cc:From;
	b=ivIfBkg6Z2NA3g7m5HezVfna1FDDuUAAWibgGg1VrfRR7fRySt4TXfrE6gOzd+P0n
	 g9AGhcqytp9ZFMKXw7xPTawu8oCLkg4AH3zeAebFXfHv8Mn1pLqAz8G0ypOyk2+AHU
	 yoDaI6XV5zTvI8Vhq4x1JioFOnVJ4cl5TvybDWVRICWEWAxOerB7b+zzLF4/ZKUuKI
	 w69wq/KmnsMxYnhHVrrlfg2LICuiApouSOzMSNKkXoWzBhFptU/v7HzdTPQkWfCyvm
	 qN9CN/aYiMYOXhiZ3T9TbaMK2w8+8g0nj2kfa3LB2ySCI+X8/sT4v476SyRu6UZEIH
	 MJpXDms5kz7Sg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C08B717E02F2;
	Tue, 10 Nov 2026 13:08:57 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net-next v5 00/10] net/stmmac: Add Mediatek MT8189 support
Date: Tue, 10 Nov 2026 13:08:47 +0100
Message-Id: <20261110-dwmac-mediatek-mt8189-v5-0-7d99d6292962@collabora.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XRzU7EIBDA8VdpOIsBhillT76H8cDH4BK3rbZY1
 2z67pK6cROzPU4m/PgHLmymKdPMDs2FTbTkOY9DHfChYeHohlfiOdaZKaFaYQTw+NW7wHuK2RV
 6433pZGe5jS4R2E5blKyefZ8o5fPmPrOBCh/oXNjL72aij896UbmuvZuJh7Hvczk0UbUWkdBog
 xq0Rxs1eAdGeeVQRICIJChu1jHPZZy+t/hFbti10+x0LpILLk0CjeRccPAUxtPJ+XFyjzVhUxd
 1k6zSe5Kqkgbho9E1Kdl7EvxJUsh2T4IqKawvqLwPCfCepG+S3P2FRVcpdG2QOgUUSf+X1nX9A
 ew26pvyAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312537; l=5981;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=0dtvKEKu/71R4CYmq7iaHMNTzXKLvIiGByglTAieoOk=;
 b=D7y0IxoV4cVW0fhM1mXnMLnQaQuzMBl6/XHv9ErVSjuARG7bSgB9RIaCshXc4aFPO1xxNQEoK
 9qyWAlr++JODgwOXOAwZbthHkAeHeSr7Sr3Tg/NJdR5DNSoxwSCL6u4
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

This series adds the Ethernet support for Mediatek MT8189 SoC and its
variants (MT8371, MT8391). These SoC integrate a Gigabit Ethernet MAC
with RGMII/RMII/MII interface, with a similar design than previous SoCs
such MT8188 or MT8195.

This series is based on net-next tree (sha1: d26955e57475).
It has been tested on Mediatek Genio 520-EVK (MT8371) and 720-EVK
(MT8391) boards, which both integrate an Airoha AN8801R Ethernet
PHY, with hardware enablement series ([1]).
It has been also tested on Mediatek Genio 510-EVK (MT8370, variant of
MT8188) and 1200-EVK (MT8395, variant of MT8195).

[1]: https://lore.kernel.org/linux-mediatek/20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com/

---
Changes in v5:
- Rebased on net-next (sha1: d26955e57475)
- Added received trailers in patch 2 and 3
- Updated commit message in patch 2 (K. Kozlowski)
- Fixed in patch 6 max delay values check and wrong value in error log
  in mediatek_dwmac_config_dt function (Sashiko)
- Link to v4: https://lore.kernel.org/r/20261103-dwmac-mediatek-mt8189-v4-0-c86c14fc50f4@collabora.com

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
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 368 +++++++++++++--------
 2 files changed, 276 insertions(+), 144 deletions(-)
---
base-commit: d26955e57475434b59d43ba372b2a50d33d5e0ed
change-id: 20260703-dwmac-mediatek-mt8189-9dafe3984951

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

