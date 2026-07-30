Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF73FA5FE
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404800; cv=none; b=o+ZhHGlY5Pkba6h0+r2BFP0zE6woWgF1YJ6TD+JuajaA/iKrL65rrDo7Du9mFAs8XmKZA1rvroId0mbcfIs6pxjcqUk94RvM7EXn3GPSlj5EsMhtwmffIHZCavFv9fXm/m4F4O78pQq4RCUHZiJADNwY597TjfdiK5eKjsX0Sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404800; c=relaxed/simple;
	bh=l03SGNDSwZrZi5eiDrPPDUpVgv0RrVfQZh7IXANUk4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezQlMHZMBS7KbxeUtm0kTXe+ichkj+LTsOUMIO8LT8T2QEFWFITS0pTX9S1MGotlL45pI0Qw+68R1JbmV7TCJWp0C5szHUxguwL8p2zVxg5zwQdZf5064WTXD5EiKB4IFYlp9H8BAAK0jAI8auAQcGJjOlplwP2f25gn2OZ+W9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EJ1HmJfJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EJ1HmJfJ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4720f3bf164so340358f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404796; x=1786009596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0dpGTLI+QILsHsiVuHfcNn7cwjsDZLrcCGv7Q1Afu4s=;
        b=EJ1HmJfJcY1vBtgRZZHP+Nr14V8tcb+pjI8e464Rk/vbNYOqMNyZ1/Fcc42qsj3GpA
         5ykKWaOC2ck3InoBqNXI+IBhXfygAMuyzqcie+MNrI8JTfWC4K0hHr8XHIQ0ZXbUkTfq
         TyN7OLrNq4u/gD2lBRQ8H8EEWtNpZnH2cgnHTqSFJnq0RBxuwoCxm62UaDpudMI8uhv6
         sE/PJShnIssT7SF0ddUnEFoergTpqHPe+8wfmUuxPdG6vMFlhu5iahdMKU7dBHUBX8r3
         vxBIZaMrBuTOvI8qWj+eL+9fu7k3kYWLrxgnjSjjvgl0jFxa4UuY5/S+yKZ2goIM8gek
         Z6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404796; x=1786009596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0dpGTLI+QILsHsiVuHfcNn7cwjsDZLrcCGv7Q1Afu4s=;
        b=KAU7eCbKIx7qIlEzp6vtYDtYj0X4Cad3Xew6/wNn5JMyfHFqiDdJF8yR7zXfV89aBa
         llr9Cjzudkz5YwpKBKvM9b7DGcpYcU1lcdlmlY1IrJtQnDvhgnFJ6LJtTNsp+uwjzmLX
         HM/tqqQFTzsl8pLvIXVEekJvMuovhHCohwjyrEIkJY/kj6VSyisBWpJ51TBboMySLRez
         zAgkEteQHrAx1t1V4DqXdqPWdQ3SYvdj5JfrPDzhU/sR/rFkCF1ASRNhO7DhzTfhMSap
         fJuq3dIurHSdssIEIeXTyXGkcvvJMpQpYQbPc/iGk4Dpeu48uSvua8s1SWTyY8VTgMtG
         j1BQ==
X-Gm-Message-State: AOJu0Yz5dgu2SlWEgDf4RuU1MV8sYiFS0lFbKodiBFhOCTX6K+5GBFgm
	H5odOo7vHn6BIqxdWGA/IAxQpt5pnkrUaj12rQ/ruM9KGXj1ku8bAmT+OLPFahZA20kaV6+5Uwd
	SAouqMPR+hzEEEhFqvSU6ecdpOYjH9Odp6RM7HICXmqWQABIW5Z2ajovco7ED2mFE
