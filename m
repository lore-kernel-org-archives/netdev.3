Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63283EF0BE
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404803; cv=none; b=q+CQCDR3evbCYILyKc/wTJUjRUVvSJJv2VdPxHfus33ZwxhiREU9MhcGQd8cRBX6DDOtJrounz1bqt51j+WdAiwWDszbOoTskg1pD4LAr0hRvIN+x6hjILm/3LM98cxaxz1VhLPr5N/oOmcD2siTm0Sj5/XMXMquBtWoKADb8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404803; c=relaxed/simple;
	bh=+hgjuQxYjtpMcz1724rJk6IMgsFRpN9qcGZucHANgfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsF32j8IgPXRcQEaNaoseXjaYyH290uuny+7RNjGOuk+a8HKRYpRHmkPxS5L1WXBVVnD5hXmnneDmWCQQI+g5CGjc+cwVWZ+y1FORIVW4do12S8kw+ugmHSfW5BWyB0XKYSognZAmE9LDSZyxVDT5t1r5i4m4W1eCkswfsJpX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SC+3crlr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SC+3crlr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49550ec592cso3380205e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404800; x=1786009600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=exwyRCNIuy6jX+FdD74F/gPpn33rwn1G1FPHjnGrbrI=;
        b=SC+3crlrKrU72P2WEBDWZ6eunRLhyHnAnxTA0LsAqrevlq34C6xaDkprxTaznJirao
         Z952akjuKpt1ySyoegw2e9kAQuqWcszXareAua5oHRxl0Rrv4XTzSdrsry0/N5NJ4ZAm
         G1OuVB2t+ce8bqX3WvrBfWe2JEJ3SIEpB8L7sDKtfbt7T60VqHIOHK1YnUxZT7ujiqWG
         vDiWpivKfsLwPLxsI0hp5DLxYlD7TInAIyak07J3luARc5kM0xdrWjITIAjKU0zPaHmT
         3GnaGgfPJQ8RX/sBLEMWyUbVp0LVX5+aO4mQ4jTotDmHxF8wUYulMBYFeJNw45hukSZd
         HNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404800; x=1786009600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=exwyRCNIuy6jX+FdD74F/gPpn33rwn1G1FPHjnGrbrI=;
        b=EXGB2cfjEdQSsnNKsSdz+MQkXf+GesD8IBnf86NPeJfU1a7lQJ4/VVzW+X8lQfTAlE
         65LbkQWEsSw+hWUWQjFPavpaVRGNpXNlAXO+Nco0wVbGeXzUQKFg+V6qJIJwEYcbYBqy
         9xtrhGNm+KKHSsDi4QKQmzwCqkiUlYlLio8r0zK2LVkulejm8gYt18LNj06mladJKIkK
         usaDWbN6UPxwrNCxVX3PU1ZHCzX8xXvcEBghZ8c1V8UPd2fj8bvo2MlxavOJk9slHW2t
         eMrbfoYD5kJppgwkMCWBklGEz0JAWmGllg1uNUpOgeQ8qBWDhtET/GEydkihrqnaeizi
         eeCg==
X-Gm-Message-State: AOJu0YwBnP7Q+6BC1X26NexqPNnNmV7V/+w01tqFVeqWT3gRk9quJYi1
	M7s1VAF8CuHhqi7j/B/unf7UrTWsh6z52mZP0NRovWOfzBrvBJf2JcYt7uO4fowuKmKT0pgbG6H
	8gi4dBnef2BHl21bnv6faLvMXivLvgTRttXvb9Bs3ZjSY+uHDKzofEvB7OvlwyDUA
X-Gm-Gg: AR+sD12zPo/sfFKW+wemtk1yexR1z987kWan8wPyKLJSjDdoMBX88Uws8yrgjOfO43/
	mCriKqr5zzmzBiL+ulCGRXOAXnt4wuFrf0MR8KlrCRRK1zsWPu7/E+t0CLpuYeRabkovA+nVaew
	+NEQaC+ivwOGmLBrBi+FqtuRc1tRzUwbqKm6u1vCuYQOFXf8W9T1u11JxN6o5bFWp/60m3hDS+c
	jyDX2J4y8gtFOSvhETW7AL00v6j/QDpIZuInjKaiA6OuLgcKIUntR5X71OfpkblfNpYiozHfHVM
	z42G5Ox1arUuhIGpsXg1QFzcehItgjVnkz+A1fgEmbTioL7Vkmyd4x0y0GGzvXLrtNFvFWHovKI
	kUf5pd4TAK/mDs5aMExwdeCcdsJ8mlhTPYo18Fa7BAlX0mwxP0Odki+uWCI563nwtilBsENIsHC
	8YZYW+87FLXZICPtA5a97ARSsMd5SdOqgGePbLHGVatm6VsvGMhg393c8Bfda6eyYMr4a7EerWK
	w==
