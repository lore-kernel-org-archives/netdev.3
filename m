Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8C5475F
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789255851; cv=none; b=ByudaYNZqs+QmR5Q2rXnCnLHw8UzT5eorptYpL3mTK7XNffCLAaVaDMiSKd/As2VmmEATPT2ISjFo7xEaio7SXGywyXefjupw0r4ACt7T21KaSj2vZnChxD2ExVswiEXDcjlsGMRm3W1uxU3125oQNQNNbp/8wghUmEJtpjXLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789255851; c=relaxed/simple;
	bh=x7XgwhllO+Yaj8edIxptVdDS+j5+ZIMHQQHWcmsrUqM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I1TF9hSzelHReT7gDFWRHybQbjmWRSljdNtXBdpuCDuqUcEEAO/RkUuvYevr+dO+QsNJkbmCDm+xImCSFVSHsvKuvO59wdnXgq80YgiwBnUJmkT18hqfvK/kxfqd6RneUUKFxZ58EDixlx05zfw0/iDlwJE+ZgucbquKgBsuEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NL9zQaun; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NL9zQaun"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a082c014aso163525585a.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789255849; x=1789860649; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sNXgE6yZ4P36J72fkqfyLoJm305tAM6674hfFa0y2so=;
        b=NL9zQauntn8RuRTsopjiY35d8mH6ajfygiXiL7fXwz+k20aUK0conULRJbENUxeiTe
         h3K6sbpUsNiKxx8vatqqge29GG8D9wd3IDi07SOp9yIZZd+d1tMU34FJtAu6LcpEevhR
         8Hl+eGdeGaeeeMTUzscvkftBKpHIoHHiNNaHsrqk+qR77AYGFTSXkpD2VMlS5bnn0Aj5
         kA0rq/bO+MN/Kr75lB1iCCGL1hWpRU8M3QlMqzW0cSQ7OTK+oHZHxeDxhDVorFu5Nwuf
         lJSLTPjaP0DHarABpR+ES8quyBfCiCANH/zbZ6iidAQVZCuTco0wTin+QpsPgoMXxeMf
         239g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789255849; x=1789860649;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNXgE6yZ4P36J72fkqfyLoJm305tAM6674hfFa0y2so=;
        b=pe7F+DEHtqz9h5rSUKFDw98EhxOyEw1v+LaVN2vSQYRQQ7Xeh2qXRuS62ERdvW5SH3
         QOvArmuMOmsqGj95kxfFjTMXspGgoK31e1bR9rVcgxuocd0MAQCo5agqZcYfpEqwYyfo
         yg42QFgTZHJsnMalIh5IdxEcV9fqbcSrU3nEwXTjPU/dStJCpyPBxqY66DV4DppvIm50
         UpyhPh2AYeyRTJq6Xtpi/JUvwFJbSSrlyYW0QUU49vgdMxMs74kXuMpn93fKYWfWox7H
         CmYo9JhFsiJN0zwp0NUB7nIZqyXgoosLOI08Z1E3DZmxjKOV2UiWCZzOiuBf6E006EaE
         Q3hw==
X-Forwarded-Encrypted: i=1; AKwUvByDAOxGxwQ7tITeNrxe/qEkXkwCPp5Mj1EOAFzrdJ6ZNu7xXZn8NaoOkUclLxGPH7YUKNxYe24=@vger.kernel.org
X-Gm-Message-State: AFuF++ldi9Y2BtnlBA6o4Azj82+m87SgTlqo3FZ0H55YoXW9wlE0VBNw
	jt/9qQOUBlUd8l7TtvaTZwRu7wRWTUr7IkicvELw4551JI8LtPwZEzsM52WjGxU/dHI/VwPy2lZ
	IWwY7Vm7/PVZb2g==
X-Received: from qknvq26.prod.google.com ([2002:a05:620a:559a:b0:939:e3ee:c681])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:488d:b0:939:72cb:baf3 with SMTP id af79cd13be357-93a187ba1bbmr21111785a.42.1789255848817;
 Sat, 12 Sep 2026 16:30:48 -0700 (PDT)
Date: Sat, 12 Sep 2026 23:30:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912233048.3977192-1-edumazet@google.com>
Subject: [PATCH v2 net] pppoatm: ensure a writable skb header and linear data
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Mitchell Blank Jr <mitch@sfgoth.com>, Chas Williams <3chas3@gmail.com>, 
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

While at it:
- Call pskb_may_pull(skb, 1) before inspecting skb->data[0] to prevent
  out-of-bounds reads on zero-length or non-linear frames (e.g. from
  bridging).
- Defer SC_COMP_PROT protocol compression until after pppoatm_may_send()
  succeeds. This eliminates the temporary skb allocation on admission failure
  and completely removes the fragile "undo" heuristic at the nospace label,
  avoiding any risk of reading uninitialized headroom or performing an
  unbalanced skb_push().

Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN ioctls")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Chas Williams <3chas3@gmail.com>
Cc: Qingfang Deng <qingfang.deng@linux.dev>
---
v2: addressed Sashiko AI review
v1: https://lore.kernel.org/netdev/20260908090519.339696-1-edumazet@google.com/

 net/atm/pppoatm.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
index 6da52d12df68e493b03f57edc46c3b5255956893..5214786e61d11aa52cf11c95c139c3a6ee471fbd 100644
--- a/net/atm/pppoatm.c
+++ b/net/atm/pppoatm.c
@@ -292,10 +292,13 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
 	struct atm_vcc *vcc;
 	int ret;
 
+	if (!pskb_may_pull(skb, 1)) {
+		kfree_skb(skb);
+		return DROP_PACKET;
+	}
+
 	ATM_SKB(skb)->vcc = pvcc->atmvcc;
 	pr_debug("(skb=0x%p, vcc=0x%p)\n", skb, pvcc->atmvcc);
-	if (skb->data[0] == '\0' && (pvcc->flags & SC_COMP_PROT))
-		(void) skb_pull(skb, 1);
 
 	vcc = ATM_SKB(skb)->vcc;
 	bh_lock_sock(sk_atm(vcc));
@@ -317,23 +320,13 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
 
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
-		memcpy(skb_push(skb, LLC_LEN), pppllc, LLC_LEN);
 		break;
 	case e_vc:
 		if (!pppoatm_may_send(pvcc, skb->truesize))
@@ -346,6 +339,12 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
 		return 1;
 	}
 
+	if (skb->data[0] == '\0' && (pvcc->flags & SC_COMP_PROT))
+		skb_pull(skb, 1);
+
+	if (pvcc->encaps == e_llc)
+		memcpy(skb_push(skb, LLC_LEN), pppllc, LLC_LEN);
+
 	atm_account_tx(vcc, skb);
 	pr_debug("atm_skb(%p)->vcc(%p)->dev(%p)\n",
 		 skb, ATM_SKB(skb)->vcc, ATM_SKB(skb)->vcc->dev);
@@ -355,13 +354,6 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
 	return ret;
 nospace:
 	bh_unlock_sock(sk_atm(vcc));
-	/*
-	 * We don't have space to send this SKB now, but we might have
-	 * already applied SC_COMP_PROT compression, so may need to undo
-	 */
-	if ((pvcc->flags & SC_COMP_PROT) && skb_headroom(skb) > 0 &&
-	    skb->data[-1] == '\0')
-		(void) skb_push(skb, 1);
 	return 0;
 }
 
-- 
2.55.0.1007.g17ff1f9808-goog

