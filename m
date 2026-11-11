Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392859;
	b=pyDbFPUoQFPmNaseLufBAgvh4g6cmrNIufnDbXMsPZWMY8+2E0Vi/LpeD5jOgkJ2HfVf
	 EhF8i+BO+/oyvKuJmMTF9L5WF3/uuXywzF5Cpec07TR7PEmFeX6UDcZhmAbNagqxMzS7X
	 GVDPHmLx03azoy2+18voPmgPyHrgJhksLX924OU4obqr8BjAQwwQVhSViO0bT9suMgGW2
	 mnie6QSwMLymKxopBR0WrBuLXibvPyYrNDQ4lLCnA8gbfUto62AOs3V83HBz+lOPjdE12
	 VMNA3QWHBTUTcpXdrl4do7S0KQm1LoRKJ+Zd7IoNkH8K1KgpRLgHwR+s1//eTUfQrrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392859;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HM3rz76RGIKt8dMzknvwQnTdPjRPPY5nGGIXvenUr+Y=;
	b=11ZZ6fve03qmjqhS3PKu1rK9ijKvDniK/EwBMyiad5bthL0fK1UFgEFhEYyDu3keXbhk
	 gaLZtFdjIRMJeR15TWboZ1wg+Ynb6/h+a/5C5rJV42BoUsXB6rcJusUM4MUC73/5BQTOH
	 InOuJJoOW4HjA9nlWUiUd5eMFcyvBY/bPHABB1OsAS4LNlse1Vk29CJvjjLs63/Aa5wX1
	 ttwu9IsApIB+VcvyukbATqc8UaFIchGyybPbS2nvJKk1XNEfb7in/sXpJrc0x4yGsKjv4
	 6Rw3yL1Y/2ZGBJghiDpWl9TPFLsNKRu56QVpCvMs6V5W8XPCIM1GI0FyXSqir0j0Grg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=odNvwpbf;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 17139606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17139606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=odNvwpbf
Received: from kero.packetmixer.de (p200300c59740DeD843BE7E4A980e9C65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id C58C0FA0B3;
	Wed, 11 Nov 2026 11:27:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HM3rz76RGIKt8dMzknvwQnTdPjRPPY5nGGIXvenUr+Y=;
	b=odNvwpbfWjjW8NjEAySOT1IkfC44KxDd/wDrh241C00FVX05yjV5NwTtD4HzTW1Bf9cMEj
	LVCv/dLyv4+GlPWHm9xrNyN03ggjU19QB34Mrhw6cu2YQ4wHVelvqCZQ9xs5ZyXEJ9t09F
	dAe3n4121KpFDX7x+f+J6DhpKrdEi8HU9AkKfoIKTwZVN5MgHyV1cUjIS8YmZT8n99iYFx
	DsxPZXcK1eTpRqdplk+inGiv4RbTaeb47nW30WNZXpLJ6E7e6VhCaIREf3zBQlKYfyP3Le
	7pm9JQKN3Plswg2Ljx6KLJ5idLhbFZPaYcICJ95R/7lQbC7Z3VdtE9JdTJUruA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/15] batman-adv: mcast: explicitly initialize mcast.num_want_all_rtr{4,6)
Date: Wed, 11 Nov 2026 11:27:15 +0100
Message-ID: <20261111102729.2096241-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

All mcast.num_want_all_* are initialized in batadv_mesh_init_late() - with
the exception of mcast.num_want_all_rtr4 + mcast.num_want_all_rtr6. At the
moment, it works because atomic_set just initializes it to 0 and the netdev
private data is already set to 0 before being passed to .ndo_init.

For consistency purposes, also initialize mcast.num_want_all_rtr4 +
mcast.num_want_all_rtr6 explicitly.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-9dbe5dec-31ae-49eb-838a-b4b92ced4ace
Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 1ce707aaf48a0..6ffc505ce2aba 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -833,6 +833,8 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_rtr4, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_rtr6, 0);
 	atomic_set(&bat_priv->mcast.num_no_mc_ptype_capa, 0);
 #endif
 	WRITE_ONCE(bat_priv->gw.mode, BATADV_GW_MODE_OFF);
-- 
2.47.3

