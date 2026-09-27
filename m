Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB93B8D4F;
	Sun, 27 Sep 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511100; cv=none; b=ciNfxfFxzRTbwYg+BuHYhdQ1tiMrIdAs5jgCOH9NPD/FEn01gEhQurdUFZNGjlALCKaZw/lphWKBWSl9uJf8al4C/7wQGcASThv7DmBFaLG6jC5JdonSLI+gs8DUCuJPdX/1LfE6xAaKNLqNKsMQflSJGZ5J0A+agrYCgotxOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511100; c=relaxed/simple;
	bh=rErvqSm2D7Pb0YD00v5JrmE6FK9DZRXYdNgS5wg5g2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezK6PxxNWcRQRPTq6lycO8fkOxRHRx80wF51MHmn00nD3Kzu72FWDkFRkDlcOoISA8JRGmMZJzR4Ehiy/wF0wW2JVH9iDdjf5dw4LawoXgy6qXWU8JQFuXcRGGpyrT+uMuxBWdk+DT+u0xPFvlSHQRBsXh08C2F+tNPsSdOMdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=PvPrFuF4; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="PvPrFuF4"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id A08EAE837FF;
	Sun, 27 Sep 2026 14:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1790510768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4jo0jjy2XCDVRSVsZS4cqMgn/Q1feuitrEHEwIs2bs=;
	b=PvPrFuF4kQcATWbgRZiTtnTOy9K6L1vTpVAYeSEZrJxb+2tzYgw9lZb7p42LbwoOObJ7f1
	Ny4U6wlzYcibz8AFU+PAL5E4X7xmED8gxVD0kc4PJPvp/mmppEDjAUZg0en1rsNHTnT62R
	x/Q3WHDTfz6JCfZmvGRo5rH9JJDm3hYdy0/uGM4PmpiA8/2VJ2zY49Q8tF5iL+DpcwQw2k
	K1TiujgUf3mPOwPgWYiW10wkIReE9ZTQLM7zpIqB9wWXYAe7wVkX9GDYEheZmulfhxJ0ve
	IEHzrzlCzBrF4VcUD6sb100t7xu2gisf655UFdm2n9Oaf3TPodOzM0m3Y+9ISA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id D9r4cbAJsvq6; Sun, 27 Sep 2026 14:06:08 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-212.088.070.pools.vodafone-ip.de [88.70.183.212])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 27 Sep 2026 14:06:07 +0200 (CEST)
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
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net-next v6 0/5] net: pse-pd: decouple controller lookup from MDIO probe
Date: Sun, 27 Sep 2026 14:05:48 +0200
Message-ID: <20260927120548.367616-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2e89ce5a-3d7c-42fd-af82-899f6bc8a64a@redhat.com>
References: <2e89ce5a-3d7c-42fd-af82-899f6bc8a64a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Spoiler: this is heavily assisted by AI agents - without them a change
this size would get too complicated for me to hold together. Everything
in it is verified by me personally.

Thanks for the feedback, and for the pointer to c82ff94592fb - I had read
the sashiko mails but hadn't replied, which is exactly what that commit
says not to do. Won't happen again.

I ran v7 through https://sashiko.dev/ myself before posting, as that
commit asks, and it was worth doing. It found a regression I had missed,
and later passes found more. Those are covered below. Doing that first
should also keep the volume down on your side.

You're right that most of the [High] ones are just the state of the tree
between v6 patches 3 and 5. Instead of saying that five times, v7 folds
v6 patches 3, 4 and 5 into one. The rtnl detour and the deferred release
are then gone from every commit, so those findings no longer apply.

v7 follows this mail. It is still five patches, but not the same five -
the review before posting found a regression that needed two more
pse_core fixes. I go through everything below anyway, one block per
patch. The numbering is v6's, to match the review mails.


1/5 - notifier chain
https://lore.kernel.org/netdev/178893559565.219967.17359688741683052582@kernel.org/

> [Low] exported with no in-tree caller at this commit

The review says itself this is the usual "add the API, then use it" split.
Nothing to do.


2/5 - fire lifecycle events
https://lore.kernel.org/netdev/178893559705.219967.11674800741670127760@kernel.org/

> [Low] the call sites discard the return value

The first half is right, but not worth doing. There is one subscriber in
tree, phy_pse_notifier_event(), and it returns NOTIFY_OK or NOTIFY_DONE,
so nothing can stop the chain. A notifier_to_errno() check would test
for something that cannot happen today.

