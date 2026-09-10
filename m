Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484449E5D2;
	Thu, 10 Sep 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051829; cv=none; b=BjouWL0weh2R+eHDUsF+8t+Zl0lkZMOKEBJSh+XdZLf54wXbgTMTfLXxJRd/wIjrr0YdLk5PsnZZlaF5DqYscCm8tKmWvtObUGUsNd2VU3yG7a+Q83QvaoUIjlbtMp5ctb5SDoBb4UUwr1/oMbvOPLrC6MSQ+vAfXB2+UqRFJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051829; c=relaxed/simple;
	bh=Eq8bRBm5N5dodvzQua1zH6X61v/mo0TOIBsWYfUVzys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cu0NBGn4LQXUGyjucZOJvX8aNUzgSu8sfjFHetTjwOfhf80yG6Wby0GR4yg7c1wHNv705heCftIZnTQ8gYMkUa9jkUwe9s1Jv6wF6cZEXtWYAoziFTlX0cYAPnQKl9Rx8CZ7g6bBBDTio+Gy8Z647dA+vNPvnTlq15nB7M2vifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Svpxuodl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uRxp3DgN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bIOAJQzz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YyPmA5Oo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Svpxuodl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uRxp3DgN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bIOAJQzz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YyPmA5Oo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8783A219A3;
	Thu, 10 Sep 2026 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789051820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YP03O9JEVVQPOuwWNB5EbBUfD/rn6eAYEpUY+WtEjno=;
	b=Svpxuodl9YygD6l1w+6fdA0MLnsgiR5EYtMjorJbi62G8cXrfhJD55QkJ9ULk6m90zuvCM
	4GN5yAofCJMYSTctmnRT3XIC4hfa+Q7za5WBGR9HzbMDLed/CzheDUKlUeixIjK76FbqNc
	PERRGT4Fkk9o3x4VrZ7kGv+tzcn+lAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789051820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YP03O9JEVVQPOuwWNB5EbBUfD/rn6eAYEpUY+WtEjno=;
	b=uRxp3DgN3AP9cBTLgL8dUPwt9ocJ+ZuE+IEptoVh7+Tmqoa9X/UOHsZn8RDqcf3DoD2XgC
	g4KEkEuW9hVtplDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789051816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YP03O9JEVVQPOuwWNB5EbBUfD/rn6eAYEpUY+WtEjno=;
	b=bIOAJQzzR9mfDBMr/mteQbfbdAbEklE/frzL2Pp9d/FbaTK1n7yllL0tvlanUP31gVaOpZ
	4dJFsg37Ay3j/tbi1XFiiiTgzjPRdaOevyxZsMmCdiKz84D+4XkP3uDbqZTqF0a3m6uK3z
	y2FNn6R70gaIvl1jyRycOPeeql0xZCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789051816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YP03O9JEVVQPOuwWNB5EbBUfD/rn6eAYEpUY+WtEjno=;
	b=YyPmA5OoPyV3L3Ox/3JrjLLY6x4yp8XoaqJf7O1YgfYGkRUDLuKEM5RZDuhAKFp3Ocly2I
	yn6Q8DuJTsSEcYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EBF113180;
	Thu, 10 Sep 2026 14:50:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cOMwHKfDomogZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 10 Sep 2026 14:50:15 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Kees Cook <kees@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/13 net-next] net: inet: relocate ip_generic_getfrag and guard IPv4 socket logic
Date: Thu, 10 Sep 2026 16:48:28 +0200
Message-ID: <20260910144914.8025-4-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910144914.8025-1-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,suse.de,nvidia.com,gmail.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
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
 net/ipv4/af_inet.c   | 96 +++++++++++++++++++++++++++++++++++++-------
 net/ipv4/ip_output.c | 18 ---------
 net/ipv6/af_inet6.c  |  5 +++
 net/ipv6/datagram.c  | 12 ++++++
 4 files changed, 99 insertions(+), 32 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index d9421ac38d78..b0c48ba544bf 100644
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
@@ -425,8 +447,10 @@ int inet_release(struct socket *sock)
 		if (!sk->sk_kern_sock)
 			BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk);
 
+#if IS_ENABLED(CONFIG_IPV4)
 		/* Applications forget to leave groups before exiting */
 		ip_mc_drop_socket(sk);
