Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372313A258;
	Sun, 22 Mar 2026 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138746; cv=none; b=pso//OgrgWhJ2w364pPWj7EMWUW9pF20PsqCootdFkFKz6UiRmXhj6jGPWj3SxSRL1WSTgCIUeZMyFgCt7rLWe8WsMnkVsRIDit9csMKr0U876q0ZC/WrIM5F3WJfRlOboxQap23DZ8LHFdV9IjkFk0YJFPz6CrqXSOmTTyiRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138746; c=relaxed/simple;
	bh=kHUh4DMK4hSNQjOELR5Ln745QI5cflC4Va03ziUL0Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNrqMISvH8Gw4vrWW6Zmv8p8h4YTnYYWHMNxzZVBtby28++HP7DytcXkJiWekGDpjQbe2734xXG8QkLxgZCn5O5f+GIAOwzKzPkAINfOVUy92CyEALAd/W4VSSZzgXruVd224MQ4rrnMGsHgp2jjyQpDSCL8dildz8H98YBGucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w46Wz-000000001MM-2iNr;
	Sun, 22 Mar 2026 00:19:01 +0000
Date: Sun, 22 Mar 2026 00:18:58 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v6 1/4] net: dsa: add driver-private pointer to
 struct dsa_bridge
Message-ID: <4ff5b936b1f4ad31ffe132aaef798d247a8ac812.1774136876.git.daniel@makrotopia.org>
References: <cover.1774136876.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774136876.git.daniel@makrotopia.org>

When a DSA driver offloads a bridge to firmware, it typically receives a
firmware-assigned bridge identifier (e.g. a FID) that must be stored and
retrieved by subsequent operations. Without a place to store this in the
DSA core's bridge structure, drivers must maintain a parallel list of
bridge objects and search it on every join, leave, and FDB operation.

Add a void *priv field to struct dsa_bridge so drivers can store their
firmware bridge identifier directly, eliminating the need for driver-side
bridge tracking structures.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6: new patch

 include/net/dsa.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6c17446f3dcc2..1c6f6c3b88e86 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -234,6 +234,7 @@ struct dsa_bridge {
 	unsigned int num;
 	bool tx_fwd_offload;
 	refcount_t refcount;
+	void *priv;
 };
 
 struct dsa_port {
-- 
2.53.0
