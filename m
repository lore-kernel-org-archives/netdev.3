Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE63C3C16
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716784; cv=none; b=fsAvtc89OieHhFqj6Z+jCrJocmY44OvhVF+q+ZZakOye/B2TpfWUtibuazsK+G0dwCkU1G6RW9BUgH0Pl3snCfEBpGjyr9lWX6Dyz8WLQR43O73bQf3n3LwA9iu8Ao+Pi6SKurfG8GohGLZa9Cmyk3c/QSvdbQjVyQm2N6r40aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716784; c=relaxed/simple;
	bh=reABiZxJ7PsfqVzCcw0Lhbf+B6p+1gck7irq6fyFe0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ibh/7SQDlFb/a/JcuG49Bl6UU5nZjjnL2DFp4HbFcf/pz4zStntFEdiTo5NwYYINZyESYRkii11YKa94p7Iip9AtM0XbI+EHppX9AIH/RZSmPvbjkMTaWtxk+JupAYqaHhZ3o0RsAmV732I+Aola1hRlTDwnjiZaVFFf5nMU+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=SndKcXF7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="SndKcXF7"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48584dc164fso2607789f8f.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788716781; x=1789321581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOFYlZkSDu1jvVl3VNvgtaDGiXZI7F7ooowek+EiJPQ=;
        b=SndKcXF7a+RaqZlN6O22ALwew8BEor6a1AjTVvdyZ3CSwHVS0sVDaauVY5VSZipmFa
         /LGDhbvt2RzvbD1Q7rJjRsNZXdlU4vbqxsCVX605W78o8xhN6uQuzWI7vRiRzbmIeWJW
         QcnnkWOpt9xCQCO8N1Ba0jdpAvbmcyv5+BeKS9paj51vhIQucrr8nGUIht8K6jtiuAlY
         D1bAazmCV56VTaHeC4w7EbqHBd+is0Y/gvmfiDEW1E+FB75SkqrnxsZ0UP7XgJ8Tgk1W
         DLV+HvuWA9nY7ntj34NRNJvWUsr7uInS/hArVlR/pCkAIRQNHQx3jlIO+YW4mocB3KuO
         1RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788716781; x=1789321581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOFYlZkSDu1jvVl3VNvgtaDGiXZI7F7ooowek+EiJPQ=;
        b=L2f3IcxNYJiBumHS4o1EEUhNXAmfjCj18S4JKAZjMiB478z1R8WlETQaS50mhyFmN9
         pnsLK2a+ojkxORAheKDNpuHQZveDAniX3eqmA1j4XeRwWSWHdxEja4wz4JXrxYnSmJHt
         +oHNU++SoflntBXZugkOPbUcPwz/fKi613p72azbwOXaPhSZLY+SqMlFrWxINxHCljAd
         Adz1cpEM9CtgXBAvIiPLOYJ7wAWrmi58jrdrXzAxYdOD5YKaPibG6mFh9c5GbkAPHRE0
         6lBF91rcQlKKkvOaTvaVdKKLhMqA/Xtl11jNk43QYAMX561FGkPGvgAa4VCr1iyDfmet
         vQWA==
X-Gm-Message-State: AFuF++k1cSfYwpPERTt+QIlUNuA3ebQKdZZ09qfVeRUtRbgLvNWbVj3R
	BOX8cfVif3/WUXK+VDY5DhGtRq7Lsmn1AAyyGOJjvMFO/piZaoV39iQTfJ45TUftXw8=
X-Gm-Gg: AYBFou09iYYkoHdQkZiblYLAXIBVjt2d5nlgDqnSUpfGEb5hRduL2ieljM0CDqn+XIW
	MYvMybbTkFmso3rtdm8AU8fepL9AThKkXWePJFS67Nn+qPaJQ4mmrlSs6/C3ss55+jWCdLTrBS0
	ocbe2fDWURgD0ai8CYYa6b5PbtNerBFX7c1YcaUM20ohZuyumjfGqAPi6C84o+MGm2stWxb7Z28
	UuHUqhEC1+Lr6UWnb1zHhjlHSA95ravdgPLII8G+SAtKJNN4VhBiAZgmCKSTWRW3VJiIYnhupjM
	Eh7fjMEN8JAlmWjcrWxQ4+6fYNidHHQEsMAVbGcR5/+g6rUC4V1zQbP1P9/866SO2RJ8noNZ8C5
	dobX3rkwc+e6gc2PnlKZwr6l1q0bbW1Gzk7G3bk578nVHfDPd3vGEkgrLCNEerZKIAvc/GEgqyO
	rg8EqmkIuap7sKbQY2CGp6RwZCvxzh5fKSWRF0mbQ=
