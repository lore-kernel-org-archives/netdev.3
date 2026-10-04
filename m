Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518652EEE75;
	Sun,  4 Oct 2026 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124455; cv=none; b=F4XcXSEWIoeRIXNTl1ig4dQZxXwaeAMMbuhzWC+2qMgycoJGPOf1X3lcaEzGw9mwsIThMQDI3a+cGXDbYRNlU1AHt15GOEwyKoLK7tLyUX7FktoSc3l9lHGXRNw6woP96iLBK4gLkoZ6Pz9eJJjXLYAWY4dYXmwlsEVKULe2C9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124455; c=relaxed/simple;
	bh=x/CkPs5ju8X+uBtaYGJYEhKyJtXFukfvQzWvslnZ1KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/CxN8LRbzNblVRsVRn2cOvSTYGKo/QMj5miiFQarVzZ5BC1+vTcppIj+QjdyYU2NMsyX4MIe4PYf2HNnokoROqIDdSSVgdO3Rr/rTpWlFkqFmCq0NtkbSJW+Ns0R/4P+Laudx/xmRvZc36mw8TtcpSdlmPL7NRyh40qyDMhUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=PoavaiPo; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="PoavaiPo"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id D315FE8322C;
	Sun, 04 Oct 2026 16:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1791124443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StKiYi9iJrZ2ynJtqg7rY64P6f6HyK3/3awHOz1ktZU=;
	b=PoavaiPok8XTKF5XmV1O/ZtkVq0R1OXhUUJlbTGJQQC/aH0FF5cmLCFV1EYJf3j1VyrnP8
	eXrV7/8eeboPTaosLbgZfCzS2uEK5UlRF+EcTO4CfCWaIMXJN70MieOVT6kQKjF5ixMe+3
	lNRAY5l21L5O5DjqjAxc/0QvnoJ3CiDywpieZLVz5LhhrxpTQwGe5tTXnGrful/yDutReU
	oApd4sOvt610v3COrzCNY3bZTufOhh7XOPr6YSQDCLUDaZr/fSRN4yCC7nWqbHKNC+1TYv
	3/fCRh8SNd1kTKHhhG62I3aAbBdC/ecRHWO0cAZxQWNB692dGfLsSvVXuLbtSg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id UzSXedJARIK7; Sun,  4 Oct 2026 16:34:03 +0200 (CEST)
Received: from p14sgen5.lan (86-103-67-252.ip.tng.de [86.103.67.252])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 04 Oct 2026 16:34:02 +0200 (CEST)
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/5] net: pse-pd: decouple controller lookup from MDIO probe
Date: Sun,  4 Oct 2026 16:33:51 +0200
Message-ID: <20261004143351.969544-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927191850.1370515-1-github@szelinsky.de>
References: <20260927191850.1370515-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey guys,
One process question first. I do run an LLM review before posting, as
maintainer-netdev.rst asks. I ran the review prompts (masoncl) locally 
against a frontier model and still got a different set of findings than
the bot reported here. If there is a better way to run it so the two 
line up, I would be glad to hear it - right now I cannot tell whether 
I am missing setup or just reading different output.

On the review itself: it turned up something in code I added in v7, so I
am answering per patch below. v8 follows with the fixes.

Four findings I fixed in code, one I disagree with and say why, one is
real but belongs in a net fix rather than here, five I have conceded in
the changelogs, and five are pre-existing and want separate net patches
rather than growing this series. Everything I claim to have checked, I
checked against the tree rather than reasoning from the changelogs.

pw-bot: cr

patch 4, [High] sibling-PI supply lookup
----------------------------------------

Correct. of_get_regulator() first reads the vpwr-supply phandle from the
node it is given. If there is none, it calls
of_get_child_regulator(dev->of_node), which walks every node under that
device. I passed pcdev->dev as the device and the PI node as the node. So
for a PI with no supply of its own, the walk went over the whole
controller and found a sibling PI's supply, and the check passed. The
core does not do this in its first stage. There it looks at the PI node
only.

