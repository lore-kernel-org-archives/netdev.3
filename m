Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA703CF209
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788667728; cv=pass; b=XTGnl3YfxF17hDfMPvKGm9CgeVWGeK7/AYSpX+0LCejt8ul2C8ort02WBxq2XzE/HYT1l7/MeIFiig7+Q4q3nloe3eeYBXZHkGsu6ye+orFdmt4MYCecj/P+zDk3PRwDAzSdcgNwoElDC79NNFFlaVxRmtVSbJxhsf1r+LWlFOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788667728; c=relaxed/simple;
	bh=eROzLL0q0ouiSUPHBo2yP9ODMUaFLLh+pXzP/8kVr4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XI1QHrSIMjS0pc6UP/d337/Emd/x24T/tGWDZEFZVCKF/sGS5Ge4a3q4Ba35iJ7hq4B7oMgJGA6sKO5EmyKFcHvvp37ZamAs6pij0XeApKJwh8fx8RMrsc6pFDxA+DOCPzldTcjke631RJN7wtXclSn5XQI8MVlUgd7bYQqoGa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=aUxEkIEf; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="aUxEkIEf"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a2b4743936so19637441fa.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 21:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788667723; cv=none;
        d=google.com; s=arc-20260327;
        b=l5Mg/f23JC9JGdO3lNIfNZ2/jbDNGWPQcsciegxTGCHp9PZYp95D1RZ7W1YKZJ5sgE
         qIUZq4rSsEsWBQ93H9nQHONyPXDAXWwu+1Zhi1nmT4bkfxGI5ezKhjinQ8s5b9G6NsLz
         QNUFauX1sKvi6l0oIZe0PkF6HstnG+b0pDwyMYotOWcF7pHXbDv1yRjc9vAuPqjwsAXe
         KrQ1MzLoSRabpRncrQYa8ch8CPImbydthbUbQVQbe83YqFryDMgrPxjWMhYGS/+Xzf3l
         oUzYN92UhjeoGFeqfyMQ/jS7+vN8J6Y7RqQOfFvLhwQdU2XFXqKNLXgbN82owYlxsMav
         ivjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/qnRZ1b/ThxLCDKg+XNGDfO9T1I8FVJXyvQjT9BlGzM=;
        fh=t4FCq4otXgaZ3pkejIck03b+fW5jvnX5IF1IQXYZG4o=;
        b=iJcf00v7JqaA4ZozThoIlrINJxWt/xwOoiTzVu8xbI9Ojyr0ClbzQ1bBpqGSovfj8h
         +WYmQGcto4nsh+FKeEt/AGOfv3R0euE7Hxy5O/Ec014tTFx93uQ4wAJEepE1egcQxyXt
         /DrwESQjrPwGXj0eY9gOQenLrxjND5ERxiq3fogRUHKc4GuX+3/JOolikNJuUgGkM798
         DHQrC1JmYlsCzKr22kmL3u85e9FCry2Ridk2lTnFdejFu3GDJhepAFzqDyE0InDwysAy
         Z9oWmAASSBL2JYIbrIx1N2s/ZiC656afr+WbcH3ocDbP4H/Ii3V4Md0OCh2h5S0my+LP
         h/Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788667723; x=1789272523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/qnRZ1b/ThxLCDKg+XNGDfO9T1I8FVJXyvQjT9BlGzM=;
        b=aUxEkIEfst2969ukf+XsHqcWqNmx8Qv/9mKsnIk5iz65Kpsa/DOkmQ+0ItwstA9oJg
         W94mH/IExfM0KQIuvOmi7e6nG2IixkGIfC+d+kl82pN8sCrXGgvre09ea0jut1cwMFP9
         bVQUn4fUgCgzZz99FnXiqyocLr/CPoinfFZ9Z2SrGuM+6UaXvSH3+eTKenqILIkQq6YQ
         5+aW04f1+zYSl/MMnaAVoECL6P1OoN59Od99t/2sgVdttt/vlFd9S9ZLF08uPZFrEFNf
         Eku/EJTL0qQf7E24aMqXpcDiESceKYZDIjCfDmpwam5uZLUmOVcnxVCM3ZxzdH2+cIG2
         IuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788667723; x=1789272523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qnRZ1b/ThxLCDKg+XNGDfO9T1I8FVJXyvQjT9BlGzM=;
        b=eqHhhzcl4WDnLTla4uYfcgZz0oGH8pGVKNQnAo5yTma2BQouLoT1Sb38L8u6DQuBMk
         OwpjJiMQUc0a/KHv9wZRtRt04XFKv6Jsecasuyw5AAyYnG0uMQd/MLFlCuhy5vZXv9ad
         ySaeI1x65auNSaOvXQPWQp8DKpwSANrWLulEQfsSLPDfmI8nNkldDLMFbMNczn/oyFD7
         Wu+fAEFEH84nDAFkZvXQY47PxE2Dyozg8UFlcFA3DvxxBhfcC1kOJN75/FWmRRniufcf
         mDrcSRdqHWj4k20VQv+VLX74thHr3lPZUAGN+KUMIQsarAEAv6ZvDYXsk6Aa+b3sG8a7
         OqBQ==
X-Gm-Message-State: AFuF++nppDAQzHfmKWdtAl/BbuwYqOqyJilORjAtNe4AhcqYPvDDZUvl
	uEeclJ371G/d/tPjE81jIHGMxGqrE0AxRq8Irhbj0MdEQQ+CFiqapgHh+DJA0agp1g9/lioSz0v
	oNXb2JH7nHOozUjawtyB6s4z+k0OXqw44ewuRrQWukueNgvd9tS3ka6yRNIQvFg==
