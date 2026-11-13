Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794548669;
	b=R/2biNhxqCjUEbh3lZUzfQWmKbcdda4s8r7gS+ZLoMZ2YIkdyqmO5NphknF2CCEWQ6hk
	 4TKGhA3uz4EIYxWozR9Isn8CicUAr4o8TVutaHe/+d5lH1qCQyYcQ5Pmp/sjXgfEBx15I
	 nUtm7xahHavUNBcSjehJ86tcDUhppQKCOtNrkoVruxFXlxxZcCVi5PHF+cz8ksTxS+FiL
	 8VEq89x+N64faAzlVOtHyPeX352sWk4/Hw4YLEm1buOT44O1tGovX/kbub7UrXZDjKMMY
	 vK4bE6K0iqFXCr/rvBGD57u62wqXpta0FNd5j8MDdsOWqPiyKp9S+qe5L/W9S5C5O6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UDUDmvLFrjDceUNHFFnKFwmFqi3Bs4rQ7NT0WKbQyu0=;
	b=EERkdTYSe7W1bRw5Iw1Y3rJ8btH5NL2C9getTV2lmMRFwDfG9vffULC5OaeElSWtu60+
	 tzQ6fK8dmy+WFbfnaPPCfQ5hHGx8lFPLv5pgyJUE9VRNrvD0oaAhZRHMaG8W6NIlf7TDc
	 9WaiBH3Mzh34wDoURDRAYcbHKgaTLAm+X3zxnyBxEFd1njqOhOHeYekQRa3IPHJxmY6R8
	 W5aCQ8y8UfeT+hXyLE3ZHecrQF9Qrg4b4Q1H+xYvtsHB08VPJDXhEa7LL3sSJU61oY0jm
	 qkCFPkbPNtEKuXy+JHZ2Mbb0t7EX5xyQn98sGqJlJ4wlV9OyoxCTsM3pYt6WIxElKRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YlwZfLjy;
	arc=fail smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9F606A321
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB9F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YlwZfLjy
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ea7190aea1so2368325ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 21:44:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794548668; cv=none;
        d=google.com; s=arc-20260327;
        b=pwbQiN6WLhe2Q7f3uBqgh4JSzJSq0oP1rjMkDehB5OS+VRBT5V8oyl4q4nJYtogcQK
         NLuE5js87KTCBIyydPVPYjKPzOfyGNLcGh5O0NL4yEoaUxEvbYty8sbCDofXKmkVoKCe
         RdX5ZIMsdvUmI2dMaD4cSc+cIwaj1+FN5lXFvbBeZZEV845CsBSXgbtzVWwR9tVoMmcj
         ExLtA9sYj7uKKInV3iw6akb+Tc+CqB4l3lkS0v03Pvb8rUnSP47K5d6iOpUVT14EZ2IB
         m+V/p+C2lO37AO/09W/fcE48L/M8Ps9Xe2ZRbnxurRKdawylyyoKOoxieVDBecDxWzSQ
         pg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UDUDmvLFrjDceUNHFFnKFwmFqi3Bs4rQ7NT0WKbQyu0=;
        fh=9YvNp0C54cykasSWwukReMLw03gD9ZYu1NFSRDpkRy4=;
        b=fZFVMd3+A+sKuAql+6M4c9Kmrm1/CyeZ+T9sRWLsc+DarpbZT0XyS2y8i6dISgxW8J
         B5tpWtrgmGE6nhGFZq9CzbJNhY/wyk1cq6Uz3i+yMYOUhFqCpBEjZW/pFjcmDopkgbpc
         3rAq6n/Pl+ZJTG8cvwf+13esHyCCXUd8nXZug6Xm1d7bAxxITiSJd9I+wGpAkDjtrSUL
         Zwr4TD3++NYN03OhO6zSxq99hvQX3OzBtTvWjAwLDm+NdeOTl/2zb1/TtfQQeSU02jme
         ZQQtpcL+1r57xL/FIJO389STOK+IAxQhWlHPOVxzAIfRZ51o/ycqRP4CV0e6bzSIhcn0
         hyUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794548668; x=1795153468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UDUDmvLFrjDceUNHFFnKFwmFqi3Bs4rQ7NT0WKbQyu0=;
        b=YlwZfLjyBPstI07GiXcbgY1PgHaL+X5W1yWOy/eXHR65Fx/h/UCfPh0Yr1zgMQmRs1
         6nZ1jxA0xPOT+RzxfuvQB99/uzu3eIj6nWI1wr59N0wuB77ZtYWgvaa52BphV79zRU/j
         QfteFPa6jhw8RqeQu008yjqsZCt1PsR8lXYCiG0B1RkfoszrAuFbtM2poeYz128vYgMG
         0F5Gu6WwU/Zq0Y91DTakxZVD8AQFazyjvKgStdJwrcpEO5f84X7vog3Tww+C8afVkiIy
         dnqdzIlRv5GFAQz+hTgqvFJc6dRJUFgMtRItZwxxYtjd3c54F4UCBdH0pua4OUMgzeCL
         +35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548668; x=1795153468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDUDmvLFrjDceUNHFFnKFwmFqi3Bs4rQ7NT0WKbQyu0=;
        b=XSd5C61MQAaKvlrmZoxxIVI0mHtw/CD7mn0bPvVqPbjmqLzEaL89pt2PJP7RHcs/p3
         6hwDtd6OupsMd1zVxBdxdk3XVoswf1CcJEgbZ7RC0guAkODBg+fZ1BsGgMuXvUBRaVLW
         TA2Y8elO9RN2YLzyq3qeZ74cDg634P5Yl2eFPWBIBcZw5lQxAfw5KN6Zbq4AAP2CZzmG
         4TjTSoFwPbUR/RvK217Y+X9NGACM8bEBjhmxgvGgtBpM30kpfMA38jB/DmptQGUNu9yP
         gY8WeMA9fLkiTU76mi+GmQkzrty13X1igpaKIKf2OqQbwfx3JyGrpsIWGXqmOw1Yfh4s
         oMJQ==
