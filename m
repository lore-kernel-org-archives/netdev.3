Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516385;
	b=cSLeDkkb1dRgZ+Pn2yK4tJQ9t4sm3eZ/ZHOFqB5dPgGABaV/HQwr2PCc8TL/Dtm8T+QR
	 vipsq864p33u73NRbQEfGN61uoj4WmG53eBcjLGMHE4eUl3sVAm4HYONgqjEwbYW7d3xe
	 ehsP0MSF4fJS0J4ZHy6rapkYAdNc3ry611rCL7xy2+WH+HiLgZ07uKht7Vh1oxF44Oe6I
	 vJRBUu1GB+C+EoOS/J4Wkj+M/esVyZjW/Qiiu3x+m+xPn+M4NEWK+O1W+EqD1X9W/fpql
	 wWXV3W//28kkGw5mF4m507C7KB/GcTGoPYcaCmWhGdddWxNHFvnrYy1gW9yqtB0YMEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oBlMAadRLUihtW59ZoPkptlPcJhMJqEim38GOPkSX2A=;
	b=kD1X8UJqtPqreB57z0hgq469OisBd/nV2ZvbVioSvaZgA1xT04Sx9nkMkLzs9aFZ1RqO
	 ns0+Gi3ICXCLXA8s4Ouwgxdlj7rNpYHmrwCNjCKz8Rfr4kHGMpZ0f9aBJHpgFC8pGnesO
	 jPMGPhMNC/mtukn9xcN/MyXpmUc4dnUDIuvfBbY0onl1rZgZLpiKTyrbxqvgoAdJJu6ml
	 7p0BZnqjuw8Qc7apfs8myS9024apBdCZNOfnwJaju0BXvrLcmt3rWVZIKIZTzTZHVUbHY
	 /BNJBSLaxpQH7aAUpteUckB7qcuyiUoVCNs3rNgUNC614xd+c0jmusGuTVF9BuzBl9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=BgrZ+xZs;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA7606A320;
	Tue, 20 Oct 2026 17:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1CA7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=BgrZ+xZs
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 77732E83125;
	Tue, 20 Oct 2026 19:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oBlMAadRLUihtW59ZoPkptlPcJhMJqEim38GOPkSX2A=;
	b=BgrZ+xZsdrEdEIduCO7WLCSFsxZy+qyVrLP4pfOQBqVjyDqt1CAjipOmgmNbBScgvlpwF+
	KqvPXIPMvYrG8qZA0l0Y/NzWHlOZNoNQ+8/bzKuMHBysypPg6tGYRoK/veSxUt2RkKeXHY
	otlHj6XsRKA/3yVValGDhdZ4w25lM0PpU4Ssmak1VJ5TD8t02+3QTKy0nirGx17TTDbc/Q
	ek6ZnyXTQL3GTPbLsQcby9XFulpN7jVG3tSodQ0m5lGt48q5ZQc6ShjRVnLG/YqE6XPAHp
	HrdO98p/LpvVWIvBBkF1fR7FHXvShUetOeLFj24wjB7xfa0AP4Jt6SK3IDfq7A==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id ijWMu-yI5k8p; Tue, 20 Oct 2026 19:13:02 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:02 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v2 00/14] net: pse-pd: assorted lifetime and error-path fixes
Date: Tue, 20 Oct 2026 19:12:35 +0200
Message-ID: <20261020171249.853085-1-github@szelinsky.de>
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
    created it unbinds.
 8  Unregister frees the PI array before it stops the IRQ handler. No
    in-tree driver hits this; 10 to 12 build on the new order.
 9  Unregister frees the PI array while a lookup can still find the
    controller.
 10 The PI regulators outlive the PI array, the PSE core can still
    power a PI while the controller goes away, and a powered PI keeps
    its budget.
 11 A failed registration leaks the kfifo and leaves power domains with
    a stale supply handle.
 12 A shared power domain's supply handle goes stale when the controller
    that created it unbinds.
 13 pd692x0 leaks its manager power budget when probe fails.
 14 pd692x0 crashes on a manager supply that is not resolved yet.

