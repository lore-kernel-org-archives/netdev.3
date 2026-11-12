Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457947;
	b=KVVXCwloa1qpyNZnujej9Ym9liXv2YmT+xwGM7ZY9cYyM97t1tpb7TFITQnA/Gk5Lqkj
	 q4tfDADJr5VS9QNclXU/XNlZZEl7DMUW4EBJAsuv6Flc0RTVxqKLsjwAviXERZcvxf7If
	 s1FzMljgDzqZ/1Xc3gAlH5ezWg9Q/NIDGv5ZvpBe0Bq7i9w3bxT+hXwwPDWii29QpitMS
	 /JBC1d3oWdi93lWly6vPtf/zF3Wv4AslnZFLJ7j0JFIvWu2g/gzcmmDaNPfRYIJFhpxdl
	 G//HzMFkukEaR0c+FBUODfLd0L8Vod1xQ+muG2RwHBhyiwTdmvYvvF5U0JI3J+KkssA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457947;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tSl8MVJnZefCbq5jHR2g4SRTuu2d9u1W5NiENOYHVKA=;
	b=kQX7I/hpQjTWEKFVxcpEYfThIbnytNK/FvPRUGY9w50uBORUM7hUWQJaRaUHM934321F
	 1ZUH6Ioer34Q3OIIjg022dMQIoZ4HFYQae7jlEORJ2t6meMOVAiHx1GnZNbl0yMcT9eer
	 8Y1HwAvO8Uf3KQ2CU6YJmWuUcpZQm/s3aasSZxXdX682V66p8pRNCuN9qQe7p7pwe9gmV
	 mEfoa9+EaJ3CXHMv6JWRrR1cQ0bgQNu9auQ1aXJDxlhPQhfJnZtY7UsfS1eVUorhrhpNh
	 /n8fVthZLlKdC7GrspHW+dwqhesoFe0RWggfg5OQoo1v6JJBNKzwl/zYEsjqfcRgbCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaeyeong.cc;
	spf=pass smtp.mailfrom=jaeyeong.cc;
	dkim=pass header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=W3uUTFNT;
	arc=none smtp.remote-ip=185.70.43.99
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9C606A321;
	Thu, 12 Nov 2026 04:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76E9C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=W3uUTFNT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
	s=protonmail2; t=1794457942; x=1794717142;
	bh=tSl8MVJnZefCbq5jHR2g4SRTuu2d9u1W5NiENOYHVKA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=W3uUTFNT42Fsc9EQUuqWLn09QQYkG+eTXYlY8O8tiIFJCCIv+XWbWUhsMkTcZbNtw
	 CgfXW6GuKJ+YRxqVdTmfUW/LpNF77p54C8NQeoihPztnt3JVUuQysU1DLA+r3DYdRE
	 J7WAH0l+eQNHI3rpzCKl1nmox2SXKazRoKoa7FtyOOEPYnHeU9kQ3Torm+Gmm2zfwP
	 cq5s6BGOtnf4xghFIe0TqNqaaQg1efazoBSTCKsSOjrUgeI4BSjt3W2T408Q0tip51
	 D08VULbLheVKtw/ktxDbNWVB7s/ZnZNKk+AWXGa8ZaogD4xy9i/jFrYU18vuOEcF0F
	 3dOhC7JZQFYeg==
Date: Thu, 12 Nov 2026 04:32:17 +0000
To: netdev@vger.kernel.org
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, alice.kernel@fastmail.im, tariqt@nvidia.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net] net/tls: serialize context removal in tls_device_down()
Message-ID: <20261112043209.102404-1-lee@jaeyeong.cc>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: 333b79e90391ab3c6eea869158387f16cfae3937
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tls_device_down() moves each context to tls_device_down_list while
holding tls_device_lock. It then drops its reference and removes the
context after releasing the lock.

tls_device_queue_ctx_destruction() removes contexts from the same list
under tls_device_lock. If it removes an adjacent context while
tls_device_down() is deleting its node, the two list updates can
interleave. One update can then target a context freed by the other path,
causing a use-after-free write.

Drop the reference and remove the context in the existing
tls_device_lock critical section. Keep tls_device_free_ctx() after
releasing the lock.

This issue was found with a static analysis tool.

Fixes: f6336724a4d4 ("net/tls: Remove the context from the list in tls_devi=
ce_down")
Cc: stable@vger.kernel.org
Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
---
Reproduced with a deterministic KUnit harness under KASAN in a 2-vCPU
x86_64 QEMU guest. The unpatched kernel reported:

  BUG: KASAN: slab-use-after-free in tls_device_racy_list_del
  Write of size 8

The patched tls_device.o was compile-tested against current net/main with
KASAN and DEBUG_LIST enabled.

 net/tls/tls_device.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 4cdfbb57ecff0..fa7170cd4fd10 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1350,6 +1350,8 @@ static int tls_device_down(struct net_device *netdev)
 =09spin_unlock_irqrestore(&tls_device_lock, flags);
=20
 =09list_for_each_entry_safe(ctx, tmp, &list, list)=09{
+=09=09bool free_ctx;
+
 =09=09/* Stop offloaded TX and switch to the fallback.
 =09=09 * tls_is_skb_tx_device_offloaded will return false.
 =09=09 */
@@ -1387,17 +1389,19 @@ static int tls_device_down(struct net_device *netde=
v)
 =09=09 */
 =09=09spin_lock_irqsave(&tls_device_lock, flags);
 =09=09list_move_tail(&ctx->list, &tls_device_down_list);
+=09=09/* Serialize the final removal with sk_destruct. */
+=09=09free_ctx =3D refcount_dec_and_test(&ctx->refcount);
+=09=09if (free_ctx)
+=09=09=09list_del(&ctx->list);
 =09=09spin_unlock_irqrestore(&tls_device_lock, flags);
=20
 =09=09/* Device contexts for RX and TX will be freed in on sk_destruct
 =09=09 * by tls_device_free_ctx. rx_conf and tx_conf stay in TLS_HW.
-=09=09 * Now release the ref taken above.
 =09=09 */
-=09=09if (refcount_dec_and_test(&ctx->refcount)) {
+=09=09if (free_ctx) {
 =09=09=09/* sk_destruct ran after tls_device_down took a ref, and
 =09=09=09 * it returned early. Complete the destruction here.
 =09=09=09 */
-=09=09=09list_del(&ctx->list);
 =09=09=09tls_device_free_ctx(ctx);
 =09=09}
 =09}
--=20
2.43.0


