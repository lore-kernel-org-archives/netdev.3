Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7B4E56FC
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287202; cv=none; b=CaUBrB5pB6agO65K/CXHiYdSy4h9+ZoW2esJrILGDwwgRpIOgdqCs8X3LhfXABLHGAGaxE4s1OvZq4K51AEknsf8IAINN3KgiPyEpAfHzFZoZcDwKdPT3Tl4ieZqMy94Cbv2zIeBJPLdFeNqUyT7Pk0ZUDRTiS6aODml5Nl6zw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287202; c=relaxed/simple;
	bh=qyAmycnZLmxhHS4lSJtzA5AeLDXkz6hW4PGsKxtevKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoz0HTufizOfIwvxf+zkrRcuQDUJcpnjCqiWrgw4o53itWAQPT2srz8cSls+KmPAPREWGRRoeLBucqFWkwyBZjcN/2qlEjzgeOqDJb3LqQI35LCJpcNCuG7dOgLrMflKWsYP4AlwIw/9kNkadX3dkH3fTOTTnJj6tQdqPMrJATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=XI99xrDj; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="XI99xrDj"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874fso87447f8f.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790287196; x=1790891996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BrGE8a9yc/X+9STBX9rzZQGKi8arSkaQ/f+L1FA0tps=;
        b=XI99xrDj1IwmgTsO2XnseB3hbl/nhM5+91uFTAUatxBfEyBACtLMZrSFQ23P7WRcHP
         v0l7Hs+XjJW+cpZie8+ZCWHmPHrQqLN0GFX3ItS6TQdTqdEwSlD49b+d8P3mB7bWYVdf
         RLckBCbCnCTdQama35N/ToDdCo24Gw/6sYMXJM1Hvsiz+jf5kJJ7lI0c7xgQuAMgnv3n
         IpIv2UaJNJN1eoJdRUTZRj7TgCicQSOtHUGrGBfN0eFAeHyNiLa2NaWx01gk8MFxKyMh
         IdZZL+vPoOewQTRBocPiBlNHHay6dVVpP1mS3IZwb2e0n329BqkqXfiTsjgtjoDRzOan
         jTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287196; x=1790891996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BrGE8a9yc/X+9STBX9rzZQGKi8arSkaQ/f+L1FA0tps=;
        b=On3vQfnlNorcmuF8Y7MCjZVtN9B/3kH3PjDulI05o0cxRntuDBTiFRSYiyNxCGAw52
         bEGqAF3JnN6TFP79298hzyTu5Z2pvUpsg+4oNBB7FCvU7ZBtlZQWqpC4oTmAT9DmbmFx
         Twhxs5PPEZ84yR514rQ55Jgnjjb40nT6GwxLnEAfb1trWsz/fVK3q71adXi502gtECLq
         e/DSPUYDEQ+SExJC8RHSshupsEXYstyeZhosrhIV2YK+VB1ShUnTTawoMBZ8sY6S/tFd
         3vzQ1StG8o6FZlo7zyd/wb2jy+iTktbodnfF8hoO//kd5l85c/8tSXC0h/rwCYMJAQ1G
         H7xA==
X-Forwarded-Encrypted: i=1; AKwUvByvtWw1PSh7DM8vb0D1hj4Y07iN0bZCwn+8eIvz2tDcl3ID+LoUd78FJuE0IlKDKEEe13OWJjE=@vger.kernel.org
X-Gm-Message-State: AFuF++mbGrCuRsMkq5dJgo2bBZbkUhtxObF1CYYOZCeekkqd6cRHDF9N
	TvBD0x/VHtJx79RfMJpyyQ/18HYdwJl8YHBlkbKv8w922SWsBhrzG7B8beZexFwINX4=
X-Gm-Gg: AYBFou1mw/GzIvbvu7KSSjEAfPepRILkt9lmidbOp2npyMEPQyjv6ivRuBPgEiI5gK9
	hkRgxkfnYrFCNW6/tRyPC7eOBVVAC+9jKHFCRnii24NeU39436o+6yLJH+uYks8w1pJvvAl9pPK
	xouhYuCADZlRijYjIjVZVgdC8ZeDDzEAaNpsy4qNXOsHe7CvedSUyWMyNOihHk6U5g3XWF2N5F0
	Yaoz/cOY0l0rvPUvQmgujO5iQQJLahCXl3CjNbyJGFfLleY/HseMp4syA2V0nifCCKgKY3+1DbZ
	PfY58Yip4xuR+5ob8i6W3Vfk3dY6LupFXuicOWyAoR6SM+wrd7NFYkrIovGvYFqNau+YlbK98A9
	OVv4h03D8d0TZfBushBmi3/3iHxfVZI8cZyhrhZ2C9RMaL0oUVycrWGg37dBtsRyY7xo7i4ZhPK
	yHwQ7r05HwUVmMbbmph1kGnMmdwvY8SGej9P2vMELDCqP3op4eyw==
