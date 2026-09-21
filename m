Received: from mail-wr2-f28.google.com (mail-wr2-f28.google.com [74.125.225.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACEA472087
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986150; cv=none; b=HwTzKV7ATN4A5+9YdgNswSN+1Y6IZLbncglOtfAWSYkLc/FWawahPAhIVLJDLrD/8HZJJpi455zSC3y58wvbmXr91QIXbnNogmKdY9oI87Ae6lXsMBX8mJq6Xloy9aMK+SJoh1b1kBb+kouLLmeFcnMXDHhttDXW0L/LQwsGeso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986150; c=relaxed/simple;
	bh=ZNM2XQERDeI2RqoHFwCDIw3T3YMY2ntyaP/+K0EAW9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTfsFTEGPARydnmgIwlL5mLd5c4AkwRlaubEaZCY9j0oZJmYQUzhExxtFzeF7oFkaQmG4OfuYlf8s5cOZSAcVreN3XO9gPfuG+nkIEPdxrZxB1Yn8ClbqQ+7zC/TJOkQUMn6YZoCvMN9gnyGT5ovV11c3NrGEQXXfh/nM/aGqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NAU+boNg; arc=none smtp.client-ip=74.125.225.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NAU+boNg"
Received: by mail-wr2-f28.google.com with SMTP id ffacd0b85a97d-485b1d2874aso2068432f8f.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986147; x=1790590947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNDLNXIHMRm1HDEavGWfH9HYDMChtC7hxnc0Jx3n384=;
        b=NAU+boNg4wWq44RQHdW7IIDKIzSbW4FeLuHzXnyZrp5R3Oy5uTzXKzHTKw1+CoHO6B
         bts2zWWMBs63+drPKr9qZUEZm7xb5w/IvmF/xsgC/4xETFksozMXfEh5OZF0cu2Df8pn
         wj0aQG+iyYB4ynBpd7BRZhs0AjhtQusCvBVLcRWJAQ87fC35N0pk08sq6YnbfMuxUJvw
         B9ZMxPAGJMhBEHJqL3VktMK+uwttolrEbSWzgOZoxb+n4OohQJuLW9GGnDEdEJnuP2ol
         lyvFkyeISiqM/UG0kAR6z9JZEpJC8Tj7KYWKJHc0hf+uhCNUnm+w+bJlC3heNS5dNxFv
         mWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986147; x=1790590947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JNDLNXIHMRm1HDEavGWfH9HYDMChtC7hxnc0Jx3n384=;
        b=BHbvDtQCFQSSEWiFD3OdIV4Star/+929GGFKyQuKD/WMeZstrV7t+fl5yTbbANg92W
         bOfYqT1fi7vGjvNNC8+Kv0FTL/9atKgqELyd+7a1AJU4mA0aM5ssK5jqDGWrfl5SgOpO
         mtx+7GgTD/zGPXgGwhT7A1RHYXgG46TQVS8N2k0V2QQX//mP+cptJFDvHZCDHy26zDd/
         jPInVk5Ih1G7T+83GB1oy3wjW0HkPNi478Q7ZtclmJf1jkjCGAtjpOHiq2Ajkbh0cDch
         hi8IMVAyvIFN0r6LFZyFA/gcwzRvVk/qZMLKJH8SNeJ46nCrbH7JxZaAjZ4pXoo/og91
         pfww==
X-Gm-Message-State: AFuF++lXiMi0e7XlQhtm0fm/D6TM7hZENzKlIDFmmBBnOB3xshefvwsI
	5vcztnOrLDI50d/1DyiI24huAwWZQV1c3SO8rc1rdUjQko+ELppSEj8FablgAe48yvKKFatGnSK
	exh47JgRzHdc2/WUwJH5CW2E6DbPIv7Tl9Wgcc5ybxAW/wKjyFc+lb6m78OBjRATKfOU=
X-Gm-Gg: AYBFou1ircD2n1Oxaw3uCXyzVWDRrIH1btIaIyVQglHizRyRkT3JsBMazwwRdmtrAO0
	2De3yeOq8URgqAv/18j1Z4ua81TL033cT4yWm2B75/fPqcCeceyKE8BCG1LhKh8dGgpQUpzWBaa
	v8/0sQTBrIg5Rr8bRx/KwdfYKCKIBjjUeq0ZgF5K16pibrxVtm6ybY6RnR1uVWop/9yxzq90rf7
	CsGIWEnu6oqa2nH4ozaxD2NaZY88Xoeb11NgRIHB6WY4pfl2/oc2f9fyGrPWyB54NyoblZVQJz1
	o+V8ekpLMv+tbtQ1pLzpkMk/vL77cOfI1eSEH0H+D6BFPw5a6jIe1Wwvt9er+Ar2QGeIov8fGeV
	QIE0iRO0kxZWQM8FPwY5Z4t9W/Qid24wXPWgz6k9R19L9H5N2SuzUAQoPSvekmJNsA5YpBFdYn4
	oGBXfWKf3oh1y9DN797IToqDWABB2jFX9Ht+oNen2gYDgs0iv/471fCzRPokMyfPZ5OQwEAyQwb
	UzStOhToTESshGJkl0nUQ==
X-Received: by 2002:a05:6000:990:b0:485:ad55:208d with SMTP id ffacd0b85a97d-4871e263f69mr22778159f8f.18.1789986146648;
        Mon, 21 Sep 2026 03:22:26 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 08/11] ovpn: reject duplicate peer VPN addresses
Date: Mon, 21 Sep 2026 12:22:09 +0200
Message-ID: <20260921102215.3599702-9-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921102215.3599702-1-antonio@openvpn.net>
References: <20260921102215.3599702-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

In MP mode, ovpn uses the peer VPN addresses as lookup keys for
selecting the peer that should receive an outgoing tunnel packet.
However, the netlink peer configuration path does not currently reject
duplicate VPN addresses.

If two peers are configured with the same VPN address, both can be
inserted in the VPN address hash table and lookups return whichever peer
is found first. This makes peer selection ambiguous and dependent on
hash insertion order.

Reject peer creation or update when the resulting VPN address is already
assigned to another peer. Ignore unspecified addresses because those are
not inserted in the VPN address hash tables.

This changes such configurations from being accepted to being rejected,
but they have never worked reliably because peer selection is ambiguous.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 37 ++++++++++++++++-----
 drivers/net/ovpn/peer.c    | 67 +++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.h    |  6 ++++
 3 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 2ba762082acc..e23f7d1f49e0 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -480,8 +480,10 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct in6_addr vpn_addr6;
+	struct in_addr vpn_addr4;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
 	u32 peer_id;
@@ -528,28 +530,47 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	rcu_read_unlock();
 
 	spin_lock_bh(&ovpn->lock);
-	ret = ovpn_nl_peer_modify(peer, info, attrs);
-	if (ret < 0) {
-		spin_unlock_bh(&ovpn->lock);
-		ovpn_peer_put(peer);
-		return ret;
+
+	/* reject peer with conflicting VPN address */
+	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
+		vpn_addr4.s_addr = nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
+		if (ovpn_peer_vpn_addr_conflict4(ovpn, peer, &vpn_addr4))
+			goto addr_conflict;
 	}
+	if (attrs[OVPN_A_PEER_VPN_IPV6]) {
+		vpn_addr6 = nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
+		if (ovpn_peer_vpn_addr_conflict6(ovpn, peer, &vpn_addr6))
+			goto addr_conflict;
+	}
+
+	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	if (ret < 0)
+		goto unlock;
 
 	/* ret == 1 means that VPN IPv4/6 has been modified and rehashing
 	 * is required
 	 */
-	if (ret > 0)
+	if (ret > 0) {
 		ovpn_peer_hash_vpn_ip(peer);
+		ret = 0;
+	}
 	/* if the remote endpoint was updated, the by_transp_addr hash bucket
 	 * also needs to be refreshed, otherwise incoming packets from the new
 	 * remote address would fail the lockless lookup
 	 */
 	if (attrs[OVPN_A_PEER_REMOTE_IPV4] || attrs[OVPN_A_PEER_REMOTE_IPV6])
 		ovpn_peer_hash_transp_addr(peer);
+
+unlock:
 	spin_unlock_bh(&ovpn->lock);
 	ovpn_peer_put(peer);
 
-	return 0;
+	return ret;
+addr_conflict:
+	NL_SET_ERR_MSG_FMT_MOD(info->extack,
+			       "VPN IP is already assigned to another peer");
+	ret = -EADDRINUSE;
+	goto unlock;
 }
 
 static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index bbd9e17fb0bf..2067825bb5b6 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -488,7 +488,7 @@ static struct ovpn_peer *ovpn_peer_get_by_vpn_addr4(struct ovpn_priv *ovpn,
  * Return: the peer if found or NULL otherwise
  */
 static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct ovpn_priv *ovpn,
-						    struct in6_addr *addr)
+						    const struct in6_addr *addr)
 {
 	struct hlist_nulls_head *nhead;
 	struct hlist_nulls_node *ntmp;
@@ -513,6 +513,64 @@ static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct ovpn_priv *ovpn,
 	return NULL;
 }
 
