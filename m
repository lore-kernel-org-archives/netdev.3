Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5BC4AFE27
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490717; cv=pass; b=jxebAmbB6NqKU2RRlyFzvqBQEY+MqqRaDHwgXKwGXuMzHFJEymWTNyAKYoEVXZAQ5uRcwV/3VXHcDk5o8yCH4zlKW6qXBxaO9tVfl3c6GyfoaaYYaCjcOy22Tt//F/2m40qw8Xxb19VuJo3GBdAlOMqrPBlXB2BjIpxfYpg3icc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490717; c=relaxed/simple;
	bh=9GwGGvfgvBSHcRik0ICfQ1lf/eR8Li3EDXS5Aa6fYyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFqFJUJxYOeEpmAMUzcFBpncy/coRS1wCVQogytFcVvDdUGG9Pb+ai22xbvmq6j41Molbgmvx3fN5JXJvFdbmGkZNsB6xYYCoTemvvullf1vXf2u1923g5r9QipMuzKcNydR0Ci1TtvfWo7fNA9yiJdcNWxm568JTIkUIzD/QUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWdbq7zW; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWdbq7zW"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa650c8so7873566b.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789490713; cv=none;
        d=google.com; s=arc-20260327;
        b=O+FuA+cZGaoEzU8aWyUpxI+R0qwLimQ18mzCxL/zMbvfqipl2HcwU2Xy1QJc0MTUpr
         txntoLkwTSbqlbd6+GU6k5Vdbbks95dAd0EBaKLSOZNHEMN6SOe7C0hzvdhDQhzQzaVH
         HInXvtwmIufY4aKNw8g4Zw0DrhSgiEJpZs3zvNSmgf8sqr591j0oPhHG2h/kyJ7BfoCk
         oO/fn1dR6FDT0jJ44us10Dlpj0MuLL6Ap/f3OrLmiipG5yn4J/H4E0LKA7CIzbBUFdZp
         yv+5KlDDKqBRKCQwJOFyPtPWOL0EjOKMzFchuyrfXqtgbhp3mfj/xXnqlWkMPYYsQ8t/
         iXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vcZ5cZp+MTIDohAvU1rokDSJo7Wxlod0GJ6VhSswrLI=;
        fh=knzHDO0kj7eJaX4EGetmTgV9Ei6DOh+Wv85mCN3sFNk=;
        b=NLSilZh5a6v1v3Bu0lCxwgX/cqCiGcXj4Z/a3+sRaogO8hvZCG+yuueLgor6fE7nC5
         VvLbE4GWQLIi5V55VYFYaatY8G/58lLNLX7Bi+NlnbODxkde4SH8dpi7wWbzKuqqfPKC
         2McuXZotwM1uHM9Y+rQtZFGGvarND9ttI8mp8zb74G7nt+HPCPMGVGfGW5trKh2Ahm3y
         q87IGTAWgsCLMh38Zfct/OuxeNVcKa/O5274G5HfDz2t6se78yJ5AhoxJDqcDKvpY5e4
         /tizeFg69LxRJx6XAPvxUFpkB+iCMa/gu/VRYKVrRERdYSmsaT+9jHkHHnlHsQV7DEKh
         4fuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789490713; x=1790095513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vcZ5cZp+MTIDohAvU1rokDSJo7Wxlod0GJ6VhSswrLI=;
        b=NWdbq7zWlVt/zVbEe0MZAYwCGJspihb0GSaeHkvsFInx0ncVpk0aLQbQgxWkAJlrD7
         yR2mwE/yH/9ATmf0FIPL2W2NDrt9jd5etw/+qi3qaJMVL3fIZTLdF+LwnWVn838Zg1Am
         rPDvNvDdVAkYK1NYFiU1rkEqzXFJg5wLjIHNGK4c+nmveCD7K+nSd2pws03M0XMXZmMl
         hRw+cptuUTGspkdaa4kLd0388NR4V+0TyzqfltGne7vRVqSIY6firDHXRzfB/tApUBRH
         tA6s5zzTuwAt330VNxqaEzrNPcPTq1zD1znhJGOhr4/zk8eHKUwscT2ClHgJHXtZy1TU
         jR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789490713; x=1790095513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcZ5cZp+MTIDohAvU1rokDSJo7Wxlod0GJ6VhSswrLI=;
        b=H+3bwFn6BLE/s3N0w45eBm1GkIAYQ7L8DdvQaY4GNJ3rwVXAKj4o7D0Zc2SFeINuX6
         xT9ADbZGu+Pw63LOzLloKrO2Ls0kaxP4JdK6JIBnSWRgRTbVg4QI60PvOLQrBWJxOL7x
         hPRJZvmD6cbnLdZovP/0nBOOWOdh05iRDp9qXwD4iWrTmhsqbqneR7/1LX3g/N7tmOKc
         kQW2OzysQjCYGFfjIzacx7o/7e5fMDhwdhQvRdil+9x2voOYYO6aG3UcvcWgnn1s4VXD
         NFyfwjki21KbidO51S9+P0Z1h/6nqPW5OpF8l0yp1izMq3iGFIo4jY7FRpB438GJGXsE
         Em3A==
