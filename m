Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A763F0777
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404802; cv=none; b=W5WFQNXxLEd9kQYHemrGTzBb3yDk0wEMznbOBP/Mh/XOpktN7SyTcMtQ5/BVYtLKWDaAKDUCM0pKRMNmyqj1CRbcb29uieOLjgXWDS6BXEyefArMMjxgEDG9wGWS1WfCijnvz2a9ILaF4jodG983PKUeJrdniA7uzag/b/DjBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404802; c=relaxed/simple;
	bh=tYLWxFIl1OKaG/5fn4rIah9YGs5ROT7qwe35rmRtSuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScRqX2Krp1+b5sH3OltQRGP7l/ZwmWLjxbea9O6mfesBcFlr36ebzBqgfHYPghzmQ0XpaDqppft5C5DukWy0P2dU6rP7Q+rIrKwCApB79DFx5YQ22oI5cT5roHqBwsAnpu0hrhpKR6ddHBJRLOKVwIgIw8DIRn17enEpjqYYzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ju/hntSD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ju/hntSD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1250040f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404799; x=1786009599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btym4f01V8LdoyEFrZvQ0ilvvOaRKP+hIGU3EIeNkD4=;
        b=Ju/hntSDQ0d/5Et8xoPbtiVEKmxzppcUo8lJjMLJ98U3VHjAA6KXaf/3QIz50ki9Af
         Kx4zYJ9Esko+LdRrf4+FgQn2uJuX1pQf01MB6JgfxYjySfhRE0mIpMmnZ86gELFwmRoF
         7/MuCZgBsYs7DzILNLCD6aCt1ak/9cMAY3Qh/0/fAz8NHBI7iteOk7b+rJnCSUl7MZSG
         EnPbNltyQAegxb9j2Ux89dhHHc49BL6MLcb2uaeiPXuuFl3y8F5O9gQl+UFiZBwGEvHR
         ZXp8uPXtv6/ptk9kj89lWswzPjTujvaZ8IaA7HrP101eFqyJIe0JI4VOMKxUNIeFmxA6
         6azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404799; x=1786009599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=btym4f01V8LdoyEFrZvQ0ilvvOaRKP+hIGU3EIeNkD4=;
        b=NoFxivjwQ9nJN3igcajtbQuEYPls3M/EUbtPNMkQuiXD/bvaoOuG/6VcSL30hsbOpH
         HA6zCL7uuUy8uM7qsytJPiKuBhSa+u0GlujYiFaELSft9dPjGxhLsxdNPm0oVX3oMAP+
         Sk2ABKx+0X4bWskCVIa5J9biuC9oeEAUjyKee0dGHXbi5AnX0nEgVUos2Du1RLUBA9MG
         TDEFpNyKTrFDNEZ9i5Uzz1ZiEDRnQC+LtrOXG0qjk1hS6/0ik3IMHgFnDTYrUkaJ3gsM
         G8IM+0KAFyFAKcgR0qfjGMblSbosnmWX9/Q92o27UjQOdVp38uFLCPWHFEb6AFrE366d
         aK7A==
X-Gm-Message-State: AOJu0Yy9g5xEeafczZj4LdLAY7TDgWdDms0eq2DYS3dJxv8237qvu806
	nhpmZRtuY88BpstVUflbhMX9GUIzbY3M/vfZr6HITzazlwXyXpi8dO76LNo8QtRKNrlOqMJzvsz
	3HFhWA/ZyGl09gL8uw7uLp9yxtTUIJtFmwJMNDtgeJ5uZ/prRgQpsNplJNXp49ILC
X-Gm-Gg: AR+sD12c8yGmoqjJnZekiU5tmgbWEBIjHthv6quTlkwSnGNlv+jU9fimo+krVREM5tG
	LjKhHPwmgIyARQf2ujRofjI0ec5+itBfr/M9iAAK8ykrRo6wpnOp/sRDT67bM9DbOlMd1iPAVve
	hMterFJ++xC5Kze/VhL7DF9P+knhx5ac1Aua4z9eqQEtO55iOn9UtKPw/yxvXMuWvj3sx8mXcwm
	Y5pY64bSqlAYCRqw3LeQlJ6IxHVnZAhQVo1hs07XCPxM5Tk1s5onsxdZh/Vt8I9DtrPxg4AfCBr
	YymxyOFZqugnHze7862xSbUwrXOMF2QnIFsuqw5Nn9iGiRCynhqDsO6LG/5XaB8PtZ9cbqM7pvH
	oSiN5f1eZ3C6iQImyxFEg30pu3BCQ5BUJ8xPq2XHfPMjUXENaDgz+a/1QU7fRXToQoauqFCfVcN
	lLmKJyyFBk/ckAaByLQq9mM2bKdQCdiNoCN/i42ua2EiLh4DnaoIiUFY6BcPn732Y7C6d1xSGD1
	Q==
