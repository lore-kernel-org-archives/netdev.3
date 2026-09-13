Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612421A6816
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 23:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789343941; cv=pass; b=QSaQyp6Ulvt8W4uxcj3WUgr75qF4HuNnpa09PNoL8dLCMRDG+pZD/XV/ziGa3On8CUkS6bO0rEaVLxQzrlvQaXjt/inhJ76OMOQm4Oz/1dc18Q1Z1+K3ZV3bLxDQskz5vDpk88bmAMp/SDd4C6KTdge2XRxbwlgUPQTWReEGv7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789343941; c=relaxed/simple;
	bh=YEV36a1/dmLBbcJxEhStmZVvh/RjCYygvgq4nB8g75g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+4aRAtcIAliWzCqQOHJ9PKxzH1tfeguWC32cS4msIxSR+yY07FNBUKhN3ORyiU+NX8ZgMD6WddUp4WT28QbWfIANKFnxN1fceLwUx0jpJBBXlOOBqj2p82aqsGEJPestMZ/F+Q/Msmbix6KbLA7+sHHY7Gl1x5W60Wf3xuaeVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkefwH1h; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkefwH1h"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-530fa1d2b31so6943951cf.2
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 16:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789343939; cv=none;
        d=google.com; s=arc-20260327;
        b=MX/I954qPjA/9GFrxprblbq4Dpr/uc7NPtOf4YZ3MKPuTgSQpg1wmFYKO9/QOhWkPN
         pEGHR0cLeBrxxFI+QvTcZsiaAvonWNovYWstx0ZY9p5CxU9AjoW9WgNqRlHFOTP7LMZl
         Bl1+Q/DpRTlhkUD6WCwgN/LTSA3OZBMluHvW2sOhhMyAKSP6Rp956CAM1+ad2I4vjAlG
         ZmYSlOikWcqm92Zp1JB8LTPaCsJxc9AtDphX6fAqmIYUVyBKqEpgsz3JlRU+CCruOWGz
         09PxHgHoevJNwGWFpobAZXJRIuTFthEZXwra7GuxifuVPvHNViqv0nLp3ML699Bwa8qk
         8ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dhh7eh78JXhKvG7tglGxyB9G1j4KiAZp+u2eEmQ/ies=;
        fh=LJikBT2fjxFikA/EUjstPYSBz5j9gXldIgZjYQ6PYbY=;
        b=pMLt03TOXdnPiSqcRdnrpXusb7A4QW44q1GyktFEIxcBisWFdrxBj3laEsrdzJ69mr
         GYIikmV/6Fuh1XiYV0AWTG3UkgXK0GfBlWxGPmossPKr/sxK9Bvbc7b6+2J2XLU52ubY
         IdrfLKtXN3/+dVpBqDHh7yLqdbZKDuqSFK41P1E2qjpIbOBJ7tEkIaU4itO4ZAf1dXqh
         DK7FQkw8VrOqV9JtDvc2i02YFxMmen9MH8oP9SZVMtaGDPTK12A3HEtGC7+vb8ezrP8k
         oukcU+Vpeaz4IFU8ZupgjLLZOm2W/1JGDCLSHz0v1rYFu8+6/SA/bmrkZo7acvT2mPbC
         lamQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789343939; x=1789948739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dhh7eh78JXhKvG7tglGxyB9G1j4KiAZp+u2eEmQ/ies=;
        b=BkefwH1hIqmjL+o8GhIqfUXIfdS79zmdLMaNbr3AlThM39iuH46aCUzyp7GATj+9gL
         rOzl0MfKrBZGncjk3KwWsGm3ybf2VtEkA0wwE9eKm9E7xxvF1GYaYJNAwiK5daqkBvsf
         hzGbIuTlwF7V3kL7Ah0VxURY/4zLHLHBJSK6S7nDq7Gb1OcpP0TVIeSlhgmrwIoHiIAm
         fwcfobor/b/09TwXIKXJsUgzzdNikUCHl6+uexlmcoFBXzI8QDVe7t+myvnu1ozvQmqL
         3rLX/blzbL8S9vUYckwanUTeVapoO2c8kUgIXHbmfE2yOAWe8Fwrrg0lH2ptfU/F5ih5
         VQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789343939; x=1789948739;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dhh7eh78JXhKvG7tglGxyB9G1j4KiAZp+u2eEmQ/ies=;
        b=LOcC57tFWw2mxVC5uvnW821gk/C8TdOtZVa+yty0TBhDyYRJjT/RF1J4VTFE2JOB/U
         GahAYDRPW31gPHbpkT1NGM9UUtF2+jfH5ZpylzmXY2LzNa1mJh/dgGyEZSPbkBAJOvZm
         gE/CdoH60LJ7phZiVFzjoZE/5eSxncMz7ZpfFGKG3h2ylhd6x4V+hRMGS6yJdQMSIraE
         AhiNpzSIh9e8CuqWwNK7hgQW3NhhYSYOFoXfmbcAAAOLd8vSJw2CozS/pUGATCB+kriv
         mGUNOH388YdaoYDIfwudvT6EnMzTx0NoWmu4JupYwc+3w8BZ32M/5RtWQtlnxILBK5AN
         WKpg==