X-Received: by 2002:a05:600c:4e16:b0:495:7aaf:77b with SMTP id 5b1f17b1804b1-49801e83788mr22479315e9.0.1785404799690;
        Thu, 30 Jul 2026 02:46:39 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:39 -0700 (PDT)
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
Subject: [PATCH net 07/10] ovpn: hash floated peer by transport identity only
Date: Thu, 30 Jul 2026 11:46:18 +0200
Message-ID: <20260730094624.4102963-8-antonio@openvpn.net>
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

The by_transp_addr table is keyed on the peer's remote transport
address, but the float rehash hashed bind->remote directly, while the
two other sites that touch the table build a clean key first:
ovpn_peer_add_mp() and the lookup in ovpn_peer_get_by_transp_addr()
both hash a sockaddr holding only family/address/port.

For a link-local IPv6 peer, bind->remote carries sin6_scope_id (set
from ipv6_iface_scope_id() when the endpoint is learned), and that
field is folded into the jhash() over sizeof(struct sockaddr_in6).
The lookup never sets sin6_scope_id, so after such a peer floats it is
rehashed into a scope_id-dependent bucket that lookups (scope_id 0)
never visit, making the peer unreachable through the by_transp_addr
fallback. ovpn_peer_transp_match() only compares address and port, so
the hash was keying on a field the match ignores.

sin6_scope_id must stay in bind->remote because the TX path uses it as
flowi6_oif, so it cannot just be cleared there. Instead build the hash
key from family/address/port only, exactly like ovpn_peer_add_mp() and
the lookup, so all three sites agree on the bucket.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 33fb0a75e600..eada414a9d92 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -904,7 +904,10 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
 					 const struct ovpn_bind *bind)
 {
+	struct sockaddr_storage sa = {};
 	struct hlist_nulls_head *nhead;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
 	size_t salen;
 
 	lockdep_assert_held(&peer->ovpn->lock);
@@ -920,12 +923,26 @@ static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
 	if (unlikely(hlist_unhashed(&peer->hash_entry_id)))
 		return;
 
+	/* Build the hash key from the transport identity only
+	 * (family/address/port), matching ovpn_peer_add_mp() and the lookup
+	 * in ovpn_peer_get_by_transp_addr(). Hashing bind->remote directly
+	 * would fold in sin6_scope_id (set on the float path but never by the
+	 * lookup), scattering the peer into a bucket lookups cannot reach.
+	 */
 	switch (bind->remote.in4.sin_family) {
 	case AF_INET:
-		salen = sizeof(struct sockaddr_in);
+		sa4 = (struct sockaddr_in *)&sa;
+		sa4->sin_family = AF_INET;
+		sa4->sin_addr.s_addr = bind->remote.in4.sin_addr.s_addr;
+		sa4->sin_port = bind->remote.in4.sin_port;
+		salen = sizeof(*sa4);
 		break;
 	case AF_INET6:
-		salen = sizeof(struct sockaddr_in6);
+		sa6 = (struct sockaddr_in6 *)&sa;
+		sa6->sin6_family = AF_INET6;
+		sa6->sin6_addr = bind->remote.in6.sin6_addr;
+		sa6->sin6_port = bind->remote.in6.sin6_port;
+		salen = sizeof(*sa6);
 		break;
 	default:
 		return;
@@ -934,8 +951,8 @@ static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
 	/* remove old hashing (no-op if entry is not currently linked) */
 	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
 	/* re-add with current transport address */
-	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
-				   &bind->remote, salen);
+	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr, &sa,
+				   salen);
 	hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
 }
 
-- 
2.54.0

