Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794153228;
	b=R5CCfeYKY4gEQKQUuIygNswSn+NiSjqfGP+bUvWUWd4F6OKwrgxcdew3Kh4Xnrp52zIL
	 uR/Zo3LpUvLOy7gZ3qz8TJFtTl33Z+WIe/w82dqRV2hW0LXplsmhsLNaVIcOqvvkraNK7
	 kA0SNTthoW7cWm7A5po8uS6X4sf455BAiyTSrlX5Ba64hxNjWI/iUuET1AfCg2gK0EbkV
	 oSz4//1SW/y2Tw5uHlx04LeMe3CJvvYYzTih0m12ZzPR7TwzFaJA+ZCJyFjucgVFT6+ai
	 fOwuULrYRdcEfhoFX72z5mvLaCctCG7xyoC3C1/tiWrWhJFFPKLrfMgFgGorc9FwqQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=puOmjAIPgIiLDy8Ot4FwAIFzyOF16FeUvkFVhIy11VA=;
	b=4K0lG8RxwRO7AXSNLQvPHES47Q/QhLzw7wZndBxgg+dYBzqmA7cHMqpn3ndUlH884AzX
	 F5+5ucl2kZNEy5vn03n9W5LrCxMFWuIwXWbvVpFhg/ykzQm+I0Yzeevoj/olivSUVVpkY
	 i8aPpBcJSGinxkhj6m4tv+NO13Wizltc96VwYb+Xd/copxHqBVRUOHS5jNiWPEXluysdy
	 FqOgHFUFnGdxPviWO3cnaMaBk5NVmUWjd5H2liBxZaRJGbVlp23NHfQeVFVKuEy04uZGD
	 c/Xv4RGbOVCtKA9AXxnp2Z8c1aKL6Us8yI/CL3DMcu2mYGVxnCELe8IIjrvz67ac/nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=KldcsY9J;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07EC606A335
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 15:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A07EC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=KldcsY9J
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40e30c26a4so28655966b.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 07:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794153226; x=1794758026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=puOmjAIPgIiLDy8Ot4FwAIFzyOF16FeUvkFVhIy11VA=;
        b=KldcsY9JCTa53ZzU2ITzlhQsCrnj5tgdPOpwq3gpDRDVFEdqVNQhfbyGQGjPRUTxCg
         6gG9ntBQX7lf2hL2U8B/IlDH9Np8ESbkN2lpJ9Nnle9iGZPBUQV5hRbcMlNkls8zBWvq
         0s6omZYj9GCtcRlr80rvAy3GDOKR2Zm66Lc1rKmGIPLGBSW2jUaGydPK4ohzb5elMo2O
         PD+UqNekQZBp84XxXFxO/4Z73VjkhlMyH99vdoHdr1A+e4dwTzbKTfrWYUDahj1118MH
         LUKGw7xkWnBl79mjKX0M14UfJCkL6IiwLohKQOW+NWT1TRpdLa/B2B/0zQgB2YS/fQpS
         2lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794153226; x=1794758026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=puOmjAIPgIiLDy8Ot4FwAIFzyOF16FeUvkFVhIy11VA=;
        b=eKHRAIUqzH9fJsuls1Tzt/i9gB5rvUPRyFTih76tMvrU2+AE4Ma93l7G9NlKhKHG2c
         nUEsuM/5mcHHm2pEej29Rox7oPhhAaYoN+5IWqDS4CgoRO+pkgsBeRRo1USFJeMo0y9p
         Btr6yeytsQnfdB9widGLFaspV3CrhOAlzheBcPSojwOZ2WF06bD0/TVwcqWF7rgREa86
         zIkabR16JAwge69CG9lCTnYbQI3x27sQjzKwNPOYJJKoKL9l6XANmyWIHZACIQtEjo/Z
         wAHbTplooptl9E+HUOCrM/9Rtc91/9r+U/r24XSecQkeHPN2LQG4buuouA9ELEGwT8Cl
         sjyQ==
