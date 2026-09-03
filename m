Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67231B803
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405980; cv=none; b=V4bYN/Dw+Mjx6TrrWVcoM9FbXERgHCcdCMrF0+vlujh7DOxz0T+J5gpfc0wDBzYIvXmCHUUgFjnKJ5ZJVFjrtf+vruxxtWPTnwYhjW6mZxq3et9utCUk97gpoGDTxoAyPY9wssUHOh1kp8Re4W2zM0J8wNGtPrPAi7X+EMc0AoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405980; c=relaxed/simple;
	bh=9ESvqYXR3bkebbJSmiGdVMtsCN0wvSNtmzI/J9fYOjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5CgZdzzohDflKb/lJctkkaAroBhMYuEeEozjb9POO0y/6XmFWQ/wavo51m7i/Azx3927SdYxRmwUWrUGFo/hQLj6e1RGM4DjHtTqG09MC/+oIpIeEy/WkqjePpSRkNGF/v4Yx4KkfY4AysGmHkS5hFC9bzJHkHOACD5Es2iO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIS5fMOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIS5fMOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEB81F00A3A;
	Thu,  3 Sep 2026 03:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788405979;
	bh=EUEIgiw5oOjOAmkN39Lq75vQvEhNhpr9ZUmsYs/MymU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cIS5fMOunIq2Od9E2c3GSvByfA9CMRxYyB0Xd3/tl1v06RqjCEHY4KIr8px9Bh56X
	 EKiYLx5mFmKRxPHhJfxdlACEZSydpn03a750lu5jVfYVl9+1Vwvox4D/bqbH7U7aYc
	 vStBkbHqeHpSQTsSI14k5di2FFgr9eNxjX36LtiRAmesOsq73hrd29DAE7gpED0JRN
	 4krv+vTOkm2JqgVskCXUm3EJ4ZRnYYBKISCJJjdbwcE+wzcyrfdaEPJNi4NGfKdlet
	 ITTn3pOfDrwa8q6CdiFoSZ97gS7P2mKbJi0dHiapTGQBnkTezg2HjbtZ3H/UZx/UYY
	 w1vmSNdP7Y1Xg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/5] net: dsa: bcm_sf2: bound the CFP rule dump by the caller's buffer size
Date: Wed,  2 Sep 2026 20:26:07 -0700
Message-ID: <20260903032611.3000029-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903032611.3000029-1-kuba@kernel.org>
References: <20260903032611.3000029-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm_sf2_cfp_rule_get_all() walks the whole cfp.unique bitmap into
rule_locs[] without consulting nfc->rule_cnt, which is how many entries
the caller had room for.  ETHTOOL_GRXCLSRLALL requires no CAP_NET_ADMIN
and the ioctl sizes the buffer from the rule_cnt userspace passes in, so
once an admin has installed CFP rules any user can ask for fewer slots
than there are rules and run off the end of the allocation.  A rule_cnt
of 0 leaves the buffer pointer NULL and the walk dereferences it.

Fixes: 7318166cacad ("net: dsa: bcm_sf2: Add support for ethtool::rxnfc")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: florian.fainelli@broadcom.com
CC: jonas.gorski@gmail.com
CC: andrew@lunn.ch
CC: olteanv@gmail.com
---
 drivers/net/dsa/bcm_sf2_cfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/bcm_sf2_cfp.c b/drivers/net/dsa/bcm_sf2_cfp.c
index 50d3a818eb1b..84a086c3e99b 100644
--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -1088,6 +1088,8 @@ static int bcm_sf2_cfp_rule_get_all(struct bcm_sf2_priv *priv,
 	unsigned int index = 1, rules_cnt = 0;
 
 	for_each_set_bit_from(index, priv->cfp.unique, priv->num_cfp_rules) {
+		if (rules_cnt == nfc->rule_cnt)
+			return -EMSGSIZE;
 		rule_locs[rules_cnt] = index;
 		rules_cnt++;
 	}
-- 
2.55.0

