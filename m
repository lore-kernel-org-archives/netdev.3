Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401223FBEB0;
	Wed, 25 Mar 2026 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461260; cv=none; b=JjWdzcvu1d9JOl3lix+GPnPka4OY+CiHWVuSEK/jCF7a6HIVFbHDULfBsLj9rjESAVGZR+KnjwYpKJcofhIwftcWks/vYKdpzhpaQLq+Z+DGSHR+XGNvvqunlWtwBVnaEJdBG2/rnKZLTkDSb4eL5uqY/DSQtRgY1jJBI2cqgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461260; c=relaxed/simple;
	bh=KrDKZcgPrX2Y19TgNz/cvhKQGbS678Z7lmO0EqHYFNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQXlAfcomhWhDA3fh0Iw7YpoYSKqwMsYBxVJHBnP5lIDEc9df78fiAkJ4HMDhZlbmvQHeO6X9RKAlb+6vHhzE5MBV5Lkh4D1u0h/O9tOzcFAc6/5PpYMVD7h94hl7WgEIat7a3cKbU2scp8cf7AomD/EEMG/SbpYDtr2v5ReHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w5SQo-000000002ZO-2jlo;
	Wed, 25 Mar 2026 17:54:14 +0000
Date: Wed, 25 Mar 2026 17:54:11 +0000
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
Subject: [PATCH net-next v7 1/4] net: dsa: move dsa_bridge_ports() helper to
 dsa.h
Message-ID: <de15444c2b5a3e0529f51a435a74e17bfa79738e.1774459500.git.daniel@makrotopia.org>
References: <cover.1774459500.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774459500.git.daniel@makrotopia.org>

The yt921x driver contains a helper to create a bitmap of ports
which are members of a bridge.

Move the helper as static inline function into dsa.h, so other driver
can make use of it as well.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v7: new patch

 drivers/net/dsa/yt921x.c | 13 -------------
 include/net/dsa.h        | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 904613f4694a..5b66109ecc23 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -2154,19 +2154,6 @@ yt921x_bridge_join(struct yt921x_priv *priv, int port, u16 ports_mask)
 	return 0;
 }
 
-static u32
-dsa_bridge_ports(struct dsa_switch *ds, const struct net_device *bdev)
-{
-	struct dsa_port *dp;
-	u32 mask = 0;
-
-	dsa_switch_for_each_user_port(dp, ds)
-		if (dsa_port_offloads_bridge_dev(dp, bdev))
-			mask |= BIT(dp->index);
-
-	return mask;
-}
-
 static int
 yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 		    struct switchdev_brport_flags flags)
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6c17446f3dcc..e93b4feaca96 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -831,6 +831,19 @@ dsa_tree_offloads_bridge_dev(struct dsa_switch_tree *dst,
 	return false;
 }
 
+static inline u32
+dsa_bridge_ports(struct dsa_switch *ds, const struct net_device *bdev)
+{
+	struct dsa_port *dp;
+	u32 mask = 0;
+
+	dsa_switch_for_each_user_port(dp, ds)
+		if (dsa_port_offloads_bridge_dev(dp, bdev))
+			mask |= BIT(dp->index);
+
+	return mask;
+}
+
 static inline bool dsa_port_tree_same(const struct dsa_port *a,
 				      const struct dsa_port *b)
 {
-- 
2.53.0
