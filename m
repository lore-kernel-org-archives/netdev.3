Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00766396B7F
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478880; cv=none; b=iKCZ6R563L7IpbK+REnzf1dAbx7AM41G3+AKZi3rOnc6T7f12xOVFk6cd/O40cUfL1lwCcgcukVpMyUa1ufBElRKCwtFOThlRXz50K50Zf3/qNvdtqHwvGGim4P//wZQPSUlgCgEnSCNQj/S47Q2nD7SpAbprxFXAsAf3eZFMqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478880; c=relaxed/simple;
	bh=sODTw4lkgTJwelczMMHcIhHau54BuPo/Fs1fFg7jQRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6wUS7M46fBKpgGNo7UI5t1sG/RlHKB/cuA9wbmVOGFeyIJjho4o3126OB+6LzBeXX1eaix3hCLsEj7Q6gJOGIEfhKk6f2fL0KRDgTJNSDEwvlM3uOVFihWHdN7ta7u0mYcjx6XR3g4aqSQzG7NsB1IG4O2aekfLJmmvdZgK7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UGTKI6cG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UGTKI6cG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=aZMbzGb+0qGCpaYD2FWrtMaPjY5n8owf0RTtb4CpeQE=; b=UGTKI6cGT3ATL2Ui37mp42z9r1
	CgSQChRT1wadYEA5JUOjFktItaA+f6YeckNetP9+SdvclGSJ0enDb+IRS0Pn+o2SVmh/P4PACkm5W
	gEOlysRWvwuT/JCUlzYhEZpzo6Ydo10eZPgPT8K/zuNpYmvgAXjei69IxYYghu1rJnXMsqE2XlBFn
	svHHltT12kG5T3N3WnXKWfqBR7iY6Cd8jV+ALBFr1Qr7TtXhs0HmQNE3/QOyVrTq/uOuznBRdt2AQ
	hPgVm2S9cPgKLKL3JHPpxWa6o+76VEQRQy+kvywM31SOTWELlXgw46GTuX/pvkTX5GE7RyXjSPC4c
	xDA5sreg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wI77h-000DxD-1a;
	Wed, 29 Apr 2026 17:46:49 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: edumazet@google.com,
	dsahern@kernel.org,
	tom@herbertland.com,
	willemdebruijn.kernel@gmail.com,
	idosch@nvidia.com,
	pabeni@redhat.com,
	justin.iurman@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v5] ipv6: Implement limits on extension header parsing
Date: Wed, 29 Apr 2026 17:46:48 +0200
Message-ID: <20260429154648.809751-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27986/Wed Apr 29 08:25:43 2026)

ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
protocol_deliver_rcu}() iterate over IPv6 extension headers until they
find a non-extension-header protocol or run out of packet data. The
loops have no iteration counter, relying solely on the packet length
to bound them. For a crafted packet with 8-byte extension headers
filling a 64KB jumbogram, this means a worst case of up to ~8k
iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
for example, is used where it parses the inner quoted packet inside
an incoming ICMPv6 error:

  - icmpv6_rcv
    - checksum validation
    - case ICMPV6_DEST_UNREACH
      - icmpv6_notify
        - pskb_may_pull()       <- pull inner IPv6 header
        - ipv6_skip_exthdr()    <- iterates here
        - pskb_may_pull()
        - ipprot->err_handler() <- sk lookup

The per-iteration cost of ipv6_skip_exthdr itself is generally
light, but skb_header_pointer becomes more costly on reassembled
packets: the first ~1232 bytes of the inner packet are in the skb's
linear area, but the remaining ~63KB are in the frag_list where
skb_copy_bits is needed to read data.

Initially, the idea was to add a configurable limit via a new
sysctl knob with default 8, in line with knobs from commit
47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and Destination
options"), but two reasons eventually argued against it:

- It adds to UAPI that needs to be maintained forever, and
  upcoming work is restricting extension header ordering anyway,
  leaving little reason for another sysctl knob
- exthdrs_core.c is always built-in even when CONFIG_IPV6=n,
  where struct net has no .ipv6 member, so the read site would
  need an ifdef'd fallback to a constant anyway

Therefore, just use a constant (IP6_MAX_EXT_HDRS_CNT). All four
extension header walking functions are now bound by this limit.

Note that the check in ip6_protocol_deliver_rcu() happens right
before the goto resubmit, such that we don't have to have a test
for ipv6_ext_hdr() in the fast-path.

