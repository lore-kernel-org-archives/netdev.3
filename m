Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866DC4B0C83
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490462; cv=pass; b=EDSoGf4eDCXwyLN5gtoWTfPx6znQR6OT8V4y0sOVQgEpBVIap578doSuoLiLxox7039ZlqnY/iUk7IgDb/WKx6DNY86cRAD6gDK9wILWegW/r0qHFyhBoC+oH2AFoXAOYbkz5WJc57W6fgpgG2ZrV/8I+ufuezQj/JLgp5kr1xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490462; c=relaxed/simple;
	bh=WZtIOEajUb1A4OG5IeP7r4iAQRTAEwrxT1fJ01BsrTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQz6xbTD2X4FmHEHlcRYjJIkihr+QYxitvxbw897Sjdg6BlvvvgSTYGAubHvdAOrQ0W1Q1dR2N2nG/7aNe8K/EKYqSh/1l6bhG08D9wjO4B7O0pXXe6jwSaRniPZvwDQY3mgf4A4Jkuh9H6BfSXVm5AHpYIa3e1CC0u5ZcThb8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZXoHJoB; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZXoHJoB"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7dbeso5258766b.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789490458; cv=none;
        d=google.com; s=arc-20260327;
        b=Bd/qemnmXpAWJRKA8fA5H5BZDdvuOt1po063jNxJNh4l22cJIzia66A1BQngxjFZ+E
         OAUEzktMZZ6M3S/JFNx9anlPvpeyVOU57MiU07q504Lu9mFQeeulBsWG5whBRSShXGGx
         IgcFv3Zy2M2Qd6TrRMGsw/Eq4wSBbzI9IKuSTaOLJKgBXHrdepXrCV4uEwf6aIcDg6oE
         d0LTkGeokmFg3WjkkExwOSbFSwPghUI886fvA+0iQgCV9/ax9oQwdSqexv/FCZHT2Gyb
         LkgQiMhAqKolJToSqGWjkpZ15YJQTQ1vTvxPnPxbHAjVOZGBuW1xcM5x/cYRmFzkoFh3
         FumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vu3NNJZGM/HCH+I3878/9beQnFbZsU+rMWWInCqvw5Q=;
        fh=U67/rihWGxHBdV5aRSetarAlexhY+xb/GwYdRsLBcQ0=;
        b=OyFY92nAtEmlMHQZx49WeJ3v4buuT0cDWGCjZtqiCHxC6YclkOn7NWxhlZpRwMr2wO
         YKmOcMbhA9rHEa/ra75pP+2VHKZ8pdiV4K0tX9ecEhP3xSskiKu6Hvt3IMxKK3pLinbm
         J4QJCO/b48KWqhZZRS1lTr1RiuAKxXxblUFsL5rEBy9bw6kJq3moZGSH8v7uJBQzah2T
         eFf7MvEBFt0GKiocfTRHMbgtiG5GbR7xnIau3d44ZtkFUAp/u9tdp3Hy7IT4ueDpDowU
         PyTQRlSs524sldNwJmLY/1+Zx5oGHfV2aJl+uuBgXNCPNxcqy3Ic2XkXC+CmXBDbjMDI
         Mtew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789490458; x=1790095258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vu3NNJZGM/HCH+I3878/9beQnFbZsU+rMWWInCqvw5Q=;
        b=TZXoHJoBzex8LT9sllzvfXb+gaxEyUDcHaSdPUHfZ/d/RlW6ikG0SRIQgV9QJMq+89
         8OGoivjQWCYbgbEnlav790Fgc9FvGOXvbFlkSiffIFQNRSytRc2jYTXuaE8rj3AcgIqW
         R0xBxukM3pfM9KmNV661m885KKfz0Pz5uD++jgelyoHNu8NZHdlSzjxIUb6Heg4Ssfg9
         P3qP82gwjzO7SLURAfHc6wtI9iQIOL0kvOiMi6Fw+JjVuOH1BVg4HT6okDqv4nAN+V/K
         fGY+r8YKnP+/xStiy3lEjcFMVnETZj8FzncvEzi8becKegZkWaSRSqHgpk1fMPeOfrVa
         VuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789490458; x=1790095258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vu3NNJZGM/HCH+I3878/9beQnFbZsU+rMWWInCqvw5Q=;
        b=vGUKbEyVU5xeqVMN65ZnfTH1+5uztaZeOGH/VoenSVSA32+yWSUTDAPmWb/XCUIyCY
         bPxKYT5+fVCvFlgFag6PqTfOx/LK+RFB4yEuxJ2oam5KvDf5iEEMsyisVuIVhv4NXVUE
         kV+/CD6uv/yuSuNnx/0Rbw2jtOwg6DtUmgPRtwCdfsFgTyIKhkSucpYGPmhQ+cx5aYXw
         3y8/Q1Xp9qMih+FS8BzWcoDgkvngxywIMo6hS0fLM3KEzgAzK4MLF8PlNRqeB6Dt5JXz
         PTNAXWUgP/dO4SFp2nGM0N/iJ8yBJuJ7xujX50gJ6q4ujttRmr77zplUb5vgDDoHpKhi
         sQSw==
