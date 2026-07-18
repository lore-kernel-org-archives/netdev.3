Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602953876B3
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365879; cv=pass; b=daocECxcqbXAxbD55YwJhhkfoeKQI/PIdJAbaGZZk+F0pGaqyjkFgkWYDoPvdoYnaxdWTJqTTCap7ba+vrJ6S9lherulTM5qcsHL2uUq9y/vKLpg5557zB0FCx9g+HBMhKj2tWHE//QTM2M/A7W7qdmhcB9uT5sF6ArdTWEOLxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365879; c=relaxed/simple;
	bh=FEaI8sHQiE3eMnaO0pdqvIZiqpqzyfNKypEF9A+N7xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+cE93ez2XlA7MsP0RrYma947dL+h00iTlkB43fwYdOPMCs+bNLLCHOe3+qt1ktbKhtNjZuvBib9mL/2RJgSmOz1aZb8s1lu0uo9WKr5TnbLdv1PgmnSlKS8j75MPAHZ8cqKR5UMUMd+Se464sCtgXVAzoJ/GlnXomnSgcY6eHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj7xyUx3; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj7xyUx3"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso43098091fa.3
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 02:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784365876; cv=none;
        d=google.com; s=arc-20260327;
        b=Ve/8dpFpVVeUvcCJ7jvYSn8MthAYH4ByInsDbcjQeYa8c23g24XE2lt9ac58cbVIXu
         oNXgdm0IY4/pmUaa0vOwHWSLPP0MCLFGZRQkxPo7HOx1rvyEgg5z8k60dJ+QDqnd4Ik5
         GE0tIeQt04bOPNBUxzLIoVAYo6Y903/1loXlxVcuHhE0zrQqslTL9O+fHmny2+3GD266
         a1M21Mrdf0HuVHFkaPXw7lk8968J/ufTRVAS5MbhZDiWijM+BUhnNpPdrcI2GC/DC69W
         JIwlKsl2IUEzYOrRlji/uZy5rdECo3tOkbDdEnOyWDEG3d6nn2cKaAmJN0VTsXMFocmy
         521A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXSmPdQkiDrb6n+kytVJ5SDnu36NfEHras5rYRYzzuk=;
        fh=NoqOuOIoqYudd+mcPi69VOVI3LiJ06PiyEzNUK7iWWE=;
        b=V+iL0Azb8DTTtt57fQaa20UDh1FmFU1rpK4MOHIq2xJPTVuGq0UowpvXAZEjiiw2q+
         KhXqwjkBJApTZyLKTMwRPNh7GH6AyLAwPbzRrnkNXyj3g4VZWKOAXhEUPM5ND2RfC/Dn
         vw8UR15/611tzbH1t2pJLRx8mP12+Oj8jdU8M/TlwV/GGE7bHm6AaKMw6RqrlblUZkf+
         hP24MRmiPTy55mPxTwlLId9JrLU3R3rsVBFs5Fwh4r6eTND2xi5gavGOrcjLtOz2z/Qy
         3dHauPnY8Uw7UTR+5+RmZcFLei6ysp5klRZ3NIni0TSY2Wef8yZHOx/MYR+IrEmMd349
         2sjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784365876; x=1784970676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IXSmPdQkiDrb6n+kytVJ5SDnu36NfEHras5rYRYzzuk=;
        b=Fj7xyUx346pMV09Hu/clF3TPhfNnXuWl/SeyEHehxNoAlBs2MQj8qfC/ojjbKoPBH2
         73qrcjXUHpqi+0TxD9YMiNO+gGGbC9X1mKPcc/N6/qSfFzM8Ngli88fUAsb7jnHvtPsN
         LYWvi+zaKCF120WeV2XbgzAs0UQCg079lUwBKfc7bnCQAEStUKiK9yoZM9mzxUI4ytNn
         AzZrQgIkyRLuh3EMAV6+G9EsUDOuu/xN2jPcngLh77zf4BbHzJOxbpHHW7cYIW5gr1TV
         Ez0OK1LsHF7lVqG+BWRWA6NEzh4msRUFsr7QKazvaesJMSgknswJEZu+3J8dnyRoMboc
         JtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784365876; x=1784970676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXSmPdQkiDrb6n+kytVJ5SDnu36NfEHras5rYRYzzuk=;
        b=FQPbM5OZUlbwOIgGQuW55a0DfScQ/VA4cII8JbAunjkw2VbaM7usmVqVrl82siRt+j
         ctznkp8e6Ei+yhWLYwbx6fmnmkGEk//irYMd+ECSi1//56LUB2yHBTiSuzVCqaCyzgyq
         Y6tOhl/GEDe+JByFwXmPnMc43XU+UCev7dnG7EubAtlwpcG7JmKQfE6je/N4FljMyFsB
         xB7uz5Yn7DCt5qLsQwvQCb08zR9fVW3qjHGugVw/iyrN5YwCF/U3yyj7acwgs5G30OKQ
         VBeoz/HrbPQyvht1+3C2gtoZbCS+Ve+pVn5JI9hzPxLnlxlYk8dtBzzwLWVDLva7X+6Y
         LpVg==
