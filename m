Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F846A610
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521578; cv=none; b=phHNqZl+s2lP8BumLPoYjvUJEFfiIitveM39iyI4yzmdXAlxyJIqjBanlICMjmodhe4gD6RNxLoQ0hTMrOVRbNxGLeyzl3Wr9Jsgp8fcXiFWhsYcbdq8y6uh559jkEYZcUEj4gTrtQ5bDT8uPn1xLuWnnzHMk4HNbLW4EyEvbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521578; c=relaxed/simple;
	bh=BU3Lg1eye0sdeBmWWx0eAbd32eviItFQ+wO4ExV3ONA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e7BAuxcUC2PeRMzw3aJLVK1mhsePerybn6uOfnG2SUmupT5AnMy9fgOwmWRElY8NzDoXzm70skL4nnVy94pGT8dUZWtyKDMcW8/S/axgfMj+1iAawIiW/rCAEVH2dQqYPw/eCLXE5uOroMXTvdXOWm+A1VXpCGMld6mXhLOTDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GdMP8+r9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GdMP8+r9"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso1108018a12.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1788521575; x=1789126375; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i6CRTCy8eDFjapCheOt3lFIeeUgsyzTe9j9fLYMiEqI=;
        b=GdMP8+r9mgBDVtKY7HT4ZcmQsRYhUrxHWdXheh7LhnZvGj8iv0fZ3bmt+xeqvRiOl8
         iUolCiVrp94mw45ErWpTpTWrSQGyY4/FfHlz/ZJQBshL2lBTG8CmeFs8KZmsvOVrBmYS
         p2b5MXXMBI4bjGpevrlPcyozuukcHhSgVKD+jMO2z3f9npWMZWFP+Rpvgepei+CviWBG
         dBnmVjyrUmD7BiYlI73OXBB7ffdkqX+eZgdOg8zWtANUWKSwJ6fi2iiMj2Qum2bMKBdo
         7KUEAVJCaQJK0KasRO4BDPmZnaEzrTPfCLgLmx18xACiGcJ/kcwihXF5uHi3a+Z87Yet
         UVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521575; x=1789126375;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i6CRTCy8eDFjapCheOt3lFIeeUgsyzTe9j9fLYMiEqI=;
        b=UVSIC/oE8HNBe5SdtEjYkdYtI/81nJn6dKSrS1XD+d+JAvF+jmKPG/u24ciMsr19da
         7wRjP8MVE7PUGTF/fY8ofernGRxJeeP6g4Ay6w+vreM0S5He7YZtnD+dSUDFnw46/vTl
         Z072K90gldupbxsHnq+8SPBqDOpZI+qfOP9R7uZqcPAEypZPQiGtg1JUzFGyO1kg01Tc
         MCSG+i1TdsWYhcN+vnYD3c1qOIQCFyWx+a0nfOThbQ4DmvuRePZnK2pNw2pJZCEkoLqy
         hHJYiKf4q4LtCsqgMTCNNF7MuALsdVacgJiEtc82S2ReVCGNQYv5buUS8r1OxSHlGCNk
         v+Yg==
X-Forwarded-Encrypted: i=1; AKwUvBxRVHrOwW6ruaeXkMjeljqB9YNGApGOAkXCIloNrQ5YAYQnZiyCp4BRgi9qM5zAV8m9HxY0fu4=@vger.kernel.org
X-Gm-Message-State: AFuF++l1O2OinB5rXQwf1EzErIveyoMeBn1xucpUrBhvBQ84h0BkgKfk
	8pId/gA2js5eEgGkcr6HSgWLXKQ41rt2N2RWFlnzvuNZtUZB6aCzfT8hOKxHBBEHJp4=