X-Gm-Gg: AR+sD10EWvgtG83g+J/PZQJyF1exerzX78BBgDLiSIr1xWoBVd8bKIwpvE4OBgQaMZC
	nQJl8p710xIjK6tURChV/THQjwCfiEsNDTUBycIRJt1SQ+Dvl/l2CbNXbDj9JOxB6rHfrfoPPtL
	LSEN3npLPmh+9eBsqRIw0TeQVMVtPwsrng/2ovYevPGHq4q8TL0KTTF4Obtzk2SqXIhCSyc2BuF
	xe/m9YjvEuj/4PNYkZrTanvyH0sNXnyNOwyVofMpGYhH7RxzLErC+uubtY7TjNpAHWR9NiK3XQg
	5ZaUvrCOsI25DgDwj9pGwJXPSoOIn+Uy16s8QaR0io+rD8aKL5DPPuMArJbUKFHEVZx4wlgGD3i
	NpEwWtTLkHnaxFtV4hCd/wzOEU9Y/Vc8OH6zGjVa+GsGoR5RKlSPVMFPqQ9SAlgaPvdYts3EoBD
	c3jcqs0pIUqTxQybQVypPzNRQ6Qz1UlqzMYglKIRdTOoqlgVNlWPChvmxRdDsbx546+dB0SK3cE
	03hUCkT3uvO
X-Received: by 2002:a05:6000:26cf:b0:47f:97f7:87dd with SMTP id ffacd0b85a97d-47fc8c18cafmr2122243f8f.25.1785404796414;
        Thu, 30 Jul 2026 02:46:36 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:35 -0700 (PDT)
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
Subject: [PATCH net 04/10] ovpn: rehash peer in by_transp_addr table on CMD_PEER_SET
Date: Thu, 30 Jul 2026 11:46:15 +0200
Message-ID: <20260730094624.4102963-5-antonio@openvpn.net>
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

When userspace updates a peer's remote endpoint via OVPN_CMD_PEER_SET,
ovpn_nl_peer_modify() installs a new ovpn_bind through
ovpn_peer_reset_sockaddr(), but ovpn_nl_peer_set_doit() only calls
ovpn_peer_hash_vpn_ip() to refresh the VPN-IP hashtables. The peer is
left in the bucket of peers->by_transp_addr corresponding to its old
remote address.

As a consequence, datagrams arriving at the UDP RX path from the newly
configured remote hash to a different slot and the lockless lookup in
ovpn_peer_get_by_transp_addr() (called from ovpn_udp_encap_recv()) does
not find the peer, until either a float event or a peer re-add fixes
the bucket.

Introduce ovpn_peer_hash_transp_addr() (modeled after
ovpn_peer_hash_vpn_ip()) and invoke it from ovpn_nl_peer_set_doit()
whenever the request carried a new remote address. The helper bails
out in P2P mode and on peers without a bind (TCP), and relies on
hlist_nulls_del_init_rcu()'s pprev==NULL short-circuit to handle the
case of an entry not currently linked in the table.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c |   6 +++
 drivers/net/ovpn/peer.c    | 105 +++++++++++++++++++++++++------------
 drivers/net/ovpn/peer.h    |   1 +
 3 files changed, 79 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4c66c1ec497e..4dad85294198 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -534,6 +534,12 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	 */
 	if (ret > 0)
 		ovpn_peer_hash_vpn_ip(peer);
+	/* if the remote endpoint was updated, the by_transp_addr hash bucket
+	 * also needs to be refreshed, otherwise incoming packets from the new
+	 * remote address would fail the lockless lookup
+	 */
+	if (attrs[OVPN_A_PEER_REMOTE_IPV4] || attrs[OVPN_A_PEER_REMOTE_IPV6])
+		ovpn_peer_hash_transp_addr(peer);
 	spin_unlock_bh(&ovpn->lock);
 	ovpn_peer_put(peer);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 68021c0c1783..a330892e82bf 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -189,6 +189,9 @@ int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
 	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
 })
 
+static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
+					 const struct ovpn_bind *bind);
+
 /**
  * ovpn_peer_endpoints_update - update remote or local endpoint for peer
  * @peer: peer to update the remote endpoint for
@@ -196,7 +199,6 @@ int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
  */
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	struct hlist_nulls_head *nhead;
 	struct sockaddr_storage ss;
 	struct sockaddr_in6 *sa6;
 	bool reset_cache = false;
