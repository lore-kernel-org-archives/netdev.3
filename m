Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431882;
	b=UnYbYheTysILPyxe8jrtkxntcJP0mtQM08Y24NIs3wwzhicwNEoVFbqql75ejMpKxL4b
	 h+Khq97oyHGW/LVcQ+t35nMoRnTtuJYz116fZo7DoxKbq0HhjWwcvFBT3jc8GpkCfthMW
	 Sn0kkBBGdHMiCZwObEn1WZ8Aykoif5VTDz5HPXeIMdRHNIUQBwJlTff7U8MUPMIShwrg1
	 7+P2GFe43c8lpvpNJJcNXDLrNi+AdB1Rn8wLb/M3BkdQQrmsMcnYjKobh6BrR8KUcoTWC
	 grVZUiV8EfB9Ui8lkVX0MvWuvXlNIape7O64f7g/gpElTiM71i3yzyYZjaeLCZVvKmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rHfu5Fiwslw8nx3rQjsC1CgnJievPpMkkfEzswEbspc=;
	b=Rlnm/5YkPiR5mz7W8viYwQAelYrr0O/Mw8AlpiT8g/6JDeGkbwPX02OoQVILUJH6oT8o
	 zMbdXlTqlBIBFXHvdiNB5kkObvI/KOFrdKR9GwJleRoH2b+C+EBESHKw990yrUXwAzq8Z
	 55myUQkerPt8pGaOxFcR0sk96it9vh/13eZWQiPCEAmGFYwGhlzF08TzQQ+e0FyaqgzQ2
	 kBEPIufIicnkdkjELOjH0/32Y59J7dvVMlaKj922zQfA/BAlBFDVcXl9YeAZEf5tzurp7
	 Oxu2JOMrggmhev6Tp8oLrZZwk0i4QjP12xgvNFEWuTIrELKFK0bBEV08p/vaphFO+cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=hSn8Hujn;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0CD606A33C;
	Wed, 11 Nov 2026 21:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0CD606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=hSn8Hujn
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 0148BE831AD;
	Wed, 11 Nov 2026 22:17:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rHfu5Fiwslw8nx3rQjsC1CgnJievPpMkkfEzswEbspc=;
	b=hSn8HujnHBRN7EP/o0mJImhf2CyuxHKKERkb6eSuv7AR4tVd+/ovBOLcB3X9moyTkKVTPk
	79DSWg8r9aUAauKIwGoMlWrfqavi46cXPTOHdQ1FWH0F9R/Mc2oRJ+ybE9GecbbOtsI2cH
	i2t9bUpItK25LEMG91qYBDIqDndbLt4l2CKnKy0Xswtt6RxhRtFezTOoVptH53URUxOKzP
	JV1sXeO5oFnG2VGZpN1fW0UWQynciuXyIDPJLe25EU61csUC3LiHfiIBWe84JNY3+AbAsd
	vpZAE0M3xGcRZ07ycOu8LilHAsEnla56gyVcMlwL9INt5vD/+VkKJ6mgx3Bkgg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id oWWISYNRiNVk; Wed, 11 Nov 2026 22:17:52 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:17:52 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v4 00/14] net: pse-pd: assorted lifetime and error-path fixes
Date: Wed, 11 Nov 2026 22:17:17 +0100
Message-ID: <20261111211731.3193796-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes for the PSE core and the pd692x0 driver, found while working on
the PSE controller teardown. Most of them are about what happens when a
controller unbinds or fails to register.

 1  The kfifo is too small: podl-pse-regulator and any controller with
    0 or 1 lines cannot register.
 2  Removes two checks that can never be true. Not a fix; it makes 3
    smaller.
 3  A module reference leaks when reading the port state fails.
 4  A failed IRQ request stays in pcdev->irq, so unregister disables a
    line another device may own.
 5  The notification worker can read a PHY that was already freed.
 6  Setting a power limit checks the PI state without the lock.
 7  A power domain shared by two controllers is freed when the one that
    created it unbinds, or when registration fails part way.
 8  Unregister frees the PI array before it stops the IRQ handler and
    the notification worker. The worker can also be queued again
    during unregister.
 9  Unregister frees the PI array while a lookup can still find the
    controller.
 10 The PI regulator ops can run after the PI array is freed.
 11 A failed registration leaks the kfifo.
 12 A shared power domain's supply handle goes stale when the controller
    that created it unbinds.
 13 pd692x0 leaks its manager power budget when probe fails.
 14 pd692x0 crashes on a manager supply that is not resolved yet.

Some patches need earlier ones: 7 needs the locked check from 6, 10 to
12 build on 7 to 9, and 14 relies on 13 to give back a budget that was
already reserved.

Testing: every patch builds on its own with W=1 and is checkpatch
clean. 1, 5, 7, 10 and 12 were tested in QEMU (arm64, KASAN, lockdep,
kmemleak) with test-only fake PSE controllers: without the patch, the
failure in its commit message shows up; with the whole series, the
tests are clean, except for the older lockdep report and the reserved
budget, both listed below. For v4, the whole series was tested again.
The new check in 8 is not covered by these tests, because the fake
controllers have no IRQ. The other patches were found by code
inspection and are build-tested only.

I also tested v4 on real hardware: a Hasivo S1300WP-8XGT-4S+ switch
(RTL9313, two HS104 PSE controllers with an out-of-tree driver, eight
PIs), running OpenWrt with 6.18.55 plus this series:
 - Power delivery, enable and disable with ethtool --set-pse, and the
   delivering LED triggers all work, also on a cold boot where the PSE
   controllers probe after the PHYs.
 - Unbind/bind and rmmod/modprobe of the PSE driver with PHYs attached:
   the PHYs drop and get back their pse_controls, the module refcount
   goes back to 0, and there are no warnings.
 - 50 rounds of unbind and bind of both controllers, while ethtool
   --show-pse/--set-pse loops and LED sysfs reads run on the same
   ports: all ports come back, and dmesg is clean.

