Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6529A435529
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385400; cv=none; b=CwsVFL+plmnRAyKMAShFM0Wxbko29OccRjTwDz+Db7ACPy3HwJZzBVb8fiojt5p/ObnSfbgPEnR5A00AKHgJwLWmyKs42IxVNYvWrebZiXl6ZuzsCBQX/t2HZQzjwF94DU/FJsm8H2jt3wdqbPKm3Kh7AEElF6SalhHXFcksUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385400; c=relaxed/simple;
	bh=x7tIsrbMyUPwgd1k03RHVrZSUrj+/5nLv/vrSIRF7kI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gqGbISchzuFGNUvNWaWBDL570meqHAaGFcX7Q4drQT3DEa119Z1nxOLHFpZFlNTL0aymx5B46DMRCzj74FVPxYqGxEzBLSISYuJKtv7D2J4RGcANoYV8f181816oBaWMd0m0/p42g9ib/qeADTwHyOFrXM1AsWHHzYc99zqjjeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+upRU50; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+upRU50"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc6dd43737so52856015ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786385397; x=1786990197; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XKDruZQ0TN5xeCIrhjnVIOzXHZSGCKivlM0ICoimkCg=;
        b=e+upRU50eGGwmvtVtyt44gnQa71k0YE7umS8uosTmTkb3OZCkbNfLfQCRg6rcOKzKX
         8mZsqzPAR7qBOBzxiRSj3w/zZTqeLVGWylfXfjGCR9HJE2rHAwLA9R8tjFajycIpGrGs
         dr6q1gfWSgNzobpP+VUdsWfGpvAepk/trfPH6Yj+D46ZymvV/T8mwXDbyBWF7oezEkrS
         Y9dzQbMrWIRZyiqw5ps9spcOaa57E6uCZ3X+bfD1Mb969Jve+9PY2U2cRUnQgn97Me7T
         mmSabipLYtCy7QWhhPEpKxWq9tHQMtGeX022hShuaC7yu4uXEwHQ6BU4ky0cCLJpUatL
         Pnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786385397; x=1786990197;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKDruZQ0TN5xeCIrhjnVIOzXHZSGCKivlM0ICoimkCg=;
        b=VIt1A2cCM4nvmdCzkYdh0CDUopgoVQcEiPLBILWU75ZA1hjsEUcnztu8NeBvi20y6i
         ythQ+zj0NT8U//tNMfdrVAweM9BhDAsX0wbYUhvUVKwxfFhVZ8gEUz3ViwClm7CCe7nV
         Qm3HE7H3byhyDc69ZWoNvBFONbYnEl/4Hn/MVqjowER4qJ3wWc7BTas6KtmTVdNqsJW6
         OuGFc0ILo370ezPCNSE6y4QTAPhCIAtNoAgy+lQ1qpSjWPMm8IipISsyYUZNcABXiKQU
         ExATjTlShemu7W63LzYXxftlITOXYcLeUcfxtKNSNKIFFInuTucG4i5LhriHXM5pXavc
         jk+g==
X-Gm-Message-State: AOJu0YwXLXcjL2WwpN8zPvMfFmcp2JfntNFWesPeyLYB/3v+nZ14bRQd
	VIp2Y95aIGthl0+yYFIAEo/GYCbv/in1Ia5+taMOZoI0qnLvX/ZAynYRvBzSYyC/ao3noQlSPSp
	jPhKSssSZYuhsJD4rZw4O91rbgxH+ztjbW4dlKOaZJy7K0Gvd4PQr1ebic79fjNXUNE9EN52she
	5pSyAE9Ylm1YP0qZnSpPh+jk1ALZE/fxSQszLqNCuWPVjwLP/OW7+K5A2t00XX5uI=
X-Received: from dycog4.prod.google.com ([2002:a05:7301:9a84:b0:313:cf74:cf85])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d58e:b0:2c9:e835:ac67 with SMTP id d9443c01a7336-2d0caa03d1fmr563084775ad.19.1786385397137;
 Mon, 10 Aug 2026 11:09:57 -0700 (PDT)
Date: Mon, 10 Aug 2026 18:09:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810180956.2348280-1-almasrymina@google.com>
Subject: [PATCH net v2 1/2] net: core: propagate unreadable flag in skb_zerocopy
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dev@openvswitch.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"

skb_zerocopy() fails to propagate the unreadable flag when copying
devmem fragments, causing target skbs to appear as readable memory.

This patch fixes the flag propagation. Additionally, it returns -EFAULT
if standard payload is mixed with unreadable devmem fragments during
extraction, and clamps unreadable skb lengths in openvswitch
queue_userspace_packet() to avert truncated invalid payloads.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Aaron Conole <aconole@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

---
v2:
- Return -EFAULT when mixing unreadable and readable frags (Pavel).
- Clamp unreadable skb lengths for openvswitch queue drops (sashiko).
v1: https://lore.kernel.org/r/20260801125308.1342897-1-almasrymina@google.com

Openvswitch maintainers: PTAL at the openvswitch changes closely. They
are reported by sashiko as an also-need part of this fix:
https://sashiko.dev/#/patchset/20260706155219.23757-1-fw%40strlen.de
---
 net/core/skbuff.c          | 13 ++++++++++++-
 net/openvswitch/datapath.c |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ba3dbac80fb49..d21af68156950 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3870,7 +3870,8 @@ EXPORT_SYMBOL_GPL(skb_zerocopy_headlen);
  *	Return value:
  *	0: everything is OK
  *	-ENOMEM: couldn't orphan frags of @from due to lack of memory
- *	-EFAULT: skb_copy_bits() found some problem with skb geometry
+ *	-EFAULT: skb_copy_bits() found some problem with skb geometry, or readable head
+ *      payload would be mixed with unreadable frags.
  */
 int
 skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
@@ -3905,10 +3906,17 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 		}
 	}
 
+	if (!skb_frags_readable(from) && j > 0 && len) {
+		put_page(virt_to_head_page(from->head));
+		return -EFAULT;
+	}
+
 	skb_len_add(to, len + plen);
 
 	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
 		skb_tx_error(from);
+		if (j > 0)
+			put_page(virt_to_head_page(from->head));
 		return -ENOMEM;
 	}
 	skb_zerocopy_clone(to, from, GFP_ATOMIC);
@@ -3928,6 +3936,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	}
 	skb_shinfo(to)->nr_frags = j;
 
+	if (i > 0 && from->unreadable)
+		to->unreadable = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(skb_zerocopy);
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index ae69b2cabab9e..7c663d7846174 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -480,6 +480,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	}
 
 	skb_len = min(skb->len, cutlen);
+	if (!skb_frags_readable(skb))
+		skb_len = min_t(size_t, skb_len, skb_headlen(skb));
 	if (nla_attr_size(skb_len) > USHRT_MAX) {
 		err = -EFBIG;
 		goto out;

base-commit: dd057113ac7ba5bdd2aed3d9405305911152f911
-- 
2.55.0.679.g6767b8d81c-goog

