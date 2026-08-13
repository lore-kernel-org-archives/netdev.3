Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA06F3328FD;
	Thu, 13 Aug 2026 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651647; cv=none; b=SVkExE3Sg80xiIbqk4W8KqLr2bQUFnqkmCNAriRGyPHrq0RDWrtD/xzwOIh5aZ5Fgv4wgatGunkIsPyHAN/LgCd5GP5hepJPBdFoESyFYuAy7p/aj6owiDHX/TfAlO+fWa4+sg+OjERvrb6U7TU86gnJF1wDpduKkz6lbTMPv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651647; c=relaxed/simple;
	bh=D+7WjoXw3nWlUT3wg/Y6/L76Qfh7JIpnEAzHqoHCkWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRdbQeungH9qMwoM7F6vfCQ5Hp/YetTwfSith3GHxgI0Tnpdvbm3v9GIsxjb1Ruok1swMgjWxRitTaIP5Sjvdq+ZuTpvrtpwLbCcjooUoxVE47+EiV/HczGnphpxgiJvNG6LhkvvXarMqsEYzJ+/TZGHM7knjkATJWUJZuUuQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Ecyw3h5L; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Ecyw3h5L"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id DA02CE838AA;
	Thu, 13 Aug 2026 22:07:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1786651635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=huGvAko+PD9Qtccss5R0hZmEGHcE8fsgK1wmoH3PFys=;
	b=Ecyw3h5LX0mO3PLJDBCr5WUfal8T2QGaWlBxP0iwqW6BYCs2Am5VDmSPWuIGZTbuVJz734
	0tN3cEXy8JOSjmBxKoT5YdoPWrgzVhzPKJUEWxEbU33F3EyWRD6P6R3apFD6Xaws68PQjw
	aZFpMl1aITMbv6qXSgcwQGZqitJmmxW5Y/DSyxoY1NWy8QHSw4SvBUV65ileTpkmnz2lDL
	G2sAwbAQaoLnG0NBTAwcMnMcqwJzpcdiHDf/5tmkTy2q/BUspHr2Fs0vtlzq7lxlKJosUN
	5PBzsvdtd8GzgGQtlzBfMeATn6VEn9J4jdvnYszmPc3MO/54euLMStNZvztEsA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id HK_7TlWVfjka; Thu, 13 Aug 2026 22:07:15 +0200 (CEST)
Received: from p14sgen5.. (163.6.106.80.static.otenet.gr [80.106.6.163])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 13 Aug 2026 22:07:14 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v3 0/3] net: pse-pd: fix use-after-free of PI array on controller unregister
Date: Thu, 13 Aug 2026 23:06:50 +0300
Message-ID: <20260813200653.980170-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes use-after-free bugs in the PSE core teardown path.
When a PSE controller is unregistered, pse_controller_unregister() frees
the PI array (pcdev->pi) and the power domain supplies while other paths
can still reach them.

To make it clear what the series covers, here is every path that
dereferences pcdev->pi and how each one is made safe:

- The regulator ops pse_pi_enable/disable/is_enabled(). Reached from the
  regulator core and from regulator sysfs (is_enabled() via the "state"
  attribute). The PI regulators are registered before the controller, so
  on unbind the controller is torn down first and pse_release_pis() frees
  pcdev->pi while the regulators are still live. Patch 2 checks
  !pcdev->pi in the three ops and does the free under pcdev->lock.

- of_pse_match_pi(), from of_pse_control_get(). A consumer probing at the
  same time walks pse_controller_list and reads pcdev->pi[i].np. Today
  the PI array is freed before list_del(), so the controller is still on
  the list with pi gone. Patch 3 moves list_del() ahead of the free;
  both run under pse_list_mutex, so a lookup sees either a live pi or no
  controller at all, with no NULL checks on the lookup path.

- pse_ethtool_get_status() and __pse_control_release(), from a consumer
  still holding a pse_control. These read pcdev->pi[psec->id] too, but
  the real issue is that the consumer can outlive the whole controller:
  of_pse_control_get() only takes a module reference, no device link, so
  a NULL check would not help. This is pre-existing and not a net fix.
  It is handled in net-next by the PSE controller notifier series [1],
  where the phy layer drops phydev->psec on unregister before pi is
  freed. phy is the only pse_control consumer in tree.

Patch 1 reorders teardown so the IRQ and the notification worker are
stopped before the power domains and the PI array are freed.

All of these are pre-existing teardown races, so there is no easy way to
trigger them on purpose and no simple reproducer. The fixes are based on
code review. They are compile tested and checkpatch clean.

[1] https://lore.kernel.org/netdev/20260630091125.3162481-1-github@szelinsky.de/

v1: https://lore.kernel.org/all/20260524223306.2570676-1-github@szelinsky.de/
v2: https://lore.kernel.org/all/20260711121611.1639086-1-github@szelinsky.de/

Changes in v3:
- New patch 3: unlink the controller from pse_controller_list before
  freeing the PI array, closing the of_pse_control_get() /
  of_pse_match_pi() race.
- Cover letter now maps every pcdev->pi entry point, following the review
  discussion with Kory and Jakub.
- Added Kory Maincent's Reviewed-by to patches 1 and 2.
- Rebased on net/main.

Changes in v2:
- Patch 1: also stop the IRQ before pse_flush_pw_ds(), and cancel the
  notification worker before pse_release_pis(). v1 only moved
  disable_irq() ahead of pse_release_pis(). Also fix the commit message,
  which wrongly said the worker does not touch pcdev->pi.
- Patch 2: take pcdev->lock around the kfree() and the pcdev->pi = NULL
  store, so a reader sees an authoritative NULL. Add the same NULL guard
  to pse_pi_enable() and pse_pi_is_enabled(), not just pse_pi_disable().
- Thanks to Simon Horman for the review.

Carlo Szelinsky (3):
  net: pse-pd: stop async event sources before freeing PI data in
    unregister
  net: pse-pd: guard regulator ops against freed PI data during
    unregister
  net: pse-pd: unregister from the controller list before freeing PI
    data

 drivers/net/pse-pd/pse_core.c | 41 ++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)


base-commit: 3aa1dcaa4f6f5ae08936491e08bd456f331f2d40
-- 
2.43.0

