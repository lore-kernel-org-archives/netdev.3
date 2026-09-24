Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FC43F4B1
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238404; cv=pass; b=cps2X/tyw/mYUAhgeDk207jkIIBZUIoU/ZXrVgiQvIOoa2igtOXEh5zgkQI50IVZY4Oeir+XJhtwSycuZDoFgIgfbal2wktERzKY24zihbSEh/bBrGg868zRXDKISllMgftxGGaY7JPmn7icd3tqKVzTkbZr/trjFAnQp9JOu/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238404; c=relaxed/simple;
	bh=svx/lXpxbyRvC5hg9Mf7leQZBgztlGdMd/1meLurTMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fed03x3FuuXS/Lo7SMUVam4L4RwQdRNKYwLPjLVArccKEeP9kbHTTYXIxJbTzHbbzXaz614qYowYUitOsi52vRidqe4DfWjc96NwJJ23njSS7JnaRdyzu/Ebj3y5pU41bSw1Y51GQgkeoiS9C3aKacHMezkKMr3GBcXHbj3fswE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GbaUbnw3; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbaUbnw3"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb767d286so14979761cf.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790238399; cv=none;
        d=google.com; s=arc-20260327;
        b=ZIsAU3Pl8aWjDYqlvdQSNyXUv+gDROcXxVdstZ/S/qoAKHCYfmNa5mJXhRv2B2idgI
         9NtXfqAYQOD95mj/Ddw0yZ2CDsZZvNKcyUM/hUMZpBbGbjzekkVqCYs627kTloA/Y4ud
         CZb5wewDasqKg+6PTw1+Jx3XIzbprfIQTRe6GxBOAt9jaLrGWc54d0JbUhEXTmQMdG4G
         Va/UAFA0hLljBAJRFfDRybDsu63iGkl9PFxRtRPa/rfQ6SgzfDnpWKrH3OeRiZBPIjwT
         4M0m1dJK63R7BSsOKdm+ld8D8wv3/otal1U3d4l/25GYMprjDFip9OHNvDPyAgyLeb9w
         3ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Djx86NYnyz/9RFz/5fi7+M66lo0Fi/FSUEqHr4nGVIo=;
        fh=WRdcciyP2WSVaW3bFfHI+v3Atm1HUheOVUSY3e81ZNE=;
        b=nVERfMKUs/PITXMTwHF/GkVB3P2L6ac3RsYcgJdBKgnXvucWfRhNYXWZ2c9QW8VHGu
         3KAvcHR7Z+tpMWHaM1VVmv6oNMOcM8txIQDLi8I7vm/9tTsJ+KB4Yk4KyjlPzJ2P0mtF
         ACm1SZ6JpDLoqcs5/OaKglt50h5c0wfgpA+pK6p2Vfwmc8L6NYy8IGll1qSPztj0/Eiu
         u7fpHY5h+5lFC19VyjU9uZg7N0y1vH3eFRGuGYLoRg8c7VDQF1dxwrefNQw+am0/T6AJ
         F5MWy74V8MeFBHZqdxsAWlpE0XCk8t9PY9uMJqkYuduyum4x+QtaixpcCrm3pxEYidwc
         0NGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790238399; x=1790843199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Djx86NYnyz/9RFz/5fi7+M66lo0Fi/FSUEqHr4nGVIo=;
        b=GbaUbnw3MbE4686aB+MUIX/nDidDE5Z3rBo4OINjyQc5X+3lgamt4CS62TDWDKCzf4
         3YX0Zu/YXQveN+I17TTkN6ju8/1eSPhPaSW2cEdqgAfj0cfBPDVIXIwrFy/aY0F0wwgO
         VH27RZJnQx7wBVgFWGlJNReK97nLue5IdRNvUORFBBbNku6xLlOUNAckvX7mxVU/39Bl
         7/BmiqJtr97Sw1pr4pBxWv4fMGQuBDcxVSMncumxC4o/Hpz1jHnJ1aC5asLvz2+FVkxm
         bRLxuEOE1Lz80cbD16xla54/+5FPb3Dwle2zh+7Ncw3lP84bGtx+8pG9M5EyKrvDY9TN
         k4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238399; x=1790843199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Djx86NYnyz/9RFz/5fi7+M66lo0Fi/FSUEqHr4nGVIo=;
        b=SjZVuagXssVAzKZ6OLpYnWGgMa56RPDfEf3gzZQXNvRpMQdk98OFp+zSWHvz6xe2ZK
         nIT/n9q9k0OYaG18WD6aLNgu3NgEsmTCzipTuE8wRPTLULqXuo/+ZaP0CIEASCxZygWK
         FTdRVs67XSlyVHqcokzlODwKg5kVHhKNANPZ+qq/w6JwYDmjvogveCZPI1SynIx/s9G9
         KOv11qt9TzsnuqZCjbEwUnHK7o7X604Py0HmQVjM3dq6MMWTJkMnfDaqfVp6GBHSl7a/
         8pa0dMLRgZ+Csg8xFi0mskVcxkayS39BFGr+EZx3peKWxpunpHsDcVPmYgtwY7+xJmlN
         zRuA==
