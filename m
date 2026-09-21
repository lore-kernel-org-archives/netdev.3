Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676CF47044C
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986148; cv=none; b=qtXahKR2wAXFcyeJFgdhk6pLN1bBZHQ493wRATTzG7/XYMPLJH3semAeYnOlWzY00grOZ/vkx/iDAA3AMMV1jBgugCj97BEcjOFH8r1AC01y82hZxymuKE5It+lYJK5YA+KkHy7zmyawuvj6ti45i0AZOpCe5mGBOWIWA/FPRzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986148; c=relaxed/simple;
	bh=Qu+eU8Sua2dxLw88XNNDejaHPPc96Fv93k4F7/Cr2ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9W209z6G+Mly3swep1qG4EvU7kEpwXEHgk+Q9ZMzdi8Ix25bWbzxaa12Y10MgSu+s70XwO8O/vAuh3LfiU4OtS+v7hr9G078Lsy62GoxjWbSpKjLpNYPevoEy65BrX/3hdK3SGx1zIMsgFqSFze0KQrdvmsJMRYoJs4zXhjLB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Inj6bjWx; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Inj6bjWx"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so19108155e9.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986144; x=1790590944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gG2eUzbutPnDE7dtjKcwke5EFlyLZ9q322o1mX80B7M=;
        b=Inj6bjWxDXmRvTTRUO/sEDaamMBRRuJU1ac0m1YtVJjx2tstXXg1fP/pIXD/stxH17
         N0BXcJ/UI6Y2ieaGaHZAwf6kQEWjIyQi4DcVCck/bxxTDTxA+LCISvvclVmPrOMVDJlv
         8pqs6czLU+YZ8QMtCSpl3g5vTDC4nGVOB6LYBRVmEloPIv9fqgReI3R4hPPF9I48mvB+
         wKu8hIM7PEUj/UbB15lvlA+3+Q+ZHwvi7b0bf8UcXEsL4BNdbY+xCDHebpQKoi8pcuPZ
         lfPWOOeSCFGaZqc7eubrXohEnyUhrbBS9n1FHZouB3/xFzQS8z5noZiBILIuAF1AzA7q
         GAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986144; x=1790590944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gG2eUzbutPnDE7dtjKcwke5EFlyLZ9q322o1mX80B7M=;
        b=GAjxy0znSehwwaJOLlwyFynbveeO6HYFs9/EScXFGMsHpLVpsUDLTWZPk1JTFqtAwk
         /9z1DCcnHTVN9wTeMJKDAMij6FHkPc8/tNceZedIKsSkBxtCnecb1jM9OBk6YyiqwqfL
         Pq6furQREXv5VcXNlJkdP5r2MrKJgSHWSeCRDmBkjZHy3UZKTN5uz1Ic/VgwwpV4RXcU
         Ciuv5iJ06AqCLM+xj/04PlVDhda/20WIoLBh7GOziZnuGoLQ8BYKe9FUH9EKOK3th9xY
         MqXriZrrMCslNyCyoEWaoAyLHyMoh6IeronY/GzPpujdyILb1ILkNvoi/0utJRJj75gS
         SZSg==
X-Gm-Message-State: AFuF++nqgXwkLfpQUoodSRqZphJVyTJCy3yuCGYauCquAZZqENPX/+PN
	c0PtkQI4QT2rHorFbXfra40taKTNEMHyxIBelVQPADKZcFNGbJ42g3E5HecL2ppy0ArIRsXt6zP
	sRcONsfHHB/kodPLaa7bxkERnIEaaRhI/i6HXe/l2rf7GsCFSbdpha2xlym5IaEXfAM8=
X-Gm-Gg: AYBFou10RzyA51j4z7Qor45vpzpHHY+kr3d/ZbaskJ9jJX5ox6N2bWiduBf9iO5e0xi
	vCTFCKkvlqt17CP8MuWpniKIxvRGrNM/cOlLon06WWopQitoJKn3zCq5LaDj4lO70V9OR3z/+FM
	3jL3OuuCsGFGILLPamiLf7LITgrczQSREB7PTzqoDxq36pT375XPP9YY2fwTkWwPC1GzlkprnIb
	qnMEPwlC6pfOkLANO9KFOkPheDH+izAPtO2ErCvmI9YIpVlxrYM2WGLIrbydRLUV9peJ7KvB4AB
	HeIFYlt6Y+JJ+azmS3znmrwJr0bZOa0JmupfqNxyrA6fuPEfRb7GMObuUPU3m1jnYw7fF1MnTed
	CKogasevaWWmghZZFTZ8KpaYkbrPhpWApu9fR5pnQj8kXJOiXvo2H2RQiS50l6uideT9vZnV626
	OWvy4Qm4jsPmcvIwzCjN8Ozw4HtSHEP5MlD2OKXNykuEg92kfy8k+e5RycX/FdwkB/E5sCR8lJ1
	D2hSVOHzwU=
X-Received: by 2002:a05:600d:1b:b0:49f:ce72:e930 with SMTP id 5b1f17b1804b1-49fce72e992mr77406655e9.34.1789986144552;
        Mon, 21 Sep 2026 03:22:24 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:24 -0700 (PDT)
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
Subject: [PATCH net 06/11] ovpn: replace bind when clearing stale local source
Date: Mon, 21 Sep 2026 12:22:07 +0200
Message-ID: <20260921102215.3599702-7-antonio@openvpn.net>
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

The UDP output fallback clears bind->local in place when the remembered
source address is no longer usable. The bind is RCU-published and read
locklessly by concurrent TX, so an IPv6 reader can observe a torn
address.

