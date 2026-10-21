Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547763;
	b=pXMRHS4PKJZHiKazybY5g3T4oRqThtE5JmaMzsstSL8OcIXfY+iw3SPDPN5mB290n3Db
	 szUSFMI+G7uBYgYKRQP+GKx3tmknjJ6OmO6xGPHPpiRRQQVgfy7pBBzASzq0wb1gxTGw0
	 IgKK9gnPMf8vlgnQCR5cPr4PNoKetQRgInZ5jd5ivXtTNbNgfyAVi9OYje4RPleN5KrbM
	 8V6j1+c3mVudpc02DbpJeLn6HTrv2HAOlM7qfnkOY40nZu1qmPoVNP+gCTPRSvlsYPbvl
	 845SR0ve1lS+qOj/LK0Jx7QukpXw3FwbjuDzbBvP2NZZGtxp3nVBqR3g7aNbwIWVUEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=3TnjCGHvcu9jfk9ulWt0hr+Q1cRLS9Qn/7cuD3nnKp4=;
	b=GbdAsdxYID5S1kNrx41CNGwGm+E6n3Uj48/bgcq5mdlW8kPtn5g30pC15/XrJRUxnt2d
	 Z2Yg9tyNChrvObH8a4ctvBUn+t2zbzg3sNfCXLV0Gs5CALP8ZN1cTiNQxRQYtJ9YlbYaT
	 QObRKkUBTQbWaEHz+JqqGNiuR+Wng42rsjXZH/3j+AKhtOFiXQsJVrUbB/1uU7WkdLW+5
	 iHjrmI0g4hPJ5oMWOMueBfakk9q7VVwSN0fuyBcZ4w+B8AdBgkPvfCd5yqosWn4zPSClZ
	 SEdq66Dgd8ytKm57axdnt75hlA3gl3f44Lk60/Od5lIT5gN7hod95KKmD1bh2RRXQLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WRUhV0os;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6936606A338
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 01:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6936606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WRUhV0os
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso359986eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 18:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792547762; x=1793152562; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TnjCGHvcu9jfk9ulWt0hr+Q1cRLS9Qn/7cuD3nnKp4=;
        b=WRUhV0osHfCnIJxK+YSjMjcewTLJFLOAmoc0O3k6io5pk+CfStU+0kYetBIVXVHS0t
         Onyf487yGDejoBnff/H2r4fZloot0ueXh2HgmzD6B9mK4gHVqZHfJ0kf2maBU/RwsI2z
         tTBYaCSf3+T5m4hZYDAUyYfgTcd9r65hhvXXfVRvPKMOcbH2cIdh90HOgPgor2bJUuey
         BgOddfis7ZUrFZHAJ7OSgCynp1Ol/vvUoYuh4R2SKNWwF19zBqHOUKJsG1DoDjLGkGt5
         Tw2oCmVO3ZbmItlvj1c33tcybCfOATiaFqvD5wpjRrhadXFPDEQLYjIanOeJCe4/s0OZ
         zCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792547762; x=1793152562;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3TnjCGHvcu9jfk9ulWt0hr+Q1cRLS9Qn/7cuD3nnKp4=;
        b=rpwn9U9jeVG3qNsi8/a4IgyIppfqjhLRZ0zxaaMYmjZ8FM85zZlnJ01rHxkdnz48dw
         e/7wJTGOuuvA/X2o4nE5Z6dRoksXUQs2sxtZsUT/dk327wfEC/yBNfbNNeRKc0AvW4Lo
         JD1XY4/D0XtsLoMMxOrI6BXonIMF2kPBZMVDjsWEzfqdQkTssQ9nKuG8tjPdlvs0v78a
         bu9SN4W1WYVo7ShUb5HlsSICAIB5bxXykjlgcdC14snh06o8n3116ycKpEXQHaM5ZmL1
         83P97RZVr6A75CQyUZW4GpTBsTo26aC5uZCbRDLk4nRdw8lYnYPoetXbxRVi4aIODrES
         WO4w==
X-Gm-Message-State: AFq9FYJk0wRuIRe51Fp2fgLY/o4fWyOW76GTLsvR621mRwup8e4TzZKr
	irILqTNrukvao91Xofy5qHhaK33nOXQEprnQvbUTUn6tttUfA3wqZJnTRdLk95wfdDQIlKLKOen
	54SJERaX+xcod8+cD82BMrGsUy92ZkbikV+3qVcj5Od90U6ilNbyyajLcJ8s/WSDEr4WMGuRvk9
	cv5pHJ10MCqnFFMgB2Zc6Vceoab/Dh5XSvWG7Vl4t5FmCtIHkHgYAcbPt+Bl4enJo=
