Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F674483A1
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796077; cv=pass; b=gbRezZ6vUehxbTSwZ067SJwCKf1NH5QER3a5Lrm9Kg5nkl5ew4d3j5bkgUMa2l6OIFtx1T035Y6m1Ash60AJWGw811Nfo+08DDF+1G8vS5xUtWxhARR4dgxLedP4DI/wPcFlovNjI4VM7teR+4a+kZhkeBLRb01S88w0IpQEpoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796077; c=relaxed/simple;
	bh=uoYQfe0OtM5hwQLQXZ1/6Jxu7DpcKxEaksYbMdB7Lac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DI1kvNgYkvqgTdIhfuyUqdSCVZNrMInw9XGhyYVUbSjBMh7BEMSgRN3z0Dp48t31EsDR9P5p1XTSmVfEcb/Lhl1TuUqFiFxLEpYgH4Fn1oK6ImS4PhC2kyfRIvVe1bb/4jQyYbYvK/1sWS7QoIwhF8xzBRrXrhogrwEvyOBj1Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4AeciHt; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4AeciHt"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-870e8b21121so88316b3a.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791796076; cv=none;
        d=google.com; s=arc-20260327;
        b=lm1vF9JeSMgLwvfu0cUCPTP+t+QT7qanRWcHFahyFW9Y/7xyo21YnL5biLofPQEHzn
         jK6hV6FuoMvlDQQZN9Ums31NEOyIF4ox8j3oCJ1edsPHzupAnDxVHTqPTCqjbKTtLUBM
         FwoITZETdH6dYWTU/pTXSN78oqDrH3STw6XX+86dBcoo7DVxs1M3fD8ItOJBvbrOD6io
         xFcWSIiWT9J32a0JmhQJaeeaKknvuGd0s6EOfA9Ydy/UZK7/fiCjRxihSgBU1B5OUtlW
         GXvI8DkE9Sg4QY2tx/ZKBGVlR3K/8pg8LRB5Iyz3CP0MD8QA3IQMzwR7F76pFQkDvPNt
         hxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DWCVh/HhawcXmZOhgfv/ReufMzsWqc2yp7GplBGUnLk=;
        fh=pR6hRaYEuTGN+yHfyWQzKnzvdTT4UPUpDwzC8Ta6Wpo=;
        b=NmtEqWJ9KHGJtFURAawZdoSvv4eumjG5iDsC3XFuNBQBSY0VfYgLiBm+MYb0N1JIP9
         v3w/PNwTQw6fXIHjWC33rE5hvHrN8euML68s3+5efenjq+DU6b4wUEuwdV+76+FjzGR1
         oXdmurBJoiqD8hIcyL0ATVBwf9QP6ZZ5oJh4HdSfWj3cmj4INGFQYbheFAN839GMkZt/
         QXvcGFcI/9MTCV9ZwLLqIUeyadmlp8ZkoEOqDL2J1gMkQ5sZRcbBBPzpiIBfz5VPIXNB
         f81rE2tK8wyHdR2cAixiLkzSjBAaOK136QAg7bBsDEjkAwIDR10t64Fbw1jjENTz4zqB
         WcKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791796076; x=1792400876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DWCVh/HhawcXmZOhgfv/ReufMzsWqc2yp7GplBGUnLk=;
        b=J4AeciHtAslMKoCFC1QSz3368wzkWChaHfo7vhcAaOnvM+xWSz3mESJoM6PCGwzJJK
         vABo/RNrM7bztg57rwSz70bLqGw5WU+91mOl7D3xILUZbBIO41lUO5i5yepkZlFCbnND
         qFNdEZNyGXn0p7dq/AeBidUbecXD6jnf0k7M9uj+I+gr8E2E/LJ38uzTeSfA/+sF3uSR
         8vE2r7nAabEKfcUmKeVJsPGlAotUI+i0jIdhrC0QMvQ1ur08wEUq6R+A+95TGCE+dkF9
         pWwrwh6OKuBmpgKgrHhwmKQuiM1Ff5JFLTafRQL9U9ObAuLevDAvFR1E/T8ERmTLB3JZ
         cM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791796076; x=1792400876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DWCVh/HhawcXmZOhgfv/ReufMzsWqc2yp7GplBGUnLk=;
        b=lWPEwDWN+vJTmjKb279RYMC48AURL+q8A2a65+wN9qI5ZBIgaU3prmncDLiPuC5b7f
         mfJ1HuXmnyTZm0nmjX5UfqxYGe8OFq033sPJZxgK4nY7DHjGdpdoqBSmpUNHmpeFKVh7
         9xeC9uo2UjU5HOG2LpZwqOxrslSAT4D2w029JcSBjJ2N/5H8Hi1AfmBANAPF1UesCXhI
         DvhS2D/1WfuDps8agounxGGRIMESRPw0KXu1DbrQlU55zYh3PPWZpXGrZxFzv2fBkLKm
         9M1MP4qnLics6suFPzWijnvDYcHcs5ffpmtp/s5S832fJpxf4VcoVxzxVA+LNdzQkEDy
         AK2w==
