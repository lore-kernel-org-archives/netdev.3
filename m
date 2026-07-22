Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463342125A
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740632; cv=pass; b=DetdttbAMDNUtNEm2ZoXJad48OK924JwmKj0H14fjD3hRrKdU8vps3rmyhjanjzosOgTZI4yyJCCoT7V1M3D1RpbVpYk3IMYzfM/tksbkQ/Egs0x093L/w5EYM8kuR2JaAwsZ+DvUyKVmk8UQH1hmHYCSavDOjQ32JDrRxdLC9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740632; c=relaxed/simple;
	bh=quUFmWfi3Lva1MInTlYEMYMN5ra/5e9+GbC9BhKVMxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uu7yVV/jgdkKWf7nnso0Soe/4UCKezX9idzvk2T5LHEUwchDaJsmBgX6Nb7/j3Ka+3BzwuGAo1izy9nHR5q/2uKWr+ivFVu1YNa//jetdJ5ABmuGMWoNUgUxgNAdjmss17kHgVZLZyM1411g23erP4kYqegdGhWuhw+ZTqtIXR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTm0gcnV; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTm0gcnV"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c5382806fso81348231cf.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784740630; cv=none;
        d=google.com; s=arc-20260327;
        b=Ydnr8GItk6K7eCltYf+pyS2wzKYg/CfLpoQUEudOcX7Iq/r4KH5/rPxtnLljXiKmtO
         6DCEFkyBoJIQz21QU061D6OvCpgEbki2w7kVtCSDbxuROQcJD4LBt3G/3xQklKGba6mH
         UZBhgXLHzlkrzRoklmipbHcykfhETjZp5SmEFl7tQXEYGS0kY7zEcQSB+yzNp0NziHsp
         YiUeCRs0SXHz5OvSxdhM7idqfIkAyfI4kdmTN+9UxmP6UgV/W6dyaVxM0N0RH3UOqeCa
         VGxmpbI5DtPh+NoJ8p7Y8HFNq8crb1RGmgWCwAy11SU+Z1U4fMRnbT+QOHEYETT1ZzLK
         H9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=quUFmWfi3Lva1MInTlYEMYMN5ra/5e9+GbC9BhKVMxY=;
        fh=7RA3iE0ruWYgXZ0STgfO7QD2vXtSR1ZT/j6XRFcf7cs=;
        b=dv8wWsKjfuVsqonlf7K7Ah/TB6FWI3ViNrwoorEaNxBitrcG8/MSF54vt2DvIdhRdG
         zC6Vn13DFWiU2Cnhll3n5DzLHJCN5ixArPX50y5KN49XeAij04JKjkdeMXg5b4NLUYsJ
         2PRGnadcAkHI8oprfj+irtYWNTslm1WzGb81J7h3WH5BtfJ+tLhWHlwizrvEDKqUokGG
         lgIzsS6l16h6kaWZw0/mg8kvmnQCSTLY1uzFUtMnCkNjO2V+Hydt9WlV+DfinJ/+9a30
         Zg7KGjm6PizdGiUCJJmepJzkSOVbQrd/13EBSrxD5dcrQYrYrTsyYiAN+Rvw/JjZMYgT
         2YTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784740630; x=1785345430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=quUFmWfi3Lva1MInTlYEMYMN5ra/5e9+GbC9BhKVMxY=;
        b=lTm0gcnVP5GA5kmbmlbgf30oa69Al/w/uJhL5VE5ONRA6hW7jLjDuyS2ETpwaEFmh4
         IsYc4thDYwhWtRj84DJhnwLMPI2fpdTHhyA1AZ2rUEdjINwKMX+aBZ+vlO+GR/EiggJg
         76KrRF0LlVFP3WjnGCKaemMJG80jZifjJn+a6867HyG4DvLTEW3uT9hIAzAd9M+8ESG7
         8e7jDOH+ErFEMr1yuuEA8BIPZVwxfvEHP77sTZRD7me8MEP+3JAaoiBvdHZ6crzLMeMA
         i+5xdRkf859GmLlVKZOOZE2cbhurDdYDN7z7ZkapRXF/0yCilu8wHwBjzIH/uT/z6D4k
         P7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740630; x=1785345430;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=quUFmWfi3Lva1MInTlYEMYMN5ra/5e9+GbC9BhKVMxY=;
        b=jk/zGeL5wQR1BSNcx6Vq0KdZc4fqueU9jCwEste/Dq+DQPxa7zwVJ/hae/MM4hz1ba
         UIIgh2YUxnMTqIc7T6R3pPvWyzz59LaYX9QCCOqiQG7f7hN3k7kK44Og49oagRvTMCU3
         RMJRL+fGUSFfOvPFWgP2Za/OKK6GClJQEnk2NNU92EKVzobARyAetE3W2OL9x0abKxkN
         ccwKnD60FRdX16roq0fMjprjaMwWpUDVY0ZQuHLGN6vi4MUagt9+FeTgoZc/d2CHTZxN
         i9rVMn40wngTBzINo0zPppbBQVZw4TdSAlhQf2UIWSFB64mMfw6OcfQT5NH0uz/3a3Jo
         vbmA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8uFzS20kR3Oo1ujZSQ5OB7C6I3Iv9Xo8/DoQA4HCxZvPIgn2Q0BMDczEiosC1IbimYoBXv6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YymbZRCrJAiUWR6Umybw7JaxXAxMm7Gj7aX6MbwiwxlD2tHCLH0
	AP7iW6PrlM9K+JlQyHcCIueZCetmoJSng7/BUt04IEaSEBKBTkajDfvI+rs6LdD+J/6MAppXrU2
	uYDJJKQIcjy+FNLwzhmoN6GG+gEXlXtY=
