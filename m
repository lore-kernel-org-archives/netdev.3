Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6C489FB8
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837475; cv=none; b=Wb/KkvZ9Z+aaVskTpmLYDbrcxeynWJLX1OojDD0vXaKYXaJEybbdGUmni+Vw9fWPS3UX8W5OA6HsVb4wTPggLwuZTulXaQodSUDE8lTJ0pNCNz18kitOeQn6XMb5Wmp9DNm4aD4w00kIblQBOCWF2QfL/jlaoBqPslSHMLUXyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837475; c=relaxed/simple;
	bh=s8rtgKWRRS80c47z9nzG+8745oEYeKy41bdZn7F2plw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTqPcGUJR5iOHPjMWAVKPNsQl6cOPHOKo3TitFd23E+AIprRQq77tOzSN/7QKMxFTZEBKEEUBFVyk2aA72m/L1r9/q3iUTPanaa7zUSZxo7Y9uf9tQG6hpAWm/8Wn8fsMYQczUJHLlO3BMAj1F+JOXO7KwSTYvlT4RQc5Y5WOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YijIE4tS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YijIE4tS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF7E1F00899
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 06:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790837474;
	bh=tc0WuOcPvlQkZSiAYiAEjpw6L9xG7pWHl0MxsPEypbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YijIE4tSNmtsRu93gHSXVba3ogjm+P19zMuIcFw8y3AUbGowE5/ICvtc5f0smcAMm
	 DmUztdTxU500ndgYvsW0t+cQAxRvI5zjApNrVa/UjeUklu1lyQf1z0rsDmn35TDRtJ
	 +D9vqdFiO7x9G4ZyjqFP5EZcayBm1LzRNy2LHqVGhZQoRgR8bKXJzAD6jDD9uuUzA4
	 NPup+pz6L/4dxNdiADhYtlw7yQ1eo9k1yPIrCOYAJyjzsDnedzDe5GubHMcEtcClMa
	 Q7T5qZRuID+hICeHYJ/s0XmMmE9igh85oq30n1HkVfM/PUxGIy6oY48QCNlpDCfj5L
	 /6vo1YfZDeb7g==
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-821ff9f018bso1591a34.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 23:51:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxfp6OH3uj0Y5oZTz2jZh2F30TviK7Lq1cysfcb6m5axYV6nUIymuXzIY74dXOXZRmNB2P+ook=@vger.kernel.org
X-Gm-Message-State: AFuF++lzsxwpo1nboahOrm58s8LAI9eWgPoHLHsRSvA83hHm1JjQnHS0
	WW+De/mrog1ujp34WAWfXW37zNh2/55wycsR/J8PyGkq2b0VWH43j0Eb+uJ3FJ7wrLf6I5a6wGp
	vy0a4MsNCCyoVDIGh54eOKrT0TOOuRx0=
X-Received: by 2002:a05:6830:3915:b0:812:3ec6:58a2 with SMTP id
 46e09a7af769-8204980b242mr4492787a34.12.1790837473314; Wed, 30 Sep 2026
 23:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930220137.843785-1-kuniyu@google.com>
In-Reply-To: <20260930220137.843785-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 1 Oct 2026 08:51:02 +0200
X-Gmail-Original-Message-ID: <CAL4Wiio7qk+nd8RdLLTdE9RKS-jPkQUeWdh3n7BHHQ6ib6vQrg@mail.gmail.com>
X-Gm-Features: AclHuK_ZjzFtGvJwl8Pri_sQVnf7v2y837-xoYfKN1CIdicb2QcOzByocWXO79M
Message-ID: <CAL4Wiio7qk+nd8RdLLTdE9RKS-jPkQUeWdh3n7BHHQ6ib6vQrg@mail.gmail.com>
Subject: Re: [PATCH v1 net] ref_tracker: Don't use __GFP_NOFAIL for
 PF_MEMALLOC thread.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+f95c2f0a71a98cef50eb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:01=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> syzbot triggered a warning in __alloc_pages_slowpath(). [0]
>
> ref_tracker_alloc() uses __GFP_NOFAIL if the passed gfp has
> __GFP_DIRECT_RECLAIM.
>
> However, cifs_demultiplex_thread() calls memalloc_noreclaim_save()
> and its kthread has PF_MEMALLOC.
>
> As commented in __alloc_pages_slowpath(), __GFP_NOFAIL should
> not be used for PF_MEMALLOC thread.
>
>         if (unlikely(nofail)) {
> ...
>                 /*
>                  * PF_MEMALLOC request from this context is rather bizarr=
e
>                  * because we cannot reclaim anything and only can loop w=
aiting
>                  * for somebody to do a work for us.
>                  */
>                 WARN_ON_ONCE(current->flags & PF_MEMALLOC);
>
> Let's avoid using __GFP_NOFAIL for PF_MEMALLOC thread.
>
>
> Fixes: 4e66934eaadc ("lib: add reference counting tracking infrastructure=
")
> Reported-by: syzbot+f95c2f0a71a98cef50eb@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6abd860c.9b478af7.e8d7a.0000.GAE@g=
oogle.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks!