X-Forwarded-Encrypted: i=1; AL+hErHie2/nG64LHSHx0gmaAPlnqS50rtWHLghW+R1Xyem0cqPn0aj7XSZig2nzQxVsJbLj/Zw3qN4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XOesVAD0LX7genyVEFjBXz1BBvzuICBbqU1KXOmSm7TUZPbf1
	MQnAEpOFFErIQdcNk60aUOW9lB8/d3+1wDxCwQf1qimAWlPp1NQI6c5N5i9ML/wPNw==
X-Gm-Gg: AYBFou3bc3wwa1CsC7tkHkC5SIrKfAhK7XcueEqZQu8+g+pLql4DbGfdGyUQ4bRvsB3
	h9pvYBgJcc6BlF5LHykqQZAhUmghRK2pfe+VPPJ+2VdjN+AVh4cHDGNyDSO6gH58GAKaRnEQnn4
	qdgZkUeHOa/Oedc299dmzPeRGMgXK2xjFI4ZrdBhrz2FyowDRouMqbkMPnudjUmph5HRmzEKVGY
	fWk8JSdmEbbfAakIPhloPGfvnY+yGTbuhOvmoq6FK459Nmrf73nyIW6B93CR9gtuXxxtHmVJ/M4
	J8EkhLfoWVrctvWhutF90T6mAuez+MSRn84JNDEWtZAN90taeKWECiEVeM9rfoLU2KhHGkBhr4E
	Xy6eVnKvo5IOzmnP5725w75/AASLXYQtcVIJ5EpqET1Be1dEwtuBi7yfSSiM1FgL0zijftIxruK
	qZb5DiSkqvzoFew6CEhm2jLXSO0RB8H6ZNe6UCdhV3IuUe68TKRV1S0EsN4L9uL1aNsxcNTynSf
	GZXQEs9mVvvC3BD7p8WKSe6egazffmZ2KtD4lGKjKHGbzNEDuxqrj/TyqXYKmgQf/MH3HEdBTu6
	o4YiT5276IKd7FfVXYy/DKkG9LfRQOQbjs4SgsFjwIaX+UoLuHYw3GoSffX3JHl4oBRTel0x4yF
	fycot/lj++XOJ0rLZ3vmyszcta3XOman5czALjUlITU5Dp8g9h6ZyPS0KjwyR5hZprE4kdXLucQ
	KpkZVeTicw+iyamixOBmYSsWIQQrMpWhVRazrK6FdEr7gxkRpcfcvQTB1osrjCGmX9nojIngl3N
	L9ywTLsObLs9kH7YDgACItVxcH3oBzfg7W12cN3BTawr4RWPzir2SZKOk9+xB+OtUnkv9Mwk0m6
	MTs4rnLDIs5IySFatfJ3CyI3m5/kOILRJkOfKx6C
X-Received: by 2002:a17:907:94cc:b0:c48:a838:c17e with SMTP id a640c23a62f3a-c4d5278459amr262933366b.14.1794153225978;
        Sun, 08 Nov 2026 07:53:45 -0800 (PST)
