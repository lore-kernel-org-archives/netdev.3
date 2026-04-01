Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308D223328;
	Wed,  1 Apr 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050491; cv=none; b=GtgDjPhK5f0eAmnXZHWrlpx9nUDSgU5sHhlW3pOS3b8vO4k8ldYV3zpWC0dPeRdiImdiN9XQI2WEfPoI0ZbUrZy6i3ZQWbv+7S7ZQvxV8Fi4tHSIArhLqwoEdzsR12tPlxdzVzaS7Lwqs6RLPVRuD3Lca4h+27YG26Eiz1/s5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050491; c=relaxed/simple;
	bh=w2vx123z0kiho2g6MGL9WtrhSk5cuYR6E2U8kW/NcVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2ZlsMpWikVjD0h6nBoCEdfyjjxMOvumrR6jJGap0pAlbvGHSMXPIXKoVdMJgoTtuOWwsSILI8O1ndFo0WSomHmlDyGRZIw3stkNrZPpej54xTScudryvoJXhzHUFsC90VHFBn8/ej07LWd8ZlM9+/CZazUuFqqDYy2N8AR23Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w7viX-000000001gF-2CpV;
	Wed, 01 Apr 2026 13:34:45 +0000
Date: Wed, 1 Apr 2026 14:34:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Yang <mmyangfl@gmail.com>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v9 2/4] net: dsa: add bridge member iteration macro
Message-ID: <e7136aaa26773f39e805a00fe4ecf13cd2b83fc0.1775049897.git.daniel@makrotopia.org>
References: <cover.1775049897.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775049897.git.daniel@makrotopia.org>

Drivers that offload bridges need to iterate over the ports that are
members of a given bridge, for example to rebuild per-port forwarding
bitmaps when membership changes. Currently drivers typically open-code
this by combining dsa_switch_for_each_user_port() with a
dsa_port_offloads_bridge_dev() check, or cache bridge membership
within the driver.

Add dsa_switch_for_each_bridge_member() macro to express this pattern
directly, and use it for the existing dsa_bridge_ports() inline
helper.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v9: no changes
v8: no changes
v7: reuse existing helper
v6: new patch
---
 include/net/dsa.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index e93b4feaca966..8b6d34e8a6f0d 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -831,15 +831,18 @@ dsa_tree_offloads_bridge_dev(struct dsa_switch_tree *dst,
 	return false;
 }
 
+#define dsa_switch_for_each_bridge_member(_dp, _ds, _bdev) \
+	dsa_switch_for_each_user_port(_dp, _ds) \
+		if (dsa_port_offloads_bridge_dev(_dp, _bdev))
+
 static inline u32
 dsa_bridge_ports(struct dsa_switch *ds, const struct net_device *bdev)
 {
 	struct dsa_port *dp;
 	u32 mask = 0;
 
-	dsa_switch_for_each_user_port(dp, ds)
-		if (dsa_port_offloads_bridge_dev(dp, bdev))
-			mask |= BIT(dp->index);
+	dsa_switch_for_each_bridge_member(dp, ds, bdev)
+		mask |= BIT(dp->index);
 
 	return mask;
 }
-- 
2.53.0