X-Forwarded-Encrypted: i=1; AKwUvBy1VijVWqyIfX0oEl8uNTkSmK9AM1FpwKuO1yGnNf/57NMs1geb3YZLYn44EVgb/5tv5o6KmiE=@vger.kernel.org
X-Gm-Message-State: AFuF++klZUpwH5clBz2Qd2EvmQtqBzwk7/2Q7hxfRd/ja+sGgM/qIf0N
	S7AwOMQOE4iW0RUYkqOwmKCyCcj7voroMyUDf6PzJMpz/i1w8c4bhFQy0VSfgrAJZuWJSDeApU3
	Lqc1aPPgSEIdgq/bUlqtpkxqrUNGnZMU=
X-Gm-Gg: AYBFou0SAo7scT+Ln3n3Sm9HaI37xM6BfIbM95i8qjCBXmsmd1OKlcgXXPXGd5kR2VD
	vH26NFXaxd9wLlapoYNKcDzFDJDub+Nd8jiNkxphgQr30HNDCpS4ck4F9ZRmIvpu6SrS+aKS9wN
	wG5PDsaPqylkeOEvVh+ArVtNh0gFL45EQNI6NzL939aNwz5mnaXm2ZijwzRC2rnfxLcuU7uKrfa
	2Ycmvh5KYs36PzbGGs+UYOIusDL4bKrbZ4WnBiVbvRBLnyrr8p+3NeEXV/K0Sp5fCuKD0blWGy0
	Su/3NFTlvkU/gIzAfERlNN4+m2QAe9kok2zmkiIE8WmME7Z6MhK69F75x6JoV/avvGdmmnEoiMR
	c2O9eFd2UtZTUAxMmNGWVlkoo06bOFZLPp1CDeXuzO4LPfAOuosD/EoOYJvsjhWruF3mlNUDnwG
	Nx6++VpDL/nQ==
X-Received: by 2002:a17:907:948c:b0:c24:adf4:5c73 with SMTP id
 a640c23a62f3a-c29d773fedcmr161284366b.1.1789490712483; Tue, 15 Sep 2026
 09:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914041221.1028092-1-zack.gomez@gmail.com> <aqeyvaw06I2883Fo@gmail.com>
