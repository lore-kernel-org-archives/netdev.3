Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301987;
	b=Hqx0RhzfxMNXL+VNNxLZmDM5yZ8XZkCHKXLOjiZr+rZkWeC9a4kolLXyr/q/IYUdpHUf
	 2TCtVKImxZBLSeeQ2AHIPivl7QmQVey86nzFpmAI3dlxCEs/xWlR6ioPdPTDZIgsh+qTC
	 OR5z8Zu2mytFth4JtkUR2oi+Jnb9B+4Cd/oMp7YdNnzKL+1/XDxcrqABrUZyiQoZaerrE
	 6YxY5lq1FMB0hj+ahGQPBpqBulrakG1AzFpLaB0QN/uByR2GwGLSLBGk+oDOxbYmztN4/
	 b6sq2Hqq1oChGsJm9wRtseb40bfZeAceWC4zsaUF+AxTzjDaztX8wKgbkNgotihuBlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301987;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=izg1/u7+/ux2L4ZiZrrTUgbq8wQG42pDQrKMiFlfrYY=;
	b=K11YFjKP2hGzjoYzm/QmcDvnsqWPT0xAPp1dvmm6byrdrzVmFadeGuKwDnhNo7wz7rLt
	 WXmdP5lrZDh1DD3SeynvY6iH6EJOcybRuf0dUAvk07oT7LOOLRX1eN7gsuXjIlBgP4zcG
	 Kk5Qb5TgRFk2ao8rp8PteddwwXqS9Wm1XIdHh8dskB0FXCG1yk1HnFHBmGtHwVweBe0Xu
	 JAiDPaX6OK7RmkqY22l7N9Tvm+M9XnOczQdkeNslWduoqhzkNGubKN9ucowuQMEwfFklB
	 IdIDvOq7MSL8juI4+33RZdLlUqOHepKejpgP+6Wo8A0mZBUEoAXVPO3RjBoZ1bfakeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BciGz++M;
	arc=none smtp.remote-ip=95.215.58.180
Received: from mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FD606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 445FD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BciGz++M
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9i5PlLUyKyJmdin+eBEuKSO1iz4ih+sE3+AEMixQ/yI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794301984; v=1; x=1794906784;
 b=BciGz++M8/YRWdV9QUeaHsQIkB2E/2EEtThZVVFqunJxHxNuteLqmNMtMXkGlmWs8Im3CLPp
 etCg0q2n/zJfDshOGrATt/Wmvc0x6a+7zeyFjUzhJ67qQxy1zEShKXF9/vkIo+ijLyW5Z1J/oMk
 L75GhzrCCa1YriWtBu6x0+cc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 85d5aaf2a0870739;
	Tue, 10 Nov 2026 09:13:04 +0000
X-Mizu-Trace-ID: 85d5aaf2a0870739
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] pppoe: use sk_node for session hash chains
Date: Tue, 10 Nov 2026 17:12:52 +0800
Message-ID: <20261110091255.24158-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
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

PPPoE uses a private next pointer to chain sockets in each hash bucket.
Removing a socket requires walking the chain to find its predecessor.

Use sock.sk_node and the standard hlist helpers to allow constant-time
removal and eliminate pppox_sock.next. Cache the bucket index in sk_hash
before publishing the socket and use it to advance /proc/net/pppoe
iteration between buckets.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c  | 101 +++++++++++++--------------------------
 include/linux/if_pppox.h |   1 -
 2 files changed, 34 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 67c28ac763ef..de6edc31790f 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -99,7 +99,7 @@ struct pppoe_net {
 	 * as well, moreover in case of SMP less locking
 	 * controversy here
 	 */
-	struct pppox_sock __rcu *hash_table[PPPOE_HASH_SIZE];
+	struct hlist_head hash_table[PPPOE_HASH_SIZE];
 	spinlock_t hash_lock;
 };
 
