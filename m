Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F94E50A6;
	Wed, 30 Sep 2026 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776472; cv=none; b=TWT6dr91HJqkOywu4DviKH8uQDyCxCy1QMTYr/fJgMekgLNJtH1GI03e8AVMqzLSPNPvtjjyG2tH752Mi5DH/odUKqA++LMVk8oLuOaTG3HhlDKyOzvol8upWUsp8EnaT+rsr8j4GG53GcUxpYB15rWYdXApH+T/Xpdqjq8Jnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776472; c=relaxed/simple;
	bh=D3VdTbEqMD9ShWbrIRdevDX/hse4XQWZBULHpw9DK6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3uAgbN0BxS9caHUVPGosgrBp6uT/LLDuiABSLAEp0W2iiSmBlNlyRv+LiuSkw3v+CaOJ7NBKqMfm2tkccHkxTKdO06PBts4T7W763fZwj+JR2YrYgzHEvYL2nDX/oioXKaq6gxIH5PE9oC7g1Hn/PB9wfWde3wpUZntnmeI6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=koH1DJbW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=96h+oruI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xW4Q+5tr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wo3kVPfS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="koH1DJbW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="96h+oruI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xW4Q+5tr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wo3kVPfS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DF5C21E35;
	Wed, 30 Sep 2026 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790776450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhni3is6EbtM9KITkGC8PhBPvn9IjE2XPwQ1jRAFRug=;
	b=koH1DJbWbzvYGQDEUgXP43IhT1lKepYqWhI7v+ThL88IiZ69UEKrL9Iwzw/IVZL8n1iZtS
	slk2FHXglE7AHhfE2BRP13iu+Tr0ULe1vQwPiphufuvnlsdIfNZJT9csYRImeiuQkcFVeY
	csKczoS1Udg+KCanrJ/TphtpBRjGRJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790776450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhni3is6EbtM9KITkGC8PhBPvn9IjE2XPwQ1jRAFRug=;
	b=96h+oruI+vN6xIcZiXPCq3TMz0V+2ZF4i/jOGaveBoCzFCp5J+MNaze4Z6/3L4H1ujcisv
	7ZeWwzUC/dRSx1Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790776446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhni3is6EbtM9KITkGC8PhBPvn9IjE2XPwQ1jRAFRug=;
	b=xW4Q+5trQTLw8OZNJY5CKrbJAT3EdjYee8vRv0z1uzrTp/dS/igSFozIn1A2SlMiFDW9i9
	FNdnVv7P2CsXMNueOWbfgD6D+UOgr0hz913G73GQ5n1OsAijQd3W0625qXW7DO3l0dIj6U
	uovsgUi67GX1tavBqQKcdowef/2W9oA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790776446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhni3is6EbtM9KITkGC8PhBPvn9IjE2XPwQ1jRAFRug=;
	b=wo3kVPfSPeu5Z8WeeXvdRQFRVHk9bg7Odsvt/ZoZ8QW+VpSJNMyHz93fmgz/ZA6H1+pB/5
	nwIN4vlA6oQyO4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F379813ABD;
	Wed, 30 Sep 2026 13:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJXpHGIUvWqUTwAAD6G6ig:T4
	(envelope-from <fmancera@suse.de>); Wed, 30 Sep 2026 13:54:04 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jeff Layton <jlayton@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/16 net-next v3] net: inet: relocate ip_generic_getfrag and guard IPv4 socket logic
Date: Wed, 30 Sep 2026 15:52:46 +0200
Message-ID: <20260930135334.4739-4-fmancera@suse.de>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.979];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,davemloft.net,suse.de,google.com,nvidia.com,linux.dev,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

To enable compiling the INET subsystem without IPv4, shared generic
utilities must be relocated and IPv4 socket logic must be guarded for
CONFIG_IPV4.

This patch moves the generic ip_generec_getfrag() from ip_output.c to
af_inet.c. It also introduces CONFIG_IPV4 guards around af_inet.c to
reject IPv4-specific ioctls, protocol registrations and bind requests.
The same guard is added to reject IPv4-mapped IPv6.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/af_inet.c   | 122 ++++++++++++++++++++++++++++++++-----------
 net/ipv4/ip_output.c |  18 -------
 net/ipv6/af_inet6.c  |   5 ++
 net/ipv6/datagram.c  |   4 +-
 4 files changed, 99 insertions(+), 50 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index d9421ac38d78..a9d46a178f9a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -129,6 +129,28 @@
 int disable_ipv6_mod;
 EXPORT_SYMBOL(disable_ipv6_mod);
 
