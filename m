Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA313A543A;
	Wed,  1 Jul 2026 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911481; cv=none; b=czlEzJ09bMXNOcI+Ui8vVkzHB+yCvP9kCrGm7yMtPdobCgmglw3u1CSzfb5Ai/dctIC5bq1y5C5s0S78R+s8HeBcUkOLeIJWMFTQSPmjhph/2faEiXAl+ndsWdbM3hfGoUeVAhf5ukzg9UPep9s0nzT8V8pk4zfSd2tpzHZ1d4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911481; c=relaxed/simple;
	bh=QIxKF0eP1N9vophR0MT1mP0a00BGi/R2xAljGm0nClI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NwqJieKU8fQU8Om4lvcPpDzo66ZcsuxXI+4NxOictQMSSO9lz58ThDZMrxzS7sgZJ68G4SK9ZOyz+Uu/Pb00mvXgIOsMF92ulaF+t8MuqyYDcBkHCyXmAB99HH1LBcJvybQxmGMTSK6M7q+KV3T34DG2jk7yPd8DsGQvhc9XDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hY0yNAyE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hY0yNAyE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782911478;
	bh=QIxKF0eP1N9vophR0MT1mP0a00BGi/R2xAljGm0nClI=;
	h=From:Subject:Date:To:Cc:From;
	b=hY0yNAyENtU/BPDjFqBMzUvBArPfg8rFQE7Ao9LMEhM3qBg0XylsoBpUbPpsKP/U8
	 DM8w7VsHwSznUTFlFN0QSQOTW/q/+k7A6Vpzr9wpd0AQ69LZpIg5gAUz+VceTGBFy7
	 Yk15qH+QnAPDaynqBOSRGEZa1bK78mUaKszOkCD81d3FntYt7fxvQ9v/Wf+6rJtU9C
	 khhoaZ4DtjjmJhI6mWupLB+hh18f1lOKiGGmomDKrLqfXbZdjMsNoAeJEQr4gU734h
	 MwcLhUpSoSPK5/9tj7wQktVF62ALUpREI/myOvspiXgczlRs9qRwPS65H2XZta8KzA
	 tymUaDFwuzvHQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B636A17E0CA2;
	Wed,  1 Jul 2026 15:11:17 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH 00/15] MT8189: Add support for system and base clock
 controllers
Date: Wed, 01 Jul 2026 15:11:05 +0200
Message-Id: <20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNQQ7CIBBFr0Jm7SSATVt7FdMF4qBEAcugqWl6d
 0kbl+8n778FmLInhkEskOnj2adYQR0E2LuJN0J/rQxa6la2R4mh9Ko/oX0m+2DkLxcKeDFM2Ml
 ONdQ4p42B6r8yOT9v3+dx50zTuybKPsKm2RSCL4OINBf8Z2Bc1x+8LNctnAAAAA==
X-Change-ID: 20260630-mt8189-clocks-system-base-70714e4ff2aa
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 Irving-CH Lin <irving-ch.lin@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782911477; l=6133;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=QIxKF0eP1N9vophR0MT1mP0a00BGi/R2xAljGm0nClI=;
 b=FdeE+8779Wq/oPJZpNVjjjWbQY4g2eRPA17K9WqARCgWMQnlsWZYkaCB7i4UMR5508qwj9uLr
 5dQvAG4F5yyDpuCEms1WonOcn1eOhQUl3Hn0lqf//hFsRP2FDXsewib
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

This series is a continuation by AngeloGioacchino Del Regno and I of a
previous series ([1]), that adds the clock controller support for
the Mediatek MT8189 SoC and its variants (MT8371, MT8391).  

The first major changes is the split of the series in two:
- one for all basic clock controllers including system ones (this
series)
- one for the multimedia and graphics related clock controllers (to be
send in the future)

We chose to separate the multimedia clock drivers from the base system
ones, as there is currently an unsolvable inter-dependency between the
power domains and multimedia clocks; the power domains need a
dual-stage bring-up, where only a part of the multimedia clocks are
accessible in the first power domain powerup stage, and the rest when
the second stage (SRAM enablement) is done.
The current workarounds for this issue, such as removing the is_enabled
operation from the impacted clock controllers clk_ops table or
let the multimedia power domain always on, were quickly discarded
for upstream.

The second major change is the dt-bindings patch that got heavily
reworked, not only because of the split choice. We took the opportunity
to regroup in the MT8186 clock and system clock dt-bindings the
description of several other Mediatek SoC (MT8188, MT8192 and MT8195)
and add in them the MT8189 new ones.
The rationale is to ease maintainability and have common files for
several currently supported SoC or new future ones, that have the same
kind of clock controller design.

Finally the pending remarks from peer reviews on the v6 revision of [1]
were also taken into account and new fixes and cleanups were also
added.

A more detailed changelog between [1] and this series:
- Removed multimedia and graphics related clock controllers code and
  definitions from series
