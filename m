Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A573CE0A1;
	Sun, 14 Jun 2026 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456466; cv=none; b=K/ZNdy14tNFgvXuvzLb+jIoR1mXPSTPz3CTkdHAdc2rJmzV0tnDqxYjqlfSeLVaga3kmyDFwmm58ehX3Z2kwwGmX1fUjTyrXOIMSLe0Z6P4yexCXME63fRSL1wEFYlsjmj6Z7+QN8uLeNHpemFcYIUR6oOrOXGGWzFdX0tBVrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456466; c=relaxed/simple;
	bh=YHWTFhVFciZIqGEwjxq70wDRUdMvVzOfe1HYq0Ikrok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPBZMTdIpXPj4Y4EGAb4m7HQoDG9dNVZ0f8pMGUY+sC3krLuIaH6RMcYH1fFWzOzUdNe6DdEPB3EzXKqKxkzO31PL6IpE7wp2iWG5LBJp4hdRDFEo+QY/B/DaxuyJjnGFpt0lisshzTLdiL4M29uWqqAMEIIfVzySYEDTaWe4E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAaCOPH2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAaCOPH2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1986AC4AF60;
	Sun, 14 Jun 2026 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781456466;
	bh=YHWTFhVFciZIqGEwjxq70wDRUdMvVzOfe1HYq0Ikrok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iAaCOPH2sO7D7TwQcIC6sAzfwGU/sRd4G4GIImiy/CkOU/JAc4MOe0KFH0Vdrl7Vr
	 NtAdiNAAs/2nV3d/ojJwRm7b6q8nzRi4HLslMDuNlk/ECXsuYTaud2eLcAibWbfNwK
	 4UvDkzCLmrnmgjTrJgbflhrMcOoERKaAy+otoCEKI3I3GPXDpsuEiHzpTz33zYZ3a6
	 s0BsMk8YvGIvGxM+iMl1mU2gTSQz8AEVarDAYhyHqQEe1iOQ9zIeYu0HzpfMIFOix2
	 5kcdWJxRFGQdImmlh6cTM72eobKvfw9DLU52v1P+P+RmgyKMNq4+fjPQd0HkXo7V4o
	 ZRvEbw/+/6+vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10577CD98C5;
	Sun, 14 Jun 2026 17:01:06 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Sun, 14 Jun 2026 10:00:29 -0700
Subject: [PATCH net-next v5 13/15] onsemi: s2500: Added selftest support to
 onsemi's S2500 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-s2500-mac-phy-support-v5-13-89874b72f725@onsemi.com>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
In-Reply-To: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781456463; l=2066;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=XieZurT7WY9JzTSozp13VETp6zk/FQzfj6t8dvF6zmE=;
 b=CvqJ/rCMjfn3fwLZ0epFzvZ0CDjEKl/WT1FSeoFltKJ/JdwGLIycgNkFerA9cuso7yRtSGk1x
 HFwmFc9W/wdAApNkZH4pS/+wzIr+GfhhKfaujGAC/R9rsQxgYN8CHOZ
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Adds selftest support for onsemi S2500 MAC-PHY. Added as a separate
patch for the ease of review.

---
changes in v5
  - No change
changes in v4:
  - Added a selftest as a separate patch
  - First patch

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/onsemi/s2500/Kconfig         | 1 +
 drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/onsemi/s2500/Kconfig b/drivers/net/ethernet/onsemi/s2500/Kconfig
index f2e8d5d1429d..7bb4b413d5f9 100644
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


