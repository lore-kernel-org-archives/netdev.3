Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348283002AB
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086521; cv=none; b=ohI+lOzm1aWqP2sNjDUvmuTQn8kHnSk/XWPetBfD+AjqehRPHYsd7y9qQscIKpRQYEDpFjFKah6NCfeBfDVG3CpCvkmx27vvtppoMSu4+lJzobQTAYWho+43D/JgMLVzzAuWHSwa/QX/ugXYA3YIeFDAbYGCFF2lklUcYmgEzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086521; c=relaxed/simple;
	bh=8gAlYhC2dwanWBpp/5WKz2s75CeAM292I5VMCQtesSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jadwcdxOZtQOXw++Yb8uedxnF5l6SRI8/9gzCzW10Up/LJURncC5t88TOpTQO/DPVXfZidnkn7DElJ/ZSVR5rf7pOdGD3sXzWxZqBdGB+oPTKj8THNbjtsVaHOf70RalRU5QCY+9xdCKyohxhwyrqdLjNQffiCIIXR4zq9xAJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UTMYjAjw; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UTMYjAjw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786086516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MZyQ4QEBmOXDqmAox0sRMRajo36BvQIQK41E6FawOcw=;
	b=UTMYjAjwId24zrvdlKGGoYns/UVJar8NsAMy6DJOhvoq5SIotCiRLwx79YPAPbyG9VTlFB
	afyOXlBEv79JVaUFLdO0ke2mRVdhYMdqrU+wZzKp/zcL5K2IxcQa9uvoRdaaErFQvWsZ2I
	8/mDCWG/nXuFudwss+WOs8RlPgC3WQ4=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	kuba@kernel.org,
	richardcochran@gmail.com,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	luoxuanqiang@kylinos.cn,
	Xuanqiang Luo <xuanqiang.luo@linux.dev>
Subject: [PATCH net v4 0/4] net: phy: dp83640: fix shared clock lifetime and probe error cleanup
Date: Fri,  7 Aug 2026 15:07:25 +0800
Message-ID: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
v4:
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

 drivers/net/phy/dp83640.c     | 191 +++++++++++++---------------------
 drivers/net/phy/phy_package.c |  23 ++++
 drivers/net/phy/phylib.h      |   2 +
 drivers/ptp/Kconfig           |   1 +
 4 files changed, 98 insertions(+), 119 deletions(-)

-- 
2.43.0