Retry the route lookup with source address autoselection without
modifying the bind. After a successful lookup, revalidate the bind and
route key under peer->lock, reset the dst cache, and best-effort publish
a replacement bind with a wildcard local address.

Do not cache the resolved dst when clearing the local source. Replacing
the source invalidates all per-CPU cache entries, while
dst_cache_set_ip4 and dst_cache_set_ip6 update only the current CPU
slot. The current packet can still use the resolved route; if bind
allocation fails, a later cache miss retries the repair.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 81 +++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index eeef4a7229f5..055cdb1bee13 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -185,7 +185,7 @@ static void ovpn_dst_cache_check_key(struct ovpn_peer *peer,
  * to detect whether the bind was replaced while the route lookup was running.
  *
  * Return: true if the lookup result still matches the current peer state and
- * may update the dst cache.
+ * may update the dst cache or replace the bind.
  */
 static bool ovpn_dst_cache_current(const struct ovpn_peer *peer,
 				   const struct ovpn_bind *bind,
@@ -218,6 +218,9 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct sk_buff *skb,
 			    const struct ovpn_route_key *key)
 {
+	struct sockaddr_storage remote;
+	struct in_addr local = {};
+	bool reset_local = false;
 	struct rtable *rt;
 	struct flowi4 fl = {
 		.saddr = bind->local.ipv4.s_addr,
@@ -236,24 +239,17 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
 	if (fl.saddr && unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0,
 						    fl.saddr, RT_SCOPE_HOST))) {
-		/* we may end up here when the cached address is not usable
-		 * anymore. In this case we reset address/cache and perform a
-		 * new look up
+		/* The learned local address is not usable anymore.
+		 * Retry with source address autoselection.
 		 */
 		fl.saddr = 0;
-		spin_lock_bh(&peer->lock);
-		bind->local.ipv4.s_addr = 0;
-		spin_unlock_bh(&peer->lock);
-		dst_cache_reset(cache);
+		reset_local = true;
 	}
 
 	rt = ip_route_output_flow(sock_net(sk), &fl, sk);
 	if (IS_ERR(rt) && PTR_ERR(rt) == -EINVAL) {
 		fl.saddr = 0;
-		spin_lock_bh(&peer->lock);
-		bind->local.ipv4.s_addr = 0;
-		spin_unlock_bh(&peer->lock);
-		dst_cache_reset(cache);
+		reset_local = true;
 
 		rt = ip_route_output_flow(sock_net(sk), &fl, sk);
 	}
@@ -267,10 +263,28 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		goto err;
 	}
 
-	/* avoid storing a stale cache */
+	/* avoid storing a stale cache or local address */
 	spin_lock_bh(&peer->lock);
-	if (likely(ovpn_dst_cache_current(peer, bind, key)))
-		dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	if (likely(ovpn_dst_cache_current(peer, bind, key))) {
+		if (!reset_local) {
+			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+			spin_unlock_bh(&peer->lock);
+			goto transmit;
+		}
+
+		/* invalidate per-CPU dst entries that may still carry
+		 * the stale source
+		 */
+		dst_cache_reset(cache);
+
+		/* preserve the current remote */
+		memcpy(&remote, &bind->remote, sizeof(struct sockaddr_in));
+		/* The current packet already has a valid wildcard-source route.
+		 * If replacing the bind fails, leave the stale local in place;
+		 * a later cache miss will retry the repair.
+		 */
+		ovpn_peer_reset_sockaddr(peer, &remote, &local);
+	}
 	spin_unlock_bh(&peer->lock);
 
 transmit:
@@ -300,6 +314,9 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct sk_buff *skb,
 			    const struct ovpn_route_key *key)
 {
+	struct in6_addr local = in6addr_any;
+	struct sockaddr_storage remote;
+	bool reset_local = false;
 	struct dst_entry *dst;
 	int ret;
 
@@ -320,15 +337,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
 	if (!ipv6_addr_any(&fl.saddr) &&
 	    unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
-		/* we may end up here when the cached address is not usable
-		 * anymore. In this case we reset address/cache and perform a
-		 * new look up
+		/* The learned local address is not usable anymore.
+		 * Retry with source address autoselection.
 		 */
 		fl.saddr = in6addr_any;
-		spin_lock_bh(&peer->lock);
-		bind->local.ipv6 = in6addr_any;
-		spin_unlock_bh(&peer->lock);
-		dst_cache_reset(cache);
+		reset_local = true;
 	}
 
 	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
@@ -340,10 +353,28 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		goto err;
 	}
 
-	/* avoid storing a stale cache */
+	/* avoid storing a stale cache or local address */
 	spin_lock_bh(&peer->lock);
-	if (likely(ovpn_dst_cache_current(peer, bind, key)))
-		dst_cache_set_ip6(cache, dst, &fl.saddr);
+	if (likely(ovpn_dst_cache_current(peer, bind, key))) {
+		if (!reset_local) {
+			dst_cache_set_ip6(cache, dst, &fl.saddr);
+			spin_unlock_bh(&peer->lock);
+			goto transmit;
+		}
+
+		/* invalidate per-CPU dst entries that may still carry
+		 * the stale source
+		 */
+		dst_cache_reset(cache);
+
+		/* preserve the current remote */
+		memcpy(&remote, &bind->remote, sizeof(struct sockaddr_in6));
+		/* The current packet already has a valid wildcard-source route.
+		 * If replacing the bind fails, leave the stale local in place;
+		 * a later cache miss will retry the repair.
+		 */
+		ovpn_peer_reset_sockaddr(peer, &remote, &local);
+	}
 	spin_unlock_bh(&peer->lock);
 
 transmit:
-- 
2.55.0

