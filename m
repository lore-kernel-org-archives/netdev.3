Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B123ABA8
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491605; cv=none; b=XSrFVwWHHQF6l2lMX/5LiqClYCTmDwo/aaHWc0EFNHOq2OgeNDzQpS05oEYMZCLU0gzoC22x8AdBSVUhkvoKjm+mt59z656xYn+doeZcgl0u70S2sdUnUuNbOA+S5B0Tf05OzMO+B5Ru2n/rXM/Ha0Dlp8jkVlqwLjB6/jQ0cUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491605; c=relaxed/simple;
	bh=abXX7AXHW6QaogY51ksdN7xygCujEszt7GE0X+z74SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8AkSze1q6UcIXfgkHhqB0Xnwq2FZ7OTdGkWYPj2YwCK/Qzo73k6cJHz5Mp6y0SD9pOXD/RN4r5iidhi1H8JCFLkH/bTgVIHz6VTSrH0NiFqzsPskMi8o1FBEd6hx+1kDwqsslk7WwBZ3KIcVb1cqZCmjS8bUg0mTJo/mmN2LSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQhKkhpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQhKkhpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A52B1F00A3F;
	Fri, 22 May 2026 23:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491604;
	bh=y+36ZqKniXdxOxZDU6nFoLdq9vRCZU8TV8XqVrBc5K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VQhKkhpuYGkjgFvlDVpzUqnUWJuxugnTpoL0qO09QYi7pwOy4IB216tCbDngBStxC
	 x2j24b5N2Bs3kjCMNyOMwAeoJz3+Mbs8vFbJB1v4yvUonRHRYtGkc8mdvnfYbSaSCq
	 Ow4nCWpvToiPlFIyy6CiSDeuUxtAr+MGwWadfKceue56XQYUIyP0QMVr+i6Sb65l+c
	 83UcOegiElGxPTpibhFRN0TGyBUsYBzhIkeCyW6VnUnANtu6UPpnCBsk8wPiEFM5+w
	 AQn/aLo5mY7q0S219s8QLswgvreLvx9rHHCjSdlhg6370igFyBR+3Ocy+HDbheZ04G
	 py+LgUpTBD2OQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	petrm@nvidia.com,
	o.rempel@pengutronix.de,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	kees@kernel.org
Subject: [PATCH net 1/9] ethtool: module: call ethnl_ops_complete() on module flash errors
Date: Fri, 22 May 2026 16:13:04 -0700
Message-ID: <20260522231312.1710836-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522231312.1710836-1-kuba@kernel.org>
References: <20260522231312.1710836-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When validate() fails we are skipping over ethnl_ops_complete()
even tho we already called ethnl_ops_begin().

Fixes: 32b4c8b53ee7 ("ethtool: Add ability to flash transceiver modules' firmware")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: kees@kernel.org
CC: maxime.chevallier@bootlin.com
CC: petrm@nvidia.com
CC: danieller@nvidia.com
---
 net/ethtool/module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index cad2eb25b5a4..741f6fb25d45 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -427,10 +427,11 @@ int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
 
 	ret = ethnl_module_fw_flash_validate(dev, info->extack);
 	if (ret < 0)
-		goto out_unlock;
+		goto out_complete;
 
 	ret = module_flash_fw(dev, tb, skb, info);
 
+out_complete:
 	ethnl_ops_complete(dev);
 
 out_unlock:
-- 
2.54.0