There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
IPv6 extension headers ordering and occurrence. The latter also
discusses security implications. As per RFC8200 section 4.1, the
occurrence rules for extension headers provide a practical upper
bound which is 8. In order to be conservative, let's define
IP6_MAX_EXT_HDRS_CNT as 12 to leave enough room for quirky setups.
In the unlikely event that this is still not enough, then we might
need to reconsider a sysctl.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v4->v5:
   - Reduce the hard-coded limit from 32 to 12 (Justin)
   - Rest as-is
 v3->v4:
   - Switching to hard-coded define with 32 limit as discussed
     earlier, otherwise fixing the kbuild-bot error becomes
     to ugly.. was worth a try, but given the case of being
     built-in also with CONFIG_IPV6=n define seems better
     (Justin, Victor, kbuild-bot)
 v2->v3:
   - Adding IP6SKB_HOPBYHOP coverage (Justin)
   - I left the limit at 8 w/ sysctl, still feels the better
     option to me if we can keep the worst-case more tightened
 v1->v2:
   - Set the default to 8 (Justin)
   - Update IETF references (Justin)
   - Add core path coverage as well (Justin)

 include/net/dropreason-core.h | 6 ++++++
 include/net/ipv6.h            | 3 +++
 net/ipv6/exthdrs_core.c       | 7 +++++++
 net/ipv6/ip6_input.c          | 5 +++++
 net/ipv6/ip6_tunnel.c         | 4 ++++
 5 files changed, 25 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index e0ca3904ff8e..2f312d1f67d6 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -99,6 +99,7 @@
 	FN(FRAG_TOO_FAR)		\
 	FN(TCP_MINTTL)			\
 	FN(IPV6_BAD_EXTHDR)		\
+	FN(IPV6_TOO_MANY_EXTHDRS)	\
 	FN(IPV6_NDISC_FRAG)		\
 	FN(IPV6_NDISC_HOP_LIMIT)	\
 	FN(IPV6_NDISC_BAD_CODE)		\
@@ -494,6 +495,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_MINTTL,
 	/** @SKB_DROP_REASON_IPV6_BAD_EXTHDR: Bad IPv6 extension header. */
 	SKB_DROP_REASON_IPV6_BAD_EXTHDR,
+	/**
+	 * @SKB_DROP_REASON_IPV6_TOO_MANY_EXTHDRS: Number of IPv6 extension
+	 * headers in the packet exceeds IP6_MAX_EXT_HDRS_CNT.
+	 */
+	SKB_DROP_REASON_IPV6_TOO_MANY_EXTHDRS,
 	/** @SKB_DROP_REASON_IPV6_NDISC_FRAG: invalid frag (suppress_frag_ndisc). */
 	SKB_DROP_REASON_IPV6_NDISC_FRAG,
 	/** @SKB_DROP_REASON_IPV6_NDISC_HOP_LIMIT: invalid hop limit. */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d042afe7a245..1dec81faff28 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -90,6 +90,9 @@ struct ip_tunnel_info;
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
+/* Hard limit on traversed IPv6 extension headers */
+#define IP6_MAX_EXT_HDRS_CNT		 12
+
 /*
  *	Addr type
  *	
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 49e31e4ae7b7..9d06d487e8b1 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -73,6 +73,7 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 		     __be16 *frag_offp)
 {
 	u8 nexthdr = *nexthdrp;
+	int exthdr_cnt = 0;
 
 	*frag_offp = 0;
 
@@ -82,6 +83,8 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 
 		if (nexthdr == NEXTHDR_NONE)
 			return -1;
+		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
+			return -1;
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
 		if (!hp)
 			return -1;
@@ -190,6 +193,7 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 {
 	unsigned int start = skb_network_offset(skb) + sizeof(struct ipv6hdr);
 	u8 nexthdr = ipv6_hdr(skb)->nexthdr;
+	int exthdr_cnt = 0;
 	bool found;
 
 	if (fragoff)
@@ -216,6 +220,9 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 			return -ENOENT;
 		}
 
+		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
+			return -EBADMSG;
+
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
 		if (!hp)
 			return -EBADMSG;
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 967b07aeb683..8972863c93ee 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -403,6 +403,7 @@ INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *));
 void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 			      bool have_final)
 {
+	int exthdr_cnt = IP6CB(skb)->flags & IP6SKB_HOPBYHOP ? 1 : 0;
 	const struct inet6_protocol *ipprot;
 	struct inet6_dev *idev;
 	unsigned int nhoff;
@@ -487,6 +488,10 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 				nexthdr = ret;
 				goto resubmit_final;
 			} else {
+				if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT)) {
+					SKB_DR_SET(reason, IPV6_TOO_MANY_EXTHDRS);
+					goto discard;
+				}
 				goto resubmit;
 			}
 		} else if (ret == 0) {
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index c468c83af0f2..9d1037ac082f 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -399,11 +399,15 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
 	unsigned int nhoff = raw - skb->data;
 	unsigned int off = nhoff + sizeof(*ipv6h);
 	u8 nexthdr = ipv6h->nexthdr;
+	int exthdr_cnt = 0;
 
 	while (ipv6_ext_hdr(nexthdr) && nexthdr != NEXTHDR_NONE) {
 		struct ipv6_opt_hdr *hdr;
 		u16 optlen;
 
+		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
+			break;
+
 		if (!pskb_may_pull(skb, off + sizeof(*hdr)))
 			break;
 
-- 
2.43.0

