Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C1641A92A
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753126; cv=none; b=R8uya6889FG5nAXqclFZpf17jZ5MO77juCBMhBh5LhDaDm2ejuyB6zfhkHLIGx4jFPRn1JC2qOjT3Ctlp8Zcn/YCpOKYInihheHTZeJt4Uynk9WtFgz5I1fuDQB1LscVTDD0U4kfwhXKcHuCz5/NO0nJWtvIkfZtygXmFgJXUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753126; c=relaxed/simple;
	bh=34QKtFQ2opmeEgBPvpo+DmrklwVFuw6HgZJEZhZanNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V9RhtpIpWaCKP5Or9S8XC1Ti4HqNm06RcBu6ftqBzPseUTu7g0nLn9w8wlCW6lmUgyB1JvywuVQRtYskynQDJ8nSWIto6h2k2PasCKdGS+6Pa6GnX0AbdCeNy2hfyJWqeJvyLrEeXA1G5vuk8ph14syixF9ze+ztL4Gr2QAOWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=udn6XVLV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="udn6XVLV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A675A4E413C5;
	Wed, 26 Aug 2026 14:05:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 778E3604EC;
	Wed, 26 Aug 2026 14:05:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F03D711C78266;
	Wed, 26 Aug 2026 16:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787753115; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=3kk+lwdyVjIUqmvMFUqCsbt2Bf0odcr5CdZvUvDqZHg=;
	b=udn6XVLVzUra7F5sClAAMy5R8i2t8WTnUk1F/bWeQK70sWMdM+ANJcqTodwR90QxNq0sqk
	IA2k5UHvvLQNbOiZPxS1FBGQSdo1WYdWg0qpNXGS9z3C16NHfx4TJqpGnlvrZN4bEpOW+m
	qvg1r3gt4rD2SbCgqu8troohsAE6t6Ka0wLf5jr1+GUp+yC8PHx3+S3YN5IfMckzhJoSFm
	Vr3sS+BFLHwxTX2olSu/r3lgCYglGy124xta+gXUUbxtx3yRASen24RO/AWspP+sPt4Wdk
	yaB0RWnhsKCulMZgpiliUDA5nxlfg8ZAiYSq3oRwKadSi08gsYSljk8JrCsmgQ==
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
	Jose.Abreu@synopsys.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net 0/6] net: stmmac: More selftest related fixes
Date: Wed, 26 Aug 2026 16:04:52 +0200
Message-ID: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

This series addresses some (but not all) issues found while running the
ethtool selftest on various stmmac platforms. As a reminder, ethtool
selftest are run with 'ethtool -t ethX', and for stmmac the goal is to test
hardware features and bugs from the IP integration in the platform.

I've been running this on :

 - Altera CycloneV (dwmac-socfpga, dwmac1000 IP, v3.70a)
 - NXP imx8mp (dwmac-imx, dwmac4, v5.10a)
 - Allwinner H2S (dwmac-sun8i, dwmac1000)
 - Amlogic S905X3 (dwmac-meson8b, dwmac1000, v3.70a)
 - STM32mp157a (dwmac-stm32, dwmac4, v4.20a)
 - SiFive JH7110 (dwmac-starfive, dwmac4, v5.20)

Here's the results before this series, noting that some bugs were already
fixed, some are ongoing (cf. the IP proto patch here [1])

[1] : https://lore.kernel.org/netdev/20260825211748.360935-1-maxime.chevallier@bootlin.com/

Tests are OK if return is 0 or -95 (-EOPNOTSUPP), tests are KO otherwise