+#endif
 
 		/* If linger is set, we don't return until the close
 		 * is complete.  Otherwise we return immediately. The
@@ -478,6 +502,7 @@ EXPORT_SYMBOL(inet_bind);
 int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 		u32 flags)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
 	struct inet_sock *inet = inet_sk(sk);
 	struct net *net = sock_net(sk);
@@ -570,6 +595,9 @@ int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 		release_sock(sk);
 out:
 	return err;
+#else
+	return -EAFNOSUPPORT;
+#endif
 }
 
 int inet_dgram_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
@@ -962,18 +990,24 @@ EXPORT_SYMBOL(inet_shutdown);
 int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct sock *sk = sock->sk;
-	int err = 0;
-	struct net *net = sock_net(sk);
+#if IS_ENABLED(CONFIG_IPV4)
 	void __user *p = (void __user *)arg;
-	struct ifreq ifr;
+	struct net *net = sock_net(sk);
 	struct rtentry rt;
+	struct ifreq ifr;
+#endif
+	int err = 0;
 
 	switch (cmd) {
 	case SIOCADDRT:
 	case SIOCDELRT:
+#if IS_ENABLED(CONFIG_IPV4)
 		if (copy_from_user(&rt, p, sizeof(struct rtentry)))
 			return -EFAULT;
 		err = ip_rt_ioctl(net, cmd, &rt);
+#else
+		err = -EOPNOTSUPP;
+#endif
 		break;
 	case SIOCRTMSG:
 		err = -EINVAL;
@@ -981,18 +1015,26 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCDARP:
 	case SIOCGARP:
 	case SIOCSARP:
+#if IS_ENABLED(CONFIG_IPV4)
 		err = arp_ioctl(net, cmd, (void __user *)arg);
+#else
+		err = -EOPNOTSUPP;
+#endif
 		break;
 	case SIOCGIFADDR:
 	case SIOCGIFBRDADDR:
 	case SIOCGIFNETMASK:
 	case SIOCGIFDSTADDR:
 	case SIOCGIFPFLAGS:
+#if IS_ENABLED(CONFIG_IPV4)
 		if (get_user_ifreq(&ifr, NULL, p))
 			return -EFAULT;
 		err = devinet_ioctl(net, cmd, &ifr);
 		if (!err && put_user_ifreq(&ifr, p))
 			err = -EFAULT;
+#else
+		err = -EOPNOTSUPP;
+#endif
 		break;
 
 	case SIOCSIFADDR:
@@ -1001,9 +1043,13 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 	case SIOCSIFPFLAGS:
 	case SIOCSIFFLAGS:
+#if IS_ENABLED(CONFIG_IPV4)
 		if (get_user_ifreq(&ifr, NULL, p))
 			return -EFAULT;
 		err = devinet_ioctl(net, cmd, &ifr);
+#else
+		err = -EOPNOTSUPP;
+#endif
 		break;
 	default:
 		if (sk->sk_prot->ioctl)
@@ -1020,6 +1066,7 @@ EXPORT_SYMBOL(inet_ioctl);
 static int inet_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
 		struct compat_rtentry __user *ur)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	compat_uptr_t rtdev;
 	struct rtentry rt;
 
@@ -1035,6 +1082,9 @@ static int inet_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
 
 	rt.rt_dev = compat_ptr(rtdev);
 	return ip_rt_ioctl(sock_net(sk), cmd, &rt);
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 static int inet_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
@@ -1153,6 +1203,7 @@ static const struct net_proto_family inet_family_ops = {
 	.owner	= THIS_MODULE,
 };
 
+#if IS_ENABLED(CONFIG_IPV4)
 /* Upon startup we insert all the elements in inetsw_array[] into
  * the linked list inetsw.
  */
@@ -1166,7 +1217,6 @@ static struct inet_protosw inetsw_array[] =
 		.flags =      INET_PROTOSW_PERMANENT |
 			      INET_PROTOSW_ICSK,
 	},
-
 	{
 		.type =       SOCK_DGRAM,
 		.protocol =   IPPROTO_UDP,
@@ -1193,6 +1243,7 @@ static struct inet_protosw inetsw_array[] =
 };
 
 #define INETSW_ARRAY_LEN ARRAY_SIZE(inetsw_array)
+#endif
 
 void inet_register_protosw(struct inet_protosw *p)
 {
@@ -1258,6 +1309,7 @@ EXPORT_SYMBOL(inet_unregister_protosw);
 
 static int inet_sk_reselect_saddr(struct sock *sk)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	struct inet_sock *inet = inet_sk(sk);
 	__be32 old_saddr = inet->inet_saddr;
 	__be32 daddr = inet->inet_daddr;
@@ -1309,6 +1361,9 @@ static int inet_sk_reselect_saddr(struct sock *sk)
 	 * uniqueness. Wait for troubles.
 	 */
 	return __sk_prot_rehash(sk);
+#else
+	return -EAFNOSUPPORT;
+#endif
 }
 
 int inet_sk_rebuild_header(struct sock *sk)
@@ -1361,6 +1416,7 @@ void inet_sk_state_store(struct sock *sk, int newstate)
 struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 				 netdev_features_t features)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	bool udpfrag = false, fixedid = false, gso_partial, encap;
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	const struct net_offload *ops;
@@ -1451,6 +1507,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 out:
 	return segs;