v8 takes the first stage only once the PI's own phandle resolves, so the
walk is never reached. I resolve the phandle instead of only testing that
the property is there, so a broken phandle cannot slip into the walk
either.

One part of the finding is too strong, and my first v8 comment had the
same mistake. The core does reach that sibling walk, but in its second
stage, through regulator_dev_lookup(pcdev->dev). So the gate does not
stop the sibling walk. What it stops is a supply on the controller node
being hidden by a sibling's.

v8 also treats -EPERM as resolved. _regulator_get_common() returns it
when someone else holds the provider exclusively. The provider is still
there, and regulator_resolve_supply() never checks this, so failing here
would block a registration the core would have finished.

patch 4, [Medium] deferral after setup_pi_matrix()
--------------------------------------------------

The leak is real. pd692x0 claims a power budget in setup_pi_matrix(). It
frees it only from that function's own error labels or from remove(), and
neither runs when registration fails later.

But the suggested fix does not work. I tried it. microchip,pd692x0.yaml
has

  pse-pi@0 { vpwr-supply = <&manager0>; };

and manager0's regulator is registered by
pd692x0_register_manager_regulator(dev, name, manager[i].node), with
rconfig.of_node set to that manager node. That call comes from
pd692x0_setup_pi_matrix(). So checking the supply before
setup_pi_matrix() asks for a regulator that only this driver can create.
It returns -EPROBE_DEFER every time and pd692x0 never probes.

I added a controller of that shape to my test setup and ran it both ways.
With the checks moved early it logs "PI 0: failed to get vpwr supply" and
stays in deferred probe. With them where they are it registers. So the
loop stays after setup_pi_matrix(), and the v8 changelog says what that
placement does not clean up.

For pd692x0 the new deferral does not fire anyway: the supplies its PIs
name are the manager regulators setup_pi_matrix() has just registered. A
board that points a pd692x0 PI at an external provider would hit the
leak, and that cleanup belongs in pd692x0.

patch 2, [High] worker re-queued after cancel_work_sync()
---------------------------------------------------------

Right, and the changelog said more than it should. At that commit every
phy still gets its handle from fwnode_mdio, and only phy_device_remove()
releases it. So an ethtool path can queue work after the drain. The tree
behaves that way today and this patch does not make it worse. It closes
once the phy patch releases those handles in the event and takes
pse_phy_lock() on both sides. v8 says that instead of implying the race
is already closed.

patch 2, [Low] disable_irq() and devres ordering
------------------------------------------------

Right. tps23881 is the only in-tree user of devm_pse_irq_helper(), and it
requests the irq after devm_pse_controller_register(). devres unwinds in
reverse, so free_irq() runs first and the handler is already stopped
before this disable_irq(). The move matters for a driver that requests
its irq earlier, instead of leaving the ordering to devres. Comment and
changelog both reworded.

While there: devm_pse_irq_helper() sets pcdev->irq even when
devm_request_threaded_irq() fails, so disable_irq() can be called on an
irq that was never requested. Pre-existing, and on my list below.

patch 3, [High] flush_pw_ds() vs a concurrent controller
--------------------------------------------------------

Real. I am not fixing it here. Reason below.

kref_put_mutex() drops the count outside pse_pw_d_mutex. And
pse_register_pw_ds() takes a new reference with a plain kref_get(), after
an xa_for_each() under that mutex. So another controller on the same
supply can take a reference while this unwind drops the last one. The
count then goes 2->1, nothing is released, and devres frees the pw_d
anyway, because that memory belongs to the controller that created it.

Closing that window does not fix the real problem. A power domain can be
shared by two controllers, but its memory belongs to the one that created
it, through devm. So any time a controller with a shared domain goes
away, that memory is freed while the other controller still points at it.
This is true with or without this patch.

