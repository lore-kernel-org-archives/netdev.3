Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F930C35F
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782815; cv=none; b=G3K/cPK3W5tlz9skxaNiknG6fCQG7fHrLqiK3Yf2O0iAYylhSXo6oCiHlZ7FKKOUDlEWWnTAEkz19RGpqKNdd7YBWc9Xa7HtE+oRnSB3bLbNZSgDl5k5HAK19yxzhbAoBA/w1ALtQsoxSsrn5gC0PpiJbtTNCgCV346scb82AQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782815; c=relaxed/simple;
	bh=sok6ZbvG2oYK/j21SYwCUAYKowsHuwpobv2udZM6K18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVVEBApM4tcO5xIu+Th2QDSlAg1XudTaRp8skrU8fCcNw3V8onZyV38ylBpAsDFAP4CG2CQVkqB6L7rI1erM0qiCLy2IvPYbRwOI0TYulwD6F1tiWSvHJN+qavM40oRzK0wTuwZIHn1dc4j8rxNKTy9HmVzpk54GzGxCeDB/59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=GtZtctMZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="GtZtctMZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso11595045e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789782812; x=1790387612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RpQg1/jWZmhf3sNxkzE4wIZy2eU9EXWek6LxmzsP1F4=;
        b=GtZtctMZB+ly/I1GkrTg7Ji06x8sWjV2/65SgtJRqSaTJ5csfPw91OyIWgzPvhlN69
         vgWZha2GRp3ZO8GNlQeQqbtVg22fK+zUy38q8JRRXhFULQQzMHzZqRi52PJwcwYLksYD
         qCHxWRlQ8BjSBi0eSGvL3JhNi4uPHENsVG+Kmm/AeEZSM5clkRsKs29hrVipuCCFgope
         yAowzW1cVlJ0nvy2jhXwvI9UGTmmuKUQhcbAiGa/yI3Gaao7eaenq+ECQLvs/r/fatK+
         n/x3fEIMYN8jewc9aOJlxQI2YKUPHlbKG2TbD68ziGzV667pjajqAm+JaJupBwwNCMf3
         ts+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789782812; x=1790387612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RpQg1/jWZmhf3sNxkzE4wIZy2eU9EXWek6LxmzsP1F4=;
        b=hB89+jmKThzkBjsqM87DOvdoNta1a23camfwQrvvGpfe+IORvwlrce7YPHaUqhjz6J
         YA0s+SQuLHXkqBh9Z5eh6IcJ+QhNsBpqWlHncKUlOLLO1giAFNz2vCkCmKJkatfXalXs
         g6x62M+TYh1wqT8yfHXCKM+yjtl3YGMOMlOX5NwzhIY06HHc+YupzHroDE13PEfM8HrL
         tZ795VOzghE3I0ceKbsLTDysCKDqPaYdC6PZoMhJ+GsgD2H6DixlcCS0xtbfiVjSyfus
         K6hf9VfNKex116thPD8Yg4pkeEv3BKO6bpe49PN6OWFfyexOAm99c8DwbECWPqIxoshh
         b01w==
X-Gm-Message-State: AFuF++kqfuhu0cWwzg3Sngv/0syH/owyRH2E7pG9Kd7fax+7ihqsLDnt
	tWpPKqXkDzeqBYgTO0MxEGzTrBW3CBTxHHiUX/ICBJlh09FgNEjU5lmnfO+ztkrKEujjuC3sY3u
	Wsrypa7CZOM7Z
X-Gm-Gg: AYBFou0H09c/TdjD/Xc9/LfdeoSaRVkie+FqWIRQ+M30STSeN3O9soRujzyRzfsoWxk
	kKS8NozkC7de/wazrPh3Iay3WFF5LOME/zdiZV7iRz+64xFaClaP0haif3T5idrVtlYaj9qq7aQ
	ZXABWtT+DXyL6gXdhpf2SUV3CRwOaGWUkgNLFn2rVNvRf+OyGVWvZEN4W5X3wQ7YtQhduvMb4nr
	DFbFomMGx10L2oC8Tuu2r95PZyYW00+F6W9puRE6H0NUqr7SuwAJ8l50KRmtofMTPQKYLE44WVd
	DDthQioq075V0jPFGXV4zgv79EUL3QFb7cx6FKXbhcu1LdxEcoT1nuVQw6MEc3+voVkqek+ISMp
	ohYK5vldoYPy1jAL3HIB4nr4/N2wyGUOtdhayC69H2f+Xu829xPmQ5GYSzn5hm3Sq0H6VsSOi6k
	ymYJxcqy5dLDjy6PqSgBVM0OsingWQ1Qt6o5QP0pZfDA/Tkkwwbj8=
