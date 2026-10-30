Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334187;
	b=ZEX4wHcfr8FM+qh/fUTZOWNNICbxcxcQbLBIQiJxXbv0DQ2kaiC3+cub6gq8SzZTtFcS
	 FhGo7slibgi3VBQ6xapSKidvSpY8NTIvdSkquzxo7Tj2GT02o9qb3ehZFO+O8Pn8cqFjz
	 5Bmj7oeeVzJe47ar5Qer6Kp16wavgO7Tzn+0hlSjyLRMH6iJbfgLDPpdrCeGvUr4B/0MW
	 Tc4KnDuO+9OWZCyr7Kz7HdsCn6n6XgGOW3doA58SyEtSaAmdyOXTKAiIa0/WjEbYgrjg5
	 bqWy2EHoMSHt/SOG/JnypPt9Q6LochrYxae+oBmL0FVPoBWo04EtvNCOjHG5ZwJvc+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J0FkcDItDnYI8f6l23PjrTbyMzPiMOtn9QhR8JgnGN0=;
	b=pFlH9lMpjek1jYUnHK2fOAR6klebcDGp90dkQWjDUUByOmKjSWZw7Dm+++zk2gRHB4XA
	 q3ZEFSrw8ZLHfAA6so0KTs2XfbT3/a3lbcofrsO4GjOirO4/icIT3YBXWgQF1EkohhkQ8
	 yHs+8L7eaCCpMswHalbV6eQ8QbEbEI1cnM4o0gSbC7jGO6YeTEV/ivSl8YfmeurGR3gnY
	 QlnEdG5Gz5KeEajOdNiRHFW29Tg/dU85Z5VraKZ2StKo3ghTljhxuLyKznML2XtSy8gby
	 pW7tatxRho4huGhdPjGXDUXglOcu/J+6jOAfD15Yavi8i69CDPEYMyL9yvmB+TAQSIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=JQ2IkKzK;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC2606A326
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72AC2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=JQ2IkKzK
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4ed6d69bdfaso187012b6e.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334186; x=1793938986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J0FkcDItDnYI8f6l23PjrTbyMzPiMOtn9QhR8JgnGN0=;
        b=JQ2IkKzKFmio0UGJ+0Yw22iCeqz/VOcrdzeTpusdnEADfpJEnnWJqdDiwYihUhrVZp
         /z2zwufeRJJvZNHe3lNN3mBPsUaqLXCp/XuAdJ7U34V5KRbdheznQFSf+cNbWhbTjvQ/
         yhcIDxK+GY3h3ABUjxklCXj3CyJiRvQi0qsgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334186; x=1793938986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0FkcDItDnYI8f6l23PjrTbyMzPiMOtn9QhR8JgnGN0=;
        b=KZjgzkFYTkrlSOb7RT0idhMUAoEA8dC+gZlP6NE9SoDlOIyyFQL0tVGl3B8XL1nk3p
         n9k/mJNgcUlGjFgA1uGL5gsZ01sVZAdptyJSknSTbICmd2xxSP9zG8xQKoM/6OvYqimn
         94XdHuxO2DNJirg3AV5BW+dnKdiQaFRNqcZbhGC5wwRk2dVlQ7IOFgTgLt0v7k9uH4yv
         v84i6fAaxPGYrpxo2pJN/7AKmiu/L8e9jc2yv1syi4ZC/q1v2OvdyqN1ZqLVSKNP2HDL
         Pv+H2X3tav42SEnEYErngDFejJMHKTUs2hFJS2K8qw3JLbNRa/a6ZQqjBXEVzza/UV/M
         6DZA==
X-Forwarded-Encrypted: i=1; AKwUvBwp9nfKiAYX/0IfVQ+D7Q2DxLGQy/omJzkfzxuIMGA/tdkpF1h9YF8Q0PTgtZPONDttTfQhDtE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXsmVXI3dgno+s4Xz+miATCKE4OlrvP9/m1B8K1muSsNfmYr4G
	oXELKchlSlLf/Cq0Uq+HRA0iWfVns5c4uxfN2zdvd1AgPlQVPgo7VNPCpjkH58rking=
X-Gm-Gg: AYBFou2I5aIXrVmaD1b07BiUrSSe0w7g1YlF2Z2XR1uVdKzUH3YCb1E2D3T2F6FYM2r
	7PBKJv3uDq0LIBbn+6y2mf6+K1LBtRdavi9SQU4Rj3utqEUgh1MmwK8CltvPdNoOebwxn5hVtl0
	dOtUB0BheWQmbrjqqtTOkgxHCyw3z1xhJClGoNaG+Y3SZjI0xZkf0NMV9OdO1CI302OePyy12ek
	pULVGIVpsrS7RUXtaHSX4UA2narsKO7MrJE8TU6JdbfBgVcCAYnnboLHaKP9yk4Wov1OZfNcId4
	WQ7dyU8n2uMox8ajAp+m7tWctzdfMs0kbdR8YlWLpZxygwZP95yH4tg5bM3R9GQGUt0a1jLmmc+
	VGBLvEDVphdFkaYYTtDCdRH/epSwt1rOimnlNZTRKUgh7P2lkGIPurS6V/+empeC+AOmpjaR5KT
	7qGCwsCSXLSgApV2u4eEHtpWhOdmbhT8emirEwBfB0DPA/aNc9uQ6SI9BfKWKDXpCzLGUtITM2Q
	7pVcFyDCDRZ729BeLah2mLy9yhaNieKfDNmpWTJ+N/cT3fg8WoTEQU9i32xtPisN+UydkEZpr9K
	U7FDkKBDcQ5WoyPdE0GuEyxRroo7r/UndglTG5I8QG5dgEc0ji9hfiIOVlBau4xBTEJNKgFURsK
	aTX1B9slC7mvrD4cUWKxLvZlxV6twEg==