X-Forwarded-Encrypted: i=1; AKwUvBxdk9Emyu3X4xrdzgcnBs9dudSP9QB6zbL0gUTOmPT9Z0FKw8ot2FpB0Szdd5yTMhqf1zkrWhA=@vger.kernel.org
X-Gm-Message-State: AFuF++kRoMZiTaRhy9DlohRDjigyXtSo/AGNPn3VuLnaDtv1A0kTo5QE
	/7Oz2W8jWs+IKRxPG6BVpnS3R4DLVa3RIgAvhKU+WqkPeuIqMeELWpTW0HH4lRqLO05ZD0b6KaN
	47H+zEZi0d5kO5aUf3zIIzDyQAmALHgJWEC/eZisa
X-Gm-Gg: AYBFou2/NJmE3dBUL1+UsWjeo2ZYn3KWd0qBOt3AogLaULx7kj6uCO+bU5Guy4oCRMa
	/v2ndSu3hliVmftqx34gc5sICrYUZV+ikW9MCG9XsGsmC2SwIu6c2dv1NpyU2ahx8B6iiDhKlhG
	eVTpWUCvSVakgpComRnV5gMkA6V+uOQBGaXBetT+Exq8HIs5+JaKSqukLJyi/1wlWrDwcZ3nT25
	lPnH1XjEXs/tapgBPwD9ldEv8k2QyQlbbPMd78loAw76eHsO/K9hMBI0ML8nXEf9ntcLvy7tMd+
	hmU1BhjVYEIc4J1aJSEN0j6e8V9fJOPhuZyqg60a3kLHTWu67uq6HM5pVjxeOn7lOP0kzTeznUT
	rXnNRBxT4vAFCHShZH+9VJ08Jq6pkV4WbUcepRa/uhxJTXRDs+sFA5zT7f9sW5ZJL/15q
X-Received: by 2002:a05:622a:4185:b0:532:d0ab:f3cb with SMTP id
 d75a77b69052e-532feb52734mr11578341cf.59.1790238398107; Thu, 24 Sep 2026
 01:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924080219.1036588-1-caixinchen1@huawei.com>
In-Reply-To: <20260924080219.1036588-1-caixinchen1@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 10:26:25 +0200
X-Gm-Features: AclHuK9XSbyZhfSiccnO7XKdYo-g6nGD7WSG7r9j6ZGeEHZyUxcT2PFsdbnfwn4
Message-ID: <CANn89iJVGmYwQerOixGurH6vw-GtvSAQq6u6zSNZoyZrcEx6Jw@mail.gmail.com>
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

