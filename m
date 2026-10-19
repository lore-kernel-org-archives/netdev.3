Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430930;
	b=EItvLDMRg0o9Ii8zPH1oCjOxDssrBQ2RXlgFrwtfnkdpB73SEP6tE7tGrNwdqSzKoM94
	 myIP1gAz7tEz6w2+0J6bILacPDMHLmJFKc73rd1Jl8TS7K8Ww6lQj0M6CIUqQedPzFauf
	 wnGlITjTsNzmdp+qaZqC/NJ1pyYgi7kQ9ddqh6CZqydUdwjeNOQLp2+wU2xZrhwk+wFze
	 KTk/H2BTkEiWSm8uq56NgWicPCWblyrfYuKakEMCKNAe9SKc9PhGocxKnj2Jc4BpYL7FC
	 WruduNGbt0p2lCkef2frFlgLbSCPKn6FntAF6OmgOppoEXRNyLi6ceYg9NUCNc1hVXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430930;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QO3s1rauZcuxZOVGGbwGfUpfXElhQcevaofoqEKmEGg=;
	b=pROnLOvva7jDpVbwDBv2OSe+zt3xjQSUFC0oJ2+q0iVE1AdlZIEVzxZotZMm182PKzz2
	 fDU0/fnc1dc9kmxFHWgbVMHjKTZcARaAl9S++Bra+MLPJHydfcZHZYEvhFXRT1Z6AJ3Cs
	 3qpjDDXaTDPCJEisso9MK83E0K7/tcCe+kRULpNCBXqdZz5ZtJ7L0pwGJn3rawqX4m/lV
	 HZ1ngWpgr9fEYT7V2gQGKA6ZG4nfyGP0kwxUShlBmOflQEHJcQPn7JgFh2vXoDh6cfbO9
	 2p7nuCf7SC/gsPJgSUbNaZqOrvpNg7NsM2bk8vyf1Vcezm8NvGSBQ7o89HMh1lZTy8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SL1bzeb4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445360A2600
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SL1bzeb4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE56D1F000CD;
	Mon, 19 Oct 2026 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430929;
	bh=QO3s1rauZcuxZOVGGbwGfUpfXElhQcevaofoqEKmEGg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SL1bzeb4dx+u8q3/fwYIfa5Hfb7F9wzDGf8EpkMGDkTli0VGA+Xiq9cGhrOi53uy0
	 CD70dSnv0gwwBgBzYPR5dQg+x44/Gnu943Q00kjXWADagUJ6YImXng97DWQx97afsu
	 okjiazt4W1jbaOwILHatmsmh54dAV8Z0Ig0hVItDNejxj2iTnsLe48J1DiGWllP65K
	 q9++9DHxgxgHMbqy20a091CohvTyfYcPA/FXwBWRuOZl68AlWM4/fLOQ0f55Xrx7Vd
	 F+aavsAVGbqoexlhVRFvhZuZwe+tQ7i+/rUTvYbjNG4Z1tAEE+uUgno/XhUsW8Y6XB
	 ag0D+4VS266bA==
Subject: Re: [PATCH net-next v5 09/14] net: ethernet: cortina: Recycle claimed
 free queue pages
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 19 Oct 2026 17:28:48 +0000
Message-ID: <179243092834.3135.8181059435095195600@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-9-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-9-b5c9e2f7b8a3@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The stable dependency on this patch is not recorded.

--

net: ethernet: cortina: Recycle claimed free queue pages

This patch keeps the base page reference and streaming DMA mapping of a
free queue page after all its fragments have been claimed, and records
such slots in a new recycle bitmap. During refill, a recycled page is
reposted if its refcount is back to one. Otherwise it is unmapped and
released before a replacement is allocated.

> net: ethernet: cortina: Recycle claimed free queue pages
>
> The preceding "Preserve in-flight free queue pages" fix releases each
> mapping after its last descriptor is claimed. Refilling therefore
> allocates and maps a fresh page at line rate even after the network stack
> has released all references to an old page.

[Severity: Low]
Should this patch be tied to the earlier fix for stable?

The earlier patch in this series, "net: ethernet: cortina: Preserve
in-flight free queue pages", carries:

    Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

so it is a stable candidate. Its commit message also says:

    A later patch restores recycling independently of queue position.

This patch is that later patch, and the paragraph quoted above describes
the earlier fix's behaviour as a problem. This patch has no Fixes: tag,
no Cc: stable and no stable dependency note.

Mainline is not affected because both patches land together. Suppose a
stable backport takes only the Fixes-tagged patch, plus the untagged
prerequisites it needs to apply, such as "Index free queue fragments
with XArray". Wouldn't geth_fill_freeq() then do one alloc_page(GFP_ATOMIC)
and one full-page dma_map_single() for every refilled page, with nothing
pointing out that recycling is missing?

Would it make sense to give this patch the same Fixes: tag? The
alternative would be a stable dependency note on the earlier patch that
points to this one.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3%40kernel.org
