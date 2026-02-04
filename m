Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928A8460;
	Wed,  4 Feb 2026 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182798; cv=none; b=BPCfmQ89+Fz+SagNz1+Jryrx4CHNoOBq71Z24nrCDk/GMDJ/IZ0HVAo+y4jLjTx/UKpVsDSeudZmiaFhT4n8CfeXgAIJskPZltalSzeeBFJgi08s5Uqs/7L3VTlUbgjTIXT2lf+osjR2w70yOr8KP5zGJzMaq3LZfVfOafaRRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182798; c=relaxed/simple;
	bh=W7F3cwVRQvPPcCpPC5iXd7t2V1p3TDDeh7EhvhGNK80=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Wjy6Vc9hxWaikx4je5vcu49X87Bvkdh/mtOvfI6FDoKLfcnVw2gI1rfvtrg8VAIvfXwwlR3UdFYmXqnxmcEw1CpxNo/8qBCHoT8Lknu7w/F6HdzhJcqswME9XC7xiiRz4FmlkdUEWTX4xZOSM1Oyw0/hCmCPn2/DL2cJAX/OZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Feb
 2026 13:26:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Feb 2026 13:26:30 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v4 00/15] net: ftgmac100: Various probe cleanups
Date: Wed, 4 Feb 2026 13:26:26 +0800
Message-ID: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILYgmkC/23NQQrCMBAF0KtI1kYy0zQEV95DXEzTiQ1oWppYK
 tK7G7pRrJuBz+e/eYnEY+AkjruXGHkKKfSxBL3fCddRvLIMbckCFdaAykqfr3dy0t2Y4mOQqBr
 EqvHaWBBlNIzsw7yCZxE5y8hzFpfSdCHlfnyunyZY+4IaBar+RSeQSjbGsqaqtb7hE6WBuc3su
 oPr76s34ZcBZmNgMSx4DV6BR7J/jepjlLMxqmIYMmRbXaNVtDGWZXkD4P1zc0MBAAA=
X-Change-ID: 20251208-ftgmac-cleanup-20b223bf4681
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770182790; l=2672;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=W7F3cwVRQvPPcCpPC5iXd7t2V1p3TDDeh7EhvhGNK80=;
 b=T0WejHB1sVF3Emb9bGvaUcKGWJX0Wwfa8BjiR8yD0uDm6a7Iv4Xc1GliegWAmu6VmiwM893Rz
 jxUn3i7NqbJCz0bolcnPIDQhisGScAJ3YpxJ+LNqRgEAOo4lHmPxGWo
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The probe function of the ftgmac100 is rather complex, due to the way
it has evolved over time, dealing with poor DT descriptions, and new
variants of the MAC.

Make use of DT match data to identify the MAC variant, rather than
looking at the compatible string all the time.

Make use of devm_ calls to simplify cleanup. This indirectly fixes
inconsistent goto label names.

Always probe the MDIO bus, when it exists. This simplifies the logic a
bit.

Move code into helpers to simply probe.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v4:
- [08/15] Add err lable to ncsi_unregister_dev() or
  fixed_phy_unregister() when getting any fail in ftgmac100_probe_ncsi()
- Link to v3: https://lore.kernel.org/r/20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com

Changes in v3:
- [06/15] Add check for devm_clk_get_optional_enabled().
- [09/15] Directly return status from ftgmac100_setup_mdio(). That is
  [13/15] patch behavior, so delete [13/15].
- [09/15] Adjust err lable.
- Add a new patch to make use of devm_ methods for mdiobus to simplify
  cleanup.
- Link to v2: https://lore.kernel.org/r/20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com

Changes in v2:
- Add net-next prefix.
- [08/15] Updated commit message.
- [04/15] Deleted {}.
- Link to v1: https://lore.kernel.org/r/20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com

---
Andrew Lunn (14):
      net: ftgmac100: List all compatibles
      net: ftgmac100: Add match data containing MAC ID
      net: ftgmac100: Replace all of_device_is_compatible()
      net: ftgmac100: Use devm_alloc_etherdev()
      net: ftgmac100: Use devm_request_memory_region/devm_ioremap
      net: ftgmac100: Use devm_clk_get_enabled
      net: ftgmac100: Simplify error handling for ftgmac100_initial_mac
      net: ftgmac100: Move NCSI probe code into a helper
      net: ftgmac100: Always register the MDIO bus when it exists
      net: ftgmac100: Simplify legacy MDIO setup
      net: ftgmac100: Move DT probe into a helper
      net: ftgmac100: Remove redundant PHY_POLL
      net: ftgmac100: Simplify condition on HW arbitration
      net: ftgmac100: Fix wrong netif_napi_del in release

Jacky Chou (1):
      net: ftgmac100: Use devm_mdiobus_alloc/devm_of_mdiobus_register

 drivers/net/ethernet/faraday/ftgmac100.c | 350 +++++++++++++++++--------------
 1 file changed, 188 insertions(+), 162 deletions(-)
---
base-commit: a22f57757f7e88c890499265c383ecb32900b645
change-id: 20251208-ftgmac-cleanup-20b223bf4681

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>

