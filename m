Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF263F0777
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404798; cv=none; b=o6T4Z6vO7iNyJYOZIVU5G86CHfgJqHIfMB+p6/PSfsPz78rI4HPYykpEdBWkDRnwPtV7YxQOZr12xLAUbHr//jq6y6yEEX7qu71DjMq+SMs+wAuZxaZ5q0P9DmlhfSOzDQk1RVikcmHCklKlbMKEfNC557ZVxfmfmF/lGJeqyn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404798; c=relaxed/simple;
	bh=kmUK4k+J33lkejqc1ZGYFBbkyqaIcvzbR2wKiTK13aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKgqPHcxzPhHkjr+Nk9LQUJGBn4LgHiequwePkLrky7whPZ4q9xPzLmUfQCTKL818NcVaGxTesYdHzHhkSlp2kO+olQf5wye4LhhhfKl5VQkKOoKfcRoTgloDpKBj3pW+q5SA77Nz7Flk+lvZxHk1gFzJ94Wx5mxu1e23e928ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=H01tqNfD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="H01tqNfD"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f7854678bso1004719f8f.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404795; x=1786009595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5p2VOIIELxz4YPcxQqWzujchMhHHNhaY5ukfxYn7+w=;
        b=H01tqNfD1C68ep/gB0Vz5PsmdC0lrVul4FqZZyveDVlOM2GBEI88DlmPCwToTrjRzR
         D+2JfmE2sR9zw16CwVnhlzcQ0aukkhmiK7bEzt4aVDXuCL+KKTXwsG9z9Ducxv7SHS9v
         uhibnE2u3M+mgmut1JJTpKHbvb3AHjtC0pkqKtKpDGdTs9D8t843DsTJPL72rMwXFSzH
         Byb7eekQOpYauPs1Uyeb3VNK4UAEbwPtqgOBriIhbNfOaMn8tVr9w/IKyLM0hyaOoKMN
         wpgJVpK5FdcsvTvpCENA1slj8f7CdqI4pb/O1YsWYzNVPY6hVIX1npC/dZdOmfo90Tk/
         Q9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404795; x=1786009595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B5p2VOIIELxz4YPcxQqWzujchMhHHNhaY5ukfxYn7+w=;
        b=aOPYVIP+amaaGr/HchA1C/vj5jcgRppXQPH3z6rBHTe4ujHHInmxEMpwn68yKOGy3m
         MznCfVtqbk+puY34k5H6fF+KgacKSxDQpF8XHbv23r9vE5k0Bnf3MCkehAF0ZBpoIXmo
         dyBVywC9e2CDk4ENL8rdAy0E3miIyuVgsErkUz8tY5rJgRE/UQpxTn1Dkkm88TmvDGqr
         SgT42Mwm3tRhUYYEiYoKshCwztppnPSF2FgNcbpGgRpZLzcwTN/mGHQLlqPu1JNpZD+C
         OM3lyePVcTheFUng5cciLJY77UezlTxpBfiYimg+DOuIvnpCMyrzrYFXNDOvg+IHBmyb
         AWLg==
X-Gm-Message-State: AOJu0YwNSHHRTgYqcWjC8k27awy/LMYFLxHH7rN2Ivsa+IY3rwGsjsVl
	v5DpmAAt66BdEubH6hYtlYCLwCTuw8lomHiHvLJh6fUDD/MbGIdnViXs7TtXCit2YYsjGfBrN37
	oV9g/avyUSTaPNhJOjzwg8h3+uRlOepNbB0ouaDcBNpewEJ8LPwP02OeodOVGasrr
X-Gm-Gg: AR+sD12nYdCwSGCStMG/0eeSGtGI0qv3qozftS5SnztxyEhnXEaWsXgk3RgBdYPaKWK
	1Dom86hsAW6q8U/iYqkrNM4Tufqa4yS2DxsFDiOr+QhQTetK8EnWZ0Q4VXKTAXBjFBOzApxK+f3
	Ef4b92y/m+dZP5aAz5T69e7OgsnXYdqv5obP+QgJKFFtYERW4mtqZ+bn0oxFOwGPAVwN+N/ShCE
	Gn0pJLvJLtIetKknXbY4gFHDiKszYWXFQ/XRShoN7O9Trc2QDUEI8hLBsTRsn896Y/MSBCEptCv
	6gAMMx9UkeH8RywDiROP9I/pdQ+6694//+N+MMMiO/9fdeET+CTVcG2sFhSIbZQm4/pBxZOYKL+
	+r3H++ZbNJh4LWB5tcp13yp2BXWv22XP2Ee2t4fCu8MySn3uR3jrtXVXelm9NuLP4dji8rNpO3K
	HDU2XCWEPa2fAJcEeP+9cZ0g59lKeiZM1egHjsUJC7LcvoWLKZYfZjFXxNzuR9b3KmkJiZPfroL
	A==
X-Received: by 2002:a05:6000:2909:b0:47d:ea8a:d224 with SMTP id ffacd0b85a97d-47fc81feb15mr2314848f8f.23.1785404795189;
        Thu, 30 Jul 2026 02:46:35 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:34 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 03/10] ovpn: skip rehash for peers already removed from by_id
