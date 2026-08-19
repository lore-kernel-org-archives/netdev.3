Received: from mta0.migadu.com (out-127.mta0.migadu.com [91.218.175.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC23C0626
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119371; cv=none; b=uKQzH3BBdPzCRAo16kqaDRJgBuetaRmd7t5a8lQaiGOdnFLl2zNOD4JWCe5HkaKtw+CU2w+6w9Jlyewm+fLaO0dZFxJs4UrgZpd16qW9bvC+azgq83HMdGbmYDyjjjbxLCj6N8oeUvA7bKyyeotuy+SOtd6bLVDm7aF1K1ghP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119371; c=relaxed/simple;
	bh=9sv0XkiTA/77jfdX24LDPI2mna+3QbnwiyDj7HkY4V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/SQc1zvB5lu7E3Tm9OdZ2wCORFHTxhmxyqJn10eyzWcAl00UH7xRbUIQSzeh3z9rESzy2FrmTSPWcd2WmDypskdDw8+uf0joKuRnQvQnQtVAYzVz7xYUaqRjiCLsP3nafkE4DJNzQByAMtIfn+7T247BBGHIIwRqP1yiYOTv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R9gR++GU; arc=none smtp.client-ip=91.218.175.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R9gR++GU"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9sv0XkiTA/77jfdX24LDPI2mna+3QbnwiyDj7HkY4V0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787119367; v=1; x=1787724167;
 b=R9gR++GUpHaAal43+fSluQTKae9BDvso3WGc09fP5yr8aB/OXTolQsBDgIpt54bmGZQXVYpJ
 GDu2TSru8zupSpkeoAx57x5h+fkdi7/hjOyMRLvihzfM78SgkEbTFSO/e+pkN9txlpo1ERfxNLK
 hL1ZqhmWyajbuC83gpvvTHkg=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 7166cd49df81669d;
	Wed, 19 Aug 2026 06:02:47 +0000
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v3 0/5] net: phy: fix cleanup after probe failure
Date: Wed, 19 Aug 2026 14:02:31 +0800
Message-ID: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

phy_probe() initializes the PHY driver, ports, SFP upstream, and LEDs in
stages. Its error paths do not always release only the resources acquired
at each stage. It can also mark the PHY ready before all setup succeeds.

Port setup also leaves SFP cleanup split between phy_sfp_probe(),
phy_setup_ports(), and phy_probe(), and default port setup ignores errors
from attaching the port to the PHY driver.

This series makes each initialization layer own its cleanup and propagates
setup failures to the caller.

Patch 1 splits the phy_probe() cleanup by initialization stage.

Patch 2 makes SFP and port setup unwind their resources in the required
order.

Patch 3 sets PHY_READY only after LED setup succeeds.

Patch 4 calls the PHY driver remove callback after later probe failures.

Patch 5 propagates errors from default port setup.

---
Changes:
v3:
  Patch 1:
  - Rename cleanup labels to include verbs describing their actions.
    (Jakub Kicinski.)

  Patch 3:
  - Do not clear phydev->drv before device-core teardown completes; this
    can expose NULL dereferences in concurrent attach paths and devres
    callbacks. Set PHY_READY only after LED setup succeeds and update the
    Fixes tag. (Sashiko, Jakub Kicinski.)

v2: https://lore.kernel.org/all/20260813132946.116176-1-xuanqiang.luo@linux.dev/
  Patch 1:
  - Limit this patch to splitting phy_probe() error paths, moving the SFP
    teardown fixes to Patch 2.

  Patch 2 (new):
  - makes SFP and port setup unwind their resources in the required order.
  - Add phy_sfp_release() for complete SFP teardown instead of open-coding
    sfp_bus_del_upstream(). (Andrew Lunn, Maxime Chevallier.)

  Patch 3 (new):
  - Restore PHY_DOWN and clear phydev->drv after probe failure.

  Patch 4:
  - Move the former Patch 2 to Patch 4; no functional changes.

  Patch 5 (new):
  - Propagate errors from default port setup.

v1: https://lore.kernel.org/all/20260812125127.106255-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (5):
  net: phy: split phy_probe() error paths
  net: phy: unregister SFP upstream before port cleanup
  net: phy: set PHY_READY after LED setup
  net: phy: call driver remove when core initialization fails
  net: phy: propagate errors from default port setup

 drivers/net/phy/phy_device.c | 80 ++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 22 deletions(-)


base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
-- 
2.43.0
