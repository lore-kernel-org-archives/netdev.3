Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589174;
	b=abAuDDXzX2Ft68iV0Srp0KMHiLnDBIA8gcikEJvv+EHpj63unUuHouNUtUWhFvL0WEXL
	 2Dw1C5AIPYgByeJrRweOFGTtaLe6w4EsLVbmOCKB8cveLf/2iBPo3u08TLFje/XJdm7I0
	 Y17fJw/rOEjtIqYBsVgHxOKmkX4YAaQ3Nti1Dca3NkuhhT2g3gYAR+Ba+Oe8VJdqdaL4X
	 sWDS5jl4lCFsOQZu/TlyTu7PE3CLhGjIrZfq2rNRHJa6Zqvi3qQniijuz2/oDPn5vXzoY
	 xPLVz786A4Id/MVIUVZUopDeoyBEO862XWguvgHP7edQlmj7mCkIPdXhDqnTrqVYPhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589174;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+L6GxWJvFVJvbC9mX5pc9tpnkZRd3788j2xKiqHowK0=;
	b=uMnSI0O0MOjz79O+RRrjEHSjNSQFcU33JvRsPp5aFDOzo5971f1VzNQdpDm/L2ZdEeUJ
	 oGBOUZRXl5BEtOO9dsNxkUQ/z0wx71U8J94Xg+FiR97c1y81cRc1w1Y+sLT5PnZOJv5Xx
	 XKASG7hNGjw3IH6EV6RILfI8MMw/oayP2CHi5IvFcVTsFLw2r4fwzlEuZJ2w/xW0W+/I+
	 r4Jm/GBStPL+jnQdGxN/SypuGs0apuV9JlKc2jQNJ++n8ONo0beNAxTVbNp+wQbD3zy3c
	 KjFF1s3HiYD+FjJdMPjcamfXI6IwrJHPCfx2bcQr+0BUnTg6fjGATinfaGgAGDP4b8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6qcGWB0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A13606A32D;
	Fri, 13 Nov 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6qcGWB0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589173;
	b=fWqFE5fhrMeuEgn+TUbxDSl7c2E0ut+wFGnAwMfRacTwTYYOLtYfP2nhEMd298cUAUFD
	 RtBByWu83IvtREkj3PqlUYYJ5wT2JXN+p38XcEmha3UFcdF/zT7ti0/xbluY5Ih+dbYk4
	 LT268SBmgGdqnlgljQlwem6Oy4WHoqS/+sdtRCyqLQvWN2cAPpT3n1Ogj/8oM5lc0nTrX
	 GodTJgC3SkJjPlOXIciSAtYynS377slj7TiGFHEzKSAmrFhSNTSSK988JOeSRNuV42n61
	 cDORijjKu6naRSCgtI559oyTpMZDtQfqceTp/ElUvSNqbz+r2yVCrymVwhKaPRNNhiA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589173;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+L6GxWJvFVJvbC9mX5pc9tpnkZRd3788j2xKiqHowK0=;
	b=fDpsG7OxBTcNisbMcZi86lKhYbGUtt6Ej2AnUZeNarKWVjDMVJFx4iQG5OykAEelL+UG
	 6GhbcTmT72FQprYcEe02C4frDXty6fcq7h6XE6gSHF33jymYdGwfOB8LsmBrZDynrhbOK
	 vd6mKnN9wSO3WCsXf05KwxekFVo5REIB2lXcW2d7e7UdwSCmxIjd31Lh9L/nZ6Sr6nZLS
	 tIiPAzqJ+aGF1Nri27ECls4PzzjpEgScd6V8mhyOZ6hU+zWQ09CdcMUcBudr324CiXu/Y
	 fc4V7Nxk4WsLw/TQyEsqxobTBBd/7NmvLBSHCgv2l4rkP0MDEJN1ayc+/lo3LbnRKxg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3336F1F00932;
	Fri, 13 Nov 2026 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589173;
	bh=+L6GxWJvFVJvbC9mX5pc9tpnkZRd3788j2xKiqHowK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=j6qcGWB0MDt0FHgECeC++SOAtDEe93Qu/RItTKfppROGeBjJ19GBSlXU/EhfaWURn
	 Hx1yJZLa3WoENcUSzG9aZdCyrYfe98ylxDqmg528iO5dhiY/BeTzsnJFu/kXo77lMB
	 WeEtiNIVK5AQB9cJHobWi2k+oY+sMWgQn0VZXRL9v4MlYwG1vx8MWntkzyBJJGbzxY
	 FPgeCB68kdRowVho/aW28Cn3h561gGXVnYRvP0zRJn9pTLnGhBG72Tz6TVF539fSuO
	 UfXvnmwijPvoOk/Yyzp9Y2Cxosdqm0OTYKPA3NLlF2Ykx7ArQg+m+NwTJ/5bG2ZLHd
	 AUAviBsKs75Lw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DAA1249A37;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:30 -0800
Subject: [PATCH net-next v11 11/14] net: ethernet: onsemi: s2500: Add
 selftest support
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-s2500-mac-phy-support-v11-11-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=1974;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=WH9d7pri849TCTPKCiEfO7p1BC22IefPtsHGHwczn+Y=;
 b=NkvbQfuN5GCezyCM1QXnlhD0fh63H5db39dnd7ZlMkJz8+hjrHlceqngk3J1aeaKMkjg+Nmzy
 DTTiMglbheYDWZN8c85Q3z7YV7d7LsOxtXct5nE2aCg1JhbaMfOlUBZ
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Add selftest support for onsemi S2500 MAC-PHY. Make it a separate
patch for the ease of review.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - No change
changes in v10
  - Added a check for CONFIG_NET_SELFTESTS before returning the
    count value
changes in v9
  - Added net_selftest entry to the ethtool_ops in the correct patch
changes in v8
  - No change
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
 drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
index 2fc09107aed3..feacb406778d 100644
--- a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/ethtool.h>
+#include <net/selftests.h>
 #include <linux/phy.h>
 
 #include "s2500_hw_def.h"
@@ -205,6 +206,10 @@ static int s2500_get_sset_count(struct net_device *ndev, int sset)
 	switch (sset) {
 	case ETH_SS_STATS:
 		return S2500_MAC_STATS_LEN;
+	case ETH_SS_TEST:
+		if (!IS_ENABLED(CONFIG_NET_SELFTESTS))
+			return -EOPNOTSUPP;
+		return net_selftest_get_count();
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -218,6 +223,9 @@ static void s2500_get_strings(struct net_device *ndev, u32 stringset,
 		memcpy(buf, s2500_mac_stat_strings,
 		       S2500_MAC_STATS_LEN * ETH_GSTRING_LEN);
 		break;
+	case ETH_SS_TEST:
+		net_selftest_get_strings(buf);
+		break;
 	}
 }
 
@@ -376,4 +384,5 @@ const struct ethtool_ops s2500_ethtool_ops = {
 	.get_ts_info = s2500_get_ts_info,
 	.get_regs_len = s2500_get_regs_len,
 	.get_regs = s2500_get_regs,
+	.self_test = net_selftest,
 };

-- 
2.43.0


