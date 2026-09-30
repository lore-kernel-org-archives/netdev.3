Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B264BB27E;
	Wed, 30 Sep 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776484; cv=none; b=B+RMf8krZG3fOfJrr/blkKn1iem1vhmjaeAggx2WEV1/Xaa/tlTRmJ//EjGXE7plLtAZG48AWuNY9v7rfluWyCXO6PoCB3wtzukfbanACA7ttScasZ7djlDyKNVIfGR/VpZOxkLfiOvR3S520IdJKWkm6cvcqMJj7Ep7gnXFfj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776484; c=relaxed/simple;
	bh=+QqBMpua7/ip1Agt+oyD1+VXp+IpirgjbVO/9BhVUSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPIFrrRxUqVFhmFCb06rVSfUa7u975rjeZj0AxUv92M0kTe/DSTtwEjNr/Zwi50eZhxi7HeXSuNE8ZZQVpcCbsZGR+9FOauYVgHBuXI2kV6x2BTgzgvGvllw79dyK+vOEWVV7skEc+l5FCCjn0FBmr576zcyUBB+fFUI+fe3CQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xjFBv0uY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NEpEbTJT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YOcqdp1n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1iqL9A3u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xjFBv0uY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NEpEbTJT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YOcqdp1n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1iqL9A3u"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41DC31F7EE;
	Wed, 30 Sep 2026 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790776462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBjgLkf+tF6jYGZBBAAf7pIMDfN+uvhAvBvGSjvb5xs=;
	b=xjFBv0uY1AT4bNN9ALqlYwRuFovLyM24d2cVRfL96/cE5pQCSpZpxv4G+NwyDCK7bQ41H5
	dGhEs05knam5VWC3wFLah2+ugKHf257f/Gnu0O9mVOjlZNMhJbRiG9R3tae3dMtwiNJPkC
	SuRExCA5F5PyM/dXH4qK9zvZg/3oK4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790776462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBjgLkf+tF6jYGZBBAAf7pIMDfN+uvhAvBvGSjvb5xs=;
	b=NEpEbTJTTjxHnc3ZB52bGKmBrKqjdR4x/U1AiErlZsH4z5jvg5qIfJfK5jRaq4REeQbRaa
	fyeo1k0yGX+YS1AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790776458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBjgLkf+tF6jYGZBBAAf7pIMDfN+uvhAvBvGSjvb5xs=;
	b=YOcqdp1neGie2IKTgIBZ40x4P9JTh+2IoWd6RKooINPJtqsBS5+5q8agES1DWCMMGdaVsE
	eSjUFKqFpJfWyIT1CdehwHLXq0bZk6DGE3z1D3Acm73OriGWF9W1v334nqptxOBvGg/S9g
	9o2WwYwUy4dDcd+7T7EVTNZ7tBNO53Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790776458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBjgLkf+tF6jYGZBBAAf7pIMDfN+uvhAvBvGSjvb5xs=;
	b=1iqL9A3uNVQ5/lIbgIZpAGDlv42qjkiVm1HT4V0l5aQxNoSmX+q7CY6+EERAwgnbaZy4+R
	xZcA89UquM3EYpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D4A13722;
	Wed, 30 Sep 2026 13:54:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJXpHGIUvWqUTwAAD6G6ig:T6
	(envelope-from <fmancera@suse.de>); Wed, 30 Sep 2026 13:54:16 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Eric Dumazet <edumazet@google.com>,
	Julian Anastasov <ja@ssi.bg>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Florian Westphal <fw@strlen.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/16 net-next v3] ipv4: raw: split IPv4 specific logic into raw_ipv4.c
Date: Wed, 30 Sep 2026 15:52:48 +0200
Message-ID: <20260930135334.4739-6-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260930135334.4739-1-fmancera@suse.de>
References: <20260930135334.4739-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,davemloft.net,suse.de,google.com,ssi.bg,strlen.de,seu.edu.cn,gmail.com,debian.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLrr9ek4ud4f4qwi71m7motjzt)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO

To enable compiling the INET subsystem without IPv4, RAW socket IPv4
specific functions must be isolated from the generic RAW socket
infrastructure, similar to how it is done for TCP.

This patch creates raw_ipv4.c and move all the functions for packet
matching, input/output processing, ICMP filtering and the AF_INET
raw_prot definition from raw.c to the new file. The Makefile is updated
to compile raw_ipv4.c only when CONFIG_IPV4 is enabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/Makefile   |   2 +-
 net/ipv4/raw.c      | 853 ------------------------------------------
 net/ipv4/raw_diag.c |   3 +-
 net/ipv4/raw_ipv4.c | 884 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 887 insertions(+), 855 deletions(-)
 create mode 100644 net/ipv4/raw_ipv4.c

diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 8b148be79fa4..7ac882ec5d4f 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -13,7 +13,7 @@ obj-y     := inetpeer.o protocol.o inet_hashtables.o inet_timewait_sock.o \
 obj-$(CONFIG_IPV4) += route.o ip_input.o ip_fragment.o ip_forward.o ip_options.o \
 		      ip_sockglue.o tcp_ipv4.o datagram.o icmp.o arp.o devinet.o \
 		      igmp.o fib_notifier.o ip_output.o fib_frontend.o \
-		      fib_semantics.o fib_trie.o
+		      fib_semantics.o fib_trie.o raw_ipv4.o
 
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 9d01006d8189..dcd554d92082 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -38,7 +38,6 @@
 #include <asm/byteorder.h>
 #include <asm/current.h>
 #include <linux/uaccess.h>
-#include <asm/ioctls.h>
 #include <linux/stddef.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -48,31 +47,25 @@
 #include <linux/sockios.h>
 #include <linux/socket.h>
 #include <linux/in.h>
-#include <linux/mroute.h>
 #include <linux/netdevice.h>
 #include <linux/in_route.h>
 #include <linux/route.h>
 #include <linux/skbuff.h>
-#include <linux/igmp.h>
 #include <net/net_namespace.h>
 #include <net/dst.h>
 #include <net/sock.h>
 #include <linux/ip.h>
 #include <linux/net.h>
 #include <net/ip.h>
-#include <net/icmp.h>
 #include <net/udp.h>
 #include <net/raw.h>
 #include <net/snmp.h>
 #include <net/tcp_states.h>
 #include <net/inet_common.h>
 #include <net/checksum.h>
-#include <net/xfrm.h>
 #include <linux/rtnetlink.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/netfilter.h>
-#include <linux/netfilter_ipv4.h>
 #include <linux/compat.h>
 #include <linux/uio.h>
 
@@ -114,824 +107,6 @@ void raw_unhash_sk(struct sock *sk)
 	spin_unlock(&h->lock);
 }
 
