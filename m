Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130343;
	b=gggTV4p4mqxo3r2tTeCsjwbwJIPlX7YZUSW2O6eq9i0gSXRASC3yt1lj2S2Zm2H4Ixw5
	 DEeG8GgsXJ9noaxVna6y8epjecq1Guetou4jBHgERXYT2rKKfm2GsE4BqhyYr3hax8j5K
	 sDK5tKi4iQhP3S0hll1N+lcoH2zym5BZlFnvtmLd8QEcO8Wr+xukU6YeimjsCeGNrJen3
	 hwY2krx3R/2BwHxvF4uRH8+aoI24Ed8oLSOwetdhrdzOED6lzWsx5Dx6ARGEaU0lyaE8K
	 yAwGuOzilvr4kRWwisWQlt6eynVNQT3r/q6xHaU95w32wc1wcM2fCkrt2VthBdUJjNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ogjdZNRhBvM3uhV1/iXpFfYGVHaekc8nB59hXwFT7Hg=;
	b=qEKUfINFuLlHBgFoiiKChU/nlxdjADsUDAaD398w07gaSTbFbV4t8FA3jVz7YpbhkFqm
	 bNqD028l4BpoYIRA/vAa4mQkkE8TxkJDC7Djbucp95O35VMMYexXRBWzh02rspSkyn8LB
	 +PNMnd6iIGAwFBF7zExc6Ax0Np40AuHxsWpDliyNbZOGbC7QcPIp5s1VDrosvLvthz358
	 +UKjiapxrovidxWV85LlentqdWP4YMRiZwSA2Fnxn5UcslO1YDjogYajD2ghz28w/IuKn
	 ZYJXkWjcMotCOjMkpE4FoYyA+okQMUKaf1gOlVWrylIBGMypipi8X6lKxbMu+s4Abqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QvtLJQnH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F3E606A32A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 19:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16F3E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QvtLJQnH
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06454116eso178590b3a.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793130342; cv=none;
        d=google.com; s=arc-20260327;
        b=PZxQ/tuLORnWY85zrkBIHe+1pS2ybWdFF8jAxmkvlZB6xWedKsxJo4H+WQmeB4aE9R
         IubaWt20eQdIU/ksdyl5bOJnANGJUAtwRZV7VyLzN/AAIO6lu1dcDRiOVuX3qMSfQeZG
         t/rDMR+1J7+VYfdvCHtSwHjXKS941w7of6mUwyhdAEQPan5NYOXjd8PHzG1hfuWJR0sB
         7YvTKyIgEfGir7fo6xGjv2xaIBZTH3eSUk4awkjXhIT12+SFLsjiXL9C3RxJrl3yzCqA
         y6FJzozoZuaQCo18RIF/gJO0wfC0AIDcpZ46Y+cGn1NWy5Q/CTO50/f9Dw+/H9xZjYpY
         GQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogjdZNRhBvM3uhV1/iXpFfYGVHaekc8nB59hXwFT7Hg=;
        fh=c4J9cf8MF+L15aGRB2m/8lGgMG/7DxdzRPKRsygrqC8=;
        b=R5oXN/Fl1Cy0ph1NXlLlSJo/bvuP39LXZoNkR08gmFDNVjJ2ri8zCz/bGrhIJYLI6V
         6MzcsTJTQCeoQeN+oIwbzcGZ8A9uhMBzklpbo/My8Z6KKWgvBHW+DFFyQacXczaidIDl
         ABuTt6usWVVLDPwfWvmqtTHj8XiUazH1ydx/krimgtoNRpp4jpKZBzVouuj2EvdB7lgX
         EEH0Bk+haXGlgkzhN8wGgEAWvD3UYrtYj7L7BOvRQQPmbDZ4/YdIycrd1gbCUKqUCdAo
         1hd2Q/i12MwvkZvqySAbZoguPN7/DA14UTlWV38vVEMuYvUmn2O3+cxJttwpTQlLy6xl
         5WMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793130342; x=1793735142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ogjdZNRhBvM3uhV1/iXpFfYGVHaekc8nB59hXwFT7Hg=;
        b=QvtLJQnHGRLSwRNPoYCSXfeF3sSHH84H1GAref5X8bRhAghX6Vz3eDiLKvQkm2UymG
         kgHEaxULJi7GJEievjPGR2PlXtayLjVylkEeHRs7MpgmmFYAiAZKShLZZdyk49M9GXdf
         mLSx1bDdgNW5KY2otgkeOMMEVbdOHoZTqlRgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130342; x=1793735142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ogjdZNRhBvM3uhV1/iXpFfYGVHaekc8nB59hXwFT7Hg=;
        b=umCVcqJpdqqVrggkXqmz/AvvSO8cp/L4wMZQN/o6uQVb2Zp1df+vNyCw6VYEbfzO9e
         qrv7UuLHixSwkfDDwuJKdR/CJQuXnllh7yzzVJfeWzTswCndMQs7Y4yBR2QbD3N47hu1
         ZC2gr8tTEmEyYos6dnIeownbwgEIEYePsPk0B8+GXpvjtQzDt1sChvvttZJ9qR99uDcP
         De0b1csZSMbzNAx3Z0x59sLYEyA5w8H5lSWt3cpzLzeF/l0yNW8KCBa8ysmDw6enZ61U
         ICzBrZhEfm9W/J5Mxt+7w5uQjOTN/7d4ruwLC0Ut7oGwNNPwYrH+t5VEcsHIaYNdqNbS
         Wk3Q==
