Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293F30DEB0
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863495; cv=none; b=BL3jP9102v9fEdDpDfejeTGZMX792IcFspVWwkxi7anYwbG8M6CEThKS8E5uFXvUcaWbVm7s16JEk/M0Qswgs+JdfZ1d6gTRsAbGlV4+usfbrQjdk4CESNnNo4bqYdAtxeB3dQ2ma4ABxPXe79q0ZIFYoq3AfSFc99oowA66KEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863495; c=relaxed/simple;
	bh=tsiKrpIW5xIVhsJ9DOti1bzBMUFKYyVhPh4JwUDj67s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDqq48sOleWYp61ttW5FGHjMqrwjAu9mbV8hYJts1Bjjs+kLZk8jee/tpiqOAbXFRwlltuuWtSk/ex9W4XFS2lqgF79RhGl9vk0c3Jzgr5dTHKIi7ytLlGSSuFCFN1cEDHlgCpr6q5EuDFkHd4I36DBApvy7DYFTlGx01mT9zrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=tvhOfOmC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L+Fp7G4f; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="tvhOfOmC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L+Fp7G4f"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E254EC05A3;
	Mon, 23 Feb 2026 11:18:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 23 Feb 2026 11:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1771863490; x=
	1771949890; bh=jjKwZiKEhGnhrc0RbZdAGHQdNaimEgLjwERQyTu75Ew=; b=t
	vhOfOmCEXN2JPv9VkICX9LIOk1ztddrloH3zPQaNmWztwtAXd99OX8PfNlG8dhj0
	4RBoKHIFwTNT4bZNyEhF5XF0ghDXv7aBL6w8yP/aKHd46JVufEDwTEOudef0AezP
	9nfMMHOGTppk+QpvT2CUyCOGotOC1Ms5mdWBa7HEtSpegaDo/aejHCNWJVP9ngJg
	ZS1R+HsxoGU+2kChzRytybpiRCq2Ji78Tct91UyJeyVwXFlOwAEb/QhoLcS9rG39
	DoFL133EOztKkqK5h57dY7KQMHTAjnqaibRV+9oVL28C/eYmosStfUxngeq6NJsz
	fXvbhsMM/r5eQpGTtxQkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771863490; x=1771949890; bh=jjKwZiKEhGnhrc0RbZdAGHQdNaimEgLjwER
	QyTu75Ew=; b=L+Fp7G4fVio/mebmf3zv49G2GdvRrZTgzw1AkInTc8XG2l0UOJn
	eZ6q0rlwWHGmtkcwZNJwY5lkhzAJReWxi2j9JHKN7/pmh65jtiLqYTq0QqhGwru3
	qdm/SsEfiaujzEH5QeQTcl10DQpBxJ7CJx7S9EGLgSSrGSkmwNVUfHuMV/Je2Sc9
	YxxO4+vDWKmRDeqmLpcgdyf/y8oR6Xdk6IJSsX71onLLUFLmq2GOTh9JYdRXUboj
	Cb2YDXqkanph6DHVg93GQ+ai84TK25ub5xaYVmTOU/eyDFADtUsQw4Aa1Qs9sWht
	WLm+7Vu6WpYU5sGRF1cwNiR3th5xugapcYg==
X-ME-Sender: <xms:wX2caRYXdNYpnlxzQ2ZquTVWlC4HbFZrRHbkApe6B0imzqLRivJSKQ>
    <xme:wX2caXeT3IZuJdobsSVwFwalNuLc92IztYaCaPvKOu2uGik06J9LUczWb-6Fh_FvG
    ilV_syiRMkhLYQiSrfBvmVNFi6TUV2d54ufrnee70fL4DuG9JZtjQ>
X-ME-Received: <xmr:wX2caaJxqE_LbJuy9BIxcKYcy1tiEgRsGje0ewQInFI1jEoYvU_Qj4fj3mFf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeghffftdevudfgkeffjedvie
    eilefhtefffeefgfehvdevhfejjedvkeefleeggfenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehimhhvgegsvghlsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wX2cacILEfMwU90D0xgJz6QwlwTOMzikY4dWSwWpwiIRyhPh0_-JEA>
    <xmx:wX2caRXc6Ak_qhRNWO73BafJ_FLYwpbAreR4I-kv84QYGfI8yzbYnA>
    <xmx:wX2cadmQ9GfBJFlOQb6v0twTxEayIn6WfAFo7s6fSOorRz3wtYpPWw>
    <xmx:wX2cafnyEzZwAO_uDlmTYff8Rp2YSPl9_Z4_41eiaeLv9b3EiZWM3g>
    <xmx:wn2caR2e1qf4bhdcZDhcAru7f-zejI2iw4WWyjyYkdFKBJAK6FvFFuYT>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 11:18:09 -0500 (EST)
Date: Mon, 23 Feb 2026 17:18:07 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] tls: Fix race condition in tls_sw_cancel_work_tx()
Message-ID: <aZx9v26-BKWoPprM@krikkit>
References: <aZgsFO6nfylfvLE7@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZgsFO6nfylfvLE7@v4bel>

2026-02-20, 18:40:36 +0900, Hyunwoo Kim wrote:
> This issue was discovered during a code audit.
> 
> After cancel_delayed_work_sync() is called from tls_sk_proto_close(), 
> tx_work_handler() can still be scheduled from paths such as the 
> Delayed ACK handler or ksoftirqd.
> As a result, the tx_work_handler() worker may dereference a freed 
> TLS object.
> 
> The following is a simple race scenario:
> 
>           cpu0                         cpu1
> 
> tls_sk_proto_close()
>   tls_sw_cancel_work_tx()
>                                  tls_write_space()
>                                    tls_sw_write_space()
>                                      if (!test_and_set_bit(BIT_TX_SCHEDULED, &tx_ctx->tx_bitmask))
>     set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
>     cancel_delayed_work_sync(&ctx->tx_work.work);
>                                      schedule_delayed_work(&tx_ctx->tx_work.work, 0);

And possibly something similar with tls_encrypt_done() if async crypto
gets delayed by just the right amount.

> To prevent this race condition, cancel_delayed_work_sync() is 
> replaced with disable_delayed_work_sync().
> 
> Fixes: f87e62d45e51 ("net/tls: remove close callback sock unlock/lock around TX work flush")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v2:
> - Shorten the patch subject
> - Target the net tree
> - Add the bug discovery background and the race scenario to the commit message
> - v1: https://lore.kernel.org/all/aZLotq3aZY0b-dI8@v4bel/
> ---
>  net/tls/tls_sw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 9937d4c810f2..b1fa62de9dab 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2533,7 +2533,7 @@ void tls_sw_cancel_work_tx(struct tls_context *tls_ctx)
>  
>  	set_bit(BIT_TX_CLOSING, &ctx->tx_bitmask);
>  	set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
> -	cancel_delayed_work_sync(&ctx->tx_work.work);
> +	disable_delayed_work_sync(&ctx->tx_work.work);

This seems ok.
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

It would maybe be a bit "cleaner" to reorder the operations in
tls_sk_proto_close() to first stop all async encryptions and switch
the CBs so that tls_write_space can't be called anymore, and then
cancel the tx_work (once we know nothing can reschedule it anymore),
but this should be fine.

>  }
>  
>  void tls_sw_release_resources_tx(struct sock *sk)
> -- 
> 2.43.0
> 

-- 
Sabrina