X-Forwarded-Encrypted: i=1; AKwUvBx1DEGUTGMtmI8++vCTXNC0WW3PkS++QXZGKN1R84W7uJl56Zu25igVEzUw44qt7b90mGOgn40=@vger.kernel.org
X-Gm-Message-State: AFuF++mF0w41p2C4BQCeLoWjM7rNJi/8T0Dzu2uDRnqWdRNnuTg7N+II
	PRAWNkAv6GbNm8+nfqJpyIXwLjOMnXi8lskCrZYwgwYiD9co4rMOAeHXbw3dq/LjvKEZsWbyyB+
	ceakqRYRdP8sqJVIS3o+qYj7Xh5WXJKrZTdJ3m68b
X-Gm-Gg: AYBFou3epv5gmWg+Me4bvF3lGBIhjzjOjXpGCixjPFOttcME5M6Xr4hUW0ZWmQDQwpP
	eM/BgQs9cTlTI9GSIH2Qx5m+FjJfoJs0EdHM3ZQ+QPGvvfEN/hBiQZvRte5pa/TYrCBzlQqBrQp
	mw3ubyGtPyH+T12h8E5Qu/FBxpcT1snt8oK9/RH57j96JKDUEsonfnqUFREBsgnly/cMe5AcpZp
	ZWa7vsQv1M0YW4k6a05ZGQsvb0aJH/+aeg6t/u3bFnyd6O3PUhMtmFS+LG0zGKbB+/3aP0U0wfM
	rpYQdVK97s6HXIwpnIW+fBfXGHEa2ZpeCjVxGgiRseXx5gaOAWx70d/eE6uzpfxjaBUSUGgkmNO
	c5Gi+tz+jLWmRzP3OKWsB0riPvIa48xVJFaS72ztw32uBwJ/7FY0ga6ErjY1GfRANRo0=
X-Received: by 2002:a05:622a:14cb:b0:530:e7aa:ef4e with SMTP id
 d75a77b69052e-5310cf4c994mr4211621cf.16.1789343938551; Sun, 13 Sep 2026
 16:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912233048.3977192-1-edumazet@google.com> <178934237420.22033.12474248772012953233@kernel.org>
 <CANn89iJGzZY3HYpUjZxJFPgWOUs7RJDJnACTBwcGhjcb7AvyAQ@mail.gmail.com>
In-Reply-To: <CANn89iJGzZY3HYpUjZxJFPgWOUs7RJDJnACTBwcGhjcb7AvyAQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 13 Sep 2026 16:58:47 -0700
X-Gm-Features: AcwNN1XAI91JYeabbiejo72XCydJWA3bOtlYuHf1Z9ZGi-lf7744WvTrW5YOWEM
Message-ID: <CANn89i+62D2BTLWHZHPzM6N8ALwr9mGoZiK0YxGXs29Mar01eA@mail.gmail.com>
Subject: Re: [PATCH v2 net] pppoatm: ensure a writable skb header and linear data
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, mitch@sfgoth.com, 
	3chas3@gmail.com, qingfang.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 4:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sun, Sep 13, 2026 at 4:32=E2=80=AFPM <netdev-bot+sashiko@kernel.org> w=
rote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
> >
> > - [High] pppoatm_send() does not make the frame linear, although the
> >   commit subject claims to "ensure a writable skb header and linear=E2=
=80=A6
> >
> > Pre-existing issues:
> > - [Low] net/atm/pppoatm.c never initialises pvcc->chan.hdrlen although
> >   the channel requires LLC_LEN (4) bytes of headroom for e_llc=E2=80=A6
> >
> > --
> >
> > pppoatm: ensure a writable skb header and linear data
> >
> > pppoatm_send() now uses skb_cow_head() to get a writable header with ro=
om
> > for the LLC header, adds a pskb_may_pull(skb, 1) before looking at
> > skb->data[0], and defers the SC_COMP_PROT pull plus the LLC push until
> > after pppoatm_may_send() has succeeded, dropping the old "undo" heurist=
ic.
> >
> > A couple of questions about the linearity claim and about the channel
> > headroom hint.
> >
> > > diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
> > > index 6da52d12df68e..5214786e61d11 100644
> > > --- a/net/atm/pppoatm.c
> > > +++ b/net/atm/pppoatm.c
> > > @@ -292,10 +292,13 @@ static int pppoatm_send(struct ppp_channel *cha=
n, struct sk_buff *skb)
> > >       struct atm_vcc *vcc;
> > >       int ret;
> > >
> > > +     if (!pskb_may_pull(skb, 1)) {
> > > +             kfree_skb(skb);
> > > +             return DROP_PACKET;
> > > +     }
> > > +
> >
> > [Severity: High]
> > The subject says "linear data" and the changelog says this pull is ther=
e
> > "to prevent out-of-bounds reads on zero-length or non-linear frames
> > (e.g. from bridging)", but does this pull actually make the frame linea=
r?
> > pskb_may_pull(skb, 1) only guarantees the single byte read as
> > skb->data[0]; skb_cow_head() -> __skb_cow() -> pskb_expand_head()
> > unshares and grows the head but leaves the paged fragments in place.
> >
>
>
> Linear' as in : make sure the first byte is in skb->head, before
> reading skb->data[0]

I guess I need to invent a new term : 1-byte-linear

Perhaps this will please/silence our AI friends.