-bool raw_v4_match(struct net *net, const struct sock *sk, unsigned short num,
-		  __be32 raddr, __be32 laddr, int dif, int sdif)
-{
-	const struct inet_sock *inet = inet_sk(sk);
-	__be32 daddr, rcv_saddr;
-
-	if (!net_eq(sock_net(sk), net) || inet->inet_num != num)
-		return false;
-
-	daddr = READ_ONCE(inet->inet_daddr);
-	if (daddr && daddr != raddr)
-		return false;
-
-	rcv_saddr = READ_ONCE(inet->inet_rcv_saddr);
-	if (rcv_saddr && rcv_saddr != laddr)
-		return false;
-
-	return raw_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if),
-				   dif, sdif);
-}
-EXPORT_SYMBOL_GPL(raw_v4_match);
-
-/*
- *	0 - deliver
- *	1 - block
- */
-static int icmp_filter(const struct sock *sk, const struct sk_buff *skb)
-{
-	struct icmphdr _hdr;
-	const struct icmphdr *hdr;
-
-	hdr = skb_header_pointer(skb, skb_transport_offset(skb),
-				 sizeof(_hdr), &_hdr);
-	if (!hdr)
-		return 1;
-
-	if (hdr->type < 32) {
-		__u32 data = raw_sk(sk)->filter.data;
-
-		return ((1U << hdr->type) & data) != 0;
-	}
-
-	/* Do not block unknown ICMP types */
-	return 0;
-}
-
-/* IP input processing comes here for RAW socket delivery.
- * Caller owns SKB, so we must make clones.
- *
- * RFC 1122: SHOULD pass TOS value up to the transport layer.
- * -> It does. And not only TOS, but all IP header.
- */
-static int raw_v4_input(struct net *net, struct sk_buff *skb,
-			const struct iphdr *iph, int hash)
-{
-	int sdif = inet_sdif(skb);
-	struct hlist_head *hlist;
-	int dif = inet_iif(skb);
-	int delivered = 0;
-	struct sock *sk;
-
-	hlist = &raw_v4_hashinfo.ht[hash];
-	rcu_read_lock();
-	sk_for_each_rcu(sk, hlist) {
-		if (!raw_v4_match(net, sk, iph->protocol,
-				  iph->saddr, iph->daddr, dif, sdif))
-			continue;
-
-		if (atomic_read(&sk->sk_rmem_alloc) >=
-		    READ_ONCE(sk->sk_rcvbuf)) {
-			sk_drops_inc(sk);
-			continue;
-		}
-
-		delivered = 1;
-		if ((iph->protocol != IPPROTO_ICMP || !icmp_filter(sk, skb)) &&
-		    ip_mc_sf_allow(sk, iph->daddr, iph->saddr,
-				   skb->dev->ifindex, sdif)) {
-			struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
-
-			/* Not releasing hash table! */
-			if (clone)
-				raw_rcv(sk, clone);
-		}
-	}
-	rcu_read_unlock();
-	return delivered;
-}
-
-int raw_local_deliver(struct sk_buff *skb, int protocol)
-{
-	struct net *net = dev_net(skb->dev);
-
-	return raw_v4_input(net, skb, ip_hdr(skb),
-			    raw_hashfunc(net, protocol));
-}
-
-static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
-{
-	struct inet_sock *inet = inet_sk(sk);
-	const int type = icmp_hdr(skb)->type;
-	const int code = icmp_hdr(skb)->code;
-	int harderr = 0;
-	bool recverr;
-	int err = 0;
-
-	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
-		ipv4_sk_update_pmtu(skb, sk, info);
-	else if (type == ICMP_REDIRECT) {
-		ipv4_sk_redirect(skb, sk);
-		return;
-	}
-
-	/* Report error on raw socket, if:
-	   1. User requested ip_recverr.
-	   2. Socket is connected (otherwise the error indication
-	      is useless without ip_recverr and error is hard.
-	 */
-	recverr = inet_test_bit(RECVERR, sk);
-	if (!recverr && sk->sk_state != TCP_ESTABLISHED)
-		return;
-
-	switch (type) {
-	default:
-	case ICMP_TIME_EXCEEDED:
-		err = EHOSTUNREACH;
-		break;
-	case ICMP_SOURCE_QUENCH:
-		return;
-	case ICMP_PARAMETERPROB:
-		err = EPROTO;
-		harderr = 1;
-		break;
-	case ICMP_DEST_UNREACH:
-		err = EHOSTUNREACH;
-		if (code > NR_ICMP_UNREACH)
-			break;
-		if (code == ICMP_FRAG_NEEDED) {
-			harderr = READ_ONCE(inet->pmtudisc) != IP_PMTUDISC_DONT;
-			err = EMSGSIZE;
-		} else {
-			err = icmp_err_convert[code].errno;
-			harderr = icmp_err_convert[code].fatal;
-		}
-	}
-
-	if (recverr) {
-		const struct iphdr *iph = (const struct iphdr *)skb->data;
-		u8 *payload = skb->data + (iph->ihl << 2);
-
-		if (inet_test_bit(HDRINCL, sk))
-			payload = skb->data;
-		ip_icmp_error(sk, skb, err, 0, info, payload);
-	}
-
-	if (recverr || harderr) {
-		sk->sk_err = err;
-		sk_error_report(sk);
-	}
-}
-
-void raw_icmp_error(struct sk_buff *skb, int protocol, u32 info)
-{
-	struct net *net = dev_net(skb->dev);
-	int dif = skb->dev->ifindex;
-	int sdif = inet_sdif(skb);
-	struct hlist_head *hlist;
-	const struct iphdr *iph;
-	struct sock *sk;
-	int hash;
-
-	hash = raw_hashfunc(net, protocol);
-	hlist = &raw_v4_hashinfo.ht[hash];
-
-	rcu_read_lock();
-	sk_for_each_rcu(sk, hlist) {
-		iph = (const struct iphdr *)skb->data;
-		if (!raw_v4_match(net, sk, iph->protocol,
-				  iph->daddr, iph->saddr, dif, sdif))
-			continue;
-		raw_err(sk, skb, info);
-	}
-	rcu_read_unlock();
-}
-
-static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
-{
-	enum skb_drop_reason reason;
-
-	/* Charge it to the socket. */
-
-	ipv4_pktinfo_prepare(sk, skb, true);
-	reason = sock_queue_rcv_skb_reason(sk, skb);
-	if (reason) {
-		sk_skb_reason_drop(sk, skb, reason);
-		return NET_RX_DROP;
-	}
-
-	return NET_RX_SUCCESS;
-}
-
-int raw_rcv(struct sock *sk, struct sk_buff *skb)
-{
-	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
-		sk_drops_inc(sk);
-		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
-		return NET_RX_DROP;
-	}
-	nf_reset_ct(skb);
-
-	skb_push(skb, -skb_network_offset(skb));
-
-	raw_rcv_skb(sk, skb);
-	return 0;
-}
-
-static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
-			   struct msghdr *msg, size_t length,
-			   struct rtable **rtp, unsigned int flags,
-			   const struct sockcm_cookie *sockc)
-{
-	struct inet_sock *inet = inet_sk(sk);
-	struct net *net = sock_net(sk);
-	struct iphdr *iph;
-	struct sk_buff *skb;
-	unsigned int iphlen;
-	int err;
-	struct rtable *rt = *rtp;
-	int hlen, tlen;
-
-	if (length > rt->dst.dev->mtu) {
-		ip_local_error(sk, EMSGSIZE, fl4->daddr, inet->inet_dport,
-			       rt->dst.dev->mtu);
-		return -EMSGSIZE;
-	}
-	if (length < sizeof(struct iphdr))
-		return -EINVAL;
-
-	if (flags&MSG_PROBE)
-		goto out;
-
-	hlen = LL_RESERVED_SPACE(rt->dst.dev);
-	tlen = rt->dst.dev->needed_tailroom;
-	skb = sock_alloc_send_skb(sk,
-				  length + hlen + tlen + 15,
-				  flags & MSG_DONTWAIT, &err);
-	if (!skb)
-		goto error;
-	skb_reserve(skb, hlen);
-
-	skb->protocol = htons(ETH_P_IP);
-	skb->priority = sockc->priority;
-	skb->mark = sockc->mark;
-	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
-	skb_dst_set(skb, &rt->dst);
-	*rtp = NULL;
-
-	skb_reset_network_header(skb);
-	iph = ip_hdr(skb);
-	skb_put(skb, length);
-
-	skb->ip_summed = CHECKSUM_NONE;
-
-	skb_setup_tx_timestamp(skb, sockc);
-
-	if (flags & MSG_CONFIRM)
-		skb_set_dst_pending_confirm(skb, 1);
-
-	skb->transport_header = skb->network_header;
-	err = -EFAULT;
-	if (memcpy_from_msg(iph, msg, length))
-		goto error_free;
-
-	iphlen = iph->ihl * 4;
-
-	/*
-	 * We don't want to modify the ip header, but we do need to
-	 * be sure that it won't cause problems later along the network
-	 * stack.  Specifically we want to make sure that iph->ihl is a
-	 * sane value.  If ihl points beyond the length of the buffer passed
-	 * in, reject the frame as invalid
-	 */
-	err = -EINVAL;
-	if (iphlen > length || iphlen < sizeof(*iph))
-		goto error_free;
-
-	if (iphlen >= sizeof(*iph)) {
-		if (!iph->saddr)
-			iph->saddr = fl4->saddr;
-		iph->check   = 0;
-		iph->tot_len = htons(length);
-		if (!iph->id)
-			ip_select_ident(net, skb, NULL);
-
-		iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
-		skb->transport_header += iphlen;
-		if (iph->protocol == IPPROTO_ICMP &&
-		    length >= iphlen + sizeof(struct icmphdr))
-			icmp_out_count(net, ((struct icmphdr *)
-				skb_transport_header(skb))->type);
-	}
-
-	err = NF_HOOK(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
-		      net, sk, skb, NULL, rt->dst.dev,
-		      dst_output);
-	if (err > 0)
-		err = net_xmit_errno(err);
-	if (err)
-		goto error;
-out:
-	return 0;
-
-error_free:
-	kfree_skb(skb);
-error:
-	IP_INC_STATS(net, IPSTATS_MIB_OUTDISCARDS);
-	if (err == -ENOBUFS && !inet_test_bit(RECVERR, sk))
-		err = 0;
-	return err;
-}
-
-static int raw_probe_proto_opt(struct raw_frag_vec *rfv, struct flowi4 *fl4)
-{
-	int err;
-
-	if (fl4->flowi4_proto != IPPROTO_ICMP)
-		return 0;
-
-	/* We only need the first two bytes. */
-	rfv->hlen = 2;
-
-	err = memcpy_from_msg(rfv->hdr.c, rfv->msg, rfv->hlen);
-	if (err)
-		return err;
-
-	fl4->fl4_icmp_type = rfv->hdr.icmph.type;
-	fl4->fl4_icmp_code = rfv->hdr.icmph.code;
-
-	return 0;
-}
-
-static int raw_getfrag(void *from, char *to, int offset, int len, int odd,
-		       struct sk_buff *skb)
-{
-	struct raw_frag_vec *rfv = from;
-
-	if (offset < rfv->hlen) {
-		int copy = min(rfv->hlen - offset, len);
-
-		if (skb->ip_summed == CHECKSUM_PARTIAL)
-			memcpy(to, rfv->hdr.c + offset, copy);
-		else
-			skb->csum = csum_block_add(
-				skb->csum,
-				csum_partial_copy_nocheck(rfv->hdr.c + offset,
-							  to, copy),
-				odd);
-
-		odd = 0;
-		offset += copy;
-		to += copy;
-		len -= copy;
-
-		if (!len)
-			return 0;
-	}
-
-	offset -= rfv->hlen;
-
-	return ip_generic_getfrag(rfv->msg, to, offset, len, odd, skb);
-}
-
-static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
-{
-	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
-			IP_OPTIONS_DATA_FIXED_SIZE);
-	struct inet_sock *inet = inet_sk(sk);
-	struct net *net = sock_net(sk);
-	struct ipcm_cookie ipc;
-	struct rtable *rt = NULL;
-	struct flowi4 fl4;
-	u8 scope;
-	int free = 0;
-	__be32 daddr;
-	__be32 saddr;
-	int uc_index, err;
-	struct raw_frag_vec rfv;
-	int hdrincl;
-
-	err = -EMSGSIZE;
-	if (len > 0xFFFF)
-		goto out;
-
-	hdrincl = inet_test_bit(HDRINCL, sk);
-
-	/*
-	 *	Check the flags.
-	 */
-
-	err = -EOPNOTSUPP;
-	if (msg->msg_flags & MSG_OOB)	/* Mirror BSD error message */
-		goto out;               /* compatibility */
-
-	/*
-	 *	Get and verify the address.
-	 */
-
-	if (msg->msg_namelen) {
-		DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
-		err = -EINVAL;
-		if (msg->msg_namelen < sizeof(*usin))
-			goto out;
-		if (usin->sin_family != AF_INET) {
-			pr_info_once("%s: %s forgot to set AF_INET. Fix it!\n",
-				     __func__, current->comm);
-			err = -EAFNOSUPPORT;
-			if (usin->sin_family)
-				goto out;
-		}
-		daddr = usin->sin_addr.s_addr;
-		/* ANK: I did not forget to get protocol from port field.
-		 * I just do not know, who uses this weirdness.
-		 * IP_HDRINCL is much more convenient.
-		 */
-	} else {
-		err = -EDESTADDRREQ;
-		if (sk->sk_state != TCP_ESTABLISHED)
-			goto out;
-		daddr = inet->inet_daddr;
-	}
-
-	ipcm_init_sk(&ipc, inet);
-	/* Keep backward compat */
-	if (hdrincl)
-		ipc.protocol = IPPROTO_RAW;
-
-	if (msg->msg_controllen) {
-		err = ip_cmsg_send(sk, msg, &ipc, false);
-		if (unlikely(err)) {
-			kfree(ipc.opt);
-			goto out;
-		}
-		if (ipc.opt)
-			free = 1;
-	}
-
-	saddr = ipc.addr;
-	ipc.addr = daddr;
-
-	if (!ipc.opt) {
-		struct ip_options_rcu *inet_opt;
-
-		rcu_read_lock();
-		inet_opt = rcu_dereference(inet->inet_opt);
-		if (inet_opt) {
-			memcpy(opt_copy, inet_opt,
-			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = opt_copy;
-		}
-		rcu_read_unlock();
-	}
-
-	if (ipc.opt) {
-		err = -EINVAL;
-		/* Linux does not mangle headers on raw sockets,
-		 * so that IP options + IP_HDRINCL is non-sense.
-		 */
-		if (hdrincl)
-			goto done;
-		if (ipc.opt->opt.srr) {
-			if (!daddr)
-				goto done;
-			daddr = ipc.opt->opt.faddr;
-		}
-	}
-	scope = ip_sendmsg_scope(inet, &ipc, msg);
-
-	uc_index = READ_ONCE(inet->uc_index);
-	if (ipv4_is_multicast(daddr)) {
-		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
-			ipc.oif = READ_ONCE(inet->mc_index);
-		if (!saddr)
-			saddr = READ_ONCE(inet->mc_addr);
-	} else if (!ipc.oif) {
-		ipc.oif = uc_index;
-	} else if (ipv4_is_lbcast(daddr) && uc_index) {
-		/* oif is set, packet is to local broadcast
-		 * and uc_index is set. oif is most likely set
-		 * by sk_bound_dev_if. If uc_index != oif check if the
-		 * oif is an L3 master and uc_index is an L3 slave.
-		 * If so, we want to allow the send using the uc_index.
-		 */
-		if (ipc.oif != uc_index &&
-		    ipc.oif == l3mdev_master_ifindex_by_index(sock_net(sk),
-							      uc_index)) {
-			ipc.oif = uc_index;
-		}
-	}
-
-	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
-			   ipc.tos & INET_DSCP_MASK, scope,
-			   hdrincl ? ipc.protocol : sk->sk_protocol,
-			   inet_sk_flowi_flags(sk) |
-			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
-			   daddr, saddr, 0, 0, sk_uid(sk));
-
-	fl4.fl4_icmp_type = 0;
-	fl4.fl4_icmp_code = 0;
-
-	if (!hdrincl) {
-		rfv.msg = msg;
-		rfv.hlen = 0;
-
-		err = raw_probe_proto_opt(&rfv, &fl4);
-		if (err)
-			goto done;
-	}
-
-	security_sk_classify_flow(sk, flowi4_to_flowi_common(&fl4));
-	rt = ip_route_output_flow(net, &fl4, sk);
-	if (IS_ERR(rt)) {
-		err = PTR_ERR(rt);
-		rt = NULL;
-		goto done;
-	}
-
-	err = -EACCES;
-	if (rt->rt_flags & RTCF_BROADCAST && !sock_flag(sk, SOCK_BROADCAST))
-		goto done;
-
-	if (msg->msg_flags & MSG_CONFIRM)
-		goto do_confirm;
-back_from_confirm:
-
-	if (hdrincl)
-		err = raw_send_hdrinc(sk, &fl4, msg, len,
-				      &rt, msg->msg_flags, &ipc.sockc);
-
-	 else {
-		if (!ipc.addr)
-			ipc.addr = fl4.daddr;
-		lock_sock(sk);
-		err = ip_append_data(sk, &fl4, raw_getfrag,
-				     &rfv, len, 0,
-				     &ipc, &rt, msg->msg_flags);
-		if (err)
-			ip_flush_pending_frames(sk);
-		else if (!(msg->msg_flags & MSG_MORE)) {
-			err = ip_push_pending_frames(sk, &fl4);
-			if (err == -ENOBUFS && !inet_test_bit(RECVERR, sk))
-				err = 0;
-		}
-		release_sock(sk);
-	}
-done:
-	if (free)
-		kfree(ipc.opt);
-	ip_rt_put(rt);
-
-out:
-	if (err < 0)
-		return err;
-	return len;
-
-do_confirm:
-	if (msg->msg_flags & MSG_PROBE)
-		dst_confirm_neigh(&rt->dst, &fl4.daddr);
-	if (!(msg->msg_flags & MSG_PROBE) || len)
-		goto back_from_confirm;
-	err = 0;
-	goto done;
-}
-
-static void raw_close(struct sock *sk, long timeout)
-{
-	/*
-	 * Raw sockets may have direct kernel references. Kill them.
-	 */
-	ip_ra_control(sk, 0, NULL);
-
-	sk_common_release(sk);
-}
-
-static void raw_destroy(struct sock *sk)
-{
-	lock_sock(sk);
-	ip_flush_pending_frames(sk);
-	release_sock(sk);
-}
-
-/* This gets rid of all the nasties in af_inet. -DaveM */
-static int raw_bind(struct sock *sk, struct sockaddr_unsized *uaddr,
-		    int addr_len)
-{
-	struct inet_sock *inet = inet_sk(sk);
-	struct sockaddr_in *addr = (struct sockaddr_in *) uaddr;
-	struct net *net = sock_net(sk);
-	u32 tb_id = RT_TABLE_LOCAL;
-	int ret = -EINVAL;
-	int chk_addr_ret;
-
-	lock_sock(sk);
-	if (sk->sk_state != TCP_CLOSE || addr_len < sizeof(struct sockaddr_in))
-		goto out;
-
-	if (sk->sk_bound_dev_if)
-		tb_id = l3mdev_fib_table_by_index(net,
-						  sk->sk_bound_dev_if) ? : tb_id;
-
-	chk_addr_ret = inet_addr_type_table(net, addr->sin_addr.s_addr, tb_id);
-
-	ret = -EADDRNOTAVAIL;
-	if (!inet_addr_valid_or_nonlocal(net, inet, addr->sin_addr.s_addr,
-					 chk_addr_ret))
-		goto out;
-
-	inet->inet_saddr = addr->sin_addr.s_addr;
-	WRITE_ONCE(inet->inet_rcv_saddr, addr->sin_addr.s_addr);
-	if (chk_addr_ret == RTN_MULTICAST || chk_addr_ret == RTN_BROADCAST)
-		inet->inet_saddr = 0;  /* Use device */
-	sk_dst_reset(sk);
-	ret = 0;
-out:
-	release_sock(sk);
-	return ret;
-}
-
-/*
- *	This should be easy, if there is something there
- *	we return it, otherwise we block.
- */
-
-static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		       int flags)
-{
-	struct inet_sock *inet = inet_sk(sk);
-	size_t copied = 0;
-	int err = -EOPNOTSUPP;
-	DECLARE_SOCKADDR(struct sockaddr_in *, sin, msg->msg_name);
-	struct sk_buff *skb;
-
-	if (flags & MSG_OOB)
-		goto out;
-
-	if (flags & MSG_ERRQUEUE) {
-		err = ip_recv_error(sk, msg, len);
-		goto out;
-	}
-
-	skb = skb_recv_datagram(sk, flags, &err);
-	if (!skb)
-		goto out;
-
-	copied = skb->len;
-	if (len < copied) {
-		msg->msg_flags |= MSG_TRUNC;
-		copied = len;
-	}
-
-	err = skb_copy_datagram_msg(skb, 0, msg, copied);
-	if (err)
-		goto done;
-
-	sock_recv_cmsgs(msg, sk, skb);
-
-	/* Copy the address. */
-	if (sin) {
-		sin->sin_family = AF_INET;
-		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
-		sin->sin_port = 0;
-		memset(&sin->sin_zero, 0, sizeof(sin->sin_zero));
-		msg->msg_namelen = sizeof(*sin);
-	}
-	if (inet_cmsg_flags(inet))
-		ip_cmsg_recv(msg, skb);
-	if (flags & MSG_TRUNC)
-		copied = skb->len;
-done:
-	skb_free_datagram(sk, skb);
-out:
-	if (err)
-		return err;
-	return copied;
-}
-
-static int raw_sk_init(struct sock *sk)
-{
-	struct raw_sock *rp = raw_sk(sk);
-
-	sk->sk_drop_counters = &rp->drop_counters;
-	if (inet_sk(sk)->inet_num == IPPROTO_ICMP)
-		memset(&rp->filter, 0, sizeof(rp->filter));
-	return 0;
-}
-
-static int raw_seticmpfilter(struct sock *sk, sockptr_t optval, int optlen)
-{
-	if (optlen > sizeof(struct icmp_filter))
-		optlen = sizeof(struct icmp_filter);
-	if (copy_from_sockptr(&raw_sk(sk)->filter, optval, optlen))
-		return -EFAULT;
-	return 0;
-}
-
-static int raw_geticmpfilter(struct sock *sk, sockopt_t *opt)
-{
-	int len = opt->optlen;
-
-	if (len < 0)
-		return -EINVAL;
-	if (len > sizeof(struct icmp_filter))
-		len = sizeof(struct icmp_filter);
-	opt->optlen = len;
-	if (copy_to_iter(&raw_sk(sk)->filter, len, &opt->iter_out) != len)
-		return -EFAULT;
-	return 0;
-}
-
-static int do_raw_setsockopt(struct sock *sk, int optname,
-			     sockptr_t optval, unsigned int optlen)
-{
-	if (optname == ICMP_FILTER) {
-		if (inet_sk(sk)->inet_num != IPPROTO_ICMP)
-			return -EOPNOTSUPP;
-		else
-			return raw_seticmpfilter(sk, optval, optlen);
-	}
-	return -ENOPROTOOPT;
-}
-
-static int raw_setsockopt(struct sock *sk, int level, int optname,
-			  sockptr_t optval, unsigned int optlen)
-{
-	if (level != SOL_RAW)
-		return ip_setsockopt(sk, level, optname, optval, optlen);
-	return do_raw_setsockopt(sk, optname, optval, optlen);
-}
-
-static int do_raw_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
-{
-	if (optname == ICMP_FILTER) {
-		if (inet_sk(sk)->inet_num != IPPROTO_ICMP)
-			return -EOPNOTSUPP;
-		else
-			return raw_geticmpfilter(sk, opt);
-	}
-	return -ENOPROTOOPT;
-}
-
-static int raw_getsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, int __user *optlen)
-{
-	sockopt_t opt;
-	int err;
-
-	if (level != SOL_RAW)
-		return ip_getsockopt(sk, level, optname, optval, optlen);
-
-	err = sockopt_init_user(&opt, optval, optlen);
-	if (err)
-		return err;
-
-	err = do_raw_getsockopt(sk, optname, &opt);
-	if (err)
-		return err;
-
-	if (put_user(opt.optlen, optlen))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int raw_ioctl(struct sock *sk, int cmd, int *karg)
-{
-	switch (cmd) {
-	case SIOCOUTQ: {
-		*karg = sk_wmem_alloc_get(sk);
-		return 0;
-	}
-	case SIOCINQ: {
-		struct sk_buff *skb;
-
-		spin_lock_bh(&sk->sk_receive_queue.lock);
-		skb = skb_peek(&sk->sk_receive_queue);
-		if (skb)
-			*karg = skb->len;
-		else
-			*karg = 0;
-		spin_unlock_bh(&sk->sk_receive_queue.lock);
-		return 0;
-	}
-
-	default:
-#ifdef CONFIG_IP_MROUTE
-		return ipmr_ioctl(sk, cmd, karg);
-#else
-		return -ENOIOCTLCMD;
-#endif
-	}
-}
-
-#ifdef CONFIG_COMPAT
-static int compat_raw_ioctl(struct sock *sk, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case SIOCOUTQ:
-	case SIOCINQ:
-		return -ENOIOCTLCMD;
-	default:
-#ifdef CONFIG_IP_MROUTE
-		return ipmr_compat_ioctl(sk, cmd, compat_ptr(arg));
-#else
-		return -ENOIOCTLCMD;
-#endif
-	}
-}
-#endif
-
 int raw_abort(struct sock *sk, int err)
 {
 	lock_sock(sk);
@@ -945,34 +120,6 @@ int raw_abort(struct sock *sk, int err)
 	return 0;
 }
 