Some patches need earlier ones: 7 needs the locked check from 6, 10 to
12 build on 7 to 9, and 14 relies on 13 to give back a budget that was
already reserved.

Testing: every patch builds on its own with W=1 and is checkpatch
clean. 1, 5, 7, 10, 11 and 12 were tested in QEMU (arm64, KASAN,
lockdep, kmemleak) with test-only fake PSE controllers: without the
patch, the failure in its commit message shows up; with the whole
series, the tests are clean, except for the older lockdep report
below. The other patches were found by code inspection and are
build-tested only.

Ross Cawston's "net: pse-pd: don't enable a PI again while disabling
it" [3] applies on top of this series without conflicts. The tests also
hit two older bugs that this series does not fix:
 - With the static strategy, turning off a PI to make room for a
   waiting one retries the waiting PI from inside its own allocation,
   which recurses until the kernel stack overflows. [3] removes that
   retry.
 - pse_isr(), setting a power limit and unregister hold pcdev->lock
   and then take the supply's regulator lock, while regulator_enable()
   on a PI takes them the other way round. Lockdep reports it when the
   supply lock is contended.

Older problems that reviews of this series found, not fixed here:
 - A pse_control held by a PHY can outlive its controller. The PSE
   notifier series for net-next fixes this.
 - Setting a power limit changes the budget and the hardware limit
   under two separate locks, so pse_isr() can run in between.
 - On tps23881, pse_controller_unregister() calls disable_irq() after
   devres has already freed the IRQ.
 - A PI waiting for budget can get budget reserved by a power limit
   change; that budget is not freed when the PI is powered later.
 - The PI regulators are visible before their power domain is set. A
   PI enabled in that short time skips the budget check.

Changes in v2:
 - 2 is new; 3 now only fixes the remaining error path (Kory).
 - 5: the worker comment says why a shared PI is safe (Sashiko).
 - 6: kernel-doc of the return value fixed (Sashiko, Kory).
 - 8: the message no longer claims bugs that 5 and 7 made impossible
   or that no in-tree driver can hit; Fixes: tag dropped.
 - 8 and 9 are patches 1 and 3 of [1]. 9 now takes the controller off
   the list before the worker drain and the power domain flush, as [2]
   1/4 did. Patch 2 of [1] is replaced by 10, which keeps the PI array
   until the PI regulators are gone, lets the core power no PI after
   unregister starts, and switches off the PIs that hold budget.
 - 11 is patch 2 of the PSE core fixes for net-next [2], moved here.
 - 12 is new; v1 listed this bug as not fixed. The domain no longer
   has a supply handle of its own; each PI uses its regulator's handle.
 - The si3474 patch and the power limit overflow fix move to net-next.
 - Collected Reviewed-by tags; each patch says if it was triggered.
 - v1: https://lore.kernel.org/netdev/20261018082314.48950-1-github@szelinsky.de/

[1] https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/
[2] https://lore.kernel.org/netdev/20261018081853.47484-1-github@szelinsky.de/
[3] https://lore.kernel.org/netdev/20261018182005.1193-1-ross@r-sc.ca/

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
  net: pse-pd: unwind allocations when controller registration fails
  net: pse-pd: use each PI's own supply handle for the power budget
  net: pse-pd: pd692x0: release the manager power budget through devres
  net: pse-pd: pd692x0: defer probe while a manager supply is unresolved

 drivers/net/pse-pd/pd692x0.c  |  31 +++-
 drivers/net/pse-pd/pse_core.c | 319 ++++++++++++++++++++++++----------
 include/linux/pse-pd/pse.h    |   5 +
 3 files changed, 255 insertions(+), 100 deletions(-)


base-commit: 78731b46967e3e7102b5cd5062bef185f3404b5c
-- 
2.43.0

