Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F153ED3B4
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986147; cv=none; b=iVKZq6vNIF4VAuJfJtTjw/8ume0tyzSXBZGfY0sraa/vL1eu06vBFfUSMwbG+TY62DoNZMvDNVyKIhTp8sAxEnwmbvJ2NBWInaN4h0bvbWyaznt6p/BXmReTOLO6+7XsSkSeUvBnsV5TuV5zCEdgD/KOTjLiXVmkHXWZSlpTJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986147; c=relaxed/simple;
	bh=pNJZiVJrr8+8VZXZ6hcnRmdv7m/uWeRest0ExNWChF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pbf/z7w71Ihw892A21L3WB9ybKm+CNopklzQR/XAsld8GMqL4EaCzzSTt3FZPBO4SZbIjIfq+RVQm6apLrTg57y+wLJRajgpGhIx88gZDcSmLhyn/hqh0PLqwfmb9rLWR+jAzqpEu2orxgCxUSSMpsO+z3OY0+9z6NDfIShX6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IfIk9W13; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IfIk9W13"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48434392b02so2083009f8f.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986143; x=1790590943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjtValQod528pcKmm1Uf4wD5ybYURDRpdIUNv28qNA0=;
        b=IfIk9W13/fHHZUQ8S2aEdNbxAxsOglbb+ul+N3PlNq+Jvc38LzMcw2dHa+rbO/IauN
         LMENVOWj//19WtiFocrvsZq9A/oHtMId59LJu8edf9eEbidbBqOAfJ73aNH+19Iys2Io
         DSS/o3oqRgEKk4iCYmaB8dEM0TGGjjRMhUIRYhZp2D3dcndapNj2gooNXtWMRhzwGJcE
         UGy40BSR2T0lzLCXs3V5wzaN2au2sxtVP+ViJGXG0udBOoIjRhLgf4CeFqh9bYj7OmE4
         UlS/kBfw6zbN3qoI1xWzVA6IdArEjqnEs6wIJUnosXcjIBTrGgsV/egMBbpZg+xOOQDL
         h0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986143; x=1790590943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IjtValQod528pcKmm1Uf4wD5ybYURDRpdIUNv28qNA0=;
        b=uVxl+4VoZv0UDnkYuY8u+xFUnKl5O7MYGkunloNCGcgU2/Wi2wJDUYTEuVEV2DS1C9
         rh9JeJr03L5NKUCeK6XkuINKN9gRFe2QsLBhrNIVMZazrlH+y8EJQuBNvjN5xC+2hnF3
         aLrgt+V50NR/VnJEUWlSfFI8QpuoQNwtBpL6yAbIPUtsFul3kD9AGUYq1V2h1ZF1ilWk
         xB8Zcg5cWHFjzzVJ84+Kyp97siPRjG954C0WpQVPunaxsTPQghOvZJBfpJ7mahpey3V9
         tnB5L+IP4yXLrEfTvVmYVStvO9IgQwvgKPDR83ITpZMwJVpjXkjcd7r9e6i+Nv4J65EY
         Oyuw==
X-Gm-Message-State: AFuF++mDZqeqKN3a+C58Vg3Lx9ToLg+yx7HcJP7CRntl05WfMDjGpqjr
	UapdKdmtcEhpvQurRC8ht8p26HhJ8LqYbfJod1+yyCeMb7RKCtTeRACneSbJlcS3PzrR0aS6J9S
	so4Cya8OkWKu2itsmibD0bxhkE1bG0i3wZsY48pOt260O0rWzSLPGWz6dMK0hP6+2aSY=
X-Gm-Gg: AYBFou3hmfSgxblLR2sn9PQbBdbQpZwDHkdIuaMQ+9jtbwzSulnB+wsT1A8hAS+beVQ
	i2QrqasRyoWP94pFexnyXTwQ9o1FnzrsFJmyuRNbE32V8hnC/DFRU124dw2AM2MdBBAsRRLncs/
	tWxTmOBYw5NY5NdFGnlLBZoQN4P13WKsE1dIRl0TAYCmEPMBd8yItoyIf7uB1SDOTXZ/CExsXLc
	99JO9AEzE5pnxCPIp+oC0WP/Y7b1UYQWLkqCVZOEzn3Q200MGuDqRCCzdJ1n6LuIp0CST6JXIqX
	bjdHg8ZqTaKLFVKBh8J9P1j3Tzhk+0bGjngA09Sf09r3OtG0Yb6BIYpOzGOxVwM1KPfYU4zmNIs
	dfflPEnURyLBNnF8dzyJscdoxJEbuMn2oNrrbOJxkSJnVSDHMDZzejc5e0LxT+ti9lmp+I6LkOB
	5e1eOdLoXWvrZ9nyBETclr4+cqeaddK1zNVuwiPNQs6FFuWrdFScQEzYUuGmuKYAJ/J9jlFg4DQ
	Ln5Y/INnv8=
