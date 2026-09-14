Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C163B0581
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427141; cv=none; b=BLB7/drNGTwWnWS+NC4Q0DjCfg5Y9ds0stxLfn4bGwrkByOOuPVLKgK9y8qEI8tKyLb6v8Bny0HuBZwRUcIj+YaSJgNPbwYofGrHMsDr9iD9+v0T2e2vsafkzEyS/+oeE2HeAZlbDtwDNIuGJAB9pbH+vFp+bBpFQH2lHECsodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427141; c=relaxed/simple;
	bh=+qmG3mGlxqWYVyhGmCN7gAEFYnkoPN8tEwEA0TlNCrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKnzF2czusBOUqdjUnMlHEuyvotbxRpjOvNTHmuH8rfapcZAQfvenr0YSXInhY16yPMDlyFbbayvx0SeVqIu1UrGLLbo2ydE6KjQGOdu7NeqckTxEb4x23L9CB7oOJIxmfk9meVTPiOD2iSQJF6nDWUh48XDHCy//xEVPL2qmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=iBUJufAI; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="iBUJufAI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cNEe2d7i+ihUe/Z3H/e8L9mvX/sHQ/eSktdBoR+Rf0w=; t=1789427138; x=1790291138; 
	b=iBUJufAI6U/FxwWdcnA0cNEeuG8mH02Gn5koAQKyIxML5cx9xckBE6jBJNS9eJz2GIXwN2Xzd53
	+uGDHR8jEm1AOJm93/5PNP8/TYAQ8dlAIJT+2CfZBVO2xsk6j6tXt5TWegnUslbgfRUiA+0fLyIRM
	to8y6ArKzE1ZueU24Cm12Jc0DNQrF4LvdhkFqhVUJJ0OnYWmlPCM7SmdoUXOv3VD41WGvEacikfGU
	CFJx4mn1TxunxA8gKEkZ/9O/mFUgNKY+OkwozhM3X+gydBD0npWMPs1/QlIfyypT9WukX7v6Vq1iL
	yuGGGZjlSS+dtEdI5OaKsbxhpCKM5+xwO1qA==;
Received: from ouster448.stanford.edu ([172.24.72.71]:60752 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1x6Fjy-0007WN-Vz; Mon, 14 Sep 2026 16:05:38 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	skhan@linuxfoundation.org,
	bagasdotme@gmail.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v11 06/15] net: homa: create homa_peer.h and homa_peer.c
Date: Mon, 14 Sep 2026 16:05:06 -0700
Message-ID: <20260914230517.1190-7-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914230517.1190-1-ouster@cs.stanford.edu>
References: <20260914230517.1190-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 718846882798e04200bb22d25938c657

