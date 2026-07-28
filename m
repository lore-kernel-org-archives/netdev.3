Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F44248B1
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235741; cv=none; b=lKZJQGAKYW9rXFYP723kCaGeJ9lnqbMvC82oIXTpNjie9QRdNs7orLfGKfS6isxnq+byjy7R8LEQfNweJM0ebF+SPNIv5YriisjN/2hgJdLF549Y71yRqfwhtlDSbFkS6dJb/A5ysvLy4J8qp2GuPyXdkJamNy3eFd1pEBp3sR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235741; c=relaxed/simple;
	bh=R7pbg4BbOsUrkcuUhcT8PFMmCBGVLrpb/aQF+NHcs/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9C9sfdZ9uzPT1S+bb1myBSDMLqficHIaYlk/xP9GYp93QlxRRH4MFJSWqKpOjiwoh3i7iwP/cL9a56k7AJCqlIDJZw256GhbB6prnd3zSalGh5Nj3jqHlpROW7M87X9njEOE3LRwMvChQqN/BpQshRnZICXOAfHOHNjFpmBG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwBdPrEs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkDwfrrU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwBdPrEs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkDwfrrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785235732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfaxk2NaR48Hu7efMAKkLqR/JuqGfWptwGyvHlDsSCI=;
	b=OwBdPrEsFNULeADd6ZT66JbkbROrLNz/rUZmRNskv+vzNOHkmFfm6fHXTVryZnK2mqAlud
	ZrMwf21S1qTaPgw6ub/oiLtQKXiRf+tjMXAGaL0Olys2NuW7NkxbFpzJdODuV07KykkTHb
	W9M6SqIuMEv2v5P6DmYiV45obtzqPnQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-5kJgmnvkO4SmQKQetlAY6Q-1; Tue, 28 Jul 2026 06:48:51 -0400
X-MC-Unique: 5kJgmnvkO4SmQKQetlAY6Q-1
X-Mimecast-MFC-AGG-ID: 5kJgmnvkO4SmQKQetlAY6Q_1785235730
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954b1c6310so33721035e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785235730; x=1785840530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfaxk2NaR48Hu7efMAKkLqR/JuqGfWptwGyvHlDsSCI=;
        b=LkDwfrrU0VXY5i+NwGcwWmYQXtAg5nsv5Up+m3j6S599tbihRbwCBRHwLHiEw9TLg5
         fwyWyaTWzMHncobu1V3XzmwrprZo3HopBI9/WjJf6A598ewQg043Ipu3bnqDKhIsxwua
         A+VeSYlfPP1309yv7GrJDIqtQ5ps5xVtUdEvqlhJ1U/EhvakH9eebPwQwt/RhgIsLvtR
         trRCidNeLNY2v007wVH8mRRlOfAEBn+ouy2fElwtZNOK9kji2ATAndXdClfnUl5XRMfb
         U5paJx6y/uDJ6e/dzaDwl4hNFiINT4oLXuSc13TGjc8UFvNcqylfRhKB7/zRZfMVjsuk
         e1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785235730; x=1785840530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dfaxk2NaR48Hu7efMAKkLqR/JuqGfWptwGyvHlDsSCI=;
        b=n18kkCKYGT1vGWoZi3bpvhXz/yiNvpTfOlDmQ1qz6flw4B8r84VvQXaGI3rlOVWMeA
         G706tRxbJu9NBeT2hhDWgM5o92TZ3mPeGiLX8nIjJ9OWorN+HEqnY79DiUoTa3BFWG2u
         macS8C1Ym5ClrZipwS4jYtK8OKogTpq3Dhx5wIPeeFelh2bbnG9JiPdH4Wd32i7r9zlo
         p+uiOyHs2RLANLepblpJcTEyKI7q0Ip98ScmDbcIqvjJ/64s6KraRu0CDJjtmk7Ud6c7
         IeTdiRrrvNLmMouhe8rp8b4kJJ5g5+dNnawxPqEnUzEhUXKOWt7DnnSW3YGfje+E4Ebx
         vMPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5GOXBmpMN5aeCtZxLxMGC5q8OCcoOwXXlPqZmXX5YecWqupMAEK+U1GlHWGhiwvJdF56a6Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnROFhsuNZhYm3EJ/+Kzh49OhVV6yGXsJ2VKrjZPLWHDA32D7W
	QxWMsOSgulh51L8YDsZ48umlg8YVVdhIsoyR/wrsNO/WFxFCE9ieRkWoVfEDZ4vC6BnWPItzI8z
	NB10MlgLNu6FwsHxsKM4l4TfYWYEAq6DuuEFdvxelngpjqDNUgvLNixuDkA==
