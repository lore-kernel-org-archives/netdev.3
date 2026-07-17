Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F83DDB07
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286100; cv=none; b=Xh+HO42nfqACTHHqwKMQSJfIDY7Sa2CWyFKbrHj4Mx4HZliyZRuEre/h8d69Pnb+9H6DCQb/HC9foUj5TjF5kAEyL5yyZqidCxffuQsCllr9yj4TV+0/WFkOV+PY0RMnPo1aU8rfmCrygV2UFJp2qo8gd7OxRytZM9YJoXoBaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286100; c=relaxed/simple;
	bh=4+AjGXuugyOJ35konCN4xyQETsUoFtYwyOmkK2Z6jRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7Ruwg8SYWsHu0ZRlzKnYV4C0m2zkraF8sKmknMVleI9XOBBVjSDNlBRFDQdo7YsFHs9alzk7661PK8xXoaYxghtU8j2kBrpqVw/Z65xnRsC/cZAWzqSW6QWapT85WBXdNSGe5xHqyRg/k+mZ8D9JDcfVeOURfMes1Gvaxe9SQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=BrNCXABK; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="BrNCXABK"
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 5E11560287;
	Fri, 17 Jul 2026 13:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1784286085;
	bh=pv2Lo/BOU36hyzDLJSH9cPuzZ+Bpqm4dt9ncBkK9NdY=;
	h=From:To:Cc:Subject:Date:From;
	b=BrNCXABKsWaG5b24q5JeQPDEKoObYDNQhD1sWeQVXdDjEBVnjUN2Q+2U2pOTIlgik
	 klBVeHAytb+cFL4fM34SDFkrvz1YxhR5yNCD/0Qtk8+V7UJkNqe6uqua2pob16stgi
	 kIKhCdXQce58STGptSDAPS3VASg8uHBa18X+qJw+WSuSZHDKYiFksRKnthO2qwplP6
	 pq72MwrMFQDU7g8Vl9RPdDiyxTBiJmdh/KiSa//w2MJ+pMSiTotUhItBj9U8K2RN8Y
	 5/Afu9oAI84oUbHYm+0B9ZVC+1tYMlv+6cc8cQXoVeoC47EsDH1jwgKcGGWwECvE6S
	 dy+f2WH8QeT5Q==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: devel@lists.linux-ipsec.org
Cc: netdev@vger.kernel.org,
	tobias@strongswan.org,
	eyal.birger@gmail.com,
	antony@phenome.org,
	steffen.klassert@secunet.com
Subject: [PATCH net-next,v3] xfrm: allow to enable udp encapsulation without userspace socket
Date: Fri, 17 Jul 2026 13:01:17 +0200
Message-ID: <20260717110118.251866-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is currently not possible to enable UDP encapsulation in xfrm without
a userspace process that listens on the specified UDP listener port in
the SA.

People have work around this by creating dummy userspace daemons such as
the one in the smallish perl program (see the script at the bottom of
this link):

http://techblog.newsnow.co.uk/2011/11/simple-udp-esp-encapsulation-nat-t-for.html

This patch adds XFRM_SA_XFLAG_UDP_ENCAP_SOCK to create the UDP socket
from the kernel.

Use a hole in net->xfrm to place the new encap_socket list.

The following example shows how to enable the standalone UDP
encapsulation:

    ip xfrm state add src 192.168.10.10 dst 192.168.10.11 proto esp spi 1 \
            encap espinudp 9999 9999 0.0.0.0 \
            if_id 0x1 reqid 1 replay-window 0 mode tunnel aead 'rfc4106(gcm(aes))' \
            0x1111111111111111111111111111111111111111 96 \
            sel src 10.141.10.0/24 dst 10.141.11.0/24 dir out

and the receiving side uses 'extra-flag udp-encap-sock':

    ip xfrm state add src 192.168.10.11 dst 192.168.10.10 proto esp spi 2 \
            encap espinudp 9999 0 0.0.0.0 extra-flag udp-encap-sock \
            if_id 0x1 reqid 2 replay-window 10 mode tunnel aead 'rfc4106(gcm(aes))' \
            0x2222222222222222222222222222222222222222 96 dir in

