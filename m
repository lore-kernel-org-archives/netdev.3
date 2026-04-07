Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981062FFF9D;
	Tue,  7 Apr 2026 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583040; cv=none; b=flC5KHYDkegUniCTM5wzUCxV0seiGYU6ZCzqS4kE6+nVm8+LPRKKNAWqgsKDa/Ff19OVpwa/F/Boh50Uv79iGevXRYVxmHWHVBZk3K1/WfCF1iGiex/sSBjXdvUer7t1fRp+F8UVtLsJ7QgVqhQiUOm1DtGT+IQoG7lXocEZCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583040; c=relaxed/simple;
	bh=RuGgmeKjH02JQYKyPD4VMsY7Oa2iZ0/ts8jVV3XqkOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5hb8IbZ0rJcaqRZmwQCNnNcn7VTOUb/0sBx5ylztJhBpMH63pm7nd5Fb9bGY0iUSELY4LBAOjPH3HpkqlJvGTT8vbyTCSLSgy88X3/DjXctdhV+Xh5HQf4MAdGl69k4KzkV+e6Av95ErEbWcZKKGCUg69MzSPx1W22B0UQ1zMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wAAFy-000000000o8-1cuP;
	Tue, 07 Apr 2026 17:30:30 +0000
Date: Tue, 7 Apr 2026 18:30:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 1/3] net: dsa: mxl862xx: reject DSA_PORT_TYPE_DSA
Message-ID: <b686f3a22d8a6e7d470e7aa98da811a996a229b9.1775581804.git.daniel@makrotopia.org>
References: <cover.1775581804.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775581804.git.daniel@makrotopia.org>

DSA links aren't supported by the mxl862xx driver.

Instead of returning early from .port_setup when called for
DSA_PORT_TYPE_DSA ports rather return -EOPNOTSUPP and show an error
message.

The desired side-effect is that the framework will switch the port to
DSA_PORT_TYPE_UNUSED, so we can stop caring about DSA_PORT_TYPE_DSA in
all other places.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index e4e16c7207630..9a9714c4859b1 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -544,10 +544,14 @@ static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
 
 	mxl862xx_port_fast_age(ds, port);
 
-	if (dsa_port_is_unused(dp) ||
-	    dsa_port_is_dsa(dp))
+	if (dsa_port_is_unused(dp))
 		return 0;
 
+	if (dsa_port_is_dsa(dp)) {
+		dev_err(ds->dev, "port %d: DSA links not supported\n", port);
+		return -EOPNOTSUPP;
+	}
+
 	ret = mxl862xx_configure_sp_tag_proto(ds, port, is_cpu_port);
 	if (ret)
 		return ret;
@@ -591,7 +595,7 @@ static void mxl862xx_port_teardown(struct dsa_switch *ds, int port)
 	struct mxl862xx_priv *priv = ds->priv;
 	struct dsa_port *dp = dsa_to_port(ds, port);
 
-	if (dsa_port_is_unused(dp) || dsa_port_is_dsa(dp))
+	if (dsa_port_is_unused(dp))
 		return;
 
 	/* Prevent deferred host_flood_work from acting on stale state.
-- 
2.53.0
