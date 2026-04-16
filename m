Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610463537EA
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369830; cv=none; b=NKHLGG40MQF5DJ5EMJ2T99DNhoNdUQpe3yeja0BtKbMnl47YFuLOkVA8fWHaY0XzbrK1HPDTn5abmaKEWSAU6I7b4Eu3YHEZPrDl0ePOS2KeVZiTCKsuljWVy2lDYbaZ+PJ1Kxqgn6sM0WKrDfybJBCvdI2uOd3hmzAWXGaJTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369830; c=relaxed/simple;
	bh=QqOs/THqfii59khCeoTMZOPtKFPFLV2Y5odetbyhFO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ECxDK834DmRAnMOu4wtksNIJLxEwMY6F/mNgizeQAviI7J3RzvIiJz/fq6zIAUIpIr0x0XqJWsSBdxb4zk46BwE609AMFbzpvPYglTciBVTzPe848QpvgituVlX5nZQDUWGmdvRpf4gYcgrmIrFwS2J7ZzrLbclI4HKLOiXG724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vp9FTgAT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vp9FTgAT"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-790afc07667so205946647b3.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369822; x=1776974622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8EuQvM8AiGSLEO1UUgTVNhEY05Q2B79NY1zW1zF9Oo=;
        b=Vp9FTgAT6k2wAZH0zdwvfEAaligl8v0Cx8NkQFcPfpNM5Y3Xqq5IckSwqOElU05NYY
         Tm9SC7sJFm9J3SlMZVzLA+QZvmSdVO78WD0+uIypgDt+4iXG0czQmmwu3F3S0exRmFpl
         qVh8ACHT0ogUpfzC7p4kQll9dv8uvLkLt21fIhyM9cIBUub+D12aQst7gt43ZFsmFmAc
         9hNQp9HKaGnkaSm57cNlsB4RRB0mjH+W9QkvSr+xKs0/6YP8vrXhHRb7eTL4SKqm1IZ6
         DgxcOdQ9YdKQckFNR4sIcwzwki3xfmKfowOhVA6d57/RhFBG9hYDaH3k48OafZ2urWym
         Nvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369822; x=1776974622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8EuQvM8AiGSLEO1UUgTVNhEY05Q2B79NY1zW1zF9Oo=;
        b=GGjrpXmQ35mgkqXgY76cKMzYslG8MRG6o+waNhILRsM3WLW5ElTBI9iqVCQGXcYuyT
         yY5VjoiSx17qEo/C+qBXGDMh3Gny+Z6/WkyJvPcfBPLLv0HR7no6waFUweAfuu+TFD3v
         T1pAnXT7dHJC8GdKCM4UUGA8aa+6wPBNjFCPFZfGye3gK66SW2xzfzsSrpKee0+NuHtS
         CECW2m8MzIab3uIFhFJNyC623qC+pQr1m0c+5/vBtBBoAn4SXCe0sdUzuEI+K/iR5gKn
         uOkZHgSOEBmaeYFLwRh+BLY7ner8ZTJc1C3Ju15EVaDW2OJv9o7EEBqukPqgvHTmOknK
         E4GQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TFuk6dmoKniwun0JVZnUSqAdQKH1HvKmX9KFShckZz4pTMwX2zXcJdt3jUS+SgKv3wcUpJeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU01C31wXO8wH11tYpgTKQey4J6ZXp13CCyuZSMmc2mjOqJD2P
	kGT2mRtnnUyIEvWBxXSQJxhWbA+8u6iLR2my3wwXflYXxY29cz62hpJndoIVT6bLSlxZTldLogW
	cIA9Ut/RFemnCuA==
X-Received: from ywbgn17.prod.google.com ([2002:a05:690c:4391:b0:7b6:65b2:1d31])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:ed4:b0:79a:c40d:b701 with SMTP id 00721157ae682-7b9e1405e01mr6568117b3.13.1776369821912;
 Thu, 16 Apr 2026 13:03:41 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:18 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-14-edumazet@google.com>
Subject: [PATCH net 13/14] tcp: annotate data-races around (tp->write_seq - tp->snd_nxt)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() annotations to keep KCSAN happy.

WRITE_ONCE() annotations are already present.

Fixes: e08ab0b377a1 ("tcp: add bytes not sent to SCM_TIMESTAMPING_OPT_STATS")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 192e95b71ce9868980a809184be83398d8740427..68894c03f2622d1a08fd747ff4c5e32be8579d2c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4472,7 +4472,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	nla_put_u16(stats, TCP_NLA_TIMEOUT_REHASH,
 		    READ_ONCE(tp->timeout_rehash));
 	nla_put_u32(stats, TCP_NLA_BYTES_NOTSENT,
-		    max_t(int, 0, tp->write_seq - tp->snd_nxt));
+		    max_t(int, 0,
+			  READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_nxt)));
 	nla_put_u64_64bit(stats, TCP_NLA_EDT, orig_skb->skb_mstamp_ns,
 			  TCP_NLA_PAD);
 	if (ack_skb)
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