X-Forwarded-Encrypted: i=1; AL+hErH+h3xKrDc/B8r6fKbjwW1o2U0AWwvv8oAHNh/R9hjDQ9yunMy3Ov3Lmrf5orI4DD1ORDRs2Ls=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EmFeqIWLBNN4k/7qEPBEuZ4VhwcBs6xET3TfEKHgCB/CgF8/K
	4UXCp0YkAtPEfgOq5Xs9FRWUomKR28q1fCw5bw1gO00jYlCd1qBiOrzOZelrFk6n4v9hAoqb6OE
	SRRFGPYiBEG3jZR+Cra98zEmESqqwTHw=
X-Gm-Gg: AYBFou1XLLm/kxiUMOBzedOs0yqycTr4Z3s4jxqOlIfzL79huWoT2Qj0KjeRcHvcDTJ
	AzY1LYYaGNj/f4xOOC0+6rChlRgRW1GOwRV0VtWDtILRq6wgg29pyExUQxEf7+gnrF0Xj0K+jyI
	XDFdx1BVuoLjdFaZBY5FOLPfgXibdLrW3KhLj/6GkAEjZaVcGS9HPuYiENIPGyUcc9aFyOiJ3n4
	c5iZ7c8rcqNZUSo7TpKhbPz4ITAo4mB88eBMaYTuXa9/oBDOE9bN+0FAQ2/LvbJCQbVasYyqlOK
	VUfBQacpYgKNK2U9oEf8efJ9I8GRWzrflipVMqa5XlSvujQl8vhplU4YnI4guTCUddVez9LqvRn
	/RzkNgM524/WrxdRykW6Z1STV6jVdVfBOd9c=
X-Received: by 2002:a17:90a:ec05:b0:3b0:c11a:902d with SMTP id
 98e67ed59e1d1-3b1b09fac26mr938995a91.10.1794548668130; Thu, 12 Nov 2026
 21:44:28 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109030042.2956-1-nashuiliang@gmail.com> <179443085204.2199510.12725312671048285646@kernel.org>
In-Reply-To: <179443085204.2199510.12725312671048285646@kernel.org>
From: chuang <nashuiliang@gmail.com>
Date: Fri, 13 Nov 2026 13:44:17 +0800
X-Gm-Features: AclHuK9F9oQ5Qrk0_Q8z0DxMdLD_AqhLC4iCmwIoVy-nc5xaLnUdD7relDJgbSU
Message-ID: <CACueBy6qrkoTqOi6b5FN7YEFLVzUve3+tbzS=f67ZJO1Px7xiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12] net: reduce ARFS flow updates by checking
 LLC affinity
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, sdf.kernel@gmail.com, daniel@iogearbox.net, 
	bobbyeshleman@meta.com, kuniyu@google.com, willemb@google.com, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 5:00=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] set_rps_cpu() (net/core/dev.c:5281-5284) decides whether to
