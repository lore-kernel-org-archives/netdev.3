Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661512;
	b=iiVo3yQY51m6sgHHpiSLd74LG81PbeC7nUB7v2UCFqCtoPCYu6Qnw4iwbkpkJ6lFnfcS
	 /c7CnwGfPSvHQY2FQPuigP/+y5KCDRi5ambn/9tuKJtnewX23OEI+huBopfvz7QlO2ony
	 r3vVL5r6nR6DdHUKpje/ksk7vNlHFPVgvF9Ff8NZPRuQXKa7RfJayTpzvvr0+zGnlRjA6
	 PSnwuxE6UVS4Hsf/lRK4Af3ZO8K7w1A9KvOn3HujGdWh58DHtdE/XjEVXDY5/Y8DcOD54
	 biTh/+tAX/Cyj3OPL0ItIteHSdXAg5jUokxkUNPs6xXHtMNILOoFurit2SnccvvFSeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=iZDXbweAmFNOv7UlpFwc90QtjCwuGkfN6YnFxiQHliQ=;
	b=xcvhX+j7GtdhuRSQYH7OPkFdq4QwbL/1HfNqc7PDythMFDowJRNKvlpuJyuQVF5hDvRO
	 +Pnb11mu8Z/lMVAAbgK/XoX9/WLk2hjKHUrVhpTZqFSnl4UHQWfp6nEueBZ80HTEh2kU7
	 /Dam98aSa128Bh28f7s6vgRV9Il4AniswtUxrYZJ6gv6GrpOKHpvZ5XFTK9mLgc1EvC3v
	 YmIhJ0xroGiBp308cxUp/2f0mSBHnLetN9G2OqKvB1ysIs08dbfRGc+AxeUn146LSnLj9
	 x0OExz2h2g9OlaA2I6mpiMppY986yriau1pCHBk/d8Kw+zUkqAT75eOrR+59AyZ4jNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NwMBWKZk;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9B606D810
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB9B606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NwMBWKZk
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c3c370b17so6035861eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793661511; x=1794266311; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZDXbweAmFNOv7UlpFwc90QtjCwuGkfN6YnFxiQHliQ=;
        b=NwMBWKZkHV9VC9yw3iAdkZ2KsA56AQ3pOxJUPTT0CttR4gI/DPhpJwxH1Ytgnx8jf4
         CgJptNiuJv7F9NxRj5XiBePAEmKGA/c0Rs9Iw8bwb9jH2L0cIF4hsiSzP5c85/8cv93H
         92M7DqcGpXrsHLV2bJD3nTri9lLl95Mjewm1RIjOJgk48n+XclK3bvk+9FtPj5YjrtTn
         zi5K64h49LLfIoDxkAcKIaB6yJxtjM/SdUX3pQtKmWqWVCkz1yl+qADFdV1gG/6SJ496
         EBS9H/4IWjbil0WrvIn9Z01QXRgxY1PrTzOBdRs9UOw+7XSHYDDA4eU1yEaSyVLNrZNz
         kotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661511; x=1794266311;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZDXbweAmFNOv7UlpFwc90QtjCwuGkfN6YnFxiQHliQ=;
        b=lSUewxgI1S6waaP3T/C/3k0DnUKkPn08QqDJTnsKRHa8MPb3mJkhUPfdyBqDhu2FKJ
         Gmu1i2fLozd4BO5XqpR2yPgEqoPc7/S0Q3rqfquu1do3El8KwvFrfJrMSEOg6KlVmZt3
         m/bExzgp+xQo83b9ZELOHPF+lIWDzxKu0Mk2tI4pVpebPdLlfLKl+FHoMhTB5UXB8vXK
         yF/bQ3D3Q4wgQZNh7IlEvL3YbVfXFyjzosroIFieB/y4bYgDr7itg0DY+HSUhgASrjkD
         BaNxiBiCkJ/i9haYqCzS1QzJAHRlyJIldExAqTIq4VgR3zpkFP2v6Mh1VZCn7XYyNaa0
         qlfg==
