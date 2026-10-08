Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F79372071
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430795; cv=none; b=UQZ3Dww7NskGc9BtxNDq6H9MuY+bCjIr8r3uj9HKRsZ5L8waptFL0HjWM3+az2IGRtL464cuD+IaD2ZYj8CkZESMp+QsklvBbMvgNlQtqMljzKniQLlR76q8fpC7A06Ld6gPT5K4zOvOyLkpswr6k4gtRKRUsIHTPA1leHCsKGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430795; c=relaxed/simple;
	bh=hrTmsIBbiGmKQOjn02ezrfotZmF8vX/5RB2XjzX5QhA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UlIJIobDn0jDzFHCRk8QHAaOfuRHzetsmS6YAmZbJicBO0rypSQymSZ6CRqkWCzXb62XcMIWliBuCsMXE3fSvHELHPXOIvrDEl51zyi/14/7cZeQA5nAN7NYP/yamd7sBpDSXlNFhTUggS5o/7ettX6fe9JDkJ2/BhEZLo8klqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKC5um8E; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKC5um8E"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so9800795eec.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 20:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791430793; x=1792035593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4HwPYJFKEdiyX4935OotxW9r3+hcqkRnlBB6xoiIvRU=;
        b=dKC5um8Ew0EXtAKrVMiXwo4lW77Hz2kS+RTvXq2Btwh4ln2TT8Lejy+sr/grZvUDOK
         vDdMNzJOZeAkHkVjEaiClyEIdUpv4bVwah55/4L3hwBWIqqTPcVBWO+rNcpDtaezG2fa
         IXI8+7SeKx838OC0pv6TNHIdq/SU/YmFlFXhK5L6ohHYGPxGSVpd5TQWH+gNrpx+Dn/V
         dCben5B3osaDM0cyQsxIgqIZZ5CorKNcxCgNn59e0UrKVpcMBSLw+C4A940viSDSV6x2
         ljp47MXnt6evOYgsxQloCnvUlMBQ6a+1f3Vm8RK95BAPrfvGdCKlFvqiOIi83zUiCLMM
         SyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430793; x=1792035593;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4HwPYJFKEdiyX4935OotxW9r3+hcqkRnlBB6xoiIvRU=;
        b=P6EQfhjVFvzYZNmMhVND5zOw6JAQPelQLOK9uONCZnLmcuhWgmCSGGgIEF7PvnXj/S
         snflvRwGj0fGTihFZ5cZBGIFRaFM6+wKVsfR08C/DBBocNEvLvKlfDYUM3hPA7LxTafQ
         JSk0f7RMyb+Cl9PcDwaDMW2Ofk0GGloH6w4yvFSQK0l+MBmofj3WUh3oM8p6tCvRYvTX
         8OmGQ82fjkCp6cugMUmsYFtW933MMXtmt2Z8r/Qu2Qkq03BtOk0YOer+e2NuUhsqDea+
         taBkyUHWNNk1PCK5mlr6ucnEesTWsmGNbx09ei5RWTvC1F3bKoNZJAjCNIFF0A94CB88
         V0vg==
X-Forwarded-Encrypted: i=1; AKwUvBybkA51uG/57Hi18G3iPJGkiyAEkFumf0bev0WpUiQMrSBIFXFMpDRqjLBqf7ffxuvFWGDOrCs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1HC/98dBRMDsQhed39iahN6ePvDnd/RCgvv1fJ4thX/hj+IKr
	VIP6j6UXsCtmYAkuM6E7QqhHQ8mek5yPCcr9GRFE/50ZF6NLS0sBVxxwZJCIlIzo7LYoHKeDzgH
	xX4G8gfaP/92QPUbtKMivmDm22A==
X-Received: from dyblz13.prod.google.com ([2002:a05:7301:160d:b0:34b:8a3f:5aaf])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:8809:20b0:351:68ca:62ac with SMTP id 5a478bee46e88-35168ca688cmr3181178eec.37.1791430792793;
 Wed, 07 Oct 2026 20:39:52 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:39:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008033952.1399670-1-almasrymina@google.com>
Subject: [PATCH net v1] net: devmem: prevent mixing fragments from different bindings
From: Mina Almasry <almasrymina@google.com>
To: Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Ralf Lici <ralf@mandelbit.com>
Content-Type: text/plain; charset="UTF-8"

validate_xmit_unreadable_skb() only inspects shinfo->frags[0] and
assumes all fragments in an unreadable skb belong to that same devmem
binding. However, tcp_sendmsg_locked() only checks that readability
matches the presence of a binding (skb_frags_readable(skb) != !binding),
allowing consecutive sendmsg() calls with different dmabuf bindings to
collapse into the same skb and bypass per-device and unbind checks in
validate_xmit_unreadable_skb().

Add net_devmem_skb_binding() to query the binding associated with an
skb, reuse it in validate_xmit_unreadable_skb(), and check in
zerocopy_fill_skb_from_devmem() that existing fragments match the target
binding.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/datagram.c |  2 +-
 net/core/dev.c      | 14 ++++----------
 net/core/devmem.h   | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 173b5d97bd409..ed8f1045f3cca 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -712,7 +712,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 	size_t virt_addr, size, off;
 	struct net_iov *niov;
 
-	if (i && skb_frags_readable(skb))
+	if (i && net_devmem_skb_binding(skb) != binding)
 		return -EFAULT;
 
 	/* Devmem filling works by taking an IOVEC from the user where the
diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360e..ad2b587dfee27 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4054,8 +4054,7 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
 static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 						    struct net_device *dev)
 {
-	struct skb_shared_info *shinfo;
-	struct net_iov *niov;
+	struct net_devmem_dmabuf_binding *binding;
 
 	if (likely(skb_frags_readable(skb) ||
 		   dev->netmem_tx == NETMEM_TX_NO_DMA))
@@ -4064,14 +4063,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	if (dev->netmem_tx == NETMEM_TX_NONE)
 		goto out_free;
 
-	shinfo = skb_shinfo(skb);
-
-	if (shinfo->nr_frags > 0) {
-		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
-		if (net_is_devmem_iov(niov) &&
-		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
-			goto out_free;
-	}
+	binding = net_devmem_skb_binding(skb);
+	if (binding && READ_ONCE(binding->dev) != dev)
+		goto out_free;
 
 out:
 	return skb;
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 4a293a7d1149c..8c74037633ae8 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -10,6 +10,7 @@
 #ifndef _NET_DEVMEM_H
 #define _NET_DEVMEM_H
 
+#include <linux/skbuff.h>
 #include <net/netmem.h>
 #include <net/netdev_netlink.h>
 
@@ -118,6 +119,22 @@ net_devmem_iov_binding(const struct net_iov *niov)
 	return net_devmem_iov_to_chunk_owner(niov)->binding;
 }
 
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_skb_binding(const struct sk_buff *skb)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	const struct net_iov *niov;
+
+	if (skb_frags_readable(skb) || !shinfo->nr_frags)
+		return NULL;
+
+	niov = skb_frag_net_iov(&shinfo->frags[0]);
+	if (!niov || !net_is_devmem_iov(niov))
+		return NULL;
+
+	return net_devmem_iov_binding(niov);
+}
+
 static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 {
 	return net_devmem_iov_binding(niov)->id;
@@ -243,6 +260,12 @@ net_devmem_iov_binding(const struct net_iov *niov)
 {
 	return NULL;
 }
+
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_skb_binding(const struct sk_buff *skb)
+{
+	return NULL;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */

base-commit: 6d25ffca055a77787c21a36b66c253f76239411b
-- 
2.56.0.385.gd3acb90ef8-goog

