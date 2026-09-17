Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828964A0157
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682044; cv=none; b=ikWzDBMGVBOqamQlny10QnEjTeYSvQrS30msz3zL6thrVYOhSVXOG4g/u58izVLaYj3sfwaRB2D91Vkmts/Nq8JZOPb797wBPu2ypU7blF9erwaIi8kfNv3ZM0mOM9q2MkMYS+EDh5TDyV86xyqIZVnHIFiCraFbzllmIW4NcdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682044; c=relaxed/simple;
	bh=zXfio3jMRHBUYw+Fdw5tP+v4c9gAYSeRHAFZp54ZXEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knqMiKmfWJI2vYSfKRRmnf6VmGCyj2kIMthRtTvjh4YVNBnKioGcW2r0ZAElDhMW87j/I+Q3qEsvOdWQD3jVuy8mjEJVIBQLJ+5LOk5sizX7pd6lw9Y4mbZ2vCxjuhOtdingUZ3UQsUJnbSfOwRBimKipxkssX23nNkCJinwV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B/cHhhav; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B/cHhhav"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9C3CB4E407BD;
	Thu, 17 Sep 2026 21:53:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 518DC5FF03;
	Thu, 17 Sep 2026 21:53:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0EBE11C7B078;
	Thu, 17 Sep 2026 23:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789682035; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=RVssTxQ5vgUrZLRLdaleGA3EAw+f1WjUsfJeu7ykFSQ=;
	b=B/cHhhavaDQz18JaBzY8BKWcyyfggNcvB1vpabYphY86oewjFYhyrWdV1fWuzz6yYqrvkJ
	LiJoYKR73JqD6ThakxMp98/1eUPJ3RgEAvFdo6q8hqm73enC7LFYmI9CZ+zrBDgNqQu+KJ
	LB/etemXNhdzNtMZS09ujspMPwlYQYjibwlwompwISFghhij5a9hOgBQQOyt+DinDhfay9
	Nh7Dbsnr/1sPJBX5Df+YMD1pbLipQbT7JiDgQZ/AMi+4i3OGhQOZzHbuKFRBNE6df4jrS1
	dDx/xytRzB1mvjUmZ1VoYHypGIiJPRLH53SLbZPRYish9BrA5Xlk/ung5S9PlQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	PKneuper@dspace.de,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net v4 0/7] net: stmmac: More selftest-related fixes
Date: Thu, 17 Sep 2026 23:53:31 +0200
Message-ID: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This is V4 of stmmac selftest fixes, addressing Sashiko's issues over
the MTU patch. This lead to the introduction of a new one. The
dev_add_pack races have been addressed, however the double-vlan issue
stayed there. Ovidiu is actively working on it, let's wait for his work
to land before fixing that.

Nicolai, I took the liberty of keeping your review tags on affected
patches, let me know if this isn't ok.

This is another round of stmmac selftest fixes, mostly about the selftests
themselves but a few things were discovered w.r.t MTU and buffer size
handling, see patch 5 anf 6.

After this is merged, I consider the selftests to be now reliable enough
to run them nightly on every stmmac series that's sent, and I'll be requiring
clean selftests for new glue drivers.

Since V3, the testing farm grew ! I've been running this on :

 - Altera CycloneV (dwmac-socfpga, dwmac1000 IP, v3.70a)
 - NXP imx8mp (dwmac-imx, dwmac4, v5.10a)
 - Allwinner H2S (dwmac-sun8i, dwmac1000)
 - Amlogic S905X3 (dwmac-meson8b, dwmac1000, v3.70a)
 - STM32mp157a (dwmac-stm32, dwmac4, v4.20a)
 - SiFive JH7110 (dwmac-starfive, dwmac4, v5.20)
 - Motorcomm YT8061 (PCIe, dwmac-motorcomm, dwmac4)
 - Qualcomm IPQ8064 (dwmac-ipq806x, dwmac1000)
 - Altera AgileX5 (dwmac-socfpga, dwxgmac2 !) (NEW)
 - Generic dwmac1000 (Loongson 2K0300, dwmac 3.70a) (NEW)
 - Rockchip RK3566 (dwmac-rk, dwmac4) (NEW)

It's becoming cumbersome to list the test results here, they can be
found, updated daily, here :

https://minimaxwell.github.io/stmmac-ci/

Thanks,

Maxime

V4:
 - Move the dev_add_pack later, to avoid potential races (sashiko)
 - Add one more MTU fix for 8K buffer selection
 - Ditch an extra SKB padding in patch 5.

V3:
https://lore.kernel.org/netdev/20260911212028.1497613-1-maxime.chevallier@bootlin.com/
 - Bail out of the EEE test if LPI is over 5 seconds

V2:
https://lore.kernel.org/r/20260910151404.976753-1-maxime.chevallier@bootlin.com
 - Snapshot before sending the frame for EEE, in case we immediately
   enter LPI
 - Also return -ETIMEDOUT instead of EINVAL

V1: https://lore.kernel.org/lkml/20260909074740.1247762-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (7):
  net: stmmac: selftests: Support running selftests on DSA conduits
  net: stmmac: selftests: Validate EEE based on the actual LPI timer
    value
  net: stmmac: selftests: Check the dev->features for S-TAG offload
    testing
  net: stmmac: selftests: Capture all packets for vlan checks
  net: stmmac: dwmac4: Use the correct bufzise when the len is exactly
    8K
  net: stmmac: size the RX buffers from the frame length, not the MTU
  net: stmmac: selftests: Account for alignment shift on dwmac1000 for
    Jumbo test

 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   2 +-
 .../net/ethernet/stmicro/stmmac/ring_mode.c   |   4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  20 +--
 .../stmicro/stmmac/stmmac_selftests.c         | 153 ++++++++++++++----
 5 files changed, 139 insertions(+), 44 deletions(-)

-- 
2.55.0

