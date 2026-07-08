Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0B4C955C;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530757; cv=none; b=cLSeQWE4hwzNlyOU54Q/pHglhKmt7POFhwGrdrE9rhVexYrPX8Ea7T0wTXG/nT8w0Ei9gSKebPYjees87LwtTogSJKfvlOl+O+hzdDTk35286W6mpnzsSX9hryfvSq95OOqqoJcCodCXIrlECrdcRniO5ShkJTOxnUWt580YN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530757; c=relaxed/simple;
	bh=tO65MYkXi3aUKw0XR3bn0/mIiIMrnwfj1GuESNTstxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGXc4AtJKpeHUd5Rzf0Ca1Edxb+HaoszZyN9KtEZe74B62xJ+XdR45NEpStezTI1CMMG1OVevWkgkMw4G6Vgg+jx/YJx2MUYiCsfkp5AzcmehDGV5yx3FfXjCyYgsgaLiGwiPiHBCet7x6qML8x1yjAOQgH6m5ISKk65hg+Sark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYPtHZOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYPtHZOU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A453C2BCFB;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783530757;
	bh=tO65MYkXi3aUKw0XR3bn0/mIiIMrnwfj1GuESNTstxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IYPtHZOUIn9NsZ8kB9eWUu4fjXeGRcJBpNS9RNz35q3dB/B0+hgCKFzgHlkhORo8Z
	 6x+2MG7iLkBlPSzgZrsLO6aHe0JLbg8BOcBUXp+SllHnigGtJEc5YdgO0X1tMzda3K
	 Ti9q4WFkYcZsMPIZQ56lWbShAf7e5L8CL8PMt/mcw+x7z9nk1Qb2OeGFCHCrKfVpNc
	 E9ejq+trpEqy4qQflnPnCNnz8sehOGwpnM2ceB+b657x67nXMXFiOMsdZw9YgTNf4Y
	 LPl0oBmBF4yxmslUw+y5ysH/ZVa3/9F62qk+OYiCkvks5SydVaSiutp//QWncptIiQ
	 zQmz5C+MVARTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A3CC44507;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 08 Jul 2026 10:12:45 -0700
Subject: [PATCH net-next v7 15/15] onsemi: s2500: Added selftest support to
 onsemi's S2500 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-s2500-mac-phy-support-v7-15-478c877aa1a9@onsemi.com>
References: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
In-Reply-To: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783530757; l=1904;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=2F0qNA75xdPACjyZAhDG2bEj0CghDHnrBQqxbAXox/w=;
 b=34FcZ5aLfX7qa4rp2Rj7EI5IE2MOkVn3CLe9AGFEiu0AdYthBE2JsX0rGbVm51XqFZj7DjrRM
 HSlw9tT8Q9uDmIA0gwJ7qEceF6yA9l8DUtGztD3Fb8uqChXPSjcwlcq
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Adds selftest support for onsemi S2500 MAC-PHY. Added as a separate
patch for the ease of review.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v7
  - No change
changes in v6
  - Moved the signed off information to the correct place.
changes in v5
  - No change
changes in v4:
  - Added a selftest as a separate patch
  - First patch
---
 drivers/net/ethernet/onsemi/s2500/Kconfig         | 1 +
 drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/onsemi/s2500/Kconfig b/drivers/net/ethernet/onsemi/s2500/Kconfig
index 7786f702d6ec..141fbaf1b641 100644
--- a/drivers/net/ethernet/onsemi/s2500/Kconfig
+++ b/drivers/net/ethernet/onsemi/s2500/Kconfig
@@ -6,6 +6,7 @@
 config S2500_MACPHY
 	tristate "S2500 support"
 	depends on SPI
+	imply NET_SELFTESTS
 	select NCN26000_PHY
 	select OA_TC6
 	help
diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
index 7e96d9ad563f..0b7ef490d7ca 100644
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
 

-- 
2.43.0


