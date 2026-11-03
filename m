Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743364;
	b=iNT+K6IsN6PhywlNOpagiN/rgHI7S7PUIQTS01hVIBsad0Ua+lgVotAqa1x1w3JHcX5x
	 pyjDb4Ff1QuKfyRqqfeSHuHf0/f4dYwaYviD8tlM1VnDK1V5OIcnIb38IhBA/XOtgW5CQ
	 iEIt85fr3vW9w95gzbVpPvGcGM0dtS+7aIu8VCR5DpG8ho0yi0lN5/XqZ5+Aw22Xy7K1d
	 AXIGqH4PZIl/P3U6fMX7aPIZKr2S7N4JaB66mycAnS2+PPxP9sp1xBjCvNUSb2VaELHD2
	 IUWshnJ3VIn4xTzy650scb/Nhb5LK1KmyvvRr/lwClpmb/UWvoezsxsUpaeVWqj54jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TSnUKrKO08Kh91aAnhcejusIowFm6XHDQWTTgaiUk/4=;
	b=P5ls/42uebgWmczoTO+qiu3M4Lh/L74ap25m6lg425a36EFBUy9UWpwpnTwwVzstVyam
	 muav4QdlM3Qa55WWqg+0BAlvQ9dFjRumVLvUYNHzs+OFEMiGevKE4pPQinFL4wXQ+3Xae
	 UttxkqcZZrLX/C5y6zJ9INCoVTwweCU37SnGIOC+MNgVMT/p+lL0B94z4vhB68bjEcvgC
	 IJS6krOFI1Ujjlz7P3qIgq0g05o+jELLKxby30l8I9Znwf7hwf+ZwB9SmK6eO+bqosTZG
	 TyPQTXb5Ormdus1w7/7/JOmmnqrs4y81ikSiOu7X4rBWwctVTIj9bNQkMILca4jJ5cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=K2MAPLLt;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52B606A324;
	Tue,  3 Nov 2026 22:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD52B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=K2MAPLLt
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 7FDE0E8337A;
	Tue, 03 Nov 2026 23:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TSnUKrKO08Kh91aAnhcejusIowFm6XHDQWTTgaiUk/4=;
	b=K2MAPLLtRXzApMvgHkI628yVm0SQd/1zjyhHHiQdwo8F2W30fOzf75YcvNtN/QfCGcgoTt
	v90mqyr03wPoArhiHqbaE/DJWgg69bG701762IO+8Y4RlRRWbmLZ+aDaJB5i97d87NhzsA
	yLskp3I606SCJezZD1IFzavwAuBPGLx/TDhyUMf+YzOUkp5c24vQIi/PAAgaLn3xesELYY
	Ost2AUxZ5Udx87Gn/d16fECjI6eoZfWMH+B0nHE4+6hqBPZdpMLcJMOYde26iaPX3C2Lg2
	z2YzpYGr4CiqIVAc7jg2N23zFilldfxs2sUqYEOQLODCVARKdfHJnPgn5wl0rA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 9YLmeeCFLRSo; Tue,  3 Nov 2026 23:02:35 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:34 +0100 (CET)
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
Subject: [PATCH net v3 00/14] net: pse-pd: assorted lifetime and error-path fixes
Date: Tue,  3 Nov 2026 23:02:03 +0100
Message-ID: <20261103220217.1131971-1-github@szelinsky.de>
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
budget, both listed below. For v3, the whole series and 7 on its own
were tested again. The other patches were found by code inspection and
are build-tested only.

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
 - Setting a power limit changes the budget and the hardware limit
   under two separate locks, so pse_isr() can run in between.
 - On tps23881, pse_controller_unregister() calls disable_irq() after
   devres has already freed the IRQ.
 - A PI waiting for budget can get budget reserved by a power limit
   change; that budget is not freed when the PI is powered later.
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

[1] https://lore.kernel.org/netdev/20261018182005.1193-1-ross@r-sc.ca/
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
 drivers/net/pse-pd/pse_core.c | 300 +++++++++++++++++++++++-----------
 include/linux/pse-pd/pse.h    |   5 +
 3 files changed, 236 insertions(+), 100 deletions(-)


base-commit: 3362cb822ea750399a15b741713181fd8560bd17
-- 
2.43.0

