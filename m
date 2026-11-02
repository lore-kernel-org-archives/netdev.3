Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635118;
	b=MSP8uVhf1JQ5aec8MHCF65y1EG5qHzKw6y95ePXD/jWLIg5kNGu2rP8SxTa+/CdnGrRQ
	 14Q4oRBkLyn/r/ck3bATRRGuzgAUg3769kNYgKEshtrS79ifbnGt/OJpZ4xnaLHgN3sq9
	 tzUKInEgu99tJ9h1ZuSsKnJl37F9wBol0O8MwAEBwoNmVbrcCPdka30pIXhfj+tCLeNFo
	 fiLpgy7VyVskpL/4r8MvfFtDOVSm1WDjJY3gHCQsbeVLKaF6pRGeDT5AGymXCqa5rX1Oa
	 u6oLabfMEH0y3WsQt7ZWAJCDZjryrQlYrQx+l32OURDXC8JH5MsOkpBaJCJActFdZaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RZZZPondBqt3Vp/YWeNv5hJhPOB7ie0frgI1Up6MMS4=;
	b=E1K4wU0sfkz8yvYOdEbr+MvKGt/8stGRooFGYqKuAai1VAba9Y9MD9FNtufcCU6e9HZt
	 UiYZWegQ53OixEMh33JQeJwStma51d3GdgFGIOhYySrbFCfBzeoI9ZGyKpAl4hbbAlt12
	 zpyKmwHB6YgQp977G64bNT3COxlbodqU7Bww/a5rP4Q84JLjaPp8L7s+xIWfdMskKfv0n
	 7eJqpe261/hhixQiZxHt4ttU889pLQhZa/723S5ZlQBFLRauI/E0KoJ8vsz2Ms3xy6x5O
	 +KeiEz+Cn2HBRk2FZ75Wy/Pg+AQmvyqC/ol7NxPFDBoboRN0iN3y5pc2TO8L8TPT9RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fo2nom8b;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912E60B57FA
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8912E60B57FA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fo2nom8b
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so5968579eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635118; x=1794239918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZZZPondBqt3Vp/YWeNv5hJhPOB7ie0frgI1Up6MMS4=;
        b=fo2nom8bxR1lQrtKErd6uSWW6DCvGREDariZr7GiERSjaI0+C6P+t7nzdpbflMyF3A
         useC5kRSjB/ombrYD2JsIgVi84bOtYdHT7+Vc5GPw01zgdlVxLcw90A1GnwssObbAi4y
         aV2XOt3wHnzpuLa7wqztDGS1BcZZqnK7LeI/HnjdLpvT0PjdlAqkEkFweq/wkwfmOv9j
         dFGM/lLo7mpWGjEQvqIplY1oj/juYOLI1fhk+KoxjDrbFN4XjJbRa3IY4sBlXwGBs1f5
         daVb/d/b09B8vOoy6mlZMNeMF3A9MIX6oZsWtuYacrfy0v58cRHkZKuets0P1SfA0SY8
         +N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635118; x=1794239918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZZZPondBqt3Vp/YWeNv5hJhPOB7ie0frgI1Up6MMS4=;
        b=BOrYhjACBrRkYDpsnLCmHztlNxnHtH+u5QSA+GwZn4vbNc0b6oq4b8JD6TNx15CrUF
         bQLxFgi8kLzsGM2+VMkLo6Bc6Zy6+BL4DL3uBql6KU4U2oFCMTAssY2LGEpY7Q8nzFcb
         +harzkRtb95BV7OXQr+x5XCwd2MLb4RPSs/Am8HxvSeg5D8+4SU/OR+o+oa3i4FcEOPn
         t4QC2MOctkc6VJawhAhC12ZRe272pEKgMsVduHvcc0LWUQPKGrgJMcqG14mj1+pLy8UL
         2lNM7sjC6XPOCYgJ4Qkes5yR07BUZoYD0eFK6Z9F35ShsgHd0KVt/AYp3u5naFayo7+5
         rbGQ==
X-Gm-Message-State: AFq9FYKg8arluN/B3cNOZl4Hl+3NTpWIh102oeJfyyqmx31dhP4TCeQw
	OYkF3rfcKfy6YkCHb3R5D9OuO8xs1+Kndb8A2dUPzAZMyXDfuE9Zfk2ze234qw==