X-Gm-Message-State: AOJu0YwmVtI8FiLuhgG6rmEz083o7E/VPRyTNPTjq0t4z/H1+3NmXR6Z
	SkH953R16nFrfqSq1jUbDgYVmnpIAzpTw9E95Bvj3TcCgVi9YFyIUXGLcy9sODQvQuOyN2AlPOZ
	ux8QSfP6jOpjXJYFY2JMVFllUzkSYF6I9k4B0
X-Gm-Gg: AfdE7cm5QlaTzMALU/t8B1qLcb5R09oCdAnSSjwJKqHPGDg8zU1YRUsmA/iZs7OxJV3
	OTkvvHHm+qlxigjNkwojZQHYe7UkWpZBiC4eZdkmxtaVQQzl+w7U1BhqtkStuqKl6WgECWmOydK
	qLMpYUDlBHkzH8t30U1c5TP8sok1SZVtW5igCDpAoT9syneocYPGL2dRC48xYAaVUjDVznzwb8Q
	TbzeGd6QnzKFoU7awxfVFDFS50nzDw7SY2sKHCqZUhEge9UUljxN2NGXKTrpnAvvND9UBSgydzt
	3J3RVZ70XqnamDxWBIzt9nOdQ4+z12GOFE/wTFsIc267Xdtyago=
X-Received: by 2002:a05:6512:3e0a:b0:5ae:c43a:c18e with SMTP id
 2adb3069b0e04-5b28f867bdbmr1382760e87.23.1784365876262; Sat, 18 Jul 2026
 02:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711030733.48567-1-sigefriedhyy@gmail.com>
 <01009484-2a68-4b44-b742-bee13bbb08b2@kernel.org> <CA+7S2v+BUmfHQpS7U8xhdiHr=EMt-S5F+oEPFiBLXQUOuX6Z6A@mail.gmail.com>
In-Reply-To: <CA+7S2v+BUmfHQpS7U8xhdiHr=EMt-S5F+oEPFiBLXQUOuX6Z6A@mail.gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 18 Jul 2026 18:11:04 +0900
X-Gm-Features: AUfX_mxnifN-ssdN5QDNwTLIC9pnzqBP5YlHoAeuzlRpwgxm0dLKXyukx4z8qYU
Message-ID: <CA+7S2vJ4w4NPHK4nR5WLLiSXU8+cR2ZKTuUctQCSr0tZNaAprA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] ipmaddr: use RTM_GETMULTICAST to list
 multicast addresses
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The kernel replies to a RTM_GETMULTICAST dump request with
> RTM_NEWMULTICAST messages =E2=80=94 it never sends RTM_GETMULTICAST in a
> response.

Hmm I just realized It's the other way around. The dump path puts
RTM_GETMULTICAST on the wire:

net/ipv4/devinet.c:
      return inet_dump_addr(skb, cb, RTM_GETMULTICAST);

IPv6 does the same (in6_dump_addrs() sets fillargs->event =3D
RTM_GETMULTICAST). RTM_NEWMULTICAST is only used for the
RTNLGRP_*_MCADDR notifications, never in dump replies.

So my v2 patch has a bug, I will send the v3 patch to fix it.

Thanks,

Yuyang
