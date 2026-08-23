Received: from mta0.migadu.com (out-117.mta0.migadu.com [91.218.175.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC2E25D530
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787457386; cv=none; b=c1CXPn9tiUAp44LsEl1chenvVaxevTZIX3U/cKd+dFhmDarLme2z0kDxmXtk9B8DBDQB1dIpW8w2uu9RYbh0mvomX0tGx8vs4VwBVkoEtX93NYmyIc/9y7AWi2Nk15kEWCSCNFB16fSew1cLWESRqmGqBWS2bsPK8P9gUFYhylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787457386; c=relaxed/simple;
	bh=b8WeBQHou80WQkLqEmCbOcvkNaWevOAbDfV9nSLIBr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqdwQa1+FjYVN8UacB+soY5y18F3P3qT1vgWDmtPYgf4FNDZb3awhikwd+4PaAzE5P3A1Re7sg5K021x5q1XESEHWJI9mt65owHZ2zrNbUo0o3vzitiBFoN2lwhULOuc+0a2lEapTLt2UmwwZvJNy1hDo8GkemAnbke66kG7Tss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SU+fjKkB; arc=none smtp.client-ip=91.218.175.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SU+fjKkB"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b8WeBQHou80WQkLqEmCbOcvkNaWevOAbDfV9nSLIBr4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787457380; v=1; x=1788062180;
 b=SU+fjKkBf4JdlMEhadg0heyJ42Bp85QKpdF1kHJqKA2xA1x/A7ZxhgVS9Ntf6pR4iljWbxzf
 aJQGxHDJ8MVdQCeoWozPv71ZdZMnDcbarQA8FXbs4RlUDK3nF5lMTv+WcO5Sgtc9oF7wIaRpf26
 ykrFmhol6YkJ1BL9pIR2YI9I=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 43fa2e50163e711d;
	Sun, 23 Aug 2026 03:56:20 +0000
X-Mizu-Trace-ID: 43fa2e50163e711d
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org
Cc: hkallweit1@gmail.com,
	chleroy@kernel.org,
	qingfang.deng@siflower.com.cn,
	hao.guan@siflower.com.cn,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v5 0/6] net: phy: fix cleanup after probe failure
Date: Sun, 23 Aug 2026 11:55:54 +0800
Message-ID: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
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
v5:
  Patch 1:
  - Describe the NULL-dereference path after a probe/remove cycle and add
    the corresponding Fixes tag. (Sashiko.)

  Patch 5:
  - Correct the Reviewed-by tag to Maxime Chevallier.

  Patch 6:
  - Mention the phy_remove() teardown path that can also trigger the
    double-free. (Sashiko.)

v4: https://lore.kernel.org/all/20260821070327.16147-1-xuanqiang.luo@linux.dev/
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
  - Make SFP and port setup unwind their resources in the required order.
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