Test                     imx   socfpga   sun8i   meson8b   stm32 starfive
MAC Loopback              0      0        0        0        0       0
MMC Counters              0      0        -95      -22      0       -22
EEE                       -95    -95      -95      -95      -95     -95
Hash Filter MC            0      0        -95      0        0       0
Perfect Filter UC         0      0        0        0        0       0
MC Filter                 0      0        -95      0        0       0
UC Filter                 0      0        -95      -22      0       0
Flow Control              -110   0        -110     0        0       -110
RSS                       -95    -95      -95      -95      -95     -95
VLAN Filtering            -110   -95      -95      -95      -110    -110
VLAN Filtering (perf)     -110   -95      -95      -95      -110    -110
Double VLAN Filter        -110   -95      -95      -95      -110    -110
Double VLAN Filter (perf) -110   -95      -95      -95      -110    -110
Flexible RX Parser        0      -95      -95      -95      -95     -95
SA Insertion (desc)       0      -95      -95      -95      0       0
SA Replacement (desc)     0      -95      -95      -95      0       0
SA Insertion (reg         0      -95      -95      -95      0       0
SA Replacement (reg)      0      -95      -95      -95      0       0
VLAN TX Insertion         -110   -95      -95      -95      -110    -110
SVLAN TX Insertion        -110   -95      -95      -95      -110    -95
L3 DA Filtering           0      -95      -95      -95      -95     -95
L3 SA Filtering           0      -95      -95      -95      -95     -95
L4 DA TCP Filtering       0      -95      -95      -95      -95     -95
L4 SA TCP Filtering       0      -95      -95      -95      -95     -95
L4 DA UDP Filtering       0      -95      -95      -95      -95     -95
L4 SA UDP Filtering       0      -95      -95      -95      -95     -95
ARP Offload               -95    -95      -95      -95      -110    -110
Jumbo Frame               0      0        0        0        0       0
Multichannel Jumbo        0      -95      -95      -95      -95     -95
Split Header             -95     -95      -95      -95      -95     -95
TBS (ETF Scheduler)      -95     -95      -95      -95      -95     -95

So, only sogfpga is all OK (in all fairness, it doesn't support much)

Several issues :

 - MMC test failing on starfive and meson8b, solved by patch 1
 
MMC counters maintained by the MAC are optional, which one is implemented
depends on how the IP is synthesized. On starfive and meson8b, the counter
used by the selftest to validate the MMC counters feature isn't implemented.

Solved by adding other counters in the validation step, kinda fragile as
this doesn't guarantee this will work on all platforms.

 - Flow control test failing on starfive, imx8mp, sun8i, solved by patch 6
 
Turns out these platforms actually never emit any Pause frame, as they don't
have enough room in their per-queue RX Fifo. They do correctly process RX
Pause frames. The fix isn't to change the advertised pauseparams, as the
pause negotiation process based on MAC capabilities doesn't allow us to
say we "just" support RX pause, so let's just not run the Pause tests if
the RX fifo is too small.

 - UC filter failing on meson8b, fixed by patches 2,3,4 and 5
 
This one is quite the rabbit hole, and is a combination of multiple issues.

 - Unicast filtering uses the same filter (perfect filter) to allow the
   primary MAC address and the secondary addresses (dev->uc) to flow
   through the interface. That means if we have say 64 slots in the
   perfect filter, only 63 can be used for the dev->uc list, as the first
   entry stores the MAC address. If the filter is full, we switch to UC
   promisc mode, were we let all UC frames flow. There's an off-by-one
   error in dwmac1000, dwmac4 and dwxgmac2.
   
 - The selftest itself needs an empty slot in the filter, so it has to
   check that sizeof(dev->uc) is $number_of_slots - 2 (one for primary
   MAC, one for the test). There's an off-by-two error in the selftest.
   
 - This leads to an interesting finding (not addressed by this series) :

   The size of the perfect filter isn't reported by the HW, so it comes
   from firmware (snps,perfect-filter-entries). A lot of platforms don't
   specify that in DT (e.g. imx8mp doesn't, it has 128 entries but the
   driver thinks there's only 1...). I've reached out to Synopsys to
   see if there's some sane default we could use on dwmac4, if anyone
   has a dwmac4 databook I'd appreciate if you could look this up, as I
   don't have access to them, I'm not a vendor... Otherwise, we'll have
   to patch all the .dtsi if we want to avoid going in UC promisc as
   soon as we add an entry in dev->uc.
   
After this series, socfpga, starfive and sun8i are all OK :)
   
Some issues are still out there, the VLAN filtering and tagging fails on
imx8mp and stm32 (so, dwmac4) butI haven't got there yet.

ARP offload doesn't work on stm32mp157a and starfive JH7110 either.

Feel free to look this up if you feel like it,
just let me know so that we don't do work on the same thing :)

Maxime

Maxime Chevallier (6):
  net: stmmac: selftests: Check multiple MMC counters
  net: stmmac: dwmac1000: Account for the primary MAC address for UC
    filtering
  net: stmmac: dwmac4: Account for the primary MAC address for UC
    filtering
  net: stmmac: dwxgmac: Account for the primary MAC address for UC
    filtering
  net: stmmac: selftests: Account for the UC filter list for filtering
    tests
  net: stmmac: selftests: Don't test flow control for small rx fifos

 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  2 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  2 +-
 .../stmicro/stmmac/stmmac_selftests.c         | 51 +++++++++++++++----
 4 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.55.0