X-Gm-Gg: AR+sD13Pa0VwdUtdbVZLZAU2hVTVNz542pQoW/wuuxFbAPgeDCUkt2uySXduPLCFQ3x
	XO+dixhGKoanV6Ls6OejTDQw0M6DV46wSX1EhD6Il8lmnYpHcgqPiskpCK7UNAHfN/46tH8fkSl
	7ykFVEwSYgtRZhFn7b8YIVUvD8wSz+C4eZx+QcKSJfr/WMOpNLVFpcm10Aow2STyejAh0Jzt+XG
	PKb/WbdE1CP9bUfv5grbMnjRGK6D/tRTfXRZUnTMfDtLWYn7xDgwD0jyU+Wn2WfZBXV1ALBWawO
	wP0JG2FtuLDIh0mBtK21XHV/Hh2z0VGwBzwForBR2LmX5Oj0b71c9/NB0gtuYN4=
X-Received: by 2002:a05:600c:8b5b:b0:493:df1d:7488 with SMTP id 5b1f17b1804b1-496c6444888mr20258345e9.16.1785235730304;
        Tue, 28 Jul 2026 03:48:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8b5b:b0:493:df1d:7488 with SMTP id 5b1f17b1804b1-496c6444888mr20258075e9.16.1785235729814;
        Tue, 28 Jul 2026 03:48:49 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c46240c4sm67760345e9.12.2026.07.28.03.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:48:49 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:48:41 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai,
	bronzed_45_vested@icloud.com
Subject: Re: [PATCH net v2 0/2] net/sched: act_vlan: pop_eth can strip
 non-Ethernet skbs and panic loopback
Message-ID: <amiJCTagBrAHsTZ_@debian>
References: <cover.1784709375.git.bronzed_45_vested@icloud.com>
 <CAM0EoMm8HGCcmGB5btFfWKA7-7sGQyhYB_FvxQu7POhZ+W=dsw@mail.gmail.com>
 <CAM0EoMkTr8y1KBXTqU6MyJOVezGknZg5u6BYE7WBzdVyqaPm6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkTr8y1KBXTqU6MyJOVezGknZg5u6BYE7WBzdVyqaPm6g@mail.gmail.com>

On Sat, Jul 25, 2026 at 08:21:52AM -0400, Jamal Hadi Salim wrote:
> On Sat, Jul 25, 2026 at 6:46 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > On Thu, Jul 23, 2026 at 1:54 PM Ren Wei <enjou1224z@gmail.com> wrote:
> > >
> > > From: Wyatt Feng <bronzed_45_vested@icloud.com>
> > >
> > > Hi Linux kernel maintainers,
> > >
> > > We found an issue in net/sched/act_vlan.c.
> > > The bug is reachable by an unprivileged user using private user and network namespaces.
> > > The relevant details are provided below.
> > >
> >
> > Please remove bouncing @bytedance emails from the CC list.
> >
> > You did not address the discussion we had earlier, which is a very
> > good example of an issue Yuan brought up at the bof - "fixing the root
> > cause".
> > Attaching the last email from Guillaume since this was not on a public list.
> > I had argued you only need patch 2 (and to be safe handle both pop and
> > push) and Guillaume argued that would not fix the root cause and there
> > is potential the bug could still happen and patch 1 would be needed.
> > His exact wording is:
> > "
> > So, if patch 1 isn't needed, that means we must guarantee all skbs
> > reaching an ARPHRD_ETHER device to have at least ETH_HLEN bytes of
> > headroom.
> > "
> > after some back and forth we steered into drivers and pskb_may_pull()
> > invocation.
> >
> > In any case it would be a good idea for you to review and consider the
> > discussion and infact test with suggested vrf device (which doesnt
> > pskb_may_pull())
> >
> 
> After some coffee, _my view_:
> The root cause is the missing pskb_may_pull(skb, ETH_HLEN) in
> loopback_xmit() and vrf_local_xmit() (thats why i was asking to repro
> with vrf).

vrf_local_xmit() is only invoked from vrf_process_v6_outbound() and
vrf_process_v4_outbound(), which both start with a pskb_may_pull()
call since commit 107e47cc80ec ("vrf: make sure skb->data contains ip
header to make routing"). So the problem shouldn't be reproducible with
VRF.

I also think that the problem should be fixed by adding pskb_may_pull()
to loopback_xmit().

> The proper fix belongs in those drivers, not in the tc action.
> Guillaume's point is valid: limiting POP_ETH to ARPHRD_ETHER devices
> doesn't fix the  problem, it just makes the existing reproducer stop
> crashing while leaving the underlying  driver defect exploitable
> through other paths.
> 
> That said, another stack or code path might lead to vlan/skbmod so
> fixing the actions might make sense as a follow-up.
> 
> cheers,
> jamal
> 