X-Received: by 2002:a05:600c:530f:b0:49d:243a:e4f9 with SMTP id 5b1f17b1804b1-49fc56cb197mr54635195e9.10.1789782811921;
        Fri, 18 Sep 2026 18:53:31 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d174sm34946045e9.11.2026.09.18.18.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:53:31 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v9 0/4] net: phy: keep a PHY interrupt across a generic bind cycle
Date: Sat, 19 Sep 2026 04:53:22 +0300
Message-ID: <20260919015326.499479-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On an MT7981B board with an MT7531 switch, the Airoha EN8811H behind
lan4 has its PHY driver as a module on the root filesystem. The switch
brings its user ports up before that filesystem is mounted, so the PHY
attaches to the generic driver first. phy_probe() replaces phydev->irq
with PHY_POLL because genphy has no interrupt callbacks, nothing puts
the number back, and the PHY polls for the rest of the uptime once its
real driver takes over. The devicetree describes a working interrupt for
it and the number is never used again. On this particular board the port
does not come up at all while that happens, because phylink rejects
2500base-x against the generic driver and DSA drops the port; it is the
PHY that carries the lost number across the cycle.

Patch 3 takes the number back from mdiobus->irq[] at the end of the bind
cycle. Patch 4 covers the other end of the same cycle: a genphy bind
that fails inside phy_attach_direct() unwinds on a label that does not
reach phy_detach(). Patches 1 and 2 put two USB drivers' interrupt
numbers into the bus table, so that there is something to take back for
them as well.

On the board above the number reaches that table through
fwnode_mdiobus_phy_device_register(), which writes phydev->irq and
mdiobus->irq[addr] together when the PHY node carries an interrupt; the
EN8811H hangs off the SoC MDIO bus, at the devicetree node
/soc/ethernet@15100000/mdio-bus/ethernet-phy@d. A driver that owns its
bus can fill the table itself instead, and several do - mt7530 writes
irq_create_mapping() results into ds->user_mii_bus->irq[] before
registering the bus, which is where the switch ports' own numbers in the
notes to patch 3 come from, and mlxbf_gige writes an ACPI GPIO interrupt
into its bus table the same way.

Andrew asked [2] for the full set of drivers that keep the interrupt
outside the bus, "so that the bus is the source of truth" [3]. Going
through that list against net/main, in his grouping:

  - lan78xx and smsc95xx write a live interrupt into phydev->irq only.
    Those are patches 1 and 2.
  - ucc_geth never writes the field at all; its single use is a read on
    the WoL path, so nothing to change, as he said.
  - ixp4xx_eth, ax88796c and emac-mac force PHY_POLL into phydev->irq
    around their connect, and each keeps doing it. ixp4xx and ax88796c
    store it in probe just after the connect succeeds, and their only
    detaches are their own probe error path and remove. emac-mac stores
    it early in emac_mac_up(), on the line before the connect, and that
    runs on every bringup. No attach in any of the three follows
    a detach without the driver forcing PHY_POLL again, so a restore in
    between cannot cost them anything.
  - stmmac_mdio already writes mdiobus->irq[] next to phydev->irq, so
    it is on the right side of this. The block is also unreachable in
    tree: it is guarded by probed_phy_irq > 0 and nothing sets that
    field, in stmmac or in sxgbe's copy of it.
  - mlxbf_gige likewise writes the bus table, from ACPI.
  - bcmasp_intf, bcmmii and tsnep set PHY_MAC_INTERRUPT, and genphy does
    not touch it: phy_interrupt_is_valid() is false for both PHY_POLL
    and PHY_MAC_INTERRUPT, and it guards the substitution, so the
    generic driver never demotes a MAC-served interrupt. They also set
    it after connect - tsnep unconditionally, bcmasp and genet for their
    internal PHY only - so what a restore hands back is replaced again.
    icplus sets it from ip175c_read_status() for its switch ports and is
    safe for the same reason.

The v7 commit message also named sxgbe as losing the interrupt. That
was wrong - the same dead probed_phy_irq guard - and it is gone.

The review [4] asked how this sits with Documentation/networking/phy.rst
telling MAC drivers to set phydev->irq directly. That contract is
per-connect: set it "before you call phy_start". The restore happens in
phy_detach(), between connections, so the value a MAC installs after a
connect still stands when phy_start() runs.

One behaviour change worth naming. phy_request_interrupt() falls back to
PHY_POLL when request_threaded_irq() fails, and that fallback no longer
survives a detach. A board with a broken interrupt line still ends up
polling, exactly as before, but it now says so once per attach instead
of once per boot.