The fix is to move the domain out of devm and use kref_get_unless_zero()
in the lookup. That is a net fix. It does not belong in a patch that is
only meant to stop the common failure leaking.

What this patch does fix happens every time today: a controller fails to
register, leaves its domains in pse_pw_d_map, and the next controller
reads them in regulator_is_equal(). v8 says which case is left open.

patch 3, [Medium] pi[i].pw_d left dangling
------------------------------------------

Fixed in v8. pse_flush_pw_ds() clears it now.

The domain is devm memory of whichever controller created it, so it can
go as soon as that probe unwinds. But pse_pi_is_enabled() still reads
pi[].pw_d through the regulator "state" attribute, and the PI regulators
are only unregistered after us. So the pointer had to go.

Before relying on NULL there I checked every place that reads pi[].pw_d.
They are all guarded, and pse_pw_d_is_sw_pw_control() returns false for
NULL, so a read in that window now falls back to the hardware state
instead of touching freed memory.

patch 3, [Medium] OF references on the paths that keep pi[]
-----------------------------------------------------------

Accurate, and my changelog invited that reading.

The OF references are taken per PI in of_load_pse_pis() and dropped only
by pse_release_pis(). So they travel with the array: recovered wherever
release_pis is reached, and leaked together with the array on the three
paths that end at free_kfifo. Same trade as the array, and v8 now says
so plainly instead of listing the references among the things it fixes.

One more thing in that changelog was simply wrong. I wrote that
pse_release_pis() only runs from pse_controller_unregister().
of_load_pse_pis() calls it on its own error path too. Fixed.

patch 4/5, [Medium] -EPROBE_DEFER no longer retried
---------------------------------------------------

Conceded. v8 no longer says a PI "can resolve late" - that implied
something recovers it, and nothing does. There is no retry until the next
PSE_REGISTERED or a phy re-registration.

fw_devlink does not close this window for the form the bindings
document. A vpwr-supply in a pse-pi node links the pse-pi node, not the
controller, so the controller only gets a SYNC_STATE_ONLY proxy link from
it, and device_links_check_suppliers() does not hold its probe for those.
Only a vpwr-supply on the controller node delays the probe.

patch 5/5, [Medium] ports powered down when a PSE probe fails late
----------------------------------------------------------------

Real, and now documented.

The REGISTERED walk runs inside pse_controller_register(), so handles get
attached part way through the PSE driver's probe. For a PI the hardware
already has powered, pse_control_get_internal() records
admin_state_enabled. If a later probe step then fails - tps23881 requests
its irq after registration - devres runs the UNREGISTERED walk, the last
reference goes, and __pse_control_release() disables the PI.

So a port that was up before the driver loaded gets powered down when
that driver fails to finish probing. It is the same thing a clean unbind
does, and the alternative is leaving a port owned by a controller that is
going away.

patch 5/5, [Medium] fw_devlink leaves the phy on genphy
-----------------------------------------------------

"pses" is an enforcing supplier binding. So once the MDIO deferral goes,
the phy registers while its own driver is still held in
device_links_check_suppliers(). If a MAC attaches in that window,
phy_attach_direct() falls back to genphy, and device_bind_driver() ->
device_links_force_bind() binds it past the pending link. Nothing
re-probes the phy later, so it stays on genphy.

v8 adds a drivers/of patch marking the link FWLINK_FLAG_IGNORE. It sits
before the phy patch, so no commit carries the window. Rob, Saravana:
that one is yours.

It drops the device link completely rather than relaxing it -
fw_devlink_create_devlink() returns early and the fwnode link is deleted
at the consumer's device_add().

Two things do ride on that link, and I had the changelog wrong about this
at first, so to be explicit: the link is managed. The fwnode link sits on
the phy's own node, so fw_devlink_create_devlink() takes its
"con->fwnode == link->consumer" branch and asks for fw_devlink_flags,
which defaults to FW_DEVLINK_FLAGS_RPM; that has neither
DL_FLAG_STATELESS nor DL_FLAG_SYNC_STATE_ONLY, so device_link_add()
promotes it to DL_FLAG_MANAGED and device_links_unbind_consumers() acts
on it. So unbinding the PSE controller releases the phy's driver today,
and DL_FLAG_AUTOPROBE_CONSUMER probes the phy when the controller binds.

