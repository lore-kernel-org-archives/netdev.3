Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784106;
	b=iZiy1XXom3FnwyX2Y0tmMUTJrL6AexaYrG4jw0KiKwOs3AS8TsEXXe08/wZZ2GajiNHa
	 3846tFtA63YSpJ7WgztOuFUKhfyVgb6HjMteEILN2pBMU/ftAos0UsFRzcg05uXQpXq5A
	 lFKq0tQaAcEyoPqtHZfXJ91xEMY+WK3IvOqiK+bKCsFYNPiJY7a/H0YByTYUmYr6B4TOn
	 xINoq+cc9NfTZHTTGTCcjyOGHq4XQtyzC21wLTnp7HgOAB3uMExciDgz2SSFE5mdJ+wkf
	 JHxAQ4UKVTLoKOBt/1oq06mXrhJFcbSO1CbZ0hjf1fEMJqrK0lNvimwdQqczEQIoOlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FUTrBVeEBeSqgAwOYecgCuWeUkNamd5uPVfxib86X5w=;
	b=FTPUJNiWkg94+YpjC4EMS4nqouvYtiLldJF6TirgklWBdHtf9nOFKZ4iGj3Co9S3q8rk
	 jxhEP/cZ6kFiSL7MYXHsM7tb0ZrTPbRKkJlZsHZe8UIrW9Zz5QNi3hROidOE44bZzgwfs
	 4EF9o4EqnPjWUYnD5ZHijO5G/bGI19xB4oV6TCZ2DJlb+0SojaIMC5E24Di0JgPg3HwZC
	 X1e4iMGhJIEvE4R38SbZ1bFALTiKauZhaclxuIyOmqk03nGOH88v5mMo47aFgZUovNTfS
	 AWuYz2vRhkFOuRO9VrQ5HLFn90noOrBrD9fEaPsL+WlC/Cv0aP0znbspCitqEypER+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5GxxxL6;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F103606D80B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F103606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5GxxxL6
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-19305bcb72cso400218c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793784105; x=1794388905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUTrBVeEBeSqgAwOYecgCuWeUkNamd5uPVfxib86X5w=;
        b=Y5GxxxL694GA0u65M5HeSizsw0G1/A0HtGyGQ0/QMpvPCahYGASJFuF8dQL5b11Cba
         PmSm04Gqi0KwImonMu6A93wmVeQf4kzfl/ZkqtASFbG4nRzS0azBnT3024OMPgYL5nAK
         //kRfoX4/mKPFVhBMXg1S/8qOYdoDirsVQ5SSQPoLfs4MRAh43FuGOEkaLgtfbH+YSYc
         KcpSaYxVffHaQrmbbuqHI/k4cMzEKpDbQU5qJoglSap/qrEOH8tfYLweet5GcXqonTwh
         X2TAdNgSIydKkZO+Ih1m+NezHG7ShmqePw/GAKqMzKC0FO0SVlrC6t/PktqfrPjd6nLA
         VLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793784105; x=1794388905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FUTrBVeEBeSqgAwOYecgCuWeUkNamd5uPVfxib86X5w=;
        b=yFHM/G06bwc3wDX1FU4swGmo8luMM2fA14KGHogB0jyaZaYuDnovkNdjbVAMA2LiZj
         bLpLSUbwEGDeQenWASFrHaY7fXGvAJ1fT2zSCMh3Ykx7UZHHxf448cRqBeJ4crdRbuqd
         qIDBx2dZc2FVQZCUsXIMrmZWMVbB41pakcnEV1EMpVOkT4A7zOTBjEZK+ieXj/J34Ecr
         HpVi8otCBbnekpuJ47jmhpZyrD5IGWknIkjd5wBH4nYdW19OcDPvrkiSErm/tBOfOfSt
         CnwgAA4FVNv7vBNHBlw5p033UrYS52p1VBQ75JKwE89vq/26lDwK0BtvCB16elMUC9sL
         lQwA==
X-Gm-Message-State: APuU4Z8eid3+CN4IOlpRGbi3Rw5rAJGCLpz8cqVzrYPINOn/s2+SWEit
	wezkqM2e/Y4tgOX28/L7IM6ZjzBrYvABZa04GBuZfci5XPheDmaTov7Fm4ltFw==
