Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7F4A1DE5
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053268; cv=none; b=pSkkDbqaViDU5pR7S0lxRwFOEeoY3TWInXeaklM1GAQqbb7RD6Gqn6PvpNczri//xwT/M8xXB0nlbB3JdNywpsoj50OG9AN3Ak1G3aAfK6ExPa9kn5pbSAylPRb3/2yvA3TJYtB5Yi0JQvG9Mv1/qgeDof4Wzu6SOdQO5ioBZEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053268; c=relaxed/simple;
	bh=Wt4AGaZzjlLmkzMuZU+yHhddyGNgpOoVw6ukdtbRyiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFvwvWRXA8qi9jv7xqniZXK99Fsfq3McCHFs8GiH/7dHstZsg9drxlT6OD6nqAR2cVqSoI/UvAooESHgE4BHHg2kMa/NdLlUq/wnE+B1NGzy8y2w88COFqEQBwujNotJLm01efLjXiJNa9Ulca1/HGnwyyfc2iLcvnAyT6f3RHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fbb54oEU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fbb54oEU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EECA14E40106;
	Thu, 10 Sep 2026 15:14:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B67B15FA2F;
	Thu, 10 Sep 2026 15:14:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE8FD11C787F4;
	Thu, 10 Sep 2026 17:14:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789053256; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=SRIsn8qe5kijvVGnEzyAS3z5dSa3YzDzhskFAKJyBLY=;
	b=fbb54oEU1+JaeCFGWFiay2g9C02IrTPNVCCVjOYLoHoXxA/A0Zqab52cH8PEEYRcRkU/Li
	+FS0Qq7f+B6gufCGUqciIKUBo9pciC1q/b1PhxUOltEZG7l+/7Q+qUJ5Ag2CdvBNYVDaiP
	VzmSaIgY1QB9yI9EzgSx4+ct06LrScgpociIgH6lZ4B4IcICWvZlSlhDPIYcz7j1JxgWSx
	uD3/Mevk9fHgffasVEFIcQrcXQT8trJtr8YZ3Rtrd04xzff2mAU6hTXNTHTOHwK7eCEhsc
	JlycaHsiHIzAk7oKK9vXexHASdrWRehyfJH52J22bAcAfz/AQpc/T8RGTBEPDQ==
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
Subject: [PATCH net v2 0/6] net: stmmac: More selftest-related fixes
Date: Thu, 10 Sep 2026 17:13:57 +0200
Message-ID: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
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

Here's V2 of the stmmac selftest fixes. I don't really know why but V1
was only partially delivered, yet Nicolai was kind enough to review
whatever managed to get to the lists, and found some things to improve
in the EEE test, addressed in this new iteration :) Hence, this is V2
and not a resend.

This is another round of stmmac selftest fixes, mostly about the selftests
themselves but a few things were discovered w.r.t MTU and buffer size
handling, see patch 5.

I've continued expanding the test devices I'm running this on, more devices
should come in the future. With this series, _almost_ everything is
green, except for some flow control stuff that is either a false positive
or a real thing that needs investigating.

After this is merged, I consider the selftests to be now reliable enough
to run them nightly on every stmmac series that's sent, and I'll be requiring
clean selftests for new glue drivers.

I've been running this on :

 - Altera CycloneV (dwmac-socfpga, dwmac1000 IP, v3.70a)
 - NXP imx8mp (dwmac-imx, dwmac4, v5.10a)
 - Allwinner H2S (dwmac-sun8i, dwmac1000)
 - Amlogic S905X3 (dwmac-meson8b, dwmac1000, v3.70a)
 - STM32mp157a (dwmac-stm32, dwmac4, v4.20a)
 - SiFive JH7110 (dwmac-starfive, dwmac4, v5.20)
 - Motorcomm YT8061 (PCIe, dwmac-motorcomm, dwmac4)
 - Qualcomm IPQ8064 (dwmac-ipq806x, dwmac1000)

Tests are OK if return is 0 or -95 (-EOPNOTSUPP), tests are KO otherwise

Before the series :

