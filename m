Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69114A689A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417658; cv=pass; b=j/74BeCSWSqtGpK3Weg+Rithr6TyLf8PVTR+vRQxWUUi092xFiAfYdhodh73aMZnzczjPzgniyiGERtuylUodDXwbSS0Np1C/kLmhroXx8CQ6Z31+QTOHttxj/EtXv5rJmoZJYxxVNAxj3M+8c5oRY5zlM4OJgjRgPE4KWOesCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417658; c=relaxed/simple;
	bh=YWYhOgkKHQZ9PyVJhLrYyT+7wvmGiap7HVsmNYYknnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiA6phHIu7/HG79Bdgebrm1tUlb7IV5u4GEN4Y/VH+++a/snpUzp1EzdhdSgglUyfYDlbko0CZE/LHTl6EhDO2QtSq3zePUofEdm5SAzyWpidgtqPUA3l3l0Qofu7ijER+D6daP1fA0GRIIV/nEhUIcmcRxvny9trETcZBwBh+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ZhXb9L3E; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ZhXb9L3E"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-89d6bd67045so859184b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792417656; cv=none;
        d=google.com; s=arc-20260327;
        b=BrvUHT7MwCmiyKJoTGp6CLVHS32r1xeBEC7IcTA9JCrZldtvPjdAp+rm7w9h1VkHXd
         fyjOPKk69iXpAvRI+FY32X6NyiXd5EnQZOx/0v2Xz+7XJW3UtD5eNoD01fJ0cIbCCcsL
         8PIG9ySWNB2e+gkgPPd2qbttV5+jnrqS60mxCOzx6TQa6xbnkkHW8xd0t9w8/YUMl9ON
         MLPeVGZ/atq9SYR+TB/6ZPIoYpKiNBIJ5ow/eYVPnozgvkMAkRB9NcyECtzyrICGuKuq
         T7D9lBBJAwqwAWnzbZqHx0ESRMcUDhi1ikrZ/0S0b9BYMb/OiQkbTLtufjrwuuEEqHxs
         M9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IxkYfjbbzXtZyJeIqZ6QLhzxAx1ox5CXI9h6Gt01KUU=;
        fh=v1ruOtZGuvETx+98FBJCDsA/4QOspvRxhalQUISItZ0=;
        b=mYaKOry/6mlvdReD/g6Of+wKKPZrE5p4W9tIP3fzgzy2hcjohI+kDoWBqKPQ8r964s
         3eiHQjwZly3mdFU1VObjJKNecuiEcRSKC6E+PEjITPutTNZEmPAsauX8jpEPs+YbxFQw
         gMLd44ZaF9hbCUoRlkyM7qIuNYoOG1sYfiETxhsFakqMtfl3BRlDOs0Nta4M0KqhCyox
         KEP608YCW2FbyPM6u2Ha5RL/Img43xbXtZCDiFkTIjIzfN5SsmoIAG/REZIkbWDx3s/D
         EGQmLvhiNH3W3VAXxGeMwF5adNItbKlOMqTUZml0rQ1Jly1xPMJeuQ6rtYKew9mZz15E
         C3/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792417656; x=1793022456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IxkYfjbbzXtZyJeIqZ6QLhzxAx1ox5CXI9h6Gt01KUU=;
        b=ZhXb9L3E3/2CC8Hj0djjaIzM945Hrz1Qg+GN7jxGm2PXj64jC9KsL+3z9iW5NGIugK
         CbV3zCTrKmxLZdKbrNnwgzCLQrYctvJSL7NeXZqPwDWs+0012C5NlIdbCIPR08WpIEHn
         yWA6L4GDoCa6tY3welmT+jDb9zscZgdnPg9sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417656; x=1793022456;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxkYfjbbzXtZyJeIqZ6QLhzxAx1ox5CXI9h6Gt01KUU=;
        b=1sUAsrD8dugTd/Td5je/K+ENsDqH0gywkPxa1BWg1tN1p9KoI61N69Rh3Yc+2O+J4P
         KK1ihoSWxXPv85r+8qBMh8XyoFmAxieroE8/n/W0F+xbrGPkcGDg3G0j7M0CuCRB9eVo
         iTGeyX6BoJhObWdCS9ZLh7WvgRZjXHmynkYkM9kJdjrTCcevjeGDwm/cYZki2VCHTYwk
         ZOaMb0F/DRZiP01ZVMt7URJEKEu2hid0eFDowyTVZ2YeYm1l9tCN/bFXhaDmSyMSCdqC
         93Zf9tWwBkoHPHDl8ZR+xYnUpFc8SS2mII01RJyV32j+YOgQKd9HAVFgZsmY2O2WliBh
         NAcA==
