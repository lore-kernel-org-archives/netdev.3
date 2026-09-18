Received: from mail-wr2-f24.google.com (mail-wr2-f24.google.com [74.125.225.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F53B2FCC
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696246; cv=none; b=boTJq3OGpLdHsOSvajo6uCYBjcz3Z0q+CXLfX+YPWSa3eM2qYbpVAGPo989j9PLlS/EPU/UVcjO0Mos/Oe6KKk6Cq4byp3qP/F0K+3BZJ/jY/04Z2MwMGdlJH5+9J//UIfLM6cXgN+M41bxF9FMb/JxzfQ4aP71pSnjiTQ/IC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696246; c=relaxed/simple;
	bh=E0wOOpnqksC/bK90AdSlqnmIRgi5A1PuPAb/wkskWy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=soBmwWuJ/5pgz3g3EOecuWOD6IERcODyLO1IenvLtkU9KU/keq5Diw4SrHG9wTs07/FuYvUWQ5AxL+/Otulwo31CisekOPpoCFdaqrAEGzzHe72kgEUHxFWXAJHGpPVKkRowwYuamgpjhn7PV+16ZZPkeHDVcnAFvhdPN4ntFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=UqKLbtDK; arc=none smtp.client-ip=74.125.225.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="UqKLbtDK"
Received: by mail-wr2-f24.google.com with SMTP id ffacd0b85a97d-482f63546c3so122156f8f.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789696231; x=1790301031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YYE+NZjc7oYjsnXdz0OWSvD8HmyTutfb/Rr1GZY97qY=;
        b=UqKLbtDKF+iabF4arITHvWmYi6MVFccENn9N7koKxz/QqbjYWVE5cS1HX9evYTWG+T
         1O+iaT65pdXYmJ7TjuANNW0wkJ2KjXCuZN0BqoHlhzooeTHsQramKuopUK7EaphDvGUN
         PkXBVtdoEtC2W8VqnKdRMjPW0breCcgzunFX6oap8Q9bgCAiYbqRm+LwU8RDol2XW5MJ
         2nt1smbMm/AL6/ge/9NI+iFB2wGK22+exf/Q1Honnm9h838UdE8bIrKL92chKjGUSsOt
         f3I/wGaY/GOw7GIsgpHYRw4ZTHfBnTpQsb1+u60g84LSFmLtWU7OiGrdWIaHWlebxMQI
         EA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789696231; x=1790301031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YYE+NZjc7oYjsnXdz0OWSvD8HmyTutfb/Rr1GZY97qY=;
        b=ysbLFhT03aLUgS93wxlIU/n0n8BiNIltGD/IyeffvERK2V/+/HDjlC92PBjsCs+R6e
         KeepjPX62KFkINDoWGr+GAsc9OhWRXcJbHfGjeMB+O6awvGYKYKeo9M+Q5GDK9mgLGHo
         G5zlauu4DXoD9rtiAi8wIJhoAsCRfL1r4zuFL+Am6U9Io2NfwXWgNe4FCok5aHnD2PFC
         mf+vlnCWPaK0cmxSANbNpS2ZtgLonF3fezOaFDrj7m3yp4gFhlH5yNaWU3Gw7mt23wez
         rsPP3YJdd6/LklaE+aFKgiU3qqTkSZ7rhxdFr29xPvGSWBZvtU4cLmFpXL1JHpMj8X/w
         6gJg==
X-Gm-Message-State: AFuF++ndIUc9CxermGSyUukm6NodthSeH1td7bxO7qZF51jdkJ7CUegx
	TewcbijcRsq720YYRE+nttr+ZGou0b5FhHyma60UWvmZFrzFfMjFMDh0/D/qHspIwRB4q5pWsGZ
	5pL30vRjljnr8
X-Gm-Gg: AYBFou0pKUbP/fbw/7Sb/rK/MiwgC0ox2v1bOyanhMX1iypMLp+I+1zW0y23JTeBXsY
	Q0KY1aXEcb3lQl9nMsvcfv02UDy3s7keOv9hvGxapkM2mBEc5VTpipfoV2PndsB3dhiUSFaKPFI
	igjEgjeGywHmXVzc8cp28jZhKnYGdDzxRKRkOhN9bDgkZD9QE78POVkEuquQPLW6WBYL2x/Frfw
	ol/fv2N/5idAiY+6Ftuy+GYw4unrM1TL9WY4ruXT/7U/3KgLdUF6by8ERLtgFtakGQ6vDrrVzeO
	fwqU9TO95O783QXmc3/Nm/gl8hR2kvDbGkVWSvrhw5CaA4S+kXVAvsULXbczczfB6BtsGU2/t1E
	oQl5b0GUnPGSbFYna6UORHxU69Ots222PI+pEmvtSqXPZbZs5jMrrm8CO/hGfOgkMKrm0o8odDO
	RQ0PHUMTCUVYPlAeFe6FfpzectuB3yLjYUZTzBbRBYR2j32SZzBw==
X-Received: by 2002:a5d:5d13:0:b0:487:73c:3f9 with SMTP id ffacd0b85a97d-4871e22069amr1089481f8f.22.1789696231608;
        Thu, 17 Sep 2026 18:50:31 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487200745b5sm64224f8f.26.2026.09.17.18.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:50:31 -0700 (PDT)
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
Subject: [PATCH net v8 0/4] net: phy: keep a PHY interrupt across a generic bind cycle
Date: Fri, 18 Sep 2026 04:50:25 +0300
Message-ID: <20260918015029.2518425-1-f@lex.la>
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

Aleksei Sviridkin (4):
  net: usb: lan78xx: register the PHY interrupt with the MDIO bus
  net: usb: smsc95xx: register the PHY interrupt with the MDIO bus
  net: phy: take the interrupt back from the bus on detach
  net: phy: restore the interrupt when the generic bind cycle fails

 drivers/net/phy/phy_device.c | 5 +++++
 drivers/net/usb/lan78xx.c    | 7 +++----
 drivers/net/usb/smsc95xx.c   | 1 +
 3 files changed, 9 insertions(+), 4 deletions(-)


base-commit: 3b95a04eb5f95bf6a016a1bb9ff37d3eee48de63
-- 
2.53.0

