Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C031E3DDE;
	Tue, 14 Jul 2026 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990227; cv=none; b=P1cYqgynXj0ykxX8xpUfROZ/b0aAq+0ev2+/jeu07hyaLECNjIb9cp0d2FoWQvTi04RNJquf4FJ0GSNsfl4J9Tt9nu+WGV/+hYGolQNW7/ujXMkFloHpQEpJyG8nlENeLMVhXxbR3hiJND0pjeB/t03KU3wGr0iWTqbwSl+43YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990227; c=relaxed/simple;
	bh=DD81WrPj2vT0lKE0CCf09Zk8ZrViL7Ter6k1RK8P+ck=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dCFcHx7Jiq5z9amytZdNqgtLDXKogDlm3duqbakeMGFpLAAi/LzGgoC5JG6PXJKh3re4MS5j4bC/CTlNPCJlsLOXLgDd4fDL7NdxQGmc8h2bVT12v2RMnWUqrIFOwOF3j7iKOCstrlm2kspNUTvOmU3hQMVwKzxAJdTnZ1FAB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wjRLl-000000001qU-2UJo;
	Tue, 14 Jul 2026 00:50:17 +0000
Date: Tue, 14 Jul 2026 01:50:13 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/4] net: dsa: mxl862xx: support firmware update
Message-ID: <cover.1783988826.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The firmware of MxL862xx managed Ethernet switches can be updated
in-system via the same MDIO bus which is also used to manage the
switch. Wire up the devlink flash_update operation for DSA drivers
and implement firmware update and version reporting in the mxl862xx
driver.

Changes since RFC [1]:
 - detect a switch stuck in MCUboot rescue mode at probe, register
   the switch without any ports and report "mcuboot-rescue" as the
   running firmware version, so devlink flash can recover from a
   failed or interrupted update (Andrew Lunn)
 - clarify in the commit message of patch 2 that the per-transaction
   MDIO bus locking is about other, non-switch devices on the same
   MDIO bus (Andrew Lunn)
 - mention in the commit message of patch 3 that closing the ports
   also stops phylib from polling the switch-internal PHYs during
   the transfer (Andrew Lunn)
 - split up run-on sentence and explain the dynamically allocated
   reprobe work item instead of just pointing at iwlwifi in the
   commit message of patch 3 (Manuel Ebner)
 - use kzalloc_obj() (Manuel Ebner)
 - state the actual duration of a complete flash and reprobe cycle
   (just under a minute) in comments and the commit message, and
   clarify that the timeout values are generous upper bounds
   (Manuel Ebner)

[1] https://lore.kernel.org/all/ak0J-HgzMRea53om@makrotopia.org/

Daniel Golle (4):
  net: dsa: wire flash_update devlink callback to drivers
  net: dsa: mxl862xx: add SMDIO clause-22 register access
  net: dsa: mxl862xx: add devlink flash_update and info_get
  net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode

 drivers/net/dsa/mxl862xx/Makefile           |   2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h     |   1 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c      | 439 ++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h      |  18 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c    |  45 ++
 drivers/net/dsa/mxl862xx/mxl862xx-host.h    |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c         |  41 +-
 drivers/net/dsa/mxl862xx/mxl862xx.h         |   9 +
 include/net/dsa.h                           |   3 +
 net/dsa/devlink.c                           |  13 +
 11 files changed, 571 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.h


base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
-- 
2.55.0