@@ -159,15 +159,14 @@ static struct pppox_sock *__get_item(struct pppoe_net *pn, __be16 sid,
 				unsigned char *addr, int ifindex)
 {
 	int hash = hash_item(sid, addr);
-	struct pppox_sock *ret;
+	struct sock *sk;
+
+	sk_for_each_rcu(sk, &pn->hash_table[hash]) {
+		struct pppox_sock *ret = pppox_sk(sk);
 
-	ret = rcu_dereference(pn->hash_table[hash]);
-	while (ret) {
 		if (cmp_addr(&ret->pppoe_pa, sid, addr) &&
 		    ret->pppoe_ifindex == ifindex)
 			return ret;
-
-		ret = rcu_dereference(ret->next);
 	}
 
 	return NULL;
@@ -176,47 +175,22 @@ static struct pppox_sock *__get_item(struct pppoe_net *pn, __be16 sid,
 static int __set_item(struct pppoe_net *pn, struct pppox_sock *po)
 {
 	int hash = hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
-	struct pppox_sock *ret, *first;
+	struct sock *sk;
+
+	sk_for_each(sk, &pn->hash_table[hash]) {
+		struct pppox_sock *ret = pppox_sk(sk);
 
-	first = rcu_dereference_protected(pn->hash_table[hash], lockdep_is_held(&pn->hash_lock));
-	ret = first;
-	while (ret) {
 		if (cmp_2_addr(&ret->pppoe_pa, &po->pppoe_pa) &&
 		    ret->pppoe_ifindex == po->pppoe_ifindex)
 			return -EALREADY;
-
-		ret = rcu_dereference_protected(ret->next, lockdep_is_held(&pn->hash_lock));
 	}
 
-	RCU_INIT_POINTER(po->next, first);
-	rcu_assign_pointer(pn->hash_table[hash], po);
+	po->sk.sk_hash = hash;
+	hlist_add_head_rcu(&po->sk.sk_node, &pn->hash_table[hash]);
 
 	return 0;
 }
 
-static void __delete_item(struct pppoe_net *pn, const struct pppox_sock *po)
-{
-	int hash = hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
-	struct pppox_sock *ret, __rcu **src;
-
-	ret = rcu_dereference_protected(pn->hash_table[hash], lockdep_is_held(&pn->hash_lock));
-	src = &pn->hash_table[hash];
-
-	while (ret) {
-		if (ret == po) {
-			struct pppox_sock *next;
-
-			next = rcu_dereference_protected(ret->next,
-							 lockdep_is_held(&pn->hash_lock));
-			rcu_assign_pointer(*src, next);
-			break;
-		}
-
-		src = &ret->next;
-		ret = rcu_dereference_protected(ret->next, lockdep_is_held(&pn->hash_lock));
-	}
-}
-
 /**********************************************************************
  *
  *  Set/get/delete/rehash items
@@ -234,10 +208,10 @@ static inline struct pppox_sock *get_item(struct pppoe_net *pn, __be16 sid,
 	return po;
 }
 
-static void delete_item(struct pppoe_net *pn, const struct pppox_sock *po)
+static void delete_item(struct pppoe_net *pn, struct pppox_sock *po)
 {
 	spin_lock(&pn->hash_lock);
-	__delete_item(pn, po);
+	__sk_del_node_init(&po->sk);
 	spin_unlock(&pn->hash_lock);
 }
 
@@ -256,20 +230,15 @@ static void pppoe_flush_dev(struct net_device *dev)
 	pn = pppoe_pernet(dev_net(dev));
 	spin_lock(&pn->hash_lock);
 	for (i = 0; i < PPPOE_HASH_SIZE; i++) {
-		struct pppox_sock *po = rcu_dereference_protected(pn->hash_table[i],
-								  lockdep_is_held(&pn->hash_lock));
-		struct sock *sk;
-
-		while (po) {
-			while (po && po->pppoe_dev != dev) {
-				po = rcu_dereference_protected(po->next,
-							       lockdep_is_held(&pn->hash_lock));
-			}
+		struct sock *sk = sk_head(&pn->hash_table[i]);
 
-			if (!po)
-				break;
+		while (sk) {
+			struct pppox_sock *po = pppox_sk(sk);
 
-			sk = &po->sk;
+			if (po->pppoe_dev != dev) {
+				sk = sk_next(sk);
+				continue;
+			}
 
 			/* We always grab the socket lock, followed by the
 			 * hash_lock, in that order.  Since we should hold the
@@ -301,8 +270,7 @@ static void pppoe_flush_dev(struct net_device *dev)
 
 			BUG_ON(pppoe_pernet(dev_net(dev)) == NULL);
 			spin_lock(&pn->hash_lock);
-			po = rcu_dereference_protected(pn->hash_table[i],
-						       lockdep_is_held(&pn->hash_lock));
+			sk = sk_head(&pn->hash_table[i]);
 		}
 	}
 	spin_unlock(&pn->hash_lock);
@@ -633,7 +601,6 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
 		po->pppoe_ifindex = 0;
 		memset(&po->pppoe_pa, 0, sizeof(po->pppoe_pa));
 		memset(&po->chan, 0, sizeof(po->chan));
-		po->next = NULL;
 		po->num = 0;
 
 		sk->sk_state = PPPOX_NONE;
@@ -970,20 +937,17 @@ static int pppoe_seq_show(struct seq_file *seq, void *v)
 
 static inline struct pppox_sock *pppoe_get_idx(struct pppoe_net *pn, loff_t pos)
 {
-	struct pppox_sock *po;
+	struct sock *sk;
 	int i;
 
 	for (i = 0; i < PPPOE_HASH_SIZE; i++) {
-		po = rcu_dereference(pn->hash_table[i]);
-		while (po) {
+		sk_for_each_rcu(sk, &pn->hash_table[i]) {
 			if (!pos--)
-				goto out;
-			po = rcu_dereference(po->next);
+				return pppox_sk(sk);
 		}
 	}
 
-out:
-	return po;
+	return NULL;
 }
 
 static void *pppoe_seq_start(struct seq_file *seq, loff_t *pos)
@@ -999,7 +963,8 @@ static void *pppoe_seq_start(struct seq_file *seq, loff_t *pos)
 static void *pppoe_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct pppoe_net *pn = pppoe_pernet(seq_file_net(seq));
-	struct pppox_sock *po, *next;
+	struct hlist_node *next;
+	struct pppox_sock *po;
 
 	++*pos;
 	if (v == SEQ_START_TOKEN) {
@@ -1007,17 +972,19 @@ static void *pppoe_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		goto out;
 	}
 	po = v;
-	next = rcu_dereference(po->next);
+	next = rcu_dereference(hlist_next_rcu(&po->sk.sk_node));
 	if (next)
-		po = next;
+		po = pppox_sk(sk_entry(next));
 	else {
-		int hash = hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
+		unsigned int hash = po->sk.sk_hash;
 
 		po = NULL;
 		while (++hash < PPPOE_HASH_SIZE) {
-			po = rcu_dereference(pn->hash_table[hash]);
-			if (po)
+			next = rcu_dereference(hlist_first_rcu(&pn->hash_table[hash]));
+			if (next) {
+				po = pppox_sk(sk_entry(next));
 				break;
+			}
 		}
 	}
 
diff --git a/include/linux/if_pppox.h b/include/linux/if_pppox.h
index 594d6dc3f4c9..aafdf72cfd2c 100644
--- a/include/linux/if_pppox.h
+++ b/include/linux/if_pppox.h
@@ -41,7 +41,6 @@ struct pppox_sock {
 	/* struct sock must be the first member of pppox_sock */
 	struct sock sk;
 	struct ppp_channel chan;
-	struct pppox_sock __rcu	*next;	  /* for hash table */
 	union {
 		struct pppoe_opt pppoe;
 		struct pptp_opt  pptp;
-- 
2.43.0

