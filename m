Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71814EE869
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463719; cv=pass; b=Z9a3g7FMuURNCD7C6qtmYIm4X79PUM2c66o1iwU1LFJo+7OfPvPdpT/AvYm7Z6BjBTymEcVXjWoI25q48YiPyP9Fqp/glPVUjfMZfD6n+kR9urZ4s8GLOETJ3ZwhhVz6IvYeG+8Gvo7/ur+V0G6sJ/y5Kc5sLqtMT7MB1OKTj94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463719; c=relaxed/simple;
	bh=QKxqZ3eMMR2X39cJ4mp4AJOBcwz2/Hm0JMLEa5hv45w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6pLlgUaMCvDnu7ZkeEGOBJtnzFHKxPFhPBeRum6yutAGI9D+Y+9fH80tkpmH2OM/1qRl899Q343Q42cdOXDIurfNkmFREYrJPL5y79mzhLIVdj3J2wjkVNJp32ga9FXzx+DvnWzpPLFQhD2Z2ZuQySjPfc8ydoV9mC4K8wSJzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHxCsvaB; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHxCsvaB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d8fd3b729dso1905735ad.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 12:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788463708; cv=none;
        d=google.com; s=arc-20260327;
        b=cS7COE5gfU7AdTAJbTLNI4q+a5D74QsfnREjpTErGp2mPm8w5RWpBAbnADU/yx8XG3
         w9ClC25JeGvLk+7RCaaxX085P4AVE93v7Q8K9Pt07utify7k/g4ZvRpgGF8LjrMdcR9L
         8HrOaYMf+Y3uj2GstjzAg3GRPOns8BcZJsyK2mMhCNOjBk/ulbs3QoGQrHGCAnv49t06
         egwLozD8BOrnOoD6a5SuM7kYrL/B/xSyEuWg4no15GlbL60z774Zz7tJNsVj6gKcdNdF
         x37Q+3IEJyJKuvk7RCUCe6TgfAyhi5Am0KysWGkquA/YYwter1gDVL3sx0/lguRks/2E
         CnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKxqZ3eMMR2X39cJ4mp4AJOBcwz2/Hm0JMLEa5hv45w=;
        fh=R6g3iRx0W5ljwl7OZioadj785z48JWJTPjSEkNOw8Io=;
        b=SLlM3QGy1aaLBY3yY9jUk8SFkZmkjvziYRPv9XC1yF3PH2AdGk14PirByDHLj1dKGg
         AB+s2xbEAo5ku5W+RyUUeT1SZ0CoyzmSr4eaNd7mKbcFPaZ6IMIXeXvs9MxwxDU7B/ZN
         7EJ7sMOpWMme6txvRHEn9xPtWDGUNoGmyqEmb8G+D4Dv2IxxngoEyhtcEhnot0giGkh7
         N/dNNLlqdddoUf+NjpDmXScMtB8jSt2/gdJHJt/YGuzP7j8KJDZSljFms/vWLwc5U5FT
         kg+uR5UYq+j1k70jMAuONfR28cUWdr0st77nE41A3+hUZXAHMvBrwnTi8CXtrZDuZAfx
         1BsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788463708; x=1789068508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QKxqZ3eMMR2X39cJ4mp4AJOBcwz2/Hm0JMLEa5hv45w=;
        b=IHxCsvaBn8xIxK2o1/5GqkXTcdPiKYubmDrI4T/kxrBOOuVGa+jzaBcfGVMyQOHWJK
         TTVWOGkoW0jj3AQ6REnI5C2zHKh/GIAiijcjq0Yq4qzSn2M1D6vixfoTvlOWMEqWZIz1
         w0NU4xKrdcNsGGD277i7cSWqwfIAwjGKKCb6Ju5cHJu5wlTAyGuKIofRUlDlhb9EbglE
         6I/6E0f8d+fusjqQDd0xWGd+CKYSdmc5UdQFoXP2IwLEnyp69kpSgjucZ6MGvHdtFqTw
         rIElbQ6zbsPYsqBzQqodRoEk1/9um0ZxPSJcqp6HSJeJxwxMIWihgUfkEpW3hPCn7kvN
         d0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463708; x=1789068508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKxqZ3eMMR2X39cJ4mp4AJOBcwz2/Hm0JMLEa5hv45w=;
        b=XvnltHIwtjpljNvtEI1ezeqCPMiQvTmS4Uwh+tXu6NRk2lOlzLvDVz1DuP5nLg9DTs
         vtmx63lfriVV6rnie0mgEcrz75BEAm4n+68KmYwoDHEuzlwqI7gom9myk+iqcvfc1KER
         UJd5gxdAtapzFdXaQm2UT3+L4GlX3dhalXmMU0MDmleUUovtMbSge8pNT6PFSlTKCBT8
         MmIsjCSs/PuJ0OhPxTDnIWbO3XoF90mF5B7moHILfB6pNGEfqMwVSoXZDoPhSu5eaA6g
         rs70ddRoajcUrqGoWKKgkyS4llEwxDF6zjJgyao5vIuRivoyeNpNT+ZZJPvRj0f75Y7J
         q6bw==
