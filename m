Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070F4A4409
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858323; cv=none; b=QeNtujOn0kO64TdkvXIRpYTnVpNK9pBQ4h18FHG3wYmlhTp6pVtoSqBrPAu2mFngtOTPcxAWG8YfWeE7kFIexapDe7x/EXz6iWwGSS1EmvERrNdBePq85lof262/Z4E9DfYFHjBwFZRDOK4yA5aws6kNuDSgUIsLY4tfCVSFtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858323; c=relaxed/simple;
	bh=sNNBBct0nwB5FmYU4k8mGBGAI21QrDEgejmZXPmM0z8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Dd9htEU+/4dmXat+DrkqPWrtmDaSw0XISXv91e8bzH94vibMyiLgQxYA2h+mPtbOLGTcAwlqTYYUrfAYTknUQdpwFMT1dLEtngt62SkBbWYI3IBdTf1rJQEFeKg5LnybB0rT/KFeAGz9ZfxpzpB42FcoJfEjudDfDnXMqZgZzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpUCDpAr; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpUCDpAr"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d137a68so54561831cf.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788858321; x=1789463121; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0akboqw8M9ZArGnEU4CANneJLg/jHZe5Hbjuj3SNUs=;
        b=FpUCDpArKKcSMWpWX0tc3h9fQ48KVVyLbyUNohTR2MeTCWb9PP4uvCMyXOWGIj8l8k
         xQHodAy+cxnaZ/v+V1KmUtAcpDTfK+87Or4GLsSJOCwIEzlMRxVV5vGECdSot1XumaA1
         bT7GdDH8lPAS0NwBr2esQscS/jjrhLlUTsQjNZcpAl6hSt9mzW9Fr5BmwSjQTXGIMJZB
         l74c077EXSDFbNWhzkVPI+CRlvVN10wTLZUh9Hk0v9vfj5tu46vDbszq9yF2163UYDPr
         srMwC5KU8XDKlMJJyLCVyDVWeF0dGWNOl0Fm4lxMBN65nUGBtZQ0iRHu6HNsrnqOqNkb
         2aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858321; x=1789463121;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0akboqw8M9ZArGnEU4CANneJLg/jHZe5Hbjuj3SNUs=;
        b=bJ/2LYaluP/aOUReDTCrMTMLCFSdXeLZsYbV9lXd7Nc0Im4KXBtmzo27VeyCM/nSTt
         EFChzXrmf8czqUX3ra3SsFJ45GX/cDC9aUSCZYQ/yL85TQSDkYuRVZGAsKut/PlSOvr2
         5Y2LNS/VVOu2BFTGvbThfaJftgABKBp+YvXNzkAGE7KnoE3iVCU74VSjqSE5LSRXVoTJ
         4FYcSq0cMFVjC9FzGNa/p2uQCtsh7l9Mg8UrZuV3Lvd7lU1OXihKCQrwiOnU7Fm1f+Iq
         zZ+BBDZTcNKoGwyi1aPuFleeCOhZrXYh4xmFFZrcNcvQ4iaCwNsBNhB1wZpdZF1FGuw9
         cZqg==
X-Forwarded-Encrypted: i=1; AKwUvBx3vYDDZ2I5nlIFochOGqbM8q/5Lwty/S2brNAKVuJr1LGbyBnad7BAQl4m11bEFIyYKq2fff0=@vger.kernel.org
X-Gm-Message-State: AFuF++lceaMEvnCgi8fVX9sySf8WdpMWEKbMogeioJR/kZkRpboM1Oad
	RAjt4yudd+LPYcU28Uyza4Blq8B8vco24x7Z4O2BdH1Xo+FdNji0N7E1I5S1CnT8JCTgZWemxvn
	RCSEpjEIo7sVMWA==
X-Received: from qtbs5-n1.prod.google.com ([2002:a05:622a:e485:10b0:530:820d:19ce])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:e484:10b0:530:7fd6:f87e with SMTP id d75a77b69052e-5307fd6fbbfmr88702941cf.11.1788858319858;
 Tue, 08 Sep 2026 02:05:19 -0700 (PDT)
Date: Tue,  8 Sep 2026 09:05:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908090519.339696-1-edumazet@google.com>
Subject: [PATCH net] pppoatm: ensure a writable skb header
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Mitchell Blank Jr <mitch@sfgoth.com>, Chas Williams <3chas3@gmail.com>, 
	Qingfang Deng <qingfang.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"

In pppoatm_send(), LLC encapsulation checks whether there is sufficient
headroom for the 4-byte LLC header, but does not ensure that the skb header
is writable.

Normal transmit packets passing through ppp_start_xmit() have their header
unshared via skb_cow_head(). However, packets can also reach pppoatm_send()
via PPP channel bridging (PPPIOCBRIDGECHAN) without going through
ppp_start_xmit().

Use skb_cow_head() to ensure both sufficient headroom and a writable
header before pushing the LLC header.

While at it, this also simplifies the code and avoids allocating and
freeing a temporary skb when the ATM socket buffer is full.

Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN ioctls")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Chas Williams <3chas3@gmail.com>
Cc: Qingfang Deng <qingfang.deng@linux.dev>
---
 net/atm/pppoatm.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
index 6da52d12df68e493b03f57edc46c3b5255956893..4ce7fa6e493e95d64909b72fd123a517c0befb12 100644
--- a/net/atm/pppoatm.c
+++ b/net/atm/pppoatm.c
@@ -317,21 +317,12 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
 
 	switch (pvcc->encaps) {		/* LLC encapsulation needed */
 	case e_llc:
-		if (skb_headroom(skb) < LLC_LEN) {
-			struct sk_buff *n;
-			n = skb_realloc_headroom(skb, LLC_LEN);
-			if (n != NULL &&
-			    !pppoatm_may_send(pvcc, n->truesize)) {
-				kfree_skb(n);
-				goto nospace;
-			}
-			consume_skb(skb);
-			skb = n;
-			if (skb == NULL) {
-				bh_unlock_sock(sk_atm(vcc));
-				return DROP_PACKET;
-			}
-		} else if (!pppoatm_may_send(pvcc, skb->truesize))
+		if (skb_cow_head(skb, LLC_LEN)) {
+			bh_unlock_sock(sk_atm(vcc));
+			kfree_skb(skb);
+			return DROP_PACKET;
+		}
+		if (!pppoatm_may_send(pvcc, skb->truesize))
 			goto nospace;
 		memcpy(skb_push(skb, LLC_LEN), pppllc, LLC_LEN);
 		break;
-- 
2.55.0.979.g7e5102b832-goog

