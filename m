Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792846585;
	b=UMLvHdR3QRQXfQQp5gZaQfR25CbFoNS62obA1nSI4a866veg0PUrLFgxuYX5KEvBlug/
	 mxcZE+2/79vODPZ/209ImPzN/5ukVvf3FG2tAXRGRQSYIBhG84ekDY/uHplwd9NP5yM82
	 lx3qjBxbNuyorrRXlyS18J2HXjTfrqhai/WCpwXKNupqGX8uU990L6hn5sPPczI+SlrZ9
	 LbuMy6AYGCKIdoocdtbtC6WT//r9P+dtcmMtYn90j1iwRY7kEvSyDGOgGasCvo4HPLrcI
	 SCQqZHgO3bwwjKVdOK0vZ8yQlncWISpn4tvHQpnl2miYwosugFRzOyx4zAyu9b+nh7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792846585;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Mailer:X-Mutt-Fcc;
	bh=FAwVFsHA3boYKoM4iIUg3Eb+bwbA1VvDycreO8U2nGo=;
	b=WQbEO5ABp1ndcjmJBm6VlyFiH3CcX4OdLPaagdzsmLrXZNyo2XZQBMK8OdPD0UmB+8+J
	 TOcKVMmruog0AVlbakUrgaTyF0UJS+piZg9UZ2hA+tZrG3wBOoQlLgEcdC3bP2yjjzoQY
	 klTgFkoN8+eIbOUFcF1Avt+RQigsleE2F5NXXboPTq+w3dpSSASdv37XEaJUMFLGrc5yT
	 +mycA5NIVFWETIKTJXhCBjowd6IavHv9e1mMHeydgMlRz8ki8URVlH0JD/73alzHPkrEp
	 GI35jrsArkkGqrVHZECiI3kF/ItaPb6BQYxqH4cL81L6IzIDiQjGZfW7/tXnNUgbsRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dzLAvR+r;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HFEIYrjm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D8606A31D
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 12:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD0D8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dzLAvR+r;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HFEIYrjm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792846583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FAwVFsHA3boYKoM4iIUg3Eb+bwbA1VvDycreO8U2nGo=;
	b=dzLAvR+rlhfovf16i7jIbcdZNgiQ/M9/dVKl8qxWSRPSvvzH7lc1Br9xBgJDySbvb0mrVW
	A3vjN9em/gB7DhhaMpCc0LyjxEy7/gcUxcAbZYwHwSgTkHpd60oWfZB0VgfbqDl46aCQQp
	FPqftVXva4fyFGoh9FPEYSwg/nC4SUs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-z7y5mb4xNXiMvxaJiqBwpQ-1; Sat, 24 Oct 2026 08:56:22 -0400
X-MC-Unique: z7y5mb4xNXiMvxaJiqBwpQ-1
X-Mimecast-MFC-AGG-ID: z7y5mb4xNXiMvxaJiqBwpQ_1792846581
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so10658475e9.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792846581; x=1793451381; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FAwVFsHA3boYKoM4iIUg3Eb+bwbA1VvDycreO8U2nGo=;
        b=HFEIYrjmAoypit5pRSqL7CjRmZkloNqhYQ0EHM90TilFC73jLOybSsbwLgrsv9CZtS
         9YXqn9LdbRfrjHuefJkp/772TV6EPe260zQX+4MQdda9t8UZKqLoFwwM8OAsSillxqyn
         1DL6+R7k9ZPQ3jr2Da7qYekXuyUi8nZpvLZXLirNfZiN39okLmU10Q0mPEJPOKi7+dsb
         cUME99I7flNcRUhrnanZb8Kl57uyr2/upLkzwjp2ST3OEE0NLrPazN4rQkgKa7AQjeqB
         L3EUg0plhCksxNp+hQidyfdoKi+xW9njoTEi8GjiZ8kiZQbAIktGeSQV3L8Bz4flOHTw
         OCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792846581; x=1793451381;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAwVFsHA3boYKoM4iIUg3Eb+bwbA1VvDycreO8U2nGo=;
        b=HyLh6BMzpAd9gOzwL1jdyXS+2DhfNzKetRzhf2zBSQgvafVq3xawZLV8RhoJ//1RDi
         r5aCBVvxIXCDa53JzlL83/mfvp0aaVjbm9AyWV7xGF5NLK4n86erUuKSC+IQDuXvYnX/
         TnYDuaTAtJeB18OZZXV3c83It2pB1sjJtIH++1v7fU3q7LIsE5kJqPFbAI0z19YWlJMJ
         GpFr3N/++4T+we9qky8qYQJeviH0Gt6SkMmrFjDQ8kJiosL1RzQhAnHUOB7DaHaTvVks
         44/No3ywdzpaIbtPRu9yZKmtLsy76QCCvMYpWjmXrm6tIQuBtGpk6BHd6s3rrk0UydH7
         sB/A==