Homa needs to keep a small amount of information for each peer that
it has communicated with, including information about the peer itself
plus routing information to communicate with that peer. These files define
the peer-specific state and provide functions for storing and accessing it.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v20:
* Separate routing information (flows and dst_entry's) from the homa_peer
  struct: there can be multiple routes to a single peer.
* Don't hold locks while transmitting packets.
* When detecting IPv4 vs. IPv6, prefer info in addresses rather than info
  from the socket; this moves Homa closer to allowing dual-stack IPv6
  sockets.
* Use time_before for jiffies comparisons.

Changes for v19:
* Bug fix: don't modify peer->flow in homa_peer_reset_dst unless the
  function succeeds.

Changes for v18:
* Fix 2 synchronization issues related to reclamation
* Simplify reclamation (eliminate gc_stop_count).

Changes for v16:
* Clean up and simplify reference counting mechanism (use refcount_t
  instead of atomic_t, eliminate dead_peers mechanism)
* Fix synchronization bugs in homa_dst_refresh (use RCU properly)
* Remove addr field of struct homa_peer
* Create separate header file for murmurhash hash function

Changes for v11:
* Clean up sparse annotations

Changes for v10:
* Use kzalloc instead of __GFP_ZERO
* Remove log messages after alloc errors
* Fix issues found by sparse, xmastree.py, etc.
* Add missing initialization for peertab->lock

Changes for v9:
* Add support for homa_net objects
* Implement limits on the number of active homa_peer objects. This includes
  adding reference counts in homa_peers and adding code to release peers
  where there are too many.
* Switch to using rhashtable to store homa_peers; the table is shared
  across all network namespaces, though individual peers are namespace-
  specific
* Invoke dst->ops->check in addition to checking the obsolete flag
* Various name improvements
* Remove the homa_peertab_gc_dsts mechanism, which is unnecessary

Changes for v7:
* Remove homa_peertab_get_peers
* Remove "lock_slow" functions, which don't add functionality in this
  patch
* Remove unused fields from homa_peer structs
* Use u64 and __u64 properly
* Add lock annotations
* Refactor homa_peertab_get_peers
* Use __GFP_ZERO in kmalloc calls
---
 net/homa/homa_peer.c | 669 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_peer.h | 457 +++++++++++++++++++++++++++++
 2 files changed, 1126 insertions(+)
 create mode 100644 net/homa/homa_peer.c
 create mode 100644 net/homa/homa_peer.h

diff --git a/net/homa/homa_peer.c b/net/homa/homa_peer.c
new file mode 100644
index 000000000000..e387a399299b
--- /dev/null
+++ b/net/homa/homa_peer.c
@@ -0,0 +1,669 @@
+// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+
+
+/* This file provides functions related to homa_peer, homa_route, and
+ * homa_peertab objects.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+
+#include <linux/xxhash.h>
+
+/* Wrapper to allow xxhash to be used as rhashtable hash function. */
+static u32 xxh32_hash(const void *data, u32 len, u32 seed)
+{
+	return xxh32(data, len, seed);
+}
+
+const struct rhashtable_params peer_ht_params = {
+	.key_len     = sizeof(struct homa_peer_key),
+	.key_offset  = offsetof(struct homa_peer, ht_key),
+	.head_offset = offsetof(struct homa_peer, ht_linkage),
+	.nelem_hint = 10000,
+	.hashfn = xxh32_hash,
+	.obj_cmpfn = homa_peer_compare
+};
+
+const struct rhashtable_params route_ht_params = {
+	.key_len     = sizeof(struct homa_route_key),
+	.key_offset  = offsetof(struct homa_route, key),
+	.head_offset = offsetof(struct homa_route, ht_linkage),
+	.nelem_hint = 10000,
+	.hashfn = xxh32_hash
+};
+
+/**
+ * homa_peer_alloc_peertab() - Allocate and initialize a homa_peertab.
+ *
+ * Return:    A pointer to the new homa_peertab, or ERR_PTR(-errno) if there
+ *            was a problem.
+ */
+struct homa_peertab *homa_peer_alloc_peertab(void)
+{
+	struct homa_peertab *peertab;
+	int err;
+
+	peertab = kzalloc_obj(*peertab, GFP_KERNEL);
+	if (!peertab)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&peertab->lock);
+	err = rhashtable_init(&peertab->peer_ht, &peer_ht_params);
+	if (err)
+		goto error;
+	err = rhashtable_init(&peertab->route_ht, &route_ht_params);
+	if (err) {
+		rhashtable_destroy(&peertab->peer_ht);
+		goto error;
+	}
+	peertab->route_ht_valid = true;
+	rhashtable_walk_enter(&peertab->route_ht, &peertab->route_ht_iter);
+	peertab->gc_threshold = 5000;
+	peertab->net_max = 10000;
+	peertab->idle_secs_min = 10;
+	peertab->idle_secs_max = 120;
+
+	homa_peer_update_sysctl_deps(peertab);
+	return peertab;
+
+error:
+	homa_peer_free_peertab(peertab);
+	return ERR_PTR(err);
+}
+
+/**
+ * homa_peer_free_net() - Garbage collect all of the peer information
+ * associated with a particular network namespace.
+ * @hnet:    Network namespace whose peers should be freed. There must not
+ *           be any active sockets or RPCs for this namespace.
+ */
+void homa_peer_free_net(struct homa_net *hnet)
+{
+	struct homa_peertab *peertab = hnet->homa->peertab;
+	struct rhashtable_iter iter;
+	struct homa_route *route;
+
+	spin_lock_bh(&peertab->lock);
+	rhashtable_walk_enter(&peertab->route_ht, &iter);
+	rhashtable_walk_start(&iter);
+	while (1) {
+		route = rhashtable_walk_next(&iter);
+		if (!route)
+			break;
+		if (IS_ERR(route))
+			continue;
+		if (route->key.hnet != hnet)
+			continue;
+		if (rhashtable_remove_fast(&peertab->route_ht,
+					   &route->ht_linkage,
+					   route_ht_params) == 0) {
+			homa_route_release(route);
+			hnet->num_routes--;
+			peertab->num_routes--;
+		}
+	}
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+	WARN(hnet->num_routes != 0, "%s ended up with hnet->num_routes %d",
+	     __func__, hnet->num_routes);
+	spin_unlock_bh(&peertab->lock);
+}
+
+/**
+ * homa_route_delete_fn() - This function is invoked for each entry in
+ * the route_ht hash table by the rhashtable code when the table is being
+ * deleted. It frees its argument.
+ * @object:     homa_peer to free.
+ * @dummy:      Not used.
+ */
+void homa_route_delete_fn(void *object, void *dummy)
+	__must_hold(((struct homa_route *)object)->key.hnet->homa->peertab->lock)
+{
+	struct homa_route *route = object;
+
+	/* Must unlink from the peer here (peertab is going away so
+	 * it won't be safe to do it later, if the reference count doesn't
+	 * drop to zero here).
+	 */
+	homa_peer_unlink(route);
+	homa_route_release(route);
+}
+
+/**
+ * homa_peer_free_peertab() - Destructor for homa_peertabs.
+ * @peertab:  The table to destroy. Caller must ensure that it will never
+ *            be accessed again.
+ */
+void homa_peer_free_peertab(struct homa_peertab *peertab)
+{
+	if (peertab->route_ht_valid) {
+		rhashtable_walk_exit(&peertab->route_ht_iter);
+		rhashtable_free_and_destroy(&peertab->route_ht,
+					    homa_route_delete_fn,
+					    NULL);
+		rcu_barrier();
+		rhashtable_destroy(&peertab->peer_ht);
+		peertab->route_ht_valid = false;
+	}
+	kfree(peertab);
+}
+
+/**
+ * homa_peer_alloc() - Allocate and initialize a new homa_peer object.
+ * @hsk:        Socket for which the peer will be used.
+ * @addr:       Address of the desired host: IPv4 addresses are represented
+ *              as IPv4-mapped IPv6 addresses.
+ * Return:      The peer associated with @addr, or a negative errno if an
+ *              error occurred. On a successful return the reference count
+ *              will be incremented for the returned peer. Sets hsk->error_msg
+ *              on errors.
+ */
+struct homa_peer *homa_peer_alloc(struct homa_sock *hsk,
+				  const struct in6_addr *addr)
+{
+	struct homa_peer *peer;
+
+	peer = kzalloc_obj(*peer, GFP_ATOMIC);
+	if (!peer) {
+		hsk->error_msg = "couldn't allocate memory for homa_peer";
+		return (struct homa_peer *)ERR_PTR(-ENOMEM);
+	}
+	peer->ht_key.addr = *addr;
+	peer->ht_key.hnet = hsk->hnet;
+	refcount_set(&peer->refs, 1);
+	spin_lock_init(&peer->lock);
+
+	return peer;
+}
+
+/**
+ * homa_peer_free() - Release any resources in a peer and free the homa_peer
+ * struct.
+ * @peer:   Peer to free. The @refs field must be zero (this also implies
+ *          for example, that the peer is not on any lists and
+ *          peer->grantable_rpcs is empty).
+ */
+void homa_peer_free(struct homa_peer *peer)
+{
+	kfree(peer);
+}
+
+/**
+ * homa_peer_get() - Returns the peer associated with a given host; creates
+ * a new homa_peer if one doesn't already exist.
+ * @hsk:        Socket where the peer will be used.
+ * @addr:       Address of the desired host: IPv4 addresses are represented
+ *              as IPv4-mapped IPv6 addresses.
+ *
+ * Return:      The peer associated with @addr, or a negative errno if an
+ *              error occurred. On a successful return the reference count
+ *              will be incremented for the returned peer. The caller must
+ *              eventually call homa_peer_release to release the reference.
+ */
+struct homa_peer *homa_peer_get(struct homa_sock *hsk,
+				const struct in6_addr *addr)
+	__must_hold(hsk->homa->peertab->lock)
+{
+	struct homa_peertab *peertab = hsk->homa->peertab;
+	struct homa_peer_key key;
+	struct homa_peer *peer;
+	int status;
+
+	key.addr = *addr;
+	key.hnet = hsk->hnet;
+
+	/* Fast path: use existing entry if it exists. */
+	peer = rhashtable_lookup(&peertab->peer_ht, &key, peer_ht_params);
+	if (peer) {
+		refcount_inc(&peer->refs);
+		return peer;
+	}
+
+	/* No existing entry, so we have to create a new one. */
+	peer = homa_peer_alloc(hsk, addr);
+	if (IS_ERR(peer))
+		return peer;
+	status = rhashtable_lookup_insert_fast(&peertab->peer_ht,
+					       &peer->ht_linkage,
+					       peer_ht_params);
+	if (status != 0) {
+		pr_err("homa_peer_get received unexpected error return from rhashtable_lookup_insert_fast");
+		hsk->error_msg = "unexpected error return from rhashtable_lookup_insert_fast";
+		homa_peer_free(peer);
+		return ERR_PTR(status);
+	}
+	return peer;
+}
+
+/**
+ * homa_route_alloc() - Allocate and initialize a new homa_route.
+ * object.
+ * @hsk:       Socket for which the homa_route will be used.
+ * @key:       Key that will be used for this entry in peertab->route_ht.
+ *             Contains the destination address and other information needed
+ *             to create a flowi and a dst_entry.
+ * Return:     A new homa_route corresdponding to @hsk and @key, or a
+ *             negative errno if an error occurred. Sets hsk->error_msg on
+ *             errors. On success, all fields have been initialized except
+ *             @peer; the route has not been inserted in route_ht and its
+ *             reference count will be one.
+ */
+struct homa_route *homa_route_alloc(struct homa_sock *hsk,
+				    const struct homa_route_key *key)
+{
+	struct homa_route *route;
+	struct dst_entry *dst;
+	int err;
+
+	route = kzalloc_obj(*route, GFP_ATOMIC);
+	if (!route) {
+		hsk->error_msg = "couldn't allocate memory for homa_route";
+		return ERR_PTR(-ENOMEM);
+	}
+	spin_lock_init(&route->lock);
+	refcount_set(&route->refs, 1);
+	route->access_jiffies = jiffies;
+	route->key = *key;
+
+	/* Find a dst_entry to use for this route. */
+	route->flow.flowi_secid = key->secid;
+	if (ipv6_addr_v4mapped(&route->key.daddr)) {
+		struct rtable *rt;
+
+		flowi4_init_output(&route->flow.u.ip4, key->bound_dev_if,
+				   key->mark, 0, RT_SCOPE_UNIVERSE,
+				   IPPROTO_HOMA, 0,
+				   ipv6_to_ipv4(route->key.daddr),
+				   ipv6_to_ipv4(route->key.saddr), 0, 0,
+				   key->uid);
+		rt = ip_route_output_flow(sock_net(&hsk->sock),
+					  &route->flow.u.ip4, &hsk->sock);
+		if (IS_ERR(rt)) {
+			err = PTR_ERR(rt);
+			goto error;
+		}
+		rcu_assign_pointer(route->dst, &rt->dst);
+	} else {
+		/* This code is derived from code in tcp_v6_connect. */
+		route->flow.u.ip6.flowi6_proto = IPPROTO_HOMA;
+		route->flow.u.ip6.daddr = route->key.daddr;
+		route->flow.u.ip6.saddr = route->key.saddr;
+		route->flow.u.ip6.flowlabel = ip6_make_flowinfo(0, 0);
+		route->flow.u.ip6.flowi6_oif = key->bound_dev_if;
+		route->flow.u.ip6.flowi6_mark = key->mark;
+		route->flow.u.ip6.fl6_dport = 0;
+		route->flow.u.ip6.fl6_sport = 0;
+		route->flow.u.ip6.flowi6_uid = key->uid;
+		dst = ip6_dst_lookup_flow(sock_net(&hsk->sock), &hsk->sock,
+						   &route->flow.u.ip6, NULL);
+		rcu_assign_pointer(route->dst, dst);
+
+		if (IS_ERR(route->dst)) {
+			err = PTR_ERR(route->dst);
+			goto error;
+		}
+		route->dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
+	}
+	return route;
+error:
+	hsk->error_msg = "couldn't find route for peer";
+	kfree(route);
+	return ERR_PTR(err);
+}
+
+/**
+ * homa_route_free() - Release any resources in a homa_route and
+ * free the object's memory. May be invoked either as an RCU callback
+ * or directly (if invoked directly, caller must ensure exclusive
+ * access to the object, e.g. it was never actually published in
+ * route_ht).
+ * @head:     @rcu_head field  in the route to free.
+ */
+void homa_route_free(struct rcu_head *head)
+{
+	struct homa_route *route;
+
+	route = container_of(head, struct homa_route, rcu_head);
+	dst_release(rcu_dereference_protected(route->dst, 1));
+	spin_lock_bh(&route->key.hnet->homa->peertab->lock);
+	homa_peer_unlink(route);
+	spin_unlock_bh(&route->key.hnet->homa->peertab->lock);
+	kfree(route);
+}
+
+/**
+ * homa_route_get() - Returns a homa_route object that can be
+ * used to communicate with a given host over a given socket. Indirectly
+ * provides access to a homa_peer object for @addr.
+ * @hsk:        Socket where the peer will be used.
+ * @addr:       Address of the desired host: IPv4 addresses are represented
+ *              as IPv4-mapped IPv6 addresses.
+ *
+ * Return:      The homa_route associated with @addr, or a negative
+ *              errno if an error occurred. On a successful return the
+ *              reference count will be incremented for the returned object.
+ *              The caller must eventually call homa_peer_route_release to
+ *              release the reference.
+ */
+struct homa_route *homa_route_get(struct homa_sock *hsk,
+				  const struct in6_addr *addr)
+{
+	struct homa_peertab *peertab = hsk->homa->peertab;
+	struct homa_route *route, *other;
+	struct homa_route_key route_key;
+	struct homa_peer *peer;
+
+	/* See if we already have a suitable route cached. */
+	rcu_read_lock();
+	homa_route_key_init(&route_key, hsk, addr);
+	route = rhashtable_lookup(&peertab->route_ht, &route_key,
+				  route_ht_params);
+	if (route && refcount_inc_not_zero(&route->refs)) {
+		route->access_jiffies = jiffies;
+		rcu_read_unlock();
+		return route;
+	}
+
+	/* No existing entry, so we have to create a new one. Switch from
+	 * RCU to real locking for this.
+	 */
+	rcu_read_unlock();
+	route = homa_route_alloc(hsk, &route_key);
+	if (IS_ERR(route))
+		return route;
+
+	spin_lock_bh(&peertab->lock);
+	peer = homa_peer_get(hsk, addr);
+	if (IS_ERR(peer)) {
+		spin_unlock_bh(&peertab->lock);
+		homa_route_free(&route->rcu_head);
+		route = ERR_PTR(PTR_ERR(peer));
+		return route;
+	}
+	route->peer = peer;
+
+	/* Insert the new entry in the flow table. It's possible that
+	 * someone else already created the entry concurrently.
+	 */
+	other = rhashtable_lookup_get_insert_fast(&peertab->route_ht,
+						  &route->ht_linkage,
+						  route_ht_params);
+	if (IS_ERR(other)) {
+		/* Couldn't insert; return the error info. */
+		hsk->error_msg = "rhashtable_lookup_get_insert_key failed in homa_route_get";
+		spin_unlock_bh(&peertab->lock);
+		homa_route_free(&route->rcu_head);
+		route = other;
+	} else if (other) {
+		/* Someone else already created the desired object; use that
+		 * one instead of ours.
+		 */
+		refcount_inc(&other->refs);
+		spin_unlock_bh(&peertab->lock);
+		homa_route_free(&route->rcu_head);
+		route = other;
+		route->access_jiffies = jiffies;
+	} else {
+		/* The new object was inserted in the hash table. */
+		refcount_inc(&route->refs);
+		peertab->num_routes++;
+		route_key.hnet->num_routes++;
+		spin_unlock_bh(&peertab->lock);
+	}
+	return route;
+}
+
+/**
+ * homa_route_validate() - Check to be sure that the information in the
+ * route for an RPC is still valid; if not, try to allocate a new route
+ * for the RPC.
+ * @rpc:    RPC whose routing information should be checked.
+ * Return:  Zero for success, or a negative errno if the route was invalid
+ *          and no new route could be created.
+ */
+int homa_route_validate(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_route *route, *old;
+	struct dst_entry *dst;
+
+	old = rpc->route;
+	rcu_read_lock();
+	dst = rcu_dereference_protected(old->dst, 1);
+	rcu_read_unlock();
+	if (!dst_check(dst, rpc->route->dst_cookie)) {
+		struct homa_peertab *peertab = rpc->hsk->homa->peertab;
+
+		/* Existing route is no longer valid; remove it from
+		 * the hash table and try to create a new one.
+		 */
+		spin_lock_bh(&peertab->lock);
+		if (rhashtable_remove_fast(&peertab->route_ht, &old->ht_linkage,
+					   route_ht_params) == 0) {
+			homa_route_release(old);
+			peertab->num_routes--;
+			old->key.hnet->num_routes--;
+		}
+		spin_unlock_bh(&peertab->lock);
+		route = homa_route_get(rpc->hsk, &rpc->route->peer->addr);
+		if (IS_ERR(route))
+			return PTR_ERR(route);
+		old = xchg(&rpc->route, route);
+		homa_route_release(old);
+	}
+	return 0;
+}
+
+/**
+ * homa_route_gc() - This function is invoked by Homa at regular intervals;
+ * its job is to ensure that the number of routes stays within limits. If
+ * the number grows too large, it selectively deletes routes (and peers)
+ * to get back under the limit.
+ * @peertab:   Structure to garbage-collect.
+ */
+void homa_route_gc(struct homa_peertab *peertab)
+{
+#define EVICT_BATCH_SIZE 5
+	struct homa_route *victims[EVICT_BATCH_SIZE];
+	int num_victims;
+	int i;
+
+	spin_lock_bh(&peertab->lock);
+	if (peertab->num_routes < peertab->gc_threshold)
+		goto done;
+	num_victims = homa_route_pick_victims(peertab, victims,
+					      EVICT_BATCH_SIZE);
+	if (num_victims == 0)
+		goto done;
+
+	for (i = 0; i < num_victims; i++) {
+		struct homa_route *route = victims[i];
+
+		if (rhashtable_remove_fast(&peertab->route_ht,
+					   &route->ht_linkage,
+					   route_ht_params) == 0) {
+			peertab->num_routes--;
+			route->key.hnet->num_routes--;
+			homa_route_release(route);
+		}
+	}
+done:
+	spin_unlock_bh(&peertab->lock);
+}
+
+/**
+ * homa_route_pick_victims() - Select a few routes that can be freed.
+ * @peertab:      Choose routes that are stored here.
+ * @victims:      Return addresses of victims here.
+ * @max_victims:  Limit on how many victims to choose (and size of @victims
+ *                array).
+ * Return:        The number of routes stored in @victims; may be zero.
+ */
+int homa_route_pick_victims(struct homa_peertab *peertab,
+			    struct homa_route *victims[], int max_victims)
+{
+	struct homa_route *route;
+	int num_victims = 0;
+	int to_scan;
+	int i, idle;
+
+	/* Scan 2 routes for every potential victim and keep the "best"
+	 * routes for removal.
+	 */
+	rhashtable_walk_start(&peertab->route_ht_iter);
+	for (to_scan = 2 * max_victims; to_scan > 0; to_scan--) {
+		route = rhashtable_walk_next(&peertab->route_ht_iter);
+		if (!route) {
+			/* Reached the end of the table; restart at
+			 * the beginning.
+			 */
+			rhashtable_walk_stop(&peertab->route_ht_iter);
+			rhashtable_walk_exit(&peertab->route_ht_iter);
+			rhashtable_walk_enter(&peertab->peer_ht,
+					      &peertab->route_ht_iter);
+			rhashtable_walk_start(&peertab->route_ht_iter);
+			route = rhashtable_walk_next(&peertab->route_ht_iter);
+			if (!route)
+				break;
+		}
+		if (IS_ERR(route)) {
+			/* rhashtable decided to restart the search at the
+			 * beginning.
+			 */
+			route = rhashtable_walk_next(&peertab->route_ht_iter);
+			if (!route || IS_ERR(route))
+				break;
+		}
+
+		/* Has this route been idle long enough to be candidate for
+		 * eviction?
+		 */
+		idle = jiffies - route->access_jiffies;
+		if (idle < peertab->idle_jiffies_min)
+			continue;
+		if (idle < peertab->idle_jiffies_max &&
+		    route->key.hnet->num_routes <= peertab->net_max)
+			continue;
+
+		/* Sort the candidate into the existing list of victims. */
+		for (i = 0; i < num_victims; i++) {
+			if (route == victims[i]) {
+				/* This can happen if there aren't very many
+				 * routes and we wrapped around in the hash
+				 * table.
+				 */
+				route = NULL;
+				break;
+			}
+			if (homa_route_prefer_evict(peertab, route, victims[i]))
+				swap(route, victims[i]);
+		}
+
+		if (num_victims < max_victims && route) {
+			victims[num_victims] = route;
+			num_victims++;
+		}
+	}
+	rhashtable_walk_stop(&peertab->route_ht_iter);
+	return num_victims;
+}
+
+/**
+ * homa_route_prefer_evict() - Given two routes, determine which one is
+ * a better candidate for eviction.
+ * @peertab:    Overall information used to manage routes.
+ * @route1:     First route.
+ * @route2:     Second route.
+ * Return:      True if @route1 is a better candidate for eviction than @route2.
+ */
+int homa_route_prefer_evict(struct homa_peertab *peertab,
+			    struct homa_route *route1,
+			    struct homa_route *route2)
+{
+	/* Prefer a route whose homa_net is over its limit; if both are either
+	 * over or under, then prefer the route with the longest idle time.
+	 */
+	if (route1->key.hnet->num_routes > peertab->net_max) {
+		if (route2->key.hnet->num_routes <= peertab->net_max)
+			return true;
+		else
+			return time_before(route1->access_jiffies,
+					   route2->access_jiffies);
+	}
+	if (route2->key.hnet->num_routes > peertab->net_max)
+		return false;
+	else
+		return time_before(route1->access_jiffies,
+				   route2->access_jiffies);
+}
+
+/**
+ * homa_peer_add_ack() - Add a given RPC to the list of unacked
+ * RPCs for its server. Once this method has been invoked, it's safe
+ * to delete the RPC, since it will eventually be acked to the server.
+ * @rpc:    Client RPC that has now completed. Must be locked by caller.
+ */
+void homa_peer_add_ack(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_peer *peer = rpc->route->peer;
+	struct homa_ack_hdr ack;
+
+	homa_peer_lock(peer);
+	if (peer->num_acks < HOMA_MAX_ACKS_PER_PKT) {
+		peer->acks[peer->num_acks].client_id = cpu_to_be64(rpc->id);
+		peer->acks[peer->num_acks].server_port = htons(rpc->dport);
+		peer->num_acks++;
+		homa_peer_unlock(peer);
+		return;
+	}
+
+	/* The peer has filled up; send an ACK message to empty it. The
+	 * RPC in the message header will also be considered ACKed.
+	 */
+	memcpy(ack.acks, peer->acks, sizeof(peer->acks));
+	ack.num_acks = htons(peer->num_acks);
+	peer->num_acks = 0;
+	homa_peer_unlock(peer);
+	homa_xmit_control(ACK, &ack, sizeof(ack), rpc);
+}
+
+/**
+ * homa_peer_get_acks() - Copy acks out of a peer, and remove them from the
+ * peer.
+ * @peer:    Peer to check for possible unacked RPCs.
+ * @count:   Maximum number of acks to return.
+ * @dst:     The acks are copied to this location.
+ *
+ * Return:   The number of acks extracted from the peer (<= count).
+ */
+int homa_peer_get_acks(struct homa_peer *peer, int count, struct homa_ack *dst)
+{
+	/* Don't waste time acquiring the lock if there are no ids available. */
+	if (peer->num_acks == 0)
+		return 0;
+
+	homa_peer_lock(peer);
+
+	if (count > peer->num_acks)
+		count = peer->num_acks;
+	memcpy(dst, &peer->acks[peer->num_acks - count],
+	       count * sizeof(peer->acks[0]));
+	peer->num_acks -= count;
+
+	homa_peer_unlock(peer);
+	return count;
+}
+
+/**
+ * homa_peer_update_sysctl_deps() - Update any peertab fields that depend
+ * on values set by sysctl. This function is invoked anytime a peer sysctl
+ * value is updated.
+ * @peertab:   Struct to update.
+ */
+void homa_peer_update_sysctl_deps(struct homa_peertab *peertab)
+{
+	peertab->idle_jiffies_min = peertab->idle_secs_min * HZ;
+	peertab->idle_jiffies_max = peertab->idle_secs_max * HZ;
+}
diff --git a/net/homa/homa_peer.h b/net/homa/homa_peer.h
new file mode 100644
index 000000000000..a0c80997ce19
--- /dev/null
+++ b/net/homa/homa_peer.h
@@ -0,0 +1,457 @@
+/* SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+ */
+
+/* This file contains definitions related to managing peers and routes
+ * (homa_peer, homa_route, homa_peertab).
+ */
+
+#ifndef _HOMA_PEER_H
+#define _HOMA_PEER_H
+
+#include "homa_wire.h"
+#include "homa_sock.h"
+
+#include <linux/rhashtable.h>
+
+struct homa_rpc;
+
+/**
+ * struct homa_peertab - Stores homa_peer and homa_route objects. There is
+ * one of these per struct homa.
+ */
+struct homa_peertab {
+	/**
+	 * @lock: Used to synchronize updates to @peer_ht, @route_ht, as well
+	 * as other operations on this object.
+	 */
+	spinlock_t lock;
+
+	/** @peer_ht: Hash table that stores struct peers. */
+	struct rhashtable peer_ht;
+
+	/**
+	 * @route_ht:  Hash table that stores homa_peer_flow objects.
+	 * There can be multiple entries in this table for each peer.
+	 */
+	struct rhashtable route_ht;
+
+	/**
+	 * @route_ht_iter: Used to scan route_ht to find routes to garbage
+	 * collect.
+	 */
+	struct rhashtable_iter route_ht_iter;
+
+	/** @num_routes: Total number of objects currently in @route_ht. */
+	int num_routes;
+
+	/**
+	 * @route_ht_valid: True means route_ht has been initialized and must
+	 * eventually be destroyed (it also means peer_ht has been initialized).
+	 */
+	bool route_ht_valid;
+
+	/**
+	 * @gc_stop_count: Nonzero means that route garbage collection
+	 * should not be performed (conflicting state changes are underway).
+	 */
+	int gc_stop_count;
+
+	/**
+	 * @gc_threshold: If @num_routes is less than this, don't bother
+	 * doing any peer garbage collection. Set externally via sysctl.
+	 */
+	int gc_threshold;
+
+	/**
+	 * @net_max: If the number of peers for a homa_net exceeds this number,
+	 * work aggressively to reclaim peers for that homa_net. Set
+	 * externally via sysctl.
+	 */
+	int net_max;
+
+	/**
+	 * @idle_secs_min: A peer will not be considered for garbage collection
+	 * under any circumstances if it has been idle less than this many
+	 * seconds. Set externally via sysctl.
+	 */
+	int idle_secs_min;
+
+	/**
+	 * @idle_jiffies_min: Same as idle_secs_min except in units
+	 * of jiffies.
+	 */
+	int idle_jiffies_min;
+
+	/**
+	 * @idle_secs_max: A peer that has been idle for less than
+	 * this many seconds will not be considered for garbage collection
+	 * unless its homa_net has more than @net_threshold peers. Set
+	 * externally via sysctl.
+	 */
+	int idle_secs_max;
+
+	/**
+	 * @idle_jiffies_max: Same as idle_secs_max except in units
+	 * of jiffies.
+	 */
+	int idle_jiffies_max;
+
+	/** @rcu_head: Holds state of a pending call_rcu invocation. */
+	struct rcu_head rcu_head;
+};
+
+/**
+ * struct homa_peer_key - Used to look up homa_peer structs in homa_peertab->peer_ht.
+ */
+struct homa_peer_key {
+	/**
+	 * @addr: Address of the desired host. IPv4 addresses are represented
+	 * with IPv4-mapped IPv6 addresses. Must be the first variable in
+	 * the struct, because of union in homa_peer.
+	 */
+	struct in6_addr addr;
+
+	/** @hnet: The network namespace in which this peer is valid. */
+	struct homa_net *hnet;
+};
+
+/**
+ * struct homa_peer - One of these objects exists for each machine that we
+ * have communicated with (either as client or server). This struct contains
+ * information that is common to all uses of the peer.
+ */
+struct homa_peer {
+	union {
+		/**
+		 * @addr: IPv6 address for the machine (IPv4 addresses are
+		 * stored as IPv4-mapped IPv6 addresses).
+		 */
+		struct in6_addr addr;
+
+		/** @ht_key: The hash table key for this peer in peertab->peer_ht. */
+		struct homa_peer_key ht_key;
+	};
+
+	/**
+	 * @refs: Number of outstanding references to this peer. Does *not*
+	 * include a reference for the entry in peertab->peer_ht. The peer
+	 * can be freed when this value becomes zero.
+	 */
+	refcount_t refs;
+
+	/**
+	 * @ht_linkage: Used by rashtable implement to link this peer into
+	 * peertab->peer_ht.
+	 */
+	struct rhash_head ht_linkage;
+
+	/**
+	 * @lock: used to synchronize access to fields in this struct, such
+	 * as @num_acks, @acks, @dst, and @dst_cookie.
+	 */
+	spinlock_t lock ____cacheline_aligned_in_smp;
+
+	/**
+	 * @num_acks: the number of (initial) entries in @acks that
+	 * currently hold valid information.
+	 */
+	int num_acks;
+
+	/**
+	 * @acks: info about client RPCs whose results have been completely
+	 * received.
+	 */
+	struct homa_ack acks[HOMA_MAX_ACKS_PER_PKT];
+
+};
+
+/**
+ * struct homa_route_key - Used to look up homa_route structs in
+ * homa_peertab_route_ht. These fields represent all of the information
+ * that could impact the choice of a particular struct dst_entry.
+ */
+struct homa_route_key {
+	/**
+	 * @saddr: Source network address. IPv4 addresses are represented
+	 * with IPv4-mapped IPv6 addresses.
+	 */
+	struct in6_addr saddr;
+	/**
+	 * @daddr: Destination network address. IPv4 addresses are represented
+	 * with IPv4-mapped IPv6 addresses.
+	 */
+	struct in6_addr daddr;
+
+	/**
+	 * @hnet: The network namespace in which this route is valid. This
+	 * needs to be a homa_hnet pointer, not just struct net, in order
+	 * to access homa_hnet->num_routes.
+	 */
+	struct homa_net *hnet;
+
+	/**
+	 * @sk_policy_out: sk->sk_policy[XFRM_POLICY_OUT]: uniquely
+	 * determines IPsec policy, if any.
+	 */
+	struct xfrm_policy *sk_policy_out;
+
+	/** @uid: sock->sk_sk_uid */
+	kuid_t uid;
+
+	/** @mark: sock->sk_mark */
+	u32 mark;
+
+	/** @secid: flowic.secid produced by security_sk_classify_flow. */
+	u32 secid;
+
+	/** @bound_dev_if: sock->sk_bound_dev_if */
+	int bound_dev_if;
+};
+
+/**
+ * struct homa_route - Holds a dst_entry for communicating with a
+ * particular peer, as well as information needed to cache the dst_entry
+ * and share it for multiple RPCs. There can be more than one of these
+ * objects per peer, which have different homa_route_keys.
+ */
+struct homa_route {
+	/**
+	 * @lock: used to synchronize uypdates to this struct.
+	 */
+	spinlock_t lock;
+
+	/**
+	 * @refs: Number of outstanding references to this object. Includes
+	 * one reference for the entry in peertab->route_ht, plus one for each
+	 * call to homa_route_get that has not been canceled by a call to
+	 * homa_peer_route_release; the object will be freed (via RCU) when
+	 * this count becomes zero.
+	 */
+	refcount_t refs;
+
+	/**
+	 * @access_jiffies: Time in jiffies of most recent access to this
+	 * object; used for garbage collection.
+	 */
+	unsigned long access_jiffies;
+
+	/** @key: Identifies this entry in peertab->route_ht. */
+	struct homa_route_key key;
+
+	/**
+	 * @peer: Peer with which this route is associated. This object holds a
+	 * reference on the peer.
+	 */
+	struct homa_peer *peer;
+
+	/**
+	 * @dst: Used to route packets to this peer; this object owns a
+	 * reference that must eventually be released.
+	 */
+	struct dst_entry __rcu *dst;
+
+	/**
+	 * @dst_cookie: Used to check whether dst is still valid. This is
+	 * accessed without synchronization, which is racy, but the worst
+	 * that can happen is using an obsolete dst.
+	 */
+	u32 dst_cookie;
+
+	/**
+	 * @flow: Contains parameters used to generate @dst; must be
+	 * retained and passed to ip*xmit.
+	 */
+	struct flowi flow;
+
+	/**
+	 * @ht_linkage: Used by rashtable to link this object into
+	 * peertab->route_ht.
+	 */
+	struct rhash_head ht_linkage;
+
+	/** @rcu_head: Holds state of a pending call_rcu invocation. */
+	struct rcu_head rcu_head;
+};
+
+void     homa_dst_refresh(struct homa_peertab *peertab,
+			  struct homa_peer *peer, struct homa_sock *hsk);
+void     homa_peer_add_ack(struct homa_rpc *rpc);
+struct homa_peer
+	*homa_peer_alloc(struct homa_sock *hsk, const struct in6_addr *addr);
+struct homa_peertab
+	*homa_peer_alloc_peertab(void);
+int      homa_peer_dointvec(const struct ctl_table *table, int write,
+			    void *buffer, size_t *lenp, loff_t *ppos);
+void     homa_peer_free(struct homa_peer *peer);
+void     homa_peer_free_net(struct homa_net *hnet);
+void     homa_peer_free_peertab(struct homa_peertab *peertab);
+struct homa_peer
+	*homa_peer_get(struct homa_sock *hsk, const struct in6_addr *addr);
+int      homa_peer_get_acks(struct homa_peer *peer, int count,
+			    struct homa_ack *dst);
+void     homa_peer_lock_slow(struct homa_peer *peer);
+void     homa_peer_release_fn(void *object, void *dummy);
+void     homa_peer_update_sysctl_deps(struct homa_peertab *peertab);
+void     homa_peer_set_cutoffs(struct homa_peer *peer, int c0, int c1,
+			       int c2, int c3, int c4, int c5, int c6, int c7);
+struct homa_route
+	*homa_route_alloc(struct homa_sock *hsk,
+			  const struct homa_route_key *key);
+void     homa_route_delete_fn(void *object, void *dummy);
+void     homa_route_free(struct rcu_head *head);
+void     homa_route_gc(struct homa_peertab *peertab);
+struct homa_route
+	*homa_route_get(struct homa_sock *hsk,
+				    const struct in6_addr *addr);
+u32      homa_route_hash(const void *data, u32 len, u32 seed);
+int      homa_route_pick_victims(struct homa_peertab *peertab,
+				 struct homa_route *victims[], int max_victims);
+int      homa_route_prefer_evict(struct homa_peertab *peertab,
+				 struct homa_route *route1,
+				 struct homa_route *route2);
+int      homa_route_validate(struct homa_rpc *rpc);
+
+extern const struct rhashtable_params peer_ht_params;
+extern const struct rhashtable_params route_ht_params;
+
+/**
+ * homa_peer_lock() - Acquire the lock for a peer.
+ * @peer:    Peer to lock.
+ */
+static inline void homa_peer_lock(struct homa_peer *peer)
+	__acquires(peer->lock)
+{
+	spin_lock_bh(&peer->lock);
+}
+
+/**
+ * homa_peer_unlock() - Release the lock for a peer.
+ * @peer:   Peer to lock.
+ */
+static inline void homa_peer_unlock(struct homa_peer *peer)
+	__releases(peer->lock)
+{
+	spin_unlock_bh(&peer->lock);
+}
+
+/**
+ * homa_route_hold() - Increment the reference count on a route.
+ * Caller must eventually invoke homa_route_release to decrement the
+ * reference count again.
+ * @route:   Route whose reference count should be incremented. Caller must
+ *           already hold a reference to this.
+ */
+static inline void homa_route_hold(struct homa_route *route)
+{
+	refcount_inc(&route->refs);
+}
+
+/**
+ * homa_route_release() - Release a reference on a route (cancels the effect of
+ * a previous call to homa_route_hold). If the reference count becomes zero
+ * then the route may be deleted at any time.
+ * @route:      Object to release.
+ */
+static inline void homa_route_release(struct homa_route *route)
+{
+	if (refcount_dec_and_test(&route->refs))
+		call_rcu(&route->rcu_head, homa_route_free);
+}
+
+/**
+ * homa_peer_compare() - Comparison function for entries in @peertab->peer_ht.
+ * @arg:   Contains one of the keys to compare.
+ * @obj:   homa_peer object containing the other key to compare.
+ * Return: 0 means the keys match, 1 means mismatch.
+ */
+static inline int homa_peer_compare(struct rhashtable_compare_arg *arg,
+				    const void *obj)
+{
+	const struct homa_peer_key *key = arg->key;
+	const struct homa_peer *peer = obj;
+
+	return !(ipv6_addr_equal(&key->addr, &peer->ht_key.addr) &&
+		 peer->ht_key.hnet == key->hnet);
+}
+
+/**
+ * homa_route_xmit() - Transmit a packet according to a given route.
+ * @skb:      Packet to transmit.
+ * @hsk:      Socket on which to transmit packet.
+ * @route:    Route to use to transmit packet.
+ * @priority: Priority for packet.
+ * Return:    0 for success, otherwise a negative errno.
+ */
+static inline int homa_route_xmit(struct sk_buff *skb, struct homa_sock *hsk,
+				  struct homa_route *route, int priority)
+{
+	rcu_read_lock();
+	dst_hold(rcu_dereference(route->dst));
+	skb_dst_set(skb, rcu_dereference(route->dst));
+	rcu_read_unlock();
+	if (ipv6_addr_v4mapped(&route->peer->addr)) {
+		hsk->inet.tos = priority << 5;
+		return ip_queue_xmit(&hsk->inet.sk, skb, &route->flow);
+	}
+	return ip6_xmit(&hsk->inet.sk, skb, &route->flow.u.ip6, 0,
+			NULL, priority << 5, 0);
+}
+
+/**
+ * homa_peer_unlink() - Remove the connection between a route and its peer,
+ * potentially freeing the peer in the process.
+ * @route:    Route to disconnect.
+ */
+static inline void homa_peer_unlink(struct homa_route *route)
+	__must_hold(route->hnet->homa->peertab->lock)
+{
+	struct homa_peertab *peertab;
+
+	if (!route->peer)
+		return;
+
+	/* Note: we don't need to use RCU for freeing peers because we have
+	 * already used RCU for freeing routes, so we know there are no
+	 * outstanding uses. By holding the peertab lock we have locked
+	 * out calls to homa_peer_get.
+	 */
+	peertab = route->key.hnet->homa->peertab;
+	if (refcount_dec_and_test(&route->peer->refs)) {
+		rhashtable_remove_fast(&peertab->peer_ht,
+				       &route->peer->ht_linkage,
+				       peer_ht_params);
+		homa_peer_free(route->peer);
+	}
+	route->peer = NULL;
+}
+
+/**
+ * homa_route_key_init() - Initialize the fields of a key for
+ * peertab->route_ht. Note: caller must hold an RCU read lock.
+ * @key:      Key to initialize
+ * @hsk:      Socket from which to pull fields for the key other than
+ *            daddr.
+ * @daddr:    Destination address for the key.
+ */
+static inline void homa_route_key_init(struct homa_route_key *key,
+				       const struct homa_sock *hsk,
+				       const struct in6_addr *daddr)
+{
+	struct flowi_common flowic;
+
+	memset(key, 0, sizeof(*key));
+	if (hsk->sock.sk_family == AF_INET)
+		ipv6_addr_set_v4mapped(hsk->inet.inet_saddr, &key->saddr);
+	else
+		key->saddr = hsk->inet.pinet6->saddr;
+	key->daddr = *daddr;
+	key->hnet = hsk->hnet;
+	key->sk_policy_out = rcu_dereference(hsk->sock.sk_policy[XFRM_POLICY_OUT]);
+	key->uid = hsk->sock.sk_uid;
+	key->mark = hsk->sock.sk_mark;
+	flowic.flowic_secid = 0;
+	security_sk_classify_flow(&hsk->sock, &flowic);
+	key->secid = flowic.flowic_secid;
+	key->bound_dev_if = hsk->sock.sk_bound_dev_if;
+}
+
+#endif /* _HOMA_PEER_H */
-- 
2.43.0

