Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD9481AAD
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184825; cv=none; b=MLcKA/nwwNCoC/8VwtF0GtrUJyMZ4kA5y3Rn9jgdGWSBp0r2jYJv+4Qe4Q08GWweZXoBb8aD528MIPQIL44IxhBn4iO2yTc8IjYtOP/M2YD0GO1GfbWwduSNQGLaEJBEqcVxxc/7T5EYDNYG6tbpwl5eh9K/IX4mbpup6V0ihMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184825; c=relaxed/simple;
	bh=WE/TLB9FLgxL0KILV38qriw4cQnZ2WHDh6bTrRyAPw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQpZR0dcEFI+8WtX8oGcUulG2aiuvKBaU0WiLZDmJYQ16htpzAMbg+8y7C7/YGTREAfCdLTIcqsaPbi6psPasbdG0MDZjl44TEu9guadClmWMEgemNIKRFCC3fD4sEY6nO8VicRHGSuyVXFsQyTybyRKumrqoifbXjVn5DKf9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=OduXuEYU; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="OduXuEYU"
Received: from kero.packetmixer.de (p200300C5970EeDd85F51f1FAa919d7a5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 02B10FA039;
	Mon, 31 Aug 2026 15:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx6gvnUZXx8GmIOlt/SIJMl285NPM/aaQjtCmRPzCb4=;
	b=OduXuEYUjVQH+Zfo81evgzUdLJFfvoO5es2SD0T6AkQziSLVAVvhEoREEiXrrU+ICNAI2q
	QKexYvp4akzFHMZmzVVeKeZCt/KhQTRTLo6LV+fSi3JBWfGKyu0HX64glP0ivcRi5YMNdP
	uJDWXgHX2VtAJzX3Q41mdP1h7rJpaQZhaCCfemw6ZWR5/cSdurozFFwTlPyyLTKzVmbXeH
	s3dYRYiiMGjUjLhV9AUecXpEFpimZSJTm8M6cjbNIvhhhSuk6937nJ2ErL6l0IrbnKIwc3
	3nGE/PGMdl7c91GNSIP+u0oga77IrLcGCnHRdsAzX77RBUP18jsXx5rT3qYm0Q==
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
Subject: [PATCH net-next 01/15] batman-adv: dat: fix printing of unknown 4addr subtype
Date: Mon, 31 Aug 2026 15:51:03 +0200
Message-ID: <20260831135117.574836-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

If an unknown subtype of an unicast 4addr packets was detected in
batadv_dbg_arp(), it is printing the (known) packet_type instead of the
subtype. This must be switched to the subtype to have any kind of use for
the reader of the debug message.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 011cfdc47fab4..270f8d6e29545 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -548,7 +548,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			break;
 		default:
 			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: Unknown (%u)!\n",
-				   unicast_4addr_packet->u.packet_type);
+				   unicast_4addr_packet->subtype);
 		}
 		break;
 	case BATADV_BCAST:
-- 
2.47.3

