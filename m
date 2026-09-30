Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C633B52F8
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761574; cv=none; b=G0EEw6/rOszb7vGnh/qgrrXGuLo3QGT/+GvETRDG0gJ/nghLv+xPQtp6xPHK4i1NHooGRWn2XuHF/0DJcdJQddniipIb/yy1mKsX1PdU6pb5tDIPRRdwhASX4kvZw1U5btpnd0vI8PUlS80fNxgeURlhKww2+fTyDEN2iLeIshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761574; c=relaxed/simple;
	bh=7U/wM99SBCBUj+kpAiJ/C1HWILsi5JUjpBfJarLFJ/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUpElZ8NCXAs5h4jv85PNDfemLjFDP8UNIqtmCJzSXg8hSfO/kKxU7fk05oYQAmU2V1Tbk2Rtc2gCMjXsGqOaqu1ct9fwpLsJaTH1MVOVs0ujnEw7ocuQ959dfJpfdf3nY6YgCbr0TkRr+ngJ72ZVV9JoKi6LdN90QT1mTIa5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=SlwAloLJ; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="SlwAloLJ"
Received: from kero.packetmixer.de (p200300C5970E81D8CF20e45A7328D917.dip0.t-ipconnect.de [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 23F6DFA25F;
	Wed, 30 Sep 2026 11:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68IkPJweZg8/k7TcmtLrKImW+zdIpL2mCpk79RpO984=;
	b=SlwAloLJMbYNQ72Wisnmrqco7kUvvl0kKXBJ6ZZUjT3l0oGI/85X4YYrJFUtvTVvpHVDxm
	vPQlk0hHKNcq57joL6hOovC0PPYXLONo1MgZuQzl1UcvSaBK4aGwkPL7+YNN7f6UuU232l
	V55npDKVE9isY/aCei/q6o1w7m7dz0BXpRNme3HwHUPNkFCWoASIi/hW+wv7vR2w1J/OIo
	36QPDyeVOPWWXsFl2fIDGwzNFTTuDbSiJePo/8eSTgRad6YhFCkjv7zzzWTc1sv2s+yoA1
	GUdw7KZLt1FRpd6o2ty1MvSg/ATUDwwVKnvAx2XHapxve/QGTz9LdVcGvqJxwQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Peng Fan <peng.fan@nxp.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 9/9] batman-adv: use assign_bit() where applicable
Date: Wed, 30 Sep 2026 11:45:58 +0200
Message-ID: <20260930094558.3723766-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit the assign_bit API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a4be5b2a87d7a..74050bffedbce 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -863,10 +863,8 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					   u8 flags,
 					   void *tvlv_value, u16 tvlv_value_len)
 {
-	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
-		clear_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
-	else
-		set_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
+	assign_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities,
+		   !(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND));
 }
 
 /**
-- 
2.47.3

