Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1072E0914
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804131; cv=pass; b=RBE9PKldBtRL+HkrTaaynuYwd4WQZZTY6LHBbTM32hdnoFuoasH29D0oOxGD9UjG8+gZILCyRFcdEh5aHU2zlrWq1VaOQLE1CPGlRQQg1XYzi5kd/NJLZD90FqCn7Pj3j5rPcdjLXkAFvomeP5DvDUycHeLGwH8gLA7AtgWHoY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804131; c=relaxed/simple;
	bh=ImImow3e+fihOWO7VmT8//WIECuyQ9MyP0HEjqwJ2y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDv8dCRHDe6bsf8uQ5eh59PY9odeER1ytPA9r9BmloKYnTgG7orboRfiBevk0DV9GUee+S7UpyYckYc/koi5MnT7qBcfJLG10V1+D29bK+5qmgq9n4uRAMMnaoNGm/I/7f/nO/GB6C0zSyOAthR8N8dLBBC1LEvjSuuK3F0j9e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+HnvCps; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+HnvCps"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd1da64fe53so60093a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791804130; cv=none;
        d=google.com; s=arc-20260327;
        b=LGxlupUiq5DppRxEY660RxzAvG2bX346GEqz0xyQXPx1LPO0n5/y/pZWLhhiG9Jdaz
         d25/F1nroXge9dEjjlHafNczzh9L5ScXzb06K6vbG0XVIkuwK99yvaRDR8EUV2giPuJG
         ewP6Kh2yOdkU5bIopraA55Zv23quGxr3/4f3jsdEZIFsRUZTIX7O8Ay8IuOy8hRJ1cbX
         3AJP2q/i98PwtmMFR9LY6DhXzq8OIXl89YUizl45e93Wbntyd3rft868HEqlKZt3xOQv
         tKZqc7fqS4ZYhKca2ZIj4Rr2EsGthFtf6Oa2yQx9KZIKlmlu81Ln3Rnb9mBd422NPnMR
         EoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3niU6cqp7D6Vf8l66QKyYfhCi9eIbqKTTvZBBqGYZyk=;
        fh=AxqNxQJ9uweIZne4+VugnBIO5c6o/WyAngGLTyMrB+s=;
        b=AnWymgrHswYqwIBRudXOKsNdcwlMMaKvyk2XzklnLqSw0SAbeQCpHMdVG1TvAnO3HR
         HCpQyLQmj9eyjOspx5jSlu9m6TBpG5ZuPJnmuAf8UWxKd+Eeddz12cuFh2pd8x3Rhrlg
         6R6U3nsDN722RyYOj3OpOib6YS3OeiAPdKryBh5SJYLZGTsh+iz7TB/ThtYWxuCFeYyu
         AgTtHNZ8veRwVfG1+GLF+fP5WAWgw8aJCP9x8oeHvpBWjc96bh3laJqfFnmddLoAdpwa
         fmk/5ysUJcT4j2sG1qDZWx7mfKrxx6gU0I/P0pg/Uuuc+TWK/0HQTFbJEFVVeihzL2cl
         KIwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791804130; x=1792408930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3niU6cqp7D6Vf8l66QKyYfhCi9eIbqKTTvZBBqGYZyk=;
        b=F+HnvCpsEua9MuqAFyVw22du5Pid1X/pNWVfMszv250sQYOVqrLA8gtoeEtF8PM9RX
         /n6M07q1oyB3s4+fqPhZ+m+jrNoacOPlKtxM4m47fXZJqEXCqZulXG9btDlpd9KuO93c
         RKrJ8Nc3Q4knawmB2m/E/r5DM/tAwsVgcr8MTvPRqf/9CbvCeXB53P2vx+dx6Q2GOgnv
         cPsgpjtiXek4r6FZbLknHeiuHEs/xhRlseYtLsOSNbl5jpaPNZJ6E7PJRX7aVmNYVMsl
         a3ydeOiiJfgFJ4ZkJ7o4hm0scYavx8LVdgv0FPulvbHvfMhTNHee2tz1uhppgHHDiwWQ
         J34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791804130; x=1792408930;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3niU6cqp7D6Vf8l66QKyYfhCi9eIbqKTTvZBBqGYZyk=;
        b=M2AxHMOFEa3ngdZpr3i2WLM9ydaaZ8w6vXfmqEhveRkfMFnD3d+dRlNDwRHFMz01rm
         J5LmXCEnfJ1AOj+WOBgI2zak6enyVFsqmXLuJEqMOymrIGaJr9BjH/aty3Cui+mVJ9Tz
         enBBHJ/0V7kP8C3qFxGshZxoL5M62IqgOp7CvTnQKjbpZIDEz9s3BFrzo9GZ8Vyxl0kH
         PmjsYDqAYcs5SiHEa8UmNtcFm4oGvTMOQReNn2PMTM8orOlSG2dGi06LBIgJC54liHLg
         Angqu4YkgMfHDljkG2wUJIu0f3aC8J59LTFtyV2+qdrjqcHy91yZD7QQJWHVoRyJXQ7x
         oAag==