X-Received: from dlbsn13.prod.google.com ([2002:a05:7022:b90d:b0:14f:4204:735e])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:fe09:b0:14d:3c0c:79e9 with SMTP id a92af1059eb24-190a4a34b06mr1218747c88.11.1792547761552;
 Tue, 20 Oct 2026 18:56:01 -0700 (PDT)
Date: Wed, 21 Oct 2026 01:55:58 +0000
In-Reply-To: <20261021015558.4124825-1-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021015558.4124825-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021015558.4124825-3-almasrymina@google.com>
Subject: [PATCH net-next v1 2/2] netmem: rename get/put_netmem() to netmem_inc/dec_ref()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Ralf Lici <ralf@mandelbit.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Willem de Bruijn <willemb@google.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

Follow the object_action() naming convention for netmem non-page_pool
reference helpers by renaming get_netmem() and put_netmem() to
netmem_inc_ref() and netmem_dec_ref().

Use netmem_inc_ref() and netmem_dec_ref() rather than netmem_ref() and
netmem_unref() because netmem_ref is already a typedef (typedef unsigned
long __bitwise netmem_ref).

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/veth.c            |  2 +-
 include/linux/skbuff_ref.h    |  8 ++++----
 include/net/netmem.h          | 12 ++++++------
 net/core/datagram.c           |  2 +-
 net/core/net_test.c           | 16 ++++++++--------
 net/tls/tls_device.c          |  2 +-
 net/tls/tls_device_fallback.c |  2 +-
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 8746d0d1f5911..54fceb64f4268 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -751,7 +751,7 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 		return;
 
 	for (i = 0; i < sinfo->nr_frags; i++)
-		get_netmem(skb_frag_netmem(&sinfo->frags[i]));
+		netmem_inc_ref(skb_frag_netmem(&sinfo->frags[i]));
 }
 
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index f768a3fa1d606..b6f6da556ee90 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -18,7 +18,7 @@ bool napi_pp_get_page(netmem_ref netmem);
  *
  * Acquires pp_ref_count via napi_pp_get_page() if @recycle is true and
  * @netmem belongs to a page_pool; otherwise acquires a non-pp backing
- * reference via get_netmem(). Counterpart to skb_netmem_unref().
+ * reference via netmem_inc_ref(). Counterpart to skb_netmem_unref().
  */
 static __always_inline void skb_netmem_ref(netmem_ref netmem, bool recycle)
 {
@@ -26,7 +26,7 @@ static __always_inline void skb_netmem_ref(netmem_ref netmem, bool recycle)
 	if (recycle && napi_pp_get_page(netmem))
 		return;
 #endif
-	get_netmem(netmem);
+	netmem_inc_ref(netmem);
 }
 
 /**
@@ -53,7 +53,7 @@ bool napi_pp_put_page(netmem_ref netmem);
  *
  * Drops pp_ref_count via napi_pp_put_page() if @recycle is true and @netmem
  * belongs to a page_pool; otherwise drops a non-pp backing reference via
- * put_netmem(). Counterpart to skb_netmem_ref().
+ * netmem_dec_ref(). Counterpart to skb_netmem_ref().
  */
 static __always_inline void skb_netmem_unref(netmem_ref netmem, bool recycle)
 {
@@ -61,7 +61,7 @@ static __always_inline void skb_netmem_unref(netmem_ref netmem, bool recycle)
 	if (recycle && napi_pp_put_page(netmem))
 		return;
 #endif
-	put_netmem(netmem);
+	netmem_dec_ref(netmem);
 }
 
 /**
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 7f36c734edcd9..fb693bc1702a4 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -413,14 +413,14 @@ void net_iov_inc_ref(struct net_iov *niov);
 void net_iov_dec_ref(struct net_iov *niov);
 
 /**
- * get_netmem - acquire a non-page_pool reference on a netmem
+ * netmem_inc_ref - acquire a non-page_pool reference on a netmem
  * @netmem: netmem to reference
  *
  * Acquires a non-pp backing reference (page._refcount via get_page() or
  * binding->ref via net_iov_inc_ref()) regardless of page_pool membership.
- * Counterpart to put_netmem().
+ * Counterpart to netmem_dec_ref().
  */
-static __always_inline void get_netmem(netmem_ref netmem)
+static __always_inline void netmem_inc_ref(netmem_ref netmem)
 {
 	if (netmem_is_net_iov(netmem))
 		net_iov_inc_ref(netmem_to_net_iov(netmem));
@@ -429,14 +429,14 @@ static __always_inline void get_netmem(netmem_ref netmem)
 }
 
 /**
- * put_netmem - release a non-page_pool reference on a netmem
+ * netmem_dec_ref - release a non-page_pool reference on a netmem
  * @netmem: netmem to unreference
  *
  * Drops a non-pp backing reference (page._refcount via put_page() or
  * binding->ref via net_iov_dec_ref()) regardless of page_pool membership.
- * Counterpart to get_netmem().
+ * Counterpart to netmem_inc_ref().
  */
