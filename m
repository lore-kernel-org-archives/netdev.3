Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B543328FC
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618535; cv=none; b=Liep5+ZDt6KW6CW3sWWrSr6//fBBEUy/Au+mIWBMvSBZW6lXFlUTCgfC6Tc17pC35NZg/Fvz1k4rjpJQf0jSz2kA/Qk4SMth0rO9gQWQmcUhY2wDbwWxUjLJZRUethYfLc7OXdrjR+AWpmAZHerBaaiy52pILUNSzxM2Wsod2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618535; c=relaxed/simple;
	bh=Gd9q8wjKBTahx8WZncyILkvuRQkf0BqNHTBqV+puh1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/yvCGltijIRbueOdYezo9lCBb7nnFGldepETd4Lr9HeJNByK7yBzIl02+r7zNg+TlJYgsIIq7e1rFCnZSXD7ss4l9/aWxJxADBX8zkgOofs6q97fqlvgqzEws7cSQB3FrhLl+b71S11zcELbVdhe44bF0gn1+hPGFvQjiyS42Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFaeXyhR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFaeXyhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CB61F000E9;
	Tue, 16 Jun 2026 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618533;
	bh=eEpsFP/xXpUPXqRf7uvxwII+CqHgphXobFe5PBEJlno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IFaeXyhRPGrBUQBqCVYlNH7iAweOxU5c1t/1ev/pwXEUnVcWauzsDZEsMzRZb6CHG
	 EdxPI6Rxg1cFf6j0V/wcAioluDrgwaZp8rXapY6LHqMnmsIql2lZWjNjrXiW2PZFUy
	 Byn5ojJn5QQ6J63L72udHlH7idKNw9dDcgnNtNepmepQKhUrunAcEtjJps80FqMyjv
	 6QAsSNedSJ0x2p19ddyJDmOQyhjOL/NIx2QLQFQaLWf7lBEi/4ibn0d2Ix4/NMsEZy
	 D+FJCwLanFgh2IwJsz7Vkp7DC7Szc+RLT0nOd1KRx5bh+r8iMyXJV20yP4ZEL/8FI0
	 RC21UYKnsGWRA==
Date: Tue, 16 Jun 2026 15:02:09 +0100
From: Simon Horman <horms@kernel.org>
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: netdev@vger.kernel.org, David Heidelberg <david+nfc@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Dan Carpenter <error27@gmail.com>,
	dzm91@hust.edu.cn, hust-os-kernel-patches@googlegroups.com
Subject: Re: [PATCH net] nfc: pn533: prevent division by zero in the listen
 mode timer
Message-ID: <20260616140209.GU712698@horms.kernel.org>
References: <20260615103547.1599528-1-dddddd@hust.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615103547.1599528-1-dddddd@hust.edu.cn>

On Mon, Jun 15, 2026 at 03:35:47AM -0700, Yinhao Hu wrote:
> The listen-mode timer handler advances the polling state machine through
> pn533_poll_next_mod(), which computes:
> 
> dev->poll_mod_curr = (dev->poll_mod_curr + 1) % dev->poll_mod_count;
> 
> pn533_poll_reset_mod_list() clears dev->poll_mod_count without first
> stopping that timer: pn533_dep_link_down() deletes no timer at all, and
> pn533_stop_poll() uses timer_delete(), which does not wait for a handler
> already running on another CPU. When the handler runs after the count
> has been zeroed, it divides by zero:
> 
> Oops: divide error: 0000 [#1] SMP
> RIP: 0010:pn533_listen_mode_timer+0x9b/0x110
> 
> Delete the timer synchronously in pn533_poll_reset_mod_list(), the single
> place that clears the list, so the handler can no longer run past a reset.
> Also return early when poll_mod_count is already zero, covering the window
> where pn533_wq_poll() re-arms the timer just before a reset.
> 
> Fixes: 6fbbdc16be38 ("NFC: Implement pn533 polling loop")
> Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
> ---
>  drivers/nfc/pn533/pn533.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
> index d7bdbc82e2ba..88df99001b4a 100644
> --- a/drivers/nfc/pn533/pn533.c
> +++ b/drivers/nfc/pn533/pn533.c
> @@ -951,6 +951,7 @@ static inline void pn533_poll_next_mod(struct pn533 *dev)
>  
>  static void pn533_poll_reset_mod_list(struct pn533 *dev)
>  {
> +	timer_delete_sync(&dev->listen_timer);
>  	dev->poll_mod_count = 0;
>  }
>  
> @@ -1235,6 +1236,10 @@ static void pn533_listen_mode_timer(struct timer_list *t)
>  {
>  	struct pn533 *dev = timer_container_of(dev, t, listen_timer);
>  
> +	/* Polling may have been stopped while the timer was pending. */
> +	if (!dev->poll_mod_count)
> +		return;
> +

I am concerned that access to poll_mod_count is not synchronised and thus
this may not work as intended.

>  	dev->cancel_listen = 1;
>  
>  	pn533_poll_next_mod(dev);
> -- 
> 2.43.0
> 
