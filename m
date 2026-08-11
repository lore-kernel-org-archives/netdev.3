Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99953A383C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461354; cv=none; b=BKI/Gsi5tjF8okRb8PjzCtr1vj59q7kalCkojiLuJ63VhbPF75dJLip+Vix8EEMrJkGbtEdngOy/3ool8Slv0K+mgWqQ8HqwEwmUz1/3m1PqxnqaQBPsaPyOX3BsRe3w3M+fy1yYpAVIPKpqbMHx00pE/n1+nOL7ajwKLpOfYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461354; c=relaxed/simple;
	bh=fxRMRAK4IBpsAVOxaRXejM27KUifdStAsC0bJ8QRIwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pK6PZ9WYFhGm9suCce6dxrOaHYBVUag4ynsC30IOkPyUx2Pmnrjyy6hnVUIi3X/KjETTaQ7djCxARgphzgXugZ4ps8XfBY7Z0EnuKRqCZoMXefIHweEBHlrHc622LvuhUa9Zp4d9fo4YknmVWa3+bEzcXHAgYgDr4hvE+TbseWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=egkc+g3z; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="egkc+g3z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786461349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7kcpdHYfxtR+9B3meSOf/Uom6EfKgyCH+FVbrO6G2PM=;
	b=egkc+g3zg1q9ZYH1QqMM709W7kptSC/fw7ygzcg7UYf1hxIVA1kBlEtPd/NAwjKU7MUupu
	nOX2QlSknsDv+0uYja+KgTJ6FO6lYqSoa/SpQNy4qJwg7XjKOwrEjzYY7QiHuf+1VcDJV6
	1lCOkakiTyoSrQPpgiV1DoprdRbvToU=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
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
	luoxuanqiang@kylinos.cn
Subject: [PATCH net v6 0/4] net: phy: dp83640: fix shared clock lifetime and probe error cleanup
Date: Tue, 11 Aug 2026 23:13:41 +0800
Message-ID: <20260811151345.73582-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

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
v6:
  Patch 4:
  - Correct the author and Signed-off-by email address.
  - Add Reviewed-by tag. (Andrew Lunn.)

v5: https://lore.kernel.org/all/20260810141511.73204-1-xuanqiang.luo@linux.dev/
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