X-Forwarded-Encrypted: i=1; AKwUvBz0Nbi6TxtbhP9SnROQ6UCBuF3rp3HDNslD4vq9xcMS8z+f22Em0geYFiOxVkNqnVe6hnJQgWs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPHlwQHL/LHnvfJ1WZvOQ735y/jF18Sl7+hk3knXSCw7KnXCCB
	7AB9ysjyDXcvmuI0nfdBOhI+00236E0ofWQjjnhclecKXo9IS24xbB2dgiZfSGEMnXwRK7WPMpI
	PftfwGdt6cGggV2GVuOd0KWF7AEXTKLARt6TlbxwwIljVUQz14QK1fO1VEg==
X-Gm-Gg: AYBFou1DrwakF9jJnXJp0ScLIyAPC4u6fdny2eaP28sT+iAefTeTUfOCJgq8lzLmf0z
	5WrCVljm6pMRrx4DWoQ5wkDuDVZObhHbyvR6oo6jROziL6ubZtbspBeSgSlTujst5mua83KRbqA
	zrkGBH4GHLxWXigeBFMlkiBVaXgdwgCdZVjIQ+GrCAM3YGoxAJ/aYsuUkKd0lzqPhl0wChaVC3I
	8fjr2+UbUuucrpS5/fO84pVjUqtVR1FfHZV/GZFAUORSrbhe3xYpvu0rl/Mx8ILW9MaU6yrA0DY
	hDUjdw0BPd/PR2xaDa9Opsr1M4Kt4pA+0EqWuT5+y7oqQbMY2K20ilC1kTLZT0g2tfpfQ3k=
X-Received: by 2002:a05:600c:3f14:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4a35ac8ec61mr28498925e9.15.1792846580908;
        Sat, 24 Oct 2026 05:56:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3f14:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4a35ac8ec61mr28498605e9.15.1792846580338;
        Sat, 24 Oct 2026 05:56:20 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5697a7sm49765185e9.7.2026.10.24.05.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:56:19 -0700 (PDT)
Date: Sat, 24 Oct 2026 08:56:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Claude Code <noreply@anthropic.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH net] skbuff: keep accesses through unset transport header in
 bounds
Message-ID: <0bdcbe2ab5ffc86ba7190fe25476bcebcb967310.1792844270.git.mst@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

Commit 2170a1f09148 ("net: no longer reset transport_header in
__netif_receive_skb_core()") stopped the receive path from pretending
that an unset transport header starts at the network header - but only
on CONFIG_DEBUG_NET=y builds, the idea being that fuzzers and CI could
catch stacks reading a transport header where none was ever established.
And the plan is to drop this for release as well.

Indeed, under KASAN, an access through the unset offset produces a
slab-out-of-bounds splat, which is how these bugs are usually found.
But a regular debug build has no such safety net: the accesses land at
skb->head + 0xffff, some 64K past the packet data.

I don't think release builds are exposed to oob in this way, but I want
to make the stack a bit more robust if yes.  While I appreciate a nice
KASAN splat as much as the next developer, making even a debug kernel do
oob accesses was never the point of the exercise.

Make skb_transport_header(), and its inner variant, verify and WARN,
then fall back to the network header position when the transport header
was not set. This way, accesses stay within the packet.

An extra benefit is that release and debug kernels now behave
identically if an unset transport header is ever reached,
avoids heisenbugs.

Fixes: 2170a1f09148 ("net: no longer reset transport_header in __netif_receive_skb_core()")
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Co-Authored-By: Claude Code <noreply@anthropic.com>
---
 include/linux/skbuff.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a3ff380d43f0..cbfeb17d86f7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2993,6 +2993,12 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
 static inline unsigned char *skb_inner_transport_header(const struct sk_buff
 							*skb)
 {
+	if (unlikely(skb->inner_transport_header ==
+		     (typeof(skb->inner_transport_header))~0U)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return skb->head + skb->inner_network_header;
+	}
+
 	return skb->head + skb->inner_transport_header;
 }
 
@@ -3072,7 +3078,11 @@ static inline void skb_unset_transport_header(struct sk_buff *skb)
 
 static inline unsigned char *skb_transport_header(const struct sk_buff *skb)
 {
-	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
+	if (unlikely(!skb_transport_header_was_set(skb))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return skb->head + skb->network_header;
+	}
+
 	return skb->head + skb->transport_header;
 }
 
-- 
MST