+/* Keep the function here for now as it is generic, it should be moved
+ * to a common L3 place
+ */
+int
+ip_generic_getfrag(void *from, char *to, int offset, int len, int odd, struct sk_buff *skb)
+{
+	struct msghdr *msg = from;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (!copy_from_iter_full(to, len, &msg->msg_iter))
+			return -EFAULT;
+	} else {
+		__wsum csum = 0;
+
+		if (!csum_and_copy_from_iter_full(to, len, &csum, &msg->msg_iter))
+			return -EFAULT;
+		skb->csum = csum_block_add(skb->csum, csum, odd);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(ip_generic_getfrag);
+
 /* The inetsw table contains everything that inet_create needs to
  * build a new socket.
  */
@@ -426,7 +448,8 @@ int inet_release(struct socket *sock)
 			BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk);
 
 		/* Applications forget to leave groups before exiting */
-		ip_mc_drop_socket(sk);
+		if (IS_ENABLED(CONFIG_IPV4))
+			ip_mc_drop_socket(sk);
 
 		/* If linger is set, we don't return until the close
 		 * is complete.  Otherwise we return immediately. The
@@ -486,6 +509,9 @@ int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 	u32 tb_id = RT_TABLE_LOCAL;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return -EAFNOSUPPORT;
+
 	if (addr->sin_family != AF_INET) {
 		/* Compatibility games : accept AF_UNSPEC (mapped to AF_INET)
 		 * only if s_addr is INADDR_ANY.
@@ -968,6 +994,9 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	struct ifreq ifr;
 	struct rtentry rt;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return -EOPNOTSUPP;
+
 	switch (cmd) {
 	case SIOCADDRT:
 	case SIOCDELRT:
@@ -1023,6 +1052,9 @@ static int inet_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
 	compat_uptr_t rtdev;
 	struct rtentry rt;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return -EOPNOTSUPP;
+
 	if (copy_from_user(&rt.rt_dst, &ur->rt_dst,
 			3 * sizeof(struct sockaddr)) ||
 	    get_user(rt.rt_flags, &ur->rt_flags) ||
@@ -1201,6 +1233,9 @@ void inet_register_protosw(struct inet_protosw *p)
 	int protocol = p->protocol;
 	struct list_head *last_perm;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return;
+
 	spin_lock_bh(&inetsw_lock);
 
 	if (p->type >= SOCK_MAX)
@@ -1243,6 +1278,9 @@ EXPORT_SYMBOL(inet_register_protosw);
 
 void inet_unregister_protosw(struct inet_protosw *p)
 {
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return;
+
 	if (INET_PROTOSW_PERMANENT & p->flags) {
 		pr_err("Attempt to unregister permanent protocol %d\n",
 		       p->protocol);
@@ -1267,6 +1305,9 @@ static int inet_sk_reselect_saddr(struct sock *sk)
 	struct ip_options_rcu *inet_opt;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return -EAFNOSUPPORT;
+
 	inet_opt = rcu_dereference_protected(inet->inet_opt,
 					     lockdep_sock_is_held(sk));
 	if (inet_opt && inet_opt->opt.srr)
@@ -1371,6 +1412,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int ihl;
 	int id;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return ERR_PTR(-EPROTONOSUPPORT);
+
 	skb_reset_network_header(skb);
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
@@ -1876,14 +1920,12 @@ static struct packet_type ip_packet_type __read_mostly = {
 	.list_func = ip_list_rcv,
 };
 
-static int __init inet_init(void)
+static int __init inet4_init(void)
 {
 	struct inet_protosw *q;
 	struct list_head *r;
 	int rc;
 
-	sock_skb_cb_check_size(sizeof(struct inet_skb_parm));
-
 	raw_hashinfo_init(&raw_v4_hashinfo);
 
 	rc = proto_register(&tcp_prot, 1);
@@ -1959,6 +2001,45 @@ static int __init inet_init(void)
 
 	ip_init();
 
+	return 0;
+out_unregister_raw_proto:
+	proto_unregister(&raw_prot);
+out_unregister_udp_proto:
+	proto_unregister(&udp_prot);
+out_unregister_tcp_proto:
+	proto_unregister(&tcp_prot);
+out:
+	return rc;
+}
+
+static void __init inet4_late_init(void)
+{
+	/*
+	 *	Initialise the multicast router
+	 */
+#if defined(CONFIG_IP_MROUTE)
+	if (ip_mr_init())
+		pr_crit("%s: Cannot init ipv4 mroute\n", __func__);
+#endif
+	ipv4_proc_init();
+
+	ipfrag_init();
+
+	dev_add_pack(&ip_packet_type);
+}
+
+static int __init inet_init(void)
+{
+	int rc;
+
+	sock_skb_cb_check_size(sizeof(struct inet_skb_parm));
+
+	if (IS_ENABLED(CONFIG_IPV4)) {
+		rc = inet4_init();
+		if (rc)
+			return rc;
+	}
+
 	/* Initialise per-cpu ipv4 mibs */
 	if (init_ipv4_mibs())
 		panic("%s: Cannot init ipv4 mibs\n", __func__);
@@ -1980,35 +2061,20 @@ static int __init inet_init(void)
 	if (icmp_init() < 0)
 		panic("Failed to create the ICMP control socket.\n");
 
-	/*
-	 *	Initialise the multicast router
-	 */
-#if defined(CONFIG_IP_MROUTE)
-	if (ip_mr_init())
-		pr_crit("%s: Cannot init ipv4 mroute\n", __func__);
-#endif
-
 	if (init_inet_pernet_ops())
 		pr_crit("%s: Cannot init ipv4 inet pernet ops\n", __func__);
 
-	ipv4_proc_init();
-
-	ipfrag_init();
+#ifdef CONFIG_PROC_FS
+	if (ip_misc_proc_init())
+		pr_crit("%s: Cannot init ipv4 misc proc\n", __func__);
+#endif
 
-	dev_add_pack(&ip_packet_type);
+	if (IS_ENABLED(CONFIG_IPV4))
+		inet4_late_init();
 
 	ip_tunnel_core_init();
 
-	rc = 0;
-out:
-	return rc;
-out_unregister_raw_proto:
-	proto_unregister(&raw_prot);
-out_unregister_udp_proto:
-	proto_unregister(&udp_prot);
-out_unregister_tcp_proto:
-	proto_unregister(&tcp_prot);
-	goto out;
+	return 0;
 }
 
 fs_initcall(inet_init);
