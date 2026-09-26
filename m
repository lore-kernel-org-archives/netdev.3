Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883B367B90
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466634; cv=none; b=Jdr9UIzWWNKWoJivGhP6RWcdSVD7JUJ497TIstvzTt6wAaKP+yJqLh1OdxBaNk2rUab0XddwtY5Grhm5ulF8YSKkKXRFrXmkt92e6cSuzeZvy2MWku+Vd5JRYmSvLBXm8rxTye9YKK74sDXUetc1+nbWecNu1iUcjwaT4+WQF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466634; c=relaxed/simple;
	bh=ESOcNByc3LVXoxPrXBMSaU71Ez1XvvjCHDyIdcCieWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmaHdm+dWTSEvwcWG2V4a9xLuhxYy3OOS9/HT31xatPqaJjBEhI1QmIT01zDKyNknTer7Oc7VelLzGd6g+mmHrhJsw61e5Mbza0ojeHFlrR5KT61ouGGdmw2VZ6dkw60J2kdCUmjZh3IHENO7qkA6Gc+TYvF9danXeHE0c9XfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=gp6WKSAQ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="gp6WKSAQ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so10693215e9.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 16:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790466630; x=1791071430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pSyNKKjitWi91gCWx+INZ7np71BoC2Vf6vzCTb3QS3I=;
        b=gp6WKSAQDKyV3bmPOUxmJkwoxQrg8+d3Al5NdCG7FrQ8J0N191Xt7hrmqEN9FEB3bO
         6COnHUi2i6oDOkG6hSxMcVSLS1a4sRs/PI7EeQfeNwVmvsFqYhQjWT5e6pM0lfUIepoE
         ySnlg80Gy9MccIVAFByVPgjwmQTr2RgU/fmF+df3kH+0fT7DdEc+UgAC9XqPkLgQleHT
         Syie36LXblK0btpukV65wbvHg+qXF2uWDg0/uYj59M0P/FakUnNbOjZRwHgmR1DnKdQW
         l3HzXAo0XV03AvigR+WYLZ5JByJShFdvBvxc0sJFI5YpDzrLv7qVuuk+P91JGC0WFwJs
         i0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790466630; x=1791071430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pSyNKKjitWi91gCWx+INZ7np71BoC2Vf6vzCTb3QS3I=;
        b=1KouGUK9VdBb/XbnyEMBalIHQKxXZmG0jfpN+7V26Ua+/0xAld4EnHQ87tJ0zqMivE
         uA3065Ew6v5/XZqcZlYCQNZTsozBe7TKJXFGM7FS/Hebc550f8SfWazz3irxdWtQkee1
         Eeks7jdEiS8gPqe7deBfP0hS6NlBB0CJswIFhnwx199mhzG52OdLV9CP8Uh5123aErbs
         tiOIkUIwURVqseo41HX00UCGjUeZIebcJ0kaFJs7/TjLTm8tJzKSMUDK2aQ5J9ekfqB3
         xdbNYx8FI6XC/fHBYSKcW1JqkxTpH7hHorfZ7AnMb/ZesMsGGhZUeJ3vHYrROD2B2tdH
         11gQ==
X-Gm-Message-State: AFuF++lFInPjzbwo/qA2QnZjav87Zz2BqR8/FMto8USZaDYlZ7GTMX91
	nt3SJtW/SP4ihbIwYKrzbm9aKFT+XWrDTyv0g+AojAVRno2AXBd7fEfzvth3eHT2pslBxo8tjbc
	+jo2AOG3Reg==
X-Gm-Gg: AYBFou0RALNukawAQIDTvMPZ1eJ2RuNe1wGtfFeXI72vcC21XdoLx+6LMZgSAL/aKzf
	IDs8t26iCtc5nRphGpV/MOnvLEW3BhSExdf7F8yVe06HDaqPPR4wDABxYta55LSgRyZ+nIX9Avu
	VwL7c/1qs+iJFFl5GNuHEA2f+TYaxuCOR4P7KBe+0+izKNSUrRtVOMKUwDaRhw5+W4X6YcrAWXE
	gstWechppysFKossvmM5PDT9mLTql8ethh8yPYmb95/EzGxyRuT/jxULiDph4eUMm+hehosb1zj
	r74BIDWu5raI2r3lhXrD/YHuz68DNfw/0D03kcgvmJ+tBYWyJFZNvz3xfwQwlEP1SgEpFLDxC/c
	rhV78XkaHnM7MoKoxBkCWDwQJMvMKnIFjHYmsIEYU2VMsDxRKo8gbh2Mnp/CfdMxxcRFpPU5gzC
	7F5nH2k8K8p4RkJrCcFtP4KaPyluvC1n9gucQboFUp3mytPBC6xl8=