-struct proto raw_prot = {
-	.name		   = "RAW",
-	.owner		   = THIS_MODULE,
-	.close		   = raw_close,
-	.destroy	   = raw_destroy,
-	.connect	   = ip4_datagram_connect,
-	.disconnect	   = __udp_disconnect,
-	.ioctl		   = raw_ioctl,
-	.init		   = raw_sk_init,
-	.setsockopt	   = raw_setsockopt,
-	.getsockopt	   = raw_getsockopt,
-	.sendmsg	   = raw_sendmsg,
-	.recvmsg	   = raw_recvmsg,
-	.bind		   = raw_bind,
-	.backlog_rcv	   = raw_rcv_skb,
-	.release_cb	   = ip4_datagram_release_cb,
-	.hash		   = raw_hash_sk,
-	.unhash		   = raw_unhash_sk,
-	.obj_size	   = sizeof(struct raw_sock),
-	.useroffset	   = offsetof(struct raw_sock, filter),
-	.usersize	   = sizeof_field(struct raw_sock, filter),
-	.h.raw_hash	   = &raw_v4_hashinfo,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	   = compat_raw_ioctl,
-#endif
-	.diag_destroy	   = raw_abort,
-};
-
 #ifdef CONFIG_PROC_FS
 static struct sock *raw_get_first(struct seq_file *seq, int bucket)
 {
diff --git a/net/ipv4/raw_diag.c b/net/ipv4/raw_diag.c
index 943e5998e0ad..38a1e74af7cd 100644
--- a/net/ipv4/raw_diag.c
+++ b/net/ipv4/raw_diag.c
@@ -40,7 +40,8 @@ static bool raw_lookup(struct net *net, const struct sock *sk,
 	struct inet_diag_req_raw *r = (void *)req;
 
 	if (r->sdiag_family == AF_INET)
-		return raw_v4_match(net, sk, r->sdiag_raw_protocol,
+		return IS_ENABLED(CONFIG_IPV4) &&
+		       raw_v4_match(net, sk, r->sdiag_raw_protocol,
 				    r->id.idiag_dst[0],
 				    r->id.idiag_src[0],
 				    r->id.idiag_if, 0);
diff --git a/net/ipv4/raw_ipv4.c b/net/ipv4/raw_ipv4.c
new file mode 100644
index 000000000000..0419026683b0
--- /dev/null
+++ b/net/ipv4/raw_ipv4.c
@@ -0,0 +1,884 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX
+ *		operating system.  INET is implemented using the  BSD Socket
+ *		interface as the means of communication with the user level.
+ *
+ *		RAW - implementation of IP "raw" sockets.
+ *
+ *		IPv4 specific functions
+ *
+ *		code split from:
+ *		net/ipv4/raw.c
+ *
+ *		See raw.c for author information
+ */
+
+#include <asm/ioctls.h>
+#include <linux/igmp.h>
+#include <linux/mroute.h>
+#include <linux/netfilter.h>
+#include <linux/sockios.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/compat.h>
+#include <net/icmp.h>
+#include <net/ip.h>
+#include <net/raw.h>
+#include <net/sock.h>
+#include <net/udp.h>
+#include <net/xfrm.h>
+
+struct raw_frag_vec {
+	struct msghdr *msg;
+	union {
+		struct icmphdr icmph;
+		char c[1];
+	} hdr;
+	int hlen;
+};
+
+bool raw_v4_match(struct net *net, const struct sock *sk, unsigned short num,
+		  __be32 raddr, __be32 laddr, int dif, int sdif)
+{
+	const struct inet_sock *inet = inet_sk(sk);
+	__be32 daddr, rcv_saddr;
+
+	if (!net_eq(sock_net(sk), net) || inet->inet_num != num)
+		return false;
+
+	daddr = READ_ONCE(inet->inet_daddr);
+	if (daddr && daddr != raddr)
+		return false;
+
+	rcv_saddr = READ_ONCE(inet->inet_rcv_saddr);
+	if (rcv_saddr && rcv_saddr != laddr)
+		return false;
+
+	return raw_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if),
+				   dif, sdif);
+}
+EXPORT_SYMBOL_GPL(raw_v4_match);
+
+/*
+ *	0 - deliver
+ *	1 - block
+ */
+static int icmp_filter(const struct sock *sk, const struct sk_buff *skb)
+{
+	struct icmphdr _hdr;
+	const struct icmphdr *hdr;
+
+	hdr = skb_header_pointer(skb, skb_transport_offset(skb),
+				 sizeof(_hdr), &_hdr);
+	if (!hdr)
+		return 1;
+
+	if (hdr->type < 32) {
+		__u32 data = raw_sk(sk)->filter.data;
+
+		return ((1U << hdr->type) & data) != 0;
+	}
+
+	/* Do not block unknown ICMP types */
+	return 0;
+}
+
+/* IP input processing comes here for RAW socket delivery.
+ * Caller owns SKB, so we must make clones.
+ *
+ * RFC 1122: SHOULD pass TOS value up to the transport layer.
+ * -> It does. And not only TOS, but all IP header.
+ */
+static int raw_v4_input(struct net *net, struct sk_buff *skb,
+			const struct iphdr *iph, int hash)
+{
+	int sdif = inet_sdif(skb);
+	struct hlist_head *hlist;
+	int dif = inet_iif(skb);
+	int delivered = 0;
+	struct sock *sk;
+
+	hlist = &raw_v4_hashinfo.ht[hash];
+	rcu_read_lock();
+	sk_for_each_rcu(sk, hlist) {
+		if (!raw_v4_match(net, sk, iph->protocol,
+				  iph->saddr, iph->daddr, dif, sdif))
+			continue;
+
+		if (atomic_read(&sk->sk_rmem_alloc) >=
+		    READ_ONCE(sk->sk_rcvbuf)) {
+			sk_drops_inc(sk);
+			continue;
+		}
+
+		delivered = 1;
+		if ((iph->protocol != IPPROTO_ICMP || !icmp_filter(sk, skb)) &&
+		    ip_mc_sf_allow(sk, iph->daddr, iph->saddr,
+				   skb->dev->ifindex, sdif)) {
+			struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
+
+			/* Not releasing hash table! */
+			if (clone)
+				raw_rcv(sk, clone);
+		}
+	}
+	rcu_read_unlock();
+	return delivered;
+}
+
+int raw_local_deliver(struct sk_buff *skb, int protocol)
+{
+	struct net *net = dev_net(skb->dev);
+
+	return raw_v4_input(net, skb, ip_hdr(skb),
+			    raw_hashfunc(net, protocol));
+}
+
+static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	const int type = icmp_hdr(skb)->type;
+	const int code = icmp_hdr(skb)->code;
+	int harderr = 0;
+	bool recverr;
+	int err = 0;
+
+	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED) {
+		ipv4_sk_update_pmtu(skb, sk, info);
+	} else if (type == ICMP_REDIRECT) {
+		ipv4_sk_redirect(skb, sk);
+		return;
+	}
+
+	/* Report error on raw socket, if:
+	 * 1. User requested ip_recverr.
+	 * 2. Socket is connected (otherwise the error indication
+	 *    is useless without ip_recverr and error is hard.
+	 */
+	recverr = inet_test_bit(RECVERR, sk);
+	if (!recverr && sk->sk_state != TCP_ESTABLISHED)
+		return;
+
+	switch (type) {
+	default:
+	case ICMP_TIME_EXCEEDED:
+		err = EHOSTUNREACH;
+		break;
+	case ICMP_SOURCE_QUENCH:
+		return;
+	case ICMP_PARAMETERPROB:
+		err = EPROTO;
+		harderr = 1;
+		break;
+	case ICMP_DEST_UNREACH:
+		err = EHOSTUNREACH;
+		if (code > NR_ICMP_UNREACH)
+			break;
+		if (code == ICMP_FRAG_NEEDED) {
+			harderr = READ_ONCE(inet->pmtudisc) != IP_PMTUDISC_DONT;
+			err = EMSGSIZE;
+		} else {
+			err = icmp_err_convert[code].errno;
+			harderr = icmp_err_convert[code].fatal;
+		}
+	}
+
+	if (recverr) {
+		const struct iphdr *iph = (const struct iphdr *)skb->data;
+		u8 *payload = skb->data + (iph->ihl << 2);
+
+		if (inet_test_bit(HDRINCL, sk))
+			payload = skb->data;
+		ip_icmp_error(sk, skb, err, 0, info, payload);
+	}
+
+	if (recverr || harderr) {
+		sk->sk_err = err;
+		sk_error_report(sk);
+	}
+}
+
+void raw_icmp_error(struct sk_buff *skb, int protocol, u32 info)
+{
+	struct net *net = dev_net(skb->dev);
+	int dif = skb->dev->ifindex;
+	int sdif = inet_sdif(skb);
+	struct hlist_head *hlist;
+	const struct iphdr *iph;
+	struct sock *sk;
+	int hash;
+
+	hash = raw_hashfunc(net, protocol);
+	hlist = &raw_v4_hashinfo.ht[hash];
+
+	rcu_read_lock();
+	sk_for_each_rcu(sk, hlist) {
+		iph = (const struct iphdr *)skb->data;
+		if (!raw_v4_match(net, sk, iph->protocol,
+				  iph->daddr, iph->saddr, dif, sdif))
+			continue;
+		raw_err(sk, skb, info);
+	}
+	rcu_read_unlock();
+}
+
+static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	enum skb_drop_reason reason;
+
+	/* Charge it to the socket. */
+
+	ipv4_pktinfo_prepare(sk, skb, true);
+	reason = sock_queue_rcv_skb_reason(sk, skb);
+	if (reason) {
+		sk_skb_reason_drop(sk, skb, reason);
+		return NET_RX_DROP;
+	}
+
+	return NET_RX_SUCCESS;
+}
+
+int raw_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
+		sk_drops_inc(sk);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
+		return NET_RX_DROP;
+	}
+	nf_reset_ct(skb);
+
+	skb_push(skb, -skb_network_offset(skb));
+
+	raw_rcv_skb(sk, skb);
+	return 0;
+}
+
+static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
+			   struct msghdr *msg, size_t length,
+			   struct rtable **rtp, unsigned int flags,
+			   const struct sockcm_cookie *sockc)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	struct net *net = sock_net(sk);
+	struct iphdr *iph;
+	struct sk_buff *skb;
+	unsigned int iphlen;
+	int err;
+	struct rtable *rt = *rtp;
+	int hlen, tlen;
+
+	if (length > rt->dst.dev->mtu) {
+		ip_local_error(sk, EMSGSIZE, fl4->daddr, inet->inet_dport,
+			       rt->dst.dev->mtu);
+		return -EMSGSIZE;
+	}
+	if (length < sizeof(struct iphdr))
+		return -EINVAL;
+
+	if (flags & MSG_PROBE)
+		goto out;
+
+	hlen = LL_RESERVED_SPACE(rt->dst.dev);
+	tlen = rt->dst.dev->needed_tailroom;
+	skb = sock_alloc_send_skb(sk,
+				  length + hlen + tlen + 15,
+				  flags & MSG_DONTWAIT, &err);
+	if (!skb)
+		goto error;
+	skb_reserve(skb, hlen);
+
+	skb->protocol = htons(ETH_P_IP);
+	skb->priority = sockc->priority;
+	skb->mark = sockc->mark;
+	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
+	skb_dst_set(skb, &rt->dst);
+	*rtp = NULL;
+
+	skb_reset_network_header(skb);
+	iph = ip_hdr(skb);
+	skb_put(skb, length);
+
+	skb->ip_summed = CHECKSUM_NONE;
+
+	skb_setup_tx_timestamp(skb, sockc);
+
+	if (flags & MSG_CONFIRM)
+		skb_set_dst_pending_confirm(skb, 1);
+
+	skb->transport_header = skb->network_header;
+	err = -EFAULT;
+	if (memcpy_from_msg(iph, msg, length))
+		goto error_free;
+
+	iphlen = iph->ihl * 4;
+
+	/*
+	 * We don't want to modify the ip header, but we do need to
+	 * be sure that it won't cause problems later along the network
+	 * stack.  Specifically we want to make sure that iph->ihl is a
+	 * sane value.  If ihl points beyond the length of the buffer passed
+	 * in, reject the frame as invalid
+	 */
+	err = -EINVAL;
+	if (iphlen > length || iphlen < sizeof(*iph))
+		goto error_free;
+
+	if (iphlen >= sizeof(*iph)) {
+		if (!iph->saddr)
+			iph->saddr = fl4->saddr;
+		iph->check   = 0;
+		iph->tot_len = htons(length);
+		if (!iph->id)
+			ip_select_ident(net, skb, NULL);
+
+		iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
+		skb->transport_header += iphlen;
+		if (iph->protocol == IPPROTO_ICMP &&
+		    length >= iphlen + sizeof(struct icmphdr))
+			icmp_out_count(net, ((struct icmphdr *)
+				skb_transport_header(skb))->type);
+	}
+
+	err = NF_HOOK(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
+		      net, sk, skb, NULL, rt->dst.dev,
+		      dst_output);
+	if (err > 0)
+		err = net_xmit_errno(err);
+	if (err)
+		goto error;
+out:
+	return 0;
+
+error_free:
+	kfree_skb(skb);
+error:
+	IP_INC_STATS(net, IPSTATS_MIB_OUTDISCARDS);
+	if (err == -ENOBUFS && !inet_test_bit(RECVERR, sk))
+		err = 0;
+	return err;
+}
+
+static int raw_probe_proto_opt(struct raw_frag_vec *rfv, struct flowi4 *fl4)
+{
+	int err;
+
+	if (fl4->flowi4_proto != IPPROTO_ICMP)
+		return 0;
+
+	/* We only need the first two bytes. */
+	rfv->hlen = 2;
+
+	err = memcpy_from_msg(rfv->hdr.c, rfv->msg, rfv->hlen);
+	if (err)
+		return err;
+
+	fl4->fl4_icmp_type = rfv->hdr.icmph.type;
+	fl4->fl4_icmp_code = rfv->hdr.icmph.code;
+
+	return 0;
+}
+
+static int raw_getfrag(void *from, char *to, int offset, int len, int odd,
+		       struct sk_buff *skb)
+{
+	struct raw_frag_vec *rfv = from;
+
+	if (offset < rfv->hlen) {
+		int copy = min(rfv->hlen - offset, len);
+
+		if (skb->ip_summed == CHECKSUM_PARTIAL)
+			memcpy(to, rfv->hdr.c + offset, copy);
+		else
+			skb->csum = csum_block_add(skb->csum,
+						   csum_partial_copy_nocheck(rfv->hdr.c + offset,
+									     to, copy),
+						    odd);
+
+		odd = 0;
+		offset += copy;
+		to += copy;
+		len -= copy;
+
+		if (!len)
+			return 0;
+	}
+
+	offset -= rfv->hlen;
+
+	return ip_generic_getfrag(rfv->msg, to, offset, len, odd, skb);
+}
+
+static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
+	struct inet_sock *inet = inet_sk(sk);
+	struct net *net = sock_net(sk);
+	struct ipcm_cookie ipc;
+	struct rtable *rt = NULL;
+	struct flowi4 fl4;
+	u8 scope;
+	int free = 0;
+	__be32 daddr;
+	__be32 saddr;
+	int uc_index, err;
+	struct raw_frag_vec rfv;
+	int hdrincl;
+
+	err = -EMSGSIZE;
+	if (len > 0xFFFF)
+		goto out;
+
+	hdrincl = inet_test_bit(HDRINCL, sk);
+
+	/*
+	 *	Check the flags.
+	 */
+
+	err = -EOPNOTSUPP;
+	if (msg->msg_flags & MSG_OOB)	/* Mirror BSD error message */
+		goto out;               /* compatibility */
+
+	/*
+	 *	Get and verify the address.
+	 */
+
+	if (msg->msg_namelen) {
+		DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
+
+		err = -EINVAL;
+		if (msg->msg_namelen < sizeof(*usin))
+			goto out;
+		if (usin->sin_family != AF_INET) {
+			pr_info_once("%s: %s forgot to set AF_INET. Fix it!\n",
+				     __func__, current->comm);
+			err = -EAFNOSUPPORT;
+			if (usin->sin_family)
+				goto out;
+		}
+		daddr = usin->sin_addr.s_addr;
+		/* ANK: I did not forget to get protocol from port field.
+		 * I just do not know, who uses this weirdness.
+		 * IP_HDRINCL is much more convenient.
+		 */
+	} else {
+		err = -EDESTADDRREQ;
+		if (sk->sk_state != TCP_ESTABLISHED)
+			goto out;
+		daddr = inet->inet_daddr;
+	}
+
+	ipcm_init_sk(&ipc, inet);
+	/* Keep backward compat */
+	if (hdrincl)
+		ipc.protocol = IPPROTO_RAW;
+
+	if (msg->msg_controllen) {
+		err = ip_cmsg_send(sk, msg, &ipc, false);
+		if (unlikely(err)) {
+			kfree(ipc.opt);
+			goto out;
+		}
+		if (ipc.opt)
+			free = 1;
+	}
+
+	saddr = ipc.addr;
+	ipc.addr = daddr;
+
+	if (!ipc.opt) {
+		struct ip_options_rcu *inet_opt;
+
+		rcu_read_lock();
+		inet_opt = rcu_dereference(inet->inet_opt);
+		if (inet_opt) {
+			memcpy(opt_copy, inet_opt,
+			       sizeof(*inet_opt) + inet_opt->opt.optlen);
+			ipc.opt = opt_copy;
+		}
+		rcu_read_unlock();
+	}
+
+	if (ipc.opt) {
+		err = -EINVAL;
+		/* Linux does not mangle headers on raw sockets,
+		 * so that IP options + IP_HDRINCL is non-sense.
+		 */
+		if (hdrincl)
+			goto done;
+		if (ipc.opt->opt.srr) {
+			if (!daddr)
+				goto done;
+			daddr = ipc.opt->opt.faddr;
+		}
+	}
+	scope = ip_sendmsg_scope(inet, &ipc, msg);
+
+	uc_index = READ_ONCE(inet->uc_index);
+	if (ipv4_is_multicast(daddr)) {
+		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
+			ipc.oif = READ_ONCE(inet->mc_index);
+		if (!saddr)
+			saddr = READ_ONCE(inet->mc_addr);
+	} else if (!ipc.oif) {
+		ipc.oif = uc_index;
+	} else if (ipv4_is_lbcast(daddr) && uc_index) {
+		/* oif is set, packet is to local broadcast
+		 * and uc_index is set. oif is most likely set
+		 * by sk_bound_dev_if. If uc_index != oif check if the
+		 * oif is an L3 master and uc_index is an L3 slave.
+		 * If so, we want to allow the send using the uc_index.
+		 */
+		if (ipc.oif != uc_index &&
+		    ipc.oif == l3mdev_master_ifindex_by_index(sock_net(sk),
+							      uc_index)) {
+			ipc.oif = uc_index;
+		}
+	}
+
+	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
+			   ipc.tos & INET_DSCP_MASK, scope,
+			   hdrincl ? ipc.protocol : sk->sk_protocol,
+			   inet_sk_flowi_flags(sk) |
+			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
+			   daddr, saddr, 0, 0, sk_uid(sk));
+
+	fl4.fl4_icmp_type = 0;
+	fl4.fl4_icmp_code = 0;
+
+	if (!hdrincl) {
+		rfv.msg = msg;
+		rfv.hlen = 0;
+
+		err = raw_probe_proto_opt(&rfv, &fl4);
+		if (err)
+			goto done;
+	}
+
+	security_sk_classify_flow(sk, flowi4_to_flowi_common(&fl4));
+	rt = ip_route_output_flow(net, &fl4, sk);
+	if (IS_ERR(rt)) {
+		err = PTR_ERR(rt);
+		rt = NULL;
+		goto done;
+	}
+
+	err = -EACCES;
+	if (rt->rt_flags & RTCF_BROADCAST && !sock_flag(sk, SOCK_BROADCAST))
+		goto done;
+
+	if (msg->msg_flags & MSG_CONFIRM)
+		goto do_confirm;
+back_from_confirm:
+
+	if (hdrincl) {
+		err = raw_send_hdrinc(sk, &fl4, msg, len,
+				      &rt, msg->msg_flags, &ipc.sockc);
+	} else {
+		if (!ipc.addr)
+			ipc.addr = fl4.daddr;
+		lock_sock(sk);
+		err = ip_append_data(sk, &fl4, raw_getfrag,
+				     &rfv, len, 0,
+				     &ipc, &rt, msg->msg_flags);
+		if (err) {
+			ip_flush_pending_frames(sk);
+		} else if (!(msg->msg_flags & MSG_MORE)) {
+			err = ip_push_pending_frames(sk, &fl4);
+			if (err == -ENOBUFS && !inet_test_bit(RECVERR, sk))
+				err = 0;
+		}
+		release_sock(sk);
+	}
+done:
+	if (free)
+		kfree(ipc.opt);
+	ip_rt_put(rt);
+
+out:
+	if (err < 0)
+		return err;
+	return len;
+
+do_confirm:
+	if (msg->msg_flags & MSG_PROBE)
+		dst_confirm_neigh(&rt->dst, &fl4.daddr);
+	if (!(msg->msg_flags & MSG_PROBE) || len)
+		goto back_from_confirm;
+	err = 0;
+	goto done;
+}
+
+static void raw_close(struct sock *sk, long timeout)
+{
+	/*
+	 * Raw sockets may have direct kernel references. Kill them.
+	 */
+	ip_ra_control(sk, 0, NULL);
+
+	sk_common_release(sk);
+}
+
+static void raw_destroy(struct sock *sk)
+{
+	lock_sock(sk);
+	ip_flush_pending_frames(sk);
+	release_sock(sk);
+}
+
+/* This gets rid of all the nasties in af_inet. -DaveM */
+static int raw_bind(struct sock *sk, struct sockaddr_unsized *uaddr,
+		    int addr_len)
+{
+	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
+	struct inet_sock *inet = inet_sk(sk);
+	struct net *net = sock_net(sk);
+	u32 tb_id = RT_TABLE_LOCAL;
+	int ret = -EINVAL;
+	int chk_addr_ret;
+
+	lock_sock(sk);
+	if (sk->sk_state != TCP_CLOSE || addr_len < sizeof(struct sockaddr_in))
+		goto out;
+
+	if (sk->sk_bound_dev_if)
+		tb_id = l3mdev_fib_table_by_index(net,
+						  sk->sk_bound_dev_if) ? : tb_id;
+
+	chk_addr_ret = inet_addr_type_table(net, addr->sin_addr.s_addr, tb_id);
+
+	ret = -EADDRNOTAVAIL;
+	if (!inet_addr_valid_or_nonlocal(net, inet, addr->sin_addr.s_addr,
+					 chk_addr_ret))
+		goto out;
+
+	inet->inet_saddr = addr->sin_addr.s_addr;
+	WRITE_ONCE(inet->inet_rcv_saddr, addr->sin_addr.s_addr);
+	if (chk_addr_ret == RTN_MULTICAST || chk_addr_ret == RTN_BROADCAST)
+		inet->inet_saddr = 0;  /* Use device */
+	sk_dst_reset(sk);
+	ret = 0;
+out:
+	release_sock(sk);
+	return ret;
+}
+
+/*
+ *	This should be easy, if there is something there
+ *	we return it, otherwise we block.
+ */
+
+static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+		       int flags)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	size_t copied = 0;
+	int err = -EOPNOTSUPP;
+	DECLARE_SOCKADDR(struct sockaddr_in *, sin, msg->msg_name);
+	struct sk_buff *skb;
+
+	if (flags & MSG_OOB)
+		goto out;
+
+	if (flags & MSG_ERRQUEUE) {
+		err = ip_recv_error(sk, msg, len);
+		goto out;
+	}
+
+	skb = skb_recv_datagram(sk, flags, &err);
+	if (!skb)
+		goto out;
+
+	copied = skb->len;
+	if (len < copied) {
+		msg->msg_flags |= MSG_TRUNC;
+		copied = len;
+	}
+
+	err = skb_copy_datagram_msg(skb, 0, msg, copied);
+	if (err)
+		goto done;
+
+	sock_recv_cmsgs(msg, sk, skb);
+
+	/* Copy the address. */
+	if (sin) {
+		sin->sin_family = AF_INET;
+		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
+		sin->sin_port = 0;
+		memset(&sin->sin_zero, 0, sizeof(sin->sin_zero));
+		msg->msg_namelen = sizeof(*sin);
+	}
+	if (inet_cmsg_flags(inet))
+		ip_cmsg_recv(msg, skb);
+	if (flags & MSG_TRUNC)
+		copied = skb->len;
+done:
+	skb_free_datagram(sk, skb);
+out:
+	if (err)
+		return err;
+	return copied;
+}
+
+static int raw_sk_init(struct sock *sk)
+{
+	struct raw_sock *rp = raw_sk(sk);
+
+	sk->sk_drop_counters = &rp->drop_counters;
+	if (inet_sk(sk)->inet_num == IPPROTO_ICMP)
+		memset(&rp->filter, 0, sizeof(rp->filter));
+	return 0;
+}
+
+static int raw_seticmpfilter(struct sock *sk, sockptr_t optval, int optlen)
+{
+	if (optlen > sizeof(struct icmp_filter))
+		optlen = sizeof(struct icmp_filter);
+	if (copy_from_sockptr(&raw_sk(sk)->filter, optval, optlen))
+		return -EFAULT;
+	return 0;
+}
+
+static int raw_geticmpfilter(struct sock *sk, sockopt_t *opt)
+{
+	int len = opt->optlen;
+
+	if (len < 0)
+		return -EINVAL;
+	if (len > sizeof(struct icmp_filter))
+		len = sizeof(struct icmp_filter);
+	opt->optlen = len;
+	if (copy_to_iter(&raw_sk(sk)->filter, len, &opt->iter_out) != len)
+		return -EFAULT;
+	return 0;
+}
+
+static int do_raw_setsockopt(struct sock *sk, int optname,
+			     sockptr_t optval, unsigned int optlen)
+{
+	if (optname == ICMP_FILTER) {
+		if (inet_sk(sk)->inet_num != IPPROTO_ICMP)
+			return -EOPNOTSUPP;
+		else
+			return raw_seticmpfilter(sk, optval, optlen);
+	}
+	return -ENOPROTOOPT;
+}
+
+static int raw_setsockopt(struct sock *sk, int level, int optname,
+			  sockptr_t optval, unsigned int optlen)
+{
+	if (level != SOL_RAW)
+		return ip_setsockopt(sk, level, optname, optval, optlen);
+	return do_raw_setsockopt(sk, optname, optval, optlen);
+}
+
+static int do_raw_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
+{
+	if (optname == ICMP_FILTER) {
+		if (inet_sk(sk)->inet_num != IPPROTO_ICMP)
+			return -EOPNOTSUPP;
+		else
+			return raw_geticmpfilter(sk, opt);
+	}
+	return -ENOPROTOOPT;
+}
+
+static int raw_getsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int __user *optlen)
+{
+	sockopt_t opt;
+	int err;
+
+	if (level != SOL_RAW)
+		return ip_getsockopt(sk, level, optname, optval, optlen);
+
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = do_raw_getsockopt(sk, optname, &opt);
+	if (err)
+		return err;
+
+	if (put_user(opt.optlen, optlen))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int raw_ioctl(struct sock *sk, int cmd, int *karg)
+{
+	switch (cmd) {
+	case SIOCOUTQ: {
+		*karg = sk_wmem_alloc_get(sk);
+		return 0;
+	}
+	case SIOCINQ: {
+		struct sk_buff *skb;
+
+		spin_lock_bh(&sk->sk_receive_queue.lock);
+		skb = skb_peek(&sk->sk_receive_queue);
+		if (skb)
+			*karg = skb->len;
+		else
+			*karg = 0;
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
+		return 0;
+	}
+
+	default:
+#ifdef CONFIG_IP_MROUTE
+		return ipmr_ioctl(sk, cmd, karg);
+#else
+		return -ENOIOCTLCMD;
+#endif
+	}
+}
+
+#ifdef CONFIG_COMPAT
+static int compat_raw_ioctl(struct sock *sk, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case SIOCOUTQ:
+	case SIOCINQ:
+		return -ENOIOCTLCMD;
+	default:
+#ifdef CONFIG_IP_MROUTE
+		return ipmr_compat_ioctl(sk, cmd, compat_ptr(arg));
+#else
+		return -ENOIOCTLCMD;
+#endif
+	}
+}
+#endif
+
+struct proto raw_prot = {
+	.name		   = "RAW",
+	.owner		   = THIS_MODULE,
+	.close		   = raw_close,
+	.destroy	   = raw_destroy,
+	.connect	   = ip4_datagram_connect,
+	.disconnect	   = __udp_disconnect,
+	.ioctl		   = raw_ioctl,
+	.init		   = raw_sk_init,
+	.setsockopt	   = raw_setsockopt,
+	.getsockopt	   = raw_getsockopt,
+	.sendmsg	   = raw_sendmsg,
+	.recvmsg	   = raw_recvmsg,
+	.bind		   = raw_bind,
+	.backlog_rcv	   = raw_rcv_skb,
+	.release_cb	   = ip4_datagram_release_cb,
+	.hash		   = raw_hash_sk,
+	.unhash		   = raw_unhash_sk,
+	.obj_size	   = sizeof(struct raw_sock),
+	.useroffset	   = offsetof(struct raw_sock, filter),
+	.usersize	   = sizeof_field(struct raw_sock, filter),
+	.h.raw_hash	   = &raw_v4_hashinfo,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	   = compat_raw_ioctl,
+#endif
+	.diag_destroy	   = raw_abort,
+};
-- 
2.55.0