X-Gm-Gg: AYBFou1I8PpxWvEnnJyHH+gg0gfJ7mt2Wi0CbiYvKJbWGXKp5Q0bSQtUGcwuiUQt2UM
	1SmvaKku4Xp6/8JXJ3w9kqZYuHjDSwxqbvF4YMIR+zBq4wY3sCwoXi08CMEh9lYm8BE3NmfnjGc
	P80mw6LUUnRyOTnuq6ppeRN51G+NzqJoou7v3wQzMBs9kFxgV5xCFanK1pfim5tRllir4Q9qU3q
	rhqIRg8Giy13sTwDmGUHycxw16ds+mFcY/Nm1Sc53s8G0bGxDo9DzGDheqGwS0fuHWNcyXIZ2gQ
	eGaVypgKmNtv6OlRF8OmZlj26Ch1i3qTJelVGUoa8ooPssnQ0PqVYQ+EaS94DBUMP1rJ3VN16Me
	7u3Mnog9tKmL6Az5xgFzwZK9oOdf3G8w2z9NQ0z7XCcSI36Vxm//LK1qBRa6ONfD6oOR/Sn2Ssn
	2JbARURQEmycB5nf+gSeiXobmPDDFMS74fPsKA3yd2kcInHs+t2mfldUFTc5YD2cWiNCWxbI8vi
	j6qXJS+1Dk11ZQjF0pK0khgTjwt/QMJK1mmMfHGP3o6RB0LQdz/S5E4PE22DYQaRxDah92giUif
	Jdeo1AVhii2F4WaJ/+6mIgyFjXQ1MXXvW7IDmVykU6Kh7fBoORANeQP5zAbHimW3HGmk1NUsBTo
	sI+Ao07v2QaqPX7kj7Wd8S4gDscRf2aa1d19h8urA5KrJIrqkUPxHh0LlXEwFtW4DgHwSvyDsqA
	==
X-Received: by 2002:a05:7022:ea46:20b0:1a9:e382:cedc with SMTP id a92af1059eb24-1ac5d8894f8mr25984685c88.46.1793784104893;
        Wed, 04 Nov 2026 01:21:44 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b87c4asm6058628c88.3.2026.11.04.01.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:21:44 -0800 (PST)
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
Subject: [PATCH net v5 2/2] netlink: Check a group again if it was released while joining it
Date: Wed,  4 Nov 2026 09:21:25 +0000
Message-Id: <20261104092125.211537-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104092125.211537-1-anilkaushikwireless@gmail.com>
References: <20261104092125.211537-1-anilkaushikwireless@gmail.com>
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

The counts are gone once the last kernel socket of the table is released.
A socket can still be joining then: connector releases its kernel socket
if its init fails, and try_module_get() works during init. Return -ENOENT
in that case, after ->netlink_unbind() if ->netlink_bind() already ran:
the socket is not a member, so nothing else would undo it.

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

With a test module that releases its kernel socket while a socket joins,
and the msleep() after the first or the second read:

Without the check on the counts:
  setsockopt(): NULL pointer dereference in netlink_setsockopt()

With it:
  setsockopt() and bind(): -ENOENT, one unbind for the one bind

genl_bind() was added, with its first capability check, in the commit
in the Fixes tag.

Link: https://lore.kernel.org/netdev/179340003139.3131.11274717768928642724@kernel.org/
Fixes: 4d54cc32112d ("mptcp: avoid lock_fast usage in accept path")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 net/netlink/af_netlink.c | 110 ++++++++++++++++++++++++++++++++++++++-
 net/netlink/af_netlink.h |   1 +
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 94c1390e8dc5..6f47a797df1b 100644
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
@@ -1023,9 +1028,18 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
 			return -EINVAL;
 	}
 