X-Gm-Message-State: APuU4Z9aw6UXo1T9n7haJ6czlFLc5J789blGlINtpwwI9OFHB3Uxs+sm
	bUxjhDfAP8rfjmmeJgRZGbn1BvIkhRdAjeL/pLI6yW466YvONc1QuJBVY9SgvtZEN9kHvDm2ssP
	JQzeXAIKran6tYUbgFzr9eIkzhEmcQOyxmO7cE1drPDvXmKBO0pfkslDwnUPlumq5uvHo/9sSq1
	QpxVUTJ3o5tGjfx7X4yLZ1qoCShz082f0nHy55Vjej8ghpX1xjaIzVl2i+oXP5J3s=
X-Received: from dyr19.prod.google.com ([2002:a05:693c:4013:b0:35f:390d:248a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:c00f:10b0:36a:1470:da0e with SMTP id 5a478bee46e88-36a423bececmr20849250eec.29.1793661510277;
 Mon, 02 Nov 2026 15:18:30 -0800 (PST)
Date: Mon,  2 Nov 2026 23:18:25 +0000
In-Reply-To: <20261102231827.4088254-1-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102231827.4088254-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261102231827.4088254-3-almasrymina@google.com>
Subject: [PATCH net-next v2 2/4] netmem: store memory provider private pointer
 directly in struct net_iov
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, io-uring@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Resolving the memory provider instance from a struct net_iov currently
chases niov->owner (struct net_iov_area) and then dereferences the
provider-specific container struct (such as net_devmem_dmabuf_binding
or io_zcrx_area->ifq).

Alias void *mp_priv over the unused _pp_mapping_pad slot inside struct
net_iov (keeping sizeof(struct net_iov) == 64 bytes unchanged) and populate
it in net_iov_init() for both TX and RX net_iovs so callers can obtain the
provider instance pointer in a single load from the net_iov cacheline.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 15 +++++++++++++--
 io_uring/zcrx.c      |  2 +-
 net/core/devmem.c    |  3 ++-
 net/core/devmem.h    |  3 +--
 net/core/net_test.c  | 10 +++++-----
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index fb693bc1702a4..c869be9c4d266 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -95,11 +95,20 @@ enum net_iov_type {
  *		supported.
  */
 struct net_iov {
-	struct netmem_desc desc;
+	union {
+		struct netmem_desc desc;
+		struct {
+			unsigned long _pad[3];
+			void *mp_priv;
+		};
+	};
 	enum net_iov_type type;
 	struct net_iov_area *owner;
 };
 
+static_assert(offsetof(struct net_iov, mp_priv) ==
+	      offsetof(struct netmem_desc, _pp_mapping_pad));
+
 struct net_iov_area {
 	/* Array of net_iovs for this area. */
 	struct net_iov *niovs;
@@ -120,10 +129,12 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
  */
 static inline void net_iov_init(struct net_iov *niov,
 				struct net_iov_area *owner,
-				enum net_iov_type type)
+				enum net_iov_type type,
+				void *mp_priv)
 {
 	niov->owner = owner;
 	niov->type = type;
+	niov->mp_priv = mp_priv;
 }
 
 /* netmem */
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 6d7abb1636e7f..6ec618d325606 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -562,7 +562,7 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	for (i = 0; i < nr_iovs; i++) {
 		struct net_iov *niov = &area->nia.niovs[i];
 
-		net_iov_init(niov, &area->nia, NET_IOV_IOURING);
+		net_iov_init(niov, &area->nia, NET_IOV_IOURING, ifq);
 		area->freelist[i] = i;
 		atomic_set(&area->user_refs[i], 0);
 	}
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 32fafbfa1359e..fe99c005cbc5e 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -323,7 +323,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		nr_niovs = len >> niov_shift;
 		for (i = 0; i < nr_niovs; i++, niov_idx++) {
 			niov = &binding->area.niovs[niov_idx];
-			net_iov_init(niov, &binding->area, NET_IOV_DMABUF);
+			net_iov_init(niov, &binding->area, NET_IOV_DMABUF,
+				     binding);
 			if (net_mp_niov_set_dma_addr(niov, dma_addr)) {
 				err = -EFAULT;
 				NL_SET_ERR_MSG(extack,
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 8fa089776610a..942b8caf36e99 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -102,8 +102,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 static inline struct net_devmem_dmabuf_binding *
 net_devmem_iov_binding(const struct net_iov *niov)
 {
-	return container_of(net_iov_owner(niov),
-			    struct net_devmem_dmabuf_binding, area);
+	return niov->mp_priv;
 }
 
 static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
diff --git a/net/core/net_test.c b/net/core/net_test.c
index 2b5080c226636..63124dbf3c9a8 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -857,7 +857,7 @@ static void netmem_ref_test_net_iov(struct kunit *test)
 			      PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
-	net_iov_init(&niov, &binding.area, NET_IOV_DMABUF);
+	net_iov_init(&niov, &binding.area, NET_IOV_DMABUF, &binding);
 	netmem = net_iov_to_netmem(&niov);
 	base_ref = atomic_long_read(&binding.ref.data->count);
 
@@ -1145,7 +1145,7 @@ static void netmem_ref_test_release_data(struct kunit *test)
 			percpu_ref_init(&binding.ref, dummy_percpu_ref_release,
 					PERCPU_REF_INIT_ATOMIC, GFP_KERNEL),
 			0);
-	net_iov_init(&niov, &binding.area, NET_IOV_DMABUF);
+	net_iov_init(&niov, &binding.area, NET_IOV_DMABUF, &binding);
 	netmem = net_iov_to_netmem(&niov);
 	netmem_set_pp(netmem, pool);
 	netmem_or_pp_magic(netmem, PP_SIGNATURE);
@@ -1206,7 +1206,7 @@ static void netmem_ref_test_skb_segment(struct kunit *test)
 			percpu_ref_init(&binding.ref, dummy_percpu_ref_release,
 					PERCPU_REF_INIT_ATOMIC, GFP_KERNEL),
 			0);
-	net_iov_init(&niov, &binding.area, NET_IOV_DMABUF);
+	net_iov_init(&niov, &binding.area, NET_IOV_DMABUF, &binding);
 	niov_nm = net_iov_to_netmem(&niov);
 	netmem_set_pp(niov_nm, pool);
 	netmem_or_pp_magic(niov_nm, PP_SIGNATURE);
@@ -1508,7 +1508,7 @@ static void netmem_ref_test_try_coalesce(struct kunit *test)
 			percpu_ref_init(&binding.ref, dummy_percpu_ref_release,
 					PERCPU_REF_INIT_ATOMIC, GFP_KERNEL),
 			0);
-	net_iov_init(&niov, &binding.area, NET_IOV_DMABUF);
+	net_iov_init(&niov, &binding.area, NET_IOV_DMABUF, &binding);
 	niov_nm = net_iov_to_netmem(&niov);
 	netmem_set_pp(niov_nm, pool);
 	netmem_or_pp_magic(niov_nm, PP_SIGNATURE);
@@ -1654,7 +1654,7 @@ static void netmem_ref_test_tcp_devmem_recv(struct kunit *test)
 		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 	binding.area.niovs = &niov;
-	net_iov_init(&niov, &binding.area, NET_IOV_DMABUF);
+	net_iov_init(&niov, &binding.area, NET_IOV_DMABUF, &binding);
 	niov_nm = net_iov_to_netmem(&niov);
 	netmem_set_pp(niov_nm, pool);
 	netmem_or_pp_magic(niov_nm, PP_SIGNATURE);
-- 
2.56.0.385.gac671c819a-goog

