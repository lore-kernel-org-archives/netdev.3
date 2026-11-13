Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612126;
	b=Nhd3TRJHCXyo1zGRv4nDaJhhUhun7JoY0yrBxmaZlHwbj8obp/HTHs/ok4BQxM02hppB
	 9bHW7CFOliN7cO5bOJ4dD3/bwyrD63nwNsfscrMvc0fRUyYUGEpAfqmEAl1wCHK0bhdvJ
	 rmDCl3g+5wfeoFLR2g3xVWAAZot2ixxKTxi+pPYnZihy9a2z4aoguRtxJ4Ed83C0Dt9/x
	 ht77xZnyie1WAKQO/CBmDZv4VdgH7iy3ASf08iZO+31TvxO0aqtlQKpF8u8WmGEHYKk8n
	 5adlr2VA5Srle7ZNiK66mM4rblqWynh69vdPW3LLdg8jQple0oXfYdnJBIyscB+KQZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eG8sIetC7zpwDTaN+oZEyMcNNgTpFmawbIcCT4kAbrI=;
	b=RwMZYxeVQ8FABn94xx0T0mvDdVCMkvE7sVSCFF6rPqX6ZCSv0I8OJEHOH6qWAv6WD3Sy
	 jAY6TxgPHx3PR0i6uZg+MOigKtg2GWHi8IriqvzYIwsvbRHeKCvTMpDPlw4Qroe+JyaOb
	 Vh3evguGeWWQ2cWD15I5zg3UlNtkXf+ts/IdM8kG8SWEik0oN+BCOo+v3csXwbkgSwUdq
	 BzBd3O7XaxxiCfcKXCWr5jQUsquWWD4d88rcPDO3E2Eeq2nWJemlijLa8OudOwq/1qO/i
	 eaur5NcqJa10y+BLLVFxKMD093rixVS+neAGJVwJk8BxFlFA7k2ONM+18w0fJywxoOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=NDNfvu1w;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A68606A329
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21A68606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=NDNfvu1w
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c847584b8so27129016d6.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794612125; x=1795216925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eG8sIetC7zpwDTaN+oZEyMcNNgTpFmawbIcCT4kAbrI=;
        b=NDNfvu1wf2iRj16DT3eUT5BRV92q1asM15vPRmZxAqSpfgP3gBLrjzeJaET6RmRZM6
         0qfP2ZejcU0vRUhpJwVNKqJheYuxmBuOIZWRPaqnj0Pc8gc1g3wmsdeyqxVqeD1r1uaw
         mStX/kqos1G2GzJnUkZEWO/pQAF7tie370CcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794612125; x=1795216925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eG8sIetC7zpwDTaN+oZEyMcNNgTpFmawbIcCT4kAbrI=;
        b=JRvT96CJwg1QHgvAUh6rD/Yjy9TQanmUs5Zh88sKa40huJzTl9ZyaLZkrwBO7pcacY
         3uRa+Y732CFQMQlofzN4e9VuWpZ7xzyMOVV5E9lF9P7xni1d3tw3hz8WYJFp50o6MZrP
         j3tV+TtPp9wMtqBCCmzIZyMkSqPIHgORiIRAzlWaUW0ktQAr6ibHG+IAL0+Q+AHod+Qk
         xDj6QWFFaoeRUCnVrXrbnDJKLDmGeBzluKDYMOcjaAGRIbn5hmJkKx+eXtKRWD5lM/qX
         SnqfGsO6XUUS+JoLiOKXGBeJc/SpKXFJrMDpmWzAIXjGPOdWKF6IPsQfRxOWt2H28JRH
         /0kw==
X-Gm-Message-State: APuU4Z/Kc2sMkeJUFOhNRgANurwDBdiGFYvAN+WIZi5lmHf4YgySt+Yk
	WylKxV5ppjeCIESAC4QEbnvLTSftTnJE5CWdE6KzGcY2MUJqZTppgq6Qh50OS+cGA7w=
