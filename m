Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56DE4F5E11;
	Mon, 28 Sep 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623909; cv=none; b=WHm0jcFYl7lSntW5W29GBFIlydhc69+2CwMkVJUF0V/tzFAyV9Pe2MhjjhdGD9NbTI+GR7yGacMx6vJc/UH9bbBgrhM9c2HlaatFDQ1cmpid0ilE+yhEXEoBl8HG62vOY0pCh4cemLQS+yudV9Pwxq9pS0YNYH4DMUvS9q2TUws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623909; c=relaxed/simple;
	bh=p4xMUAoV47rG0aYO3Inzajlrdg/yNKGrRD0rRlUK5Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzeVu2j8VSK6DJlIwmAix0DyXtP8oIpPO/JvGIe2cBBdewEoHWpZ0KBsNvyk3dH9oUJ2PLPru3NflCrAOlOVj1Sj7+Naejk3DjMaJWjI6XEjjnuycsuVO8yl1GK0nodTjEHr6jOiwyAHmKa7AB5/0PMlkH6L0MwKhgbW3G8750c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L5s4QsEb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JATAl0I7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cLjz2rTG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HLYCJtnc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L5s4QsEb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JATAl0I7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cLjz2rTG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HLYCJtnc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF09B21B07;
	Mon, 28 Sep 2026 19:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790623902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lp8hvIoJ8Jqv5jVfxnkcNIiODK0r856bKYALyBJ9J64=;
	b=L5s4QsEbUM5yiiBk+Xhx9cpcoUgPyqcP1OheRAQqezWRh0RQqfqEHjilwE31wlZq7qW3Tm
	Dv16wldX6r9SWydvxSfetQrbFYwUZ4mJ+mrcVNDRDBqsvRyukKCw+JosEpOtCDoxjOHRqB
	z62cnRIB0Of55fYC2pQAzqmBQln0mY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790623902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lp8hvIoJ8Jqv5jVfxnkcNIiODK0r856bKYALyBJ9J64=;
	b=JATAl0I7a6OPqbtPGjBQ6sTtvBA5HmDXmQXj57likKBvvHucdchtmtgqzjpY2p1JCg1J//
	mzZQizAYummc2PBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790623897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lp8hvIoJ8Jqv5jVfxnkcNIiODK0r856bKYALyBJ9J64=;
	b=cLjz2rTGFaDPu0ne0V7ZLAMl3gPYXFO9S3QYZg9VrhENI7TRO4x3FpT+nWWtrcS4wEZXp0
	j50nL0LeoM45nakxauQ2UIA9Mgch5C6n0M1X+xzmiUB/LMjJa5p8t4cnerx5flStark503
	QJl05nKFqUsxTRlaQRSqx9DUxm3DY2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790623897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lp8hvIoJ8Jqv5jVfxnkcNIiODK0r856bKYALyBJ9J64=;
	b=HLYCJtncjLZSNZEAeLFOJRIr6Xq1NGH2j80UeHYjmLo95GGh6qJeBbdvQvlpJaIv88+IIQ
	VrcvO+N8QZs7wMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C55F313418;
	Mon, 28 Sep 2026 19:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4RBiFn3AumpWOAAAD6G6ig:T4
	(envelope-from <fmancera@suse.de>); Mon, 28 Sep 2026 19:31:36 +0000
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/16 net-next v2] net: inet: relocate ip_generic_getfrag and guard IPv4 socket logic
Date: Mon, 28 Sep 2026 21:29:59 +0200
Message-ID: <20260928193046.6698-4-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928193046.6698-1-fmancera@suse.de>
References: <20260928193046.6698-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,davemloft.net,suse.de,google.com,nvidia.com,linux.dev,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

To enable compiling the INET subsystem without IPv4, shared generic
utilities must be relocated and IPv4 socket logic must be guarded for
CONFIG_IPV4.

This patch moves the generic ip_generec_getfrag() from ip_output.c to
af_inet.c. It also introduces CONFIG_IPV4 guards around af_inet.c to
reject IPv4-specific ioctls, protocol registrations and bind requests.
The same guard is added to reject IPv4-mapped IPv6.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/af_inet.c   | 69 ++++++++++++++++++++++++++++++++++++++------
 net/ipv4/ip_output.c | 18 ------------
 net/ipv6/af_inet6.c  |  5 ++++
 net/ipv6/datagram.c  |  4 +--
 4 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index d9421ac38d78..cf00386933d6 100644
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
@@ -1153,6 +1185,7 @@ static const struct net_proto_family inet_family_ops = {
 	.owner	= THIS_MODULE,
 };
 
