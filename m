Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024163;
	b=iZpi+Iv3I4KEf9WbxDQeQIDN5TtxuTbfKn3+vfMIxfBBYfyywCq8/8N+YOGAmGhUBYNf
	 tv3ZkbSiaM75NolvN+55mnNkInTwb57ges27SZX6dNMvIX3xd9/BYUMHAPtYXbNDEYLyX
	 YIZrpilHIZAlxWKJVXPAl+MqT4qGFY3Ox0EZPhLTz5N8028wyseUoPkyGTzIf1Iytq47J
	 NhwBBIq5XyO78l8VT+/5gJwK4vfiASfJLEUA8gIuSaTSN4Z3lbqc//sQflLxcNFOfQ+4O
	 RzOLPf26X2ACtvhydmwGKtnZOSMmKta2KMH5+ibbhN5BCCqFPNGqKfxcrtHGJAVdf5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iDNBUXlZYHZzJ9wp74s8HsM2SQUSI7+qOI3EN8FHBMw=;
	b=YrZWRNb5bRa5Fn8bxzi9B7Yefq5K6AfV5p6vVoDlJsDN2/XEuxt6ApWoad8ldOSKx3V4
	 F7FX7GK2cl9li/a4YA0aWwV/mr8XkEAGwjWd9TPpqQ5aglJ8feWDZFdkkKD0sEAUA6pEl
	 JgQ2HeLxRQRAKFtfePFq7PqcUhVY5IU+sJJEqtwa698fQvpjudyoPgEKifZu25ubLlc9i
	 p+kRf2WRBj5bxyU/swCRqEoa459559IaPlm66afzO41hBX9w7u0/xR3V4pVBwBrYAeZ+v
	 7j3pblEbjOg1atEQLgK4uHuCv2q3Ypw3tJGtq06nRYJocO9DRPmP9o4qG4/yf/1bjSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b="Zx4lXM/Y";
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F2606A32C
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 04:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B50F2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Zx4lXM/Y
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-703be215729so508711eaf.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 20:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794024161; x=1794628961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDNBUXlZYHZzJ9wp74s8HsM2SQUSI7+qOI3EN8FHBMw=;
        b=Zx4lXM/YLmu98OuBoXL0bPIqITK6E0AeA/i/VUJXhJAd7XkOdbDo3F7W9wEXV2cAgL
         OwM9/GJt2AnVBheOesg7wWIk3kElkAe7491IDsIuQvigM1GEIbDUBynUI2hqydxSuB/p
         nU/mwi/Y+sEmTKaVcgeFfKk5B084RG5mxNV+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794024161; x=1794628961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDNBUXlZYHZzJ9wp74s8HsM2SQUSI7+qOI3EN8FHBMw=;
        b=QawcVwyP/tSURDkfRsGSwLE+OOZywkrzUXW8uhuYDQoukBkcMPKZHsQghwSD5R5GbN
         h+UYYozXcrDmxR4fKIJz1sj1bd96nlOX/+D82d6cHX5OEhU80uUqd62O8/JrXf/ca9Jy
         LTOohzSgmo1VQNRNluL7K9FVYpe3n0GLRKis0H7MjWW5whIT4z8I12Ca3XzD7Q9p+sud
         3p+Xb8GAqptcSnsj882xI3Y6RPWmkrAKBlX3m+JW2hHR4upBLP0xs1Si4oK9aVnqmgvQ
         WraqazwkTpdokbxG0OfinLiLY4vpvXzS5xtDAOAZbDCL1eD1qOJL71eTyYh/CMBhSmQP
         J7MQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQ7G8O68LZD4g4ouDGhj71l/JjuFi7WhMS/MXJHufyJAfYguamXpbrv787h0isc/UUxlIxsTk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qdImUziVwoO6esmm1snSn3AQLUK+uGVCfiW6fXqdG4rNBI41n
	Q45uiDuI8baZxwwU48nY4r/N9qKpSLsJV7cWHZ6Jn8katMYyA+5qGRB0s0+x8XHiWb0=