X-Gm-Gg: AR+sD13ZoeZOAahDIYjnWIRrvvZEu8S5l71IFdNbuUZVZwbWHTbW2SX3K6DstYs0CJQ
	5L09RaXFnTCjCZxIuxf+pVtJq0Lg4vrppp0SYYhhmeZnmraNWFgxV6nt4QxVmoqfsrEtFkAZIKz
	H0Hs9FrqHmKSK1Q1yZe9CEmUCm3GCRDRO6NxHa2VNwMjdTsDdY/ibLUjBI6XGO+Xrldv6uW0Jvu
	YV3mkWLjyI0sKXF2X7WEMVZ17MYa4AQ1smlvacKOy3H+kha08HZTxCrqmYjpQ==
X-Received: by 2002:a05:622a:153:b0:51a:8b64:69e2 with SMTP id
 d75a77b69052e-5213d2b7276mr228515301cf.7.1784740629936; Wed, 22 Jul 2026
 10:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782548651.git.bronzed_45_vested@icloud.com>
 <3ab4a04fbab887238facc1792e02c33fd68190f7.1782548651.git.bronzed_45_vested@icloud.com>
 <20260630171016.11c02dec@kernel.org> <20260630172027.5eaba39b@kernel.org>
 <CAPuPA7KMdDSGKWJXEZzSpgbdUj4_BGGX2+CedgchoD77bPd8sg@mail.gmail.com> <20260721182245.50059a0d@kernel.org>
In-Reply-To: <20260721182245.50059a0d@kernel.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Wed, 22 Jul 2026 10:16:58 -0700
X-Gm-Features: AUfX_mzCk5eZ-iil-nSL57Kf4TsRHu-C4RyoXC6xDUl4tGcnzcbWIg8REePUudU
Message-ID: <CAPuPA7KqBgzc4KQx7M=c15RJh7bKDKa9uGOuBoJ5KVi9OugPMA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: act_skbmod: require an Ethernet header
 for MAC rewrites
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, jhs@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, peilin.ye@bytedance.com, cong.wang@bytedance.com, 
	gnault@redhat.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	zcliangcn@gmail.com, bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 30 Jun 2026 23:46:46 -0700 Yuan Tan wrote:
> > On Tue, Jun 30, 2026 at 5:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Tue, 30 Jun 2026 17:10:16 -0700 Jakub Kicinski wrote:
> > > > On Mon, 29 Jun 2026 10:46:03 +0800 Ren Wei wrote:
> > > > Let's do away with the 5 reported-by tags? You can use a tag for yo=
ur
> > > > tool or your team, it doesn't have to be a person. Look at sashiko =
or
> > > > syzbot reported-by tags.
> > >
> > > On second thought, if y'all work together maybe there should be no
> > > reported-by tag at all? Can you explain the situation?
> >
> > Hi Jakub,
> >
> > Since February, our team's bug-finding tool has found hundreds of bugs
> > and vulnerabilities. Several people have helped improve the tool to
> > discover more bugs, and verify that they are real. I did not want
> > their credit to be lost, so I added Reported-by tags based on whether
> > they contributed to finding a particular bug.
> >
> > I agree, though, that having five Reported-by tags may not look ideal.
> > Maybe using the tool name instead would be better. I will discuss this
> > with the others.
> >
> > We also found many external volunteers to submit patches, instead of
> > simply dumping bug reports on the community and leaving it at that. We
> > were worried that too many reports might annoy maintainers. That said,
> > it may be easier in some cases for maintainers to fix the issues
> > themselves rather than review our patches, since we are not experts in
> > every subsystem.
>
> Sorry, I was AFK for the last 2.5 weeks.
> I expect you to make the changes I asked for.
> There are multiple teams doing the same thing as you are,
> and nobody else has so many tags.

Hi Jakub,

I would like to sincerely apologize for the problems with our patch
submission process.

Because of some communication issues on our side, we did not handle
the submission process correctly. One particularly embarrassing
mistake is that I only recently realized that when you wrote last
month, =E2=80=9CCan you not post these to the public list?=E2=80=9D, you me=
ant that we
should post cover to the public list. I had understood it as asking us
not to post them publicly. This was entirely my misunderstanding of
the English phrasing, and I am very sorry.

Going forward, we will send the cover letters, including the PoCs and
bug details, to the public mailing list. We will also use Reported-by:
vega@nebusec.ai instead of using individual volunteer names.

Besides, we will also be more careful about prioritizing fixes. We
understand that some very minor or highly theoretical bugs may not be
worth the maintainers=E2=80=99 review time. It is sometimes difficult for u=
s
to make this judgment correctly, and we are still trying to improve
this part of our process. We will do our best to be more selective in
the future.

I am sorry for the confusion and frustration caused by our previous
submissions. Thank you for your patience and for all the feedback you
have given us.

Best,
Yuan