X-Received: by 2002:a05:600c:3b18:b0:49c:fa21:1c8a with SMTP id 5b1f17b1804b1-49cfa211d97mr149116625e9.31.1788716780986;
        Sun, 06 Sep 2026 10:46:20 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6158e9sm331528735e9.12.2026.09.06.10.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:46:20 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 0/2] net: phylink: wait for a PHY that probes after the MAC
Date: Sun,  6 Sep 2026 17:46:17 +0000
Message-ID: <cover.1788711837.git.f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY whose driver or firmware lives on a filesystem cannot be
connected when the MAC probes, because the files become readable long
after the MDIO bus was scanned. Today the port that names such a PHY is
dropped at probe and stays dead for the whole uptime, and nothing
retries it.

Let the port declare that with phy-needs-host-firmware and poll for the
PHY instead of failing. Patch 1 adds the property, patch 2 does the
waiting.

This is one half of an RFC last posted whole as v2 [1]. The other half
describes the chip that drove it - the Airoha EN8811H, an MD32
microcontroller that answers a PHY ID from power-on and becomes a PHY
only once the host writes firmware into its volatile RAM - as an MDIO
device that owns the download and the reset line. The halves touch no
common file and go to different reviewers, so they are posted apart;
the other one is at https://lore.kernel.org/r/cover.1788711797.git.f@lex.la/ . They are
not alternatives: this half alone carries a board
whose chip answers its ID before firmware and whose PHY driver is a
module, and the other buys the cases that are not that - chips mute
before firmware, a built-in PHY driver whose probe fails once on
missing files and is never retried, and reset ownership. The last one
matters here, and I say why below.

The poller waits for a driver that has bound, not for a device that
exists, because the generic driver would otherwise
bind and cannot drive such a PHY. The test cannot be made to hold past
its own return: the device lock that would freeze it cannot be taken
under rtnl, and phy_attach_direct()'s own failure path takes it again.
What is caught instead is the outcome one step later, where the attach
bound the generic driver and returned success, and the poll puts that
back. The window before it, where phy_attach_direct() meets a NULL
phydev->drv, is open - see the questions at the end.

The connect returns 0 and not -ENODEV, because DSA reads
-ENODEV as permission to look for the PHY on the switch's internal MDIO
bus, which is the wrong device.

Waiting never gives up, since firmware or a module can arrive at any
time: a port with the property and no PHY polls at the 30 s ceiling for
the uptime, after one warning at the end of the first minute. A connect
that fails with the real driver bound stops there instead, for the
reason patch 2 gives. A port left in either state reports itself as
still waiting and nothing restarts it: DSA connects once, at port
setup, so an ifdown and ifup do not re-arm the poller - only unbinding
the switch driver does.

rtnl is taken with trylock so the poller never blocks on it, which
keeps it from parking a shared workqueue worker while another thread
holds rtnl. The attach lands within one poll interval of the PHY
becoming ready when rtnl is free; contention pushes it out by another
interval each time the trylock loses.

While the poll runs the port has no PHY, so it must not report the
MAC's own link modes as if they were the port's - that describes a link
that cannot come up, and ethtool would accept settings for it. The
pending path reports an empty set, stamps the unknown speed and duplex
over the ethtool core's zeroing, and refuses ksettings_set,
set_pauseparam and nway_reset. Reading pause parameters is left alone,
because it reports the configured request rather than a capability, and
the EEE calls already return -EOPNOTSUPP with no PHY attached.

Why not -EPROBE_DEFER and fw_devlink: there is no supplier link to wait
on. drivers/of/property.c parses no phy-handle, so fw_devlink never
builds one, and a deferral would park the MAC until something else
triggers the pending list - which need not coincide with the firmware
files appearing. Deferring the MAC's own probe is worse anyway: it
takes every port with it, including the one needed to mount the
filesystem that holds the firmware.

Cost in struct phylink: a delayed_work plus the fwnode, the connect
flags and the wait's own counters, appended at the end.

The flag sits on the MAC/port node because that is where the waiting
happens: phylink keeps the port and polls until the PHY turns up.
Question 2 asks whether it belongs there.

The flag is also a request for a dedicated PHY driver: a PHY meant to
run on the generic driver must not carry it, or the wait never ends.

Tested on an MT7981B board (MT7531 switch, EN8811H on a 2500base-x
port), warm boots only - I have no remote way to cut power. The board
runs OpenWrt, so what booted is these patches backported onto its 6.18
tree, not the mailed text byte-for-byte. What the board showed:

 - the case this exists for, a PHY arriving while the port is already
   running: attach at 67.44 s, carrier at 71.93 s, and the PHY's
   interrupt fires without any port bounce. This needs [3]; without it
   the same path left the port dead
 - an ifdown/ifup cycle disconnects and reconnects cleanly
 - the stopped-port path, reached by booting with the firmware out of
   reach and putting the port down while the PHY cannot exist: the PHY
   attaches to the stopped port, sits there attached and carrier-less,
   and the later up starts it, with the link three seconds behind
 - the wait itself: one warning at 65 s naming the property and the
   missing PHY, then a 29.19 s gap between the PHY becoming usable and
   the poller noticing - the ceiling doing its job, where the initial
   one-second interval would have attached within a second

