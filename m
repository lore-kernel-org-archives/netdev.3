Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567842885A
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757624; cv=none; b=T8ToI9pd66LPFZT9NUGBRn3dwNlE3Cj76SYATxjRJTqD2CWsMcCRDhzjB3BB8FUG+PPBSXb1+VKIq1eYz7KpKu1JrIMSlsWK78FTjlZoYJDcqTIsTiCs4jq8Fwlb30qbywyUfLELzLXkLC64tu+FtXu6RqiySRCR2p1tGMdh+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757624; c=relaxed/simple;
	bh=UCvpZy6ypCbpO8JoWwFrjxqkvOCtR3ebHIiAmH0D8lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHQzu2CQbrj5qBKcsVpz628JQhpJWPZ2HLJh56eFV+/GstJgF2D+YiE7zS/XSQ/UFBzegKf30FYgntkjbiRkvjzoJxIgdKBOrVR8+KlCVsIOa69bnCKmrdMDucdHOnzkMV75/4M9Xm/H1uVAzo4D/Aph6Ipuv7idqc6BA3QyA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeUgs9qt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeUgs9qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBDC1F00899;
	Fri, 18 Sep 2026 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757610;
	bh=p8doxsjIXdfMXZjGBeVDR1SEw0Ipw6oSBAsBw3BOdhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UeUgs9qtwgiWgROmuVTduoWOYjdTem0+c1mdoZZkihbJc4sD8k9l7wQQIRs9e10cG
	 4kdVSPNd5OKxRsokEd6BfJBZZLQUGfZCXeOAIvMCZNTXb3N3Gu34viVGgAp8gzW41L
	 ak+YwvtwCVE6K1A15BfFL3Odx09+aDpVs4JcKER4dsrWex0N6DYKJ5rWxM1axJnRNT
	 41zqGeuC8kvepLFOyv7WzUVwKRi9ckV/fwojHLY2mKGZj1WVvZzGQrWRuQpRYOXkG2
	 8ageoIpXxx1xpgJWNqAFMcpEgDwVxJ6nuqmiuqHBuv7dVwxn3tQotPtt8QI7kiS+/r
	 ZqX5hu6rRxy0A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	olteanv@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	vivien.didelot@gmail.com
Subject: [PATCH net-next 1/2] net: dsa: mv88e6xxx: check the port when reading back a policy rule
Date: Fri, 18 Sep 2026 11:53:25 -0700
Message-ID: <20260918185326.3940857-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918185326.3940857-1-kuba@kernel.org>
References: <20260918185326.3940857-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chip->policies is one IDR for the whole switch, so the location an
ETHTOOL_GRXCLSRULE caller supplies can name a rule belonging to any port.
mv88e6xxx_get_rxnfc() copies it out without looking at policy->port, which
lets a user on one user port read the MAC address and VID of a policy an
admin installed on another.  ETHTOOL_GRXCLSRULE needs no CAP_NET_ADMIN.

The GRXCLSRLCNT and GRXCLSRLALL arms of the same switch statement already
filter on policy->port, which makes the GRXCLSRULE omission look
unintentional. Nonetheless, changing this does carry some regression
risk.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: olteanv@gmail.com
CC: f.fainelli@gmail.com
CC: vivien.didelot@gmail.com
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 7f68a0c55802..daef7c78b860 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2457,7 +2457,7 @@ static int mv88e6xxx_get_rxnfc(struct dsa_switch *ds, int port,
 	case ETHTOOL_GRXCLSRULE:
 		err = -ENOENT;
 		policy = idr_find(&chip->policies, fs->location);
-		if (policy) {
+		if (policy && policy->port == port) {
 			memcpy(fs, &policy->fs, sizeof(*fs));
 			err = 0;
 		}
-- 
2.55.0

