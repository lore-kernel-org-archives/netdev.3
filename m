Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6F39FCAE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885154; cv=none; b=lNSz1qCmpMZxYa1yJpejgpW+a1kEg7i9GwermFiWQS9DXiTQdFXGB24mRdogh38EkKXhEBr9D0rz7RqRun8bWMAUjKIFQh99yzDVkKdBBpau2dxz/Bu52ii7sTMMNnGyTRuIximjXUf9LhJyXiNCSfVeSAEmDi+aRyXB2RhS3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885154; c=relaxed/simple;
	bh=lvERhqWFIzeR9CSOt0wp6SobFqysALAzzfrhXiUWo9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3NO+FvpdD/zFJFEmH3vW/WpzgyBMbsAF4D8FY/Qw1LfxA4qArsaSYVWybrDV6BbILx3N/cKwB/2o1gW07mM5es3wNGKTqXYsyNSeVxKiKNaIWu45tAMJ2PGvVCry+iWPczk3P3eEXoHHO+qDJVmacexo45t4GEbhdZ2T0ZslBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=OK+Urmy4; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="OK+Urmy4"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e36so2487313a12.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790885152; x=1791489952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EcGZBgVs6V7xRRG4AyNekMmCdFec/IScmb1jciCnZPs=;
        b=OK+Urmy43tNyTAwdubfgQQQJ7uxBhIenyxSpYdcMcejCrJV0PkCgiMF2JKqjq8T4y8
         TYMxu9+NJcixCVwdE+cyFvqGLm4ROuDvlXjOxpYuDuIAvcSj0Qzq+lnadc/XuFDR7qN/
         GnbTl3Wfur9HEENZeOeXDXCVgDXaguM0XWetTNH6aLoJVZsFcufu6ZzY/sl+0qJnmRdP
         Z5HJnbiOHgypIxBr62moDWZ4IkArfLZVnyMiHDI+bMpfnMEpz0d9QmC16F4KiV8Jqj/f
         X7nCLe1DbYMEt11smZ45fy+PAseJRdtUb1NG6Pz5hbWigFm1Krq3+8xA6AoQwhHSrrVM
         5twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790885152; x=1791489952;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EcGZBgVs6V7xRRG4AyNekMmCdFec/IScmb1jciCnZPs=;
        b=AQ/9t0PtKIBV5HXD5qeztC3jUMbAavJ12xU3r1MCaf7JcfTjB+KcXK0SVS5rjjUjw9
         oEVQJL/aNsU8CPj3+bCdvn4AxPicaNGvCj6PLr2w6bBVCd5OmMs+1SYMV2/snnj0+M8m
         zMj3yCJisZ9IFjs56VGo+fgvgAcoF1IJa6pqZ7mQKXD5/hjvzb3jRHS63bJsKa1KFebB
         VcxVspcZtPsOzcESn8LtDU4xcjIoLXWK7hQneO9b2zE/NxHv9uUDyzB0/73hDxXFDzoq
         CvHchV8XnRXbJW9/wc97Atqd6i8XgkiqCzaaecUJ94WrtikYlrT9nssQzeuu1CCjkOyO
         HDeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWQ9cfarxD4cVRlj4Fjd40HFuIgmajTHxKFJQpguTAZAiZVHDCHo3RLRSvTJHzhxWr2MiWa+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJo4iEh1cgRkPiVxYAcykJXnYKVVjcrPtP+ngphWXMFnZf02X1L
	4gfEoDQJNjYdPpUoaOWGVF8vW0HZ6v21BQ6wCO7Zw0kimcuhSld2RxbMoP8A2igmKCE=
X-Gm-Gg: AYBFou1BoQ7/4BmcbYjU+oIdhEkiHDtNmEA4AIWVnl6TC76C55AZ/Q5+pJBypn95Ofm
	z0EGbt//r9XaTDwLWZhpQboTOcJI74TzHxTb/+gfIsrxyurWUgKWY066FRMv9Zm1JEa2JYgH2vT
	SDWzG+wOTG6Aytn1bVtt360K650VtH+RjgujJ2o/rHSIL4fltkwHRPS2QQ6fhaTYrVb2dihOoh2
	dnuHn6Uhfso2lCZ5iPlKYhe9gZoNEudcWL3BjNQT/utJns59AvipbwrDk8rdnGfk97Q/hI/34Gi
	jIXL/ZuyY6tC1Ta8X3FQLG074ODwsGBv7MNp4dt8E9YkOssOkpqjY1Gcs6ewrXMvjMfhVyYHuW+
	Ysxejz2qrUK+dYIMyWwvdfoT6pWbs41y6K0wgb4c+CA/w2htpC4eFkPUUqomD9pyY0rmeNfMN0N
	2BdAL5sDXEbLiFe2HjtBlkEyrWwP8F3X1NAg3zdAM6azKX1bQe/gNDAJX/UEorknP+/89r+fwr4
	onD6aX3mK3+