X-Received: by 2002:a05:600c:a08:b0:49e:73e7:888c with SMTP id 5b1f17b1804b1-49fe66c8a3emr178973425e9.4.1790466630135;
        Sat, 26 Sep 2026 16:50:30 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349fa1sm24716798f8f.8.2026.09.26.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:50:29 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	f.fainelli@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v11 0/4] net: phy: keep a PHY interrupt across a generic bind cycle
Date: Sun, 27 Sep 2026 02:50:20 +0300
Message-ID: <20260926235024.705646-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Keenetic KN-1012 (MT7981B, MT7531 switch), the Airoha EN8811H
behind lan4 has its PHY driver as a module on the root filesystem. The
switch brings its user ports up before that filesystem is mounted, so
the PHY attaches to the generic driver first. phy_probe() replaces
phydev->irq with PHY_POLL because genphy has no interrupt callbacks,
nothing puts the number back, and the PHY polls for the rest of the
uptime once its real driver takes over. The devicetree describes a
working interrupt for it and the number is never used again. On this
particular board the port does not come up at all while that happens,
because phylink rejects 2500base-x against the generic driver and DSA
drops the port; it is the PHY that carries the lost number across the
cycle.

Patch 3 takes the number back from mdiobus->irq[] at the end of the bind
cycle. Patch 4 covers the other end of the same cycle: a genphy bind
that fails inside phy_attach_direct() unwinds on a label that does not
reach phy_detach(); it puts back the value the field held when the
attach started. Patches 1 and 2 put two USB drivers' interrupt numbers
into the bus table, so that there is something to take back for them as
well.

What this does not cover: phy_probe() makes the substitution for any
driver without interrupt callbacks, not only for the hand-bound generic
one, and phy_remove() does not undo it. So a Generic PHY bound through
sysfs, or a real driver without interrupt support unbound through sysfs
or rmmod, still leaves PHY_POLL for the next driver. Undoing it in
phy_remove() is what v5 and v6 did - v5 from a saved field, which Andrew
asked to drop, v6 from the bus table behind a phy_link_change check that
races phy_attach_direct(), as nothing there holds a lock in common with
the driver core. Removing the substitution, below, closes those paths
too.

On the board above the number reaches that table through
fwnode_mdiobus_phy_device_register(), which writes phydev->irq and
mdiobus->irq[addr] together when the PHY node carries an interrupt; the
EN8811H hangs off the SoC MDIO bus, at the devicetree node
/soc/ethernet@15100000/mdio-bus/ethernet-phy@d. A driver that owns its
bus can fill the table itself instead, and several do - mt7530 writes
irq_create_mapping() results into ds->user_mii_bus->irq[] before
registering the bus, which is where the switch ports' own numbers in the
notes to patch 3 come from, and mlxbf_gige writes an ACPI GPIO interrupt
into its bus table too, though after registering it and after
phy_find_first(), the way stmmac does.

Andrew asked [2] for the full set of drivers that keep the interrupt
outside the bus, "so that the bus is the source of truth" [3]. Going
through that list against net/main, in his grouping:

  - lan78xx and smsc95xx write a live interrupt into phydev->irq only.
    Those are patches 1 and 2.
  - ucc_geth never writes the field at all; its single use is a read in
    ucc_geth_open() feeding device_set_wakeup_capable(), so nothing to
    change, as he said.
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
    it after connect - tsnep unconditionally, bcmasp for its internal
    PHY and genet for an internal PHY that is not on v5 - so what a
    restore hands back is replaced again.
    icplus sets it from ip175c_read_status() for its switch ports and is
    safe for the same reason.

The v7 commit message also named sxgbe as losing the interrupt. That
was wrong - the same dead probed_phy_irq guard - and it is gone.

The review [4] asked how this sits with Documentation/networking/phy.rst
telling MAC drivers to set phydev->irq directly. That contract is
per-connect: set it "before you call phy_start". The restore happens in
phy_detach(), between connections, so the value a MAC installs after a
connect still stands when phy_start() runs.

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

Changes since v10 [9]:

 - Patch 4 restores the value phydev->irq held on entry to
   phy_attach_direct(), kept in a local, instead of reading
   mdiobus->irq[] (addressed review). The label is also reached when a
   second attach of an already attached PHY fails its bind, and there
   the bus table would have overwritten the live number; nor does the
   table hold a PHY_MAC_INTERRUPT that a MAC wrote into phydev->irq
   alone.
 - Patch 4's changelog no longer claims its store is ordered before
   d->driver is cleared (addressed review). Two plain stores are not
   ordered for another CPU, and the unwind runs without the device lock,
   as the bind it undoes does.
 - Patch 3's changelog said the generic driver stays bound until the
   release. After a sysfs unbind of it under a consumer,
   is_genphy_driven stays set with no driver bound, so the store can
   meet the probe of a driver binding meanwhile. The changelog now says
   so, and why the next attach still requests a number that matches the
   driver bound then (addressed review). It also says that a
   PHY_MAC_INTERRUPT is replaced under the generic driver, and why that
   is harmless in tree.
 - Patch 1's changelog said a devicetree PHY node "still" overrides the
   table. Before this patch the driver's own write came last and won, so
   it is a change, and the changelog now says so.
 - The paths this series does not cover are named above.
 - Patch 4 touches the error_module_put lines that patch 2 of the attach
   guard series [10] also rewrites; whichever lands second needs a
   trivial rebase.

