Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC5456296
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243789; cv=pass; b=ooIIWqilL+33gQQeAJA//UYb7d/X3RS6zlVm7j4M1UYehWLjGM9zXkmlLKr1OQX0yV0POol2zueqjC6n9aJpGw/bvUhI/lQnUZhoA95NzRYZyBHYhg/ZE6qlkTxobXaX8+UGSUR7CnlcfYvdtNU72QSxOTzTK2hnwLIg24UdYWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243789; c=relaxed/simple;
	bh=LBZZcNSVeHHRIpD1xuzWESX6CCgFGvOZ+4ZFnY2ewKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UB85HBF00EiczXwsok0FALp8mNuOHhbRjosO9mgIe+DZpFKFZmFeypCeS0WcFYSHZ+d+kbmVEqDRuYxBiv2WbgYCYB+an4zy2j0Kd4Os1awdaPl2iL+PrOVQxfwUm0RkWQH6jDvE5zAXB9emfgDbb7SHHT33UTrN/pD6niWw3xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JODW4//u; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JODW4//u"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-5309a20a55bso16794291cf.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790243763; cv=none;
        d=google.com; s=arc-20260327;
        b=qtTkXRYXDAjY9ZQUKTbO5XcIrDTXL8N71Ldds5V8uQdePdTYoyqY2sXeO91OyqBkT7
         GL+zVB2Qz02pyIoNJNKmY7g7ZMgm/G37T9rqlWRcQzQHdJGffT8K75VaQoD7qQKwyyjg
         VwlR68aHt5ygAhn9l0o/WX+HPlsGpJY1MDDeACQQm/4Af1/9nIOpqULWSKtxzlAO/xeL
         zXBX5O7xTk9+9yxlNal4kNNxAbF3iydTi5DLkMQz9KgJ4aPbYQPj8CNF2RPLwi022gLP
         OU4lMKg4qEL153hBOab4Or2nQgD97idT0wkrWhnFIx6xTjrVUANiw70bXa5JCKuTGvUJ
         tM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rM8Pnb3OaTJqlPgDl5Nu230H8PB3TRPyBVd+A2AcpH4=;
        fh=ZfwvmZM95CjSGHpP3PVt1m0p525lXJnW3hbBeqDD5wA=;
        b=XYKA1V0Uxu0KVnlVmWf4ZGmcuwiQoRG1GyeYv8awxajt1424kdnbNoHxqjDFHDhMiz
         6L2PA22+I6wOKCkk+I3oDArWJ1GSiGpuP10/zcGfvWdm0lAiqr7mvV54GS8zqlyS4ZW7
         lZJBDUmPcp52RPUg7Rb0PmJw5oLZ5UjcwVg6uHugP94AaVVjqndb4hhbx3LuoJC4smYk
         1Qc2KxzpDNugHeoGOduXRhArfl+orKRxJ6z1Uj3yQyT9/l+kCLU+k/319cvhhMIodAQl
         RLfxubKgleLHyKLzU2YMlZnucp1UgVgpbaSaqVqmqAkrmzN6fsah6y6k48vLulz1Yu6S
         wDXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790243763; x=1790848563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rM8Pnb3OaTJqlPgDl5Nu230H8PB3TRPyBVd+A2AcpH4=;
        b=JODW4//u3KjtFnoafHckYjbn/WXha6Zo9QUiqtgARpc7DjBG0mhE0WWH+hSp6QxsNm
         RfYVeBrlMNaoigggDW6bLYZkB/uWJilNXDFvbdrL36dL+fm5HmpCEUZ60jPpRQYZCPAw
         C/PM4Ypr9TRp0aRT/iAXkY+ck9MM5VKEqtGOKkZwp7Pe0cuc2nCPFuoFVFFfi7IGy3Kt
         k5Fv+L7nfpY1z6MkPu1vtql9PBXlqQ8A130evougp8/k8OVH0GzSToEOXITzEzSv0+0O
         hCpLEC4ltGH4PCVCEyb0S5OvP3NAzgIqZsERBJifrjKchVfuLn2YBZKdazPT5ztVnquF
         CRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243763; x=1790848563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rM8Pnb3OaTJqlPgDl5Nu230H8PB3TRPyBVd+A2AcpH4=;
        b=wA2+m4rZwCc96zkkmBntBCNM6U+xvCG8m37SgS6rWE8rU5QdIGNZmpi3V83vzHFvpa
         Y0hXFmjp/Y2QBnWtYe3Pxk8dgRwSCEH4PbrBdfzIP573QPdFO3w/eK2WDxI9FXxwDF5a
         XmaCG1ps7f+PpvPmk3Ulkwtl7XFpzstBuGEntTUCh1cHhzeAFvRW9h8HPj+BRP2Zfr8z
         8vXrfgTMK0bGR4M8+NRzeb/wgTbLNN9qv/Y2H4USDqn8zF6C2W1bKQ85flRDoB5QQO9z
         v0CC4vghlLtRwq7hqiERSnKIsY2MNnc8/k1KHbFqsXJr3iWGFP1ZXYQ1nFT8bzAWzThr
         Ys9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzOLZmPDUKpP7svojG5kWVrddOjRKIMX6TdGrkSd29w2ZyGejRq0O5rKM/1huwJY5bnZV3Q5l4=@vger.kernel.org