X-Received: by 2002:a05:6000:250d:b0:486:e60f:a4e3 with SMTP id ffacd0b85a97d-4887168cd11mr6025795f8f.1.1790287196248;
        Thu, 24 Sep 2026 14:59:56 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm1922324f8f.9.2026.09.24.14.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:59:55 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Mao Wenan <maowenan@huawei.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net v3 0/4] net: phy: make PHY driver unbind safe against attach and use
Date: Fri, 25 Sep 2026 00:59:46 +0300
Message-ID: <20260924215951.2127682-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unbinding a PHY driver through sysfs while its MAC brings the port up
can oops. On a Keenetic KN-1012 (MT7981, mtk_eth_soc), an unbind of the
wan PHY driver racing "ip link set wan up" faulted on the first attempt,
with no delay added anywhere. The fault was inside the PHY driver's
config_init: the driver read phydev->drv after phy_remove() had cleared
it. Patch 3 has the trace.

Serialising attach against unbind is not enough on its own. With only
that, an unbind that loses the race waits for the attach and then
removes the driver from a PHY that is now attached. On the board the
consumer then faulted one step later: in phylink_bringup_phy() right
after the attach returned, or in _phy_state_machine() at the next
ifdown. A DSA port gets there without any race, because DSA keeps its
PHYs attached from switch setup to teardown. Patch 4 makes the unbind
wait until the consumer has detached.

1: refuse a second attach of a PHY that is already attached, before
   taking anything. That -EBUSY path used to run phy_detach() on the
   first consumer's attachment. Found in review of patch 2, whose
   module accounting it unbalanced.
2: put the module reference phy_attach_direct() took, not whatever
   driver is bound at detach time. Found by reading. On the KN-1012 the
   sequence that would leak faults earlier, before the detach reaches
   the put.
3: a per-PHY mutex and a "bound" flag. An attach is either done with
   the driver before phy_remove() starts tearing it down, or is refused
   with -EAGAIN, or, after the unbind has finished, gets the generic
   driver as today.
4: phy_remove() waits for phy_detach() when the PHY is attached,
   except when the PHY device itself is being deleted.

1, 2 and 3 stand on their own. Without 4, an unbind that loses the race
to an attach still leaves that consumer with a PHY whose driver is
gone. 3 only guarantees the attach itself does not run into a driver
being removed.

On the lock inversion (Paolo): the PHY's device lock is the obvious lock
for this, but attach may run under rtnl, and rtnl is taken under that
device lock on bind and unbind in at least two places. For a PHY with an
SFP cage, phy_probe() and phy_remove() go through sfp_bus_add_upstream()
and sfp_bus_del_upstream(), which take rtnl. For a PHY LED on the netdev
trigger, led_classdev_register() and led_classdev_unregister() register
and unregister a netdevice notifier, which takes rtnl.

Removing the inversion would at least mean moving the SFP registration
out of probe and remove, and that is not net material. The SFP
upstream ops write netdev state that rtnl protects. Attach does not
always run under rtnl (DSA connects its ports before taking it), so
the registration cannot follow the attach either. Nothing under the
new mutex takes rtnl. On the generic-driver path, device_bind_driver()
can take a supplier's device lock for sync_state, as it already does
today.

Vladimir, this is where patch 4 falls short of what you asked for in
[1]: that unbinding a PHY driver should not "explode ... even in
uncontrolled situations where the netdev isn't carefully disconnected
from the PHY first". What I looked at, and what each costs:

- A, phy_remove() waits for the detach (patch 4, kept): the unbind
  blocks, uninterruptibly, until the consumer detaches. For DSA that
  means until the switch is torn down, even with the port down, since
  DSA stays connected.
- B, stop at patch 3: the oops moves one frame up, into
  phylink_bringup_phy() or _phy_state_machine(). Patch 4 has the
  phylink trace.
- C, let the caller hold the lock across attach and bringup: widens
  the series to phylink and still leaves every use after bringup.