+#else
+	return ERR_PTR(-EPROTONOSUPPORT);
+#endif
 }
 
 static struct sk_buff *ipip_gso_segment(struct sk_buff *skb,
@@ -1774,6 +1833,10 @@ static int __init init_ipv4_mibs(void)
 	return register_pernet_subsys(&ipv4_mib_ops);
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
+static int ipv4_proc_init(void);
+#endif
+
 static __net_init int inet_init_net(struct net *net)
 {
 	/*
@@ -1824,8 +1887,6 @@ static int __init init_inet_pernet_ops(void)
 	return register_pernet_subsys(&af_inet_ops);
 }
 
-static int ipv4_proc_init(void);
-
 /*
  *	IP protocol layer initialiser
  */
@@ -1870,26 +1931,30 @@ static int __init ipv4_offload_init(void)
 
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
 	if (rc)
 		goto out;
-
 	rc = proto_register(&udp_prot, 1);
 	if (rc)
 		goto out_unregister_tcp_proto;
@@ -1926,7 +1991,6 @@ static int __init inet_init(void)
 	};
 	if (inet_add_protocol(&net_hotdata.udp_protocol, IPPROTO_UDP) < 0)
 		pr_crit("%s: Cannot add UDP protocol\n", __func__);
-
 	net_hotdata.tcp_protocol = (struct net_protocol) {
 		.handler	=	tcp_v4_rcv,
 		.err_handler	=	tcp_v4_err,
@@ -1958,7 +2022,7 @@ static int __init inet_init(void)
 	 */
 
 	ip_init();
-
+#endif /* CONFIG_IPV4 */
 	/* Initialise per-cpu ipv4 mibs */
 	if (init_ipv4_mibs())
 		panic("%s: Cannot init ipv4 mibs\n", __func__);
@@ -1980,6 +2044,9 @@ static int __init inet_init(void)
 	if (icmp_init() < 0)
 		panic("Failed to create the ICMP control socket.\n");
 
+	if (init_inet_pernet_ops())
+		pr_crit("%s: Cannot init ipv4 inet pernet ops\n", __func__);
+#if IS_ENABLED(CONFIG_IPV4)
 	/*
 	 *	Initialise the multicast router
 	 */
@@ -1987,19 +2054,17 @@ static int __init inet_init(void)
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
@@ -2009,12 +2074,14 @@ static int __init inet_init(void)
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
@@ -2051,3 +2118,4 @@ static int __init ipv4_proc_init(void)
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
+#endif
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 74e095b6b7ca..dbcac1921101 100644
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
index f0efdc13baf4..d194906f8a5e 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -299,6 +299,7 @@ int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 
 	/* Check if the address belongs to the host. */
 	if (addr_type == IPV6_ADDR_MAPPED) {
+#if IS_ENABLED(CONFIG_IPV4)
 		struct net_device *dev = NULL;
 		int chk_addr_ret;
 
@@ -329,6 +330,10 @@ int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 			err = -EADDRNOTAVAIL;
 			goto out;
 		}
+#else
+		err = -EADDRNOTAVAIL;
+		goto out;
+#endif
 	} else {
 		if (addr_type != IPV6_ADDR_ANY) {
 			struct net_device *dev = NULL;
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 191c9733ff9f..ff7a56ff8368 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -33,10 +33,12 @@
 #include <linux/errqueue.h>
 #include <linux/uaccess.h>
 
+#if IS_ENABLED(CONFIG_IPV4)
 static bool ipv6_mapped_addr_any(const struct in6_addr *a)
 {
 	return ipv6_addr_v4mapped(a) && (a->s6_addr32[3] == 0);
 }
+#endif
 
 static void ip6_datagram_flow_key_init(struct flowi6 *fl6,
 				       const struct sock *sk)
@@ -153,10 +155,14 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	int			err;
 
 	if (usin->sin6_family == AF_INET) {
+#if IS_ENABLED(CONFIG_IPV4)
 		if (ipv6_only_sock(sk))
 			return -EAFNOSUPPORT;
 		err = __ip4_datagram_connect(sk, uaddr, addr_len);
 		goto ipv4_connected;
+#else
+		return -EAFNOSUPPORT;
+#endif
 	}
 
 	if (addr_len < SIN6_LEN_RFC2133)
@@ -184,6 +190,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	daddr = &usin->sin6_addr;
 
 	if (addr_type & IPV6_ADDR_MAPPED) {
+#if IS_ENABLED(CONFIG_IPV4)
 		struct sockaddr_in sin;
 
 		if (ipv6_only_sock(sk)) {
@@ -217,6 +224,9 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 		}
 
 		goto out;
+#else
+		return -ENETUNREACH;
+#endif
 	}
 
 	if (__ipv6_addr_needs_scope_id(addr_type)) {
@@ -522,10 +532,12 @@ int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len)
 				ipv6_iface_scope_id(&sin->sin6_addr,
 						    IP6CB(skb)->iif);
 		} else {
+#if IS_ENABLED(CONFIG_IPV4)
 			ipv6_addr_set_v4mapped(ip_hdr(skb)->saddr,
 					       &sin->sin6_addr);
 			if (inet_cmsg_flags(inet_sk(sk)))
 				ip_cmsg_recv(msg, skb);
+#endif
 		}
 	}
 
-- 
2.55.0

