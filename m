Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F84D98F3
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527240; cv=none; b=U+HNTgFWTGftSxCNJYMrWZrSITvZ0+4Ye7BJmerHhdapWtg8WH6+VJlYMtX8UCpKQoICscUwyBCu/+7gVvMOEGzYQZz3QDJHnyLbl+f/Car4PkA2633nuxItP3ubRXls08gn4QriH086mNU2CxdpLhq8Kt1CAUBYS7LUcEqKMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527240; c=relaxed/simple;
	bh=R/zZG4ZyrvWUzuSIU5eJSLX1T5t0EJujPTyy2snq0VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH3rhP79soicsyy+uyJhUba/IqS6co+V7hoVVc1nnCfx0rxBYFTaeBKC4rxJg5x1P3Fr/FtweQNCHoHrFePKNLL+DRNrerDay9k46BbpzKGYeTCkaLI8xnVKJbT6bbmcpbPuk5fnVY75+2ehMnVmmiJsk+/SHy4TkUY6HFq93KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h6I2Ib6N; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h6I2Ib6N"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso29211a91.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780527237; x=1781132037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d66PsLO70IOujHc9tD5MHey7l/21gIQRZ4eLyqG6j78=;
        b=h6I2Ib6NzAggY2uuHEMis7kUb3lGpGHer3EOzQw9N6FE6SlLFfO63pJWH0yAzbVnde
         VE3HqsfZFrLiaxxBpiwfHBCR2+mOuht4o4autHUSz1aEx6avtmmuYkla2lAMaOk9JYh4
         wojau/9PNX+IQs0cfSFDDK4TgjuVxa/TsLsZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527237; x=1781132037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d66PsLO70IOujHc9tD5MHey7l/21gIQRZ4eLyqG6j78=;
        b=om2oBwFBEmmynPDD6xEPtiS7g+xbYhj+Ze9QpqO8pplFHW+TMtk07SBKP9tOCxPIeo
         9Tf6Qz8uoiXlAUMYLMmbTIlIF3+PLnSvd4Y59ygwkxf+f51CQINA/mt13c3TwXo5vKbk
         DeqdmWNrH10BUJijBg1sKNuK43KaFj6zU6mr0MSYV9qdlac9fRf2mVaRoybFtH/Ayo8V
         /VoDovTfsD+AskSJOiIV/t5lPbL9SUsTykOd6AHebQajxgBxUK9jnSS7SZDNsx4rdyYb
         EN/8Lz7AveloK729Iz8AsjxD/sHwrR781lSTQk+rTYQ2VNXne0UWqPuRv9Z2iBkHATZL
         bnPg==
X-Forwarded-Encrypted: i=1; AFNElJ/L5c8uIQDFV90kHYLOB1GGFFn9xENaFnRVuAtxn2qUQFbW2lu9swShNMmA7AtGmf3SiAx2TPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOBkEFI39DodstTfPUkkUMTRMR17KlgKIOAWgCavx/FZq14ei6
	M7yg6/qle9Jt6IZq8Kr/XKYs+rwcQZilaY+zU4Koc6Uyg24LW6euH6dTB/1BknyPIt+XQ5Gy6Yi
	eh9eIhwrjCA==
X-Gm-Gg: Acq92OEAyGtfD2vZ+59yfxuc0/rwSM622WuAL+ICdZgR3WnSkhtBNaTILSyUKM5lqM5
	5rnfQn964glk6qZ+Vs1J+u7zTVEqLxIOJ6D4oG0Zxs6vz1XCmYtkBSYf2t6kp4to02mtVFr8hFg
	5HJ+7i4bY3arjTq/Erkj6TJ4PzvN0HBcdcXavZU0Dmb9ft67ej/NSaQZ7rNoxgoL9a0tQL4wn4a
	daAUrWL2dOtsUaoRJIJsKChGQ9Oj4JaDJfgfjNBzDb0pVU0vH782F4EPsS84Y2UmagSh+3SgvtW
	AAHTxH4oQoFoF9BEVyuPF7id3+4l1FOArgTtJMb/jW4I9amkgvceNJiuHDIBcY17wfmEoX6ifKl
	/nt07EgOZvlZ2/RrIwJ8vSdzMYQjmTbtaaTlAIbVaDHiWFfQkqzMoupqb03/bI3FPjs/GLsGvS4
	l58wIFAiqc7JWbo1Yp583zwTYh5CkhcZJjLIjatD4LtsH3v6a+LsKkhC5SpikxdH6ZkiRJSLiT7
	GkKPRDVwoc=
X-Received: by 2002:a17:90b:4b47:b0:366:5c38:fd61 with SMTP id 98e67ed59e1d1-36e32f1676amr4999031a91.12.1780527236965;
        Wed, 03 Jun 2026 15:53:56 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a285a1sm779163a91.9.2026.06.03.15.53.55
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 15:53:55 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36d5fd50d20so32396a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:53:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+qOft3eX+MpydUwgAzfbvWRyNym99KGgmDIbe5p8v5Y7jFTXRB0AzozBBU1z/J1Iz69yC3iW0=@vger.kernel.org
X-Received: by 2002:a17:90b:4ac7:b0:36b:8873:d96d with SMTP id
 98e67ed59e1d1-36e32b3baefmr4916778a91.11.1780527234968; Wed, 03 Jun 2026
 15:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
 <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com> <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
In-Reply-To: <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 15:53:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com>
X-Gm-Features: AVHnY4JfTnadgKQknxIsZL_Ab3vCkRcYm3kghJCvdkf-q8nXBlQAzmvvhTEK5F8
Message-ID: <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 15:23, Andy Lutomirski <luto@amacapital.net> wrote:
>
> So I'm suspicious that you've possibly make bugs much (MUCH) harder to
> exploit, but the underlying awful code and opportunity for bugs is
> still there.  MSG_SPLICE_PAGES is still around, and there is still
> (AFAICS) no actual coherent description of what it means.

I don't disagree. I've only looked at the filesystem side.

The networking side does some odd stuff too (and I did look at some of
that, and had to be edumacated by Jakub on some of the subtler rules
for what skb data sharing is ok and when it's not - really not my
area).

But at least MSG_SPLICE_PAGES should be kernel-internal only
interface, and once you don't share page cache pages with networking
code I think that kneecaps a lot of the attacks.

So that's really the aim here for me - at least _attempting_ to go
"maybe we can just limit splice enough that it doesn't even *matter*
when networking does something odd and questionable".

And it's entirely possible that the current zero-copy "networking gets
direct access to the page cache folios" is a huge and insurmountable
performance requirement for some loads. So the vmsplice patch - and
_particularly_ my suggested "let's try always copying" patch - may
simply be doomed.

But I'd rather try to simplify the splice code by removing complexity
- and possibly then failing and having to revert it and rethink things
- than not even trying.

Because I think splice() is a *cool* feature. It was always *clever*.
I just don't think it's worth the pain it has cause.

And it's been around for a long long time, and after more than two
decades it's still most definitely not _widely_ used.

So that makes it a failure in my book. Sometimes "clever" just isn't
the right thing.

               Linus