Date: Thu, 30 Jul 2026 11:46:14 +0200
Message-ID: <20260730094624.4102963-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730094624.4102963-1-antonio@openvpn.net>
References: <20260730094624.4102963-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovpn_nl_peer_set_doit() resolves the target peer via
ovpn_peer_get_by_id() before taking ovpn->lock. In the window between
the lookup (which only takes a refcount) and the subsequent
spin_lock_bh(&ovpn->lock), a concurrent OVPN_CMD_PEER_DEL, keepalive
expiry, or socket teardown can take ovpn->lock first, run
ovpn_peer_remove() to unhash the peer from all four tables (by_id,
by_vpn_addr4/6, by_transp_addr) and release the lock. set_doit then
acquires ovpn->lock and calls ovpn_peer_hash_vpn_ip(), which
re-inserts the now-removed peer back into the rehashing tables.

The same race affects the float path: ovpn_peer_endpoints_update()
holds only a refcount and acquires ovpn->lock very late (after async
AEAD decrypt and a netlink notification), then rehashes the peer
in the by_transp_addr table.

The resurrected peer becomes reachable again from the RX lookup
(ovpn_peer_get_by_transp_addr) and the TX VPN-IP lookup, even though
userspace believes it is gone. Once the data-path refcount drops the
peer is freed via call_rcu while the hash entries embedded in it
remain linked, opening a UAF window.

Bail out of the rehash when hash_entry_id is unhashed, mirroring
the sentinel already used by ovpn_peer_remove() to detect the
already-removed state. The check is safe under ovpn->lock, which
serializes every mutation of hash_entry_id, and is a no-op for the
add path because ovpn_peer_add_mp() inserts hash_entry_id before
calling ovpn_peer_hash_vpn_ip().

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 73 ++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a21d02ac715e..68021c0c1783 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -297,40 +297,46 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* rehashing is required only in MP mode as P2P has one peer
 	 * only and thus there is no hashtable
 	 */
-	if (peer->ovpn->mode == OVPN_MODE_MP) {
-		spin_lock_bh(&peer->ovpn->lock);
-		spin_lock_bh(&peer->lock);
-		bind = rcu_dereference_protected(peer->bind,
-						 lockdep_is_held(&peer->lock));
-		if (unlikely(!bind)) {
-			spin_unlock_bh(&peer->lock);
-			spin_unlock_bh(&peer->ovpn->lock);
-			return;
-		}
+	if (peer->ovpn->mode != OVPN_MODE_MP)
+		return;
 
-		/* This function may be invoked concurrently, therefore another
-		 * float may have happened in parallel: perform rehashing
-		 * using the peer->bind->remote directly as key
-		 */
+	spin_lock_bh(&peer->ovpn->lock);
+	spin_lock_bh(&peer->lock);
+	bind = rcu_dereference_protected(peer->bind,
+					 lockdep_is_held(&peer->lock));
+	if (unlikely(!bind))
+		goto unlock2;
 
-		switch (bind->remote.in4.sin_family) {
-		case AF_INET:
-			salen = sizeof(*sa);
-			break;
-		case AF_INET6:
-			salen = sizeof(*sa6);
-			break;
-		}
+	/* peer may have been concurrently removed between the caller's
+	 * initial lookup and our acquisition of ovpn->lock; skip the
+	 * rehash so we don't re-insert a removed peer
+	 */
+	if (unlikely(hlist_unhashed(&peer->hash_entry_id)))
+		goto unlock2;
 
-		/* remove old hashing */
-		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
-		/* re-add with new transport address */
-		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
-					   &bind->remote, salen);
-		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
-		spin_unlock_bh(&peer->lock);
-		spin_unlock_bh(&peer->ovpn->lock);
+	/* This function may be invoked concurrently, therefore another
+	 * float may have happened in parallel: perform rehashing
+	 * using the peer->bind->remote directly as key
+	 */
+
+	switch (bind->remote.in4.sin_family) {
+	case AF_INET:
+		salen = sizeof(*sa);
+		break;
+	case AF_INET6:
+		salen = sizeof(*sa6);
+		break;
 	}
+
+	/* remove old hashing */
+	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+	/* re-add with new transport address */
+	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
+				   &bind->remote, salen);
+	hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+unlock2:
+	spin_unlock_bh(&peer->lock);
+	spin_unlock_bh(&peer->ovpn->lock);
 	return;
 unlock:
 	spin_unlock_bh(&peer->lock);
@@ -906,6 +912,13 @@ void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
 	if (peer->ovpn->mode != OVPN_MODE_MP)
 		return;
 
+	/* peer may have been concurrently removed between the caller's
+	 * initial lookup and our acquisition of ovpn->lock; skip the
+	 * rehash so we don't re-insert a removed peer
+	 */
+	if (hlist_unhashed(&peer->hash_entry_id))
+		return;
+
 	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
 		/* remove potential old hashing */
 		hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
-- 
2.54.0

