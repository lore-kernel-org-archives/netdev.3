Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BA35E936
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430831; cv=none; b=dF4I0v/0HzdYq6xwPWnF7ZmtkSJG1LumYSDxS1IV38R/8CsKQV4VT2/qK6hJwj6l1AHcDqd1calBuHBPtmHE5CPcAWEnorTBWqMr6MxHvi0MhXkOyWSiWb4oa5KKYl2Ft/eRH1q8otcXZp83CopuhXGglsOPCEB4L45nuaIquIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430831; c=relaxed/simple;
	bh=hrTmsIBbiGmKQOjn02ezrfotZmF8vX/5RB2XjzX5QhA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pcawrbsg5+iBWLNKaQomOjqbcY6+yI6UKYIc+4Inn8pD1DWdM20MWcksU6600dW/iW6i5vo+YR0zy0CYigOdYqx2cAPKg7lU6o95GoISe50umW/qT87GFUPfWeca7bubO6pECqsSFGDW3rJ2TU+TJv52gLUqlozNB4JTNwdb2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHkkdScq; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHkkdScq"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-351788121cfso1477678eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 20:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791430829; x=1792035629; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4HwPYJFKEdiyX4935OotxW9r3+hcqkRnlBB6xoiIvRU=;
        b=LHkkdScq6uzXozHIJBnIIMqQ2J9jfS7swumkyAo5RqEuQVt2AA02IoWv5W0c6gf4ka
         pSMnD52fZDDt0BGXA5gfIGzdCGFyGxgplzCP90TxkejQqR5FmDp/xLERenEHSy0RGVOr
         S/0lAcZay5ejr9Aw9DV6VziDGJL2KC3jRNn/0PJzYvvIQgvxgKzQewjjlRvNkVWZAEL3
         MM/+Or2NfoPP6PKOcSpflvVfP+BPPklocVBbBoV+KFCsb5PNI+qTtgiQBZ7qiMGbhvED
         +2r45tKK4b704c80tb7dmQX4UrgGYanuZ7tiWd4wM8Bq8W7IRM59fDe/1nmd/4nKlb4H
         Pl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430829; x=1792035629;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4HwPYJFKEdiyX4935OotxW9r3+hcqkRnlBB6xoiIvRU=;
        b=Nl9vb4Ln/ZzAki2jJ4d50I9mqk0QJtJM+FW4S2cIo8ZnaDAWPiUlTwohzNDVgAnJVN
         AIpjxWP/nQJRI3/rffuZJmk0caYtAvmFXfPxDQLxYLOvFuEGJFKkTUzv6BLgpfXcd6h7
         ByehlfpA2I7x+Rqdp++bLRF12FuFfWmda6UMDGRI56DSOWv1lseosdVWYxOD21QtR/Y+
         3r+XNhNuBq0vRW8lK2TLvV5vMPOHlK/n3qXoBnxDLl3BBbSsZOyv7ZpsZ8RdFo5npplv
         LloXJUf22zRXQLfwIGzhpSPyoRax6vajtKD/nCCLRniptGmFuHBNAahgDSD0j1wUMiu4
         cfcw==
X-Gm-Message-State: AFq9FYKouYjohrCfEhzaD8Mnb7CTga1m9M0irF3cBfQmSbXuziKWOyWS
	YRlQDJa/41repBbhHiN3pL+VRdMqmohRztGUaeX+I+lrGTHSq1/UD/olZXf6ilfyLLJW84ZtRqE
	raYa71NueIf9FTiXBXcKR5gQfVF05sX73MaTFZ2kWLG82z6AuccmwDakCKHMkQfctPOldoAGIjs
	7eNFTCKaN/ERWHOTDNxPKn5VQ5V2HIDRDkokMQ1xvyPsCzXNq99ZHeH579wNDB3eM=
X-Received: from dybmn3.prod.google.com ([2002:a05:7300:d203:b0:351:79dd:52dd])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:8617:b0:351:11aa:5d5b with SMTP id 5a478bee46e88-3515dde8bbbmr4820551eec.19.1791430828091;
 Wed, 07 Oct 2026 20:40:28 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:40:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008034027.1403188-1-almasrymina@google.com>
Subject: [PATCH net v1] net: devmem: prevent mixing fragments from different bindings
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Antonio Quartulli <antonio@openvpn.net>, 
	Pavel Begunkov <asml.silence@gmail.com>, Ralf Lici <ralf@mandelbit.com>
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

