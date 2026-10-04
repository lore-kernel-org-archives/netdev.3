Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22B3B9D9D;
	Sun,  4 Oct 2026 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132166; cv=none; b=mSeAC4cVichu622ZLhcL07linIfRS8zgy12glPe/DL2mU68Rq0UbZzW504zXBzXXgMMdWLfk68aqBmw6Q2rC4CJ84ClxV9XpU2f624jDbB2CvqE6cMRwQDRy3t07mLpkShYgCt8KWzBMq9QLNCLn7LuC2AToOMEt7Z5ZO0kr+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132166; c=relaxed/simple;
	bh=7n2FlQ5I26vee400B48bKay0DQOqh+7ohbjbhsaxfU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KK9TfXkuhgn0svrLu8baVgaoFZVoNOG7gUbH2PApaDhsTMeWA8PQNJyu1k12JbuxZy80JiHSvbXT8m7sMbE6KMzlPuQmsh6v4re4cdIZ2Ez/ldZV0Hq+NiVLY9Es0WuExuUJsACK6TjhyyJ9aE+llck/4nVAtAGPDROm9WN+oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Oqt5Grj/; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Oqt5Grj/"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 96078E837F0;
	Sun, 04 Oct 2026 18:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1791132159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wG8b4mwqgj0kCHMRldeDtiSDZxfB4+l7ZPgSNj6RaJM=;
	b=Oqt5Grj/tAiqo0VcabugezrVc/PU+CG2lugr1XyV8rECiwvs2jTDLmUDmu6F/f3shRgJW+
	ve9ETPhwdVvoar746pHJfav3BD7umTHE4LXNpO65OHhF7DR8yPc6T0tCQwfLdwxZCM2KIg
	LYQFEpQRk8kOfVQ9drn7eUNUqRaDZl4jHmx8+BQ249t3JWNOB9U/1o/0P9dagap/2u/pVt
	wxhC9GT3tyNXMZOw9+Wyt+20YSMVNAtueVgP0lt6w8kpASacq1X78ZL3PzWyxNSm5hOmJQ
	c0T83sPhVo02JMN5aMP48T8TK5VCyDV1ESw4+VBh5eYu7Q7XQfaEv6T2lwTbpg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id b0jDsfkfKoOK; Sun,  4 Oct 2026 18:42:39 +0200 (CEST)
Received: from p14sgen5.lan (86-103-67-55.ip.tng.de [86.103.67.55])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 04 Oct 2026 18:42:38 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v8 0/7] net: pse-pd: decouple controller lookup from MDIO probe
Date: Sun,  4 Oct 2026 18:42:12 +0200
Message-ID: <20261004164219.1161294-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v8 of the series Corey started as an RFC [3]; I took it over
from v2 [1]. It takes the PSE controller lookup out of the MDIO probe
path, so a modular PSE controller driver no longer makes the PHY (and any
DSA switch behind it) spin on -EPROBE_DEFER until the PSE module loads.

v7 [10] drew an LLM review [11]. Four of its findings are fixed here,
one I disagree with (patch 5 below), and the rest I answered in that
thread. v6 [7] drew one too [8]; v7 folded the patches it was mostly
about into the phy patch, so no commit carries the rtnl detour or the
deferred release. Per Documentation/process/maintainer-netdev.rst I also
ran LLM review locally on v7 and v8 before posting.

Patch 2 reorders pse_controller_unregister() around the new event,
because a subscriber runs arbitrary teardown inside it. The controller
is unlinked from pse_controller_list before the event and before
anything is freed, so a lookup racing the teardown resolves nothing
rather than a controller whose pcdev->pi[] pse_release_pis() is about to
free. v6 disclosed that as pre-existing and reachable only from phy
registration; it is reachable from more than that here, because after
the last patch a second controller registering runs a PSE_REGISTERED
walk that calls of_pse_control_get() for every phy on mdio_bus_type that
has a DT node and no handle yet, which happens on any board with two PSE
controllers. disable_irq() moves up for the same reason: pse_isr()
queues notifications and reaches pcdev->pi. On tps23881, the only
in-tree user of devm_pse_irq_helper(), devres has already run free_irq()
by then, so the move is what makes the ordering hold for a driver that
requests its irq earlier rather than leaving it to devres.

