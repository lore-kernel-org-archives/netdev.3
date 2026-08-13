Received: from mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BCA47DFBA
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627806; cv=none; b=LjeLf9z84/hgw82YM5zw7otIP1gqnOInMxV8g586Iz0OMT0kbrqo8i9EGbzsv8eb12vIINrNWwcapCohBhQUYkbi6gtZWfedUIqYgQMgIRMnA76znmytdKKY/oqHy3oVVu0278YwoLxIy0LHpIE/L1IbFIcS3C+/6wabDHAqslg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627806; c=relaxed/simple;
	bh=HAWYRcD4muE/GTJBGpnAWE09cM62VJnZG/b+f/Yg7FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQLLJS4SnXfhfkUZCud1K5SqGTAU7Bal8ZaTdl0SDCW2gKk24iz+vs6RuYV2nA9PObGpYP6bg7RcrlOkbWooOujAx3KRr8hJaJN0Kmu9OH/uNSYJwMgg86nNmagAJBe93DXfdWgkNMvk6LiIfKU5j95pPsAwNGKo2NhBwOUEbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YDmFOL+O; arc=none smtp.client-ip=91.218.175.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YDmFOL+O"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HAWYRcD4muE/GTJBGpnAWE09cM62VJnZG/b+f/Yg7FA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786627803; v=1; x=1787232603;
 b=YDmFOL+OQhWXJ4EYIdv4uTX0N/ULQF2IASBOKEQaYx1K5J24jUQgOLBMPsIaRB1CQXOkDKmg
 ui8o/wynVpmjIM3vImEBLQ92YN023pdWsfrW1tNLET5TdAAesbaoz+1sWYDrFg7qKBxTejYUUIc
 YGNlZGx02inRR3CmGVlFLIHk=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id ff7f95da8e7537ab;
	Thu, 13 Aug 2026 13:30:01 +0000
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v2 0/5] net: phy: fix cleanup after probe failure
Date: Thu, 13 Aug 2026 21:29:40 +0800
Message-ID: <20260813132946.116176-1-xuanqiang.luo@linux.dev>
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
at each stage or restore the PHY device state.

Port setup also leaves SFP cleanup split between phy_sfp_probe(),
phy_setup_ports(), and phy_probe(), and default port setup ignores errors
from attaching the port to the PHY driver.

This series makes each initialization layer own its cleanup.

Patch 1 splits the phy_probe() cleanup by initialization stage.

Patch 2 makes SFP and port setup unwind their resources in the required
order.

Patch 3 restores the PHY device state after probe failure.

Patch 4 calls the PHY driver remove callback after later probe failures.

Patch 5 propagates errors from default port setup.

---
Changes:
v2:
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
  net: phy: restore device state after probe failure
  net: phy: call driver remove when core initialization fails
  net: phy: propagate errors from default port setup

 drivers/net/phy/phy_device.c | 77 +++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 19 deletions(-)


base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
-- 
2.43.0
