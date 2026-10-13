Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A76253340
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876475; cv=pass; b=iR3LZTC7PTMRnFI76DTt6CsDdj4JL1uFB+oBKbRJX4Lc3zpgaZv2iy7mDjWjg7F0C3G1BgfOTwhi3xdYJxsQjKZ7JIKHPRiFSkYJ0r1IKvxnWDRlmCK4KeG3IykS44sAiVhFqx1oeny3rv0hlbbvn13SESrY7bkekqidBub/mn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876475; c=relaxed/simple;
	bh=bwWVbO9licfd3UHamNwo2L07dQOWrAJkfuluUvWLxKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f973qBBW73qHY42aAfRK/A5NUM54YD3ziW4k5q5iDjzK1GJJJccUG2rFc0w3uOySUodNpfNbkA9plmDESrT7F+IueFVNc1ItefHYTcfjHYqPvCn50TzRqK1wE0X2j2I2u7l4XOBldzi4H3og/IX9edWSQzYnc7LG+O4nAFIQdi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G76eyoLz; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G76eyoLz"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so3912269a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791876472; cv=none;
        d=google.com; s=arc-20260327;
        b=mKVzYcFUBpqPBV0X0O846by6aSGAsACJ3F9DvcgYoVLtEwpN6aQQh7+1jv1Khu9X3m
         1NpMkydJVIdkAXVWcmXRsAWwhncMUx4j6xTnG3tU9OUbGc1eDsMMUez9/ubwnwl0y25P
         qyVLfBXMGcIRjU5lEsQqTA5CSt/h+kV49AvHwaMaXAAe5QJBPJozAKCJv6UTT2CM8gcQ
         6QUIS4V8qn3uNWB4nI59kPRltYWlanLv/YriJFQsi+zeJtyTvCQf51oLbeioIuQ8fXOa
         Bf7xTVGdA4/xyqzzXb0JjuLkHcT4lA42jnSF4Cye3O9ldGwtmJ4Pr+Ow5t9ra0kSiUp8
         WFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bwWVbO9licfd3UHamNwo2L07dQOWrAJkfuluUvWLxKc=;
        fh=xYznBo/5ZkmnhXO48gAxBJAjVjooGjBON5KMprgp3jY=;
        b=Iyfw0fYhQj+hutv7Q4LSXD5oHRGwwYiWdBKX+gVA7XqImrqFSpbs4CAU8BYBBM6Mch
         TN8Fc5Ce4X5uwiUxhXzn/zAys3a0uw+eyUytrLfy464gfuLm0u8cH3Fdys/F1EHPi1sz
         tMDvJSdH4G6xv8je+zOXGgniVoLRFTuT451g5aVwxLZ0+ccxUQOo2sjFciuT2cKJQkc8
         FT/XNbNs06VC3E/TBSyjwfRZ6rLtD/p2xd845soJYXTUGSyPNMKoUA/zyo1CHzIhDkCm
         5fjGTRqQ/UqKEmMhtwLMYXt48goCvyD5OL0VrqW0fCr7YK/TrUCexMDKpwEt5I76FFjz
         bXhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791876472; x=1792481272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bwWVbO9licfd3UHamNwo2L07dQOWrAJkfuluUvWLxKc=;
        b=G76eyoLzvojgC1WAz3t4J3vZyfF89vFQCEJvsrTK1b+f5Gi2r7EB8Fn4zMNQzwjJYo
         N2TyvJG2IOZ+3KX2611EJpVCl8PzM9JDQJgHQlxUG8gQh9cDN1lOv1FSeL4KPOPH3VFP
         mfh6d3a8ppe4F++bkfrdbCh/HhEemGpaz32NwucvJRYREQAEVQfFeyGan9RsI3N/FLY8
         KnObDThXDxMHKdipE82i2CbWWytOGQEO4yL0346QxvZKIay/sdO85ela9ZyHkwPBHwbb
         r+8geWSL9i+holpUqplxSLxwK082ixawWDRmoq4gS5wh/7u46F6PHREk8wyNOh/wgsAt
         zeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791876472; x=1792481272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bwWVbO9licfd3UHamNwo2L07dQOWrAJkfuluUvWLxKc=;
        b=gaHM8PR4MdaHmLX8L4OzUP4Z8nN7JlKDczOPaS4zt/Ws59RaQSC52iwoCN9tv3+UEu
         OmZn82/utyk5w134A+7DFCgdgsXygmNgsllf3DPAj02wNHZv1MkTmun1eGuzTK7l2ZnP
         afwVqBEib3O1066v5Q7gb+Rc7U8JAIbMhA05gRi93aYXAxnzgs82vunQ1BeKgjgISPP2
         kIqAfaQxkp8A7p45PHX/ptPPAz0gDVOljrFVpvkIQqDdOXt8U6PhTOTBpe3jMSQbjOsl
         YbS7no2orfeuxWXSDcxAt+MaDk0HGwpcpS/p6lT4HLxt2xnarrASAkM3B9DszgEgGcwg
         n1EA==
