Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948E47DD77
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049875; cv=none; b=DmbGEmEEaon3/KKAdbzApKcLJ469TGzXp26twxBu/zQTJd04wdv/v2LorFE8Oq7xcMlVA3p6/Wf+4qidDc0qPJgYBt3PqQCe6hsGoy1io7gbV9V6a8Q7WOdvpWL2NFuMcRP1P92AUWKadcfr61Rkih6mkvz8WwyMJORUy9I3EzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049875; c=relaxed/simple;
	bh=7VhssldhEn1SH6TcBBPIWkuyOXVfHEC4iqR4M4KlGbE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bmNX3fnfWm16Bdt63jXWd+E+6GEwiJnj/R0SqJ1fCVh76Unxk06zoIMyrwOComMdvXrpx77mcJVg3apJYfnaWVVT+G+cc7UQWZZnPDzHpbPNERox8U2hYniV7r6mZLeAs1Cz5hLGm8yMDaI224k09e4XqrlIUa97Pm/n5Y6TB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HIuT8OL+; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIuT8OL+"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd1e45a268cso1464957a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792049868; x=1792654668; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Be8sy8Bdn5ONmnvgzJDmAuJ13byc/JKsc3e6N06ewxs=;
        b=HIuT8OL+zlvsAVEP5a7KvTMGIuqRZMYp7NN8I1G4aob5sWO9vtEDJ7xYwgj7xiDnBb
         GO7fMoU3autulH4rm6wBsqHIujBunYX5QLwxdiuM41ZhXgQl7ey5nf13HaynkmNRXWba
         LoGKXkAl+lcjiuEy1/CBFV3v6Wv7YnsswELs8uDCKpErmp95R/oJH/YeSejAOaioG2oY
         jv9MhpN59RCK0U8uWFbCeGdsNf7rJXlGER81CZNgtk3s+OIEOyg01iv3FsWQGlFMYFx2
         b2F+JqisSxi40Zc9ofnrkqR6yMk/0dHbrJF/ZJxuipzYO7nzcOuRwU69noQGdOkG4VjQ
         2gtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792049868; x=1792654668;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Be8sy8Bdn5ONmnvgzJDmAuJ13byc/JKsc3e6N06ewxs=;
        b=FibW4bRN/F0/cnY6qH55WpSqX/Tjfyv9M+zKZSPF1Dg0mqgJI8wYlNojC/VRt+hyMu
         IhKkiyMeHtJV7HAxfOkcuIhaBPujVN3OMQx33qTW0PSK8LCDH2qW4NTwfPbjIUsvrKQp
         aA/V2//A56bRZaS192+oibBTE/U+DI3rH8ye43D7il7LC1IHrPYRlmsnVKHuH/Ty7+tI
         y7GstIJW6vm76y0/QgEGiNhDDKiLDuFWm97m96t+ivuUADtbXFce14S8tQm28fBaRMME
         j5SSwwfjo4EOtcbwtuyRuVV0iMHBg3TmktORXlMfhxSxn6aQGj5WrdonAM9WMq+XZBf/
         jC4A==
X-Forwarded-Encrypted: i=1; AKwUvBz6XZ/Z5t1Ub5MEE7rZfbg+phBrBbavxrfeN1TR78XUbgRMLnKccPRGvrShnLyTXN3OZmXQafg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/1O1AJEBar2S58l5wXTe1Q6h4+zk/P8xeVT6O4KchZeWb2Ozy
	H4dJpKrfaxYkIHM0zpmmIk8PXpWWBfFMFKx425rtLM0ofqPe+Z1OXKF555UQXHcdte5sI+Uqyyw
	9uA==
X-Received: from pjbil8.prod.google.com ([2002:a17:90b:1648:b0:3a8:28d0:2510])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b:b0:3ab:2c2b:1030
 with SMTP id 98e67ed59e1d1-3ab3a747cfcmr14208135a91.22.1792049867875; Thu, 15
 Oct 2026 00:37:47 -0700 (PDT)
Date: Thu, 15 Oct 2026 07:37:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261015073736.2944215-1-tavip@google.com>
Subject: [PATCH net 0/2] tcp: clamp return value of tcp_wmem_schedule() to non-negative
From: Octavian Purdila <tavip@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes a bug in tcp_wmem_schedule() where a negative
sk->sk_forward_alloc under TCP memory pressure causes tcp_wmem_schedule()
to return a negative copy length when sk->sk_wmem_queued already reaches
or exceeds sysctl_tcp_wmem[0].

sk->sk_forward_alloc can transiently become negative when tcp_collapse()
re-packs partially read or high payload-to-truesize SKBs in the receive
queue and charges newly allocated SKBs via sk_mem_charge() before
freeing the original SKBs. When a subsequent send hits memory pressure
in sk_wmem_schedule() with sk->sk_wmem_queued >= sysctl_tcp_wmem[0],
tcp_wmem_schedule() returns min(copy, sk->sk_forward_alloc) < 0.
Callers such as tcp_sendmsg_locked() then pass that negative copy length
to skb_copy_to_page_nocache() -> copy_from_iter_full() ->
check_copy_size(), triggering WARN_ON_ONCE(bytes > INT_MAX) and
returning -EFAULT instead of waiting for memory or returning -EAGAIN.

Patch 1 clamps the return value of tcp_wmem_schedule() to [0, copy] so
a negative sk->sk_forward_alloc is treated as 0 available bytes.
Patch 2 adds a packetdrill selftest that reproduces the negative
sk->sk_forward_alloc condition via tcp_collapse() under memory pressure
and verifies that a non-blocking write fails with EAGAIN rather than
EFAULT.

Octavian Purdila (2):
  tcp: clamp return value of tcp_wmem_schedule() to non-negative
  selftests: net: packetdrill: add test for negative sk_forward_alloc in
    tcp_wmem_schedule()

 net/ipv4/tcp.c                                |   2 +-
 .../testing/selftests/net/packetdrill/config  |   1 +
 .../tcp_wmem_schedule_negative_fwd_alloc.pkt  | 116 ++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_wmem_schedule_negative_fwd_alloc.pkt

-- 
2.56.0.176.g3575e65682-goog