X-Gm-Gg: AYBFou1i1jvbierOlc/Jx/ANPMH6hNpJElSh69hPI8cs3a0ZyrHFQNfKRXGDuEbWcIO
	e4/+FgK4ZcJBYQhIAPWFhjgRkXPtGsQxfFIigMBESfn7q33BYZ6i6zD0EobbBrDezudFaEx8u6R
	gGSno4tpUo9O4BW0R0GV5TW40/iDOxt+zJjFMIcwG6ZKPQcfMLSj4IT3mBynI4z78KW6nPZZjGY
	MkUvJIuqCHkr1jEadFyPbFW/pBmL0wIYQXyPo8GcD0BXO4Tov7H6hA/V37L0LCbuyW/CkRF14uf
	pokyBZmFHo8U2XCaf/tkI2wizcDgxaQ1VrQChiU6+v89OgjiHMKCtwXCzohfCj9CT4fwZtHpWzO
	3hdHvCOI/tpskU5pESmlDviN2OoZMtUiEWtRHzLbg4Vw1KHyva9+0JMzvabrcWbkRFzv9NwwYt3
	2W0uuTu2jj3XVmy73BCD/wv9dlRJ+Cx0J1nmmsg8LOo+NC65PLXnWVtZiccDk9sY8b0KXKhlnwc
	zHMpOP1ofSIvi6/B6B/pEuNaACm7VSqmDZCPwdeIIE7Ws2elZNEPdeTppdDLZMrSrPkPfKSpi7V
	1MWVIKMTrmPvgeP0/7tKaxtlCO16tqQLEixHQfnf6uGe7Fs0/vx+YZ2vqzlwXMkTxE/MT9mVZ/w
	8JWaMqxwdWGY6LYATkqtc5tAS/OvwqPQ71WpbC8SWSixLJIMUVL5y02wKiHMg7t6u0ygMLdqGCw
	==
X-Received: by 2002:a05:7022:f51c:b0:14a:5284:1bf5 with SMTP id a92af1059eb24-1ac5b02881dmr14514852c88.13.1793635117354;
        Mon, 02 Nov 2026 07:58:37 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm35115869c88.12.2026.11.02.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:58:36 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <martineau@kernel.org>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net v4 2/2] netlink: Check a group again if it was released while joining it
Date: Mon,  2 Nov 2026 15:58:19 +0000
Message-Id: <20261102155819.4100930-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261102155819.4100930-1-anilkaushikwireless@gmail.com>
References: <20261102155819.4100930-1-anilkaushikwireless@gmail.com>
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

genl_bind() checks a group under cb_lock, but netlink_setsockopt() and
netlink_bind() set the membership bit only after it returns and the lock
is dropped. If the family is unregistered in between, its members are
cleared before this socket is one. The socket then becomes a member of a
group ID that no family owns, or that a family registered in the
meantime got, and the GENL_MCAST_CAP_* flags of that family are never
checked for it.

Count per group in the netlink table how many times its members were
cleared, which genetlink does when it frees the group IDs of a family.
Read the count before and after ->netlink_bind(), and again once the
table is grabbed. If it changed since the first read, the group was
released, so check it again against its current owner.

If the count changed only after ->netlink_bind() returned, the family
that was bound is gone, so ->netlink_unbind() is not called for it.
Otherwise it is called before the new check, as ->netlink_bind() most
likely reached the new owner. The core cannot tell for sure: if a family
is unregistered and another one registers just after ->netlink_bind()
returned, and before the second read, the new family gets an unbind
without a bind. The check is still done again. In the tree, only the
thermal family has these callbacks, and it is never unregistered.

bind() can then fail after it gave the socket its port ID. This only
happens when a family is unregistered meanwhile.

Found by the Sashiko review of the previous patch, not seen in
production. Triggered in a VM as an unprivileged user, with a test-only
msleep() after the bind callback, and a test family that registers again
with GENL_MCAST_CAP_NET_ADMIN:

Before:
  setsockopt() and bind(): the socket is a member of the group

After:
  setsockopt() and bind(): -EPERM, not a member
  setsockopt(), no family owns the group yet: -ENOENT, not a member