+retry:
 	if (nlk->netlink_bind && groups) {
 		int group;
 
+		netlink_lock_table();
+		if (!tbl->mc_gen) {
+			netlink_unlock_table();
+			return -ENOENT;
+		}
+		memcpy(gen, tbl->mc_gen, sizeof(gen));
+		netlink_unlock_table();
+
 		/* nl_groups is a u32, so cap the maximum groups we can bind */
 		for (group = 0; group < BITS_PER_TYPE(u32); group++) {
 			if (!test_bit(group, &groups))
@@ -1042,6 +1056,15 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
 			netlink_undo_bind(group, groups, sk);
 			return err;
 		}
+
+		netlink_lock_table();
+		if (!tbl->mc_gen) {
+			netlink_unlock_table();
+			netlink_undo_bind(BITS_PER_TYPE(u32), groups, sk);
+			return -ENOENT;
+		}
+		memcpy(bound_gen, tbl->mc_gen, sizeof(bound_gen));
+		netlink_unlock_table();
 	}
 
 	/* No need for barriers here as we return to user-space without
@@ -1063,6 +1086,31 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
 	netlink_unlock_table();
 
 	netlink_table_grab();
+	if (nlk->netlink_bind && groups) {
+		unsigned long gone = 0;
+		bool released = false;
+		int group;
+
+		if (!tbl->mc_gen) {
+			netlink_table_ungrab();
+			netlink_undo_bind(BITS_PER_TYPE(u32), groups, sk);
+			return -ENOENT;
+		}
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
@@ -1692,6 +1740,8 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		break;
 	case NETLINK_ADD_MEMBERSHIP:
 	case NETLINK_DROP_MEMBERSHIP: {
+		struct netlink_table *tbl = &nl_table[sk->sk_protocol];
+		unsigned int gen = 0, bound_gen = 0;
 		int err;
 
 		if (!netlink_allowed(sock, NL_CFG_F_NONROOT_RECV))
@@ -1701,12 +1751,51 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 			return err;
 		if (!val || val - 1 >= nlk->ngroups)
 			return -EINVAL;
+retry:
 		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
+			netlink_lock_table();
+			if (!tbl->mc_gen) {
+				netlink_unlock_table();
+				return -ENOENT;
+			}
+			gen = tbl->mc_gen[val - 1];
+			netlink_unlock_table();
 			err = nlk->netlink_bind(sock_net(sk), val);
 			if (err)
 				return err;
+			netlink_lock_table();
+			if (!tbl->mc_gen) {
+				netlink_unlock_table();
+				if (nlk->netlink_unbind)
+					nlk->netlink_unbind(sock_net(sk), val);
+				return -ENOENT;
+			}
+			bound_gen = tbl->mc_gen[val - 1];
+			netlink_unlock_table();
 		}
 		netlink_table_grab();
+		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind &&
+		    !tbl->mc_gen) {
+			netlink_table_ungrab();
+			if (nlk->netlink_unbind)
+				nlk->netlink_unbind(sock_net(sk), val);
+			return -ENOENT;
+		}
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
@@ -2037,6 +2126,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 	struct sock *sk;
 	struct netlink_sock *nlk;
 	struct listeners *listeners = NULL;
+	unsigned int *mc_gen = NULL;
 	unsigned int groups;
 
 	BUG_ON(!nl_table);
@@ -2058,7 +2148,8 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 		groups = cfg->groups;
 
 	listeners = kzalloc(sizeof(*listeners) + NLGRPSZ(groups), GFP_KERNEL);
-	if (!listeners)
+	mc_gen = kcalloc(groups, sizeof(*mc_gen), GFP_KERNEL);
+	if (!listeners || !mc_gen)
 		goto out_sock_release;
 
 	sk->sk_data_ready = netlink_data_ready;
@@ -2075,6 +2166,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 	if (!nl_table[unit].registered) {
 		nl_table[unit].groups = groups;
 		rcu_assign_pointer(nl_table[unit].listeners, listeners);
+		nl_table[unit].mc_gen = mc_gen;
 		nl_table[unit].module = module;
 		if (cfg) {
 			nl_table[unit].bind = cfg->bind;
@@ -2085,6 +2177,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 		nl_table[unit].registered = 1;
 	} else {
 		kfree(listeners);
+		kfree(mc_gen);
 		nl_table[unit].registered++;
 	}
 	netlink_table_ungrab();
@@ -2092,6 +2185,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 
 out_sock_release:
 	kfree(listeners);
+	kfree(mc_gen);
 	netlink_kernel_release(sk);
 	return NULL;
 
@@ -2119,6 +2213,17 @@ int __netlink_change_ngroups(struct sock *sk, unsigned int groups)
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
@@ -2163,6 +2268,9 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
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