X-Gm-Gg: AYBFou2YWde8xGzGhcBXNGTsV48LPojEyyR0iSwzxuPAhVidGIJhWNjZBjaYuIt5Yje
	5XJ9S55Fo74hylE8N/CV4XdVKKGsKbJsrRo00Lm8ppQw7Ba33tZVzta0Sr5+NbgVFCMi/Ffh529
	o9aWw9zrTkGOcogA9e/bCNBXj9zNQ4ItPKxCv6YihGRirpGxQ2vSEZUk/9VFB/gm4Ajg/bKgZjW
	hLLOF3MpAVdNxVPCcIGGOKkRJ7r7fVK7g8jtrmkdfyqL49ZZzsO0joKQWVLWBosgfa+7rfQg2zV
	LadFCurGI1vCK6gIJKUmf3JDJt0Vp4tAR0+KA5f/Itdt8pdgQAvXIq0YHQv3+DpGxRKxq8s70Se
	8FNMsTJoR10BUfsSHS74K554+N52ktMVcmpV/hLdXliwJizxK6OeJIrU967SZI+QvoqwiA5/kXw
	FXkG5TaL/78/0pdOxhsOO0GXTwURX/QDDrUCdW8tl9GsBTS7zQ0HA0zvh/ibU8WQ==
X-Received: by 2002:a05:6402:350f:b0:698:663d:d7bd with SMTP id 4fb4d7f45d1cf-6a7e90a9fa9mr2058304a12.11.1788521575111;
        Fri, 04 Sep 2026 04:32:55 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68e9889sm1030310a12.22.2026.09.04.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:32:54 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Neal Cardwell <ncardwell@google.com>,  Willem de
 Bruijn <willemb@google.com>,  David Ahern <dsahern@kernel.org>,  Ido
 Schimmel <idosch@nvidia.com>,  Simon Horman <horms@kernel.org>,  Kuniyuki
 Iwashima <kuni1840@gmail.com>,  netdev@vger.kernel.org,  Kyle Zeng
 <kylebot@openai.com>,  Michal Luczaj <mhal@rbox.co>,  Hyunwoo Kim
 <imv4bel@gmail.com>
Subject: Re: [PATCH v1 net-next 1/2] tcp: Do not allow buggy transitions
 between ehash and lhash2.
In-Reply-To: <20260904033543.2635540-2-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Fri, 4 Sep 2026 03:35:28 +0000")
References: <20260904033543.2635540-1-kuniyu@google.com>
	<20260904033543.2635540-2-kuniyu@google.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 04 Sep 2026 13:32:53 +0200
Message-ID: <87fqzp2qvu.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 04, 2026 at 03:35 AM GMT, Kuniyuki Iwashima wrote:
> The following state transitions have long been a playground for
> syzbot, and recently AI joined in, reporting a lot more bugs.
>
>   * listen() + shutdown() + connect()
>   * connect() + connect(AF_UNSPEC) + listen()
>
> All the fix attempts would add more code to the fast path, which
> is not worth it.
>
> Instead of playing whack-a-mole with these edge-case bugs,
> let's disallow these transitions.
>
> Note that unhashed_state is placed in the 4-byte hole after
> icsk_pmtu_cookie.
>
>   $ pahole -C inet_connection_sock vmlinux
>   struct inet_connection_sock {
>   ...
> 	__u32                      icsk_pmtu_cookie;     /*  1208     4 */
> 	unsigned char              unhashed_state;       /*  1212     1 */
>
> 	/* XXX 3 bytes hole, try to pack */
>
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Closes: https://lore.kernel.org/netdev/20260731140512.566464-1-david.lee@trailofbits.com/
> Reported-by: Michal Luczaj <mhal@rbox.co>
> Closes: https://lore.kernel.org/netdev/20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co/
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260824033331.1084971-1-imv4bel@gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/inet_connection_sock.h |  1 +
>  net/ipv4/inet_connection_sock.c    |  1 +
>  net/ipv4/inet_hashtables.c         | 11 +++++++++++
>  3 files changed, 13 insertions(+)
>
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
> index 433c2df23076..903499581db7 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -94,6 +94,7 @@ struct inet_connection_sock {
>  	u32			  icsk_rto_max;
>  	__u32                     icsk_delack_max;
>  	__u32			  icsk_pmtu_cookie;
> +	unsigned char		  unhashed_state;
>  	const struct tcp_congestion_ops *icsk_ca_ops;
>  	const struct inet_connection_sock_af_ops *icsk_af_ops;
>  	const struct tcp_ulp_ops  *icsk_ulp_ops;

Glad we went in that direction in the end. Makes like easier.

Nit: Could be a flag, like CAN_LISTEN or CAN_CONNECT?
Either INET_FLAGS_* or maybe we need ICSK_FLAGS_*?

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