@@ -2028,12 +2094,8 @@ static int __init ipv4_proc_init(void)
 		goto out_udp;
 	if (ping_proc_init())
 		goto out_ping;
-	if (ip_misc_proc_init())
-		goto out_misc;
 out:
 	return rc;
-out_misc:
-	ping_proc_exit();
 out_ping:
 	udp4_proc_exit();
 out_udp:
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a24cc8ee11d3..4c6b34e70990 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -932,24 +932,6 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(ip_do_fragment);
 
-int
-ip_generic_getfrag(void *from, char *to, int offset, int len, int odd, struct sk_buff *skb)
-{
-	struct msghdr *msg = from;
-
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		if (!copy_from_iter_full(to, len, &msg->msg_iter))
-			return -EFAULT;
-	} else {
-		__wsum csum = 0;
-		if (!csum_and_copy_from_iter_full(to, len, &csum, &msg->msg_iter))
-			return -EFAULT;
-		skb->csum = csum_block_add(skb->csum, csum, odd);
-	}
-	return 0;
-}
-EXPORT_SYMBOL(ip_generic_getfrag);
-
 static int __ip_append_data(struct sock *sk,
 			    struct flowi4 *fl4,
 			    struct sk_buff_head *queue,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index f0efdc13baf4..f220eaab085b 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -302,6 +302,11 @@ int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 		struct net_device *dev = NULL;
 		int chk_addr_ret;
 
+		if (!IS_ENABLED(CONFIG_IPV4)) {
+			err = -EADDRNOTAVAIL;
+			goto out;
+		}
+
 		/* Binding to v4-mapped address on a v6-only socket
 		 * makes no sense
 		 */
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 191c9733ff9f..079d1951405b 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -153,7 +153,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	int			err;
 
 	if (usin->sin6_family == AF_INET) {
-		if (ipv6_only_sock(sk))
+		if (!IS_ENABLED(CONFIG_IPV4) || ipv6_only_sock(sk))
 			return -EAFNOSUPPORT;
 		err = __ip4_datagram_connect(sk, uaddr, addr_len);
 		goto ipv4_connected;
@@ -186,7 +186,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (addr_type & IPV6_ADDR_MAPPED) {
 		struct sockaddr_in sin;
 
-		if (ipv6_only_sock(sk)) {
+		if (!IS_ENABLED(CONFIG_IPV4) || ipv6_only_sock(sk)) {
 			err = -ENETUNREACH;
 			goto out;
 		}
-- 
2.55.0

