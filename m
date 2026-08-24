Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0610372049
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539288; cv=none; b=FBxqbd1bdro3DttsCK+ZT1/i30HIx+1P1T4lB2OQq25kfxaJKyGr0TabUY4V5ocplGu6cC7kwwfR8yHiPwsaT7G3cCcaz1pmRSDJDu0l0g18jYRx7LLBClsXaQ40daVCqZj+n1hIU292pN8OokF7Oym0dNYcz8IlDVFxGI55Mns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539288; c=relaxed/simple;
	bh=eVMlWxVQr7oL7OUokGCpCcdwoLSXrn/87RDA9InGgTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGvsPKf3svOuzbfYHtTUavFVv8doJzy7je9lLwbmv5DBRubIOvAQHP73Ix1w7hvrnhoquGhJANpBQFUXayUvEWI780NrCaFhLki9lxH0gsUJ63LppWNLVZ7DhqQrD+bdo2CPWY11YfnTyx/r5PAQMZCvQEfqfgQie0bQyeBFuFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=e/EGfYVk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="e/EGfYVk"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so327520466b.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787539282; x=1788144082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQDlZUqXKTPfwqBY8N8tCdcmyCJmkDuzU6UtMMpoHKM=;
        b=e/EGfYVk6LSSA3yqgVyiuaeUdoqzvHeMezDHGaodWz+FsZnkD+/aUxOmf/ExLXCw67
         mJ3G6cvim9JdKLnQHYHM+VTxLgA0yuNozrcvl9Izoo74IEyBuumlN7PEi+vEjU8umBJN
         q1pdo3zg9P/QB7x8UTpO4geBlCT9XRJFJTkZylJ9SwPljAGSt4D57wnYkSnDIh45Rj0y
         P7AuvvZC/kswSoowwI3jVLCE+ry9bD0P8v9b5Wfsg3VtOthCYr3z4mi9+c5HfyEpKgVQ
         CxeJPQRhBkTk/qQFziLsHa0WA99ISWOkRhci7rdcY9tBZl70ALol0UdeEmz9fHYqIcN3
         d6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787539282; x=1788144082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQDlZUqXKTPfwqBY8N8tCdcmyCJmkDuzU6UtMMpoHKM=;
        b=XV4LX945E0QmnpnLeHY02cCgNI+bCDv3UvpwBES80gCn3m5M/q3CkZAjv1KD4cC3L6
         UesaBZOA6UAUUG+W7eDGsX7Q02orw4xSYFT6HP7d6BXMVFN4H7YKEifikIjayag5SUva
         ExhTMH8i56/9xbLMh15O7Tq1FilIrqcFpF4G8Li5LiT9rBfiVwxgAB6eUyPmTkA3y22c
         O0RoBkh9XWkAM9XKyV3F7lrHola9ZSj4fqeW6G7nzuYQXEX1ObFBg4AfR6Q6WEuWxN4O
         8d5sQUhoG+AB/rxPBLEREn5VoNYiaCKkblzTpNC7a+CFH26ntcNUdRoyP41wAEvw4IY0
         /ZrA==
X-Forwarded-Encrypted: i=1; AHgh+RrudxbmdShL5qAT953iKXzbmbK+BcR6ShRigILLXiANzbC0jfTVDFpPcqE/IUH+6anm0vrxTRw=@vger.kernel.org
X-Gm-Message-State: AFuF++kMc2uU7Z7WKtCrnWeQDBgemaFC1gyyRfYcPGglsfKzjGtyG3on
	yyPlnxYhAEjcxRj66Ex6zPkKSjMkNyrVcazj10WEUh/6SAA4Tf82f/N9aRiR3G96NAk=
X-Gm-Gg: AR+sD10LCCQ6IsM7O7vA1Q0CPmvnCAzqm5wvYBn/fteh7XQlCX9f9hd5yUQE9DqAMyv
	8yEEbNvp37ZUIScej5/jEoiD3BR1/FgTUkR2IZxA0hu//VAonFHAAE8KJAqzu8NOuhl4DAt20iq
	gsOPwlMkeps5ZQH6jutXwvIuByx6ztOWH4r+N0w0FiE+TxplW/JVIyWQFxB6SCLWaPckDRThz8w
	hiNnZB0Ddk2V+/k4MKg4PzmxiSlGAsr7AjZ5jb9sQywhRnYH0xRz9DMaVv+QniWccySeXGY5FeK
	OMfqEJf12hJItchQgIP+DqKpZ+uQHNZWrIMo+0BZufS9Lyz5zfM9pJpKjZugD8zign0sLLdGQp2
	IESHaIYi1vDWzeZVPR8pDu4LYtM/OJwpW6sGz6keZVf2N/7+fq4n549cbqVJKBRoo/xCER+fHOr
	xPi9Aaj9sOrwlp7MdFwOGcrRvMh4JjDSK96fgICldROAyMJ9HG/74lrnJI
X-Received: by 2002:a17:907:97d5:b0:c20:21be:ea75 with SMTP id a640c23a62f3a-c246a33ea8bmr2393322466b.8.1787539282331;
        Sun, 23 Aug 2026 19:41:22 -0700 (PDT)
Received: from ownbook ([195.181.160.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249686e37bsm949008466b.55.2026.08.23.19.41.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:41:21 -0700 (PDT)
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
Cc: Russell King <linux@armlinux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v2 0/2] net: restore EEE on MediaTek switches and SoC MACs
Date: Mon, 24 Aug 2026 05:41:15 +0300
Message-ID: <20260824024117.46154-1-f@lex.la>
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
v2: commit messages rewritten to carry the Why only, mechanism notes
    moved below the scissors (Andrew Lunn); comments and commit
    messages reworded so the 2.5 Gbps exclusion reads as unvalidated
    rather than impossible (Daniel Golle); no functional changes.
v1: https://lore.kernel.org/netdev/20260822195252.2934-1-f@lex.la/

Aleksei Sviridkin (2):
  net: dsa: mt7530: populate lpi_interfaces to fix EEE support
  net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support

 drivers/net/dsa/mt7530.c                    | 24 ++++++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 22 ++++++++++++++++---
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.55.0

