Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33363EB0F6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042754; cv=none; b=K1L6crYR6q8QpYpokDpstx75KtG/Z3+AJ/NGW4Uc5bm9UUTizsIHXeOTMUT8Zi8PJEPaJemk1DeeKD9fvcq2qSYmL+RrUMsBHDug5f69RXflq/9HSEtBuyRUAEGu12EiScrPAcza5zfyZI1c3xmZ+FAJLCCZRm/epyCniXnQZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042754; c=relaxed/simple;
	bh=HoDSBKJjHVMPvX81IRFiiuGpxnHrJXtqODStpk0TR0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uu5BzM+MANZ19BOeZqCU1DueDSaT4INOjU6BrlnF7bprYsppngEmLfiy3TOcQRyvshnrO1zyzC6RLbeQj5H0RtuCO2tGZMbnJeyDrk+Xh0PpNkOVrq3b6IdaROsEiNsQ0AYCYokdjDmzexvv/7kgH3qVaRzNSgjPKeSY0OI9W3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/mH8CIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/mH8CIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2672E1F00893;
	Tue,  9 Jun 2026 22:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042753;
	bh=lsZr8NsT7I5W8zFPTZN43nG22GTSmPGdkPQAhmUqgBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T/mH8CIKbhCeGsEgqEE89PkBLqFcUqDkO4i7w6ZlDujoa2D3RMZovn0QkCwftFlEk
	 Fvn6UBBt8ZhYKrhjjrp1f9oiWXL0SEGyCFuju/frjqzi008soKGrKdZoudi/RoqXgU
	 /4IH8D+WcysYRNDirTXxT3PE+or4iaZ1GikstHMo0K20jNiwtbds3DcOKjV9GOhhiF
	 2sf7k/+2rxKvLkCaYJRL4MVOEPrlBYjISlpumrwRx+1ZL3+fHWgq+dsEfACfWYUY5g
	 PN+Shexic9RkqJucXqfq5XTDCku7KUMhvOI2Njqr7Bw2H2N1K517Ha9/FIEkwkPZwn
	 I7ASWzCCjY8vQ==
Date: Tue, 9 Jun 2026 15:05:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
 razor@blackwall.org, sdf@fomichev.me, dtatulea@nvidia.com,
 bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 1/4] netdev: check for nla_put_u32() failures
Message-ID: <20260609150552.2d962600@kernel.org>
In-Reply-To: <15c024cd-7ab1-47b4-94e5-90db0f74227f@iogearbox.net>
References: <20260609190804.1137085-1-kuba@kernel.org>
	<20260609190804.1137085-2-kuba@kernel.org>
	<15c024cd-7ab1-47b4-94e5-90db0f74227f@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 21:52:25 +0200 Daniel Borkmann wrote:
> > -	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> > +	err = nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> > +	if (err)
> > +		goto err_unbind;
> > +  
> 
> Not sure about these three tbh... if the skbs are guaranteed to be
> large enough, would a more straight forward ...
> 
>    WARN_ON_ONCE(err);
> 
> ... suffice?

Sure, I guess it's subjective whether it's better to add a WARN
and have to explain why it can never happen or just call the
undo function since it's already available :)

> Unwinding at this point feels a bit excessive. Is there
> any other way we could assert this earlier before we do all the ops
> that need to be unwound?

It's dead code. We keep getting patches for "nla_* return value not
checked" tho, so if decided to squash these while at it..

I'll respin with WARN