X-Gm-Message-State: AFq9FYKKZaW3ybVvjVYH0K66I4q2HMxY2sK+O1gM2cfhoccfFwtvz3i3
	rFY2KC1jUPdoDJq9ZiQQ0BaCmoL0wd7VW+49GvYVV8UPOrYQcpmZJuVbLo8a1IuqUDvTuJNNNHJ
	IqvCEKfkkL5EyOHIssedY3/aWlUgC0L5g3kmPnQjA
X-Gm-Gg: AYBFou2wpbr0iF05b75/FpiQS1W1lA95WOrs7Oh4IzzXeWC2B+lz7sZTE6VJNz3yFAt
	8EJzcQX+tMPRCZOdWTRGOS1fgxqX6xYwqAK1aD8oIvfSh2yZmn+gGqLnHzqjoDLk8VvQYIWQbMG
	OxKMPZvD0BzwOywsEoDX19gGVBDHTHHBRkhEtRI/cJLwzzBSqWMCi+FsXihPoT4IjenIvkkRhQ8
	9gGz6YGwtM1XFIDYjSgUquglWRuM1X1dB0do6P1jRMwuFsmfSEUBiKs3Iksi1BbH3tFV0r3gdrP
	26OLLc6e8cw+FynRwA+XbgyB8NFwkcXq05oE0U47Z2dOk1TYiMSR7J5bGQi81vsz5aETD4nOfS4
	0viIDyToSCIiQJeMGKIAf0Mlk2DCIypc5s7Gq9zpLJUxQ
X-Received: by 2002:a05:6a00:2d1a:b0:89f:f166:e221 with SMTP id
 d2e1a72fcca58-89ff166e494mr5001339b3a.46.1792417655490; Mon, 19 Oct 2026
 06:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com> <QDISC-5RTM.v2.r0.20261015051735-1@mojatatu.com>
 <87ld7t3kl3.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87ld7t3kl3.fsf@all.your.base.are.belong.to.us>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 19 Oct 2026 09:47:21 -0400
X-Gm-Features: AclHuK_kzp92HQLPFnjpkI2erNoFI6v8vjMiGON8GWcsHv6WbmNHliLjXp1wBk8
Message-ID: <CAM0EoMmL1Yjo67wOmOwWtfYLNrVFH7zSbgDtx2Rg+k3-Nu4QOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cake@lists.bufferbloat.net, 
	Victor Nogueira <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Bj=C3=B6rn,

On Mon, Oct 19, 2026 at 9:07=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake: fix
> > autorate reconfiguration throttling").  That change only stored
> > last_reconfig_time; it did not address the concurrency between the
> > autorate rate update in cake_enqueue() and the netlink reconfiguration
> > path, which the original review flagged.
> >

You are reviewing a very old version - the last one was a v6[1], most
of these fixes are in the "no good deed goes unpunished" from sashiko
;->
I am about to post a v7. Maybe review that one?

cheers,
jamal

[1] https://lore.kernel.org/netdev/QDISC-BA27.v6.r0.20261014054826@mojatatu=
.com/