X-Forwarded-Encrypted: i=1; AKwUvBxyyuZFgm6piOHwHfgTTFbxt/CkJ8uBC7mtl6MnO1vtdSHGn9dKqyHoJxUY+VeHpf0/P3yomQU=@vger.kernel.org
X-Gm-Message-State: AFuF++ni3FdQYTj97D6in+0wW8d0lcNNpJqfwi61j4Pdi00rQ98uts9l
	y5CfuG/GwCn5svM9vgTmd3YBOZErHicjBl2GcX7qFdQ7F/JKKTRkHhkmPfz9tpvlMaq4K0lYOTi
	PYojhx2Za4DhbsTz7EvmBoTTXivASC/36HotC7ZrG
X-Gm-Gg: AYBFou02uwqihJoZ8VV9gl1rzagtFLNiCu+OONh1ccLAPOyS+Mhk7YKFKvHQdjuTYRo
	OkkMvY4DmMZ32O4SB6BEqkKvwrYkLdvDKSihHFZEIwkwkm/yajR/bYKLpkQuoSU3mQos520iw5I
	H2KJaPGcpQkHXh287yDYr7HhoKcYs+VfoF/fzMjQauf6RhkT9FOsqAKdPYLLPCRVkF09q5LU1ot
	NKr2OenkmwPmF4TCz0d/b8EVFvMRJxREPzzFKPaVB3XA76fAVZyj0UROEXkrpr4VPsPYu9p0Wt6
	h6aZ95DLJxDX0mbD7nm+8tcCKMogDa+04quEI2ruUM0bKus1vl/0M7Z95nioQ5w9brIgTGaF4O6
	hpm462BXFOAyxLjE9R7PWvxuK2Hq5fD2x6KPz9t7ykesmYrywosX6SjH1mO8GK2tYx/fbOXJKh+
	b5cywOrQpHYs03
X-Received: by 2002:a17:90b:2784:b0:395:4de5:1054 with SMTP id
 98e67ed59e1d1-39b26272bdcmr1062522a91.16.1788463707201; Thu, 03 Sep 2026
 12:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824033331.1084971-1-imv4bel@gmail.com> <20260824033331.1084971-7-imv4bel@gmail.com>
 <apaAskNL-IvdcR7h@v4bel> <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com>
 <20260901085102.5c58a5b0@kernel.org> <CANn89i+px52TtJy3S9=uHxGj3s-WueguRo1Z_4FxO=02KLmwmQ@mail.gmail.com>
 <apnHqmYZQ4yzOP4N@v4bel>
In-Reply-To: <apnHqmYZQ4yzOP4N@v4bel>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 3 Sep 2026 12:28:15 -0700
X-Gm-Features: AcwNN1U6zY6LZ3oh1KYqCMuclwz2vgIWYpsKBP1jBBoFZoxWBAYwuULPqKemveU
Message-ID: <CAAVpQUAVXFrRuxPCKW_4qqAAdjTpv+arijYODeFMfXshKqajHw@mail.gmail.com>
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, ncardwell@google.com, 
	dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, willemb@google.com, 
	andrew+netdev@lunn.ch, kees@kernel.org, jiayuan.chen@linux.dev, 
	kerneljasonxing@gmail.com, ij@kernel.org, martin.lau@kernel.org, 
	shakeel.butt@linux.dev, matttbe@kernel.org, martineau@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:17=E2=80=AFPM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> On Tue, Sep 01, 2026 at 05:57:04PM +0200, Eric Dumazet wrote:
> > On Tue, Sep 1, 2026 at 5:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Tue, 1 Sep 2026 10:03:51 +0200 Paolo Abeni wrote:
> > > > > Looking at this further, unhashing the listener and then calling
> > > > > synchronize_net() lets the disconnect path handle it. MPTCP needs=
 a fix
> > > > > too, though, because it closes and reuses the first subflow direc=
tly
> > > > > without going through tcp_disconnect().
> > > >
> > > > This looks like a more palatable approach: this patch in the curren=
t
> > > > format looked way too invasive to me.
> > >
> > > I likely lack context on this, but I was wondering whether we should
> > > potentially disallow the transitions between listening and data socke=
ts
> > > instead of fixing these endless bugs?
> >
> > +2 I think I mentioned this at some point.
> >
> > Same for IPV6_ADDRFORM : we should not allow transformed socket to
> > even use tcp_disconnect().
>
> So.. do you have a plan for this work?

I'll post a patch to disallow the buggy transformation.
https://lore.kernel.org/netdev/CAAVpQUAWjBuF1Rgze0Vt_XvkUT=3DAjw-F+Kh+s2iHk=
38c8iAapg@mail.gmail.com/

>
> Or should I send the v3 series first? I am still looking into related
> problems, and it looks like this series covers most of the "important"
> ones that have to be handled right away. What is left seems to be the
> UDP side and other minor problems.
>
>
> Best regards,
> Hyuwnoo Kim
