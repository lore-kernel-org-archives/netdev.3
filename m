Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5F932B10A
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428380; cv=none; b=sZiF5KPi/57HpmMAnekqhogB5R7FF2K5suWfEXzbvTdeR0zqLAe+mga6A/y6TqndJZHxuCzJgO5lXSlnxNu7dLJtMXxFMMwgdTtAkGyLeSjNsJia1j3Yo5ZOkuZljkVQRzLus/IzBYqPJwBDfKAwJN44ZjuCocXarb7HR8OBWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428380; c=relaxed/simple;
	bh=UqQuL+AXIRZqPn6VNUMyOijNM+5doE4BGR5QBRJIq3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgPRJTMI+8e9JtFg08Z11QmKH8VL1wf/nrDmYQ3l3qKSjE9KkqAPINmwi38RW9bnP7RdJqnJjxmxN6WiCkirodgpplHXIpkYBABxp6+J1JEGNHxCvw1ETDnXxQnB4RttkmBdn0h5X446fpBzTtewYXUyeLrUvfVpTpzvkeGeUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=I+DvfO58; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="I+DvfO58"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso3678722a12.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787428375; x=1788033175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MbRs6SJvz6u9cGosQWklZdWE9HBk6wlNApB8tJN/dPQ=;
        b=I+DvfO58anM90A3ODO2y3Eynj7KalPx4W/h058HK3Fd7VUU+7cxKqgKDzPcrBAHLzS
         qrpYCmPrZx5R5bMSkS/hJq+s1NBYAzhFm1IthoDFp/ihMLzY+6Ec/fE4lrog/zIguaBi
         HsZJUHjNaUhCzUlO7Quy2oOquHVh39RBvQy9Bt6CrPx/Xb7fgNqTqVS8JyRZCbDRNjJM
         l52xCDuy9QqgeE67Sag284EOa2caIioqiKOxuHzltOLVtd4+uCraj70LlKxnVzfYXN1Q
         YE18I45yyhtTx9zvl6L6kD/ci21yjASA9V+9nGfsiUroYyHL1H5ODR0QoeL1OYQiMAgN
         8XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428375; x=1788033175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbRs6SJvz6u9cGosQWklZdWE9HBk6wlNApB8tJN/dPQ=;
        b=iFrv++hxpcl8zffYDHU7wGIp74EhYoO3HyHR8MWSnIBmsM/0kTF115rP7lzVDoh0/v
         j5L2QlrGxGx+dnzNEwNKANnmqVBJ35jOJ/AAZW+3SbZmqJv/+pqIa8Q7vs8Um3ci2gt7
         ck6GS1W6CxjeMcHh52Vu0omTXL9ZGG2bRvU9luIT/Ee+/yOsaScSq5M+EIhn/NvKhVNO
         dY9+zkhq2vms9rezKKUJntE3P1ym6tNDtLl6VSIxJSxRLSGeuxfCMd4NNQcbW0tlmsaa
         1zlViq44cKfEJs5hr9UYPyo4eNB62jM293yo5r6hCKH1hI70uco5SkaqXtVwkFN3EZcS
         qLfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrL0lUAnW3rW3WYb0HNQSM4Qt6Rt5yjI7FFcq7gQlhngCJDP0nC4L3ZGVAUZho7VJdEgGlEIP4=@vger.kernel.org
X-Gm-Message-State: AFuF++lX+/9swEdDXlbaBV1yMKmO8DMpQxHdnCDsn7RdfZfF3jxyHRZW
	ymct2HM9a9x5WENw9u2/sHQm1ybebGg01q4DxXMn5jelYiHS5loziC3lCxW7tHcbCJ4=
X-Gm-Gg: AR+sD10De17w4ca1GuRuMC6HLFusd3gPNf1YHwpvMBtMogUzPG9yG01f++k6rSxlzba
	NfqVtf4gtOad8uojnCM7jqaPgRuC0j3C+nx2I/8iUq95ZzZ9h8pn+GcHTxxvlLG/A66VphMJ5WD
	aC33uzphzHN9ty2azEmDtv1HzlSr/kNNqoJnlgAQXplYovlL7h5tHUl4KghAvq6iajKXOC0TO2G
	bPvfRFhEVhu2nguTC7Tk4cAeDMOZaVip0hRbvl8LQeRIMNO9mjh8GhESDgn5NHKqB34Cr6uNPHZ
	3WProLKE6RyC+LvsoMiFc3QIPVCecpFcS2k0K3H7BEKayAKfgtsf6AVoLE8NasAQ+MM/fVs4piF
	GL//asdX7Tjt+oSIx/CDycRfvgF2Xc5vp4E2Ji/IQ16t8MvM1z2o1jxRlsx/21OdDAdY7FcS7N5
	J+QBzZ2LLuRIBck3VaAYZTKjDBsRjUrnRD59Qa/Zf+orshRU5s4EO8Xl0rEk7iTIgACjFOLw==
X-Received: by 2002:a17:907:3d0a:b0:c20:83b1:396c with SMTP id a640c23a62f3a-c246a62b68fmr1552247666b.17.1787428375029;
        Sat, 22 Aug 2026 12:52:55 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2495ee5295sm475032666b.0.2026.08.22.12.52.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 12:52:54 -0700 (PDT)
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
Subject: [PATCH net 0/2] net: restore EEE on MediaTek switches and SoC MACs
Date: Sat, 22 Aug 2026 22:52:50 +0300
Message-ID: <20260822195252.2934-1-f@lex.la>
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

On MT7531 this undoes half of a deliberate arrangement.
Commit 06dfcd4098cf ("net: dsa: mt7530: fix enabling EEE on MT7531
switch on all boards") turned EEE on at the switch MACs while zeroing
the switch PHYs' EEE advertisement, and ended "With this change, EEE
can now be enabled using ethtool". Only the "off out of the box" half
survives.

Each patch fills lpi_interfaces from supported_interfaces, minus the
interfaces the MAC cannot signal LPI on, and corrects lpi_capabilities,
which takes effect for the first time as a result: neither MAC has EEE
force bits above 1 Gbps. Neither driver sets eee_enabled_default, so
LPI stays off until userspace asks for it with ethtool --set-eee. The
EEE advertisement is a different matter: phylink stops force-clearing
it, so a PHY that advertises EEE out of reset advertises it again and
the link may negotiate EEE, without this MAC asserting LPI. There are
two exceptions: MT7531's five internal PHYs, whose advertisement
mt7531_setup() zeroes before they are probed, and EN7528, where the
driver deliberately leaves both LPI bitmaps empty so phylink keeps
taking the phy_disable_eee() branch.

The two patches are independent and touch different subsystems; they
are sent together because they are the same bug.

Splitting each patch further - lpi_interfaces in one, the
lpi_capabilities correction in another - was considered and rejected: a
value that never reached phy->advertising_eee is not a reviewable
behavioural unit on its own, and the split would leave an intermediate
commit claiming 2.5 Gbps LPI that the registers do not implement.

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

No 2.5G mode is offered, which is the corrected lpi_capabilities, and
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

Aleksei Sviridkin (2):
  net: dsa: mt7530: populate lpi_interfaces to fix EEE support
  net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support

 drivers/net/dsa/mt7530.c                    | 24 ++++++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 22 ++++++++++++++++---
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.55.0