X-Gm-Gg: AYBFou12GRi2QWsY8z1PpuwC4sP5Vfw8acTgK4k6XBNqaCL8ke6y+HduwWfwK1dcuac
	WzxWLk13g6B2FqQyR0HlJEwLL/jmJtq93+KQb6pH1SQRC0qQp8f2PI8EJmqTMQvKxp48IVs6QtH
	4d2u17yGdvJoYOqyLvkVFRx73ulBM/3eKX/NwESnpNeRm86Pf4PJT7mNTETdLRByp3kmEmAK+PA
	GeKVHRBXhrEeYJ+1kZeU8ZLRYdcL0oo5FJswCFnqW1GJCyfY4/9CLpweQp4xOY5SLU7MSpegrTH
	s+Xn+ByFp+xj7ftUUrVPwdE2JldsDbqwiAYYFA+DSKah6hR/5mW1y68TL8ts5KtZInBdqMd5FVH
	eYue0wjANZZszgPaCIs46cS4kpjFYnWyMgJPqpIQVUNr8IGF567GiE009I6A7vJZIubWZDi9axs
	5efocY/BvFkFG5smMnfp+l1RmCLpTGHoSd1j6xvPIhG12wqHwykIotAahA1PrFCFO4DgfW1+0P+
	fNguXWoVgTcH0c9FaQZVdJOLf6v8ZxKr26KMRFXVOeRccb6ly5Xvp5hOsXj4+Cuvo9C+PmA1uQy
	rGzyKPPX9Ozq0DN3EOGkm9HN/iQzNcIgpLO+PML2nF8oFDLoyh/LtwSptg62YYrNzTIRFKsgALE
	v0nZI6oPkIiNGPlaoJGN1sf6Ht/EN9bmI6MJWzB+TSxD1YgHJAz8=
X-Received: by 2002:a05:6214:d8d:b0:91f:ffc:69cf with SMTP id 6a1803df08f44-91f13a9513emr121471506d6.35.1794612124812;
        Fri, 13 Nov 2026 15:22:04 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7b607sm31147806d6.26.2026.11.13.15.22.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 15:22:04 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: dev@openvswitch.org
Cc: netdev@vger.kernel.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: openvswitch: make transport checksums writable
Date: Fri, 13 Nov 2026 15:21:58 -0800
Message-ID: <20261113232158.61174-1-kylebot@openai.com>
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

OVS can still rewrite an IP address after transport-header extraction
fails. The checksum helpers check skb->len, which includes non-linear
data, before directly accessing the L4 checksum. If the transport header
was not pulled into the linear head, the checksum update can read or
write beyond it.

Call skb_ensure_writable() before IPv4 TCP/UDP and IPv6 TCP/UDP/ICMPv6
checksum updates. Save the original addresses and reload header pointers,
since even a failed pull can move the skb head.

Keep failures nonfatal to preserve the existing policy of rewriting IP
addresses when the transport header is unavailable. A failed pull or
unshare may leave a stale checksum or CHECKSUM_PARTIAL seed; the receiver
may discard the packet.

The issue was found by an LLM.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v3:
- Select source and destination addresses with booleans instead of
  calculating offsets. Keep the saved IPv6 address across head movement.
- Remove the redundant IPv6 fragment check and correct tab alignment.
- Move testing details below the separator and clean up attribution.

v2: https://lore.kernel.org/r/20261107040238.27606-1-kylebot@openai.com
v1: https://lore.kernel.org/r/20261030042304.74291-1-kylebot@openai.com

I have a reproducer for this issue and can share through DM.

 net/openvswitch/actions.c | 77 +++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 12e339cbf791..3b10b3fbadc3 100644
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
+						sizeof(struct tcphdr))))
 			inet_proto_csum_replace4(&tcp_hdr(skb)->check, skb,
 						 addr, new_addr, true);
 	} else if (nh->protocol == IPPROTO_UDP) {
-		if (likely(transport_len >= sizeof(struct udphdr))) {
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+						sizeof(struct udphdr)))) {
 			struct udphdr *uh = udp_hdr(skb);
 
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -345,32 +347,34 @@ static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
 	}
 }
 
-static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
-			__be32 *addr, __be32 new_addr)
+/* May move the skb head; callers must reload packet pointers. */
+static void set_ip_addr(struct sk_buff *skb, __be32 new_addr, bool saddr)
 {
-	update_ip_l4_checksum(skb, nh, *addr, new_addr);
-	csum_replace4(&nh->check, *addr, new_addr);
+	__be32 old_addr = saddr ? ip_hdr(skb)->saddr : ip_hdr(skb)->daddr;
+
+	update_ip_l4_checksum(skb, old_addr, new_addr);
+	csum_replace4(&ip_hdr(skb)->check, old_addr, new_addr);
+
 	skb_clear_hash(skb);
 	ovs_ct_clear(skb, NULL);
-	*addr = new_addr;
+
+	if (saddr)
+		ip_hdr(skb)->saddr = new_addr;
+	else
+		ip_hdr(skb)->daddr = new_addr;
 }
 
 static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
 				 __be32 addr[4], const __be32 new_addr[4])
 {
-	int transport_len;
-
-	if (l4_proto == NEXTHDR_FRAGMENT)
-		return;
-
-	transport_len = skb->len - skb_transport_offset(skb);
-
 	if (l4_proto == NEXTHDR_TCP) {
-		if (likely(transport_len >= sizeof(struct tcphdr)))
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+						sizeof(struct tcphdr))))
 			inet_proto_csum_replace16(&tcp_hdr(skb)->check, skb,
 						  addr, new_addr, true);
 	} else if (l4_proto == NEXTHDR_UDP) {
-		if (likely(transport_len >= sizeof(struct udphdr))) {
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+						sizeof(struct udphdr)))) {
 			struct udphdr *uh = udp_hdr(skb);
 
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -381,7 +385,8 @@ static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
 			}
 		}
 	} else if (l4_proto == NEXTHDR_ICMP) {
-		if (likely(transport_len >= sizeof(struct icmp6hdr)))
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+						sizeof(struct icmp6hdr))))
 			inet_proto_csum_replace16(&icmp6_hdr(skb)->icmp6_cksum,
 						  skb, addr, new_addr, true);
 	}