In-Reply-To: <aqeyvaw06I2883Fo@gmail.com>
From: Zack Gomez <zack.gomez@gmail.com>
Date: Tue, 15 Sep 2026 12:45:00 -0400
X-Gm-Features: AcwNN1WDQXY_pMC5NqZrsA4SmeYj4x-kFu6e6I1hVD1u8f-sluStJigEyZ2240Q
Message-ID: <CAErB-w3fmW4bQqRg7895dZ4ZRqkDJmfb7FSCLPvRCkwrhQzaqQ@mail.gmail.com>
Subject: Re: [PATCH net] netpoll: bound the deferred transmit queue
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 01:47:39AM -0700, Breno Leitao wrote:
> I have a patchset that does exactly that, which I wrote after
> hitting a similar issue in production. Would you mind having a test?

Tested your v2 on 7.2.5 with stock netpoll (no cap), same host, NIC
and reproducer as the commit message. Two writers offer 200k lines/s
to /dev/kmsg. The slow-completion condition is the one from the
original event: the sink only ever receives, so its MAC ages out of
the switch's table, the switch floods each frame to every port and
pauses this one. "paused" below is that state; "learned" is after a
ping from the sink put the MAC back in the table. parked is the peak
skb count in npinfo->txq, slab the peak growth in unreclaimable slab.

bucket link sent parked slab backlog
20k/s paused 8.3k/s 152k +116 MiB growing
10k/s paused 8.6k/s 58k +27 MiB growing
5k/s paused* 5.2k/s 1.1k 0 flat
20k/s learned 20.1k/s 1.1k 0 flat
unlimited learned 200k/s 3.0k 0 flat

* at 5k/s the flood is light enough that the switch never pauses
the port.

Seems to work as advertised: with the link healthy the target sends
exactly the configured rate and nothing is parked.

> I think the rate limiting should live on the netconsole side, not
> netpoll.

I'd still argue the netpoll change is required: there should not be
a path to OOMing the box. The rate limit is opt-in, and even once
set it OOMs the same way if the limit is above what the link is
draining at that moment, which above is 8k/s under the pause and
200k/s without it. The two rows at 20k/s are the same configuration
on a good day and a bad day.

I read the two as solving different problems. Yours is consumer
side: it limits how much damage one machine can do to a listener.
The netpoll cap is producer side: it keeps the sender from damaging
itself. Both seem worth having.

> If we do end up also rate limiting at the netpoll side, I'd like to
> see a WARN_ON_ONCE() here, since it shouldn't be the main ratelimit
> path, but rather something to flag that something is off.

No strong opinion on that; I'll defer to the maintainers. The drop
is counted either way: netconsole sees NET_XMIT_DROP in
xmit_drop_count and exposes it as transmit_errors.

Zack



On Mon, Sep 14, 2026 at 4:47=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Mon, Sep 14, 2026 at 12:12:21AM -0400, Zack Gomez wrote:
> > A producer that outruns that drain therefore grows the queue until the
> > host is out of memory.
> ...
> > Observed with netconsole forwarding a GPU driver
> > that logged one line at ~1e5/s after a firmware hang.
>
> I know what you mean, I'm seeing the same issue on my side.
>
> > Cap it at 1024 skbs and drop new skbs beyond that.
>
> I don't think netpoll should be the one doing rate limiting here.
>
> I think the rate limiting should live on the netconsole side, not
> netpoll.
>
> I have a patchset that does exactly that, which I wrote after
> hitting a similar issue in production. Would you mind having a test?
>
> https://lore.kernel.org/all/20260910-netcons_ratelimit-v2-0-ebf0dd91e26e@=
debian.org/
>
> > @@ -314,6 +322,10 @@ static netdev_tx_t __netpoll_send_skb(struct netpo=
ll *np, struct sk_buff *skb)
> >       }
> >
> >       if (!dev_xmit_complete(status)) {
> > +             if (skb_queue_len(&npinfo->txq) >=3D NETPOLL_TXQ_MAX) {
> > +                     dev_kfree_skb_irq(skb);
> > +                     goto out;
>
> If we do end up also rate limiting at the netpoll side, I'd like to
> see a WARN_ON_ONCE() here, since it shouldn't be the main ratelimit
> path, but rather something to flag that something is off.
>
> --breno
