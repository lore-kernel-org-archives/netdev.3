Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98E4A2A6B
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307154; cv=none; b=Agy3JnjUDSYVrCIFP6gszhAFcKznv8QvE1QLpqdzjNj07RgBpKyNO65gFJNWSRjDsRHRR8kM+a0yJiu0T0YWUeChKZbYydKAkHzEddeU4kR76J6cE5cT1EotwDtY1Sxhef5grrvnYTVsqwL6k5CqS/3/bvZ00/t3ifV0ND++Jcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307154; c=relaxed/simple;
	bh=HlSmoI338TjhkhXtqEYg8geDLYOdbdBnzpHAgkyabNE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IuaiDJ8rSiUBDRgDP6vXiyBViUuIzplOLVZr1E7gdmyJtHEKCh3h9Pk6Lz4va3+pjawZs36AwZbg16NyB2TjFHrnbBI5Hu9l/0GxVLHk9PeYz9CtGPNLJgrPCImsW6unrtcMnvc8E6Gd37b6UaFNODUXtNmwK7BznX+TWvY+XcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE5wYc/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE5wYc/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEA51F0089B;
	Tue,  6 Oct 2026 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307151;
	bh=6y/1IrNLZOjRAGfaMfGNIO1B+lSxKpkDKE8agkB3fZc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DE5wYc/Rejzu9k2p646WGwsLK2CxX2vll419bS+vNwVJGrmwlXxTpjrR/E3kRJyPz
	 B3AKl2y/2W0hfsSlM5MMfEqkMwsAifCdMWvmAvcphF7319SUudLPnHFpSfHqAnaCth
	 Qy43W5nyrejfcZ2llVGZpcUYPXE9LHMqeMmXdZ6t2Hbm8+RFfW7PhQHi5zgcCnvT26
	 u4fis4YMJYPJTUU0RBFoi49g9SEvtEjraxD19H0HaebdgrpYCI/MTOXDKTlPJt7D29
	 bUKmFDeRlkGScuPAid3pUMkq8m8v9vyoGiEfE5lApvx1W0vpH0CSwvMV7lLM/wFPx+
	 q/X0+xRFVn3Kw==
Subject: Re: [PATCH net-next v3 08/12] net: ethernet: cortina: Rotate free
 queue page allocation
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:10 +0000
Message-ID: <179130715044.434549.12317966263867256368@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-8-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-8-3e1f25890ae8@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit "net: ethernet: cortina: Rotate free queue page
  allocation" carries `Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver…
- [Low] The commit message carries a Fixes tag and `Assisted-by: LLM`, so
  it presents itself as a netdev bug fix.
- [Low] `geth_cleanup_freeq()` and the error labels in
  `geth_setup_freeq()` (`err_freeq_bitmap` / `err_freeq_pages`) free the…

--

net: ethernet: cortina: Rotate free queue page allocation

This patch changes geth_freeq_alloc_slot() to start each bitmap search
just after the most recently allocated slot, wrapping at the end, instead
of always starting from zero. A new freeq_page_cursor field holds the
position, and geth_setup_freeq() resets it to 0.

> The free queue metadata bitmap currently searches for a free slot from
> zero for every page allocation. Under sustained traffic this repeatedly
> scans occupied low-numbered slots.

[ ... ]

> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

[Severity: Medium]
Is this Fixes tag pointing at the right commit? The freeq_page_bitmap,
geth_freeq_alloc_slot() and its find_first_zero_bit() search are not in
4d5ae32f5e1e. They were added earlier in this series by "net: ethernet:
cortina: Preserve in-flight free queue pages".

The change also doesn't seem to alter behavior beyond where the search
starts. The old code returned -ENOSPC only when there was no zero bit in
[0, num_freeq_pages). The new code returns -ENOSPC only when both searches
fail, which is the same condition. A free slot is still found whenever one
exists.

This looks like an optimization of code added in the same unmerged series.
Could it be folded into "Preserve in-flight free queue pages", or sent
without a Fixes tag?

> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[Severity: Low]
The patch carries a Fixes tag, but the commit message doesn't say how the
scan cost was found or measured, or how the change was tested.
Documentation/process/maintainer-netdev.rst asks for this:

  All bug fixes must state how the issue was discovered and validated,
  and how the fix was tested.

For hardware drivers, it also asks that the testing statement name the
hardware the fix was tested on. Could that be added, including which
Gemini board was used?

Also, the message says the bitmap "currently searches for a free slot from
zero", but that behavior was added two patches earlier in this series.
Could the message say so?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 2345d582cb597..87c537ae83e7a 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -743,12 +744,20 @@ static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
>  
>  	lockdep_assert_held(&geth->freeq_lock);
>  
> -	slot = find_first_zero_bit(geth->freeq_page_bitmap,
> -				   geth->num_freeq_pages);
> -	if (slot == geth->num_freeq_pages)
> -		return -ENOSPC;
> +	slot = find_next_zero_bit(geth->freeq_page_bitmap,
> +				  geth->num_freeq_pages,
> +				  geth->freeq_page_cursor);
> +	if (slot == geth->num_freeq_pages) {
> +		slot = find_first_zero_bit(geth->freeq_page_bitmap,
> +					   geth->freeq_page_cursor);

[Severity: Low]
As far as I can tell this can't be reached today, but the wrap search
now passes freeq_page_cursor as the size argument. That means it relies
on the cursor matching the current bitmap.

geth_cleanup_freeq() and the error unwind in geth_setup_freeq() free the
bitmap and clear the count, but leave the cursor at its last value:

geth_cleanup_freeq() {
    ...
	bitmap_free(geth->freeq_page_bitmap);
	geth->freeq_page_bitmap = NULL;
	kfree(geth->freeq_pages);
	geth->freeq_pages = NULL;
	geth->num_freeq_pages = 0;
    ...
}

If geth_freeq_alloc_slot() ran in that state,
find_next_zero_bit(NULL, 0, cursor) would return 0. Then
find_first_zero_bit(NULL, cursor) with a non-zero cursor would read
through the NULL bitmap. The old find_first_zero_bit(bitmap, 0) returned
-ENOSPC without touching memory.

The current callers of geth_fill_freeq() appear to be guarded:

- geth_setup_freeq() resets the cursor after bitmap_zalloc() succeeds.
- NAPI only runs after a successful geth_resize_freeq().
- The SWFQ_EMPTY source stays masked after a failed resize.

Would it make sense to reset freeq_page_cursor to 0 next to the
num_freeq_pages = 0 assignments? Then the allocator wouldn't depend on
those outside guards.

> +		if (slot == geth->freeq_page_cursor)
> +			return -ENOSPC;
> +	}
>  
>  	__set_bit(slot, geth->freeq_page_bitmap);
> +	geth->freeq_page_cursor = slot + 1;
> +	if (geth->freeq_page_cursor == geth->num_freeq_pages)
> +		geth->freeq_page_cursor = 0;
>  
>  	return slot;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