Longer term the substitution itself is what wants removing. There are
two of them and they are identical - phy_probe() and phy_attach_direct()
both do "if the bound driver has no interrupt callbacks and the number
looks valid, replace it with PHY_POLL" - so phy_interrupt_is_valid()
could ask whether the bound driver can service the interrupt and neither
site would need to write anything. That reaches every caller of the
helper, so it belongs in net-next and not here.

v7 1/2 ("net: phylink: unwind the PHY binding when bringup fails late")
has nothing to do with the interrupt and is posted for net on its own
alongside this series, which is why the patch count changed.

Changes since v8 [5]:

 - Patch 1 fills the lan78xx bus table before the bus is registered
   rather than one entry after the scan, and drops the write to
   phydev->irq that phylib now does from the table itself [6]. The
   netdev_dbg() that printed the field goes with it -
   phylink_bringup_phy() prints the same number, at info level, as this
   driver connects.
 - Patch 2 does the same for smsc95xx, and drops its phydev->irq write
   [7].

Changes since v7 [1]:

 - The restore moved above device_release_driver(). After that call the
   mdio device is bindable and the device lock is dropped, so a
   phy_probe() on another CPU writes the same field. Holding the lock
   across both, as the review [4] asked, is not available:
   device_release_driver_internal() takes it itself. Ordering the store
   ahead of the release gives the same guarantee, since the generic
   driver is still bound there and a driver registering meanwhile is
   turned away with -EBUSY before it reaches phy_probe().
 - New patch 4 for the phy_attach_direct() failure path. The v7 commit
   message claimed detach covered every substitution; it does not cover
   that one.
 - v7 2/2 carried no Fixes: tag at all. It does now, and patch 4 has
   its own.
 - New patches 1 and 2, for lan78xx and smsc95xx.
 - The sxgbe claim dropped.
 - The phylink patch split out, see above.

Patch 3 is measured on that board. The one condition arranged for the
run is that the PHY driver module loads after the root filesystem
instead of from the early boot list the distribution normally uses -
that early list is also why a shipped image does not trip over this.
The distribution's own late-PHY handling was also removed, that being the
one patch which could have changed the outcome; upstream has nothing like
it. The unwind block of the phylink patch posted alongside this series is
in the kernel too and is not reached on either path: the -EINVAL failure
returns from phylink_bringup_phy() at its validate call, before
pl->phydev is assigned, and the -EIO failure returns from
phy_attach_direct() before phylink_bringup_phy() runs. The kernel is
still a distribution one and its remaining patches to phylink and
phy_device do run on these paths; none of them writes phydev->irq. The
generic driver then binds at 1.87 s and the real one between 13.4 and
13.6 s depending on the boot, and phydev->irq afterwards reads -1 without
the patch and 15 with it, 15 being the number the devicetree gave that
PHY.

Patch 4 needs a generic probe that fails, which the board does not
produce on its own, so it went through a debug-only module parameter
that fails it once for one address. The connect then ends in -EIO rather
than the -EINVAL of the validation path, and the unwind takes the label
that patch touches; the same reading is -1 with patch 3 alone and 15
with both.

Patches 1 and 2 are compile-tested only - I have no LAN78xx or LAN95xx
device, and a Tested-by from someone who has one would be welcome.

[1] https://lore.kernel.org/r/20260909204306.2374562-1-f@lex.la/
[2] https://lore.kernel.org/r/8f67d3ba-ce25-49bf-8378-c76d748879a9@lunn.ch/
[3] https://lore.kernel.org/r/a2a2a8fb-97c3-498f-9bf4-e0c44be2eff6@lunn.ch/
[4] https://lore.kernel.org/r/20260915005946.823736-1-kuba@kernel.org/
[5] https://lore.kernel.org/r/20260918015029.2518425-1-f@lex.la/
[6] https://lore.kernel.org/r/df5d4af1-a86a-4820-9aeb-b1449a60f37e@lunn.ch/
[7] https://lore.kernel.org/r/6e14d6b7-2a5a-40e2-920e-fc69a6e85173@lunn.ch/

Aleksei Sviridkin (4):
  net: usb: lan78xx: register the PHY interrupt with the MDIO bus
  net: usb: smsc95xx: register the PHY interrupt with the MDIO bus
  net: phy: take the interrupt back from the bus on detach
  net: phy: restore the interrupt when the generic bind cycle fails

 drivers/net/phy/phy_device.c |  5 +++++
 drivers/net/usb/lan78xx.c    | 12 +++++-------
 drivers/net/usb/smsc95xx.c   |  6 ++++--
 3 files changed, 14 insertions(+), 9 deletions(-)


base-commit: 3b95a04eb5f95bf6a016a1bb9ff37d3eee48de63
-- 
2.53.0