@@ -396,16 +401,28 @@ static void mask_ipv6_addr(const __be32 old[4], const __be32 addr[4],
 	masked[3] = OVS_MASKED(old[3], addr[3], mask[3]);
 }
 
+/* May move the skb head; callers must reload packet pointers. */
 static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
-			  __be32 addr[4], const __be32 new_addr[4],
+			  const __be32 new_addr[4], bool saddr,
 			  bool recalculate_csum)
 {
-	if (recalculate_csum)
-		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
+	struct ipv6hdr *nh = ipv6_hdr(skb);
+	__be32 old_addr[4];
+
+	if (recalculate_csum) {
+		memcpy(old_addr, saddr ? &nh->saddr : &nh->daddr,
+		       sizeof(old_addr));
+		update_ipv6_checksum(skb, l4_proto, old_addr, new_addr);
+		nh = ipv6_hdr(skb);
+	}
 
 	skb_clear_hash(skb);
 	ovs_ct_clear(skb, NULL);
-	memcpy(addr, new_addr, sizeof(__be32[4]));
+
+	if (saddr)
+		memcpy(&nh->saddr, new_addr, sizeof(__be32[4]));
+	else
+		memcpy(&nh->daddr, new_addr, sizeof(__be32[4]));
 }
 
 static void set_ipv6_dsfield(struct sk_buff *skb, struct ipv6hdr *nh, u8 ipv6_tclass, u8 mask)
@@ -479,16 +496,18 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		new_addr = OVS_MASKED(nh->saddr, key->ipv4_src, mask->ipv4_src);
 
 		if (unlikely(new_addr != nh->saddr)) {
-			set_ip_addr(skb, nh, &nh->saddr, new_addr);
+			set_ip_addr(skb, new_addr, true);
 			flow_key->ipv4.addr.src = new_addr;
+			nh = ip_hdr(skb);
 		}
 	}
 	if (mask->ipv4_dst) {
 		new_addr = OVS_MASKED(nh->daddr, key->ipv4_dst, mask->ipv4_dst);
 
 		if (unlikely(new_addr != nh->daddr)) {
-			set_ip_addr(skb, nh, &nh->daddr, new_addr);
+			set_ip_addr(skb, new_addr, false);
 			flow_key->ipv4.addr.dst = new_addr;
+			nh = ip_hdr(skb);
 		}
 	}
 	if (mask->ipv4_tos) {
@@ -533,10 +552,11 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		mask_ipv6_addr(saddr, key->ipv6_src, mask->ipv6_src, masked);
 
 		if (unlikely(memcmp(saddr, masked, sizeof(masked)))) {
-			set_ipv6_addr(skb, flow_key->ip.proto, saddr, masked,
+			set_ipv6_addr(skb, flow_key->ip.proto, masked, true,
 				      true);
 			memcpy(&flow_key->ipv6.addr.src, masked,
 			       sizeof(flow_key->ipv6.addr.src));
+			nh = ipv6_hdr(skb);
 		}
 	}
 	if (is_ipv6_mask_nonzero(mask->ipv6_dst)) {
@@ -555,10 +575,11 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
 							     NULL, &flags)
 					       != NEXTHDR_ROUTING);
 
-			set_ipv6_addr(skb, flow_key->ip.proto, daddr, masked,
+			set_ipv6_addr(skb, flow_key->ip.proto, masked, false,
 				      recalc_csum);
 			memcpy(&flow_key->ipv6.addr.dst, masked,
 			       sizeof(flow_key->ipv6.addr.dst));
+			nh = ipv6_hdr(skb);
 		}
 	}
 	if (mask->ipv6_tclass) {

base-commit: 2800868f63227c8237d70c41e70d441c919620d6
-- 
2.55.0.openai.911.g06873a30d2f3

