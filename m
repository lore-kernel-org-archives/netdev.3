Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488090;
	b=a7hLeFogVJHnw5WNtJe1VoapzaHb/NnaxEcvCyaQpXBSg6V+0MEskHy8wT1BigUINzjk
	 LufuofU4jpPod8yJ3B0+G6AUmAfomEz5ttAzi763buzLsFotmFRRXmSXXMYR8ayjm8tZQ
	 Vn8wzbmyetd6tVJZnHMEWPICsw3ePUZiJAz5TDEVXl+VXDMtyJASq+MP5HNJ63e91V3Ko
	 8KNLda5i9EM509XAk8P+O3pbKuZUoxPOu9z6zIr1Y0HZEZ3ug5gSBGl4cIP5G6xJw530e
	 qhS/hBTLYSVM55LCSlMzAfp8OxXydYgRavoKwZQ698lhNIrNCIidmXBp7VR+UUNh88g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488090;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OyLLAUQgg2lsg9dQ6S3FRdSjv0JAJE2gYyPiInB6GMk=;
	b=Bn9WTfwJRjpEo8k9Ie/yHdH6k1F/OtLLeveNNVr83xGxHaaQa9I6dV/WCYu8Mvjjq9Eh
	 iAjTJ1j9nWlXOy24VT2Ie7RNntjJZjBxKaRzfNd+rWQNm0m6bUsg1XQwbDDi3Kfg/wkNx
	 L+y/3IB4hFKky1waYI0MH6r5rfqr9ZY8l0BEziqZAWqXkj0jgHTwz6QpUaVub+qRNTMmt
	 4N4AgKiEcCwAp7Uhc/HxfUNidNHnvgt/NNNqQzVEA5pAUTnaEs4r5gTQkgSHMPvysbtel
	 2ezoMpiGSQMn6pXgbN+dJ/ttiqbk1QBXuCyyb9fHTNL/fnu5Gx0xpS+key3TsahFxQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DeJcECNi;
	arc=none smtp.remote-ip=95.215.58.223
Received: from mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F8606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE8F8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DeJcECNi
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YNTKApM0NRZweSbGwqQREeW9XGzGVWqnor/S3lp0hng=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792488087; v=1; x=1793092887;
 b=DeJcECNiuHs+hoCDz8hqLT5qHF+kZIQojZ8CCusexWrdskmYUVTcgzSojnw8GZHasrTN9Voy
 TfjrlIhRWkcYoueir1+SHTA1VxdLMJF4xd5o70zPy9nuu/5zWapv+qizd5qRLV4pmrbGCy7Pk+Y
 jKweFhN53seqcKYL8okOv978=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ce2fc71dc6064e2e;
	Tue, 20 Oct 2026 09:21:27 +0000
X-Mizu-Trace-ID: ce2fc71dc6064e2e
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH net] pppoe: delete session hash entries by pointer match
Date: Tue, 20 Oct 2026 17:21:11 +0800
Message-ID: <20261020092118.47416-1-qingfang.deng@linux.dev>
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

pppoe_connect() copies the requested PPPoE address to a socket before
attempting to insert the socket into the session hash table. If the
tuple already exists, __set_item() returns -EALREADY, but the copied
address and ifindex remain set on the failed socket.

Closing that socket then deletes the existing socket's hash entry
through pppoe_release(), preventing it from receiving further session
traffic. An unprivileged process in the same network namespace can
trigger this through a duplicate connection attempt.

To avoid the accidental delete, pass the pppox_sock to __delete_item(),
and unlink only an entry whose pointer matches the requested socket.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index bf7414b46a26..ee0e318d6a2a 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -194,18 +194,16 @@ static int __set_item(struct pppoe_net *pn, struct pppox_sock *po)
 	return 0;
 }
 
-static void __delete_item(struct pppoe_net *pn, __be16 sid,
-					char *addr, int ifindex)
+static void __delete_item(struct pppoe_net *pn, const struct pppox_sock *po)
 {
-	int hash = hash_item(sid, addr);
+	int hash = hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
 	struct pppox_sock *ret, __rcu **src;
 
 	ret = rcu_dereference_protected(pn->hash_table[hash], lockdep_is_held(&pn->hash_lock));
 	src = &pn->hash_table[hash];
 
 	while (ret) {
-		if (cmp_addr(&ret->pppoe_pa, sid, addr) &&
-		    ret->pppoe_ifindex == ifindex) {
+		if (ret == po) {
 			struct pppox_sock *next;
 
 			next = rcu_dereference_protected(ret->next,
@@ -236,11 +234,10 @@ static inline struct pppox_sock *get_item(struct pppoe_net *pn, __be16 sid,
 	return po;
 }
 
-static inline void delete_item(struct pppoe_net *pn, __be16 sid,
-					char *addr, int ifindex)
+static void delete_item(struct pppoe_net *pn, const struct pppox_sock *po)
 {
 	spin_lock(&pn->hash_lock);
-	__delete_item(pn, sid, addr, ifindex);
+	__delete_item(pn, po);
 	spin_unlock(&pn->hash_lock);
 }
 
@@ -570,8 +567,7 @@ static int pppoe_release(struct socket *sock)
 	 * protect "po" from concurrent updates
 	 * on pppoe_flush_dev
 	 */
-	delete_item(pn, po->pppoe_pa.sid, po->pppoe_pa.remote,
-		    po->pppoe_ifindex);
+	delete_item(pn, po);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -621,8 +617,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
 	if (stage_session(po->pppoe_pa.sid)) {
 		pppox_unbind_sock(sk);
 		pn = pppoe_pernet(sock_net(sk));
-		delete_item(pn, po->pppoe_pa.sid,
-			    po->pppoe_pa.remote, po->pppoe_ifindex);
+		delete_item(pn, po);
 		if (po->pppoe_dev) {
 			dev_put(po->pppoe_dev);
 			po->pppoe_dev = NULL;
@@ -672,8 +667,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
 
 		error = ppp_register_net_channel(dev_net(dev), &po->chan);
 		if (error) {
-			delete_item(pn, po->pppoe_pa.sid,
-				    po->pppoe_pa.remote, po->pppoe_ifindex);
+			delete_item(pn, po);
 			goto err_put;
 		}
 
-- 
2.43.0