>   skip ARFS hardware steering by comparing next_cpu with old_cpu.
>
> --
>
> net: reduce ARFS flow updates by checking LLC affinity
>
> This patch makes set_rps_cpu() skip the ARFS ndo_rx_flow_steer() call
> when the CPU recorded for the flow and the new target CPU share an LLC.
> rflow->cpu is still updated. A new sysctl, net.core.arfs_llc_affinity,
> turns this on and off, and it is off by default.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 3b60b15e2175e..0011cec296402 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
>
> [ ... ]
>
> > @@ -5273,6 +5277,12 @@ set_rps_cpu(struct net_device *dev, struct sk_bu=
ff *skb,
> >               if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
> >                   !(dev->features & NETIF_F_NTUPLE))
> >                       goto out;
> > +
> > +             if (static_branch_unlikely(&arfs_llc_affinity) &&
> > +                 old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
> > +                 cpus_share_cache(old_cpu, next_cpu))
> > +                     goto out;
> > +
>
> [Severity: Medium]
> Does rflow->cpu reliably show which LLC services the hardware queue the
> flow is arriving on?
>
> get_rps_cpu() takes old_cpu from the hash slot in the arrival queue's
> table:
>
>         tcpu =3D rflow->cpu;
>         ...
>                 rflow =3D set_rps_cpu(dev, skb, rflow, tcpu, next_cpu, ha=
sh);
>
> That value is software bookkeeping, and other flows can share the slot.
> The new check runs before the cpu_rmap_lookup_index() /
> skb_get_rx_queue() comparison. So it can suppress ndo_rx_flow_steer()
> even when the arrival queue's IRQ/NAPI CPU is in a different LLC from
> next_cpu.
>
> The skip path still reaches:
>
>         WRITE_ONCE(rflow->cpu, next_cpu);
>
> sd_llc_id equality is transitive, so every later migration inside that
> LLC would skip again. Could the flow then stay on a far queue
> indefinitely?
>
> Here are some ways rflow->cpu can drift away from the real hardware
> queue:
>
> - After a successful steer from queue A to queue B, packets still in
>   flight on A go through set_rps_cpu() again and hit:
>
>                 if (hash !=3D READ_ONCE(tmp_rflow->hash) ||
>                     next_cpu =3D=3D tmp_cpu)
>                         goto out;
>
>   This records next_cpu (LLC X) in A's slot, but A's IRQ may be in LLC
>   Y. Two later cases then hit the new skip, with the application on
>   another CPU in LLC X. One is a flow whose hash collides with that slot
>   and which RSS delivers on A. The other is the original flow coming
>   back on A after rps_may_expire_flow() let the driver drop its rule.
>   No failure is needed for this to happen.
>
> - The existing goto out paths still record next_cpu without moving the
>   hardware queue. These are ndo_rx_flow_steer() returning rc < 0 (for
>   example -ENOMEM, -EPERM or -EPROTONOSUPPORT from
>   mlx5e_rx_flow_steer()), a target queue with no flow table, and an
>   active colliding filter. Before this patch the next migration retried
>   the steer. With the sysctl on, migrations within the same LLC never
>   retry.
>
> - irqbalance or an admin moves queue A's IRQ to another LLC. cpu_rmap
>   gets updated, but the skip happens before cpu_rmap is consulted.
>
> - A driver drops all of its hardware rules without touching
>   rps_dev_flow, for example mlx5e_arfs_disable()->arfs_del_rules().
>
> In each case NAPI would process the packets on a remote LLC, and they
> would then go through the RPS backlog to the application's CPU with an
> IPI.
>
> This also seems to conflict with the new text in
> Documentation/networking/scaling.rst, and with the similar wording in the
> commit message:
>
>   "since the application's cache locality is preserved either way"
>
> The reported ~99% drop in mlx5e_rx_flow_steer calls cannot tell avoided
> redundant updates apart from steering that is wrongly suppressed.
>
> Would it be more accurate to compare next_cpu with the CPU servicing the
> arrival queue instead of the previously recorded rflow->cpu? For example,
> that could be smp_processor_id() for non-threaded NAPI, or the CPU tied
> to the queue from skb_get_rx_queue(skb).
>
> >               rxq_index =3D cpu_rmap_lookup_index(dev->rx_cpu_rmap, nex=
t_cpu);
> >               if (rxq_index =3D=3D skb_get_rx_queue(skb))
> >                       goto out;

The scenario walkthrough was very helpful, and the issue is real.
I will add a READ_ONCE(rflow->filter) !=3D RPS_NO_FILTER check to
set_rps_cpu() in the next revision:

if (static_branch_unlikely(&arfs_llc_affinity) &&
   old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
   cpus_share_cache(old_cpu, next_cpu) &&
+   READ_ONCE(rflow->filter) !=3D RPS_NO_FILTER)
goto out;

> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261109030042.2956-1-nashuiliang%40gmail.com

pw-bot: cr