X-Received: by 2002:a05:6808:8896:b0:4bb:ac05:9ebf with SMTP id 5614622812f47-5640ddb2da3mr560571b6e.14.1793334186362;
        Thu, 29 Oct 2026 21:23:06 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49923sm699662b6e.1.2026.10.29.21.23.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:23:06 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: dev@openvswitch.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] net: openvswitch: make transport checksums writable
Date: Thu, 29 Oct 2026 21:23:04 -0700
Message-ID: <20261030042304.74291-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An IP address rewrite can execute even if the transport-header pull in
key_extract_l3l4() failed. In that case the transport key is cleared,
but the IP protocol and transport offset remain available. The address
rewrite helpers check the total skb length before updating the transport
checksum. This does not guarantee that the checksum is in the linear
head, or that it is writable.

A non-linear IPv6 packet with a long, valid extension-header chain can
therefore cause an out-of-bounds checksum read/modify/write when the
GFP_ATOMIC head expansion fails. KASAN reports the access in
inet_proto_csum_replace16(). The IPv4 TCP/UDP and IPv6 TCP/UDP/ICMPv6
address rewrite paths all have the same missing check.

Make the applicable transport header writable before changing an
address, and propagate failure through the existing action error path.
Reload cached network-header and address pointers after the operation,
since it can move the skb head. Preserve the existing behavior for
unchanged addresses, truncated transport headers, non-first fragments,
and IPv6 destination rewrites that do not affect the pseudo-header.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/openvswitch/actions.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 12e339cbf791..36c2a1963222 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -319,6 +319,35 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
 	return 0;
 }
 
+static int ensure_l4_checksum_writable(struct sk_buff *skb, u8 l4_proto)
+{
+	unsigned int offset, len;
+
+	switch (l4_proto) {
+	case IPPROTO_TCP:
+		len = sizeof(struct tcphdr);
+		break;
+	case IPPROTO_UDP:
+		len = sizeof(struct udphdr);
+		break;
+	case IPPROTO_ICMPV6:
+		len = sizeof(struct icmp6hdr);
+		break;
+	default:
+		return 0;
+	}
+
+	offset = skb_transport_offset(skb);
+	if (unlikely(offset > skb->len))
+		return -EINVAL;
+
+	/* Truncated transport headers have no checksum to update. */
+	if (unlikely(skb->len - offset < len))
+		return 0;
+
+	return skb_ensure_writable(skb, offset + len);
+}
+
 static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
 				  __be32 addr, __be32 new_addr)
 {
@@ -462,6 +491,7 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
 {
 	struct iphdr *nh;
 	__be32 new_addr;
+	u8 l4_proto;
 	int err;
 
 	err = skb_ensure_writable(skb, skb_network_offset(skb) +
@@ -470,6 +500,10 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		return err;
 
 	nh = ip_hdr(skb);
+	l4_proto = nh->protocol;
+	if (nh->frag_off & htons(IP_OFFSET) ||
+	    (l4_proto != IPPROTO_TCP && l4_proto != IPPROTO_UDP))
+		l4_proto = 0;
 
 	/* Setting an IP addresses is typically only a side effect of
 	 * matching on them in the current userspace implementation, so it
@@ -479,6 +513,11 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		new_addr = OVS_MASKED(nh->saddr, key->ipv4_src, mask->ipv4_src);
 
 		if (unlikely(new_addr != nh->saddr)) {
+			err = ensure_l4_checksum_writable(skb, l4_proto);
+			if (unlikely(err))
+				return err;
+
+			nh = ip_hdr(skb);
 			set_ip_addr(skb, nh, &nh->saddr, new_addr);
 			flow_key->ipv4.addr.src = new_addr;
 		}
@@ -487,6 +526,11 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		new_addr = OVS_MASKED(nh->daddr, key->ipv4_dst, mask->ipv4_dst);
 
 		if (unlikely(new_addr != nh->daddr)) {
+			err = ensure_l4_checksum_writable(skb, l4_proto);
+			if (unlikely(err))
+				return err;
+
+			nh = ip_hdr(skb);
 			set_ip_addr(skb, nh, &nh->daddr, new_addr);
 			flow_key->ipv4.addr.dst = new_addr;
 		}
@@ -533,6 +577,13 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		mask_ipv6_addr(saddr, key->ipv6_src, mask->ipv6_src, masked);
 
 		if (unlikely(memcmp(saddr, masked, sizeof(masked)))) {
+			err = ensure_l4_checksum_writable(skb,
+							  flow_key->ip.proto);
+			if (unlikely(err))
+				return err;
+
+			nh = ipv6_hdr(skb);
+			saddr = (__be32 *)&nh->saddr;
 			set_ipv6_addr(skb, flow_key->ip.proto, saddr, masked,
 				      true);
 			memcpy(&flow_key->ipv6.addr.src, masked,
@@ -555,6 +606,15 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
 							     NULL, &flags)
 					       != NEXTHDR_ROUTING);
 
+			if (recalc_csum) {
+				err = ensure_l4_checksum_writable(skb,
+								  flow_key->ip.proto);
+				if (unlikely(err))
+					return err;
+
+				nh = ipv6_hdr(skb);
+				daddr = (__be32 *)&nh->daddr;
+			}
 			set_ipv6_addr(skb, flow_key->ip.proto, daddr, masked,
 				      recalc_csum);
 			memcpy(&flow_key->ipv6.addr.dst, masked,

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