X-Gm-Gg: AYBFou2/jx08apb96fw4IcqAV0OdWLwQz43vhBORP+TtZmNYignsRvjUNgaUqlQdWiF
	ltxzEVFVaJ388ZATVpdcD3tTwOzzcavg7qXaxNc7GJ+Q6R6uxQfciVGS9/MeJ+5WxjDlv3q2ZPa
	Gv/Zlf5YLEmPF4/YwWZbMTQN6NBC9tCLOnMF6WoMmglMIlAgt5ep1IRi9L7VRJuSfonGZZVXZ0B
	BPk/ZGZ0gaQ7dNEEnJ5phX7agu10FbkA36+Klc3SYNAxCJzJ+QHjOBThqG529WbPtsgGifYeVvH
	BqnxEWnziD6lmf74fcuhBOne2UVvJ7dRAUGa6ctmT2JxbGAuh4VUbmwGL6ti1pS7et7hH5pYxl+
	FIytW3R8k8i3p9iSQvE74dzbQbI+bE4zGyNSp0bOCECHNOcYD2pSyjHADSxkqoWViZHEAP1ah70
	MxSLxpu8n9X7H9XRpiaSrot6Zf3QwES4pG7TqNosnmMCsf0uogeCLUHoVmw2VVukp3y5JvIE7oX
	WY6ZkZRzWfAf+82FeXdIMAR26guhutVWY63X1qTI436gQzn+E6pvKkpR6kB2vDiNqFZs81K+Uf6
	EYh6R7UM2Q0l3idU20J0JCCpLvSMAyJAD0VwePcEEEkffxi5xMVQYHNlBWxiombffxaZtVgKgRo
	k/t52BloVDV6+gKxtWvd7STiDn935FA==
X-Received: by 2002:a05:6820:448b:b0:6ef:1250:1064 with SMTP id 006d021491bc7-716e788c04amr2164318eaf.30.1794024161505;
        Fri, 06 Nov 2026 20:02:41 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e9cb331fsm3118162eaf.2.2026.11.06.20.02.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:02:41 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: dev@openvswitch.org,
	netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: openvswitch: make transport checksums writable
Date: Fri,  6 Nov 2026 20:02:38 -0800
Message-ID: <20261107040238.27606-1-kylebot@openai.com>
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

An AI-assisted source review identified the missing writability checks.
The supplied userspace reproducer sends non-linear IPv6 packets with
long, valid extension-header chains through TAP and Open vSwitch. It
triggers a size-2 KASAN access in inet_proto_csum_replace16() as UID
1000 in an owned user/network namespace. The reproduction uses natural
allocation pressure, without kernel changes or error injection. IPv4
TCP/UDP and IPv6 TCP/UDP/ICMPv6 address rewrites have the same issue.

Replace the total-length checks with skb_ensure_writable() immediately
before each transport-checksum access. Keep an unavailable transport
checksum nonfatal, as with the existing truncated-header handling.
Preserve the old address values across the operation and reload packet
pointers afterwards, since even a failed pull can have moved the skb
head. Retain the existing unchanged-address, later-fragment, and IPv6
routing-header behavior.

The Open vSwitch module builds with GCC and W=1. The changed object
also builds with allyesconfig and allmodconfig. Code review covers the
common SET action paths and adjacent checksum writers. The supplied
reproducer and kernel selftests have not been rerun against the rebuilt
module. Codex assisted with the patch review, validation, and report
preparation.

The issue was found by an LLM.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
Link: https://lore.kernel.org/r/20261030042304.74291-1-kylebot@openai.com
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Suggested-by: Aaron Conole <aconole@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v2:
- Put writability checks directly in the transport-checksum branches.
- Keep an unavailable L4 checksum update nonfatal.
- Save the original addresses and refresh all potentially stale packet
  pointers, including after a failed pull.
- Target net, include all maintainers, and describe discovery and testing.
v1: https://lore.kernel.org/r/20261030042304.74291-1-kylebot@openai.com

I have a reproducer for this issue and can share through DM.

 net/openvswitch/actions.c | 56 +++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 12e339cbf791..fe472e950cb1 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -319,20 +319,22 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
 	return 0;
 }
 
-static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
-				  __be32 addr, __be32 new_addr)
+static void update_ip_l4_checksum(struct sk_buff *skb, __be32 addr,
+				  __be32 new_addr)
 {
-	int transport_len = skb->len - skb_transport_offset(skb);
+	struct iphdr *nh = ip_hdr(skb);
 
 	if (nh->frag_off & htons(IP_OFFSET))
 		return;
 
 	if (nh->protocol == IPPROTO_TCP) {
-		if (likely(transport_len >= sizeof(struct tcphdr)))
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+					       sizeof(struct tcphdr))))
 			inet_proto_csum_replace4(&tcp_hdr(skb)->check, skb,
 						 addr, new_addr, true);
 	} else if (nh->protocol == IPPROTO_UDP) {
-		if (likely(transport_len >= sizeof(struct udphdr))) {
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+					       sizeof(struct udphdr)))) {
 			struct udphdr *uh = udp_hdr(skb);
 
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -345,11 +347,15 @@ static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
 	}
 }
 