genl_bind() was added, with its first capability check, in the commit
in the Fixes tag.

Link: https://lore.kernel.org/netdev/179340003139.3131.11274717768928642724@kernel.org/
Fixes: 4d54cc32112d ("mptcp: avoid lock_fast usage in accept path")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 net/netlink/af_netlink.c | 79 +++++++++++++++++++++++++++++++++++++++-
 net/netlink/af_netlink.h |  1 +
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index fec2879c497d..96bfebc57899 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -780,6 +780,8 @@ static int netlink_release(struct socket *sock)
 			old = nl_deref_protected(nl_table[sk->sk_protocol].listeners);
 			RCU_INIT_POINTER(nl_table[sk->sk_protocol].listeners, NULL);
 			kfree_rcu(old, rcu);
+			kfree(nl_table[sk->sk_protocol].mc_gen);
+			nl_table[sk->sk_protocol].mc_gen = NULL;
 			nl_table[sk->sk_protocol].module = NULL;
 			nl_table[sk->sk_protocol].bind = NULL;
 			nl_table[sk->sk_protocol].unbind = NULL;
@@ -990,6 +992,9 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
 	struct net *net = sock_net(sk);
 	struct netlink_sock *nlk = nlk_sk(sk);
 	struct sockaddr_nl *nladdr = (struct sockaddr_nl *)addr;
+	struct netlink_table *tbl = &nl_table[sk->sk_protocol];
+	unsigned int bound_gen[BITS_PER_TYPE(u32)];
+	unsigned int gen[BITS_PER_TYPE(u32)];
 	int err = 0;
 	unsigned long groups;
 	bool bound;
@@ -1023,9 +1028,14 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
 			return -EINVAL;
 	}
 
+retry:
 	if (nlk->netlink_bind && groups) {
 		int group;
 
+		netlink_lock_table();
+		memcpy(gen, tbl->mc_gen, sizeof(gen));
+		netlink_unlock_table();
+
 		/* nl_groups is a u32, so cap the maximum groups we can bind */
 		for (group = 0; group < BITS_PER_TYPE(u32); group++) {
 			if (!test_bit(group, &groups))
@@ -1036,6 +1046,10 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
 			netlink_undo_bind(group, groups, sk);
 			return err;
 		}
+
+		netlink_lock_table();
+		memcpy(bound_gen, tbl->mc_gen, sizeof(bound_gen));
+		netlink_unlock_table();
 	}
 
 	/* No need for barriers here as we return to user-space without
@@ -1057,6 +1071,26 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
 	netlink_unlock_table();
 
 	netlink_table_grab();
+	if (nlk->netlink_bind && groups) {
+		unsigned long gone = 0;
+		bool released = false;
+		int group;
+
+		for_each_set_bit(group, &groups, BITS_PER_TYPE(u32)) {
+			if (gen[group] != tbl->mc_gen[group])
+				released = true;
+			if (bound_gen[group] != tbl->mc_gen[group])
+				__set_bit(group, &gone);
+		}
+		/* see netlink_setsockopt(), undo all but gone and retry all */
+		if (released) {
+			netlink_table_ungrab();
+			netlink_undo_bind(BITS_PER_TYPE(u32), groups & ~gone,
+					  sk);
+			bound = true;
+			goto retry;
+		}
+	}
 	netlink_update_subscriptions(sk, nlk->subscriptions +
 					 hweight32(groups) -
 					 hweight32(nlk->groups[0]));
@@ -1686,6 +1720,8 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		break;
 	case NETLINK_ADD_MEMBERSHIP:
 	case NETLINK_DROP_MEMBERSHIP: {
+		struct netlink_table *tbl = &nl_table[sk->sk_protocol];
+		unsigned int gen = 0, bound_gen = 0;
 		int err;
 
 		if (!netlink_allowed(sock, NL_CFG_F_NONROOT_RECV))
@@ -1695,12 +1731,34 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 			return err;
 		if (!val || val - 1 >= nlk->ngroups)
 			return -EINVAL;
+retry:
 		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
+			netlink_lock_table();
+			gen = tbl->mc_gen[val - 1];
+			netlink_unlock_table();
 			err = nlk->netlink_bind(sock_net(sk), val);
 			if (err)
 				return err;
+			netlink_lock_table();
+			bound_gen = tbl->mc_gen[val - 1];
+			netlink_unlock_table();
 		}
 		netlink_table_grab();
