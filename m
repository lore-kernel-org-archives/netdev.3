Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AC9318BB5;
	Thu, 20 Aug 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218168; cv=none; b=Wi1RitfY0ywQRIDDoJZhheIW83iWlhvAF6DuIG2VTAh/PKpe1UgND8F+C4JpWwN0BPdtAL3Y6IDOqTQlPUl9Sa+EiybT/GJTUInqGONNXkUlt2p+Ea6O5/2jqBV9O9aDwgKMkKcLgmQ3e/OWR1lkCoFYU1T5ECg9fujXqEUgmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218168; c=relaxed/simple;
	bh=cFeLXt5v06FlluerWEqeDEjp9knaGzBEAlUK4IPtL8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0BudCPkwbHOrNkAXFliVD1xzz3VjaMhZUCQMVYBS/bRIhWVyZUijDK6T1VYThvOgulv5IBVGukdQyjLm/GtFueTf2x73xqW1ckAk+McDV00G89UZjzh3wS/AN3mj6kfURyKgtjQpTjX+pd/A55gjsmRUD//3DNrs5+4hHj55iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6HBWSOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6HBWSOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DBC1F000E9;
	Thu, 20 Aug 2026 09:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787218167;
	bh=cFeLXt5v06FlluerWEqeDEjp9knaGzBEAlUK4IPtL8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T6HBWSOn2EN1XOfALfMvmr+ST2AhNW6zz6fA7vjFq38Eb4sZdoEICJ5TMChycg1ka
	 tsYWumv6djNUeBa4mTqBPKq78HLEnVXwiSOexdZrGmBuqJI9NX6FpP1cJLatIBI2a9
	 +TMG72VvEy3yreHQtRSGkXLrCh9SvSmoMOO2qtxg3otQhOqB0NJG/aXE+w8Qb7dLNL
	 elzYn2qIXPItIM3PYhJd8lMHI3NQ9nLrmhNmgjY/zPe5CQPTMzwEPHLdwC9Ubmiweb
	 9mDoObFx+RkebRDTnwtmG8HiEurfGAJOOkSpc2biABG6Z4aZyiwd9Og/7xmeJjSDEL
	 xv+AUKbJ2cWYw==
Date: Thu, 20 Aug 2026 10:29:22 +0100
From: Simon Horman <horms@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v9 4/4] net: rnpgbe: Add link status handling
 support
Message-ID: <20260820092922.GX265046@horms.kernel.org>
References: <20260814111317.1741087-1-dong100@mucse.com>
 <20260814111317.1741087-5-dong100@mucse.com>
 <20260818120418.GD265046@horms.kernel.org>
 <0B1894BBE93DB8F9+20260820033212.GD2730731@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0B1894BBE93DB8F9+20260820033212.GD2730731@nic-Precision-5820-Tower>

On Thu, Aug 20, 2026 at 11:32:12AM +0800, Yibo Dong wrote:

...

> I will remove the unbounded drain loop and handle at most one mailbox
> request in each work-item invocation.
>
> For the dedicated mailbox MSI-X vector, the hard IRQ handler will increment
> an event sequence counter before queueing the mailbox work. The worker will
> compare this counter before and after handling one request; if another
> dedicated mailbox interrupt arrived while it was running, it will requeue
> itself and return, rather than continuing to drain in the same invocation.

This sounds reasonable. But it's probably worth mentioning that
synchronisation around the counter, as you describe, probably needs
something like smp_load_acquire/smp_store_release.

> For MSI and single-vector MSI-X operation, mailbox and data interrupts share
> a vector and cannot be distinguished in the hard IRQ handler. Those
> interrupts will only queue the worker; the worker verifies the firmware
> request counter before reading the mailbox, so data-only interrupts result
> in a coalesced empty check. They do not increment the mailbox event sequence
> counter.
>
> This bounds each work invocation while preserving mailbox events that arrive
> during processing.
> And cancel_work_sync() waits for at most one mailbox check rather than an
> unbounded drain loop. The worker does not requeue itself once the device is
> down.
> Would this approach be acceptable?

Yes, overall this sounds good to me.