Both are given up on purpose: the notifier does the attach and detach now
and does not tear the phy driver down, and with the deferral gone there
is nothing for an autoprobe to wait on. DL_FLAG_PM_RUNTIME is the one
that really had no effect, and there is no dpm or devices_kset ordering
to lose.

That also makes patch 5 not a no-op on its own. The MDIO path registers
the phy before it looks the PI up, so the link exists and goes active as
soon as the controller binds - the cascade therefore goes away at patch 5
rather than at the phy patch. It also stops holding the phy's driver back
during the MDIO retries, so with patch 5 alone the driver probes inside
device_add() and is removed again on each retry until the controller
binds; the phy patch removes the retries. The changelog says all of this
now.

phy_try_attach_pse() comment
----------------------------

Separately: the comment still said that any error other than -ENOENT or
-EPROBE_DEFER "means a broken binding". That is not true. -ENOMEM lands
there, and so does -EPERM from regulator_get_exclusive() when the PI is
already held exclusively - _regulator_get_common() returns that from its
"if (rdev->exclusive)" test, before it ever looks at open_count. I agreed
this was wrong in the v6 thread but only fixed the changelog back then.
The comment is fixed in v8, and it now also says that -EPROBE_DEFER from
a registered controller, while its vpwr provider is not yet bound, is not
retried.

Pre-existing, and I would rather send these as separate net patches than
grow this series
-----------------------------------------------------------------------

All five verified against the base this series sits on, e3bfd25626b4:

- pse_controller_register() calls kfifo_alloc() with pcdev->nr_lines
  before the 0 -> 1 fixup, and __kfifo_alloc_node() rejects a rounded
  size below 2. pse_regulator.c never sets nr_lines, so it stays 0 and
  podl-pse-regulator cannot register at all on net-next today. Any
  driver with one PI fails the same way, and realtek-pse-mcu-core.c can
  reach that since it accepts max_ports == 1 from the MCU. I ran into
  this building a one-PI test controller. Fixes: ffef61d6d273.

- devm_pse_irq_helper() sets pcdev->irq even when
  devm_request_threaded_irq() fails. pse_controller_unregister() then
  calls disable_irq() on an irq that was never requested.

- pse_control_get_internal() leaks a module reference: the
  !pi_get_admin_state and pse_pi_is_hw_enabled() < 0 paths goto free_psec,
  which sits below put_module. The retry walk makes it easier to hit.

- psec->attached_phydev is a raw pointer with no device reference and is
  never cleared. pse_send_ntf_worker() reaches it through
  pse_control_get_netdev(), which dereferences
  psec->attached_phydev->attached_dev under rtnl_lock() but not
  pse_phy_lock().

  I had this wrong when I first looked at the two-phys-on-one-PI variant,
  so to correct myself: no second handle is created, but not because the
  second get is refused. pse_control_get_internal() walks
  pcdev->pse_control_head first and returns a matching psec with a
  kref_get(), before any regulator_get_exclusive() runs, so the handle is
  shared rather than rejected - and it keeps attached_phydev pointing at
  the first phy, which is exactly the case raised. It behaves identically
  before this series, since fwnode_mdiobus_register_phy() made the same
  call for each phy, so it is not a regression here, but it is reachable
  and the net fix should cover it.

- pse_release_pis() frees pcdev->pi while the PI regulators are still
  registered - devm_pse_controller_register() adds its devres node after
  them, so unregister runs first and the regulator "state" attribute can
  read freed memory. This one is already covered by my pending net
  series:
  https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/

Thanks for the review. v8 follows this mail.

Carlo