[9] makes a related reordering for net, independently of any subscriber,
so pse_controller_unregister() conflicts if [9] is applied. The order is
not identical: [9] leaves the unlink below cancel_work_sync() and
pse_flush_pw_ds(), which it can, having no event to place. Here the
event has to sit after the unlink and before the frees, and
cancel_work_sync() after the event, so the unlink moves up to just after
disable_irq(). The merged function wants this order, which already
includes [9]'s reordering:

    if (pcdev->irq)
            disable_irq(pcdev->irq);
    mutex_lock(&pse_list_mutex);
    list_del(&pcdev->list);
    mutex_unlock(&pse_list_mutex);
    blocking_notifier_call_chain(&pse_controller_notifier,
                                 PSE_UNREGISTERED, pcdev);
    cancel_work_sync(&pcdev->ntf_work);
    WARN_ON(!list_empty(&pcdev->pse_control_head));
    pse_flush_pw_ds(pcdev);
    pse_release_pis(pcdev);
    kfifo_free(&pcdev->ntf_fifo);

I am happy to send that as a follow-up on top of the merge if that is
easier than carrying it in the conflict.

Kory, a specific ask on patch 2. cancel_work_sync() sits below the event,
not above it, because __pse_control_release() can re-enter your budget
code. regulator_disable() on a PI that is still on runs
_pse_pi_disable(). With the static strategy that retries a pending port
on the same power domain, and if the domain is still over budget it sheds
a lower priority one through pse_disable_pi_pol() - which queues a
notification and calls schedule_work() from inside the walk. Draining
before the walk would leave that work racing kfifo_free(). Draining after
it also keeps the worker's own transient reference, taken by
pse_control_find_by_id(), from becoming the last one once
pse_release_pis() has freed the array.

I staged that case in QEMU (below) and confirmed it with a dump_stack()
from pse_disable_pi_pol(), so it is a path I have hit rather than only
reasoned about. The ordering rests on your design though, so please take
a look at it.

Patch 5: each PSE PI regulator is registered with a "vpwr" supply. The
regulator core deliberately treats an unresolved supply at registration as
non-fatal, so pse_controller_register() completes and PSE_REGISTERED fires
for a controller whose PIs cannot be handed out yet: regulator_get_exclusive()
in pse_control_get_internal() resolves the supply itself and keeps
returning -EPROBE_DEFER until the vpwr provider appears. Before this series
the MDIO layer propagated that and deferred probe retried it. After it,
phylib has no event left to retry on, and the port would silently lose PSE
for good.

Patch 5 checks every PI's supply before registering any PI regulator, so
the PSE driver's own probe defers and deferred probe handles the
ordering. It checks exactly the PIs the registration loop creates a
regulator for, including a controller with no pse-pis node, and it
follows both stages the core uses - the PI node, then the controller
device - because a vpwr-supply written once on the controller node is
invisible from the PI node but resolves at stage two.

The review of v7 found two things wrong with that. The PI-node lookup has
to be taken only once the PI's own phandle resolves, or
of_get_child_regulator() walks the whole controller subtree and answers
one PI from a sibling's supply before the controller node is ever
consulted; that is fixed. The core reaches the same sibling walk, but
only after the controller's own vpwr-supply has had its turn.

It also asked for the loop to move ahead of setup_pi_matrix(), because
pd692x0 claims a power budget there that nothing gives back when
registration fails later. I tried that and it is wrong: pd692x0's pse-pi
nodes name the manager regulators setup_pi_matrix() itself registers, so
checking earlier defers on a supply only that driver can bring up and it
never probes. I added a controller of that shape to the test setup and
confirmed it both ways. The loop stays where it is and the changelog says
what the placement does not clean up.

-EPERM is now treated as resolved, since it only means the provider is
held exclusively. The check still stops short of the core's
device_is_bound() gate, so a probe interleaving with the provider's own
can slip through, and nothing retries that PI until the next
PSE_REGISTERED. fw_devlink only prevents that when the vpwr-supply sits
on the controller node: one in a pse-pi node gives the controller just a
SYNC_STATE_ONLY proxy link, which does not hold its probe back.