+#if IS_ENABLED(CONFIG_IPV4)
 /* Upon startup we insert all the elements in inetsw_array[] into
  * the linked list inetsw.
  */
@@ -1193,6 +1226,7 @@ static struct inet_protosw inetsw_array[] =
 };
 
 #define INETSW_ARRAY_LEN ARRAY_SIZE(inetsw_array)
+#endif
 
 void inet_register_protosw(struct inet_protosw *p)
 {
@@ -1267,6 +1301,9 @@ static int inet_sk_reselect_saddr(struct sock *sk)
 	struct ip_options_rcu *inet_opt;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return -EAFNOSUPPORT;
+
 	inet_opt = rcu_dereference_protected(inet->inet_opt,
 					     lockdep_sock_is_held(sk));
 	if (inet_opt && inet_opt->opt.srr)
@@ -1371,6 +1408,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int ihl;
 	int id;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return ERR_PTR(-EPROTONOSUPPORT);
+
 	skb_reset_network_header(skb);
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
@@ -1774,6 +1814,10 @@ static int __init init_ipv4_mibs(void)
 	return register_pernet_subsys(&ipv4_mib_ops);
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
+static int ipv4_proc_init(void);
+#endif
+
 static __net_init int inet_init_net(struct net *net)
 {
 	/*
@@ -1824,8 +1868,6 @@ static int __init init_inet_pernet_ops(void)
 	return register_pernet_subsys(&af_inet_ops);
 }
 
-static int ipv4_proc_init(void);
-
 /*
  *	IP protocol layer initialiser
  */
@@ -1870,20 +1912,25 @@ static int __init ipv4_offload_init(void)
 
 fs_initcall(ipv4_offload_init);
 
+#if IS_ENABLED(CONFIG_IPV4)
 static struct packet_type ip_packet_type __read_mostly = {
 	.type = cpu_to_be16(ETH_P_IP),
 	.func = ip_rcv,
 	.list_func = ip_list_rcv,
 };
+#endif
 
 static int __init inet_init(void)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	struct inet_protosw *q;
 	struct list_head *r;
 	int rc;
+#endif
 
 	sock_skb_cb_check_size(sizeof(struct inet_skb_parm));
 
+#if IS_ENABLED(CONFIG_IPV4)
 	raw_hashinfo_init(&raw_v4_hashinfo);
 
 	rc = proto_register(&tcp_prot, 1);
@@ -1958,7 +2005,7 @@ static int __init inet_init(void)
 	 */
 
 	ip_init();
-
+#endif /* CONFIG_IPV4 */
 	/* Initialise per-cpu ipv4 mibs */
 	if (init_ipv4_mibs())
 		panic("%s: Cannot init ipv4 mibs\n", __func__);
@@ -1980,6 +2027,9 @@ static int __init inet_init(void)
 	if (icmp_init() < 0)
 		panic("Failed to create the ICMP control socket.\n");
 
+	if (init_inet_pernet_ops())
+		pr_crit("%s: Cannot init ipv4 inet pernet ops\n", __func__);
+#if IS_ENABLED(CONFIG_IPV4)
 	/*
 	 *	Initialise the multicast router
 	 */
@@ -1987,19 +2037,17 @@ static int __init inet_init(void)
 	if (ip_mr_init())
 		pr_crit("%s: Cannot init ipv4 mroute\n", __func__);
 #endif
-
-	if (init_inet_pernet_ops())
-		pr_crit("%s: Cannot init ipv4 inet pernet ops\n", __func__);
-
 	ipv4_proc_init();
 
 	ipfrag_init();
 
 	dev_add_pack(&ip_packet_type);
+#endif /* CONFIG_IPV4 */
 
 	ip_tunnel_core_init();
 
-	rc = 0;
+	return 0;
+#if IS_ENABLED(CONFIG_IPV4)
 out:
 	return rc;
 out_unregister_raw_proto:
@@ -2009,12 +2057,14 @@ static int __init inet_init(void)
 out_unregister_tcp_proto:
 	proto_unregister(&tcp_prot);
 	goto out;
+#endif
 }
 
 fs_initcall(inet_init);
 
 /* ------------------------------------------------------------------------ */
 
+#if IS_ENABLED(CONFIG_IPV4)
 #ifdef CONFIG_PROC_FS
 static int __init ipv4_proc_init(void)
 {
@@ -2051,3 +2101,4 @@ static int __init ipv4_proc_init(void)
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
+#endif
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