Test                     imx  socfpga sun8i meson8b stm32 starV mcom ipq806x
MAC Loopback              0     0      0     0       0     0     0    -110
MMC Counters              0     0      -95   0       0     0     0    -110
EEE                       -95   -95    -95   -110    -110  -95   -95  -95
Hash Filter MC            0     0      -95   0       0     0     0    -95
Perfect Filter UC         -95   0      0     -95     -95   -95   -95  -95
MC Filter                 -95   0      -95   -95     -95   -95   -95  -95
UC Filter                 -95   0      -95   -95     -95   -95   -95  -95
Flow Control              -95   0      -110  0       -110  -95   -110 -110
RSS                       -95   -95    -95   -95     -95   -95   -95  -95
VLAN Filtering            -110  -95    -95   -95     -110  -110  -95  -95
VLAN Filtering (perf)     -110  -95    -95   -95     -110  -110  -95  -95
Double VLAN Filter        -110  -95    -95   -95     -110  -110  -95  -95
Double VLAN Filter (perf) -110  -95    -95   -95     -110  -110  -95  -95
Flexible RX Parser        0     -95    -95   -95     -95   -95   -95  -95
SA Insertion (desc)       0     -95    -95   -95     0     0     0    -95
SA Replacement (desc)     0     -95    -95   -95     0     0     0    -95
SA Insertion (reg         0     -95    -95   -95     0     0     0    -95
SA Replacement (reg)      0     -95    -95   -95     0     0     0    -95
VLAN TX Insertion         -110  -95    -95   -95     -110  -110  -110 -95
SVLAN TX Insertion        -110  -95    -95   -95     -110  -95   -110 -95
L3 DA Filtering           0     -95    -95   -95     -95   -95   -95  -95
L3 SA Filtering           0     -95    -95   -95     -95   -95   -95  -95
L4 DA TCP Filtering       0     -95    -95   -95     -95   -95   -95  -95
L4 SA TCP Filtering       0     -95    -95   -95     -95   -95   -95  -95
L4 DA UDP Filtering       0     -95    -95   -95     -95   -95   -95  -95
L4 SA UDP Filtering       0     -95    -95   -95     -95   -95   -95  -95
ARP Offload               -95   -95    -95   -95     -110  -110  -110 -95
Jumbo Frame               0     -110   -110  0       0     0     0    -110
Multichannel Jumbo        0     -95    -95   -95     -95   -95   -95  -95
Split Header             --95   -95    -95   -95     -95   -95   0    -95
TBS (ETF Scheduler)      --95   -95    -95   -95     -95   -95   -95  -95

ARP offload's still there as this was a net-next patch and I've ran these
checks on the net tree.

Jumbo frame tests on dwmac1000 started failing after :

commit 23680bf5f8c6 ("net: stmmac: restore NET_IP_ALIGN in the RX DMA offset")

This commit is OK though, it just made the selftest reveal the cracks
hiding beneath the surface of MTU/bufsz handling.

After this series :

Test                     imx  socfpga sun8i meson8b stm32 starV mcom ipq806x
MAC Loopback              0      0     0       0     0     0     0    0
MMC Counters              0      0     -95     0     0     0     0    0
EEE                       -95    -95   -95     0     0     -95   -95  -95
Hash Filter MC            0      0     -95     0     0     0     0    -95
Perfect Filter UC         -95    0     0       -95   -95   -95   -95  -95
MC Filter                 -95    0     -95     -95   -95   -95   -95  -95
UC Filter                 -95    0     -95     -95   -95   -95   -95  -95
Flow Control              -95    0     -110    0     -110  -95   -110 -110
RSS                       -95    -95   -95     -95   -95   -95   -95  -95
VLAN Filtering            0      -95   -95     -95   0     0     -95  -95
VLAN Filtering (perf)     0      -95   -95     -95   0     0     -95  -95
Double VLAN Filter        0      -95   -95     -95   0     0     -95  -95
Double VLAN Filter (perf) 0      -95   -95     -95   0     0     -95  -95
Flexible RX Parser        0      -95   -95     -95   -95   -95   -95  -95
SA Insertion (desc)       0      -95   -95     -95   0     0     0    -95
SA Replacement (desc)     0      -95   -95     -95   0     0     0    -95
SA Insertion (reg         0      -95   -95     -95   0     0     0    -95
SA Replacement (reg)      0      -95   -95     -95   0     0     0    -95
VLAN TX Insertion         0      -95   -95     -95   0     0     0    -95
SVLAN TX Insertion        -95    -95   -95     -95   -95   -95   -95  -95
L3 DA Filtering           0      -95   -95     -95   -95   -95   -95  -95
L3 SA Filtering           0      -95   -95     -95   -95   -95   -95  -95
L4 DA TCP Filtering       0      -95   -95     -95   -95   -95   -95  -95
L4 SA TCP Filtering       0      -95   -95     -95   -95   -95   -95  -95
L4 DA UDP Filtering       0      -95   -95     -95   -95   -95   -95  -95
L4 SA UDP Filtering       0      -95   -95     -95   -95   -95   -95  -95
ARP Offload               -95    -95   -95     -95   -110  -110  -110 -95
Jumbo Frame               0      0     0       0     0     0     0    0
Multichannel Jumbo        0      -95   -95     -95   -95   -95   -95  -95
Split Header              -95    -95   -95     -95   -95   -95   0    -95
TBS (ETF Scheduler)       -95    -95   -95     -95   -95   -95   -95  -95

ARP can be ignored, and Flow control needs some more attention, but
we're getting there :)

Thanks,

Maxime

V2:
 - Snapshot before sending the frame for EEE, in case we immediately
   enter LPI
 - Also return -ETIMEDOUT instead of EINVAL

V1: https://lore.kernel.org/lkml/20260909074740.1247762-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (6):
  net: stmmac: selftests: Support running selftests on DSA conduits
  net: stmmac: selftests: Validate EEE based on the actual LPI timer
    value
  net: stmmac: selftests: Check the dev->features for S-TAG offload
    testing
  net: stmmac: selftests: Capture all packets for vlan checks
  net: stmmac: size the RX buffers from the frame length, not the MTU
  net: stmmac: selftests: Account for alignment shift on dwmac1000 for
    Jumbo test

 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  20 +--
 .../stmicro/stmmac/stmmac_selftests.c         | 116 +++++++++++++++---
 2 files changed, 109 insertions(+), 27 deletions(-)

-- 
2.55.0

