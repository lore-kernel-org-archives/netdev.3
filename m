Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C26405F7
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784162643; cv=none; b=UG+HF1ori+CsvaNYgdIIdDUsrQ5rkeepfNmmPaMF7RTFFeibrTNCGjEmj5znPt3wFa75D2h4QtJfLh/SKkXjGXVdyk0+RrOPebO5IkR9aKJaoxLDVb4w4z48FSy8Vit8a0+BUpvj+hhHYrmHGvBI8HPvIrf9f4/4hydOWbZcNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784162643; c=relaxed/simple;
	bh=brLHTe2cJZX9XkyLF/aYl8/54ZJ9DmYkqSeWd6NM5g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkeeQBhY8LHJEJeo84X0jC8rJbMaqMcI12p9zXfOdZSvHjsFohcaUhC7REhTKQXehZSAK/VSqiM2Mwvf3nhZlYPJj+ekJ42h0knOcqij95dV0hMFIcjj3mX24OErMEHm/5AyGGtJhQumhW34R24GOXXyBth190AjJAHVoQl9Fo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDMWsQvj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDMWsQvj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cee9b74ee1so26551635ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784162641; x=1784767441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1o+KziW6b/GVugCs/B2MAgSMCWqeQ8TakkxiOE3NICQ=;
        b=dDMWsQvjVwXce8kGohzHSzQewAopEHHb93ifkFkqSTGBYf08MOUUfQAm2Lmd8PHeWs
         sRe4DgYXMFHu+mmDsoucgpiWeQhOlInleCpZHoZHf/6HcxTSoQotzMGOSyb+24tXhP6/
         Fb9tD9HKm8HyNCjc7LJrkvIlLuXKpVwEPMrGt9MCC62tsWq/48tMmLrAS6MsdWvnyTi6
         2orsKzYiLtihAP8/fA8777nBy8PO+zbeWz9g+bT4NejucKiQOdaSECevADg6qESBYKqj
         uh50yxkleH6M3EqIrPIXrZ0YILWP7tP8eLrQTYm+JDWbVOVpg4QwToWKXVYnO4cMv/8/
         C8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784162641; x=1784767441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1o+KziW6b/GVugCs/B2MAgSMCWqeQ8TakkxiOE3NICQ=;
        b=QGw02MkQmr7D+7ppmjmJW16ohIbe/zCJcDPRv7WcTLAIv0XkaEA8JYDrT82Ju8aORV
         CTojxkxd2aLy81r+TsOrQ1BCcoema81ItPnvhzkNK4xjJ+mhGq/utxsHcneThZumSJ1c
         NDwUzi06++JPePlcg6byHFXBZtbtWHB58lgn2wX/me7veXR0EJtpGunt03YDedAZFn8v
         ACQzM5tSBAQ+Cbb5qm4Dwstr4bmGzqENEdt7R6xqqYcanTSIO2mhkBJQHG3TaosPyc0N
         HP0z/BMO1C7xtufGEXFgTpUdU78sWxThVDTIL31EQqf5dgVm8cTFtUjGzV8X3grsCdfm
         dJ3A==
X-Gm-Message-State: AOJu0YwW7ipFRDJ0t5fNWWgMPNmBOP6bXuISCohGpRxYgjBPwPUswEsz
	4BaL0okbATaq8Bgt+LUgu8DQi/iU1D05rdLEGmBp2ZOm3VPRuRcGK18nbkUpgQ==
X-Gm-Gg: AfdE7ckBIC2ev2qUGl4ZJh/OtvOnPhPG1q5XglLrrTSt4j7lNzmU39b1ssoeWjqQEqO
	TzUH4D6EosbaTpLNe4Lyz5bsFajQeK5uoVXgOjrxBY66qaQ6pZZ3IEOLQ1TlTeDD6mDSyyl/VGA
	39E2d+XwBcRB/BvQzU5BYOKR5oZeY82PNJ3WF10w3vUJksT+qX+aB/yC0kf0RzMn1Qb6IJzfJOL
	7/Tkf+70o3fUUHTu4dj9KghZg8GOwpZtym1pkAmpkkduZejZlNZudThsjqAW/YtHiIyq7f+cPlg
	XlnXba7tSHn8G7ycTbuSGRl/bWMWei1TVs/by9HEQdaJgA75DqQ2fPivCqs+gji1IgkSGdmKtpx
	SJ6OCetnZ0ExNXE4BQvGH0frI/5NQzCri9BlLLshqsgC2hma2Y1x1hO/Q4ALGXO19gf+lkQ8k2V
	qDUjNk/VObf/UKCpv0/AD+BiWtfCKyZdPzNJDJb4lQ5BwSIwRrluLq7emjVSR/+snicdI9Z1qaz
	qFTgp74oQ==