X-Forwarded-Encrypted: i=1; AKwUvByWA6SusOLhpoNs24j4yP4PTbsBEByBisV7321KLnkyK22Dmcm0JnuUJ/cQAdlEsxyiPyZHd4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKF9l75iXe0eDHP6ek2zq2eN9CLwwrsID5VUa2gxqgUwb5EIuVb
	AIg35vtQO0daYl7rabnijD6pXSaLs2awIhUFGe7oLscouy0wJnhJm+PINRziI1ILUSTKAf5VKFf
	8wTo8P7C/i6o6yO+oFpHXtHu0Kk0Mzuc33Nub774o
X-Gm-Gg: AYBFou0nryootWj0gR52hHrhBNxzwm4W1RE9JIUat1qbm/RQ8A3Qv7+DZs7Ptm4ecrx
	0lKh+NqD3FkHQjNCttJs3cb6bGkxCWmL2BoMdnesjDQJHD0Fcf/TRbWlc68lbGjP7qo8TmGU04x
	JFIsVCl+52ENuXAfBllaaPnwVuZS0boJBsfRJiyVjAkOgTDA1Aa3o+j31PKQwUzI7y712EvmlGm
	ga5hJHfomanc+n3aiT8HxbTstdzzh1FA+VX6oJn8RpIqJbhbal3wkoMSF/psYi6VS9oXktw7lFZ
	8Y1mkKK1OibJ440gMJKrt1HTqypsVBm6dvCGHFFLEH+Vtvz40seOf30WxerJfGdreyOcbEi4AN6
	vVhcoc37fRHpCfX9BBOfRUk0E29NrMu5Og2mqS2ahUd2QcaFudHUuMIE7JxNDxWPiViFVrcbniD
	ZSa3/5sqznSW2dlv8=
X-Received: by 2002:a05:6a00:3a0d:b0:893:12e5:c07c with SMTP id
 d2e1a72fcca58-8a6e82b2c88mr187466b3a.27.1793130342392; Tue, 27 Oct 2026
 12:45:42 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
 <20261026160747.283702-1-horms@kernel.org> <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
 <20261026174643.088e3f49@kernel.org> <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
 <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
 <CAM0EoMkf_ewuY4bx=MFNc0ybR66pLP3F8nZSCZBMW6bbXWoFOA@mail.gmail.com> <20261027182905.GQ257209@horms.kernel.org>
In-Reply-To: <20261027182905.GQ257209@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 15:45:31 -0400
X-Gm-Features: AclHuK9VHmyLnFXXwTIyYI5AQH1rkT6wNTiebNqpfKQAGesdZXrNLOB5IQZpdg4
Message-ID: <CAM0EoMkym=CiT5=ye72N4s_zat6GF-ihN-Mk3hpY4R0YgAqFGw@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:29=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Oct 27, 2026 at 04:04:34AM -0400, Jamal Hadi Salim wrote:
> > On Tue, Oct 27, 2026 at 3:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Tue, Oct 27, 2026 at 3:25=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Mon, Oct 26, 2026 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kernel=
.org> wrote:
> > > > >
> > > > > On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > > > > > This is an AI-generated review of your patch. The human sendi=
ng this
> > > > > > > email says "Hi Jamal, passing this on for your consideration =
as it
> > > > > > > seems to have got stuck somewhere."
> > > > > >
> > > > > > There was nothing wrong with the headers this time - so not sur=
e what
> > > > > > is going on. A bit frustrating.
> > > > >
> > > > > It is frustrating, you are the only one with these issues.
> > > > > Patch 2 is posted in reply to patch 1. IDK what else is wrong.
> > > > >
> > > >
> > > > Let me send a repost3 - will take the opportunity to pedantically f=
ix
> > > > the commit message (no code change).
> > >
> > > BTW, checking i see the threading was:
> > >      0/2 cover  (root)
> > >        1/2      (reply to 0/2)
> > >          2/2    (reply to 1/2)
> > >
> > > I checked other postings that didnt have issues and it was fine. I
> > > also found the approach
> > >    0/2 cover  (root)
> > >        1/2      (reply to 0/2)
> > >         2/2    (reply to 0/2)
> > >
> >
> > And for repost3:
> > - 0/2 (root)
> >      1/2  In-Reply-To/References: 0/2
> >      2/2  In-Reply-To: 1/2; References: 0/2 + 1/2
> >
> > I am sticking to this approach going forward.
>
> Hi Jamal,
>
> It's unclear to me if the threading relates to why the NIPA-Sashiko revie=
w
> of this patch-set didn't propagate to the ML.  But I would suggest that
> however b4 handles threading would be a good approach top copy.

I looked at several patches that it didnt have any problems with (some
merged already) and it doesnt seem to care which of the two approaches
used. But i will look at what b4 format looks like for completion.
I am begining to suspect it is not the threading, more the repost
approach. The "repost" was not including any code or commit changes
and it seems to be problematic even when i changed the message ids. So
likely it is only paying attention to subject versioning i.e vX or the
body text. I added modified commit text this time on all 3, so lets
see if that fixes it (caveat: the Vx didnt change).

cheers,
jamal