X-Gm-Gg: AYBFou1x7RoLTp0g7nxUn79p0/CPub3j/lIAkK5TMlu1rtga1gxAWlCLzumPvmrfbJi
	Sc6KcRPSLTjfi/Gw9AdgaFUwNBGAeqiRs/5gTzDDoIzOn1j6/mlX1gqnMJhFpXfnK206m0HkLQb
	BXThHyIkPupzIBYO6AAR3ao66+6S6V64MWU3a1usPc2sKNHd16SoUJYYRVZBcfPJCNS/nWfpI+y
	Hng/YXyhNcEoJUPOvLU9FF+VbUC18KjM0xlEPKlAZy/Meqf18jRkGV1jvPSmhA7wFBk4jYFgr+7
	INs3DM+awnnuAXVP1OJ+I9oxVzIteUqmtB8/8rIi00bWvrFUhefgJxsObTDeyE3oLOiPBBgdqbM
	=
X-Received: by 2002:a05:651c:2205:b0:3a1:4b92:76b0 with SMTP id
 38308e7fff4ca-3a371b5a644mr16405391fa.5.1788667722643; Sat, 05 Sep 2026
 21:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
 <20260905151227.75099-1-horms@kernel.org> <CAANe3eRpVGnYpygfiQTsXd2VmBO43P-P1RfREkdDypgXBZB9Uw@mail.gmail.com>
 <20260905190217.GE40544@horms.kernel.org>
In-Reply-To: <20260905190217.GE40544@horms.kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Sun, 6 Sep 2026 12:08:30 +0800
X-Gm-Features: AcwNN1VTRejeC3BkfntBUh_MIrPvKzSvYUZPlMcVAjoUU_1YeMmnOwv8v11Td5o
Message-ID: <CAANe3eQ-N3fse+6hTJfEjHQT+y=xkZA6eYVeD--+k+fdhZC5Xw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] udp: diag: bound bucket lock hold time
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xemul@parallels.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:02=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sat, Sep 05, 2026 at 11:49:05PM +0800, zihan xi wrote:
> > On Sat, Sep 5, 2026 at 11:12=E2=80=AFPM Simon Horman <horms@kernel.org>=
 wrote:
> > >
> > > This is an AI-generated review of your patch. The human sending this
> > > email has considered the AI review valid, or at least plausible.
> > > Full review at: https://sashiko.dev/#/patchset/133b6aee9e2c908c9da37d=
5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai?part=3D1
> > > ---
> > > udp: diag: bound bucket lock hold time
> > >
> > > This patch limits the time the UDP hash bucket spinlock is held durin=
g
> > > netlink socket dumps by collecting a bounded batch of matching socket=
s.
> > > It takes a reference to each socket, releases the lock, processes the
> > > batch, and resumes from a preserved cursor.
> > >
> > > > diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
> > > > index f4b24e628cf8d..18cfe0df654dd 100644
> > > > --- a/net/ipv4/udp_diag.c
> > > > +++ b/net/ipv4/udp_diag.c
> > > [ ... ]
> > > > +static void udp_diag_dump_done(struct netlink_callback *cb)
> > > > +{
> > > > +     struct inet_diag_dump_data *cb_data =3D cb->data;
> > > > +     struct sock *sk =3D (struct sock *)cb->args[2];
> > > > +
> > > > +     if (sk) {
> > > > +             cb->args[2] =3D 0;
> > > > +             sock_put(sk);
> > > > +     }
> > > > +     cb_data->dump_done =3D NULL;
> > > > +     module_put(THIS_MODULE);
> > > > +}
> > >
> > > [Severity: High]
> > > Does this module_put() introduce a race condition with module unloadi=
ng?
> > >
> > > When an active netlink dump for UDP sockets finishes, inet_diag_dump_=
done()
> > > invokes udp_diag_dump_done(). This function drops its module referenc=
e using
> > > module_put(THIS_MODULE) as its final step.
> > >
> > > If this was the last reference, a concurrent rmmod udp_diag operation=
 can
> > > proceed and unmap the module's text segment before the thread executi=
ng
> > > udp_diag_dump_done() executes its return instruction to return to ine=
t_diag.
> > >
> > > Could this result in a kernel panic due to the CPU attempting to exec=
ute
> > > unmapped memory?
> >
> > Yes.  If that module_put() drops the last reference, rmmod can unmap
> > udp_diag while dump_done() is still returning to inet_diag.
> >
> > I will keep the extra module_get() in udp_diag_dump(), and move the
> > matching module_put() into inet_diag_dump_done() so it runs after the
> > callback has returned.
>
> I think that the fundamental problem here is that managing module lifecyc=
le
> from within the module itself tends to be unsafe. I'm not sure your
> proposal addresses that problem.
>
You are right.  Keeping __module_get() in udp_diag and only moving the
put into inet_diag_dump_done() still lets the module pin itself.

> I think one possible solution is to move the module_put into delayed work=
.
> And another, is to move module lifecycle handling into the core.
>
> Possibly the first option is cleaner as I think that only udp_diag
> has the need for this.
>
The extra pin exists only because the dump kept a socket cursor after
inet_diag had already dropped the handler.  I will drop that cursor
instead of adding delayed work or extra core lifecycle state.

v2 will bound the bucket lock the way tcp_diag already batches, and
leave module get/put in inet_diag_lock_handler() /
inet_diag_unlock_handler().

Thanks,
Zihan