+/**
+ * ovpn_peer_vpn_addr_conflict4 - check if the VPN v4 address is already in use
+ * @ovpn: the openvpn instance to search
+ * @peer: peer being added or updated, or NULL
+ * @addr: VPN IPv4 address to check
+ *
+ * Check whether @addr is already assigned to another peer. @peer is ignored
+ * when found, allowing peer updates that keep an existing address.
+ * Unspecified addresses are ignored.
+ *
+ * Note: the caller must hold @ovpn->lock.
+ *
+ * Return: true on conflict, false otherwise.
+ */
+bool ovpn_peer_vpn_addr_conflict4(struct ovpn_priv *ovpn,
+				  const struct ovpn_peer *peer,
+				  const struct in_addr *addr)
+{
+	struct ovpn_peer *tmp = NULL;
+
+	lockdep_assert_held(&ovpn->lock);
+
+	/* we don't hash INADDR_ANY, no conflict in that case */
+	if (addr->s_addr != htonl(INADDR_ANY))
+		tmp = ovpn_peer_get_by_vpn_addr4(ovpn, addr->s_addr);
+
+	return tmp && tmp != peer;
+}
+
+/**
+ * ovpn_peer_vpn_addr_conflict6 - check if the VPN v6 address is already in use
+ * @ovpn: the openvpn instance to search
+ * @peer: peer being added or updated, or NULL
+ * @addr: VPN IPv6 address to check
+ *
+ * Check whether @addr is already assigned to another peer. @peer is ignored
+ * when found, allowing peer updates that keep an existing address.
+ * Unspecified addresses are ignored.
+ *
+ * Note: the caller must hold @ovpn->lock.
+ *
+ * Return: true on conflict, false otherwise.
+ */
+bool ovpn_peer_vpn_addr_conflict6(struct ovpn_priv *ovpn,
+				  const struct ovpn_peer *peer,
+				  const struct in6_addr *addr)
+{
+	struct ovpn_peer *tmp = NULL;
+
+	lockdep_assert_held(&ovpn->lock);
+
+	/* we don't hash ::, no conflict in that case */
+	if (!ipv6_addr_any(addr))
+		tmp = ovpn_peer_get_by_vpn_addr6(ovpn, addr);
+
+	return tmp && tmp != peer;
+}
+
 /**
  * ovpn_peer_transp_match - check if sockaddr and peer binding match
  * @peer: the peer to get the binding from
@@ -1040,6 +1098,13 @@ static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 		goto out;
 	}
 
+	/* reject peer with conflicting VPN address */
+	if (ovpn_peer_vpn_addr_conflict4(ovpn, NULL, &peer->vpn_addrs.ipv4) ||
+	    ovpn_peer_vpn_addr_conflict6(ovpn, NULL, &peer->vpn_addrs.ipv6)) {
+		ret = -EADDRINUSE;
+		goto out;
+	}
+
 	bind = rcu_dereference_protected(peer->bind, true);
 	/* peers connected via TCP have bind == NULL */
 	if (bind) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 063535699ecd..1879bfb76992 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -164,6 +164,12 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
 struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb);
+bool ovpn_peer_vpn_addr_conflict4(struct ovpn_priv *ovpn,
+				  const struct ovpn_peer *peer,
+				  const struct in_addr *addr);
+bool ovpn_peer_vpn_addr_conflict6(struct ovpn_priv *ovpn,
+				  const struct ovpn_peer *peer,
+				  const struct in6_addr *addr);
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 void ovpn_peer_hash_transp_addr(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
-- 
2.55.0