X-Forwarded-Encrypted: i=1; AKwUvBzXQhIc6QGroUeUcLU+h7ZZA3fvZsuzZLL8EvNsL1QXF6R8btFdkhPOp3F9njiVL5rNuIlwCNk=@vger.kernel.org
X-Gm-Message-State: AFuF++lt6qusPbxXiLkFJW+37ftPm28gZS2QcFILRX0pn3f+1KpSsa4W
	hvbGQ4/K49eir7yNHyv7OYPXgNUMhg3AgNqZUJvaRgbXRdozL8O3ynkTk0tXDwbr4mXLKJBwfVT
	NEYZ/kuQCrxqH9qJ/nxSNHKsblMPaErQ=
X-Gm-Gg: AYBFou2WIbNvUaOZQnHwbmujvV0NGPRJf9GG2uoj8uxJv9UBsZEFNv3n/zkbDnHc2hH
	IeV/uRcahhaWAHy6MPndLLk4s09Riqu2BJ5oyQgqCY1QHAywe9I+xSEv8PCeX7gLxoDwx6zcFvq
	RwGsl30c1FxOKllU2JcdncwGQ5L5nWBwKIm6bjnWoJk+lKXMnN0GzSLvWwFx152aemhU6xLAa9b
	3VsUaVHe/zhNreVTmlnSQcWWSR/FUT9gC/VXM6vq+yaq+BjgHMELehVpb2qqs1amhnC2rNmU/Ko
	cbJtg/uG8a9RGXJuKlFpbgSFjk1K51KxB7fQvqh+jkxnLClFmN5V9YMdLIC8ZA5KYvYjq4u7jpW
	YyyijxLn3tlz7YxNoJ7d5A3VyZaQz0yC39crk9LBTypPGn3dgpdFB/+oB4CDl+fjeOuXLFPjyvi
	JVRnYxscK5eg==
X-Received: by 2002:a17:907:7b8d:b0:c29:5172:6151 with SMTP id
 a640c23a62f3a-c29d79cefb4mr148064866b.45.1789490457246; Tue, 15 Sep 2026
 09:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914041221.1028092-1-zack.gomez@gmail.com> <aqeyvaw06I2883Fo@gmail.com>
In-Reply-To: <aqeyvaw06I2883Fo@gmail.com>
From: Zack Gomez <zack.gomez@gmail.com>
Date: Tue, 15 Sep 2026 12:40:46 -0400
X-Gm-Features: AcwNN1V1k-oe92wPE5LgPY7yR0oPHt-_r4hbhbeUUXP5pnRcpfylG1YgWf8SGfA
Message-ID: <CAErB-w04-1NAxCV7hdZFxcbYx5LTocmtvCOj5mOSXD5yCCTqXQ@mail.gmail.com>
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
