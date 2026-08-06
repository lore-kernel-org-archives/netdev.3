Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC238F934;
	Thu,  6 Aug 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024201; cv=none; b=PlB4mLeMYfaf2blrf+AsCW1DKdPJEiS0D39ucNBm2p02hGPD40nf9RAR9mc/qtiqC00y7jm8CEbj2TGmbKah+e+pNahJoxKyfkndivZ/Pd+YO/9Ga375xKWkc2LrZ+CC/A1M35pY//SCdbRAe8YJHuVCdgMleZRUfr5qntN3bkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024201; c=relaxed/simple;
	bh=ScSjWr/7rKFcbiKCKxHtB93pHBf4RtdpPkMyknhHogM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssQYqFuvMy03l9XZozrOpHZ+W8rSloSxA4VcP34blZyTtERs/HG10f9WKjXNQvMqI0/0KkSFlc1nPP5S5bbJckR4nrpiZ1DLEfbsOD82Hsc4c9J4PuLFcN+9z73Aa9ELxDIgKaMQITu5wWHUUy25sMqvC0Ya0nyJjmh5LXVj69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQQgItMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQQgItMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886E11F000E9;
	Thu,  6 Aug 2026 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024199;
	bh=uggi82GscbWlBKgAdg65ELmtfvTgIkSLrqlQb/L8iVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eQQgItMFiILVFsshjUxGFdEmERg6cuhXoQL7ea4MuCQAMkAQsZOYlH2uGiq+tlv7i
	 O7KxZhcRlj3g+zV/XzhWdlS8Qqd9Pn8bM7/Uuo4+NgCwepxwdqdAXQ7/HDkL1eYmCv
	 8+9SzN769FQn+ExgIT1n6j0tcCML8s+GcpJRzn7oJKizh5KerubOdzn0KLxxAWiRED
	 UYyFQNz5xEE9fCM4qGnC3zX5brbrGnvhoKDZTsxO3bN50o+OKdciIIXfEC/vPPM6up
	 hKnyirZ4Ce5UxNBf7QUT9D25/UAZ5xTG8mzUL2u7XmY09gVpIA8cL/43oRS3PTcZZz
	 HqCi5Aqhv3oMw==
Date: Thu, 6 Aug 2026 06:49:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH io_uring-7.2 1/1] io_uring/zcrx: fail non-qops netdevs
 early
Message-ID: <20260806064958.1b9ae431@kernel.org>
In-Reply-To: <178601764913.2132084.3867669701970816639.b4-ty@b4>
References: <23ae94da6725cac660652781b3533a20d0a1ad34.1786016493.git.asml.silence@gmail.com>
	<178601764913.2132084.3867669701970816639.b4-ty@b4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 06:00:49 -0600 Jens Axboe wrote:
> On Thu, 06 Aug 2026 12:42:33 +0100, Pavel Begunkov wrote:
> > netdev_get_by_index_lock() might return a netdev that doesn't have qops
> > and also relies on rtnl. We're going to reject it later when opening a
> > queue, but netdev_queue_get_dma_dev() warns before that. Reject non-qops
> > netdevs earlier for now.
> > 
> > RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> > WARNING: ./include/net/netdev_lock.h:72 at netdev_assert_locked_ops_compat
> >     include/net/netdev_lock.h:72 [inline]
> > WARNING: ./include/net/netdev_lock.h:72 at netdev_queue_get_dma_dev+0x52e/0x660
> >     net/core/netdev_queues.c:43,
> > RIP: 0010:netdev_assert_locked_ops_compat include/net/netdev_lock.h:72 [inline]
> > RIP: 0010:netdev_queue_get_dma_dev+0x53a/0x660 net/core/netdev_queues.c:43
> > Call Trace:
> >  <TASK>
> >  zcrx_register_netdev io_uring/zcrx.c:831 [inline]
> >  io_register_zcrx+0xe94/0x1d30 io_uring/zcrx.c:983
> >  __io_uring_register io_uring/register.c:942 [inline]
> >  __do_sys_io_uring_register+0x1193/0x1bc0 io_uring/register.c:1040
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > [...]  
> 
> Applied, thanks!
> 
> [1/1] io_uring/zcrx: fail non-qops netdevs early
>       commit: cf7aa48151deb629022a8b0c61c139dbfa579933

I asked for a different fix :/

https://lore.kernel.org/all/20260805165817.7e1fc367@kernel.org/

Outside subsystems should not be poking at random fields and making
guesses. The assert is simply wrong and should be changed.

Jens, can you drop this please?