X-Received: by 2002:a5d:5f42:0:b0:47f:97e9:fe4a with SMTP id ffacd0b85a97d-47fc81fc91dmr2465258f8f.43.1785404798483;
        Thu, 30 Jul 2026 02:46:38 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:38 -0700 (PDT)
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
Subject: [PATCH net 06/10] ovpn: zero-initialize sockaddr before learning a floated endpoint
Date: Thu, 30 Jul 2026 11:46:17 +0200
Message-ID: <20260730094624.4102963-7-antonio@openvpn.net>
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

ovpn_peer_endpoints_update() builds the new remote endpoint in an
on-stack struct sockaddr_storage that is left uninitialized. For IPv4
only sin_family/sin_addr/sin_port are written, leaving the 8-byte
sin_zero padding as stack garbage (for IPv6, sin6_flowinfo is left
uninitialized likewise).

ovpn_peer_reset_sockaddr() -> ovpn_bind_from_sockaddr() then memcpy()s
sizeof(struct sockaddr_in)/sizeof(struct sockaddr_in6) bytes - padding
included - into bind->remote. That buffer is later hashed with jhash()
over the same length to place the peer in the by_transp_addr table, so
the garbage padding lands the floated peer in an essentially random
bucket. Lockless lookups in ovpn_peer_get_by_transp_addr() build their
key from a zero-initialized sockaddr_storage, compute a different bucket
and fail to find the peer.

This is also a plain use of uninitialized stack memory in jhash().

Build the floated endpoint with a designated initializer so the
padding (sin_zero for IPv4, sin6_flowinfo for IPv6) is zeroed as part
of the assignment. This keeps the padding out of the by_transp_addr
hash key without memset-ing the whole sockaddr_storage on every
received packet.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a330892e82bf..33fb0a75e600 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -222,9 +222,16 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 			 */
 			local_ip = &ip_hdr(skb)->daddr;
 			sa = (struct sockaddr_in *)&ss;
-			sa->sin_family = AF_INET;
-			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
-			sa->sin_port = udp_hdr(skb)->source;
+			/* use a designated initializer so the sin_zero padding
+			 * is zeroed (it ends up in the by_transp_addr hash key)
+			 * without memset-ing the whole sockaddr_storage on the
+			 * RX fast path
+			 */
+			*sa = (struct sockaddr_in) {
+				.sin_family = AF_INET,
+				.sin_addr.s_addr = ip_hdr(skb)->saddr,
+				.sin_port = udp_hdr(skb)->source,
+			};
 			salen = sizeof(*sa);
 			reset_cache = true;
 			break;
@@ -250,11 +257,19 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 			 */
 			local_ip = &ipv6_hdr(skb)->daddr;
 			sa6 = (struct sockaddr_in6 *)&ss;
-			sa6->sin6_family = AF_INET6;
-			sa6->sin6_addr = ipv6_hdr(skb)->saddr;
-			sa6->sin6_port = udp_hdr(skb)->source;
-			sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
-								 skb->skb_iif);
+			/* use a designated initializer so the sin6_flowinfo
+			 * padding is zeroed (it ends up in the by_transp_addr
+			 * hash key) without memset-ing the whole
+			 * sockaddr_storage on the RX fast path
+			 */
+			*sa6 = (struct sockaddr_in6) {
+				.sin6_family = AF_INET6,
+				.sin6_addr = ipv6_hdr(skb)->saddr,
+				.sin6_port = udp_hdr(skb)->source,
+				.sin6_scope_id =
+					ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
+							    skb->skb_iif),
+			};
 			salen = sizeof(*sa6);
 			reset_cache = true;
 			break;
-- 
2.54.0

