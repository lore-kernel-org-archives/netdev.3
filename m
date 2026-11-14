Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794628865;
	b=RJa4S/ufrulUYL8icOJ5nlO8jsGtPJso3/lNDHclYzWyGWyWx7OJc3D5I3rDBHTD7t9f
	 RP9rtQ3vMWo74VZJS8uM9JPIS37gTGJEPxpfrMCXQU/rITCfSFUgKt29CRNAVFuyZauR3
	 XLnYreVhDY6h4jlqKixCafV0vrItetpu6wIfo4rdJxgoAS3YTPpTBGsq7zht/pW6afChy
	 82d1b9IHozf3hC/csfDb+mtdoS5a/fytHRrWNXVR/nT8LN+eGS5/RzjX6tJffhKZJkuJ+
	 JwTqn44m548vzqQRnBqqQTuFMZtaF6tcDn70WtBlcSENaa0ifxfhsIrciSv+5sowaYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=l7iCBJ1Jp0M+HoojyGh6nGJDWbPNAFLmE5CKYQf58WI=;
	b=AJeI9LOHhjErCrhO9SKXOR/7KT/mBpfGmky+zCmMrvwtmer7QEmuvdUn87UrMdBaNE6N
	 0snICnNM1cyJYjqDYjWdl4tt5rtJ0+rPRIFLIgWUrlg0eeemdDN6gK1KkAq1ifD2WFd7e
	 f+yd00h1h6ovqqA4+38emrMHL6vjdtsxi1Dc1Hhazb3Bl4JrLa0ryfjWoFyVBBtBtIqas
	 6rsNXtPU2p95M5IUvWj5yki8L3TnIJTJTHPAo/7xDlBR/7G/LBeooyUcUK2wnZHPDltYn
	 NwgVMguxfTu8P/W0LgPP/1P2TlsyWPd4JcZY/xGCFoXNbUwu2HPdpTyT7zMEvuf5iPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jGlahVQP;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13068606A327
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13068606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jGlahVQP
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eb2437d752so25649955ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794628864; x=1795233664; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7iCBJ1Jp0M+HoojyGh6nGJDWbPNAFLmE5CKYQf58WI=;
        b=jGlahVQP3DfmVbK/ozvRmNpCRW32P4y4kApVjgUPr5Uo9zv93E+kpr1iXdHQczbGwg
         +JtGOgk4426S5RvuudnYXHeeUYuErBlJUSWLCyZjDmvxF1cMMKrGzpGCNHXoZeu809aT
         bU1IST7PONIsX6M2WS5rZNYShbWSFGMXSSSlzlMVLlAr9rv8Jg6/IgJeqcp86Nu4K+/f
         c5M1kwsnulIRfyRiIaN0Q5g5vN2Qi1Yb+IKoCPQ+zAFdGuXIdkOCrtMn+nznhkFA/T5w
         u6WN8Q5Smdev7T0PeDLwTCnIRD+K79evwYEBDf96t7w4jhReF+P9stQyuxVOH6uSsrB7
         wMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628864; x=1795233664;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7iCBJ1Jp0M+HoojyGh6nGJDWbPNAFLmE5CKYQf58WI=;
        b=YRqU38sybRNoBlmOhyMVvDiQZwLhQSeERHFByoQ/s6zB2CDl8tjim4BUcsYfyo6Mgn
         K4Y+VhHtLl4N/DDrzvCCEnU6zz+kQZJfAnJenHbPg22pZ16mFh0LHgwmL1aa+PVwrKZJ
         pQx3QtmXR5Huxz5eWcyrRJKEG7m+rG7mp6WfxKL3j13SvtdF6ZyKFNhTO9NXnGprMs2j
         CFHguLqwuYUlwfAD2CibOc2cOaGyGdqQrDdwQXOE79T6wY0uBa9Q06UgMugAIQlDcyVg
         eZKzQnUwHC6G4ju29TanEmrqhUnQGsIbfqTlLh87DzB2sDme8jG3UOJg0z+tYhMRGRCd
         HwSw==
X-Forwarded-Encrypted: i=1; AL+hErHMRtSisILgk/FSoE9cndvxir21CZ7HTRoKQF2Y2VPNcpb5nCSJ4322Xip7sd26MwE3mC5WFzY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KAzP7sV52eYUXJGid9ZxnGOz6xvWZZyJwmAjfub6XNJBFTE4I
	Wn0ofUfNllPL2KrizLzNUXTpte71C+3gxV4jbTXqA3Wyl1enqQMM8u82zlOTMsZhw5hgxFiZ2CZ
	mFVBclg==
X-Received: from pltk11.prod.google.com ([2002:a17:902:694b:b0:2eb:50b1:b505])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:390d:b0:2e9:5507:b532
 with SMTP id d9443c01a7336-2ee0dc5d126mr44751495ad.43.1794628864062; Fri, 13
 Nov 2026 20:01:04 -0800 (PST)
Date: Sat, 14 Nov 2026 04:00:44 +0000
In-Reply-To: <20261114040101.1043546-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261114040101.1043546-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261114040101.1043546-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/8] tcp: Clean up the first loop in tcp_collapse().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tcp_collapse() detects skb to start collapsing from in the
first loop.

If the last skb has SYN or FIN, the condition is tested
again after the loop.

skb_frags_readable() is placed inside and outside of the
loop as well.

If we goto skip_this in both cases, we can remove the second
tests and simply replace end_of_skbs with the inverted loop
condition.

Then, we do not need a test for tcp_collapse_one() too.

Also, skb_frags_readable() should be tested after the fully
overlapping check.

Let's clean up the loop.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a2074a1af422..32e63d089db8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5839,23 +5839,17 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 {
 	struct sk_buff *skb = head, *n;
 	struct sk_buff_head tmp;
-	bool end_of_skbs;
 
 	/* First, check that queue is collapsible and find
 	 * the point where collapsing can be useful.
 	 */
 restart:
-	for (end_of_skbs = true; skb != NULL && skb != tail; skb = n) {
+	for (; skb && skb != tail; skb = n) {
 		n = tcp_skb_next(skb, list);
 
-		if (!skb_frags_readable(skb))
-			goto skip_this;
-
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
 			skb = tcp_collapse_one(sk, skb, list, root);
-			if (!skb)
-				break;
 			goto restart;
 		}
 
@@ -5864,27 +5858,25 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		 * - bloated or contains data before "start" or
 		 *   overlaps to the next one and mptcp allow collapsing.
 		 */
-		if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
-		    (tcp_win_from_space(sk, skb->truesize) > skb->len ||
-		     before(TCP_SKB_CB(skb)->seq, start))) {
-			end_of_skbs = false;
+		if (!skb_frags_readable(skb) ||
+		    TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN))
+			goto skip_this;
+
+		if (tcp_win_from_space(sk, skb->truesize) > skb->len ||
+		    before(TCP_SKB_CB(skb)->seq, start))
 			break;
-		}
 
 		if (n && n != tail && skb_frags_readable(n) &&
 		    tcp_skb_can_collapse_rx(skb, n) &&
-		    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq) {
-			end_of_skbs = false;
+		    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq)
 			break;
-		}
 
 skip_this:
 		/* Decided to skip this, advance start seq. */
 		start = TCP_SKB_CB(skb)->end_seq;
 	}
-	if (end_of_skbs ||
-	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
-	    !skb_frags_readable(skb))
+
+	if (!skb || skb == tail)
 		return;
 
 	__skb_queue_head_init(&tmp);
-- 
2.56.0.611.g1030f0b940-goog