-static __always_inline void put_netmem(netmem_ref netmem)
+static __always_inline void netmem_dec_ref(netmem_ref netmem)
 {
 	if (netmem_is_net_iov(netmem))
 		net_iov_dec_ref(netmem_to_net_iov(netmem));
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 173b5d97bd409..ecc30a6f83023 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -735,7 +735,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 		size = min_t(size_t, size, length);
 		size = min_t(size_t, size, iter_iov_len(from));
 
-		get_netmem(net_iov_to_netmem(niov));
+		netmem_inc_ref(net_iov_to_netmem(niov));
 		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
 				       size, PAGE_SIZE);
 		iov_iter_advance(from, size);
diff --git a/net/core/net_test.c b/net/core/net_test.c
index 6fdab6a55b4d5..2b5080c226636 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -536,10 +536,10 @@ static void netmem_ref_test_page(struct kunit *test)
 	netmem = page_to_netmem(page);
 	base_ref = page_ref_count(page);
 
-	/* Layer 1: get_netmem / put_netmem use page non-pp refcount */
-	get_netmem(netmem);
+	/* Layer 1: netmem_inc_ref / netmem_dec_ref use page non-pp refcount */
+	netmem_inc_ref(netmem);
 	KUNIT_EXPECT_EQ(test, page_ref_count(page), base_ref + 1);
-	put_netmem(netmem);
+	netmem_dec_ref(netmem);
 	KUNIT_EXPECT_EQ(test, page_ref_count(page), base_ref);
 
 #ifdef CONFIG_PAGE_POOL
@@ -600,12 +600,12 @@ static void netmem_ref_test_pp_page(struct kunit *test)
 	base_ref = page_ref_count(page);
 	base_pp_ref = atomic_long_read(&page->pp_ref_count);
 
-	/* Layer 1: get_netmem / put_netmem always use non-pp refcount */
-	get_netmem(netmem);
+	/* Layer 1: netmem_inc/dec_ref always use non-pp refcount */
+	netmem_inc_ref(netmem);
 	KUNIT_EXPECT_EQ(test, page_ref_count(page), base_ref + 1);
 	KUNIT_EXPECT_EQ(test, atomic_long_read(&page->pp_ref_count),
 			base_pp_ref);
-	put_netmem(netmem);
+	netmem_dec_ref(netmem);
 	KUNIT_EXPECT_EQ(test, page_ref_count(page), base_ref);
 
 	/* Layer 2: napi_pp_get/put_page use pp_ref_count */
@@ -861,7 +861,7 @@ static void netmem_ref_test_net_iov(struct kunit *test)
 	netmem = net_iov_to_netmem(&niov);
 	base_ref = atomic_long_read(&binding.ref.data->count);
 
-	/* Non-PP net_iov: net_iov_inc/dec_ref & get/put_netmem */
+	/* Non-PP net_iov: net_iov_inc/dec_ref & netmem_inc/dec_ref */
 	net_iov_inc_ref(&niov);
 	KUNIT_EXPECT_EQ(test, atomic_long_read(&binding.ref.data->count),
 			base_ref + 1);
@@ -886,7 +886,7 @@ static void netmem_ref_test_net_iov(struct kunit *test)
 	netmem_or_pp_magic(netmem, PP_SIGNATURE);
 	atomic_long_set(&niov.desc.pp_ref_count, 2);
 
-	/* Layer 0 & 1: net_iov_inc_ref / get_netmem grab non-pp ref on PP */
+	/* Layer 0 & 1: net_iov/netmem_inc_ref grab non-pp ref on PP */
 	net_iov_inc_ref(&niov);
 	KUNIT_EXPECT_EQ(test, atomic_long_read(&binding.ref.data->count),
 			base_ref + 1);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 2382d00aef8fc..1a5f328d80a50 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -143,7 +143,7 @@ static void destroy_record(struct tls_record_info *record)
 	int i;
 
 	for (i = 0; i < record->num_frags; i++)
-		put_netmem(skb_frag_netmem(&record->frags[i]));
+		netmem_dec_ref(skb_frag_netmem(&record->frags[i]));
 	kfree(record);
 }
 
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 35cc510db4321..b547027cc879f 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -256,7 +256,7 @@ static int fill_sg_in(struct scatterlist *sg_in,
 	for (i = 0; remaining > 0; i++) {
 		skb_frag_t *frag = &record->frags[i];
 
-		get_netmem(skb_frag_netmem(frag));
+		netmem_inc_ref(skb_frag_netmem(frag));
 		sg_set_page(sg_in + i, skb_frag_page(frag),
 			    skb_frag_size(frag), skb_frag_off(frag));
 
-- 
2.56.0.212.g129ede20d9-goog