X-Gm-Message-State: AFuF++lH09wAvmQyEDTG/enE4D8rm+qXwUkT/ofXoEHwu8VismMNVdR1
	Tu2aQ0LvJ/+oqZP0JnemusXHROTP0NZa0EV/9EN/eQH5KR8olVjqSDqULveg1bD7Ake8qTX9NQN
	Rlfd1ymU4cq0PXqCIx+0yU+G55ySEtAOzpeS/lUWr
X-Gm-Gg: AYBFou2btRrVg8Kho0Bn45v4fFl1XQq2++s8574e5kCVcGZZ3ZbRupxPRh/tLAGbrhZ
	mkkE24N+8+j9+ByC5PggNeICCL1caqzX9UxQWYbj6nveqvJqUl3uxLptrQtmZ4H9l/h/sWmVlr2
	fwWZ67jCBj4RI2YHa3L/Zp7/SPS91rtsuzO8KWlEf+PVlBY86KEfRxJyLFXlqXzGzIFCGDPEWnn
	GvitarPwvEkTu+0+j2kvS1WoTHsn53ya83cOLj8MVhryFP8uIRZqG0eaXnw6vLauSJRwRWw3o5t
	V1yoRrSBALjqY6959OUO5FqVbE0DPHS2C2AMtZwoPUaDUZ4toi2lEuEIyZFXPOyzV7jUwGxunnl
	ii9IbmlPGM9miadSnKt1tYTiC/88/3yIW06MwGjC+jI+sH0N6KdYiycFdOQxJtbSRiZxv
X-Received: by 2002:a05:622a:5a0f:b0:532:8f15:2744 with SMTP id
 d75a77b69052e-532fea4d150mr14339051cf.20.1790243762050; Thu, 24 Sep 2026
 02:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924080219.1036588-1-caixinchen1@huawei.com>
 <CANn89iJVGmYwQerOixGurH6vw-GtvSAQq6u6zSNZoyZrcEx6Jw@mail.gmail.com> <d8c12b4e-4ff2-4c62-a40d-d67bb4680a0d@huawei.com>
