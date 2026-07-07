Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FD3DDAE4
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437542; cv=none; b=Wo8dHUwKEskv4B18l7ob6nGl8nZlIesMSGetgPNUIaitcb3El9DzZo/LlAT8JVVxl0LSTlAhMyqimBc09iBX6uA4GdUG8VjDFDkXewxGh9HDFzw/k2CfKVJOh7QgRSV1mWIeP4/l+lqhSTCvvdoB3V3S3WJ5n9eNQs2fdYV5iM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437542; c=relaxed/simple;
	bh=I0y7IU0rxcq1/BkRB+YBIrm6tn1mEF67J2Mt+Hzwz2o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=t4WvvaaOyHZAC8F7+GDEdqAqY1CjFms0Y/UQRn0IrYlBpfUbEmU/1O2HSvLpfVwuZdSx4cXyXxYxdKF5z9dYB+70kI7/V3tCs3iT1RiuX/0O74Ji3CcuXNnIUqDr4ELGrYAitr5AKGSDMx2Fi6TK+BQfEf69tB6gU4P99h2T0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rA+ywnZp; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rA+ywnZp"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664cb440f9eso5357167d50.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437540; x=1784042340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vByBCCqrffCkosrAvPTiILJu5TaMlB+MJdsxe1VmZPE=;
        b=rA+ywnZpiDw3kUpQqUBEYeZjru5wJmv1Jqbk80xQyb9uLVyh0sXRJylwRPpmYF9nL/
         Gu2cUYU6IiNf+WBejFHkqcBqDSsJ7UuXA5HM3rKg6j4gdZ/raMP4spvSDELUXu+gCWeG
         RTovxe2Fn4n0uCUFoWSTOc5TFLoDld4JD93aAqcXGOG8FXFl72Hw1QauD7awtkAZ5732
         dKgVNqg+44lXBc5y0QqVwZhpAX1EGftwPnivbA9S2SM3DpBfQkCTdDsIBiFaNHkdfH3O
         tTU+Gi2muOcOZWWJfkd58wheF/9l8pVwg/TFdn2N6SB7tKUwnfbIYzrpBRNeO4vmmwMw
         YhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437540; x=1784042340;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vByBCCqrffCkosrAvPTiILJu5TaMlB+MJdsxe1VmZPE=;
        b=KDq5cVkAwNGrPIouGL/YQXX8oeGL7Rtyo2jDYw0ladd5MjffCAJVcFX8UWyudqpdjE
         kXBdesVaw9l4gaXrduuiXhnoAfoOvQzx0OVijckQ2XYO0mxAgRNHo5HKB9m6TSwAA+FQ
         EW10pvHudrZ+ULrrsdCsWarr6kQTweTKL3PHKg0sErwdWenWFiIDzdRqhrxWE/vv4fUG
         qcc99Z8GFa8rjd9lYTUjzr8LK+V6seSXCjG4FzlSqwmmYqf6RTxHOVEW3bTKK7gvSL2J
         NH+GijjVIWyH7Dn8DPM+Umk5Sab0AV5lEA0z9WVSRTZ2ulEWLBZ0g+qGcCKhVsfjOcUK
         kfMA==
X-Forwarded-Encrypted: i=1; AHgh+RqQH2apni0/Jdf/yeFgEdSKzuoka3lYsrtpxQssy3FseUzYQq0Sg6IKrqNWP/wKco5y9CqsQuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrdCQgsjCqR3NfrRvNeFR15Yxw99FvavtPNFGmGmfJ5cLqKh0
	0ZJV32GXIxqTj2vjrDwtkAtgJixhpkMTMTqGdfcYiFunBjhpJFt719SM
