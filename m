Received: from mta1.migadu.com (out-236.mta1.migadu.com [95.215.58.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20032B111
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371341; cv=none; b=EcOGtLXUYu6odY2IgFZWGZlTTAUNckycaZVxCp6gBjwVIKfFVcP/lS9/KjmImoUegx7Z8rosAZZVmRmhCUe1zRVUQyx+SuEpqHRGeadhdWxmaHLGHiPhVg4Tevsw3/n/MZNdH1E633x8r/ANMSC/DPghiWkmO/3l6pIAyb0ZwV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371341; c=relaxed/simple;
	bh=cwdws7dQB5UT2+8IkuCqQuSUtAVNDKWPhooGtxCAy1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohvvl2XZywFwGpbhn3GhbZ+NhBeQTXgroEYdN4MzdxstcWp3xwMyT1/BkK7nV9lCKaQjjuGccICHBCF901ITv6PBOAcTJR7qXtdOl833pWIAbkDiEsQlT1ONIyg9lKvqeK9kLDQzNWqd12EJWVQQ+xelfUfgM1I9LvPXBiG7auk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o5HEdddM; arc=none smtp.client-ip=95.215.58.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o5HEdddM"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cwdws7dQB5UT2+8IkuCqQuSUtAVNDKWPhooGtxCAy1E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786371335; v=1; x=1786976135;
 b=o5HEdddMRj524MF2bF2H9QT1EBbLNAruymrBINu7MfeKiOxlG2dgIR/Lk3eJJFpT39NAxSVh
 Cw1WoGv3ba27+cNdOX1YTEJRCWocyCaLN6TAcZTMws+B4WeTBlSFXvsCnliwh6b7AqU4hE8ZSzP
 PCciIJx9t4CG3VNJvd0ihZb8=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by mta10.migadu.com with ESMTPS id c75130e72eb424e2;
	Mon, 10 Aug 2026 14:15:35 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org,
	andrew@lunn.ch
Cc: kuba@kernel.org,
	richardcochran@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	luoxuanqiang@kylinos.cn,
	Xuanqiang Luo <xuanqiang.luo@linux.dev>
Subject: [PATCH net v5 0/4] net: phy: dp83640: fix shared clock lifetime and probe error cleanup
Date: Mon, 10 Aug 2026 22:15:07 +0800
Message-ID: <20260810141511.73204-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <xuanqiang.luo@linux.dev>

The DP83640 driver shares one PTP clock between all PHYs on the same MII
bus.

Its driver-local clock lookup and removal scheme can leak the shared clock
on probe failure or free it while another probe is acquiring it.

This series moves the shared clock to the PHY package infrastructure.

Patch 1 adds PHY package locking helpers.

Patch 2 embeds the pin configuration in the shared clock.

Patch 3 clears per-PHY state when PTP clock registration fails.

Patch 4 fixes the shared clock lifetime using the PHY package
infrastructure.

---
Changes:
v5:
  Patch 1 ~ 3:
  - Add Reviewed-by tags. (Andrew Lunn.)

  Patch 4:
  - Replace devm_phy_package_join() with explicit phy_package_join() and
    phy_package_leave(). (Andrew Lunn.)

v4: https://lore.kernel.org/all/20260807070729.12545-1-xuanqiang.luo@linux.dev/
  Patch 1 (new):
  - Add PHY package locking helpers for shared package data.
    (Andrew Lunn.)

  Patch 2 (new):
  - Split the pin configuration storage change into a separate patch and
    clarify that the pin functions remain configurable at runtime.
    (Andrew Lunn.)
  - Clarify the locking comments for pin_config. (Sashiko.)

  Patch 3 (new):
  - Split the PTP registration failure cleanup into a separate patch.

  Patch 4:
  - Use the PHY package locking helpers instead of accessing the MII bus
    shared lock directly. (Andrew Lunn.)
  - Adapt the lifetime fix to the preparatory changes split into separate
    patches. (Andrew Lunn.)

v3: https://lore.kernel.org/all/20260805072725.169431-1-xuanqiang.luo@linux.dev/
  - Drop the Suggested-by tag. (Jakub Kicinski.)
  - Set err to -ENOMEM on the kzalloc_obj() failure path. (Sashiko.)
  - Let devres handle cleanup on driver detach instead of explicitly
    releasing the action from .remove(). (Jakub Kicinski.)

v2: https://lore.kernel.org/all/20260730064451.32261-1-xuanqiang.luo@linux.dev/
  - Replace the driver-local clock list and kref with the PHY package API.
    (Jakub Kicinski.)
  - Use devres to avoid leaking the new package reference on later PHY core
    initialization failures.
  - Embed the pin configuration in the package private data to simplify
    lifetime management.

v1: https://lore.kernel.org/all/20260724023532.14583-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (4):
  net: phy: add PHY package locking helpers
  net: phy: dp83640: embed pin configuration in clock
  net: phy: dp83640: clear state after PTP registration failure
  net: phy: dp83640: fix per-bus clock lifetime

 drivers/net/phy/dp83640.c     | 131 +++++++++-------------------------
 drivers/net/phy/phy_package.c |  23 ++++++
 drivers/net/phy/phylib.h      |   2 +
 drivers/ptp/Kconfig           |   1 +
 4 files changed, 61 insertions(+), 96 deletions(-)

-- 
2.43.0
