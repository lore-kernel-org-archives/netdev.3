Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C33D8903
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621586; cv=none; b=BKHZwUQdx8oezyqw5NiUHHhlgFkUyMHAL5GWSQqOquZ5TtsDa7LCkmCBWJRQIZzEdmZn+zuXftDtcVKFKJDTp7epw6Jdbfs0iBJ3NSRlEwicVTw1NLxguyyggX1XQO2oSgkibc4UezsV/KU3DyJ0r9VQVhUkc2krSAJz7kr3tPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621586; c=relaxed/simple;
	bh=/LLvU+5AnYzTjy57lN2tpyIzvmdHROTfxW0jkjFEfuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QZyLaRJIGQ2r7AKbVOnKxKbiEqoIjy5LG6njx3mluCC5V9RWRQTIcMIHXPgso2Uxbyfohlt6T6m2rdbZ+eoXO+JcXhVsPIKmrHDV0xtGKezbvX5HD+o0a8YPV3hqFx4tKZrLFpED4WcaGuJ0j6POXi7p64jehjFe57CAUHjdyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dlPpSfmU; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dlPpSfmU"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-358856e5105so1349747eec.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791621580; x=1792226380; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMs6zujZVOhihfnpjH1h+iJn7PnD9P9Ohm7NiW91TsM=;
        b=dlPpSfmULiFiON0icXljxQWbgzaOtv3rM42WB0uaZoZtNCriy5hvcJu5mNZV3L1u9b
         lzazIw07/CT5fGccBcbAMduVypLd75/fEDigHntkcP++BeMqdlvnzLPV+BI0JN0YYLeL
         N3jzdPV2WnYhHCAanJBhmLr3Pm8Z7yPEIO1e7eftEVP0RT3CZmdVEtEZAy86xmdi5UhJ
         NJXcg4zfOy25E3p4rTbBk7yrG9fz5F/Gy1zu6TB7Zfwpz5c97I6xxVVMQUyk7XFEAlMg
         qYrYk3iRkt8XLqzxRm2fZ7qribJDNWiamO8FMfW+o9zc1QCHm7s0Qwh62MbHvVZaKwtM
         g/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621580; x=1792226380;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMs6zujZVOhihfnpjH1h+iJn7PnD9P9Ohm7NiW91TsM=;
        b=fN1/JOYHMY9NxWiCzDUmOl7rjKmadC5OdGoeaz+aYu2SQGA8lsj/WKj7dJwUq3KvAH
         jw1nVtn3YxbloNJCNZNMmVgFh7nzzM229J5nKQA45yYctMucmai9KEgGQbA6qX8Z99NG
         znCcIfqtGijUHsplkZqh0vrWNzlXu0Ug2ECOX3iRLE6v2EoTVmxhLyHBUyQQQTgORfFC
         1/5QjzO8SMmBR8VJ1TI/g0DdKNqY2V0JXV+KoM3MS05MTRAKpFWKOVrhCiOCnPpr7Dy7
         femqskZLONZIZDlGL8T66x88iJ7ogA4W1pGrOiUkIx2j3YWP3/yzw/H90Z34pw4K8Fx7
         mfGw==
X-Gm-Message-State: AFq9FYIEap9C9Iz99D1nGoGN8sMPZNb7u0l5aR+c41dAndstqjj3Qgm9
	73NUwocz0Gxl1jclXr4rx8kuel/4lNVvxAs/ySxILmWofp5oKS8AeivLyqbeIMYyYZzFGSTA/oj
	0nI/cxdVxydJc6n7x2KyRO9U99oDyJQ2ltKxsCb3azeWLUmptI0Gml2k0AwZeyzuWdblJnz/oU7
	nDDd3h1jzHjib13eB6tTCv/vYLh6q1+cP8V1DS4SspFvDV7fc6hHjreRPK3dZM7WM=
X-Received: from dycc9.prod.google.com ([2002:a05:693c:60c9:b0:351:4a84:2505])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1a05:b0:358:eccb:af7c with SMTP id 5a478bee46e88-358eccbc89dmr38890eec.33.1791621577801;
 Sat, 10 Oct 2026 01:39:37 -0700 (PDT)
