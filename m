Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4538A717
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777291; cv=none; b=Zu2OehtrNNj/GJbO5oamvNw1u0q87UqSw5STLn3g+Y9H/qwQW1c9PRdP0UPCUriimmZxeuFsDhUSlbkdynjhIruF2k9XVDzmrKPojTxxtWnc4g1saQg8Y4pDt7VsN6vY1FhFRKGVC3mJL1AAMlB+SqM1eqSjfwpXeJ9oY1ZmHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777291; c=relaxed/simple;
	bh=lKizjzbX306AsZcOuKlswc5fA6mSPnfijXJ0Y7oZ2tQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rAgLIylkXwnGvRJWLyEbPMP/uVK7yCWADdPdEaG22zJ/VjzLnXSoQ2IUDRw9hcWEBBmanMDUd0hyR5htKIblb+I5tpSY8TzMfUyKRx7Ak7QxgFsDAxbR8YFi52GyEsd7RdRpiQhW8PUsSB5K/melamDtqQ3MqePNoeRYlmebNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2R7+fOi; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2R7+fOi"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb7d6ba548eso4619470a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785777289; x=1786382089; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lfjv8btm7SM4nYiUku46hVA8+1TFQKBzNlJiSqVfZCI=;
        b=r2R7+fOibDzfYrrV9xOJWaicYVFaC0eZECt8mBPTxMyy+cBoSbgBBc2BnAKzaf7r6M
         hwz6mz/mFAmoLPC56N5N/Mi8ZPc6E36v9J22h8SIv9BmvFyDIHar5BZRiQZ8YCXy4ws/
         xYTJcWj0okgmnnIqcZ3R3ZZMFzR0OEDBRffNt4kUHC4LIn52gWCxpwez689Soa/nmqIa
         oxpB75/05HbwTXRafZiEIDwUHzfnAD2dOqkyUUazTT2duR0qexL2DMYCucS4HhTXXYTC
         DqhhCykIgPTZKSiX3MUutGD5/qP2U8MmUxDg0O2YQ/1vpmjDzDGOobcfk8bXdURZcoDf
         ZOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785777289; x=1786382089;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lfjv8btm7SM4nYiUku46hVA8+1TFQKBzNlJiSqVfZCI=;
        b=Ny8bdTMlM1iv2dlD7wVeWgRlkzH4TwEQplnIFMoLT4jry4G9la3JRG7cDKz41gKyXj
         LXeTPdLwUQV05iMi+PVD0U+m9ZTMUuwFWa063omFFHuPXEW+rs0UQEJ2NcxMfTP6d32b
         NZRQM1WhnQCbTecTcBEILJbX5y8y2hmxq0EDlrlLkpbfzci5dcRoDZo4yYLoHtAIK2f/
         Q9knjFTfyolbclBRUIVQhaQBrzD9HBz1xU2hgUbElPcOMPjpvdhkPA4gyizM1Jr7h1WT
         +gD8lAWhVwBWnsKn7ta/Ie30FeMgC5joT9CnkzyifI+wr16CW8gh3MZQ7BIXnHWmpayn
         6TFA==
X-Gm-Message-State: AOJu0YxLsfoDCiKpcd7nkE9HWMex21qfZXnTSVE/gyD4KYXMdaWtoFZ6
	rO7PQFgT4qzg2seH79UV5o/LSavdJ+c1sfgfs7a4f+JsQrgh2VjATsHsxxtcHV75Xj7CGaqayjV
	g9LnDAqkXk0wmXCISzdCxFBN9tayWeyww8e6FZDoEafdQHOHf4ijatTVcDhfwASrk2orTElDw/N
	tS98ounzBIdzWXnY+h+fPN0l68fUpaLq9K6wMLK7RbFCYCK/ISvfy/u/Mzg4W0+Ks=
X-Received: from dyng4.prod.google.com ([2002:a05:7300:7f04:b0:314:f751:f881])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:93a1:b0:3c4:2cf9:2896 with SMTP id adf61e73a8af0-3c92a8af306mr11281485637.45.1785777289000;
 Mon, 03 Aug 2026 10:14:49 -0700 (PDT)
Date: Mon,  3 Aug 2026 17:14:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803171441.408014-1-almasrymina@google.com>
Subject: [PATCH net v2 1/3] net: core: propagate unreadable flag in skb_zerocopy
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com, 
	kuniyu@google.com, bjorn@kernel.org, jiayuan.chen@linux.dev, 
	kaiyuanz@google.com, willemb@google.com, asml.silence@gmail.com, 
	sdf@fomichev.me, bobbyeshleman@gmail.com, fw@strlen.de, 
	Mina Almasry <almasrymina@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Ralf Lici <ralf@mandelbit.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When skb_zerocopy() copies devmem payload fragments, it fails to update
the target skb's unreadable flag. This causes the target to appear as
readable memory.

Propagate the unreadable flag if any devmem fragments were copied from
the source.

Additionally, to prevent memory corruption, explicitly return -EFAULT
if standard payload from the head is mixed into the same skb alongside
unreadable devmem fragments during a head-to-frag extraction.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

---
v2:
- Return -EFAULT when mixing head-to-frag unreadable/readable frags to prevent memory corruption (Pavel).
v1: https://lore.kernel.org/r/20260801125308.1342897-1-almasrymina@google.com
---
 net/core/skbuff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ba3dbac80fb49..8bacc6c4e16e1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3905,6 +3905,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 		}
 	}
 
+	if (!skb_frags_readable(from) && j > 0 && len)
+		return -EFAULT;
+
 	skb_len_add(to, len + plen);
 
 	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
@@ -3928,6 +3931,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	}
 	skb_shinfo(to)->nr_frags = j;
 
+	if (i > 0 && from->unreadable)
+		to->unreadable = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(skb_zerocopy);

base-commit: af39eb111ce6b5eba9c08513b62c4868eb7e7fd5
-- 
2.55.0.571.g244d577d93-goog

