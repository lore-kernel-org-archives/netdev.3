Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233D4A485E
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439011; cv=none; b=PUy6j7NVX3jHsxMhcG6GU0fLQt5GxsJD6+mlL5cc0N/d2eY4ffnidbOdwLlwXlRTuRav4elRF29p2ipdYM9Bz53fATk9x+ZFE5c0RRGW1lkcz2mGClRkppPhvBsD1mu2f7ARkP060NA4P2OJ2JV/Ly1Xxv+F5UpX4k98yrhyUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439011; c=relaxed/simple;
	bh=KK7nY2YLsEG83Mq0L8w3IFmjrKX07lGWyztiaqtfewo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUT9PIfUgFN7pyC6dPNxH206qplt6oFS8zM/feEsPDSNEnlHyU9e0SF3aTz9fYVhWsYbpHuRXG6eODmRcz5z2Cmgf6cBAHR6Z3PRRC9mbn8qEP6tc6liAQfv+ckSK/W+UWFiYPLvVCgkvdVzKNgVYgWJzGkts2XI6USq1Q2GGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=PCdWTSum; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="PCdWTSum"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4843f205a5bso1598872f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788439007; x=1789043807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=abT7VqpybEgUMKiyUxYdksUtrvwhOjj1ImBvIGn0b08=;
        b=PCdWTSumFkMidQQFmzSfX/Q3OBNMarMWyi4ePHSO0ZkAGUnKRyq5P5F1VemzOR9DYb
         f1GYSrK56EWrCbcXVSMT2niBdq8aEUqjsd5UDU+6p2pjSNdtIPjjInEZfH0jdPPDRovm
         xlkm8eukZXVzNGniixJ9XqoSRKq/Ikvt7wP+kVwZV9d/HhSvHi+AwZ7GnaFaVHbZENCg
         /yP+38l1olAi5ayCXj97tciOXhwewhpcb46haHwZ2nuTeFteu/JcKL5BsQk2khj////8
         OFN4N23XVZiZ+wcGXt84Ofk7iHp7sHYaW+qRC/8wYmsJw/TsStwRkuF0dRgY3qhXhP+8
         JYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439007; x=1789043807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abT7VqpybEgUMKiyUxYdksUtrvwhOjj1ImBvIGn0b08=;
        b=mzbplQDq0w9r8GQhtSEpyACHQIfqWZGksoUgZIuMd7vK0fjb6mQQnGG2PyBKd4vIwN
         KDMlnpH89dPXutP+d6evwF2v8nDOuNtvOGfTI2OQh/M1Col4a8nKX2o4SP0Mm9sDtRiR
         KRujb+1nCWZ/mghPyPBZz5YYzuXgFJ5//bNd+MyJB4DZ6CbywKWGiyR9gIloLzmkDjiV
         8CWKDtkR/yYGAsNrYquKDuB/pLngY8L7oT4HB4UTi+u1lm2O1knFx779e3RquhPxc5Uv
         cDIDrSfADQrIG+5CyjrRR1L0Dx0wb/6iBUJoUfBJgmEXHm0JbKuh7qa9eXMaWQM0h4T6
         G8+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwwHEklOOkKEsN4dT5gpRc6vxWa1UlG72mwVnuiOZ6MHw3cx8BUmo/r/9B2EDO3g38zj3epU6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lLJWTn3o8tIpm1PjzKUIx2a2Klw4gTRj7VseULDopnQ3O20g+S
	yHJIFW4UtulZNk98M2pEreV00BTWD2D0iPBUDEuhUfVIfMeBhejMrWRStfu4tfdKZms=