In-Reply-To: <d8c12b4e-4ff2-4c62-a40d-d67bb4680a0d@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 11:55:50 +0200
X-Gm-Features: AclHuK_LOWvzBhJczhAfbtW30YiVgV1gD1vN5_bi3qPOiAKB6UaaHqyDAfOb9kg
Message-ID: <CANn89iLA55e6evpx__7AUQF45uYAbUHxRtz4rVT=vsKpqBRWkA@mail.gmail.com>
Subject: Re: [PATCH RFC -next 0/5] net: charge socket memory budget to memcg upfront
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, kuniyu@google.com, 
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org, ncardwell@google.com, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:25=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.co=
m> wrote:
>
> Hi,
>
> Thank you for the review.
>
> We found that sk_forward_alloc is a plain int updated by a non-atomic
> RMW (sk_forward_alloc_add(), where even the read side is not
> READ_ONCE), and its writers span three unrelated lock domains:
>
>    - socket lock, process context: SO_RESERVE_MEM and TX grants
>       (__sk_mem_schedule(), sk_forced_mem_schedule());
>
>    - receive-queue lock, softirq: UDP RX charges and the
>       udp_rmem_release() fold;
>
>    - no lock at all: sk_mem_charge()/sk_mem_uncharge() from
>       skb_set_owner_r() and skb destructors, and the sk_mem_reclaim()
>       fold itself.
>
> Any cross-domain pair loses an update.  A lost charge is still
> returned in full by the matching skb free, so it resurfaces as a
> phantom surplus in sk_forward_alloc, and the next fold hands it back
> to the memcg via __sk_mem_reduce_allocated() ->
> mem_cgroup_sk_uncharge() - an uncharge with no matching charge.
>
> We first tried to fix it with locks, and hit three walls:
>
>    - the socket lock cannot be used: its holders free skbs (e.g.
>       tcp_recvmsg()), and the destructor's sk_mem_uncharge() would
>       need to re-acquire it - recursion.  That is why these helpers
>       are lockless in the first place;
>
>    - a new per-socket spinlock serializes the RMWs but not the bug:
>       __sk_mem_schedule() publishes the grant before the memcg charge,
>       and the charge may sleep (GFP_KERNEL, memcg reclaim/OOM), so no
>       spinlock can cover both steps; a fold in that window can still
>       refund pages whose charge afterwards fails;
>
>    - such a lock would also sit on the per-packet charge/uncharge
>       paths, exactly the hot path the cacheline layout around
>       sk_forward_alloc was tuned to keep cheap.
>
> Are there any good solutions to solve this problem?

Perfect, you now gave us what we need.

UDP is broken, it should be easy to fix without breaking TCP.

I am surprised your LLM went to a completelly broken path.

sk_forward_alloc is never supposed to be updated locklessly across
multiple lock domains:

- For TCP, sk_forward_alloc is strictly serialized by the socket lock
  (lock_sock / bh_lock_sock). TCP does not use sock_rfree() as an skb
  destructor (sk_mem_uncharge() is called under the socket lock in
  tcp_eat_recv_skb() and sk_wmem_free_skb(), while TX destructors
  sock_wfree() / tcp_wfree() only touch sk_wmem_alloc).

- For UDP, sk_forward_alloc is serialized by sk->sk_receive_queue.lock
  (in __udp_enqueue_schedule_skb() and udp_rmem_release()).

Your reproducer and analysis point to two specific places that violate
these locking rules:

1. SO_RESERVE_MEM on UDP sockets:
   SO_RESERVE_MEM (commit 2bb2f5fb21b0, "net: add new socket option
   SO_RESERVE_MEM") was designed for TCP, where sk_forward_alloc is
   protected by lock_sock(sk) and sk_mem_reclaim() checks
   sk_unused_reserved_mem(sk).

   However, sock_reserve_memory() only checks sk_has_account(sk), which
   also matches UDP. UDP does not support SO_RESERVE_MEM:
   udp_rmem_release() does not check sk_unused_reserved_mem(sk) (so the
   first recv() reclaims the reserved pages from sk_forward_alloc), and
   setsockopt(SO_RESERVE_MEM) only holds lock_sock(sk) instead of
   sk->sk_receive_queue.lock, racing with __udp_enqueue_schedule_skb()
   and udp_rmem_release().

   We can fix this directly in sock_reserve_memory():
diff --git a/net/core/sock.c b/net/core/sock.c
index 1d5927cd49a1..763c2017d9ef 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1034,7 +1034,7 @@ static int sock_reserve_memory(struct sock *sk, int b=
ytes)
  bool charged;
  int pages;

- if (!mem_cgroup_sk_enabled(sk) || !sk_has_account(sk))
+ if (!mem_cgroup_sk_enabled(sk) || !sk_is_tcp(sk))
  return -EOPNOTSUPP;

2. BPF sockmap (net/core/skmsg.c):
   As you noted in the reproducer comments, sk_psock_skb_ingress() and
   sk_psock_skb_ingress_self() call sk_rmem_schedule() and
   skb_set_owner_r() (which installs sock_rfree() as skb->destructor)
   from sk_psock_backlog() or after dropping sk_receive_queue.lock in
   udp_read_skb(). Calling skb_set_owner_r() / sock_rfree() without the
   socket lock (or sk_receive_queue.lock for UDP) on protocols with
   sk_has_account(sk) is a bug in net/core/skmsg.c and should be fixed
   there.
