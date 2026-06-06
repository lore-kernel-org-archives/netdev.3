Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BD30D416;
	Sat,  6 Jun 2026 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780724570; cv=none; b=qZkSfSMY0GlI8Vnj2ThDm/37lbiLquw7ThXZJECC1TV+GE/yC3yB3nk6U1VsGnf1e0o10WKv20sN2WPbgM3txGCYKAiSS+MehDbDKbma0GT0CBbnRZAkYJKrVK1YahbNJp7Y1C4sDYBXexBB17qnSowyTk1u1SfBmxqOUjKROvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780724570; c=relaxed/simple;
	bh=QG9/aUQq3lNYNSRpDS+oE4FGDJ/aRe862w851zW6Btg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7KZOizGz/YDkpkg43acIes21PHO2QnuQLiBgBjqUVAQFtxh/YWjMTkZ6JGi4KuXRN7U1sb7UY+YpL/CKjo3eCHs3AMpi5/c9+8t96wgr+FSyYgjolMq+n92Syq8ekl1xjK3dczopnMleUV7tJUL4b1EHWansv4oegjyVz6lkgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4ps/SEc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4ps/SEc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 192AFC2BCC4;
	Sat,  6 Jun 2026 05:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780724570;
	bh=QG9/aUQq3lNYNSRpDS+oE4FGDJ/aRe862w851zW6Btg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k4ps/SEcFKfWZEfXb6GFo8obkV4WlrsG6q3A+tQRdabPaKzIkrblJNhuwDnGZXAG+
	 pvBczhT1aSL3yKqhk4aGe2Dx+IHeEp/DU9vdiMqdkKEXG0sx3ktJv1ixOnJzPB8RSd
	 SZdpl6EmawYUNzK3AQZJyF1jMsqImz/iahZMQyR1W+H/tzvP7hzzjhfJdNoTOgd/oe
	 /vNWpTliB036A07HsDFAbA2dtlcAk6VOyVm4Y3ww6DJZABwNCSKb23w0FBjhc9r4De
	 oHSMbFjoPFGJ6IjnXaUWPtcvyfxKrYkLaz+Cctpejt1Ov48cOSs9HvAL71mgIgqfJ2
	 8hgAy0gQVu3qQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B01CD8C92;
	Sat,  6 Jun 2026 05:42:50 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 05 Jun 2026 22:42:45 -0700
Subject: [PATCH net-next v4 14/16] onsemi: s2500: Added selftest support to
 onsemi's S2500 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-s2500-mac-phy-support-v4-14-de0fbc13c6d8@onsemi.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
In-Reply-To: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780724562; l=1929;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=pwrT8nQjZ1Mftaz3kKIXboZB0R35Ne+b9zhE7hrK+JA=;
 b=Vo5hs0XFfqz/FTSZZqZjSzJBiKaoXnTGTWT12jwxtBzdMhCw7nwlRfdpeiSUHg+/QfUeAOy5E
 IAvRL59AlO7C2ha+bowftIcAja0L+O31YpDSc3/XZvBj5+GTztRnJmq
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Split the selftest support into a separate patch for the ease of
review.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/onsemi/s2500/Kconfig         | 1 +
 drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/onsemi/s2500/Kconfig b/drivers/net/ethernet/onsemi/s2500/Kconfig
index 22b0afad7a21..822398eb4760 100644
--- a/drivers/net/ethernet/onsemi/s2500/Kconfig
+++ b/drivers/net/ethernet/onsemi/s2500/Kconfig
@@ -8,6 +8,7 @@ if NET_VENDOR_ONSEMI
 config S2500_MACPHY
 	tristate "S2500 support"
 	depends on SPI
+	imply NET_SELFTESTS
 	select NCN26000_PHY
 	select OA_TC6
 	help
diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
index 85bd8ea50dd8..334fac71ddea 100644
--- a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/ethtool.h>
+#include <net/selftests.h>
 #include <linux/phy.h>
 
 #include "s2500_hw_def.h"
@@ -229,6 +230,8 @@ static int s2500_get_sset_count(struct net_device *ndev, int sset)
 	switch (sset) {
 	case ETH_SS_STATS:
 		return S2500_MAC_STATS_LEN;
+	case ETH_SS_TEST:
+		return net_selftest_get_count();
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -242,6 +245,9 @@ static void s2500_get_strings(struct net_device *ndev, u32 stringset,
 		memcpy(buf, s2500_mac_stat_strings,
 		       S2500_MAC_STATS_LEN * ETH_GSTRING_LEN);
 		break;
+	case ETH_SS_TEST:
+		net_selftest_get_strings(buf);
+		break;
 	}
 }
 
@@ -343,5 +349,6 @@ const struct ethtool_ops s2500_ethtool_ops = {
 	.get_ts_info        = s2500_get_ts_info,
 	.get_regs_len       = s2500_get_regs_len,
 	.get_regs           = s2500_get_regs,
+	.self_test          = net_selftest,
 };
 

-- 
2.43.0


