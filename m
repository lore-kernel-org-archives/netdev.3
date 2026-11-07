Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794059458;
	b=knqy7OKXzflTWHwzSXT9KTkwydTVQ2xkzJ48/b/pmIy9xiOsWx+TKSCIU9YXnZAn2X+V
	 U6Nn77YTWE7DogskB4f3wcUgc/U3aRZgxhneNL4HH3YHZTNdJHHb/2z2hBtf31xtt3N6I
	 8o0eJN3FQLX7WOBqyo4jcbF5UKSwZT34dT2Vo0h10XjxGczu4a1qkivGZwGDtAPwiKXOJ
	 j/B9UllRVeV/Bo/MPu8dowmezmR2gW/KWfbFU8u3zm5HPZ0kOi7BnPmg4yMRNPjoZgK5J
	 +uJ0YwicnB5vSVYwHKoobuc/v46gfF2D4hfPQCWYZSO2I/ASzilHYh4eSWD+mo13oEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794059458;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=yv1aNjLkbAl4fTpgBXhNWf1+G8wEj5mdyEs/bUbPwEI=;
	b=1nvsIlBhKV2oMCWmMc4nqYbaCun0V5XnCE2py2z8a61FBlTGGHZt3jVpNhAps/Jzcxjv
	 e+fmfE1hSU0QFx4nxHdNZrHaLnOciGSEc715hvSaZf8a5vIhnTorG+MWUdfRHmU2VBWUi
	 0DZqzMCmmkVRzSyugD/h169nZdSwX29oIbSql2/Sip8hIWOpMpMPqoK++xSRVXM8g5Pn+
	 b+GRdQtkj1dAcnjQ5nknoX8vZVd7uTSf5g9mdfGanAnhGa7/sQET9PrD7F1JZ1j1QM4NR
	 TfaaRdf8W5LJ7Wdnz3D/WLTeYRr3/fjG80z7jSRVwhmvqFnuj4V5N7GpuKhooWtLSMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512A606A330;
	Sat,  7 Nov 2026 13:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D512A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jMHWL4KG0z8XrrJ;
	Sat, 07 Nov 2026 21:50:54 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A7DonWa001651;
	Sat, 7 Nov 2026 21:50:49 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 21:50:51 +0800 (CST)
X-Zmail-TransId: 2afb6aef2cbb3ac-e1dfc
X-Mailer: Zmail v1.0
Message-ID: <20261107215051120CrLjo_cGXWfdJxXk4ae8s@zte.com.cn>
Date: Sat, 7 Nov 2026 21:50:51 +0800 (CST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
Cc: <horms@kernel.org>, <josef@toxicpanda.com>, <willemb@google.com>,
        <almasrymina@google.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBuZXQ6IHNrYnVmZjogZG9uJ3QgQlVHKCkgd2hlbiBza2JfY29weV9iaXRzKCkgZmFpbHMgaW4gX19wc2tiX3B1bGxfdGFpbA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A7DonWa001651
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 21:50:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEF2CBE.000/4jMHWL4KG0z8XrrJ

From: Shao Mingyin <shao.mingyin@zte.com.cn>

__pskb_pull_tail() BUG()s if skb_copy_bits() returns an error.
skb_copy_bits() fails when the lengths do not add up, or when a
frag_list child carries unreadable frags (devmem net_iov, commit
65249feb6b3d ("net: add support for skbs with unreadable frags")).  The
top-level check above does not cover frag_list children, and
skb_gro_receive() links them without propagating skb->unreadable, so a
mixed skb trips the BUG().

Nothing has been committed at that point, so return NULL the way the
rest of the function already handles failures, with a
DEBUG_NET_WARN_ON_ONCE() for debug kernels.  skb_condense(), the one
net/core caller that ignores the return, now checks it and keeps the
original truesize when the pull fails, as the frags are still there.

The other direct callers that ignore the return do not build a
frag_list child: xen-netfront drops the skb when the failed pull leaves
nr_frags at MAX_SKB_FRAGS, and niu, mlx5 and ftmac100 pull at most what
their own skb holds.  A length mismatch there is a driver bug, which
the debug warning reports.

This is the separate change that commit 279877d86c82 ("net: skbuff:
don't BUG() when skb_copy_bits() fails in copy helpers") left for the
callers; the audit is above.  No Fixes: tag and no stable marking: the
mixed skb is an invariant violation, not a regression, and this is a
net-next hardening in the BUG_ON() removal series.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 net/core/skbuff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Tested on 7.3.0-next-20261030 (QEMU/TCG guest).  QEMU has no devmem
(net_iov) backend, so a TEST-ONLY hook (applied to both kernels, not
part of this patch) fabricates an skb whose frag_list child carries an
unreadable frag, then calls the real __pskb_pull_tail() on it at
late_initcall time: skb_copy_bits() recurses into the child, sees the
unreadable frag and fails.  The hook then calls skb_condense() on the
same skb, so the failed pull must not shrink truesize.

  unpatched                             patched
  kernel BUG at                         __pskb_pull_tail() returns NULL,
  net/core/skbuff.c:2903                skb_condense() keeps truesize 960,
                                        boot continues, no BUG

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..8a200252ef93 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2900,8 +2900,11 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta)
 			return NULL;
 	}
 
-	BUG_ON(skb_copy_bits(skb, skb_headlen(skb),
-			     skb_tail_pointer(skb), delta));
+	if (unlikely(skb_copy_bits(skb, skb_headlen(skb),
+				   skb_tail_pointer(skb), delta))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return NULL;
+	}
 
 	/* Optimization: no fragments, no reasons to preestimate
 	 * size of pulled pages. Superb.
@@ -7218,7 +7221,8 @@ void skb_condense(struct sk_buff *skb)
 			return;
 
 		/* Nice, we can free page frag(s) right now */
-		__pskb_pull_tail(skb, skb->data_len);
+		if (!__pskb_pull_tail(skb, skb->data_len))
+			return;	/* frags are still there, keep truesize */
 	}
 	/* At this point, skb->truesize might be over estimated,
 	 * because skb had a fragment, and fragments do not tell
--
