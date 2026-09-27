Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897B3563F6;
	Sun, 27 Sep 2026 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536755; cv=none; b=OHNL33KFSBv3ri1jsuGuHC6kp+H1hWyQgAh4kD8Sj67/PQOPkBP2wXcyzaruIPsahGjwz7EWE/AY4NYxksbSTnySQmLir2xDGolK/EexSl6FONf4AJoNIQulzvprXiwiVqs8E9iqNRXj19FAqBZBtNOuwJpN16jLEfCW2PXUMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536755; c=relaxed/simple;
	bh=Pu1xVx8jdEVwJzQBESoObCsfkI9oLih2HOvKsv6V0Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sirMHxA7bU5h6RajDXh5yAPpxvsMReppN3ZneAer16/+WhfMURPV3aO+3GEpbLF7iZmyzVIu84Uyo8nS/i/7zwtRkqtlQ77YeQI6JRJLsiiaxD2cuWqxZ0/krHWQq8x8skhXlJio5R3FB4hQ1X3ERRIJbwj44zRo6xfzQKMJ0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Jvs0kghJ; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Jvs0kghJ"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id A6A2AE8388F;
	Sun, 27 Sep 2026 21:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1790536748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b04rRLr9ToaS7kFDXE1hhj8dG59PkABywOagNfRjHo4=;
	b=Jvs0kghJqIBa1vTK5zEaBml6dmfu2izcLyWRt5xTG4nS8acDyz3sZhAFAeCyXSAc2ALusD
	HpYS6fVJlNxNZk6MKPLm7RHSuEF+zqVqLOeHDBHU2Q/X0DTeCOckykx/MFteg99XeESHKW
	xkPsszmw2+nilUqkPbkisGwNDc/zZT3D3/HhM8OCFE2OWl9fsizrZ9zjmUnBTae4ETDUcU
	zgBtTKrrMOud/kGmk4ZwdIS0Eqd8r7RsAMkoxzGsemGkI1gCNP2Vris0TP8zVFvyfOoSey
	3up4wXXDxlxrtzzjXQR/RhvdPLBG6CwNgOYdf6AEj7dwGAdF69bs3AIXQrTbiw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id sKchOnPrd3IO; Sun, 27 Sep 2026 21:19:08 +0200 (CEST)
Received: from p14sgen5.. (ip-077-020-250-175.vkd66.pools.vodafone-ip.de [77.20.250.175])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 27 Sep 2026 21:19:07 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v7 0/5] net: pse-pd: decouple controller lookup from MDIO probe
Date: Sun, 27 Sep 2026 21:18:45 +0200
Message-ID: <20260927191850.1370515-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v7 of Corey's series [1]. It takes the PSE controller lookup out
of the MDIO probe path, so a modular PSE controller driver no longer makes
the PHY (and any DSA switch behind it) spin on -EPROBE_DEFER until the PSE
module loads.

v6 [7] drew a large AI review [8], which I have now answered point by point
in that thread. Paolo's reading was right: most of the [High] findings
described the state of the tree between the old patches 3 and 5, which the
old patch 5 then fixed. Rather than argue that in five changelogs, v7 folds
those three patches into one, so the rtnl detour and the deferred release
never exist at any commit. That also removes a real bisect hazard: the old
patch 3 on its own hung lantiq_etop and sni_ave on probe, and the old patch
4 was what repaired it.

Per Documentation/process/maintainer-netdev.rst I ran LLM review over v7
before posting, more than once. Patches 3 and 4 exist because of what it
found, and it changed patch 2 and the phy patch as well:

Patch 2 reorders pse_controller_unregister() around the new event, because
a subscriber runs arbitrary teardown inside it. The controller is unlinked
from pse_controller_list first, so a lookup racing the teardown resolves
nothing rather than a controller whose pcdev->pi[] pse_release_pis() is
about to free. v6 disclosed that as pre-existing and reachable only from
phy registration; it is reachable from more than that here, because after
the last patch a second controller registering runs a PSE_REGISTERED walk
that calls of_pse_control_get() for every phy on mdio_bus_type, which is
exactly the two-controller board I test on. disable_irq() moves up for the
same reason: pse_isr() queues notifications and reaches pcdev->pi.

cancel_work_sync() moves the other way, to after the event rather than
before it. A subscriber dropping the last pse_control reference reaches
__pse_control_release(), which calls regulator_disable() if the PI is
still on. With the static budget strategy that retries any port on the
same power domain waiting for power, and if the domain is still over
budget it sheds a lower priority port through pse_disable_pi_pol(),
which queues a notification and calls schedule_work(). Draining the
worker before the walk would leave work queued behind it, racing the
kfifo_free() below. Draining after it also stops the worker's own
transient reference, taken by pse_control_find_by_id(), from becoming
the last one once pse_release_pis() has freed the array.

