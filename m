Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD02D7D3A;
	Sun, 18 Oct 2026 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311559; cv=none; b=TV7+fMbY2Wq7aKhZsKCk6op1CEtqVNCwgsf5S29UUR+PNuKt7LrmxRnNhsZomin3I4uxmrHnWUwZl5N5A9eVYeFC3UlcB0gpco3pFqqryqWnI1wnT2aCXx4sfQnbX+RaL6QDs/5NQn0ukXWhZj5uFXSPJMXArLo7tp7kUhG1IjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311559; c=relaxed/simple;
	bh=AcTJDpBORWj5VtW4qCVsH2NiGHRLll8OJRfHyNmGvUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceZbmci2bT0qSD7UhAi5vf8ukB3BLbjBBJqSGcbagMbniV3nZvAx+PuaEnpP9DgEQLQF3462pStqwHcyJCFEQqaj3jPD/uyOuwOH/0H9YeNrARDOrT7T7/qfSkTYJmSGi3mu0FyRamB7PzGrKkwaiJnDqIqJ9I7HVR7Vbt4xMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=A2ExJJ4H; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="A2ExJJ4H"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 96891E837CF;
	Sun, 18 Oct 2026 10:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oSa85OIU8s8xC52cWOnXHEuigvzsLY2qbqfV+53tJes=;
	b=A2ExJJ4HeJbb/lkJ7HmXxSLFiALmn0DM4jOUEKhjL6NcdIqYM+4+oGiMFmD3zj6Cposjqa
	OxGyF6N33CfmQ+eAfWN3Q3jK2gCD/XrNjiJ8yN5J0rSUFWnnH3CQmZ2h2ZF0JseLPxhfNA
	edbJbv2cKp8003xKu4up7DxuxWE/ScZbSF/SovJsGBZPsoy0iMG2H3uClpOzoLIF35HHDy
	/Y94/G6pkzz+tTPer6zZzWYxJiIbv4SiJ2+f6k27yzPZlqZGMbAfhgeySk1Il25Noj1jzj
	KwUMxcqj+dThMonnmOMmKaTie7iRic1JVgPkB7/g3C+zuHduP9fKA58biRcjAw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 7cACpadZ9Dux; Sun, 18 Oct 2026 10:19:13 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:19:12 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Corey Leavitt <corey@leavitt.info>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Simon Horman <horms@kernel.org>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next 0/4] net: pse-pd: core fixes ahead of the controller notifier
Date: Sun, 18 Oct 2026 10:18:49 +0200
Message-ID: <20261018081853.47484-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These four PSE core fixes were part of the "decouple controller lookup
from MDIO probe" series [1]; Oleksij asked to split them out. They do
not need phylib, and each one fixes a problem on its own:

 1. Unregister frees the PI data while the controller can still be
    found. Take it off the list and stop the IRQ and the worker first.
 2. A failed registration leaks memory, and can leave freed power
    domains in the global map. Clean up on the error paths.
 3. si3474: use dev_err_probe(), so the deferral from 4 is not logged
    as an error.
 4. Defer the PSE driver's probe until every PI's vpwr supply is there.

Patch 1 conflicts with the pending net series [2]; keep the order from
patch 1. Patch 2 conflicts with two of the net fixes posted alongside
[3]; the note below its --- explains how to merge them.

Tested in QEMU on arm64 with KASAN, lockdep and kmemleak: controllers
whose supply never appears defer, and an injected pse_register_pw_ds()
failure is cleaned up and retried. The only KASAN reports are the known
stale-handle bug at MDIO bus unbind, the same without this series; the
decouple series fixes it. This series, the decouple series and the net
fixes together also run on a Hasivo S600WP (hs104), with 200 controller
unbind/bind cycles and no warnings or leaks. Every patch builds with
W=1, and PHYLIB=m, PHYLIB=n and PSE_CONTROLLER=n link.

[1] https://lore.kernel.org/netdev/20261004164219.1161294-1-github@szelinsky.de/
[2] https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/
[3] "net: pse-pd: assorted lifetime and error-path fixes", for net

Carlo Szelinsky (4):
  net: pse-pd: unlink the controller before freeing its PI data
  net: pse-pd: unwind allocations when controller registration fails
  net: pse-pd: si3474: use dev_err_probe() for controller registration
  net: pse-pd: check the PI vpwr supply before registering the
    controller

 drivers/net/pse-pd/pse_core.c | 175 ++++++++++++++++++++++++++++++----
 drivers/net/pse-pd/si3474.c   |   7 +-
 2 files changed, 158 insertions(+), 24 deletions(-)


base-commit: 98c2ad4f5d805dbc1ea436a334ee59311806a48c
-- 
2.43.0

