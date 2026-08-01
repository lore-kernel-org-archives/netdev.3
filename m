Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DA25B090
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785588791; cv=none; b=kvdTbXTRSxyFkPlPaHZGw4aeBqnEYO/y6P2El8Kz0qjdr5lHXmbKnS726VQZLNfFbU4LEZoRhjvYpjhwJErW2sJSwab3IknWqmNk20jiLDO8sZaLVILES+nhzf557njdZ9eRiZZnHBXj4j84X4th37J4FbJx5CijLV6E8l7j5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785588791; c=relaxed/simple;
	bh=PhLR4+qn453F+QIwU0DsbC1PeRAX3ITCmQFBqjZMZ5k=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=hTeJfcibvTsI4P/671K2eXsaylTIi4jVu+FpR447lsMv1tHUnIR+1aeESiHz/GPzDgKItRHsswzK0JBXYpPUgCJh+7etnaS5yAgZYzb85gvA5P34ZvEA6FAOwBefq9qCX/2Z387UFzmx6Q4k8By9dGGtFwo4ckHeM/VZWjOcCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvP38ZBF; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvP38ZBF"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so36342305ad.3
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785588789; x=1786193589; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BD+pUsKKpLLfVgUegmrxzd2L72D2X2rHT5PiZiLd4oo=;
        b=fvP38ZBFbweL2IwaWU3Xnhw+jVvhURa/CKYS4ttDq8Q/TRv7T3NW7LVop9z5625iFi
         InBDUHTVZUNWQ+hN1BKHkg7m3/hWhZFtGTvs8FbyuXpS8drsnUysIXjBfHWAwWHw8cXP
         xnte6aXMbFjDJN8to/WM0TkkYR997o9XeGNhW1WMK+yyDpvsu9+19VjSZkUbHrcjoBXL
         0TFXDxuNaynLVnArKhnyye1isqKHbnyo/Ys5ido4ecd250q88LcQjvKstVDPazKBSZl3
         2OO1aIOfDDDcgCHJY0JJRTeuZ7IX5FEVYWS92J1bcelEXA2VPsX0dRQ1VepkjEI67R3X
         JpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785588789; x=1786193589;
        h=content-type:cc:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BD+pUsKKpLLfVgUegmrxzd2L72D2X2rHT5PiZiLd4oo=;
        b=oTibmrlHwZRyUH5E/VYBNcdzn4gshxqi5iwzxCEYuKnWVsncOsBQ7TDJYpQJxN4LvP
         2azfXS1jff1lBjr1gr/N52d+V1tRjTs7j/9N3zm+TD45L4myFkyygnSgmBDUTQExH3h/
         DlfFDv+qqE5pXA7PdJWvo9Up56W7Oaj8aLJ1O7HXXNl/TF9HtbgB9G/NCqGnSn5UdYJP
         FRB0KlFoFwVeJEqIqokBVVVecoyQna7jJiSCftRdsVypNCh6Es0Dc6m094Xpf8JLgVgT
         GF4d/6Ra9PWYdqNY5O1XDscEL/jg6YpW8U1pWkbcEaf5myu9WJYZuFU4M7BgvwMzQYXV
         Ie5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr+q/LmaJQTDivKVLCRGkOtHKsgdt6OxVQrTw/r5i+B0LiXK0A8EX2C0wVtXwsuzFdht+EOshM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztMKEw52NNFXfZgw8gQzW5hSMWIHPLXoBSNuBFR2BjkTMXaS2S
	7XbIs2uP5ICtw3AEQIJ9yu84mnl3zdUoAbAoCZnjOpUf9zlId0E0j8jX0G+U+SQXs2u/3JF7dom
	MNgU364TwkHicgWmNRCWrxQkMpg==
X-Received: from dyjh34.prod.google.com ([2002:a05:7300:5622:b0:313:c814:320f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:390c:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2d05219bb84mr32050535ad.7.1785588788682;
 Sat, 01 Aug 2026 05:53:08 -0700 (PDT)
Date: Sat,  1 Aug 2026 12:52:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260801125308.1342897-1-almasrymina@google.com>
Subject: [PATCH net v1 1/3] net: core: propagate unreadable flag in skb_zerocopy
From: Mina Almasry <almasrymina@google.com>
Cc: Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

When skb_zerocopy() copies devmem payload fragments, it fails to update
the target skb's unreadable flag. This causes the target to appear as
readable memory.

Propagate the unreadable flag if any devmem fragments were copied from
the source.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ba3dbac80fb49..aebe8ea74776a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3928,6 +3928,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	}
 	skb_shinfo(to)->nr_frags = j;
 
+	if (i > 0 && from->unreadable)
+		to->unreadable = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(skb_zerocopy);
-- 
2.55.0.571.g244d577d93-goog