@@ -295,46 +297,23 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 	ovpn_nl_peer_float_notify(peer, &ss);
 
 	/* rehashing is required only in MP mode as P2P has one peer
-	 * only and thus there is no hashtable
+	 * only and thus there is no hashtable.
+	 *
+	 * This function may be invoked concurrently, so re-read peer->bind
+	 * under the proper locks and rehash against its current value.
 	 */
 	if (peer->ovpn->mode != OVPN_MODE_MP)
 		return;
 
+	/* This function may be invoked concurrently, therefore another
+	 * float may have happened in parallel: re-acquire the locks and
+	 * rehash using the peer->bind->remote directly as key
+	 */
 	spin_lock_bh(&peer->ovpn->lock);
 	spin_lock_bh(&peer->lock);
 	bind = rcu_dereference_protected(peer->bind,
 					 lockdep_is_held(&peer->lock));
-	if (unlikely(!bind))
-		goto unlock2;
-
-	/* peer may have been concurrently removed between the caller's
-	 * initial lookup and our acquisition of ovpn->lock; skip the
-	 * rehash so we don't re-insert a removed peer
-	 */
-	if (unlikely(hlist_unhashed(&peer->hash_entry_id)))
-		goto unlock2;
-
-	/* This function may be invoked concurrently, therefore another
-	 * float may have happened in parallel: perform rehashing
-	 * using the peer->bind->remote directly as key
-	 */
-
-	switch (bind->remote.in4.sin_family) {
-	case AF_INET:
-		salen = sizeof(*sa);
-		break;
-	case AF_INET6:
-		salen = sizeof(*sa6);
-		break;
-	}
-
-	/* remove old hashing */
-	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
-	/* re-add with new transport address */
-	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
-				   &bind->remote, salen);
-	hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
-unlock2:
+	__ovpn_peer_hash_transp_addr(peer, bind);
 	spin_unlock_bh(&peer->lock);
 	spin_unlock_bh(&peer->ovpn->lock);
 	return;
@@ -902,6 +881,66 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	return match;
 }
 
+/* Move @peer to the by_transp_addr bucket matching its current bind.
+ *
+ * Caller must hold both peer->ovpn->lock and peer->lock, and must have
+ * already dereferenced a valid (non-NULL) peer->bind, passed in as @bind.
+ */
+static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
+					 const struct ovpn_bind *bind)
+{
+	struct hlist_nulls_head *nhead;
+	size_t salen;
+
+	lockdep_assert_held(&peer->ovpn->lock);
+	lockdep_assert_held(&peer->lock);
+
+	if (WARN_ON_ONCE(!bind))
+		return;
+
+	/* peer may have been concurrently removed between the caller's
+	 * initial lookup and our acquisition of ovpn->lock; skip the
+	 * rehash so we don't re-insert a removed peer
+	 */
+	if (unlikely(hlist_unhashed(&peer->hash_entry_id)))
+		return;
+
+	switch (bind->remote.in4.sin_family) {
+	case AF_INET:
+		salen = sizeof(struct sockaddr_in);
+		break;
+	case AF_INET6:
+		salen = sizeof(struct sockaddr_in6);
+		break;
+	default:
+		return;
+	}
+
+	/* remove old hashing (no-op if entry is not currently linked) */
+	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+	/* re-add with current transport address */
+	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
+				   &bind->remote, salen);
+	hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+}
+
+void ovpn_peer_hash_transp_addr(struct ovpn_peer *peer)
+{
+	struct ovpn_bind *bind;
+
+	lockdep_assert_held(&peer->ovpn->lock);
+
+	/* rehashing makes sense only in multipeer mode */
+	if (peer->ovpn->mode != OVPN_MODE_MP)
+		return;
+
+	spin_lock_bh(&peer->lock);
+	bind = rcu_dereference_protected(peer->bind,
+					 lockdep_is_held(&peer->lock));
+	__ovpn_peer_hash_transp_addr(peer, bind);
+	spin_unlock_bh(&peer->lock);
+}
+
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
 {
 	struct hlist_nulls_head *nhead;
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 86c8cffada6d..dfa5c0037e02 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -150,6 +150,7 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
 struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb);
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
+void ovpn_peer_hash_transp_addr(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
-- 
2.54.0