Not exercised: the retry after a failed connect, though nothing rules
it out. The validation route into it is closed on this chip, since the
EN8811H reports RATE_MATCH_PAUSE and phylink_validate_phy() then never
intersects the port's line-rate modes with the PHY's copper ones - but
any failure inside phy_attach_direct() reaches the same retry, and MDIO
accesses can fail. Neither is the lost-race branch, which needs an
unbind between the readiness test and the attach.

No in-tree device tree sets phy-needs-host-firmware yet. The board I
tested is supported out of tree, in OpenWrt; the in-tree
mt7986a-bananapi-bpi-r3-mini carries the same chip and would be the
first candidate, but I have no such board to test the conversion on.

Two out-of-tree patches are needed, and only one of them is declared
below. Patch 1 of the pending pair [2] is applied on top of the base
and format-patch lists it as a prerequisite: a late bringup failure has
to leave pl->phydev clear, or every retry hits -EBUSY. The other, [3],
is a fix now on the list for net and is not in this mbox at all - a
forced major configuration can run over an uninitialised link_state,
and this poller reaches it on a port that is already up when the PHY
arrives, because the attach reports the not-yet-started PHY as down and
the resolve then takes the link-failed branch. Applying the mbox alone
gets the first and not the second.

System sleep is worth naming even though this half does not touch it.
On the shape this half targets alone - the PHY node owns reset-gpios
and the PHY driver downloads in .probe() - a suspend that cuts power
wipes the firmware, the PHY's own resume writes into a dead chip, and
this poller offers nothing: it only runs while no PHY is attached, and
after a resume one still is. The other half's MCU driver reloads the
firmware there, which is one more thing the phylink half does not buy
on its own.

The poller repeats the sequence phylink_fwnode_phy_connect() runs -
choose the interface, attach, bring up, detach on failure - with a
different point at which the reference is dropped. A shared helper is
the obvious ask and I have not written one; say if you want it before
the rest.

What I am asking:

 1. phylink_phy_is_usable() cannot stay true past its own return. An
    unbind between it and the attach leaves phy_attach_direct() reading
    a NULL phydev->drv, and the device lock that would close it cannot
    be taken under rtnl. A guard inside phy_attach_direct(), or the bus
    notifier this poll was always meant to become? The exact edge
    exists - BUS_NOTIFY_BOUND_DRIVER fires from driver_bound() after
    phy_probe() has set PHY_READY - so the follow-up is a notifier plus
    a one-shot work item. Polling first was the plan agreed in [4]; say
    if you want the notifier in this series instead.

 2. The property sits on the MAC/port node, which is where [4] put it:
    that is where the waiting happens. It describes the PHY, though,
    and phylink resolves phy-handle to a fwnode before it needs the
    device, so reading it from the referenced node is a one-token
    change, and a PCS node could carry its own the same way. Andrew,
    is the MAC node still where you want it?

 3. A connect that fails with the real driver bound is not retried.
    That is a policy borrowed from this chip: the failure path ends in
    phy_detach(), which asserts a PHY-node reset line, and firmware
    that lives in RAM does not survive it, so a retry loop would erase
    it once a cycle for the uptime. For any other late PHY the same
    rule turns a transient MDIO error into a port that is dead until
    the switch driver is rebound. Retry, stop, or retry unless the PHY
    node owns reset-gpios? And should the property be refused outright
    on such a node, so the board learns at boot that it converted to
    the wrong shape?

[1] https://lore.kernel.org/r/cover.1788548229.git.f@lex.la/
[2] https://lore.kernel.org/netdev/20260902080511.2211261-1-f@lex.la/
[3] https://lore.kernel.org/netdev/20260904185540.2844261-1-f@lex.la/
[4] https://lore.kernel.org/netdev/a230d199-5d4d-4637-aff3-e725a37e1da1@lunn.ch/

Aleksei Sviridkin (2):
  dt-bindings: net: ethernet-controller: add phy-needs-host-firmware
  net: phylink: wait for PHYs that are known to probe late

 .../bindings/net/ethernet-controller.yaml     |   8 +
 drivers/net/phy/phylink.c                     | 210 +++++++++++++++++-
 2 files changed, 211 insertions(+), 7 deletions(-)


base-commit: 761ae184f850f33d1bbf6c4530c7f237be780d21
prerequisite-patch-id: 293623f600b825505376e5c5bf72df2ac1f58e1e
-- 
2.53.0