Patch 3 exists because patch 5 makes -EPROBE_DEFER an ordinary return
from pse_controller_register(). That function has no unwind past
kfifo_alloc(): the kfifo leaks on every failure, and past
of_load_pse_pis(), which cleans up after itself, so do the PI array and
its OF references - once today and on each retry after patch 5 - and a
partial pse_register_pw_ds() leaves devm-allocated power domains in the
global xarray for the next registration to trip over.

Patch 3 adds the unwind, at two depths: pse_pi_ops index pcdev->pi[], and
the PI regulators are devm-registered, so once one exists the array
cannot be freed here at all and stays leaked as it is today. It is
released on the failures that happen while it exists and before the first
PI regulator does - setup_pi_matrix() and the supply check - which is
where the ordinary deferral now lands. It also clears pi[].pw_d, and says
what it does not cover: a power domain shared with another controller can
still be freed under it, which is pre-existing and wants the domain out
of devm.

Patch 4 is a small si3474 change for the same reason. si3474 logged
every controller registration failure with dev_err(), and its binding
puts vpwr-supply in the pse-pi nodes, which fw_devlink does not wait
for, so with patch 5 it would log an error on every deferred probe
retry until the supply appears. It now uses dev_err_probe(), as
pd692x0 and tps23881 already do.

The v6 review [8] caught two things in the phy patch, both fixed in v7.
The error paths of phy_device_register() could leak a handle:
device_add() puts the phy on the klist before its own later failure
points, so a PSE_REGISTERED walk can attach one that nothing releases. A
put at the out: label does not work, because by then device_add() has
unwound the phy off the bus and the PSE_UNREGISTERED walk would miss it
too. phydev->psec_detached now covers registration as well as removal,
so no handle is attached in that window. The write before device_add()
is the one place it is set without pse_phy_lock(), which is safe because
the phy is not on the klist yet and device_add()'s own locking orders
it.

That flag is a plain bool rather than another bit in the flags word,
since it is written under pse_phy_lock() while its neighbours are written
under phydev->lock and rtnl.

Patch 6 is a one-entry change in drivers/of/. fw_devlink treats "pses"
as a supplier binding, so a phy that references a PI has a device link to
the PSE controller and its driver probe waits for it. That was invisible
while the PSE lookup deferred the phy anyway, since fwnode_mdio removed
it again on every retry. Once patch 7 stops
deferring, the phy is registered while its own driver is still blocked,
and a MAC attaching in that window takes the generic driver through
phy_attach_direct() - device_bind_driver() then forces the bind past the
pending link, and nothing re-probes it later.

Marking the link FWLINK_FLAG_IGNORE drops it entirely: no device link, no
ordering, no cycle detection, and the fwnode link goes at the consumer's
device_add(). That is what post-init-providers already does.

Two things do ride on that link today, because it is managed - the fwnode
link sits on the phy's own node, so fw_devlink_create_devlink() asks for
fw_devlink_flags, which defaults to FW_DEVLINK_FLAGS_RPM and carries
neither DL_FLAG_STATELESS nor DL_FLAG_SYNC_STATE_ONLY, so
device_link_add() promotes it to DL_FLAG_MANAGED. So unbinding the PSE
controller releases the phy's driver, and DL_FLAG_AUTOPROBE_CONSUMER
probes the phy when the controller binds. Both are given up on purpose:
the notifier does the attach and detach now, without tearing the port's
phy driver down, and there is no deferral left for an autoprobe to wait
on. DL_FLAG_PM_RUNTIME is the one that really had no effect, since no PSE
driver implements PM ops, sync_state or runtime PM.

That also means patch 6 is not a no-op on its own. The MDIO path
registers the phy before it looks the PI up, so the link exists and goes
active as soon as the controller binds, which puts the cascade's removal
at patch 6 rather than at patch 7. It also stops holding the phy's driver
back during those retries, so at patch 6 alone the driver probes and is
removed again on each one until the controller binds; patch 7 removes
the retries. Its changelog says both.

Rob, Saravana: this one is yours, and it is why the phy patch is safe to
take.

