Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B2379EFF
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510165; cv=none; b=D1wcElFikusLVFWZfXJ5EhjUY/W+B6RPSKVb9bMoyhsN5WHyOGrlKgj6mElPjc7c/j3VCeVjaEHfADHkwAw+QJBoSzajpkl72LWiJVY/4PJwfXyGvKky9uoqoz67JsHcIwkFBNsruXqYd99GZJdCntEFOnm6AWEyL3tL7+81+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510165; c=relaxed/simple;
	bh=gscrcobiFZjTV8CWh53O8e36+ERF3+9AvCKc+SjayGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+FGzl5EdGRJDQwxzIFIZ5mWvZySCcWiZZ+IYR4SmoLSt+v7oe9MIbDuyJAdKWrksRWk7DL7ox86hICqNqI4LPAo8eM9leKgOClwvKsFhoCe4a3rcEC1xPPiaiC9smq0gcs+PD1YIDydLguVC8038B3RvdMAptT+lePooHnqQRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCjZXzmt; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCjZXzmt"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so3331201a12.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787510164; x=1788114964; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UUizFyvTXfnDZkThaHs02zvim1q/J5mzBIkFP4tM+c=;
        b=TCjZXzmtmOU36XVBrEpFFhsEMJMjd5to8BAfJAVU+j5kptVcXqo+Q9QCj3Efa+twCU
         n/gpjTy6DxkfMur2ZHm8ufEjtPLTG6f1dmd7e8gVuJaN9iq+sLUrL6w8pw/HU/NJQKnf
         Iy23VMiycz+3L0im6wAYlsfeD7x+DqX9cnmLDIwsJQfjTq33rACeE+ljkE76J+VcyNWU
         qSdTZ5Vi1ZjircucKH1vOjyU4CM98LaE2l8wUkVcBWtlAz38LKQSi3uzH5gy8x4fNAf4
         +VhKhrvg/heqtmhvkH6T3pxFQcbF/LnTZXSBHqHybq0Eobmrr7uXaHoNBSVWkCMOd7ga
         FwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787510164; x=1788114964;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UUizFyvTXfnDZkThaHs02zvim1q/J5mzBIkFP4tM+c=;
        b=Do3PNwhfsBsFa1d1b4+TXXlEYKTfexnPw2D7NBMzJoimRkHZeckDXiUyPBEIOnb/uq
         s67iuvB338LTG6wCylRrBza4xcPmxgMwa85UllgkiZ8hO3B/mOCZb3JrSqNcAoJyshZL
         ccavGlj5H647sg86LKoc69xizihtqciXZFgpRYvjDjSkoQN07srIrMW3NEqpwgTvBrRm
         FRaKcmF7GJedPCIraglUQsJCblw1lnMDr7BFx3lyY5HXi1nab+UtgeNSZn78n1fm4cyr
         o4KJrs+xBwoY9ABkR+HLdFNHEFW+LyefFu/xwH4k8H15NvtXYTF10YroSTgoIWQflpgh
         WEmA==
X-Forwarded-Encrypted: i=1; AHgh+RqbYqQIk+9zFCSp0AxUKNlIh+HgkHKG4Ib85GPNXBhg2nGfVPWZ8oXZWxiZFiuDu1tETD2FvZY=@vger.kernel.org
X-Gm-Message-State: AFuF++mzR/XSWQYL51rUghhzOKyIBgjhCPEW1BApga19xty6rD8SFkg4
	5p6MPYWpb8Yy9TYTSvQSVQNWe4TfftgH1luATHrPBOG+YGJdY7PV4tbxPFVWzJrvoTEa2aOPI3I
	VedfS1a0Hst67Tk7S2dXj9g1TcA==
X-Received: from dlbbz30.prod.google.com ([2002:a05:7022:239e:b0:13e:5cad:4689])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c90c:b0:3cc:22bb:8911 with SMTP id adf61e73a8af0-3cd2fe7a2cdmr41465461637.6.1787510163813;
 Sun, 23 Aug 2026 11:36:03 -0700 (PDT)
Date: Sun, 23 Aug 2026 18:36:02 +0000
In-Reply-To: <20260823183602.1051453-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823183602.1051453-1-almasrymina@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260823183602.1051453-2-almasrymina@google.com>
Subject: [PATCH net v1 2/2] net: core: fix head-page leak in skb_zerocopy
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	Eric Dumazet <edumazet@google.com>, Zoltan Kiss <zoltan.kiss@citrix.com>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When skb_orphan_frags() throws -ENOMEM, skb_copy_ubufs() may have
already reallocated and replaced 'from->head'. Accessing from->head to
drop the old refcount leaks the original head page, and erroneously
puts an unrelated new buffer. Use the local 'page' tracker variable
instead to drop the reference properly.

Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
Note to sashiko: if you find pre-existing issues, mark them clearly as pre-existing.
---
 net/core/skbuff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 201c9ec1519c7..92aad6f0b0e14 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3907,7 +3907,7 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	}
 
 	if (!skb_frags_readable(from) && j > 0 && len) {
-		put_page(virt_to_head_page(from->head));
+		put_page(page);
 		return -EFAULT;
 	}
 
@@ -3916,7 +3916,7 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
 		skb_tx_error(from);
 		if (j > 0)
-			put_page(virt_to_head_page(from->head));
+			put_page(page);
 		return -ENOMEM;
 	}
 	skb_zerocopy_clone(to, from, GFP_ATOMIC);
-- 
2.55.0.766.g2966f0265a-goog

