Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF44518120;
	Mon, 21 Sep 2026 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028037; cv=none; b=ShAojwydXq+yQIE6sX10kXDYX4M0YQ7F8YaQm4Q/yv8Ox4hAu827HldbpU2otMw8j5rVgVKC9zc0JIxErCuI+FFKlClXC5QuCMH3oNNt6LFCJq9vYc143GgP9JluSmtQOlMTYsVFUCf58IZ6EgAJUVKR4AG+vvu60dNJRLQFLtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028037; c=relaxed/simple;
	bh=qz4/YYWXJpr06I59bi5sUWCWfU/oGF8IV7/SYFOgw3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQl40lDLE6v+OPD5GOE1BGojP2agqLt736OyZfWywbSUuQ0cu4SO4YQbmbdxqOmCYS/eEmNfI6xTpX05YY8Xnz4ua6pBFTqx+eMncj33JlNg06Eb43Yv5o1Aa2mNYyXUmBhFf8w00NV4dMUW7HcyBA7jAg7fSg4zWi1B5jmMML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=uIxyPS4P; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="uIxyPS4P"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9DBECC0000F3;
	Mon, 21 Sep 2026 15:00:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9DBECC0000F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790028029;
	bh=qz4/YYWXJpr06I59bi5sUWCWfU/oGF8IV7/SYFOgw3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uIxyPS4P4DR5F1mbnyWhL/jqUD6Q508fj+DRLA3Am0e6XiY5xpQF6hVCsFRLLjJt7
	 Lu7/+d8k8jX/4ISd1kVsGZL08A30x3YIRP3gr7JU0LgBARy0S2AOmHWzvzrBu3wb3g
	 ytM0mJqfQ4j4IFP1PIWDT0iMoxkJbsa7JWy7mAf8=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 47D27AE0;
	Mon, 21 Sep 2026 15:00:29 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 4/5] net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
Date: Mon, 21 Sep 2026 15:00:20 -0700
Message-Id: <20260921220021.281418-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921220021.281418-1-florian.fainelli@broadcom.com>
References: <20260921220021.281418-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcmgenet_set_mac_addr() did not check whether the provided MAC address is a
valid Ethernet address before applying it. Userspace could configure an
invalid address (such as all zeroes or a multicast address) while the
interface is down.

Add a call to is_valid_ether_addr() and return -EADDRNOTAVAIL if the MAC
address is not valid.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index bfb74dca55d6..e9d9d3d7b636 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3634,6 +3634,9 @@ static int bcmgenet_set_mac_addr(struct net_device *dev, void *p)
 	if (netif_running(dev))
 		return -EBUSY;
 
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
 	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
-- 
2.34.1