X-Gm-Message-State: AFq9FYKhTcefLZcbBRH3muwXovSBo0IMlKIpKm10b3vFWEpa326rcOoX
	08PPT0tIVH2UrSTpksO0t/6aMChbPrwrMaGz9x9SVf65lWuXflFNzO4GX1qBK6/PzBtmFnBikP9
	X07an51SmbUXVxGaletwSLYuILsMbgQY=
X-Gm-Gg: AYBFou3B7TJg2t9+RDh4c+KD7WyOHDhwpAJY4KILwHHLjBFrPMTyEkq7NxB0Dzr6iKu
	FoS/AQAEWzvUumLl/CauDOUdbUWVgkZ//+Xx5zp8RAspFcLP/6dLjgwLR73rHo7pTIgjDpaI2En
	0xuk+R7u6888by5vIwxuB7KsrUgctordTZ424lqTOBrpebMGjGIJcDrx/PMlQ0Nno7zT7m3XvoF
	N0Q5D/7NgC2L93SeTlhDXhu6heO2AFeXGpVUFpxMyBbLZg6SM18SgCrgq7OFhvAc5Xd5Kd1Il+T
	aodNqR0cdDUdyzWOsCf0bYOqhR4/quJexxXAItrA7RBNKLHFvWWaca98srpblLL7P/JrX6VDdKv
	WqwPTCs9ec04e
X-Received: by 2002:a17:902:da4f:b0:2da:dd0a:99e0 with SMTP id
 d9443c01a7336-2e8428a2c77mr122171625ad.2.1791804129626; Mon, 12 Oct 2026
 04:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
 <20260930090813.73901-2-q.h.hack.winter@gmail.com> <179110850671.434549.2584497019282941556@kernel.org>
 <1791424156.460.8ed76b88c7@gmail.com> <asySLDyakgLAKVdf@secunet.com>
 <CAH78Gvt0gUELPSeqf348P4-B8E7RH3L3PhFdgVdjfK=WKEpzdQ@mail.gmail.com> <asyytFvHJGf_KB_D@secunet.com>
In-Reply-To: <asyytFvHJGf_KB_D@secunet.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Mon, 12 Oct 2026 19:21:57 +0800
X-Gm-Features: AclHuK_rUMnN31SSB_KN6FhkpZSAxBkc67iXhJ2qmDZZxPegZYe3XhyfD991XX0
Message-ID: <CAH78GvuFZxvHWqpbBv3cOQAA-TqvjgS14vH-GsTF58wJ8_vLvA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] vti: fix tunnel device use-after-free across
 async crypto resumption
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Christian Hopps <chopps@labn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

Sounds good -- thanks for taking the patchset.  Ccing Chris on the IPTFS
part makes sense.  I'll follow the thread, and I'm happy to review it
if that helps.

Qihang

On Mon, Oct 12, 2026 at 6:13=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Mon, Oct 12, 2026 at 05:07:43PM +0800, Qihang wrote:
> > Hi Steffen,
> >
> > Thanks a lot for the guidance, much appreciated.
> >
> > Your three points make sense. For IPTFS, the skbs freed without the
> > receive callback are the outer xfrm skbs, and it's only a handful of
> > places in xfrm_iptfs.c -- a small shared helper would be cleaner than
> > open-coding it at each site.  The two xfrm_input changes (set family
> > before the early drop, and hold the skb->dev reference unconditionally)
> > look straightforward too.
> >
> > Would you prefer to handle the IPTFS and xfrm_input fixes yourself
> > (Christian for IPTFS?), or should I send them as part of this series?
> > Either way is fine with me.
>
> I'll handle the full patchset, but Cc Chris on IPTFS.
