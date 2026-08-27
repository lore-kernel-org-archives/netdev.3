Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2177331A65
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865419; cv=none; b=aycjmsEL4sCibanQDjgkVG5IOBQQgD8x0nRTKcNfO4+DpfQhKskAkUGqHALlH09gjcwO2s7o0dEqGsWsRYH6GQJz21H8/FD8m4WIIVs6g0Z6ODr5cHWhVvt2+is2OOLmTHDfNXwXPVigW9kSy+CQ1m+j4wXHyWexw57DYzDVFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865419; c=relaxed/simple;
	bh=p+5zmtSK0nfRg48wX7x8rE5iAILPBqs1SSLH4sZoz4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aB2W+NwhgKwlgLqrFexjI5dD7HEbEldmHPu5shEmXfNVIdgC85Msd63IW9V4DHzF3kg66yeG8P0i6qIwuNo22e+QQ+4V7+1oOVoDsURwQmnggLOHT1qNAJZjuCSGMMDZ1XEsFoKxL8wOmZ5kAI9Bx2vjJAwwWULDuusrXu+JJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=j0tEE0rl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="j0tEE0rl"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso2736665e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787865416; x=1788470216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=akfGOb5pkYggg80PmucZoF7nPoQ3Nyl03nn3uUvFbXA=;
        b=j0tEE0rlVSSLOhvQK4UOoXctO7o941TZp4FVdSdUVsOAXT4Eu0SuK+qsT+y1Jd8O+s
         BSY/kjB2wkah+Q5tJYPLdeo7KoYByYpO6rFkBMpN4RenvQS6tIWYEUHw4XoGSXUP6hfc
         nbEDf5T8V7mSEBRwNNjyLfx11y1XKFfn9qfIAdqqx/d47orvmJYrPt2MUOnpWhxfhvSM
         ip0QnmWjUdfHq3PLjNQzOl+9nwDQqYuoXSFcOpKjRXNHHSaSik1KgK5iorqQLJ5Ii6Cj
         gOZ9Qpz6dCDRCAcHs3TxMJP4/Y/pz3t6WYzeoElFf3+F2I/v1O/8BJMgEzTHS/K2u6lv
         dq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787865416; x=1788470216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akfGOb5pkYggg80PmucZoF7nPoQ3Nyl03nn3uUvFbXA=;
        b=UlQy8CLjJCfMs38hls02H536w/0JVYmr8Ac0E/KZm0PjLdeC2v2BrgHAvJULl4VZQE
         gORYcq8gAqzRtglF/8wslyJbcP2Nl+/yXnPR5jRgtPAMzLXjf36sHNro+NqUEv4p0+Z9
         f9WK9+Y7SoVDbH98dl+h4cRln8R5brz3zmUEHiB8J8Mwrs3kL7Xy0h9CNcUuIEzhFJyT
         C6MGXHMcsJ7wFjykBZTrlToJYBGV/3sJbNMgnERq7BcpNbmzduDw5w5JPwiNBI53RyGE
         W/LAFS6aMgVEnbv1N9I34MLc8PQa3Fak8ry3U3D7DfQ8jin0l1Nlcf13iEVmmHrKgP1w
         gcww==
X-Forwarded-Encrypted: i=1; AHgh+RqhTCxkeA4ylkLHHPLvBC6mEtvYvoC+35/uKyXoxU/FUv8ihuoqPb0aacpTbYSrnKaICWbCd9Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kV7/GgEyUwphfrDKeJFHRxEckYoKEFXr24ma3S2FNbU6aNgvuM
	AotbxidiPr6knUSN3te+s2F/g1l5MfqyhHEA7V67z65VFPO5sOaY58mLrE7HDj0yzIc=
X-Gm-Gg: AR+sD12KJL454twCuVgbsOCqtE7F4VTUy0BqoWzgwLn5TyhIpLgh5NaXIMxG+KtrT9m
	aZGrjcGvdu7yRrhjCABmkQjn/TikGeuRRkXL2A34FH2P/NyUgXz/+/1niRUnkg83IfusDy0Utlf
	YjQ4eV4rPMvVGLmjANx4hgTQRmm2t8LKe3gO7eGL1c7dQjKkOuHVbNpFxzx4xbk1Kssx3tuLWhR
	PMkF/1xskvKLZvmlyTqkeOOaCgGavKYoGB/TVcyv26xPeyoXAIk2lH133Sa8Qb9Nw3rxd1F9vH1
	mnteifwTFbzb9ZJa7VCisiW29EnRoTXxfJGK1kvGKf0emSxZKFg8jrSONi3D0oAsDEAHE5mxzCc
	EfTl36C8fkpB/TKFsEB9KGIEyLjHVKnJYL+D5cuxezWAuFO445mJc8c+QsS54FJdxQMwZhxGhqE
	/W/4zVNwnxJl7Dbs7BjqmQDuTk/CHAvt8O5tVAxJHcxhNChlpI9j+7lSepx7GOhei4dg==
X-Received: by 2002:a05:600c:3546:b0:499:dbc0:370d with SMTP id 5b1f17b1804b1-49b91c1dad9mr26372755e9.2.1787865416128;
        Thu, 27 Aug 2026 14:16:56 -0700 (PDT)
Received: from ownbook ([31.146.92.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27aa050sm11004557f8f.12.2026.08.27.14.16.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 14:16:55 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: "Chester A . Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Russell King <linux@armlinux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v3 0/2] net: restore EEE on MediaTek switches and SoC MACs
Date: Fri, 28 Aug 2026 00:16:50 +0300
Message-ID: <20260827211652.63504-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
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
MAC that uses mtk_phylink_ops since the two conversions named in the
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

Based on net-next at 91ec20351349. Both driver files are byte
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

On wan the link partner advertises no EEE, so enabling it settles at
"enabled - inactive", which is the correct outcome, and the link
survived the autonegotiation restart. Its Tx LPI reads 1000 (us)
against lan1's 30; see the note below the scissors of patch 1.

lan4 keeps EEE disabled and never arms LPI, which is what dropping
2500BASE-X from lpi_interfaces is for. Forwarding through it was
lossless with no carrier change.

---
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

 drivers/net/dsa/mt7530.c                    | 24 ++++++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 22 ++++++++++++++++---
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.55.0

