Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B03839B3;
	Sun, 18 Oct 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311809; cv=none; b=nPj/yr0Mv4OAaXpbL7uMWAEMrGXURPe6gN+nRl/IT6Icw+r18RnnYra0XGKMPJ85LNcZZnEOSw6CPOBiofusbhwT3qYolthA6PIpI2hvtenpC77NT4nuTxJfYbnwVvhhrNmhGT74BYdqTmbD00bt8iX8NUlmjUMXhdaU+rM8smQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311809; c=relaxed/simple;
	bh=8KiEpJD7IgoNfI5gv+FAL9bV/Doesl071WSblsCBU/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOTZTOZB24Zfu+kJuE3ifqvL0EVh2pAfxcyrHmeCaK85qDypOTjPIKwFqhUtg6xw12PxEEa9n7PsK/UaFbRvoajE5/66Z3ANMqS4PmKwWc+BwJdE4mhAp/kPkCO0n1oaJOaRj54QFTYkQlQNGItLKcRcb34JgwpDteD3fmOaWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Y016lIQ7; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Y016lIQ7"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id D02A4E837CF;
	Sun, 18 Oct 2026 10:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cGo4EOml9t5mWRjRP47u5O+MkLpMXnwlmyIIpKmbAsY=;
	b=Y016lIQ7NoC5cGf2RtFATTwLW3qr+3l0paqH+FEjXCQB0NVHTfzKF9wqNDqxBHVm7SCIO2
	WQ141VNsv+SJefpDcYgvL/z1M+lzqvIkRoN0XKp+AtD9jiffy2DPfo68Fzv6mDd/WGCCQv
	FK1BUWm7wxvdUrmlIMJRd5oRW4TohXt2Rn/4W46YG4q4HCcKpJNGL7SDOWbnFrxUeukfZq
	XWNmqizTpPur7QnIuTDQPdAhvGAmbaF6HXSEmXxGGnn+iVZSVMCI0RnBqRkxb4Gc/fdQlY
	jJYOCv6rjdIhYo2TmXd/lAxzx3aWKWN5wuAsQl66A58f1tXslGdj7BcKukMKVA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 6EzpaMSJKRU2; Sun, 18 Oct 2026 10:23:24 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:23:24 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net 00/10] net: pse-pd: assorted lifetime and error-path fixes
Date: Sun, 18 Oct 2026 10:23:03 +0200
Message-ID: <20261018082314.48950-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes for the PSE core and two of its drivers, found while working on
the PSE controller teardown. Two patches depend on the one before them:
6 is only safe with the locked check from 5, and 8 relies on 7 to give
back a budget that was already reserved.

 1  The kfifo is too small: podl-pse-regulator and any controller with
    0 or 1 lines cannot register.
 2  A module reference leaks when reading the port state fails.
 3  A failed IRQ request stays in pcdev->irq, so unregister disables a
    line another device may own.
 4  The notification worker can read a PHY that was already freed.
 5  Setting a power limit checks the PI state without the lock.
 6  A power domain shared by two controllers is freed when the one that
    created it unbinds.
 7  pd692x0 leaks its manager power budget when probe fails.
 8  pd692x0 crashes on a manager supply that is not resolved yet.
 9  si3474 logs through an I2C client it has already unregistered.
 10 A low voltage reading overflows the current for a power limit and
    hits a BUG_ON().

Testing: every patch builds on its own with W=1 and is checkpatch
clean. 1, 4 and 6 were tested in QEMU (arm64, KASAN, lockdep, kmemleak)
with a test-only fake PSE controller: net/main shows the kfifo failure
and use-after-free reports, the series is clean. The other patches are
build-tested only. Together with the PSE core fixes and the decouple
series, the series also runs on a Hasivo S600WP (hs104), including
setting power limits.

Pending work:
 - "net: pse-pd: fix use-after-free of PI array on controller
   unregister" [1] applies with this series in either order.
 - The PSE core fixes for net-next [2] conflict with 5 and 6; the note
   in their patch 2 explains how to merge them.

Not fixed here: a shared power domain's supply handle belongs to the PI
regulator of the controller that created it, so it goes stale when
that controller unbinds. That is older than this series.

[1] https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/
[2] https://lore.kernel.org/netdev/20261018081853.47484-1-github@szelinsky.de/

Carlo Szelinsky (10):
  net: pse-pd: size the notification kfifo after defaulting nr_lines
  net: pse-pd: fix module refcount leak in pse_control_get_internal()
  net: pse-pd: do not keep a failed IRQ in pcdev->irq
  net: pse-pd: do not reach a freed PHY from the notification worker
  net: pse-pd: check the PI state under the lock when setting a power
    limit
  net: pse-pd: do not tie a shared power domain to its creator's devres
  net: pse-pd: pd692x0: release the manager power budget through devres
  net: pse-pd: pd692x0: defer probe while a manager supply is unresolved
  net: pse-pd: si3474: fix use-after-free in ancillary client error path
  net: pse-pd: reject a power limit whose current does not fit an int

 drivers/net/pse-pd/pd692x0.c  |  31 ++++--
 drivers/net/pse-pd/pse_core.c | 171 +++++++++++++++++++++++-----------
 drivers/net/pse-pd/si3474.c   |   4 +-
 3 files changed, 140 insertions(+), 66 deletions(-)


base-commit: aaaaf87ea99b8766c9a8aa0e71aa42e6bc8a5320
-- 
2.43.0