X-Gm-Message-State: AFq9FYL0ZRt77bMlZu8sm9GVlklf5wtW94dy35pb0ShrAXcaJmBT1zr3
	3reOijJEHXzcgVPNrHCgoCGLMH5/sK6T5ohwoybZO2LT8SYgVIpIF6mj/A9gqmH/ZL69Qb/9ODf
	I4WfQ0EgeBtaVSctbFChRMxWSL4rXR+A=
X-Gm-Gg: AYBFou3DHbHWHny5YMZdYb0irjPHvXmhqBkmiYHJ89F+XUTnGVJSG2ro3uOU/Wm/uYz
	YtubqC84hsGK2RphlNUgD8eztXPTZ1a4uPrUpHR/3Ptr8PBjI9Lo4SxtbJQSEoLsC8GvKqJAmir
	KnCdla+JNPNG31mLxlGnnj9+8/S7EtLD4As8BcTrM+E8QXnHoU+V3jSb7ycKbVKC/1jhOvOwoI1
	nkrnM1fi/K8muQhHcDTfRzMFPYIeTICrZPpMlxYXtds1rqvOVgx/KIh7J8vhowWoj/W/kJ5CFHi
	1izztt+wCpso72v3VPrgNiPxl89cgFIEZ82z9vTvRTNFzNyUnNoWN9waUGAivN+Bb8aTQ6Y+gUf
	HMT11mkVuXukO
X-Received: by 2002:a17:903:19e8:b0:2df:8909:f719 with SMTP id
 d9443c01a7336-2e842aa4aaamr121044035ad.3.1791796075785; Mon, 12 Oct 2026
 02:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
 <20260930090813.73901-2-q.h.hack.winter@gmail.com> <179110850671.434549.2584497019282941556@kernel.org>
 <1791424156.460.8ed76b88c7@gmail.com> <asySLDyakgLAKVdf@secunet.com>
In-Reply-To: <asySLDyakgLAKVdf@secunet.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Mon, 12 Oct 2026 17:07:43 +0800
X-Gm-Features: AclHuK91mSJQpkcAuNKP7lhbEE2Z9AzA85M0in2-CNT68_ZzPsH_JW-C1eG2BpU
Message-ID: <CAH78Gvt0gUELPSeqf348P4-B8E7RH3L3PhFdgVdjfK=WKEpzdQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] vti: fix tunnel device use-after-free across
 async crypto resumption
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

Thanks a lot for the guidance, much appreciated.

Your three points make sense. For IPTFS, the skbs freed without the
receive callback are the outer xfrm skbs, and it's only a handful of
places in xfrm_iptfs.c -- a small shared helper would be cleaner than
open-coding it at each site.  The two xfrm_input changes (set family
before the early drop, and hold the skb->dev reference unconditionally)
look straightforward too.

Would you prefer to handle the IPTFS and xfrm_input fixes yourself
(Christian for IPTFS?), or should I send them as part of this series?
Either way is fine with me.

Thanks again,
Qihang

On Mon, Oct 12, 2026 at 3:54=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Thu, Oct 08, 2026 at 01:49:16AM +0000, Qihang wrote:
> > All real, and vti6 has the same problems.
> >
> > The dev_hold()/dev_put() idea assumed the callback runs exactly once
> > per skb, which xfrm_input() doesn't guarantee. IPTFS frees the outer
> > skb on its own without any callback.
>
> This is a IPTFS bug. If IPTFS frees the skb, it has to make sure
> to run the whole destruction path including all the callbacks.
>
> > The early drop when the SA is no
> > longer valid happens while family is still AF_UNSPEC, so xfrm_rcv_cb()
> > can't find the afinfo and never calls us.
>
> Assigning family before the early drop should fix this.
>
> > And on the success path I'd
> > drop the last reference before gro_cells_receive() is done with
> > skb->dev.
>
> I think we should unconditionally refcount skb->dev in the
> xfrm input path to fix that for now.
>