Changes since v9 [8]:

 - Patch 3 restores under is_genphy_driven rather than above the block.
   Unconditionally it also wrote a field this series has no claim on: a
   MAC installing PHY_MAC_INTERRUPT writes phydev->irq alone, and a
   phy_request_interrupt() that failed left PHY_POLL there while the bus
   table still held the number that could not be requested.
 - The v9 cover named a behaviour change, a PHY_POLL fallback from a
   failed phy_request_interrupt() no longer surviving a detach. The
   scoping takes it back, and that paragraph with it:
   phy_request_interrupt() runs behind phy_interrupt_is_valid(), which
   is false for as long as the generic driver is bound, so the fallback
   never meets the restore.
 - The -EBUSY sentence in patches 3 and 4 claimed more than the code
   gives. The prober's half holds - __driver_probe_device() returns
   -EBUSY while dev->driver is set - but neither the hand-bind in
   phy_attach_direct() nor the store in phy_detach() holds the device
   lock that device_bind_driver() asks its callers for, so what is there
   is statement ordering. Both bodies say that now. Taking the lock is a
   separate series.
 - Patches 1 and 2 keep their code. Both changelogs now give the real
   reason for filling the whole bus table, which is that a loop is
   smaller than a second branch on the chip id; phy_mask already pins the
   address to one entry everywhere except lan78xx's 7801 and smsc95xx's
   external PHY.
 - Patch 2 also puts the declarations in smsc95xx_bind() back in longest
   to shortest order: the i it adds had made the int line longer than
   the char line above it.
 - The question whether lan78xx's fill of the bus table overrides a
   per-PHY interrupt from the devicetree was against the v8 shape, which
   wrote the entry in lan78xx_phy_init() after the bus was registered.
   Since v9 it is written in lan78xx_mdio_init() ahead of
   of_mdiobus_register(), and
   fwnode_mdiobus_phy_device_register() then overwrites it from the PHY
   node.

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
   ahead of the release puts it where the generic driver is still bound
   and a driver registering meanwhile is turned away with -EBUSY before
   it reaches phy_probe().
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
the patch and 15 with it, 15 being the irq the devicetree interrupt of
that PHY maps to.

Patch 4 needs a generic probe that fails, which the board does not
produce on its own, so it went through a debug-only module parameter
that fails it once for one address. The connect then ends in -EIO rather
than the -EINVAL of the validation path, and the unwind takes the label
that patch touches; the same reading is -1 with patch 3 alone and 15
with both. That was measured again for v11, whose patch 4 takes the
value from the local, on two images of a 6.18.52 distribution kernel
that differ only by patch 4.

Patches 1 and 2 are compile-tested only - I have no LAN78xx or LAN95xx
device, and a Tested-by from someone who has one would be welcome.

[1] https://lore.kernel.org/r/20260909204306.2374562-1-f@lex.la/
[2] https://lore.kernel.org/r/8f67d3ba-ce25-49bf-8378-c76d748879a9@lunn.ch/
[3] https://lore.kernel.org/r/a2a2a8fb-97c3-498f-9bf4-e0c44be2eff6@lunn.ch/
[4] https://lore.kernel.org/r/20260915005946.823736-1-kuba@kernel.org/
[5] https://lore.kernel.org/r/20260918015029.2518425-1-f@lex.la/
[6] https://lore.kernel.org/r/df5d4af1-a86a-4820-9aeb-b1449a60f37e@lunn.ch/
[7] https://lore.kernel.org/r/6e14d6b7-2a5a-40e2-920e-fc69a6e85173@lunn.ch/
[8] https://lore.kernel.org/r/20260919015326.499479-1-f@lex.la/
[9] https://lore.kernel.org/r/20260922131955.4175785-1-f@lex.la/
[10] https://lore.kernel.org/r/20260924215951.2127682-1-f@lex.la/

Aleksei Sviridkin (4):
  net: usb: lan78xx: register the PHY interrupt with the MDIO bus
  net: usb: smsc95xx: register the PHY interrupt with the MDIO bus
  net: phy: take the interrupt back from the bus on detach
  net: phy: restore the interrupt when the generic bind cycle fails

 drivers/net/phy/phy_device.c |  4 ++++
 drivers/net/usb/lan78xx.c    | 12 +++++-------
 drivers/net/usb/smsc95xx.c   |  6 ++++--
 3 files changed, 13 insertions(+), 9 deletions(-)


base-commit: 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d
-- 
2.53.0