X-Gm-Gg: AYBFou1fXIMHQEJh9szCGeZOJ7KwaHKAWR2dLWrOluDvM49wq1p4dL6w+QY3puDsAFz
	qEVd5+296gslwOziCRyj3asXN3jc1WFkaYWz5UPM5Qj2Vpj7fYZy+pxvwlRL1huzPczK1jqwK2l
	eT8aypfk0l27ASjlb+YOxmnFxozONvdB0fo7eMPKK8fs6fwxqlPw2mlv+7pRp/rfrOpcb0G/wmo
	3JzK/WHf6XjzraY7n9lyFSL+X7EA68MVwJDQHhISYZryn0GGdfbpHCTPbtj/reNOBokrbVBiNLe
	ftVZPHOvC9cP5j+8epDvsVOPt5dePCjWEbAQhsIPioIJXIUcjAwb6E8sN3JqLDvIzaFEaRxkvuk
	RUykBE1e9kMwZPrBUvqzleQSFFdKhdVcADv29RndZOMDp3NyUGi+fPBDiUb2pVs62WrMYGL3d2X
	+ilaVA7eWv1/nbxRjzkJuYt6Y/pCOs2/HkCnmZRpNwCuRQ/1Vc0Qw=
X-Received: by 2002:a05:6000:98c:b0:474:530:9d with SMTP id ffacd0b85a97d-48488f20a10mr24494726f8f.13.1788439006829;
        Thu, 03 Sep 2026 05:36:46 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72d2asm12828927f8f.8.2026.09.03.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:36:46 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	nbd@nbd.name,
	lorenzo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	dqfext@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v5 0/2] net: restore EEE on MediaTek switches and SoC MACs
Date: Thu,  3 Sep 2026 12:36:42 +0000
Message-ID: <20260903123644.23800-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both drivers fill in phylink_config.lpi_capabilities and
lpi_timer_default but never lpi_interfaces. phylink treats a MAC as
supporting managed EEE only when the tx_lpi methods are implemented and
BOTH bitmaps are non-empty, which phylink_create() decides once and for
all, so EEE has been off on every mt753x port and on every mtk_eth_soc
MAC that uses mtk_phylink_ops since the two commits named in the
Fixes: tags. Because the tx_lpi methods ARE implemented, phylink takes
the other branch and calls phy_disable_eee(), which fills
eee_disabled_modes - so userspace cannot enable EEE either.

On an MT7981B board with an MT7531 switch, before these patches:

  == lan1
  Cannot get EEE settings: Not supported
  == lan2
  Cannot get EEE settings: Not supported
  == lan3
  Cannot get EEE settings: Not supported
  == lan4
  Cannot get EEE settings: Not supported
  == wan
  Cannot get EEE settings: Not supported

lan1-3 are the MT7531 internal PHYs, lan4 is an EN8811H on switch port
5 whose MAC side runs 2500BASE-X rate matched to a 1 Gbps media link,
and wan is the mtk_eth_soc MAC with its directly attached 1 Gbps PHY -
so both drivers are covered.

Each patch fills lpi_interfaces from supported_interfaces and leaves
2.5 Gbps out of both bitmaps for now. LPI above 1 Gbps is unvalidated
rather than unsupported: both MACs fold 2.5 Gbps onto their 1 Gbps
speed encoding, so the 1 Gbps EEE force bit is what would govern it.
MediaTek's SDK driver sets the force bits for 100 Mbps and 1 Gbps only,
EEE signalling on 2500BASE-X is outside 802.3, and the 1 us unit of the
wakeup timers is undocumented at 2.5 times the port clock.

The SoC MAC patch fills lpi_interfaces only on SoCs carrying a new
MTK_GMAC_EEE capability. mtk_mac_enable_tx_lpi() programs wake-up times
taken from MT7531's reset values, and the capability marks the SoCs
where those have been measured to work: MT7981 for now. The others keep
today's behaviour, EEE unreachable from userspace, until someone with
the hardware confirms them.

Neither driver sets eee_enabled_default, so LPI stays off until
userspace asks for it with ethtool --set-eee. The EEE advertisement is
a different matter: phylink stops force-clearing it, so a PHY that
advertises EEE out of reset advertises it again and the link may
negotiate EEE, without this MAC asserting LPI. MT7531's internal PHYs
and EN7528 are the exceptions, for the reasons in patch 1. Devicetree
eee-broken-* marks act at the PHY level and keep working, so a board
that already distrusts its PHYs stays protected: OpenWrt marks all
modes broken on MT7621's internal PHYs.