Ross Cawston's "net: pse-pd: don't enable a PI again while disabling
it" [1] applies on top of this series without conflicts. The tests
also hit two older bugs that this series does not fix:
 - With the static strategy, turning off a PI to make room for a
   waiting one retries the waiting PI from inside its own allocation,
   which recurses until the kernel stack overflows. [1] removes that
   retry.
 - pse_isr() and setting a power limit hold pcdev->lock and then take
   the supply's regulator lock, while regulator_enable() on a PI takes
   them the other way round. Lockdep reports it when the supply lock
   is contended. Kyle Swenson's RFC [2] removes the PI regulators, so
   the second order goes away.

Older problems that reviews of this series found, not fixed here:
 - A pse_control held by a PHY can outlive its controller. The PSE
   notifier series for net-next fixes this.
 - When a controller unbinds, its PIs are not switched off, and the
   budget they hold stays reserved on the supply. This should use the
   normal disable path, and belongs with the fix above.
 - The notification worker uses the net_device without holding a
   reference to it.
 - Setting a power limit changes the budget and the hardware limit
   under two separate locks, so pse_isr() can run in between.
 - On tps23881, pse_controller_unregister() calls disable_irq() after
   devres has already freed the IRQ.
 - A PI that waits for budget, or was turned off to make room for
   another one, can get budget reserved by a power limit change; that
   budget is not freed when the PI is powered later.
 - The PI regulators are visible before their power domain is set. A
   PI enabled in that short time skips the budget check.
 - pse_control_get_internal() reads the PI state from the hardware and
   sets admin_state_enabled without pcdev->lock.
 - In the regulator core, regulator_request_power_budget() first
   reserves the budget on the parent supply. If the request then fails
   on the regulator itself, the parent's part is not given back.

Kees Cook's devm_kmalloc_obj() conversion, not in mainline yet,
conflicts with 7 in one line of pse_alloc_pw_d(). Keep 7's version:
kzalloc_obj(*pw_d).

Changes in v4:
 - Rebased on the current net/main.
 - 5: shorter comments; the locking rule is now in the kernel-doc
   (Kory, Sashiko).
 - 8: pse_set_config_isr() does not try to power a PI once unregister
   has started, so it no longer reports a false power control error
   (Sashiko). Kory's Reviewed-by is kept, as this is a small change.
 - 9: the comment in pse_controller_unregister() no longer promises
   more than the code does.
 - 10: the commit message names the patches it needs (Sashiko).
 - Collected Reviewed-by tags.
 - v3: https://lore.kernel.org/netdev/20261103220217.1131971-1-github@szelinsky.de/

Changes in v3:
 - Rebased on the current net/main.
 - 7 now also gives back the power domains when pse_register_pw_ds()
   fails part way, moved here from v2 11. The release asserts that
   pse_pw_d_mutex is held (Oleksij).
 - 8 now sets pcdev->unregistering, moved here from v2 10, so the
   worker cannot be queued again after the drain (Sashiko, Oleksij).
   With that, it has a Fixes: tag again.
 - 10 only keeps the PI array until the PI regulators are gone.
   Switching off the PIs on unbind is dropped (Oleksij); this also
   drops the lock order problem Sashiko found in it.
 - 11 only frees the kfifo now, so its subject changed.
 - 12: asserts that pse_pw_d_mutex is held in pse_pw_d_leave(),
   renames pse_pw_d_release_locked() to pse_pw_d_release() (Oleksij),
   and wraps two lines to 80 columns.
 - Collected Acked-by tags. Dropped the tags on 7 and 8, as their code
   changed.
 - v2: https://lore.kernel.org/netdev/20261020171249.853085-1-github@szelinsky.de/

[1] https://lore.kernel.org/netdev/20261019220835.613-1-ross@r-sc.ca/
[2] https://lore.kernel.org/netdev/20261020-pse_regulator_fixes-v1-1-fd6084a22cba@est.tech/

Carlo Szelinsky (14):
  net: pse-pd: size the notification kfifo after defaulting nr_lines
  net: pse-pd: remove dead pi_get_admin_state() checks
  net: pse-pd: fix module refcount leak in pse_control_get_internal()
  net: pse-pd: do not keep a failed IRQ in pcdev->irq
  net: pse-pd: do not reach a freed PHY from the notification worker
  net: pse-pd: check the PI state under the lock when setting a power
    limit
  net: pse-pd: do not tie a shared power domain to its creator's devres
  net: pse-pd: stop async event sources before freeing PI data in
    unregister
  net: pse-pd: unregister from the controller list before freeing PI
    data
  net: pse-pd: keep the PI data until the PI regulators are gone
  net: pse-pd: free the notification kfifo when registration fails
  net: pse-pd: use each PI's own supply handle for the power budget
  net: pse-pd: pd692x0: release the manager power budget through devres
  net: pse-pd: pd692x0: defer probe while a manager supply is unresolved

 drivers/net/pse-pd/pd692x0.c  |  31 +++-
 drivers/net/pse-pd/pse_core.c | 301 +++++++++++++++++++++++-----------
 include/linux/pse-pd/pse.h    |   5 +
 3 files changed, 234 insertions(+), 103 deletions(-)


base-commit: 070411c1590c8172eb4d86f045d99c372f22fe23
-- 
2.43.0

