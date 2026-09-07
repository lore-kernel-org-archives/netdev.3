Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D27425872
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769124; cv=none; b=KAXMeVSBPcFZ6WWqLIYLLbHIUFY/GIDI85R06ExV+uwPoW0AtnuxkIROhz6ljMJ4rX1OZXHPuz8SNLB2CcxRritk5H9BPRqXzZ8aSNBl7L7jtF5o75Qk29AEB4n14bSuW/iIzWktyDXFgZBxeRtYnSgTELWGW4UQJIAWc5j+1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769124; c=relaxed/simple;
	bh=pkHDBGdfac3h81xfv4nuiMXGWtSGmpbig7FTF8dYxME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX7LsZlsarjn6G7Y0VOwNXi7QJ1BI+hm4vJ8nmXVK+rfBbdQxvjxZesb0X6yFgA264Dlvyx/o8NBpIYRE7J8E/KJ+5PDzb1Ji1SioC3nBxy1hfSvhwOPC+ciMU5v4gFeiVcakB7Yyqz3GB7oooS0AlVYkyqXmIvbSpaUWYn1hxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=y8ksAf+V; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="y8ksAf+V"
Received: from kero.packetmixer.de (p200300C59748d0D8c3747188e6dFe6C0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 8A0D1FA2C4;
	Mon, 07 Sep 2026 10:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx42SSP6TSVRnmDAWlf0ao23yIX26HwAK66gY1duE24=;
	b=y8ksAf+V/38C4w/h24eNIVmM1mj6SR5BAg1aibuXt26pb/UWrTEi/rKfpChv+GBHefSB28
	+x9NblYEpO/dCMTyRrqBGYy3Dzil3jh3F8RYRu3Sht7jOB1URIubsQyl9l5rmdI0jSyVxp
	upSHq5tdWT9cx+pGVUD5cPgf7nuPGuKgUUzhLV9otYUfGOf+q6QPsOJ4r2R7Vq+8OL1+BU
	OQBrzAAr439S1UXqPFmI6um0QFHGTsVqFxOcq9OoGj48xvVRKsyfL7HkDAnzGrR6qiyke3
	S9HP8cuI/cF+5Fz2EH4PxBkZVPkp7ZdmATeLH4FtPt0jWX4xBM26aLN+wo25YQ==
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
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 15/15] batman-adv: correct batadv_hash_remove kdoc return type
Date: Mon,  7 Sep 2026 10:18:24 +0200
Message-ID: <20260907081824.2474040-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

Not the data is returned after a batadv_hash_remove() but the pointer to
the hlist_node which was used to look up the entry in the hash.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=8
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index e67afe01304ce..45a432cc15789 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -137,7 +137,7 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
  * data could be the structure you use with just the key filled, we just need
  * the key for comparing.
  *
- * Return: returns pointer to data on success, so you can remove the used
+ * Return: returns pointer to hlist_node on success, so you can remove the used
  * structure yourself, or NULL on error
  */
 static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
-- 
2.47.3