No Fixes: tag. 5e82147de1cb ("net: mdiobus: search for PSE nodes by
parsing PHY nodes.") is the commit to blame, but this is a refactor
across net, phylib and drivers/of plus six new exports, and tagging it
would invite a stable backport of all that to cure a probe-retry loop.

How it works: pse_core gets a notifier chain (REGISTERED /
UNREGISTERED). phylib subscribes, owns phydev->psec, and attaches the
handle when the controller shows up instead of during probe. fwnode_mdio
loses its PSE awareness, so no PSE-originated -EPROBE_DEFER leaves it.
Patch 6 removes the other half, the fw_devlink link that deferred the
phy's driver. With both gone there is no probe-retry loop left.

On the tags: Jonas tested the v4 shape and Aleksander tested the v6
locking, which is unchanged here. Neither tested the fixes above. On the
folded phy patch the code they exercised is intact, so I have kept their
tags there. Jonas's tag also rides on patch 2, and that one did change
in v7 - pse_controller_unregister() is reordered around the event - so
it is the weakest of the tags I kept. Patch 1 only gained a kernel-doc
correction. Happy to drop any of them if either would prefer.

Tested on a Realtek rtl9303 PoE switch with an HS104 PSE controller on
i2c, with a PD drawing power on one port. That board carries the notifier
mechanism from patches 1, 2 and 7; the failure paths of patches 3 and 5
are exercised in QEMU only, below, patch 6 only by booting with it
applied, and patch 4 is build-tested only.

 - clean boot, no probe-retry loop, the controller registers once
 - rmmod is refused while a phy holds a handle
 - i2c unbind: the notifier walk drops the handle and the port powers
   down, and ethtool reports no PSE attached
 - i2c bind: the handle comes back and the PD is powered again
 - six unbind/bind cycles, power domain index stable

Also exercised under QEMU, on arm64 under KASAN, PROVE_LOCKING and
kmemleak. The device tree has five PSE controllers:

 - a working one, plus an MDIO bus with two phys, only one of which
   references a PI. Unbinding the controller detaches that phy's handle
   and rebinding re-attaches it; the other phy is never touched;
   unbinding the MDIO bus releases a live handle.
 - one whose vpwr provider never appears - must defer.
 - one with its vpwr-supply on the controller node instead of the PI
   nodes, which the core resolves one stage later - must defer.
 - one whose controller node carries a vpwr-supply that never appears,
   with the first PI naming its own working supply and the next none, so
   a check that lets of_get_child_regulator() answer the second from the
   first misses the controller's supply - must defer.
 - one shaped like pd692x0, whose PI names a regulator the driver only
   registers from setup_pi_matrix() - must register, not defer.

I confirmed the last three both ways, with and without the fix each is
there for. The WARN_ON in patch 7 stays silent across six unbind cycles
and kmemleak reports nothing.

The same setup stages an over-budget static-priority domain for the
patch 2 case above: releasing a handle in the walk sheds a lower
priority port through pse_disable_pi_pol(). No lockdep splat on that
path, which re-enters the regulator core from a notifier callback under
the chain's rwsem and pse_phy_mutex.

Build matrix, all linking a real vmlinux: PHYLIB=y, PHYLIB=m (the config
that failed to link in v5), PHYLIB=n, PSE_CONTROLLER=n, and CONFIG_OF=n.

Changes in v8:
 - Rewrite the changelogs: drop references to other patches by position
   and to the pending net series (its conflict note is now below the
   --- of patch 2), reflow, and cut review history that belongs here.
 - Patch 2: add Co-developed-by, since the reordering is mine.
 - New patch 4: switch si3474 to dev_err_probe() for the controller
   registration error, so the supply check's -EPROBE_DEFER is not
   logged as an error on every retry.
 - Patch 7: say that any phy registered with a DT node now gets its PI,
   including ones found by mdiobus_scan(), and that a persistent lookup
   error is reported again on each controller registration.
 - Patch 3: clear pi[].pw_d in pse_flush_pw_ds(). The domain is devm
   memory of whoever created it, and pse_pi_is_enabled() still reaches
   that pointer from the regulator "state" attribute.
 - Patch 5: take the PI-node supply lookup only once that PI's own
   vpwr-supply phandle resolves. of_regulator_get_optional() falls back
   to of_get_child_regulator() on the device node, so a PI naming no
   supply of its own was answered from a sibling PI's before the
   controller node was consulted, masking an unresolved vpwr-supply
   there.
 - Patch 5: treat -EPERM from the supply get as resolved. It only means
   another consumer holds the provider exclusively, which the core's own
   resolution never asks about.
 - Patch 5: say why the checks cannot move ahead of setup_pi_matrix(),
   which the review asked for - a pd692x0 PI names a regulator that
   function registers itself.
 - New patch 6: stop "pses" gating probe in fw_devlink, so the phy is not
   left bound to the generic driver once patch 7 removes the deferral.
   Its changelog spells out that the link is managed, so dropping it also
   drops the supplier-unbind cascade and DL_FLAG_AUTOPROBE_CONSUMER, that
   this happens at patch 6 rather than at patch 7, and that on its own it
   lets the phy driver probe and unbind on every MDIO retry.
 - Patch 5: ask the controller-device stage of the supply lookup once for
   the whole controller instead of once per PI.
 - Patch 3: drop the flush_pw_ds label, which had to jump over
   release_pis, in favour of flushing inline at the one failure that
   needs it.
 - Document what is not fixed: the worker drain is only final once the
   phy patch lands, devres already quiesces the irq for tps23881, the OF
   references leak with the PI array on the three paths that keep it, a
   PSE probe failing after registration powers the PI down, and a shared
   power domain can still be freed under a second controller. The last
   is pre-existing and wants the domain out of devm, so not fixed here.
 - Fix changelog claims the review caught: pse_release_pis() does run
   from of_load_pse_pis() too, and nothing retries a PI that resolves
   after the pre-check (v7 said it could "resolve late").
 - Fix the phy_try_attach_pse() comment: other errors are not
   necessarily a broken binding, and -EPROBE_DEFER from a registered
   controller whose vpwr provider is not yet bound is not retried.
 - Patch 3: the shared power domain problem is not a refcount race, as
   my reply to the v7 review put it - pse_register_pw_ds() takes its
   reference under pse_pw_d_mutex and kref_put_mutex() takes that mutex
   for the final put. It is only that the domain is devm memory of the
   controller that created it. Changelog corrected.
 - Correct changelog and comment claims found in a final audit: patch 5's
   comments no longer say nothing retries the consumer at that commit
   (fwnode_mdio still does) or describe a CONFIG_OF=n path that cannot
   be reached; patch 7 no longer says a hard lookup error used to be
   retried by deferred probe - it failed the whole MDIO bus registration.

Changes in v7:
 - Patch 2: reorder pse_controller_unregister() around the event - unlink
   and disable_irq() before it, cancel_work_sync() after it, the frees
   last. The pse_control_head WARN_ON goes with the phy patch instead
   (patch 7 here), with the walk that empties the list - in patch 2 an
   unbind would trip it, since the fwnode_mdio hook still hands out
   handles nothing releases.
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

Changes in v5 (since v4 [4]):
 - Replace rtnl with a dedicated mutex in the PSE attach path; with rtnl
   it deadlocked lantiq_etop [5].
 - Put phydev->psec back in phy_device_remove(), closing the
   use-after-free Paolo forwarded [6].

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
[10] https://lore.kernel.org/netdev/20260927191850.1370515-1-github@szelinsky.de/
[11] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927191850.1370515-1-github%40szelinsky.de

Carlo Szelinsky (4):
  net: pse-pd: unwind allocations when controller registration fails
  net: pse-pd: si3474: use dev_err_probe() for controller registration
  net: pse-pd: check the PI vpwr supply before registering the
    controller
  of: property: do not let "pses" block a consumer's probe

Corey Leavitt (3):
  net: pse-pd: add notifier chain for controller lifecycle events
  net: pse-pd: fire lifecycle events on controller register/unregister
  net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio
    hook

 drivers/net/mdio/fwnode_mdio.c |  34 ----
 drivers/net/phy/phy_device.c   | 144 ++++++++++++++-
 drivers/net/pse-pd/pse_core.c  | 321 +++++++++++++++++++++++++++++++--
 drivers/net/pse-pd/si3474.c    |   7 +-
 drivers/of/property.c          |   5 +-
 include/linux/phy.h            |   7 +
 include/linux/pse-pd/pse.h     |  65 +++++++
 net/ethtool/pse-pd.c           |  16 +-
 8 files changed, 540 insertions(+), 59 deletions(-)


base-commit: e3bfd25626b44b6fa61a13c17178922171d519ce
-- 
2.43.0