X-Received: by 2002:a17:90b:3846:b0:3a0:c717:2db with SMTP id 98e67ed59e1d1-3a6ce7913eamr293093a91.27.1790885152227;
        Thu, 01 Oct 2026 13:05:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd456214sm19602a91.4.2026.10.01.13.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 13:05:51 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:05:50 -0700
From: Joe Damato <joe@dama.to>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: brauner@kernel.org, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, jack@suse.cz, jirislaby@kernel.org,
	kuba@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
	shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] eventpoll: return -ENOIOCTLCMD for unknown ioctl commands
Message-ID: <ar69Hgsx6+PEYYCY@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Hengyu Liang <hengyul@cs.unc.edu>, brauner@kernel.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	jack@suse.cz, jirislaby@kernel.org, kuba@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org,
	viro@zeniv.linux.org.uk
References: <arWdMDek0iv0obDy@devvm20253.cco0.facebook.com>
 <20260930095058.1062123-1-hengyul@cs.unc.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930095058.1062123-1-hengyul@cs.unc.edu>

On Wed, Sep 30, 2026 at 05:50:58AM -0400, Hengyu Liang wrote:
> On Fri, Sep 25, 2026 at 5:59 AM Joe Damato <joe@dama.to> wrote:
> >
> > On Thu, Sep 24, 2026 at 02:57:47PM -0400, hengyul@cs.unc.edu wrote:
> 
> [...]
> 
> > >       default:
> > > -             ret = -EINVAL;
> > > +             ret = -ENOIOCTLCMD;
> > >               break;
> > >       }
> >
> > I think based on the documentation this is probably right, but I am now
> > wondering why both ep_eventpoll_ioctl and ep_eventpoll_bp_ioctl need to
> > exist.
> >
> > Maybe when I first implemented this I thought it made sense to factor
> > out the busy poll ioctls into their own function, but in retrospect maybe
> > it's cleaner to just collapse the ioctl function into a single one
> > instead of having two layers?
> >
> > In other words, maybe:
> >   - delete ep_eventpoll_ioctl
> >   - add the is_file_epoll check to ep_eventpoll_bp_ioctl
> >   - rename ep_eventpoll_bp_ioctl to ep_eventpoll_ioctl
> >   - fix the test (as you did in this version of the patch)
> >
> > Would result in a cleaner fewer helpers / cleaner code ?
> 
> Thanks for taking a look. Agreed, a single handler would be cleaner.
> Two things I noticed while looking into it:
> 
> 1. With CONFIG_NET_RX_BUSY_POLL=n, ep_eventpoll_bp_ioctl() is the stub
>    that returns -EOPNOTSUPP for every command. If it became the
>    .unlocked_ioctl handler as is, every ioctl on an epoll fd would fail
>    with EOPNOTSUPP on those kernels, which is the same problem in a
>    different config. So the stub would need to keep a small switch:
> 
>     static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd,
>                                    unsigned long arg)
>     {
>         switch (cmd) {
>         case EPIOCSPARAMS:
>         case EPIOCGPARAMS:
>             return -EOPNOTSUPP;
>         default:
>             return -ENOIOCTLCMD;
>         }
>     }

Yea, I see. I read it more closely this time. I suspect when I wrote this
originally, I had factored the code this way that way the stub could take care
of the CONFIG_NET_RX_BUSY_POLL=n case. So, now I'm not sure it make sense to
fold them into a single handler becauase we'd end up duplicating the switch
logic in two places for each CONFIG_NET_RX_BUSY_POLL setting.

So, in retrospect, I think probably the original patch you proposed might be
the best option. Sorry if I misread it the first time. 
