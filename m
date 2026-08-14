Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E672495047
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734822; cv=none; b=o0EfhYCsvuG93Vdwrw2hG9UQBvrXgBSJGQmLpfelLoameAl+AXV1rOrlJCrnwCgZeAC0kbgAPVp5gDtIga03KSorVWtzczZep1zj9JcECkXu1AJn8mcvLMKH6mu66xTiz1WcRDNMaLEWbggE5RgA+Z1Synyrkk2l6msfOLoQz+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734822; c=relaxed/simple;
	bh=8psm+vfJeN5Sa6df/bJ4T2K8atloHaVdU6/1VgSOj/g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZDMd3djeAcuJ1O5Oth+s8IXyWfE4QZL70dfI/0tIDZ8xaznDTNsno3puF1AXbLPbwJdAlCMLVzMqqJdnerbbcHxloEhyTukhaTQzvc8QJzeWPfm6BbbDgZBk/GUMyCxuv5v85aRVVeKABLnyYsgoHWp2kXMknrOB3zWmk5nASu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sz2p3A5Y; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sz2p3A5Y"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so1546387a12.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786734818; x=1787339618; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OI+1skUob0SWIdAwytp9RXQE8P/u0Lcv+pNJU3Jw3Ls=;
        b=sz2p3A5YsN0S9OKC3WgyTID26+HvKGlPmNqJ0NUVrKPK6xvfe8JYm+jYI11LIemxhf
         Dk/D4kG+sydNZyashPGc1vwAonblWnQhdKzIjQ7LjbZktE6Ryzc6ZkVnxMCSW3juU068
         njAPx0kHUQQiVvW44w0CS45NUS3y2XAg7ddkvMdn/hZgkzknhvReSY346jW/umyhHJ04
         KJCxr3GTwc83XhNdLssIVQyXWgUuzfUpMNXfkRmakBjgzs67uCFOkSpTwIGhfCTCWmmu
         8EfF/yHcB2KrcTyDXZq1RDObyzE/pHg5KrYijJ1Zy1ruhsJPV/83TamNturLgvJC0hCl
         H1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734818; x=1787339618;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OI+1skUob0SWIdAwytp9RXQE8P/u0Lcv+pNJU3Jw3Ls=;
        b=kFDRDgBa1FZJvHXamO7ahTmxMVJhEQFCm7Swsa5xSv5r6XZTUkDrxgVYhhpmGBqN1h
         hJCql7Si2xBSo6k5YM93X1gDJJdo0XSBLuV32+cJQ+8gt8x+JWAvCcLk6o+Nqnb3pvQ8
         a66UpFk4JSYM8U3y7Xrgm4KHej/H3QQzlr7hRZnaq+jdEBpHrMQJvtCQuvDXvsDke7tp
         X/ma3Hdas1D6Kuz+/Q2loY3C9Iea5G8FKMR7p4SJkmaIMpXzN9IlHmnjroiQo78zkqAX
         viq7EnvaAa4Z6z8bZMw3DaIkvVHB+IBzH/19K4ofZShsgYDxfsm2ARks/yLP1QPckY7C
         CDpA==
X-Forwarded-Encrypted: i=1; AHgh+RpmFcXnl3XrtiHnrb30rz/5LcvLCnqd1HJTGmwjCh9HLLdFJKOCNW1scuSO9EAxFJ/1U8G9kmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAaUx9U4NfwBaRqU7j5lSva9HCAtTtPjuBJWhX9Cgj5P/NNzVg
	OTa5OFjCvzDrIIZ8GngqLB6eyDhZQnqdpnDb2zdXfAPL1tWhgSh2tcfE12WhDHDRpndx0A2Jt+m
	LnofyeF3xtDlFq5SVUs3R3o0qtw==
X-Received: from dybvt10.prod.google.com ([2002:a05:7301:78ca:b0:313:d014:d248])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2443:b0:3c3:9070:96bf with SMTP id adf61e73a8af0-3cc71b60f1emr8183683637.9.1786734817521;
 Fri, 14 Aug 2026 12:13:37 -0700 (PDT)
Date: Fri, 14 Aug 2026 19:13:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814191336.187243-1-almasrymina@google.com>
Subject: [PATCH net v4 1/2] net: core: propagate unreadable flag in skb_zerocopy
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, 
	Mina Almasry <almasrymina@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dev@openvswitch.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"

skb_zerocopy() fails to propagate the unreadable flag when copying
unreadable fragments, causing target skbs to appear as readable memory.

This patch fixes the flag propagation. Additionally, it returns -EFAULT
if readable fragments are mixed with unreadable fragments during
extraction, and returns -EFAULT in openvswitch queue_userspace_packet().

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Aaron Conole <aconole@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
---
v4:
- Changed commit references from payload types to readable/unreadable
  fragments.
---
 net/core/skbuff.c          | 13 ++++++++++++-
 net/openvswitch/datapath.c |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

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
index ae69b2cabab9e..482893a5f67dc 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -467,6 +467,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	if (!dp_ifindex)
 		return -ENODEV;
 
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
+
 	if (skb_vlan_tag_present(skb)) {
 		nskb = skb_clone(skb, GFP_ATOMIC);
 		if (!nskb)

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.55.0.691.gc56d675ccc-goog