The two patches are independent and touch different subsystems; they
are sent together because they are the same bug.

Targeted at net as a regression fix with an active userspace lockout;
can be retargeted at net-next if maintainers prefer.

Based on net-next at 91ec20351349. All three files touched are byte
identical in net/main and the series applies there unchanged.

After the series, all five ports report:

  EEE status: disabled
  Tx LPI: disabled
  Supported EEE link modes:  100baseT/Full
                             1000baseT/Full
  Advertised EEE link modes:  Not reported

No 2.5G mode is offered, which is the narrowed lpi_capabilities, and
nothing is advertised until userspace asks. On this board no PHY came
out of reset advertising EEE, so the case where the advertisement
returns once phylink stops clearing it is not exercised here.

Enabling it on lan1, whose partner advertises EEE at both speeds:

  # ethtool --set-eee lan1 eee on
  EEE status: enabled - active
  Advertised EEE link modes:  100baseT/Full 1000baseT/Full
  Link partner advertised EEE link modes:  100baseT/Full 1000baseT/Full

  # ethtool --set-eee lan1 eee on tx-lpi on
  EEE status: enabled - active
  Tx LPI: 30 (us)

With LPI armed, 30 parallel ICMPv6 streams of 1400-byte payload, 300
packets each one second apart - so every gap crosses the LPI threshold
and the link enters and leaves LPI thousands of times over 300 s - lost
nothing: 300/300 on every stream, tx and rx error counters unchanged,
carrier_changes unchanged, and no mac_enable_tx_lpi errors in dmesg.

On wan, cabled for this round to a partner that advertises EEE (a
BCM5720), the MT7981 GMAC's own LPI was exercised. With tx-lpi armed
the wan PHY's MMD 3.1 reads 0x0f44, Tx LPI indication set, so the MAC
is asserting LPI; it drops to 0x0044 with tx-lpi off and comes back
with it on. The same 30-stream test at 1 Gbps lost nothing over 9000
packets with the link cycling through LPI at every 1 s gap. At
100 Mbps the only losses were the first packet or two of some
streams, and those reproduce with EEE disabled on both ends:
neighbour discovery for 30 streams starting at once. The 17 and 36 that
mtk_mac_enable_tx_lpi() programs therefore hold on MT7981 against this
partner at both speeds. Its Tx LPI reads 1000 (us) against lan1's 30;
see the note below the scissors of patch 1.

lan4 keeps EEE disabled and never arms LPI, which is what dropping
2500BASE-X from lpi_interfaces is for. Forwarding through it was
lossless with no carrier change.

---
v5: in-code comments cut to one line each; the reasoning stays in
    the commit messages (Maxime Chevallier). No code change.
    https://lore.kernel.org/netdev/20260902080519.2211373-1-f@lex.la/
v4: patch 2: populate lpi_interfaces only on SoCs carrying a new
    MTK_GMAC_EEE capability, set for MT7981 after measuring its LPI
    exits; the other SoCs keep the current behaviour (Paolo Abeni).
    patch 1: lpi_capabilities is derived from mac_capabilities instead
    of asserting both speeds. Cover: the MT7981 GMAC LPI measurement.
    https://lore.kernel.org/netdev/20260827211652.63504-1-f@lex.la/
v3: both commit messages cut down to the Why, with the mechanism left
    to the diff and the detail below the scissors (Andrew Lunn); no
    code changes.
    https://lore.kernel.org/netdev/20260824024117.46154-1-f@lex.la/
v2: commit messages rewritten to carry the Why only, mechanism notes
    moved below the scissors (Andrew Lunn); comments and commit
    messages reworded so the 2.5 Gbps exclusion reads as unvalidated
    rather than impossible (Daniel Golle); no functional changes.
    https://lore.kernel.org/netdev/20260822195252.2934-1-f@lex.la/

Aleksei Sviridkin (2):
  net: dsa: mt7530: populate lpi_interfaces to fix EEE support
  net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support

 drivers/net/dsa/mt7530.c                    | 16 ++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 18 +++++++++++++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  4 +++-
 3 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.53.0