X-Received: by 2002:a05:6000:38f:b0:487:ee4:b5e4 with SMTP id ffacd0b85a97d-4871e21a26bmr19302927f8f.8.1789986143446;
        Mon, 21 Sep 2026 03:22:23 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:22 -0700 (PDT)
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
Subject: [PATCH net 05/11] ovpn: replace bind when learning local endpoint
Date: Mon, 21 Sep 2026 12:22:06 +0200
Message-ID: <20260921102215.3599702-6-antonio@openvpn.net>
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

struct ovpn_bind is published through peer->bind with RCU, but local
endpoint learning updates bind->local in place under peer->lock. UDP TX
reads the field without that lock. In particular, a concurrent IPv6
update can therefore result in a torn address read.

Use ovpn_peer_reset_sockaddr to publish a replacement bind when learning
a new local endpoint, just as a remote endpoint change does. Preserve
the current remote address and reset the dst cache only after the new
bind has been published successfully.

Track remote endpoint changes separately so that float notification and
transport-address rehashing remain limited to actual peer floats.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index b400783c2efa..430c6cd48db8 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -200,13 +200,12 @@ static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
  */
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 {
+	const void *local_ip = NULL;
 	struct sockaddr_storage ss;
 	struct sockaddr_in6 *sa6;
-	bool reset_cache = false;
 	struct sockaddr_in *sa;
 	struct ovpn_bind *bind;
-	const void *local_ip;
-	size_t salen = 0;
+	bool floated = false;
 
 	spin_lock_bh(&peer->lock);
 	bind = rcu_dereference_protected(peer->bind,
@@ -233,8 +232,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 				.sin_addr.s_addr = ip_hdr(skb)->saddr,
 				.sin_port = udp_hdr(skb)->source,
 			};
-			salen = sizeof(*sa);
-			reset_cache = true;
+			floated = true;
 			break;
 		}
 
@@ -246,10 +244,12 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &bind->local.ipv4.s_addr,
 					    &ip_hdr(skb)->daddr);
-			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
-			reset_cache = true;
+			local_ip = &ip_hdr(skb)->daddr;
+			memcpy(&ss, &bind->remote, sizeof(struct sockaddr_in));
+			break;
 		}
-		break;
+		/* nothing changed */
+		goto unlock;
 	case htons(ETH_P_IPV6):
 		/* float check */
 		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
@@ -271,8 +271,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 					ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
 							    skb->skb_iif),
 			};
-			salen = sizeof(*sa6);
-			reset_cache = true;
+			floated = true;
 			break;
 		}
 
@@ -285,26 +284,30 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &bind->local.ipv6,
 					    &ipv6_hdr(skb)->daddr);
-			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
-			reset_cache = true;
+			local_ip = &ipv6_hdr(skb)->daddr;
+			memcpy(&ss, &bind->remote, sizeof(struct sockaddr_in6));
+			break;
 		}
-		break;
+		/* nothing changed */
+		goto unlock;
 	default:
 		goto unlock;
 	}
 
-	if (unlikely(reset_cache))
-		dst_cache_reset(&peer->dst_cache);
-
-	/* if the peer did not float, we can bail out now */
-	if (likely(!salen))
-		goto unlock;
-
 	if (unlikely(ovpn_peer_reset_sockaddr(peer,
 					      (struct sockaddr_storage *)&ss,
 					      local_ip) < 0))
 		goto unlock;
 
+	/* reset the cache only after a successful bind update to avoid useless
+	 * cache misses on concurrent TX
+	 */
+	dst_cache_reset(&peer->dst_cache);
+
+	/* if only the local address changed, bail out now */
+	if (!floated)
+		goto unlock;
+
 	net_dbg_ratelimited("%s: peer %d floated to %pIScp",
 			    netdev_name(peer->ovpn->dev), peer->id, &ss);
 
-- 
2.55.0