[9] makes a related reordering for net, independently of any
subscriber, so pse_controller_unregister() will conflict when [9]
back-merges. The order is not identical: [9] leaves the unlink below
cancel_work_sync() and pse_flush_pw_ds(), which it can, having no event
to place. Here the event has to sit after the unlink and before the
frees, and cancel_work_sync() after the event, so the unlink moves to
the top. The merged function wants this order, which contains [9]'s fix:

    if (pcdev->irq)
            disable_irq(pcdev->irq);
    mutex_lock(&pse_list_mutex);
    list_del(&pcdev->list);
    mutex_unlock(&pse_list_mutex);
    blocking_notifier_call_chain(&pse_controller_notifier,
                                 PSE_UNREGISTERED, pcdev);
    cancel_work_sync(&pcdev->ntf_work);
    pse_flush_pw_ds(pcdev);
    pse_release_pis(pcdev);
    kfifo_free(&pcdev->ntf_fifo);

I am happy to send that as a follow-up on top of the merge if that is
easier than carrying it in the conflict.

Kory, a specific ask on patch 2. The reason cancel_work_sync() sits below
the event and not above it is that __pse_control_release() can re-enter
your budget code: regulator_disable() on a PI that is still on runs
_pse_pi_disable(), and with the static strategy that retries a pending
port on the same power domain and, if the domain is still over budget,
sheds a lower priority one through pse_disable_pi_pol() - which queues a
notification and calls schedule_work() from inside the walk. I have
tested that path rather than only reasoned about it, but the ordering
rests on your design, so I would rather you looked at it than have it
ride in unremarked.

Patch 4: each PSE PI regulator is registered with a "vpwr" supply. The
regulator core deliberately treats an unresolved supply at registration as
non-fatal, so pse_controller_register() completes and PSE_REGISTERED fires
for a controller whose PIs cannot be handed out yet: regulator_get_exclusive()
in pse_control_get_internal() resolves the supply itself and keeps
returning -EPROBE_DEFER until the vpwr provider appears. Before this series
the MDIO layer propagated that and deferred probe retried it. After it,
phylib has no event left to retry on, and the port would silently lose PSE
for good. Patch 4 checks every PI's supply before registering anything, so
the PSE driver's own probe defers and deferred probe handles the ordering.
It checks exactly the PIs the registration loop creates a regulator for,
including a controller with no pse-pis node, and it follows both stages
the core uses - the PI node, then the controller device - because a
vpwr-supply written once on the controller node is invisible from the PI
node but resolves at stage two. It stops short of the core's
device_is_bound() gate, so a probe interleaving with the provider's own
can still resolve late; the changelog says so.

Patch 3: that makes -EPROBE_DEFER an ordinary return from
pse_controller_register(), which has no error unwind at all. The kfifo and
the PI array plus its OF references are leaked on every failure, once today
and on each retry after patch 4, and a partial pse_register_pw_ds() leaves
devm-allocated power domains in the global xarray for the next registration
to trip over. Patch 3 adds the unwind, at two depths: pse_pi_ops index
pcdev->pi[], and the PI regulators are devm-registered, so once one exists
the array cannot be freed here at all and stays leaked as it is today. It
is released on the failures that happen while it exists and before the
first PI regulator does - setup_pi_matrix() and the supply check - which is
where the ordinary deferral now lands.

The same reviews caught two things in the phy patch. The error paths of
phy_device_register() could leak a handle: device_add() puts the phy on
the klist before its own later failure points, so a PSE_REGISTERED walk
can attach one that nothing releases. A put at the out: label does not
work, because by then device_add() has unwound the phy off the bus and
the PSE_UNREGISTERED walk would miss it too. phydev->psec_detached now
covers registration as well as removal, so no handle is attached in that
window. And that flag is a plain bool rather than another bit in the
flags word, since it is written under pse_phy_lock() while its
neighbours are written under phydev->lock and rtnl.

