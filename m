Received: from mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8C3769EC
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295835; cv=none; b=Z2k/4fzcNj+LfsEpMp5YTB0p4ia23RgCafWPmw2ACZ8FAGv7Spg/8je5OBgK8jBJKwC7FBJRgZUgmodhITSsolLjv8tcbntWlyM6/Qs3Fqf0Mu8do8085vzmjaCAdkVzowGYJsMrPXc6XwCv/7663xmsNTrSbTxlOA6QO7DOKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295835; c=relaxed/simple;
	bh=69Rq3UqkPTx28gQob0ppT8X0M3AuM5LoVS+3QbuPNB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+WhMEpevRdCbur5Fg4Qad+xi7PgX3jRY0NSWB72kGNf/CmxksrVE3pPec72shwkwUkQx03uHCeym7krPmmiCtH14kqA3hVGww8/dI+5+cxCAqnQSqKMZp6tdoluV4By+0aZAimCE5wUqYSPzqSI8Qzyg/cTOtKMNdsW0BgOV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fSt8CwaH; arc=none smtp.client-ip=95.215.58.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fSt8CwaH"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=69Rq3UqkPTx28gQob0ppT8X0M3AuM5LoVS+3QbuPNB4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787295830; v=1; x=1787900630;
 b=fSt8CwaHyPRRKNxk84eassg6asaO3ERob+gOXowL7glgdt4ZkcODp4osZPkwzWRMNnSfjwwb
 OOprduZC39020vSVQLw8NlnuGx+Mtma5qn/A+siyC+y16D+BVq5EBDgHfdnNkiJrHLupJn2MuZ8
 Syw3MH492LhG2vxHqLGRu4vQ=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id ae2f571670914545;
	Fri, 21 Aug 2026 07:03:50 +0000
X-Mizu-Trace-ID: ae2f571670914545
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org
Cc: hkallweit1@gmail.com,
	qingfang.deng@siflower.com.cn,
	hao.guan@siflower.com.cn,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v4 0/6] net: phy: fix cleanup after probe failure
Date: Fri, 21 Aug 2026 15:03:21 +0800
Message-ID: <20260821070327.16147-1-xuanqiang.luo@linux.dev>
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

Patch 6 prevents a double-free after partial LED trigger registration.

---
Changes:
v4:
  Patch 1:
  - Explain that LED triggers are initialized after the SFP upstream and
    ports, so they must be unwound first. (Andrew Lunn.)

  Patch 2-5:
  - Add Reviewed-by: Andrew Lunn <andrew@lunn.ch>.

  Patch 6 (new):
  - Prevent a double-free after partial LED trigger registration and make
    the cleanup ownership explicit. (Sashiko.)

v3: https://lore.kernel.org/all/20260819060236.24665-1-xuanqiang.luo@linux.dev/
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

Xuanqiang Luo (6):
  net: phy: split phy_probe() error paths
  net: phy: unregister SFP upstream before port cleanup
  net: phy: set PHY_READY after LED setup
  net: phy: call driver remove when core initialization fails
  net: phy: propagate errors from default port setup
  net: phy: avoid double-free after LED trigger registration failure

 drivers/net/phy/phy_device.c       | 80 ++++++++++++++++++++++--------
 drivers/net/phy/phy_led_triggers.c | 11 ++--
 2 files changed, 65 insertions(+), 26 deletions(-)


base-commit: 746fc0787f616da418ffc04a110296fe95d53491
-- 
2.43.0