-static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
-			__be32 *addr, __be32 new_addr)
+/* May move the skb head; callers must reload packet pointers. */
+static void set_ip_addr(struct sk_buff *skb, __be32 *addr, __be32 new_addr)
 {
-	update_ip_l4_checksum(skb, nh, *addr, new_addr);
-	csum_replace4(&nh->check, *addr, new_addr);
+	unsigned int addr_offset = (u8 *)addr - skb_network_header(skb);
+	__be32 old_addr = *addr;
+
+	update_ip_l4_checksum(skb, old_addr, new_addr);
+	addr = (__be32 *)(skb_network_header(skb) + addr_offset);
+	csum_replace4(&ip_hdr(skb)->check, old_addr, new_addr);
 	skb_clear_hash(skb);
 	ovs_ct_clear(skb, NULL);
 	*addr = new_addr;
@@ -358,19 +364,17 @@ static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
 static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
 				 __be32 addr[4], const __be32 new_addr[4])
 {
-	int transport_len;
-
 	if (l4_proto == NEXTHDR_FRAGMENT)
 		return;
 
-	transport_len = skb->len - skb_transport_offset(skb);
-
 	if (l4_proto == NEXTHDR_TCP) {
-		if (likely(transport_len >= sizeof(struct tcphdr)))
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+					       sizeof(struct tcphdr))))
 			inet_proto_csum_replace16(&tcp_hdr(skb)->check, skb,
 						  addr, new_addr, true);
 	} else if (l4_proto == NEXTHDR_UDP) {
-		if (likely(transport_len >= sizeof(struct udphdr))) {
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+					       sizeof(struct udphdr)))) {
 			struct udphdr *uh = udp_hdr(skb);
 
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -381,7 +385,8 @@ static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
 			}
 		}
 	} else if (l4_proto == NEXTHDR_ICMP) {
-		if (likely(transport_len >= sizeof(struct icmp6hdr)))
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+					       sizeof(struct icmp6hdr))))
 			inet_proto_csum_replace16(&icmp6_hdr(skb)->icmp6_cksum,
 						  skb, addr, new_addr, true);
 	}
@@ -396,12 +401,19 @@ static void mask_ipv6_addr(const __be32 old[4], const __be32 addr[4],
 	masked[3] = OVS_MASKED(old[3], addr[3], mask[3]);
 }
 
+/* May move the skb head; callers must reload packet pointers. */
 static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
 			  __be32 addr[4], const __be32 new_addr[4],
 			  bool recalculate_csum)
 {
-	if (recalculate_csum)
-		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
+	unsigned int addr_offset = (u8 *)addr - skb_network_header(skb);
+	__be32 old_addr[4];
+
+	if (recalculate_csum) {
+		memcpy(old_addr, addr, sizeof(old_addr));
+		update_ipv6_checksum(skb, l4_proto, old_addr, new_addr);
+		addr = (__be32 *)(skb_network_header(skb) + addr_offset);
+	}
 
 	skb_clear_hash(skb);
 	ovs_ct_clear(skb, NULL);
@@ -479,16 +491,18 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		new_addr = OVS_MASKED(nh->saddr, key->ipv4_src, mask->ipv4_src);
 
 		if (unlikely(new_addr != nh->saddr)) {
-			set_ip_addr(skb, nh, &nh->saddr, new_addr);
+			set_ip_addr(skb, &nh->saddr, new_addr);
 			flow_key->ipv4.addr.src = new_addr;
+			nh = ip_hdr(skb);
 		}
 	}
 	if (mask->ipv4_dst) {
 		new_addr = OVS_MASKED(nh->daddr, key->ipv4_dst, mask->ipv4_dst);
 
 		if (unlikely(new_addr != nh->daddr)) {
-			set_ip_addr(skb, nh, &nh->daddr, new_addr);
+			set_ip_addr(skb, &nh->daddr, new_addr);
 			flow_key->ipv4.addr.dst = new_addr;
+			nh = ip_hdr(skb);
 		}
 	}
 	if (mask->ipv4_tos) {
@@ -537,6 +551,7 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
 				      true);
 			memcpy(&flow_key->ipv6.addr.src, masked,
 			       sizeof(flow_key->ipv6.addr.src));
+			nh = ipv6_hdr(skb);
 		}
 	}
 	if (is_ipv6_mask_nonzero(mask->ipv6_dst)) {
@@ -559,6 +574,7 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
 				      recalc_csum);
 			memcpy(&flow_key->ipv6.addr.dst, masked,
 			       sizeof(flow_key->ipv6.addr.dst));
+			nh = ipv6_hdr(skb);
 		}
 	}
 	if (mask->ipv6_tclass) {

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.55.0.openai.911.g06873a30d2f3