+		/* The group was released around ->netlink_bind(), and may have
+		 * a new owner now, so check it again. If it was released only
+		 * after ->netlink_bind() returned, the owner that was bound is
+		 * gone: no ->netlink_unbind() for it. Otherwise assume that the
+		 * current owner was bound.
+		 */
+		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind &&
+		    gen != tbl->mc_gen[val - 1]) {
+			bool unbind = bound_gen == tbl->mc_gen[val - 1];
+
+			netlink_table_ungrab();
+			if (unbind && nlk->netlink_unbind)
+				nlk->netlink_unbind(sock_net(sk), val);
+			goto retry;
+		}
 		netlink_update_socket_mc(nlk, val,
 					 optname == NETLINK_ADD_MEMBERSHIP);
 		netlink_table_ungrab();
@@ -2031,6 +2089,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 	struct sock *sk;
 	struct netlink_sock *nlk;
 	struct listeners *listeners = NULL;
+	unsigned int *mc_gen = NULL;
 	unsigned int groups;
 
 	BUG_ON(!nl_table);
@@ -2052,7 +2111,8 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 		groups = cfg->groups;
 
 	listeners = kzalloc(sizeof(*listeners) + NLGRPSZ(groups), GFP_KERNEL);
-	if (!listeners)
+	mc_gen = kcalloc(groups, sizeof(*mc_gen), GFP_KERNEL);
+	if (!listeners || !mc_gen)
 		goto out_sock_release;
 
 	sk->sk_data_ready = netlink_data_ready;
@@ -2069,6 +2129,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 	if (!nl_table[unit].registered) {
 		nl_table[unit].groups = groups;
 		rcu_assign_pointer(nl_table[unit].listeners, listeners);
+		nl_table[unit].mc_gen = mc_gen;
 		nl_table[unit].module = module;
 		if (cfg) {
 			nl_table[unit].bind = cfg->bind;
@@ -2079,6 +2140,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 		nl_table[unit].registered = 1;
 	} else {
 		kfree(listeners);
+		kfree(mc_gen);
 		nl_table[unit].registered++;
 	}
 	netlink_table_ungrab();
@@ -2086,6 +2148,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 
 out_sock_release:
 	kfree(listeners);
+	kfree(mc_gen);
 	netlink_kernel_release(sk);
 	return NULL;
 
@@ -2113,6 +2176,17 @@ int __netlink_change_ngroups(struct sock *sk, unsigned int groups)
 	if (groups < 32)
 		groups = 32;
 
+	if (tbl->groups < groups) {
+		unsigned int *mc_gen;
+
+		mc_gen = kcalloc(groups, sizeof(*mc_gen), GFP_ATOMIC);
+		if (!mc_gen)
+			return -ENOMEM;
+		memcpy(mc_gen, tbl->mc_gen, tbl->groups * sizeof(*mc_gen));
+		kfree(tbl->mc_gen);
+		tbl->mc_gen = mc_gen;
+	}
+
 	if (NLGRPSZ(tbl->groups) < NLGRPSZ(groups)) {
 		new = kzalloc(sizeof(*new) + NLGRPSZ(groups), GFP_ATOMIC);
 		if (!new)
@@ -2157,6 +2231,9 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
 	struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
 	struct hlist_node *tmp;
 
+	/* the group can be given to another user, see netlink_setsockopt() */
+	tbl->mc_gen[group - 1]++;
+
 	sk_for_each_bound_safe(sk, tmp, &tbl->mc_list) {
 		/* bitmap predates the group, can't be a member */
 		if (group - 1 >= nlk_sk(sk)->ngroups)
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 778a3809361f..d5e2e404fd11 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -64,6 +64,7 @@ struct netlink_table {
 	struct listeners __rcu	*listeners;
 	unsigned int		flags;
 	unsigned int		groups;
+	unsigned int		*mc_gen;
 	struct mutex		*cb_mutex;
 	struct module		*module;
 	int			(*bind)(struct net *net, int group);
-- 
2.25.1