The second half is worth doing. In v7, by the time cancel_work_sync()
returns, every handle should be gone: the walk drops the phy's and the
drain drops the worker's. So if pcdev->pse_control_head is not empty
there, someone still holds one I did not account for. That is the bug I
describe further down. v7 patch 2 adds that warning.

> [High] PSE_UNREGISTERED fires while pcdev is still on pse_controller_list

Real, and v7 closes it here rather than leaving it to my net series [1].

My first answer was going to be that the race isn't new. The old fwnode
lookup ran from the same registration path, so it could wait for [1],
whose patch 3 moves list_del() ahead of pse_release_pis().

That is true but it isn't the whole picture. After the phy patch, a
second controller registering runs a PSE_REGISTERED walk that calls
of_pse_control_get() for every phy on mdio_bus_type. So this series adds
a second trigger, and it is the one a two-controller board hits. Mine is
one.

So v7 patch 2 reorders pse_controller_unregister() around the event.
disable_irq() and the unlink both move above it. of_pse_control_get() is
the only thing that walks pse_controller_list, and subscribers get pcdev
as the event data, so nothing needs the controller listed. A lookup can
then no longer reach a controller whose pi[] is about to go.

cancel_work_sync() moves the other way, below the event. That is the
next answer.

[1] still stands on its own for net and stable.

> [High, pre-existing] pi freed before the worker is drained

I had this filed as [1]'s problem. That was wrong.

Before this series the phy's reference outlived the whole teardown. The
worker takes a transient reference through pse_control_find_by_id(), but
it could never be the last one, so __pse_control_release() did not run
during unregister at all.

The PSE_UNREGISTERED walk changes that. It drops the phy's reference, so
the worker's put can be the last one. Left as it was, that put would
land after pse_release_pis() had freed pcdev->pi. The window is much
smaller than the one it replaces, but it is new, so it belongs in this
series. The reorder below is what closes it.

The obvious fix is cancel_work_sync() ahead of the frees, which is what
[1] does for net. On its own that is not enough here, because the walk
does more than drop references.

A subscriber dropping the last reference reaches
__pse_control_release(), which calls regulator_disable() if the PI is
still on. With the static budget strategy that retries any port on the
same power domain waiting for power, and if the domain is still over
budget it sheds a lower priority port through pse_disable_pi_pol(),
which queues a notification and calls schedule_work(). So draining the
worker before the walk leaves new work queued behind it, racing the
kfifo_free() below.

Narrow - it needs tps23881 or another PSE_BUDGET_EVAL_STRAT_STATIC
controller, over budget, with a port pending - but reachable.

So in v7 patch 2 cancel_work_sync() sits after the event, with the frees
below both. The order is not the same as [1]'s. There the unlink sits
below cancel_work_sync() and pse_flush_pw_ds(), which is fine because
[1] has no event to place. Here the event has to be after the unlink and
before the frees, and cancel_work_sync() after the event, so the unlink
moves to the top.

The two will conflict on the back-merge - I tried the merge, and
pse_controller_unregister() comes out with two conflict hunks. The
merged function wants v7's order, which contains [1]'s fix. The cover
spells it out.

Kory reviewed [1]. This one turns on pse_pw_d_retry_power_delivery()
re-entering from a release, so I would like him to check the placement
here too.

[1] has been sitting at Changes Requested since August, I'll respin it.


3/5 - own phydev->psec via the notifier
https://lore.kernel.org/netdev/178893559852.219967.17408171091451392990@kernel.org/

> [Low] is the module unload part of this rationale the right way round?

No, it is the wrong way round. try_module_get() pins the provider for as
long as a phy holds a handle, so rmmod is refused before the module exit
path runs and the walk never runs at all. What the walk covers is driver
unbind and device removal, and v7 says that instead.

> [Low] no Fixes: tag, no target tree

The target tree is in the subject line. On the Fixes: tag - 5e82147de1cb
("net: mdiobus: search for PSE nodes by parsing PHY nodes") is the commit
to blame, but this is a refactor across two subsystems plus a new export,
and tagging it invites a stable backport of all that to cure a
probe-retry loop. Say the word if you want it anyway.

> [Medium] is every error other than -ENOENT/-EPROBE_DEFER really a broken
> binding?

Fair point. pse_pi_is_hw_enabled() talks to the chip over i2c on
tps23881, si3474, pd692x0 and realtek-pse-mcu, so -EIO is possible.
Before this series that error came back out of
fwnode_mdiobus_register_phy() and deferred probe retried it. Now the
port ends up without PSE, and phy_try_attach_pse() logs it with
phydev_warn() rather than dropping it silently. Patch 5 documents that.

For a genuinely transient i2c error I am not convinced a retry is worth
it. That needs a work item and a give-up policy, in a series whose whole
point is taking work out of the probe path.

