Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94033043DE;
	Mon,  2 Feb 2026 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013737; cv=none; b=ncWnHNl4xwxxUEsPSXifuJ0NpVBbw0SBLflLOv2TLDCS/1mEjrkLiIM3vVfvTPOAzD9MfXEFxIdZDiU0qSG3E0kPtR/ImdzKdotESH67N298iKzJ2sc/w31wx9JhlkW8xkckxvlu603nMJlkOgxathlGw9tmwfrdunhAf0/sT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013737; c=relaxed/simple;
	bh=ika1oG6feLwzhS+M+pURwPvG/UckFXhKexElfc7xFJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d9ugmi3qsDtHwLMjCJpfICi5ZU3QeE/j+yy6FR5oyU2eH7Vu2/FApjdXvAVs52bRvWPvneXVLPzcJquWHUeNTMY/nUEvnvJ43WTfE/jgWm8L07weSFrG2CNHcyhwd+Gr4W9eqZAUpvE7Pz4yBrUddvD6bP5WJr3yiTA6LPNK6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=F/uttqOA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="F/uttqOA"
X-UUID: 6c480508000011f1b7fc4fdb8733b2bc-20260202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QiUAvSJJw6dro6/o+A9Z+bQes8F+Viy8+ik7qmJJS6E=;
	b=F/uttqOAi2xVb/ffAlLHqkyEWklAABUktNBGlSkvuj1gcjR7jXvGeW1Z8D8SV/WqmqvuNB/cDgPE3Z3ceat5mk1CfgrLhgm+bi/JveK/3VxFYXfhhcKOR4ggo+oL2TixFZbf1STKo5PUUVXvs5kDQXBbYOqdclOlJgEo9ox4LFs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:01e8f744-1030-4c6a-85f1-e2cffdd70441,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:9b347b7a-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6c480508000011f1b7fc4fdb8733b2bc-20260202
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1844753353; Mon, 02 Feb 2026 14:28:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Feb 2026 14:28:42 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 2 Feb 2026 14:28:42 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Cochran
	<richardcochran@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, "Chen-Yu
 Tsai" <wenst@chromium.org>, Miles Chen <miles.chen@mediatek.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Qiqi Wang
	<qiqi.wang@mediatek.com>, <sirius.wang@mediatek.com>,
	<vince-wl.liu@mediatek.com>, <jh.hsu@mediatek.com>,
	<irving-ch.lin@mediatek.com>
Subject: [PATCH v5 00/18] Add support for MT8189 clock controller
Date: Mon, 2 Feb 2026 14:28:07 +0800
Message-ID: <20260202062840.342707-1-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Changes since v5:
- Remove redundant 'binding', 'definition' in commit message.
- Remove MT8189 dt-schema, merged into common (apmixed, topckgen, syscon ...).
- Separates power domain patches to another series.

Changes since v4:
- Fix dt_binding_check warning.
- Check prepare_enable before set_parent to ensure our reference clock is ready.
- Enable fhctl in apmixed driver.
- Refine clock drivers: 
  - Change subsys name, regs base/size (clock related part, instead of whole subsys).
  - Simply code with GATE_MTK macro.
  - Add MODULE_DEVICE_TABLE, MODULE_DESCRIPTION
  - Register remove callback mtk_clk_simple_remove.
  - Remove most of CLK_OPS_PARENT_ENABLE and CLK_IGNORE_UNUSED which may block bringup,
      but some subsys will power off before we disable unused clocks, so still need here.  

changes since v3:
- Add power-controller dt-schema to mediatek,power-controller.yaml.
- Separates clock commit to small parts (by sub-system).
- Change to mtk-pm-domains for new MTK pm framework.

changes since v2:
- Fix dt-schema checking fails
- Merge dt-binding files and dt-schema files into one patch.
- Add vendor information to dt-binding file name.
- Remove NR define in dt-binding header.
- Add struct member description.

  This series add support for the clock controllers
of MediaTek's new SoC, MT8189. With these changes,
other modules can easily manage clock resources
using standard Linux APIs, such as the Common Clock Framework (CCF).

Irving-CH Lin (18):
  dt-bindings: clock: Add MediaTek MT8189 clock
  clk: mediatek: clk-mux: Make sure bypass clk enabled while setting MFG
    rate
  clk: mediatek: Add MT8189 apmixedsys clock support
  clk: mediatek: Add MT8189 topckgen clock support
  clk: mediatek: Add MT8189 vlpckgen clock support
  clk: mediatek: Add MT8189 vlpcfg clock support
  clk: mediatek: Add MT8189 bus clock support
  clk: mediatek: Add MT8189 cam clock support
  clk: mediatek: Add MT8189 dbgao clock support
  clk: mediatek: Add MT8189 dvfsrc clock support
  clk: mediatek: Add MT8189 i2c clock support
  clk: mediatek: Add MT8189 img clock support
  clk: mediatek: Add MT8189 mdp clock support
  clk: mediatek: Add MT8189 mfg clock support
  clk: mediatek: Add MT8189 dispsys clock support
  clk: mediatek: Add MT8189 scp clock support
  clk: mediatek: Add MT8189 ufs clock support
  clk: mediatek: Add MT8189 vcodec clock support

 .../bindings/clock/mediatek,apmixedsys.yaml   |    1 +
 .../bindings/clock/mediatek,infracfg.yaml     |    1 +
 .../bindings/clock/mediatek,pericfg.yaml      |    1 +
 .../bindings/clock/mediatek,syscon.yaml       |   27 +
 .../bindings/clock/mediatek,topckgen.yaml     |    2 +
 drivers/clk/mediatek/Kconfig                  |  146 +++
 drivers/clk/mediatek/Makefile                 |   14 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c  |  192 ++++
 drivers/clk/mediatek/clk-mt8189-bus.c         |  196 ++++
 drivers/clk/mediatek/clk-mt8189-cam.c         |  108 ++
 drivers/clk/mediatek/clk-mt8189-dbgao.c       |   94 ++
 drivers/clk/mediatek/clk-mt8189-dispsys.c     |  172 +++
 drivers/clk/mediatek/clk-mt8189-dvfsrc.c      |   54 +
 drivers/clk/mediatek/clk-mt8189-iic.c         |  118 ++
 drivers/clk/mediatek/clk-mt8189-img.c         |  107 ++
 drivers/clk/mediatek/clk-mt8189-mdpsys.c      |   91 ++
 drivers/clk/mediatek/clk-mt8189-mfg.c         |   53 +
 drivers/clk/mediatek/clk-mt8189-scp.c         |   73 ++
 drivers/clk/mediatek/clk-mt8189-topckgen.c    | 1020 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8189-ufs.c         |   89 ++
 drivers/clk/mediatek/clk-mt8189-vcodec.c      |   93 ++
 drivers/clk/mediatek/clk-mt8189-vlpcfg.c      |  111 ++
 drivers/clk/mediatek/clk-mt8189-vlpckgen.c    |  280 +++++
 drivers/clk/mediatek/clk-mux.c                |    9 +-
 .../dt-bindings/clock/mediatek,mt8189-clk.h   |  580 ++++++++++
 25 files changed, 3630 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-bus.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dbgao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dispsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dvfsrc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-iic.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mdpsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-scp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-ufs.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vcodec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpckgen.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt8189-clk.h

-- 
2.45.2

