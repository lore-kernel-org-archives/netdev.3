Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963433;
	b=EFI9gUt/y51S3cVcu0mxcvtWxD4kOd1w8BsAPQeLdJnxJPSecQUI6S/RFH9FnvcA4hfq
	 zs8oCemy7J8LfGkFp3H3owh3mmtiUQUVryhZgmU10psfeBAql5UQFndJ45kAJcr0dRXwe
	 lNaD+NEAYxTmA2Ki0VkZgnNZNLSsVtkv16POn2vADpC4wpucdbRtwoVhCsKDaz+qtVNS/
	 FJMIf5oT0XamXPBB80aWuvms4XhwqqYVeITaEdzGJppB47HmxagsQd2pUjMWFVivBTJa2
	 7q8ChbEB9oTVlzOllaYSz9EA3XnwK0a5NFzOfnETqFZA8Glfg9eJSRTzPRZ9ogbsqSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963433;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=79VEnISlBWCB0jfRPZxMBgFANQF9nkjMie7oZkEbJyM=;
	b=Nmsfzzgtt0OAueGwwsuXLu7wkv0FRVwrOazzFxbGkywHmdRRAu+h+rgh1XfiVO7jDDW/
	 TjfHmhzTZHE2lGEU5LVAYdQBDcpYUHcXofG2OnWqOoCqzZAJndYCSmIJK8UdtXkkTa+Zc
	 JcdYz9/mCZ1/CWm+TtZ+JP3SnJml7I4IlRokMixwoYHtytXKPwsdNpF3cxsnu4pwiKfKG
	 dKmVHM8M6IRpjWdYGxbmtOJIg0OezfMNJq01gGjRKh9FYjOHexhN+OoO/VFTap3iJBSQk
	 rafTwqSOHmxcjZxoqOzER/e4xA9O5RIKuHke8xmol39IpELlmva1+9XtIwezsRYqdQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oypPu6P5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB8B606A329;
	Fri,  6 Nov 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oypPu6P5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C68E1F008A4;
	Fri,  6 Nov 2026 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793963433;
	bh=79VEnISlBWCB0jfRPZxMBgFANQF9nkjMie7oZkEbJyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oypPu6P5oKVysGRQFLgMe+23NPmbfsu1P2FvjR0QMxUEge5PuMtPJl5JCHt89IaJm
	 w9PFPE2Dt/wulLtdEsKSEP8u4HaG16/bep4kyC6AsTki0KiBLE2Y1wF0c7RP2o3VZz
	 oWBJGk5S2VlvZTlT2gk3faZpGnPedAIqdkCPKhoiHVGfyuG2WgKlZE0KJGm3nUK1Qc
	 tKPI4JgQ10uYbDFeOOJKOqGX6HyvecBxiFIaxF6gTtPuR9a48CkdMRef5hiA3waUOV
	 MdHLQxgMbu+cQmS+4bm39ih8o9inFcjWCV2Xc+K5qZkdlpOt4TgarDKnnEZFp7sRm0
	 Tgd9aBnxMEx2Q==
Date: Fri, 6 Nov 2026 11:10:30 +0000
From: Harry Yoo <harry@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Arthur Kiyanovski <akiyano@amazon.com>, 
	David Arinzon <darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kernel-team@meta.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ena: reuse the whole RX page on 64kB page
 kernels
Message-ID: <au2yaGVnZmyA2WUo@minisforum>
References: <20261106-ena-rx-reuse-64k-page-v1-1-ac75b20c5de8@kernel.org>
 <au2nNm44LnaoXcB2@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au2nNm44LnaoXcB2@gmail.com>

On Fri, Nov 06, 2026 at 02:09:34AM -0800, Breno Leitao wrote:
> On Fri, Nov 06, 2026 at 03:17:11AM +0000, Harry Yoo (Meta) wrote:
> > Since commit ef5b0771d247 ("net: ena: fix driver when PAGE_SIZE ==
> > 64kB"), the RX buffer given to the device is limited to ENA_PAGE_SIZE
> > (16kB) because the buffer length field in the RX descriptor is 16 bits.
> > However, the driver still allocates a full page for each RX buffer, so
> > on a 64kB page kernel only the first 16kB of the page is handed to the
> > device and the remaining 48kB is never used.
> > 
> > The dynamic RX buffer recycling added by commit f7d625adeb7b ("net: ena:
> > Add dynamic recycling mechanism for rx buffers") does not fully utilize
> > the page because ena_try_rx_buf_page_reuse() only reuses what is left
> > in the current buffer and ignores unused memory in the page.
> > 
> > This shows up when RX data stays in socket receive queues, as each
> > queued skb keeps the whole 64kB page alive while at most 16kB of it
> > holds data. On an EC2 t4g.large instance (64kB pages, 8GB memory) with
> > 519MB left unread across 64 TCP sockets, RX pages pinned 2869MB of
> > memory while the socket layer accounted only 687MB.
> > 
> > Fix this by mapping the whole page and letting
> > ena_try_rx_buf_page_reuse() size the next buffer from the room left in
> > the page instead of from what is left of ena_buf->len. ena_buf->len is
> > then only the length written to the RX descriptor and stays capped at
> > ENA_PAGE_SIZE. With this fixed, a comparable workload pins only 497MB.
> > 
> > When PAGE_SIZE equals ENA_PAGE_SIZE, the room left in the page equals
> > ena_buf->len, so nothing changes.
> > 
> > Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
> 
> Nice finding,

Thanks for reviewing, Breno!

> this seems like a bug, no? Which means 'net' tree and a Fix: tag.

Good point, I think Fixes: f7d625adeb7b (6.6.y) would be fairly
reasonable as this is the first commit that reuses the buffer,
it is quite huge unaccounted memory waste on kernels with 64kB pages,
and the change is quite minimal (applies cleanly up to 6.6.y).

I'll respin it targeting net tree with Fixes: tag after waiting for
a few days.

> Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks!

-- 
Cheers,
Harry / Hyeonggon