No Fixes: tag. 5e82147de1cb ("net: mdiobus: search for PSE nodes by
parsing PHY nodes") is the commit to blame, but this is a refactor
across two subsystems plus a new export, and tagging it would invite a
stable backport of all that to cure a probe-retry loop.

Two changelog errors from v6 are also fixed: netsec does not deadlock (its
MDIO bus comes up in probe, not from ndo_init), and the module-unload
rationale was backwards (try_module_get() pins the provider, so rmmod is
refused before the unregister path ever runs).

How it works: pse_core gets a notifier chain (REGISTERED / UNREGISTERED).
phylib subscribes, owns phydev->psec, and attaches the handle when the
controller shows up instead of during probe. fwnode_mdio loses its PSE
awareness, so no -EPROBE_DEFER leaves it and the probe-retry loop is gone.

On the tags: Jonas tested the v4 shape and Aleksander tested the v6
locking, which is unchanged here. Neither tested the fixes above. On the
folded phy patch the code they exercised is intact, so I have kept their
tags there. Jonas's tag also rides on patch 2, and that one did change in
v7 - pse_controller_unregister() is reordered around the event - so it is
the weakest of the three. Patch 1 only gained a kernel-doc correction. I
would rather say so here than let it pass silently; happy to drop any of
them if either would prefer.

Tested on a Realtek rtl9303 PoE switch with an HS104 PSE controller on
i2c, with a PD drawing power on one port:

 - clean boot, no probe-retry loop, the controller registers once
 - rmmod is refused while a phy holds a handle
 - i2c unbind: the notifier walk drops the handle and the port powers
   down, and ethtool reports no PSE attached
 - i2c bind: the handle comes back and the PD is powered again
 - six unbind/bind cycles, no warning, power domain index stable

Also exercised under QEMU, on arm64 under KASAN, PROVE_LOCKING and
kmemleak. The device tree has a PSE controller, a second one whose vpwr
provider never appears, and an MDIO bus with two phys, only one of which
references a PI. Unbinding the controller detaches that phy's handle and
rebinding re-attaches it; the other phy is never touched; unbinding the
MDIO bus releases a live handle; and the controller with the missing
supply defers instead of registering. A third controller puts its
vpwr-supply on the controller node rather than the PI nodes, which the
core resolves one stage later - that one has to defer too, and on the
code before patch 4's second stage it registers instead. The new
WARN_ON in patch 5 stays silent across six unbind cycles and kmemleak
reports nothing.

The same test setup stages an over-budget static-priority domain, so that
dropping the last reference really does reach pse_disable_pi_pol() and
schedule_work() from inside the walk - the case patch 2's
cancel_work_sync() placement exists for. I checked that with a
dump_stack() rather than by reasoning about it: releasing phy1's handle
in the walk lands in _pse_pi_disable(), the retry picks a pending port on
the same domain, the domain is short, and a lower priority port is shed.
No lockdep splat, which is the result I wanted most: that path re-enters
the regulator core from a notifier callback, under the chain's rwsem and
pse_phy_mutex.

Build matrix, all linking a real vmlinux: PHYLIB=y, PHYLIB=m (the config
that failed to link in v5), PHYLIB=n, PSE_CONTROLLER=n, and CONFIG_OF=n.

Tested-by: Carlo Szelinsky <github@szelinsky.de>

Changes in v7:
 - Patch 2: reorder pse_controller_unregister() around the event - unlink
   and disable_irq() before it, cancel_work_sync() after it, the frees
   last. The pse_control_head WARN_ON goes in patch 5 instead, with the
   walk that empties the list - in patch 2 an unbind would trip it,
   since the fwnode_mdio hook still hands out handles nothing releases.
 - New patch 3: unwind the kfifo, the PI array and the power domains when
   controller registration fails.
 - New patch 4: check every PI vpwr supply before registering the
   controller, so a consumer never meets a registered controller that can
   only answer -EPROBE_DEFER.
 - Fold old patches 4 and 5 into the phy patch, so no intermediate commit
   carries the rtnl recursion or the deferred release.
 - Hold phydev->psec_detached across registration too, make it a bool
   rather than a bitfield, and drop the unsafe release from
   phy_device_register()'s error path.
 - Drop netsec from the deadlock list; fix the module-unload rationale;
   document that a transient attach error is no longer retried by deferred
   probe.
 - Include <linux/notifier.h> in phy_device.c.
 - Rebased on net-next.

Changes in v6:
 - Fix a v5 build regression: the mutex moved into pse_core, since
   net/ethtool is always in vmlinux while PHYLIB is tristate.
 - Fold phy_device_register_locked() back into phy_device_register().

Changes in v5:
 - Replace rtnl with a dedicated mutex in the PSE attach path.
 - Put phydev->psec back in phy_device_remove().

Changes in v4:
 - Add Tested-by from Jonas Jelonek. No code changes.

Changes in v3:
 - Drop patch 1 (regulator handle fix); it went to net separately [2].

v1 was an RFC by Corey [3].

[1] https://lore.kernel.org/netdev/20260620112440.1734404-1-github@szelinsky.de/
[2] https://lore.kernel.org/netdev/20260624204017.2752934-1-github@szelinsky.de/
[3] https://lore.kernel.org/netdev/20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info/
[4] https://lore.kernel.org/netdev/20260630091125.3162481-1-github@szelinsky.de/
[5] https://lore.kernel.org/netdev/bac5e6e9-7358-4ccb-87fc-9c40baa33682@wp.pl/
[6] https://lore.kernel.org/netdev/20260703071025.100797-1-pabeni@redhat.com/
[7] https://lore.kernel.org/netdev/20260906153102.959217-1-github@szelinsky.de/
[8] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906153102.959217-1-github%40szelinsky.de
[9] https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/

Carlo Szelinsky (2):
  net: pse-pd: unwind allocations when controller registration fails
  net: pse-pd: check the PI vpwr supply before registering the
    controller

Corey Leavitt (3):
  net: pse-pd: add notifier chain for controller lifecycle events
  net: pse-pd: fire lifecycle events on controller register/unregister
  net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio
    hook

 drivers/net/mdio/fwnode_mdio.c |  34 -----
 drivers/net/phy/phy_device.c   | 139 ++++++++++++++++++-
 drivers/net/pse-pd/pse_core.c  | 243 +++++++++++++++++++++++++++++++--
 include/linux/phy.h            |   7 +
 include/linux/pse-pd/pse.h     |  65 +++++++++
 net/ethtool/pse-pd.c           |  16 ++-
 6 files changed, 452 insertions(+), 52 deletions(-)


base-commit: e3bfd25626b44b6fa61a13c17178922171d519ce
-- 
2.43.0