Running v7 through sashiko.dev before posting turned up a worse case of
the same thing, which I had missed and so had the review on the list.
-EPROBE_DEFER here does not only mean "controller not registered yet".

Every PI regulator is registered with a "vpwr" supply, and the regulator
core treats an unresolved supply at registration as non-fatal. So
pse_controller_register() completes, PSE_REGISTERED fires, and
regulator_get_exclusive() inside pse_control_get_internal() keeps
returning -EPROBE_DEFER until the vpwr provider shows up. phylib has no
event left to retry on, so the port loses PSE for good, and silently.
Deferred probe on the MDIO bus used to recover exactly that.

So my "the notifier retries the latter at PSE_REGISTERED time" was wrong
for that case. v7 patch 4 checks the PI's vpwr supply before registering
anything, so the PSE driver's own probe defers and the ordering goes
back where deferred probe can handle it.

That in turn makes -EPROBE_DEFER a routine return from
pse_controller_register(), which has no error unwind at all. The
notification kfifo, the PI array and an OF reference per described PI
are leaked on every failure, and a partial pse_register_pw_ds() leaves
devm-allocated power domains in the global xarray for the next
registration to trip over.

Today those failures are terminal, so each leaks once. With the supply
check the leak would repeat on every deferred-probe retry. So v7 also
adds the unwind, as patch 3, ahead of the supply check.

It unwinds at two depths, which is worth flagging.
pse_pi_ops.is_enabled, .enable and .disable all index pcdev->pi[], and
the PI regulators are devm-registered on pcdev->dev. So from the first
successful registration until devres unwinds the failed probe there are
live regulators whose ops would follow a freed pointer.
regulator_late_cleanup() and the "state" attribute both reach them.

The array is released on the failures that happen while it exists and
before the first regulator does: setup_pi_matrix() and the supply check.
Earlier than that there is nothing to release - pcdev->pi is still NULL,
or of_load_pse_pis() has already freed it - and from the registration
loop on it has to stay. An allocation failure in the loop's first
iteration therefore leaks it too, where releasing would have been safe,
but the rule stays simple. The supply check runs before the loop, so the
ordinary deferral releases the array.

On an arm64 boot with a PI whose supply never appears, kmemleak is clean
with that patch in place.

Unrelated thing I noticed while checking pse_control_get_internal():
two exits after a successful try_module_get() jump to free_psec instead
of put_module - the missing pi_get_admin_state callback, and a failing
pse_pi_is_hw_enabled(). Both leak a module reference. Pre-existing, and
it has to go to net separately.

> [High] deferred put vs the bus walk
> [High] does the detach walk close the UAF
> [Medium] worker as last holder

The first is the intermediate state that v6 patch 5 removes, and v7
folds away entirely. The second is the list_del ordering above. The
third is the worker answer under 2/5 - it turned out to be this series'
problem, not [1]'s.


4/5 - dedicated mutex instead of rtnl
https://lore.kernel.org/netdev/178893560000.219967.12262382469111881440@kernel.org/

> [Low] does netsec belong in that list?

No, netsec does not belong there. It brings its MDIO bus up in probe,
before register_netdev(). ndo_init allocates the rings, power-cycles the
phy over that bus and resets the hardware - which only works because the
bus is already there. lantiq_etop and sni_ave do match. v7 drops netsec.

> [Medium] the deadlock was introduced two patches earlier, series isn't
> bisectable

Folded for v7. I agree the UAF windows aren't worth restructuring for,
but at v6 patch 3 alone lantiq_etop and sni_ave hang on probe, and that
is a boot failure rather than a theoretical window. So v6 patches 4 and
5 go into 3, and the intermediate states are gone. Each of the five
commits builds on its own.

Jonas's and Aleksander's tags are on the folded patch. Jonas's tag is
also on patch 2, which did change in v7, and the cover says so.

> [High] off-bus phy keeps its pse_control
> [High] does the mutex cover the teardown

Intermediate state again, and the list_del ordering again. The
kernel-doc is fixed either way: the mutex serialises phydev->psec
against the notifier walk, the phy attach and detach paths and the
ethtool paths. It does not protect the controller teardown and no longer
says it does.


5/5 - put phydev->psec back in phy_device_remove()
https://lore.kernel.org/netdev/178893560151.219967.4509880385605166044@kernel.org/

> [Medium] in-series regression fixed by a later patch, with no
> attribution

Same answer as under 4/5. v7 folds v6 patches 3, 4 and 5 into one, so
there is no intermediate regression left, and nothing to attribute.