On Thu, Sep 24, 2026 at 9:36=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> The memcg socket accounting currently charges pages to the memory
> cgroup per grant (__sk_mem_schedule() publishing forward allocation)
> and refunds them later from skb destructors.  The refund side folds
> per-skb "was this charged" snapshots back into the socket balance
> under concurrent lockless RMW, and races there can drive the memcg
> socket balance negative, ending with:
>
>     page_counter underflow
>     WARNING: ... mm/page_counter.c ... page_counter_cancel()
>
> This series flips the model: a socket is charged its whole memory
> budget (sk_sndbuf + sk_rcvbuf + sk_reserved_mem) to its memcg when the
> budget is established or grows, and refunded when the budget shrinks
> or the socket dies.  Grants and per-skb charge/uncharge stop touching
> the memcg entirely, so the racy refund pairing has no code left to go
> wrong: refunds can never exceed charges and the balance cannot
> underflow by construction.
>
> Tested: full arm64 build with 0 warnings; each intermediate state
> compiles (bisectable); tools/testing/selftests/cgroup builds clean.
> Runtime validation on the workload that used to trigger the underflow
> is pending.
>


Charging sk_sndbuf + sk_rcvbuf upfront to memory.current is not
viable, especially for servers handling large numbers of connections
(e.g. 1 million TCP sockets):

We specifically went in the exact opposite direction in commit
4890b686f408 ("net: keep sk->sk_forward_alloc as small as possible")
to make sure idle sockets hold zero forward-allocated memory and
non-idle sockets hold less than one page (4 KB) in sk_forward_alloc.


1. Massive phantom memory charges and false OOMs:
   With default sysctl_tcp_wmem[1] (16 KB) and sysctl_tcp_rmem[1]
   (128 KB), 1 million completely idle TCP sockets immediately charge
   144 GB to the cgroup's memory.current while holding 0 bytes of
   actual packet buffers.
   Worse, once TCP autotuning grows sk_rcvbuf / sk_sndbuf during a
   short burst (up to tcp_rmem[2] =3D 6 MB and tcp_wmem[2] =3D 4 MB by
   default), TCP does not shrink sk_rcvbuf or sk_sndbuf when the queues
   drain and the connection becomes idle again. 1 million long-lived,
   mostly-idle connections would permanently pin hundreds of GBs (up to
   several TBs) of non-existent memory in memory.current, forcing the
   memcg into constant reclaim thrashing of real page cache/anon pages
   and triggering premature memcg OOM kills.

2. Overcommitted caps vs. physical reservations:
   sk_sndbuf and sk_rcvbuf are per-socket upper bounds that are heavily
   overcommitted across sockets, not reservations (unlike SO_RESERVE_MEM).
   Comparing this to vm_committed_as is flawed: vm_committed_as tracks
   virtual address space overcommit globally and is never charged to
   memcg's memory.current for the exact same reason.

3. Broken memcg limit enforcement (memory.max bypass):
   __sk_mem_raise_allocated() drops mem_cgroup_sk_charge() completely,
   while sk_memcg_budget_sync() ignores charge failures ("the new budget
   is used uncharged"). When a cgroup reaches memory.max,
   sk_memcg_budget_sync() fails in sock_init_data_uid(), tcp_init_sock(),
   setsockopt(SO_SNDBUF/SO_RCVBUF), or autotuning, yet sk_sndbuf and
   sk_rcvbuf are still raised. Subsequent skb allocations in
   __sk_mem_schedule() will then allocate real physical memory without
   charging the memcg at all.

4. Unnecessary struct sock bloat and hot-path overhead:
   - Adds 8 bytes (sk_memcg_budget + sk_memcg_budget_lock) to struct sock
     (even when !CONFIG_MEMCG).
   - Acquires spin_lock_bh(&sk->sk_memcg_budget_lock) inside
     sk_mem_reclaim().
   - Every TCP socket creation charges rmem_default + wmem_default
     (416 KB) in sock_init_data_uid() and immediately uncharges 272 KB
     in tcp_init_sock().

If you are hitting a page_counter underflow race in socket memcg
accounting, please share the exact race / stack trace and fix the
underlying accounting bug rather than charging uncommitted buffer limits.