- Added new dt-bindings patches to factorise existing MT8188, MT8192
  and MT8195 in MT8186 clock dt-bindings
- Heavily modified the MT8189 dt-bindings to add new compatibles 
  in MT8186 clock dt-bindings
- Created a new dt-bindings include for the MT8189 reset controller
  definitions (include/dt-bindings/reset/mediatek,mt8189-resets.h)
- Removed unnecessary `syscon` compatible fallback from MT8189 base
  clock controllers
- Added missing 'mediatek,mt8189-fhctl' compatible declaration in
  dt-bindings
- Modified Kconfig to COMMON_CLK_MT8189 be tristate (and not bool) to 
  allow all MT8189 clock controller drivers to be built as modules (it
  was partial) 
- Fix pll unregisters in clk_mt8189_apmixed_probe error case
- Reparent several clocks to correct 26M references in clk-mt8189-bus.c,
  clk-mt8189-topckgen.c and clk-mt8189-vlpckgen.c
- Removed CLK_SET_RATE_NO_REPARENT flag from mfg_sel_mfgpll
- Rename TOPCKGEN_fmipi_csi_up26m clock to fmipi_csi_up26m to remove caps usage
- Implemented reset controllers in clk-mt8189-ufs.c
- Updated all file headers to update copyrights and add all authors
- Added all co-developed-by trailers

The series is based on linux-next tree (tag: next-20260630) and has
been tested on Mediatek Genio 520-EVK (MT8371) and 720-EVK (MT8391) boards
with board hardware enablement patch series (new series revision for
those boards to be sent soon after this one).

[1]: https://lore.kernel.org/linux-mediatek/20260309120512.3624804-1-irving-ch.lin@mediatek.com/
[2]: https://lore.kernel.org/linux-mediatek/20260309120512.3624804-2-irving-ch.lin@mediatek.com/

---
Louis-Alexis Eyraud (15):
      dt-bindings: clock: mediatek: reorder MT8186 compatibles
      dt-bindings: clock: mediatek: regroup MT8188 dt-bindings into MT8186
      dt-bindings: clock: mediatek: regroup MT8192 dt-bindings into MT8186
      dt-bindings: clock: mediatek: regroup MT8195 dt-bindings into MT8186
      dt-bindings: clock: mediatek: Add MT8189 clocks
      clk: mediatek: Add MT8189 apmixedsys clock support
      clk: mediatek: Add MT8189 topckgen clock support
      clk: mediatek: Add MT8189 vlpckgen clock support
      clk: mediatek: Add MT8189 vlpcfg clock support
      clk: mediatek: Add MT8189 bus clock support
      clk: mediatek: Add MT8189 dbgao clock support
      clk: mediatek: Add MT8189 dvfsrc clock support
      clk: mediatek: Add MT8189 i2c clock support
      clk: mediatek: Add MT8189 scp clock support
      clk: mediatek: Add MT8189 ufs clock support

 .../bindings/clock/mediatek,mt8186-clock.yaml      |  171 +++-
 .../bindings/clock/mediatek,mt8186-fhctl.yaml      |    1 +
 .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   42 +-
 .../bindings/clock/mediatek,mt8188-clock.yaml      |   93 --
 .../bindings/clock/mediatek,mt8188-sys-clock.yaml  |   58 --
 .../bindings/clock/mediatek,mt8192-clock.yaml      |  191 ----
 .../bindings/clock/mediatek,mt8192-sys-clock.yaml  |   68 --
 .../bindings/clock/mediatek,mt8195-clock.yaml      |  238 -----
 .../bindings/clock/mediatek,mt8195-sys-clock.yaml  |   76 --
 drivers/clk/mediatek/Kconfig                       |   79 ++
 drivers/clk/mediatek/Makefile                      |    8 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c       |  196 ++++
 drivers/clk/mediatek/clk-mt8189-bus.c              |  200 ++++
 drivers/clk/mediatek/clk-mt8189-dbgao.c            |   98 ++
 drivers/clk/mediatek/clk-mt8189-dvfsrc.c           |   58 ++
 drivers/clk/mediatek/clk-mt8189-iic.c              |  122 +++
 drivers/clk/mediatek/clk-mt8189-scp.c              |   77 ++
 drivers/clk/mediatek/clk-mt8189-topckgen.c         | 1024 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mt8189-ufs.c              |  133 +++
 drivers/clk/mediatek/clk-mt8189-vlpcfg.c           |  115 +++
 drivers/clk/mediatek/clk-mt8189-vlpckgen.c         |  284 ++++++
 include/dt-bindings/clock/mediatek,mt8189-clk.h    |  433 +++++++++
 include/dt-bindings/reset/mediatek,mt8189-resets.h |   17 +
 23 files changed, 3046 insertions(+), 736 deletions(-)
---
base-commit: ba7c57499e5999aeae8dd4f954eb2600589d80aa
change-id: 20260630-mt8189-clocks-system-base-70714e4ff2aa

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