> [Medium] do the error paths of phy_device_register() still reach it?

They don't. That is a real leak, and v7 fixes it.

device_add() puts the phy on the klist in bus_add_device() and can still
fail after that, so a concurrent PSE_REGISTERED walk can attach a handle
that nobody ever puts. The obvious fix is a locked put at the out:
label, since the unwind calls bus_remove_device() for us. That is
exactly what makes it wrong: by then the phy is off the bus, so the
PSE_UNREGISTERED walk misses it too, and a concurrent unregister can
free pcdev->pi before the put reads it.

v7 instead sets phydev->psec_detached before device_add() and clears it
only once registration has succeeded. No handle can be attached in that
window, so there is nothing to release on the error path.

> [High] can PSE_REGISTERED re-attach after the put has run?

Yes, that one's real. The phy only comes off the mdio_bus_type klist in
bus_remove_device(), which is a good way into device_del(), so between
our unlock and that point the walk still sees it, psec is NULL again,
and phy_try_attach_pse() re-binds it.

The suggested fix doesn't work though. With the put after device_del(),
the phy is off the klist first, so an unregistering controller can walk
past it, free pcdev->pi, and then our put hits the freed array in
__pse_control_release() - which is the UAF this patch exists to fix. The
put has to stay in front of device_del(): while the phy is still on the
klist the walk and the put take the same mutex, so whoever is second sees
NULL.

So v7 marks the phy as detached under the same lock and has
phy_try_attach_pse() skip it. I did look at just holding pse_phy_lock()
across device_del(), but that puts the PSE mutex above driver removal and
the whole sysfs teardown, which seems like a lot for a window this small.

The flag is a plain bool, not another bit in the flags word. It would
otherwise share a storage unit with suspended and sysfs_links, which
are written under phydev->lock and rtnl while this one is written under
pse_phy_lock().

> [High] "can no longer outlive the PSE controller" - accurate?

Not as flatly as v6 put it. v7 says what the patch actually gives you:
the phy's own reference goes away synchronously while it is still on
the bus. With patch 2 unlinking the controller first, the controller
side is closed too, so the claim holds for a different reason than the
one v6 gave.

> [High, pre-existing] nothing clears psec->attached_phydev

Agreed. attached_phydev is only set when a fresh handle is allocated, an
existing one at the same index is just kref_get()'d, and nothing ever
clears it - so pse_send_ntf_worker() can end up dereferencing a freed
phy_device.

Not something this series introduces, and it needs a pse_core helper to
clear it under pse_list_mutex. It has to go to net separately, after
this series, with:

Fixes: fa2f0454174c ("net: pse-pd: Introduce attached_phydev to pse control")


So v7, which follows shortly, is five patches again, but not the same
five:

  - v6 patches 3, 4 and 5 folded into one, no intermediate rtnl or
    deferred release
  - patch 2 now reorders pse_controller_unregister() around the event -
    unlink and disable_irq() before it, cancel_work_sync() after it, the
    frees last - closing both the lookup-versus-teardown race and the
    worker-as-last-holder one inside this series
  - patch 2 also warns if pcdev->pse_control_head is not empty once the
    worker is drained
  - new patch 3: unwind the kfifo and PI allocations when controller
    registration fails
  - new patch 4: check the PI vpwr supply before registering the
    controller, so a consumer never meets a registered controller that
    can only answer -EPROBE_DEFER
  - psec_detached is held across registration as well as removal, so
    the PSE_REGISTERED walk can't attach a handle nothing will free
  - psec_detached is a plain bool rather than another bit in the flags
    word, since it is written under pse_phy_lock() while its neighbours
    are written under phydev->lock and rtnl
  - netsec dropped, module-unload wording fixed, the probe-defer
    behaviour change documented
  - kernel-doc no longer claims the mutex protects controller teardown
  - <linux/notifier.h> included where struct notifier_block is used

One more thing turned up while testing patch 3 on a device tree where
the vpwr provider never appears. pse_controller_register() calls
kfifo_alloc() with pcdev->nr_lines before the "if (!nr_lines) nr_lines =
1" default below it, and __kfifo_alloc() rejects a size under two. So a
controller with nr_lines of 0 or 1 cannot register at all, and that
default is dead code. The three drivers with a compile-time constant
cannot hit it; realtek-pse-mcu-core takes nr_lines from the device at
runtime, so it is the one that could. Pre-existing, one line to fix,
and it has to go to net separately.

So, separately against net: the leaked module ref, the attached_phydev
back-pointer, that kfifo ordering, and a respin of [1].

[1] https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/

Thanks,
Carlo