Date: Sat, 10 Oct 2026 08:38:43 +0000
In-Reply-To: <20261010083935.3274178-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261010083935.3274178-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010083935.3274178-3-almasrymina@google.com>
Subject: [PATCH net-next v1 2/6] net: skbuff: add napi_pp_get_page() and use
 it in tcp_recvmsg_dmabuf()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Michael Grzeschik <mgr@kernel.org>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=" <u.kleine-koenig@baylibre.com>, Petr Machata <petrm@nvidia.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Jakub Raczynski <j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"

While napi_pp_put_page() releases a page_pool pp_ref_count reference on
a netmem, no symmetric helper existed to acquire one, forcing callers
like tcp_recvmsg_dmabuf() to open-code atomic_long_inc() on
niov->desc.pp_ref_count.

Add napi_pp_get_page() to pair symmetrically with napi_pp_put_page(),
and use WARN_ON_ONCE(!napi_pp_get_page(netmem)) in tcp_recvmsg_dmabuf()
to match WARN_ON_ONCE(!napi_pp_put_page(netmem)) in
tcp_release_user_frags().

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/skbuff_ref.h |  2 ++
 net/core/skbuff.c          | 31 +++++++++++++++++++++++++++++++
 net/ipv4/tcp.c             |  6 ++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 05c8486bafac8..0441c220fdbdf 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -9,6 +9,8 @@
 
 #include <linux/skbuff.h>
 
+bool napi_pp_get_page(netmem_ref netmem);
+
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b459264ba5180..8a8be746828db 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1026,6 +1026,15 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 EXPORT_SYMBOL(skb_cow_data_for_xdp);
 
 #if IS_ENABLED(CONFIG_PAGE_POOL)
+/**
+ * napi_pp_put_page - release a page_pool reference on a netmem
+ * @netmem: netmem to unreference
+ *
+ * Drops a page_pool reference (pp_ref_count) on @netmem if it belongs to a
+ * page_pool. Counterpart to napi_pp_get_page().
+ *
+ * Return: true if @netmem belongs to a page_pool, false otherwise.
+ */
 bool napi_pp_put_page(netmem_ref netmem)
 {
 	netmem = netmem_compound_head(netmem);
@@ -1038,6 +1047,28 @@ bool napi_pp_put_page(netmem_ref netmem)
 	return true;
 }
 EXPORT_SYMBOL(napi_pp_put_page);
+
+/**
+ * napi_pp_get_page - acquire a page_pool reference on a netmem
+ * @netmem: netmem to reference
+ *
+ * Acquires a page_pool reference (pp_ref_count) on @netmem if it belongs to a
+ * page_pool. Counterpart to napi_pp_put_page().
+ *
+ * Return: true if @netmem belongs to a page_pool, false otherwise.
+ */
+bool napi_pp_get_page(netmem_ref netmem)
+{
+	netmem = netmem_compound_head(netmem);
+
+	if (unlikely(!netmem_is_pp(netmem)))
+		return false;
+
+	page_pool_ref_netmem(netmem);
+
+	return true;
+}
+EXPORT_SYMBOL(napi_pp_get_page);
 #endif
 
 static bool skb_pp_recycle(struct sk_buff *skb, void *data)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f4c9101e5996a..99d7237a623d8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -254,6 +254,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/skbuff.h>
+#include <linux/skbuff_ref.h>
 #include <linux/splice.h>
 #include <linux/net.h>
 #include <linux/socket.h>
@@ -2559,6 +2560,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 		 */
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			netmem_ref netmem = skb_frag_netmem(frag);
 			struct net_iov *niov;
 			u64 frag_offset;
 			int end;
@@ -2612,8 +2614,8 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
-				atomic_long_inc(&niov->desc.pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+				WARN_ON_ONCE(!napi_pp_get_page(netmem));
+				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = netmem;
 
 				sent += copy;
 
-- 
2.56.0.385.gd3acb90ef8-goog