This allows for multiple SAs using the same listener udp port.

This is useful for testing scenarios where UDP encapsulation is
required.

Note this patch exports xfrm6_udp_encap_rcv() just like
xfrm4_udp_encap_rcv() otherwise linker complains due to unreachable
symbol.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: - Use x->id.daddr.a{4,6} instead of encap_oa, as suggested by Eyal and Tobias.
    - Fix several SA using same udp encapsulation configuration.

This is a follow up to:
https://lists.linux-ipsec.org/archives/list/devel@lists.linux-ipsec.org/thread/F4IOY2DKFDX3E45UUFQHUZKTHV7AD6G4/

NOTE for netdev maintainers:
Targetting net-next so sashiko kicks in for review, ipsec-devel still has no such service yet.

 include/net/netns/xfrm.h  |   1 +
 include/net/xfrm.h        |  11 ++++
 include/uapi/linux/xfrm.h |   1 +
 net/ipv6/xfrm6_input.c    |   1 +
 net/xfrm/Kconfig          |   2 +
 net/xfrm/xfrm_state.c     |  16 +++++
 net/xfrm/xfrm_user.c      | 122 +++++++++++++++++++++++++++++++++++++-
 7 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index b73983a17e08..5091c07b1e46 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -56,6 +56,7 @@ struct netns_xfrm {
 	unsigned int		policy_count[XFRM_POLICY_MAX * 2];
 	struct work_struct	policy_hash_work;
 	struct xfrm_policy_hthresh policy_hthresh;
+	struct hlist_head	encap_socket;
 	struct list_head	inexact_bins;
 
 
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index a6d69aaa6cd2..99730a2fc8b9 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -25,6 +25,7 @@
 #include <net/ipv6.h>
 #include <net/ip6_fib.h>
 #include <net/flow.h>
+#include <net/udp_tunnel.h>
 #include <net/gro_cells.h>
 
 #include <linux/interrupt.h>
@@ -169,6 +170,13 @@ struct xfrm_dev_offload {
 	u8			flags : 2;
 };
 
+struct xfrm_encap_sock {
+	struct hlist_node	list;
+	struct udp_port_cfg	cfg;
+	struct sock		*sk;
+	refcount_t		refcnt;
+};
+
 struct xfrm_mode {
 	u8 encap;
 	u8 family;
@@ -249,6 +257,7 @@ struct xfrm_state {
 
 	/* Data for encapsulator */
 	struct xfrm_encap_tmpl	*encap;
+	struct xfrm_encap_sock	*encap_sock;
 
 	/* NAT keepalive */
 	u32			nat_keepalive_interval; /* seconds */
@@ -2343,6 +2352,8 @@ static inline bool xfrm6_local_dontfrag(const struct sock *sk)
 }
 #endif
 
+int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
+
 #if (IS_BUILTIN(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
     (IS_MODULE(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
 
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 051f8066efd1..28aa5c8ca317 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -413,6 +413,7 @@ struct xfrm_usersa_info {
 
 #define XFRM_SA_XFLAG_DONT_ENCAP_DSCP	1
 #define XFRM_SA_XFLAG_OSEQ_MAY_WRAP	2
+#define XFRM_SA_XFLAG_UDP_ENCAP_SOCK	4
 
 struct xfrm_usersa_id {
 	xfrm_address_t			daddr;
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 89d0443b5307..2e3f7b9e5a4f 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -173,6 +173,7 @@ int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 
 	return ret;
 }
+EXPORT_SYMBOL(xfrm6_udp_encap_rcv);
 
 struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 					struct sk_buff *skb)
diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index 4a62817a88f8..fe42cfca9423 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -7,6 +7,7 @@ config XFRM
 	depends on INET
 	select GRO_CELLS
 	select SKB_EXTENSIONS
+	select NET_UDP_TUNNEL
 
 config XFRM_OFFLOAD
 	bool
@@ -23,6 +24,7 @@ if INET
 config XFRM_USER
 	tristate "Transformation user configuration interface"
 	select XFRM_ALGO
+	select NET_UDP_TUNNEL
 	help
 	  Support for Transformation(XFRM) user configuration interface
 	  like IPsec used by native Linux tools.
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 36a4f6793ede..c849e7ac750a 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <net/udp_tunnel.h>
 
 #include <crypto/aead.h>
 
@@ -586,6 +587,16 @@ static const struct xfrm_mode_cbs *xfrm_get_mode_cbs(u8 mode)
 	return cbs;
 }
 
+static bool xfrm_socket_put(struct xfrm_encap_sock *encap_sock)
+{
+	if (refcount_dec_and_test(&encap_sock->refcnt)) {
+		udp_tunnel_sock_release(encap_sock->sk);
+		return true;
+	}
+
+	return false;
+}
+
 void xfrm_state_free(struct xfrm_state *x)
 {
 	kmem_cache_free(xfrm_state_cache, x);
@@ -597,6 +608,10 @@ static void xfrm_state_gc_destroy(struct xfrm_state *x)
 {
 	if (x->mode_cbs && x->mode_cbs->destroy_state)
 		x->mode_cbs->destroy_state(x);
+
+	if (x->encap_sock && xfrm_socket_put(x->encap_sock))
+		kfree(x->encap_sock);
+
 	hrtimer_cancel(&x->mtimer);
 	timer_delete_sync(&x->rtimer);
 	kfree_sensitive(x->aead);
@@ -3332,6 +3347,7 @@ int __net_init xfrm_state_init(struct net *net)
 					      SLAB_HWCACHE_ALIGN | SLAB_PANIC);
 
 	INIT_LIST_HEAD(&net->xfrm.state_all);
+	INIT_HLIST_HEAD(&net->xfrm.encap_socket);
 
 	sz = sizeof(struct hlist_head) * 8;
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d6db63304ba6..bc88581e51e8 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -29,6 +29,7 @@
 #include <net/xfrm.h>
 #include <net/netlink.h>
 #include <net/ah.h>
+#include <net/udp_tunnel.h>
 #include <linux/uaccess.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <linux/in6.h>
@@ -484,6 +485,17 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			goto out;
 	}
 
+	if (attrs[XFRMA_SA_EXTRA_FLAGS]) {
+		u32 xflags = nla_get_u32(attrs[XFRMA_SA_EXTRA_FLAGS]);
+
+		if (xflags & XFRM_SA_XFLAG_UDP_ENCAP_SOCK &&
+		    (!sa_dir || sa_dir == XFRM_SA_DIR_OUT)) {
+			NL_SET_ERR_MSG(extack, "Flag UDP_ENCAP_SOCK can only be set on input SA");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
 	if (sa_dir == XFRM_SA_DIR_OUT) {
 		if (p->flags & XFRM_STATE_DECAP_DSCP) {
 			NL_SET_ERR_MSG(extack, "Flag DECAP_DSCP should not be set for output SA");
@@ -556,7 +568,6 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 				err = -EINVAL;
 				goto out;
 			}
-
 		}
 
 		if (attrs[XFRMA_IPTFS_DONT_FRAG]) {
@@ -932,9 +943,17 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 			goto error;
 	}
 
-	if (attrs[XFRMA_SA_EXTRA_FLAGS])
+	if (attrs[XFRMA_SA_EXTRA_FLAGS]) {
 		x->props.extra_flags = nla_get_u32(attrs[XFRMA_SA_EXTRA_FLAGS]);
 
+		if (x->props.extra_flags & XFRM_SA_XFLAG_UDP_ENCAP_SOCK &&
+		    x->encap && x->encap->encap_type != UDP_ENCAP_ESPINUDP) {
+			NL_SET_ERR_MSG(extack, "XFRM_SA_XFLAG_UDP_ENCAP_SOCK can only be set on UDP_ENCAP_ESPINUDP type");
+			err = -EOPNOTSUPP;
+			goto error;
+		}
+	}
+
 	if ((err = attach_aead(x, attrs[XFRMA_ALG_AEAD], extack)))
 		goto error;
 	if ((err = attach_auth_trunc(&x->aalg, &x->props.aalgo,
@@ -1036,6 +1055,97 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	return NULL;
 }
 
+static struct xfrm_encap_sock *
+xfrm_socket_find_get(struct net *net, const struct udp_port_cfg *udp_conf)
+{
+	struct xfrm_encap_sock *listener;
+
+	hlist_for_each_entry(listener, &net->xfrm.encap_socket, list) {
+		if (!memcmp(&listener->cfg, udp_conf, sizeof(*udp_conf))) {
+			refcount_inc(&listener->refcnt);
+			return listener;
+		}
+	}
+
+	return NULL;
+}
+
+static int xfrm_socket_encap_create(struct net *net, struct xfrm_state *x,
+				    struct udp_port_cfg *udp_conf,
+				    struct udp_tunnel_sock_cfg *tuncfg)
+{
+	struct xfrm_encap_sock *listener;
+	struct socket *sock;
+	int err;
+
+	listener = kzalloc_obj(*listener);
+	if (!listener)
+		return -ENOMEM;
+
+	err = udp_sock_create(net, udp_conf, &sock);
+	if (err) {
+		kfree(listener);
+		return err;
+	}
+	setup_udp_tunnel_sock(net, sock->sk, tuncfg);
+
+	listener->sk = sock->sk;
+	listener->cfg = *udp_conf;
+	refcount_set(&listener->refcnt, 1);
+	hlist_add_head(&listener->list, &net->xfrm.encap_socket);
+
+	x->encap_sock = listener;
+
+	return 0;
+}
+
+static int xfrm_socket_setup(struct net *net, struct xfrm_state *x,
+			     struct netlink_ext_ack *extack)
+{
+	struct udp_tunnel_sock_cfg tuncfg = {};
+	struct xfrm_encap_sock *listener;
+	struct udp_port_cfg udp_conf;
+	int err;
+
+	if (!x->encap)
+		return -EOPNOTSUPP;
+
+	memset(&udp_conf, 0, sizeof(udp_conf));
+	udp_conf.family = x->props.family;
+
+	switch (x->props.family) {
+	case AF_INET:
+		udp_conf.local_ip.s_addr = x->id.daddr.a4;
+		tuncfg.encap_rcv = xfrm4_udp_encap_rcv;
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		udp_conf.local_ip6 = x->id.daddr.in6;
+		tuncfg.encap_rcv = xfrm6_udp_encap_rcv;
+		break;
+#endif
+	default:
+		return -EOPNOTSUPP;
+	}
+	udp_conf.local_udp_port = x->encap->encap_sport;
+
+	listener = xfrm_socket_find_get(net, &udp_conf);
+	if (listener) {
+		x->encap_sock = listener;
+		return 0;
+	}
+
+	tuncfg.encap_type = UDP_ENCAP_ESPINUDP;
+
+	err = xfrm_socket_encap_create(net, x, &udp_conf, &tuncfg);
+	if (err < 0) {
+		NL_SET_ERR_MSG(extack, "Cannot initialize kernel UDP socket");
+		return err;
+	}
+
+	return 0;
+}
+
 static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 		       struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
@@ -1053,6 +1163,14 @@ static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!x)
 		return err;
 
+	if (x->props.extra_flags & XFRM_SA_XFLAG_UDP_ENCAP_SOCK) {
+		err = xfrm_socket_setup(net, x, extack);
+		if (err < 0) {
+			x->km.state = XFRM_STATE_DEAD;
+			goto out;
+		}
+	}
+
 	xfrm_state_hold(x);
 	if (nlh->nlmsg_type == XFRM_MSG_NEWSA)
 		err = xfrm_state_add(x);
-- 
2.47.3

