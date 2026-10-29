Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268000;
	b=vvlOe9DrM55kOTYsFB4XysIgPh5L6vi2ybp938vV+QITbXdSOTJfJtWaQabzEGsm7znE
	 9+WhF2aXzaX+0+KwKiwjpk+xwuE3taoj1VpsG86pQYJO6QnZvjOkvIwv9fgEn7PoGSiYy
	 IsY6u8yJHuCGKdhajWTSslCiudLTdDbE6OSMIfU472ZSkCr1KDU1EDbwPJ4pzfEDXX34i
	 5a2nqSLMsb2+EEZzYTigd8lBDIkIO6+5gzrZJxLteIR+uWcuYzSqF7dZ1sxkHhkGZv3O3
	 zBYOUFKEI138lmnFFdc9uuiCU1mxYhYMai0L3a8R+ujE0Jx0P/hMuf8Fr6h4/vTzTQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268000;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=R5j+yiYhCHq58JPEG4iD9M+YB5PgArKotbfDfonHirY=;
	b=uqHTxytS89YsiKifpsCXBt5EDfqCbgPdbCnmSYb0gt5ikjwMZA1gKoClp6Wn+7pyzXOy
	 l0cH0CDCV3BeY3LzqxGq/MJIvstHgV4GmrbtCWUFcCoGl8+Rq7XRiGa6+Z9/0IDhe/vQ9
	 tSp5v75AhKx4LI0yQ7NvhgxhO4AyEDP8Q/M9gSc+N8+1lqDoCzLrQ8JGYvfxn0d+o4oSI
	 qStvWW6HEzAX2ohZnAiEFA/St0r5UQ5yugxZJQm3y2PaumO5+uuzoo1Cik7d50xK6a4O/
	 sfcK2d9kdf26OyW600QBq/OjMGO6ud+EAZPRXl7jdRj+urcp4BxyZTql/zL3Y99NaOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O73oQffq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24794606A31F;
	Thu, 29 Oct 2026 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O73oQffq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DE31F01825;
	Thu, 29 Oct 2026 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267999;
	bh=R5j+yiYhCHq58JPEG4iD9M+YB5PgArKotbfDfonHirY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O73oQffqeqikGDOuGDIY+NW2h/CpmNU5TKIWGZcmDMP/nIgRRBHUlxQ/rByvmxysZ
	 2DibCtTty4S0qQ9JYLUNQ2dkoJIfYb8Wg3hbow/0qw3zC5PBMT7ZxMHVn7cTHo7P2Q
	 eHigrpfHtmmgho+MFCgSY57Bf3fA0P7yUHFhFVvfcWiY3qyFqifrEJNJT3kb10q7fr
	 glHPWTJcD+Lxk+9D43PGxMBgpyc1vLVzeGu/TPAkP2mu3xRvW6L77MXJ9JtBs+0ddf
	 BwJsHcek9yBt2zul90gA9wabFYrnGM5WS2elzRf2uumNpf+KWH+n9eTsTQmHKx/8s9
	 GLzP+X0yXxHbg==
Date: Thu, 29 Oct 2026 09:59:54 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: alex@goodkind.io, nbd@nbd.name, lorenzo@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, tarick@bedeir.com
Subject: Re: [PATCH net] net: ethernet: mediatek: preserve sibling PPE
 bindings
Message-ID: <20261029095954.GD257209@horms.kernel.org>
References: <20261023012529.5994-1-alex@goodkind.io>
 <179306513862.3134.14236907013127690482@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179306513862.3134.14236907013127690482@kernel.org>

On Tue, Oct 27, 2026 at 01:38:58AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 (3) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The fix is incomplete: the L2_SUBFLOW branch of
>   __mtk_ppe_check_skb()…

Hi Alexander,

The issue above does seem to be of concern.
Could you please respond to it?

> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but L2 (bridge)
>   flows never get the 0xffff 'unbound' sentinel in entry->hash.
> - [Medium] This problem wasn't introduced by this patch, but
>   mtk_flow_offload_stats() reads entry->hash without ppe_lock: once for…
> - [Medium] This problem wasn't introduced by this patch, but the MIB read
>   sequence in mtk_mib_entry_read() is not serialized.

...
