Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30299481FA8
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184825; cv=none; b=W7R9HVJU5vj6pjbPurFfs1U/yh6afXRt5XzGiZsPdblOr1GGnf+6HLClFjiMJfbNMtMZnH6QvG59D54jcH7Q0b5rq+qzL1mFrgkepiJNDSU2m/N/zYrktNlHrPyjt+VmrUk/7b1ZEyK6dXFsScajS6zi29+Vkf2PuAp1faeUroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184825; c=relaxed/simple;
	bh=Z//WCYLXgIFjwGRoKouDyHQOJS6vseIGdRQrE3Y7yt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptc8Ia0p4h3xc9ekRmAuepbMcw8DilFB5rh8jEoMj/b2rU7px+BEJMXkDfOYgIwMS7mFNQHT+51czxGu0NzRSeRPP/yjLFcHdZ6XCrCRy8YP7d2Wo0KTjQipTC0yWHTvudAlHNJzNJ0Z7fiuucLz9w339p6hQE5NSSfAURs0k+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=BG6MOK07; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="BG6MOK07"
Received: from kero.packetmixer.de (p200300c5970eEDD85F51f1fAa919d7a5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id EC9B9FA156;
	Mon, 31 Aug 2026 15:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJI+Pl5vMT3PeoeRx+lSOsYoU3O+98uwWK2tI6SxqaE=;
	b=BG6MOK07AHvo0rVL6cFFUzaXP8SDkuYD1dFmzho1Wcg/2oAxnlXLekQv5oeMMD5BRIr2kn
	tgMK12Y0139R/6hAFjm1rSzjtr3Chpx/5lU/+BTo1EP0kDKhUwEJFul1QgLLOowez0bFpH
	7eXjQXe/ChrM+88+X7rI78QiGqsLp9ix52XyR3OKq55bXIyweHXAdbk3XSqhpCQwzP7Hb6
	n45VhttPgyvfBK3TZEkLGE7Ij3v5qUi3aWwUCi72ygHrx902hq+NOiWXHbbqal922HfREK
	Sl9jW6gP/ff0BdADfyUbQMJKCoW/bvFzVPwvD7I6iHUqrwS4Pf91/HG5HGsKYw==
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
Subject: [PATCH net-next 04/15] batman-adv: clarify cut-off in batadv_v_neigh_is_sob kernel-doc
Date: Mon, 31 Aug 2026 15:51:06 +0200
Message-ID: <20260831135117.574836-5-sw@simonwunderlich.de>
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

The neigh1 throughput must be more than 3/4 of the neigh2 throughput. Just
3/4 is not enough to return true.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 2d3045733db1d..0d0a226c3fd0c 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -519,7 +519,7 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
  * @neigh2: second neighbour to compare
  * @if_outgoing2: outgoing interface to use for @neigh2
  *
- * Return: true if the throughput of @neigh1 is at least 3/4 of the
+ * Return: true if the throughput of @neigh1 is more than 3/4 of the
  *  @neigh2 throughput
  */
 static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
-- 
2.47.3