X-Forwarded-Encrypted: i=1; AKwUvByUD4XmfLxHbrKmEWlbMAHVz7vgEb5HhCrVYu4hjNjKuOGmy+tLyVVm0jzlZpS1c+YIEeOU8Cs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQqpy74fKMq4YWQSMYkoQP7KPBsSRUuK/BiCmakgQ9UtVeC3p2
	yP3AFiO38xjpJvexyXi8AM1PQdnZwH2gvfUPm2GFkJDdKQ+rKwMAlnQf7ZC2Jns58Jdjlfy2lcB
	p4JHgReEzUEwsMtNiiVhDto66kyA2KMC9VnDIWuNW
X-Gm-Gg: AYBFou22vgsT3xjPgFiAJMzziwjgGGNH85FCoaJpZN49Bi6soYbJLP+rk/hKHcdSJZH
	DCgbvRS0D/leWLyGKL+uLXREmNsMW4RsKJfm2xANxEJ2RlSG6QQYSJRm3KpWh3hD74soQCbNCkY
	hai0flFRilhuwnnLpfey83hyuPQp5mCNHZnDrdxdowXWahn6fWnCChfp5LW/d6SXWfriOzEPKkO
	3dfWS5nkmP63neok7u8qlfz2FOn6nCRUWg2TnwhVPWJQr9wn0vkNSChZoe9Agj3qMQNiXFZZN8Y
	QDj20hbpoSPi7opaiXAvHqClLjOi+nvqqA0Bq4Axs7hWEEEVDTg9w5RrUkjCT9x5z0KV02V9I6q
	Zs1DVgFUFwJny5nrbVERB70qU8t6zneRMjGaUDuJUDY57C7ojeMJ0hSmXwVXsB7pgFrKzirDlhH
	sIP3rTp+kxRnoYu5ZA3bTLFfQ4
X-Received: by 2002:a05:6402:21cb:b0:6b1:c355:c7b3 with SMTP id
 4fb4d7f45d1cf-6b1c355cdf1mr3550014a12.25.1791876471530; Tue, 13 Oct 2026
 00:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012194530.3751034-1-kuniyu@google.com> <20261012194530.3751034-5-kuniyu@google.com>
 <20261013071619.GB852441@shredder>
In-Reply-To: <20261013071619.GB852441@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 13 Oct 2026 00:27:37 -0700
X-Gm-Features: AclHuK95tsCjazIrg5O3w1NSqbTINjXSwL8Ai_hJVmroeZmGKk8xUgW74pAQKyg
Message-ID: <CAAVpQUBx9VYgyHLBuVSKem0mFJ1KF16bMQbpE+xSqYn8__PMgw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/4] neighbour: Floor INTERVAL_PROBE_TIME_MS
 at 1000.
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:16=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 07:44:59PM +0000, Kuniyuki Iwashima wrote:
> > Previously, the lower bound of INTERVAL_PROBE_TIME_MS was capped
> > at 1s by commit ed6cd6a17896 ("net, neigh: Set lower cap for
> > neigh_managed_work rearming").
>
> Nit: INTERVAL_PROBE_TIME_MS didn't exist in ed6cd6a17896. It was only
> introduced later, in 211da42eaa45.

Indeed, I'll rephrase that with neigh_managed_work().

>
> >
> > Later, commit 211da42eaa45 ("net, neigh: introduce
> > interval_probe_time_ms for periodic probe") changed the limit
> > to 1ms.
> >
> > The limit actually did not work but was fixed with
> > netlink_range_validation by commit 6d79b223ec44 ("neighbour:
> > Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.").
> >
> > neigh_table is now per-netns, and a user could hog CPU by setting
> > INTERVAL_PROBE_TIME_MS to a small value.
> >
> > Let's floor the value at 1 second.
>
> The bot will most likely complain that this changes existing behavior,
> but:
>
> 1. The original floor was 1 second.
>
> 2. It is unlikely that anyone but syzbot is setting it below 1 second.
>
> I would explain this in the commit message to suppress such comments.

Will add them in v2.

Thank you !
