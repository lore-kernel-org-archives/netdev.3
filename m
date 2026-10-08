Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980633A5440
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426558; cv=none; b=CEuKEhCN1ATQ9oFcWQ5hDumB4RTrOLR+aV3o2iOa8ymkgCgYEVcmldBI3QBx1Fl7JmDVf4ZpMENuwpu1ZDKcPKk4fHcJL0hW90qVTZUNjE/guLyHR5rO5P6fUaaXJhHLEUVWMUJuEHMvqaaKjYw5odwdFb0Z6g8ogPtEktGbMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426558; c=relaxed/simple;
	bh=K2zX7urvjPwy2TrhU6XQVJzXffnHDfc5nWvRgj55vJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyhJpL7JSvAI3wU5/ZU6DzsUyEOTWk5n2Jiso9rZbmqZJ631P2XD9t8PUpFSL0o8iyn3woAY0Uc4ecZZYgICwBbKEx0qVibq4NQfAbhQdnafsIgw+b2KXefAP3dx5COLo4CfpDwSHrmtnG29nWlgip0hnP0E1XDxwID57oed7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTSuiQZf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTSuiQZf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so16367725ad.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791426555; x=1792031355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8nU5jADcyGgWP4KIgDf9MaVyFEAKHWHZ95cmiPzpazc=;
        b=JTSuiQZffJ3nl5Tth+vOU+FVW5wP6AkE9ZjJcrY6w8pQ32VHZ67qLCg1V79FPJSyzk
         n3KhjJNR+079eBQrr4yyqIvYLIC+AY36hxiSyHxHn3X38frf8kI362izb472B0AhD38j
         3J40FTdO6tp+JXXH8Xx6ZAbtcBSjrTCCxBKTjj8U1oarEYzaaasQ6Zu0yz1zQ6k7asz7
         7Pq2mcHU5Ck5bYno1elofucy/3dRuQKO0iPHon0LE40YPhvhmXtaUMCv0e8xmbenR2Nr
         AOMLvWil5m601kFDJgfzTsR22PizmI2WTW1zMe1AGiPZpZ2YP+x8q19T9/CgfgLXTZS+
         fMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426555; x=1792031355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8nU5jADcyGgWP4KIgDf9MaVyFEAKHWHZ95cmiPzpazc=;
        b=MW9WKDIhBLILBReGOBBeqcQdCiyb02AYvZsIBNtXxiFVgpd4YI01dKQJQn2qkYVH0g
         x/jRqWrmrTi1rkMJjlruj176ID+DHWaVSAlv4jNeI7aAo7vcG5F56Wp5QPMxvw24A9qB
         gcNo94stiM1psno6LCq1+pgq5DGiONyfcjrN9dpkVhIqT4iMtrIJq28c4hTUEnrjeZDR
         ujmr5q4GAyr9Js85P4lsDch8ZWVsB7rFrNc2jkppIVtq4yIUhChFKEp6oMvdzprlN6Qx
         W8SZYUxGs+v0ZtMeN8/JmUzOf1HjjnnpRKvLiap8hBXYrdgmpy9cryZXynbn84CD5gnP
         iBKg==
X-Gm-Message-State: AFq9FYK/BggoR4mi9c6qOvUocb78ZM2u43bBpfgB3HjxIbKva6G5KL5H
	qO3CeTjYViEVC8u0Wd9OdccKtpzhj+1rUXhUc1RS+FLCtAWVd8cc4ZP2uKX3GaRK
X-Gm-Gg: AYBFou3MWWWyG+mK8whuOuth8TeRlh/5plJtWF6UbSJ8Jv5HHCSuFTJJdy0sx+6vi/F
	c1lwIV3f/6jDxWiONTFk+jgQi+iT/r8l/fmnHyPMZ4REdtvsES8kNv6s7S8hfJFVk4Htk6joIAZ
	2C5drcafKWkli1iH5xpGTbSpdk/B0A1k3wvsbWe7/U8KKMPwivVthWw/+y+Qcjy6HuG2Zz3vsN0
	SGUVbiygBdrCi09O1RRbKSeeWLGRWv1Q3p8TJTQL4cDXEq+GoqkYlylWJ8lWH9aUnFwby9HJQS0
	ZU5WDVzL3gPzghRSwzZqhgMRZttmheSzSa0ff6DJVzMUB+4vIH3tosqyBpGZT0thkAhBnPvg6GG
	StjsENgkS3Gv4pq2gpBBbtx4SAwGCczoGRO7iHYRnkXaNwmWhpENaZvGKr8/QbGJ2ryA8ypnBgl
	oOJQYgAqDQDwqOhs9zmGX+zmaVDwrkngvWogHK63adMwEzukOVySLmidLHsB4ZYLOGLsdgayJ4u
	Yjtq4sD/fjKZ/ICMWH6ZilNMw==
X-Received: by 2002:a17:903:2410:b0:2df:84e0:9021 with SMTP id d9443c01a7336-2e5ffae39d6mr35622525ad.7.1791426554896;
        Wed, 07 Oct 2026 19:29:14 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm18045865ad.50.2026.10.07.19.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 19:29:14 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 08/10] net: ethernet: aeroflex: move setting of netops to fix crash
Date: Thu,  8 Oct 2026 10:26:50 +0800
Message-ID: <20261008022656.3592191-9-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008022656.3592191-1-mmyangfl@gmail.com>
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

greth_of_probe() calls greth_mdio_init(), which connects the PHY,
before dev->netdev_ops is assigned. phy_attach_direct() ->
phy_link_topo_add_phy() reads dev->netdev_ops through
netdev_need_ops_lock() since the commit in question, so probing crashes
with a NULL pointer dereference when CONFIG_NET_SHAPER is enabled.

Assign netdev_ops before the PHY attach, as was done for emac in commit
7c9f391ec89c ("net: emac: move setting of netops to fix crash").

Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/aeroflex/greth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index a593adc16c78..fccb67beebee 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -1421,6 +1421,8 @@ static int greth_of_probe(struct platform_device *ofdev)
 	/* Check if MAC can handle MDIO interrupts */
 	greth->mdio_int_en = (tmp >> 26) & 1;
 
+	dev->netdev_ops = &greth_netdev_ops;
+
 	err = greth_mdio_init(greth);
 	if (err) {
 		if (netif_msg_probe(greth))
@@ -1498,7 +1500,6 @@ static int greth_of_probe(struct platform_device *ofdev)
 		dev->flags &= ~IFF_MULTICAST;
 	}
 
-	dev->netdev_ops = &greth_netdev_ops;
 	dev->ethtool_ops = &greth_ethtool_ops;
 
 	err = register_netdev(dev);
-- 
2.53.0