- A with a killable wait: ->remove cannot fail, so after a kill it
  could only go on removing the driver, back into the oops.
- suppress_bind_attrs on PHY drivers: removes the sysfs unbind your
  use case relies on.
- A managed device link MAC -> PHY: the unbind would take the whole
  MAC or switch down with it.

A is a compromise. What it does not achieve: an unbind of a PHY in use
hangs instead of failing, and on DSA it hangs until switch teardown,
even with the port down.

On the KN-1012, lan4 is a DSA port on an EN8811H. Without the series,
with lan4 down, unbinding air_en8811h returned at once. Bringing lan4
up after that gave a WARN in phy_start() and no oops within 10 s.
Unbinding the switch instead faulted in phy_free_interrupt() from
phy_disconnect(). With the series (an earlier revision with the same
attach and wait code, before the device-deletion change), the same
unbind blocks with lan4 up or down, and returns when the switch is
unbound.

Vladimir, should patch 4 go separately, to net-next or as an RFC, with
1 to 3 going to net now?

Patch 4 has other costs too. The hung-task detector, when enabled,
reports the blocked unbind after its timeout. System suspend and
reboot wait on that PHY's device lock meanwhile. device_shutdown()
takes it and does not detach PHYs, so a reboot behind a blocked unbind
hangs. sysfs shows the driver link gone while ->remove is still
waiting, because the driver core removes it first.

Deleting the PHY device does not wait and keeps today's behaviour, for
example mdiobus_unregister() from a MAC driver's remove. Some MAC
drivers never detach their PHY and would otherwise hang in their own
removal. Andrew asked in 2020 whether an unbind could be blocked while
the interface is up [2]. Florian Fainelli answered that nothing bad
happens, which the traces here no longer bear out.

This series does not close one more window. phy_attach_direct() still
stores the generic driver in d->driver and calls device_bind_driver()
without the device lock the driver core expects. A real driver binding
through the driver core at the same moment can still collide with it.

I tested on the KN-1012 with OpenWrt's 6.18 kernel and a backport of
the series, on top of the board's pending phylib/phylink patches for
its late PHY and test-only mt7530 fixes. Patches 2 to 4 ran as an
earlier three-patch revision without patch 1 and otherwise identical
in code, with PROVE_LOCKING:
- the wan race, 450 iterations: no oops. In 447 the unbind was still
  pending after the attach and returned at ifdown.
- no lock-order report across the unbind/bind cycles. The controller
  unbind runs also show warnings from mtk_remove() stopping and
  disconnecting its netdevs without rtnl (the refcount underflow in
  mtk_stop() comes from stopping netdevs that were already down), and
  DSA teardown a kernfs WARN. Both predate this series.
- the device-deletion branch of patch 4, through a test module calling
  phy_device_remove() on the attached EN8811H, since unbinding the
  switch or the Ethernet controller here detaches the PHY first. The
  call returned, and it released an unbind already waiting.
- the -EAGAIN refusal of patch 3 was hit once, on an earlier revision
  with the same attach code: mtk_open() got -11 and "ip link set wan
  up" failed with "Resource temporarily unavailable".

Patch 1 ran on this revision, without PROVE_LOCKING. A test module
attaching lan1 to the EN8811H that lan4 holds got -EBUSY. lan4 kept
its PHY, and the air_en8811h refcount was unchanged. Without the
series the same call left lan4 with no PHY. The same wan race without
the series faulted on the first try.

[1] https://lore.kernel.org/netdev/20260311203410.rio7m6nuf72hs5p6@skbuf/
[2] https://lore.kernel.org/netdev/20200917131545.GL3526428@lunn.ch/

v2: https://lore.kernel.org/netdev/20260919015340.499675-1-f@lex.la/
- Retargeted to net, and the race closed with locking rather than a
  NULL test at attach entry, as asked in review.
- The module reference fix is its own patch.
- New patch 1: a second attach no longer detaches the first consumer.
- An unbind of an attached PHY now waits for the detach.

Aleksei Sviridkin (4):
  net: phy: refuse a second attach before touching the PHY
  net: phy: put the driver module the attach took
  net: phy: serialise attach and detach with PHY driver bind and unbind
  net: phy: make an unbind wait for the attached consumer to detach

 drivers/net/phy/phy_device.c | 95 ++++++++++++++++++++++++++++++------
 include/linux/phy.h          | 12 +++++
 2 files changed, 92 insertions(+), 15 deletions(-)

-- 
2.53.0

