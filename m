Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06DB36C9E4
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491224; cv=none; b=VXgMCLzC+zCu5yw5LgnKSJOFBIWYRRvR16K6XoK9tU5Gja1qvkYhdbfKSTYC8hPGesgC4PVGhwtrixfIfO/QTrK2bBVisqJYFeIok4VSUNxKRtHCRMihBekvqQSYmAEHKaNB/A5/YW68dk6j0pmI2xaAST9w3UfWf7HgrQMy6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491224; c=relaxed/simple;
	bh=2wxr/Q70DEIlw+bq4aRtP8yGtQiZ+u/gdNhzNSj4JGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xuc39SGALvX4NSa/iI2QkyDGcvah1C8FNPjj+4F6sRjRe9rLRJuPoYVKB/ItmlWw0W3z8/4zRr9aMk/tdgotoCHkt3a6z7lgYc3Dx3A3Yv7EXoDunJeb9HVNgySUjJOCRKNAt0jyCEQ8lGYt6iDVcf0amshXUjkmHyfTD5xJEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DENzTIjY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DENzTIjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F841F00A3F;
	Fri, 22 May 2026 23:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491223;
	bh=dhHib17SBqJdsADwFCWaLhoL9A5VoPEF0aoH9YkUr+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DENzTIjY7v4odTDWK6aWhwsExUjeZdpBkLkXj/RObUHwifeM39p5OtLj7wUEqYQbq
	 UkbS7cEWd6LQybSlBlR7Zab6Ef0FZsm2YSnajGpc1Ioke9nYwphbYuU3J2HjMaxY8G
	 bUOUPtd/f957yjFET5l0kV/NRBV68/mUDeWRNjOcvJc87yfK/K/GI2cCQii4sGn43L
	 KRp6Dxbd6ZIaWyTmrDZt9K1we/lKzPp+np10S3BZn9QvP2K5A43pDNaArGtA27rVX2
	 kSTL7eA2vRin5rrDhJNel21/ciQ9qpu2T09HatxaHwMo+ZBNvWMRj0/Z5hS/2gsQdx
	 x+DsHRbg+Iocg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net 2/6] ethtool: rss: add missing errno on RSS context delete
Date: Fri, 22 May 2026 16:06:43 -0700
Message-ID: <20260522230647.1705600-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522230647.1705600-1-kuba@kernel.org>
References: <20260522230647.1705600-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remember to set ret before jumping out if someone tries
to delete a context on a device which doesn't support
contexts.

Fixes: fbe09277fa63 ("ethtool: rss: support removing contexts via Netlink")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: gal@nvidia.com
---
 net/ethtool/rss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 8ffec9785efa..a16ee1e8e640 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -1170,8 +1170,10 @@ int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	dev = req.dev;
 	ops = dev->ethtool_ops;
 
-	if (!ops->create_rxfh_context)
+	if (!ops->create_rxfh_context) {
+		ret = -EOPNOTSUPP;
 		goto exit_free_dev;
+	}
 
 	rtnl_lock();
 	netdev_lock_ops(dev);
-- 
2.54.0