X-Gm-Gg: AfdE7ckJKK1v5COjpHYHscP634FKCj+iasKjOOiiFOC9hbKdGhGgh7DFf91NDbgC2Fx
	JRp8ZZw5OUBJBGJQAB1XZGcalBACTCIG4qPc56nO7uCfNjnY5SVM8D/xD0wWoQ7ShTDx549u9oO
	r0CgU4Gig67GJzInq/2azyFZS9R40kegKSlRWrFnwdE4o93SWtnxaYDWicl5MW6zNPSoR5WPe0j
	1VcbuDvkG/6cnEYkim2jFML2TV07Tjc6lqkdgGgfgumnHkqYuAowi6Q4jExKcbYwHuJcTfJxTcx
	C4tAeoqEhDGCxTD+KgvFgEUWVrvZv4fIvaqGDBluio8K69U2n08Z7ckLIaHD0GK04aLIVBQsYhU
	kb6Nbq+hFjETivM7gbhFN5DINiJ7HrbuPaD48LG+5oI6EOCe2h2tjkd4AgFOYOuXkrD0XLqePQK
	PylkJ9tyfJ5BrjmXP5KuNG1kUkZ6o2UauGJZ059x7K55cZ4Rs6QbJ4/kBKZ5GjLQyp+JsNgpztB
	Sai
X-Received: by 2002:a05:690e:d0c:b0:667:7710:eb49 with SMTP id 956f58d0204a3-6677fb5cda2mr4626401d50.18.1783437539480;
        Tue, 07 Jul 2026 08:18:59 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667874c2d15sm1014291d50.0.2026.07.07.08.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:18:59 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:18:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: luyun <luyun_611@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kerneljasonxing@gmail.com, 
 kuniyu@google.com
Cc: mhal@rbox.co, 
 bjorn@kernel.org, 
 jiayuan.chen@linux.dev, 
 netdev@vger.kernel.org, 
 minhnguyen.080505@gmail.com
Message-ID: <willemdebruijn.kernel.c29ee6a560e5@gmail.com>
In-Reply-To: <dbcfecb3-7b5e-4d53-b4ac-486fded1e192@163.com>
References: <20260706100229.13812-1-luyun_611@163.com>
 <willemdebruijn.kernel.250ccf6e7c9be@gmail.com>
 <dbcfecb3-7b5e-4d53-b4ac-486fded1e192@163.com>
Subject: Re: [PATCH net-next] net: skbuff: use net_zcopy_get() instead of
 refcount_inc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

luyun wrote:
> =

> =E5=9C=A8 2026/7/6 21:55, Willem de Bruijn =E5=86=99=E9=81=93:
> > Yun Lu wrote:
> >> From: Yun Lu <luyun@kylinos.cn>
> >>
> >> The net_zcopy_get() increments the uarg->refcnt, which is called bot=
h
> >> in pskb_carve_inside_header() and pskb_carve_inside_nonlinear().
> >> Also use net_zcopy_get() in pskb_expand_head for code consistency.
> >>
> >> No functional change intended.
> >>
> >> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> >> ---
> >>   net/core/skbuff.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index 18dabb4e9cfa..bcf3b2c65fb9 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -2326,7 +2326,7 @@ int pskb_expand_head(struct sk_buff *skb, int =
nhead, int ntail,
> >>   		if (skb_orphan_frags(skb, gfp_mask))
> >>   			goto nofrags;
> >>   		if (skb_zcopy(skb))
> >> -			refcount_inc(&skb_uarg(skb)->refcnt);
> >> +			net_zcopy_get(skb_zcopy(skb));
> > This adds some unnecessary instructions in skb_zcopy.
> >
> > It's not terrible and I see the consistency argument. But would make
> > more sense to update the recently added pskb_carve_.. variants instea=
d.
> =

> Thanks for your review.
> =

> The skb_zcopy() does indeed make repeated checks. So following your =

> suggestion,
> =

> I have modified the code as follows:
> =

> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net_zcopy_ge=
t(skb_zcopy(skb));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net_zcopy_ge=
t(skb_uarg(skb));
> =

> Does it seem more reasonable?
> =

> And I plan to modify all three functions in patch version 2.
> =


That sounds good to me, thanks.