X-Received: by 2002:a05:6a20:6a09:b0:3c1:b9c:4890 with SMTP id adf61e73a8af0-3c36c1957b7mr5208428637.22.1784162641314;
        Wed, 15 Jul 2026 17:44:01 -0700 (PDT)
Received: from l.localdomain ([76.166.220.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm4107620c88.4.2026.07.15.17.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:44:00 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dave Seddon <dave.seddon.ca@gmail.com>
Subject: [PATCH net-next v1 01/11] net: flow_dissector: gate BPF program lookup behind a static key
Date: Wed, 15 Jul 2026 17:43:47 -0700
Message-ID: <20260716004357.3652679-2-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
References: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__skb_flow_dissect() takes rcu_read_lock(), resolves the netns from
skb->dev/skb->sk, and does two dependent rcu_dereference() loads of
the netns-BPF run_array (init_net's first - a shared cacheline - then
the packet netns') on every dissect, even though the overwhelmingly
common case is that no BPF flow dissector program is attached
anywhere on the system.

Add a static key that counts attached flow dissector programs and
skip the whole lookup block when it is zero, exactly as
bpf_sk_lookup_enabled does for the sibling NETNS_BPF_SK_LOOKUP attach
type (also see cgroup_bpf_enabled_key[] for the same pattern per
cgroup-BPF attach type).

The sk_lookup type is link-only, so its inc/dec sit only in
netns_bpf_attach_type_need()/unneed(), which the link attach/release
paths already call. The flow dissector type also supports legacy
BPF_PROG_ATTACH, so additionally inc on a fresh (non-replacement)
prog attach, dec in __netns_bpf_prog_detach(), and dec for a
remaining legacy prog in netns_bpf_pernet_pre_exit() (links are
already handled by the existing per-link unneed loop there). All
these paths run under netns_bpf_mutex.

As with sk_lookup, there is a brief window where a just-attached
program can miss a concurrent dissect (key flips after
rcu_assign_pointer) or a just-detached one can cause a wasted lookup;
both are benign and match the existing semantics of the sibling keys.

DEBUG_NET_WARN_ON_ONCE(!net) moves inside the gated block: it exists
to catch a missing netns for the BPF hook, which is only meaningful
when a program can actually be attached.

With the key disabled this removes the rcu_read_lock/unlock pair, the
netns resolution, and both run_array loads from the per-packet path.

Assisted-by: Claude:claude-fable-5 sparse smatch
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 include/linux/skbuff.h     |   1 +
 kernel/bpf/net_namespace.c |  17 +++++-
 net/core/flow_dissector.c  | 104 +++++++++++++++++++++----------------
 3 files changed, 75 insertions(+), 47 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..6448c59dc807 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1588,6 +1588,7 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
 			     unsigned int key_count);
 
 struct bpf_flow_dissector;
+extern struct static_key_false netns_bpf_flow_dissector_enabled;
 u32 bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 		     __be16 proto, int nhoff, int hlen, unsigned int flags);
 
diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 25f30f9edaef..0d48ea65697e 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -28,6 +28,9 @@ DEFINE_MUTEX(netns_bpf_mutex);
 static void netns_bpf_attach_type_unneed(enum netns_bpf_attach_type type)
 {
 	switch (type) {
+	case NETNS_BPF_FLOW_DISSECTOR:
+		static_branch_dec(&netns_bpf_flow_dissector_enabled);
+		break;
 #ifdef CONFIG_INET
 	case NETNS_BPF_SK_LOOKUP:
 		static_branch_dec(&bpf_sk_lookup_enabled);
@@ -41,6 +44,9 @@ static void netns_bpf_attach_type_unneed(enum netns_bpf_attach_type type)
 static void netns_bpf_attach_type_need(enum netns_bpf_attach_type type)
 {
 	switch (type) {
+	case NETNS_BPF_FLOW_DISSECTOR:
+		static_branch_inc(&netns_bpf_flow_dissector_enabled);
+		break;
 #ifdef CONFIG_INET
 	case NETNS_BPF_SK_LOOKUP:
 		static_branch_inc(&bpf_sk_lookup_enabled);
@@ -352,6 +358,11 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	net->bpf.progs[type] = prog;
 	if (attached)
 		bpf_prog_put(attached);
+	else
+		/* Mark attach point as used on a fresh attach; a
+		 * replacement keeps the existing count.
+		 */
+		netns_bpf_attach_type_need(type);
 
 out_unlock:
 	mutex_unlock(&netns_bpf_mutex);
@@ -373,6 +384,8 @@ static int __netns_bpf_prog_detach(struct net *net,
 	attached = net->bpf.progs[type];
 	if (!attached || attached != old)
 		return -ENOENT;
+	/* Mark attach point as unused */
+	netns_bpf_attach_type_unneed(type);
 	netns_bpf_run_array_detach(net, type);
 	net->bpf.progs[type] = NULL;
 	bpf_prog_put(attached);
@@ -546,8 +559,10 @@ static void __net_exit netns_bpf_pernet_pre_exit(struct net *net)
 			net_link->net = NULL; /* auto-detach link */
 			netns_bpf_attach_type_unneed(type);
 		}
-		if (net->bpf.progs[type])
+		if (net->bpf.progs[type]) {
+			netns_bpf_attach_type_unneed(type);
 			bpf_prog_put(net->bpf.progs[type]);
+		}
 	}
 	mutex_unlock(&netns_bpf_mutex);
 }
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 8aa4f9b4df81..b8c59209b460 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -73,6 +73,14 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
 }
 EXPORT_SYMBOL(skb_flow_dissector_init);
 
+/* Enabled while any netns has a BPF flow dissector program attached;
+ * lets __skb_flow_dissect() skip the program lookup entirely in the
+ * common no-program case. Maintained by the netns-BPF attach/detach
+ * paths in kernel/bpf/net_namespace.c.
+ */
+DEFINE_STATIC_KEY_FALSE(netns_bpf_flow_dissector_enabled);
+EXPORT_SYMBOL(netns_bpf_flow_dissector_enabled);
+
 #ifdef CONFIG_BPF_SYSCALL
 int flow_dissector_bpf_prog_attach_check(struct net *net,
 					 struct bpf_prog *prog)
@@ -1117,59 +1125,63 @@ bool __skb_flow_dissect(const struct net *net,
 					      FLOW_DISSECTOR_KEY_BASIC,
 					      target_container);
 
-	rcu_read_lock();
+	if (static_branch_unlikely(&netns_bpf_flow_dissector_enabled)) {
+		rcu_read_lock();
 
-	if (skb) {
-		if (!net) {
-			if (skb->dev)
-				net = dev_net_rcu(skb->dev);
-			else if (skb->sk)
-				net = sock_net(skb->sk);
+		if (skb) {
+			if (!net) {
+				if (skb->dev)
+					net = dev_net_rcu(skb->dev);
+				else if (skb->sk)
+					net = sock_net(skb->sk);
+			}
 		}
-	}
 
-	DEBUG_NET_WARN_ON_ONCE(!net);
-	if (net) {
-		enum netns_bpf_attach_type type = NETNS_BPF_FLOW_DISSECTOR;
-		struct bpf_prog_array *run_array;
-
-		run_array = rcu_dereference(init_net.bpf.run_array[type]);
-		if (!run_array)
-			run_array = rcu_dereference(net->bpf.run_array[type]);
-
-		if (run_array) {
-			struct bpf_flow_keys flow_keys;
-			struct bpf_flow_dissector ctx = {
-				.flow_keys = &flow_keys,
-				.data = data,
-				.data_end = data + hlen,
-			};
-			__be16 n_proto = proto;
-			struct bpf_prog *prog;
-			u32 result;
-
-			if (skb) {
-				ctx.skb = skb;
-				/* we can't use 'proto' in the skb case
-				 * because it might be set to skb->vlan_proto
-				 * which has been pulled from the data
-				 */
-				n_proto = skb->protocol;
-			}
+		DEBUG_NET_WARN_ON_ONCE(!net);
+		if (net) {
+			enum netns_bpf_attach_type type = NETNS_BPF_FLOW_DISSECTOR;
+			struct bpf_prog_array *run_array;
+
+			run_array = rcu_dereference(init_net.bpf.run_array[type]);
+			if (!run_array)
+				run_array = rcu_dereference(net->bpf.run_array[type]);
+
+			if (run_array) {
+				struct bpf_flow_keys flow_keys;
+				struct bpf_flow_dissector ctx = {
+					.flow_keys = &flow_keys,
+					.data = data,
+					.data_end = data + hlen,
+				};
+				__be16 n_proto = proto;
+				struct bpf_prog *prog;
+				u32 result;
+
+				if (skb) {
+					ctx.skb = skb;
+					/* we can't use 'proto' in the skb case
+					 * because it might be set to
+					 * skb->vlan_proto which has been pulled
+					 * from the data
+					 */
+					n_proto = skb->protocol;
+				}
 
-			prog = READ_ONCE(run_array->items[0].prog);
-			result = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
-						  hlen, flags);
-			if (result != BPF_FLOW_DISSECTOR_CONTINUE) {
-				__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
-							 target_container);
-				rcu_read_unlock();
-				return result == BPF_OK;
+				prog = READ_ONCE(run_array->items[0].prog);
+				result = bpf_flow_dissect(prog, &ctx, n_proto,
+							  nhoff, hlen, flags);
+				if (result != BPF_FLOW_DISSECTOR_CONTINUE) {
+					__skb_flow_bpf_to_target(&flow_keys,
+								 flow_dissector,
+								 target_container);
+					rcu_read_unlock();
+					return result == BPF_OK;
+				}
 			}
 		}
-	}
 
-	rcu_read_unlock();
+		rcu_read_unlock();
+	}
 
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
-- 
2.54.0