Received: from Desktop (p54aff56f.dip0.t-ipconnect.de. [84.175.245.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d68d52f4bsm71648166b.8.2026.11.08.07.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:53:45 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev
Subject: [PATCH nf-next v9 1/2] netfilter: flowtable: tear down direct xmit flows when the fdb entry moves
Date: Sun,  8 Nov 2026 16:53:43 +0100
Message-ID: <20261108155344.35845-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108155344.35845-1-julius@bairaktaris.de>
References: <20261108155344.35845-1-julius@bairaktaris.de>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

A direct xmit flow that reaches a bridge port keeps sending to that port
when the host moves to another port of the bridge, and packets from the
other side keep the flow from timing out.

The gc now checks the fdb entry next to the dst check, through
nf_br_utils_hook, and tears the flow down when the entry points to
another port. An entry that aged out does not tear it down, because
offloaded packets do not refresh it.

One possibility to address this issue is to subscribe to
SWITCHDEV_FDB_DEL_TO_DEVICE event notifications, however, this requires
iterating over the whole flowtable whenever a fdb entry is removed.

The bridge port is found from out.ifidx through the vlan devices that
the forward path has below the port. The vid is the bridge vlan in the
encap stack, or the pvid of the port for an untagged port of a
vlan_filtering bridge.

Reported-by: Eric Woudstra <ericwouds@gmail.com>
Link: https://lore.kernel.org/netfilter-devel/20250925182623.114045-1-ericwouds@gmail.com/
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[julius@bairaktaris.de: find the bridge port below the vlan devices of the
 path, take the vid from a bridge vlan or the port pvid, keep a flow whose
 entry aged out, check the bridge the flow transmits on, follow struct
 net_bridge_dst, build br_nf_utils.o only with the flowtable]
Link: https://lore.kernel.org/netfilter-devel/20261014210256.1573072-1-pablo@netfilter.org/
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 include/linux/netfilter.h             |  7 +++++
 include/net/netfilter/nf_flow_table.h |  8 ++++-
 net/bridge/Makefile                   |  2 ++
 net/bridge/br.c                       |  2 ++
 net/bridge/br_nf_utils.c              | 38 ++++++++++++++++++++++
 net/bridge/br_private.h               | 13 ++++++++
 net/netfilter/core.c                  |  3 ++
 net/netfilter/nf_flow_table_core.c    | 45 +++++++++++++++++++++++++--
 net/netfilter/nf_flow_table_path.c    | 20 ++++++++++--
 9 files changed, 133 insertions(+), 5 deletions(-)
 create mode 100644 net/bridge/br_nf_utils.c

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index e99afc1414cd3..be85d8f68b452 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -67,6 +67,13 @@ static inline void nf_inet_addr_mask(const union nf_inet_addr *a1,
 #endif
 }
 
+struct nf_br_utils {
+	bool (*fdb_valid_dst)(const struct net_device *dev,
+			      const unsigned char *addr, u16 vid);
+};
+
+extern const struct nf_br_utils __rcu *nf_br_utils_hook;
+
 int netfilter_init(void);
 
 struct sk_buff;
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 5b22d31cb1407..220ece9490e8e 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -153,6 +153,9 @@ struct flow_offload_tuple {
 					xmit_type:3,
 					encap_num:2,
 					needs_gso_segment:1,
+					bridge_path:1,
+					bridge_vlan:1,
+					port_vlans:2,
 					tun_num:2,
 					in_vlan_ingress:2;
 	u16				mtu;
@@ -235,7 +238,10 @@ struct nf_flow_route {
 			u32			hw_ifindex;
 			u8			h_source[ETH_ALEN];
 			u8			h_dest[ETH_ALEN];
-			u8			needs_gso_segment:1;
+			u8			needs_gso_segment:1,
+						bridge_path:1,
+						bridge_vlan:1,
+						port_vlans:2;
 		} out;
 		enum flow_offload_xmit_type	xmit_type;
 	} tuple[FLOW_OFFLOAD_DIR_MAX];
diff --git a/net/bridge/Makefile b/net/bridge/Makefile
index 1203dc19e15c9..fc53c332246de 100644
--- a/net/bridge/Makefile
+++ b/net/bridge/Makefile
@@ -14,6 +14,8 @@ bridge-$(CONFIG_SYSFS) += br_sysfs_if.o br_sysfs_br.o
 
 bridge-$(subst m,y,$(CONFIG_BRIDGE_NETFILTER)) += br_nf_core.o
 
+bridge-$(subst m,y,$(CONFIG_NF_FLOW_TABLE)) += br_nf_utils.o
+
 br_netfilter-y := br_netfilter_hooks.o
 br_netfilter-$(subst m,y,$(CONFIG_IPV6)) += br_netfilter_ipv6.o
 obj-$(CONFIG_BRIDGE_NETFILTER) += br_netfilter.o
diff --git a/net/bridge/br.c b/net/bridge/br.c
index d9a39ff98868d..c0618ef6dac5c 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -458,6 +458,7 @@ static int __init br_init(void)
 		goto err_out6;
 
 	brioctl_set(br_ioctl_stub);
+	br_nf_utils_init();
 
 #if IS_MODULE(CONFIG_BRIDGE_NETFILTER)
 	pr_info("bridge: filtering via arp/ip/ip6tables is no longer available "
@@ -486,6 +487,7 @@ static int __init br_init(void)
 
 static void __exit br_deinit(void)
 {
+	br_nf_utils_fini();
 	stp_proto_unregister(&br_stp_proto);
 	br_netlink_fini();
 	unregister_switchdev_blocking_notifier(&br_switchdev_blocking_notifier);
diff --git a/net/bridge/br_nf_utils.c b/net/bridge/br_nf_utils.c
new file mode 100644
index 0000000000000..300bce6c1b0b8
--- /dev/null
+++ b/net/bridge/br_nf_utils.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/netdevice.h>
+#include <linux/netfilter.h>
+
+#include "br_private.h"
+
+static bool nf_br_fdb_valid_dst(const struct net_device *dev,
+				const unsigned char *addr, u16 vid)
+{
+	const struct net_bridge_fdb_entry *f;
+	const struct net_bridge_port *p;
+
+	p = br_port_get_check_rcu(dev);
+	if (!p)
+		return false;
+
+	if (!vid && br_opt_get(p->br, BROPT_VLAN_ENABLED))
+		vid = br_get_pvid(nbp_vlan_group_rcu(p));
+
+	/* Offloaded packets do not refresh the entry, it can age out. */
+	f = br_fdb_find_rcu(p->br, addr, vid);
+
+	return !f || br_fdb_dst_port(f) == p;
+}
+
+static const struct nf_br_utils nf_br_utils = {
+	.fdb_valid_dst	= nf_br_fdb_valid_dst,
+};
+
+void br_nf_utils_init(void)
+{
+	rcu_assign_pointer(nf_br_utils_hook, &nf_br_utils);
+}
+
+void br_nf_utils_fini(void)
+{
+	RCU_INIT_POINTER(nf_br_utils_hook, NULL);
+}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 014d0b8db8c73..3b68f8d85672b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2165,6 +2165,19 @@ struct nf_br_ops {
 };
 extern const struct nf_br_ops __rcu *nf_br_ops;
 
+#if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
+void br_nf_utils_init(void);
+void br_nf_utils_fini(void);
+#else
+static inline void br_nf_utils_init(void)
+{
+}
+
+static inline void br_nf_utils_fini(void)
+{
+}
+#endif
+
 /* br_netfilter.c */
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 int br_nf_core_init(void);
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 44c856c1e621c..92e9852c80c0c 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -814,6 +814,9 @@ static struct pernet_operations netfilter_net_ops = {
 	.exit = netfilter_net_exit,
 };
 
+const struct nf_br_utils __rcu *nf_br_utils_hook;
+EXPORT_SYMBOL_GPL(nf_br_utils_hook);
+
 int __init netfilter_init(void)
 {
 	int ret;
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 0d72dc8ae47a1..113580adf10d3 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -5,6 +5,7 @@
 #include <linux/netfilter.h>
 #include <linux/rhashtable.h>
 #include <linux/netdevice.h>
+#include <linux/if_vlan.h>
 #include <net/ip.h>
 #include <net/ip6_route.h>
 #include <net/netfilter/nf_tables.h>
@@ -139,6 +140,9 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 		memcpy(flow_tuple->out.h_source, route->tuple[dir].out.h_source,
 		       ETH_ALEN);
 		flow_tuple->out.ifidx = route->tuple[dir].out.ifindex;
+		flow_tuple->bridge_path = route->tuple[dir].out.bridge_path;
+		flow_tuple->bridge_vlan = route->tuple[dir].out.bridge_vlan;
+		flow_tuple->port_vlans = route->tuple[dir].out.port_vlans;
 		break;
 	case FLOW_OFFLOAD_XMIT_XFRM:
 	case FLOW_OFFLOAD_XMIT_NEIGH:
@@ -572,6 +576,43 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 	nf_ct_put(ct);
 }
 
+static bool nf_flow_dst_valid(struct nf_flowtable *flow_table,
+			      struct flow_offload *flow, int dir)
+{
+	struct flow_offload_tuple *other = &flow->tuplehash[!dir].tuple;
+	struct flow_offload_tuple *tuple = &flow->tuplehash[dir].tuple;
+	struct net *net = read_pnet(&flow_table->net);
+	const struct nf_br_utils *br_utils;
+	struct net_device *dev;
+	bool valid = true;
+	u16 vid = 0;
+	int i;
+
+	if (!nf_flow_dst_check(tuple))
+		return false;
+
+	if (!tuple->bridge_path)
+		return true;
+
+	rcu_read_lock();
+	br_utils = rcu_dereference(nf_br_utils_hook);
+	if (!br_utils)
+		goto out;
+
+	dev = dev_get_by_index_rcu(net, tuple->out.ifidx);
+	for (i = 0; dev && i < tuple->port_vlans; i++)
+		dev = __vlan_find_dev_deep_rcu(dev, other->encap[i].proto,
+					       other->encap[i].id);
+	if (tuple->bridge_vlan)
+		vid = other->encap[i].id;
+
+	valid = dev && br_utils->fdb_valid_dst(dev, tuple->out.h_dest, vid);
+out:
+	rcu_read_unlock();
+
+	return valid;
+}
+
 static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 				    struct flow_offload *flow, void *data)
 {
@@ -584,8 +625,8 @@ static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 
 	if (nf_flow_has_expired(flow) ||
 	    nf_ct_is_dying(flow->ct) ||
-	    !nf_flow_dst_check(&flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple) ||
-	    !nf_flow_dst_check(&flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple) ||
+	    !nf_flow_dst_valid(flow_table, flow, FLOW_OFFLOAD_DIR_ORIGINAL) ||
+	    !nf_flow_dst_valid(flow_table, flow, FLOW_OFFLOAD_DIR_REPLY) ||
 	    nf_flow_custom_gc(flow_table, flow)) {
 		flow_offload_teardown(flow);
 		teardown = true;
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 841f099434d98..cd3098c1d0de6 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -95,7 +95,10 @@ struct nft_forward_info {
 	u8 ingress_vlans;
 	u8 h_source[ETH_ALEN];
 	u8 h_dest[ETH_ALEN];
-	bool needs_gso_segment;
+	u8 needs_gso_segment:1,
+	   bridge_path:1,
+	   bridge_vlan:1,
+	   port_vlans:2;
 	enum flow_offload_xmit_type xmit_type;
 };
 
@@ -107,7 +110,7 @@ static int nft_dev_path_info(struct net_device_path_stack *stack,
 			     unsigned char *ha, struct nft_flowtable *ft)
 {
 	const struct net_device_path *path;
-	int i;
+	int i, n;
 
 	memcpy(info->h_dest, ha, ETH_ALEN);
 
@@ -149,6 +152,8 @@ static int nft_dev_path_info(struct net_device_path_stack *stack,
 				info->encap[info->num_encaps].proto =
 					path->encap.proto;
 				info->num_encaps++;
+				if (info->bridge_path)
+					info->port_vlans++;
 			}
 			if (path->type == DEV_PATH_PPPOE) {
 				memcpy(info->h_dest, path->encap.h_dest, ETH_ALEN);
@@ -184,6 +189,14 @@ static int nft_dev_path_info(struct net_device_path_stack *stack,
 			case DEV_PATH_BR_VLAN_KEEP:
 				break;
 			}
+			info->bridge_path = 1;
+			info->port_vlans = 0;
+			n = info->num_encaps;
+			info->bridge_vlan = path->bridge.vlan_id && n &&
+					    info->encap[n - 1].id ==
+					    path->bridge.vlan_id &&
+					    info->encap[n - 1].proto ==
+					    path->bridge.vlan_proto;
 			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
 		default:
@@ -262,6 +275,9 @@ static int nft_dev_forward_path(const struct nft_pktinfo *pkt,
 	if (info.xmit_type == FLOW_OFFLOAD_XMIT_DIRECT) {
 		memcpy(route->tuple[dir].out.h_source, info.h_source, ETH_ALEN);
 		memcpy(route->tuple[dir].out.h_dest, info.h_dest, ETH_ALEN);
+		route->tuple[dir].out.bridge_path = info.bridge_path;
+		route->tuple[dir].out.bridge_vlan = info.bridge_vlan;
+		route->tuple[dir].out.port_vlans = info.port_vlans;
 		route->tuple[dir].xmit_type = info.xmit_type;
 	}
 	route->tuple[dir].out.needs_gso_segment = info.needs_gso_segment;
-- 
2.53.0

