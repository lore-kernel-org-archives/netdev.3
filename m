Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959792;
	b=YUbTlOXaHXdgVcwhISB/7MPbxdRNdVf0noh7O2gxhkw9BIGXZJxMsLZo/GP47gKzdE3v
	 TaUdwukMv/rsLa/wxloEG22pK7fidOxHFdJLqyhObOGRwS8eVsDApQFvH+0Sxne6HPpce
	 IaNZu1kfiahBFGg+fqCn8+vr5pZevI0vfMMwUB5rJGnFyhlZXIHSaTH6JK3Q+R9S954NJ
	 8tvN10YuX0MuCzFoOiuW6NZQ1tIKOC+V+TxMLA94HlBKQt8aM6heGvi47i60rRG5P6E82
	 VairwKaeUZn/tmREE2DOGdNGsz4Pt+hE4U8WV34JIPQLyFJENuZR+3A5gWVwyugPdPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959792;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=nlXCNuaGteJMHPhKOMcWqAFCETDFUXQYuHFMl+88FyI=;
	b=bcpMhIXSgBCDekJMkx2X/RDDagLsyaReG2XHGCO53DQxpqt0Ebaojs/9rAbnsYlvGpu4
	 daG6/oyoZisUdk08aHUVYeBZJnZaY4OxSfyA3RKnXMTzveXmuw39L+wxYNjcm00lIF8Tz
	 mn1NV24/9M6e6WCHzNG2N1vvw9yCcyg0ZycKnDCR7hi2BsvergfLwUNkVFxCG1L8cOyOv
	 rFKm2gr/f774gmHNkFUSCcsxKDk6/YaZ45TNslZQqg3kwuqiYBt3zYVmO++JNDDCE4lqY
	 M2FNF20wt+an+MADo1f8JrqmsODgICKMU+/4kvYwYy3UBp1wk8/rN0R7RSsr2vHq4nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=ciB7EYh5;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A4606A32C;
	Fri,  6 Nov 2026 10:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E6A4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=ciB7EYh5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nlXCNuaGteJMHPhKOMcWqAFCETDFUXQYuHFMl+88FyI=; b=ciB7EYh5KJ21H8k7CQUVDoJPTK
	aBgaJ2IlEbwPkXY9J0ggZMzwj2MomPQwOFuHGrQ/bu+U+sIvQ3mUrs2U0aWehjAQ05Ld8ivjdv8Lu
	1qX1L+1al//RhizxEOSN8lJNFi6qNCaD/awwNhUAQBydIMdLfUk5NnAcyzW/5aZPoxhwVr2Mue/CH
	Y639ld4gMvJb0p9TWcG463E1q2UwLxKrmW25xatpGquDgJZTsT6NvgrhJEq3A/Jb9wAfOM6kAIbAi
	AFWgzqqpRkAvAF/V10jbPGGrKl8ru2m9v22wh3MAYPHG90zvrpePLR8tpaWgd/R/keZgJ9BsWQnVT
	V+NBT3bw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xPGtA-009CvW-07;
	Fri, 06 Nov 2026 10:09:40 +0000
Date: Fri, 6 Nov 2026 02:09:34 -0800
From: Breno Leitao <leitao@debian.org>
To: "Harry Yoo (Meta)" <harry@kernel.org>
Cc: Arthur Kiyanovski <akiyano@amazon.com>, 
	David Arinzon <darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kernel-team@meta.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ena: reuse the whole RX page on 64kB page
 kernels
Message-ID: <au2nNm44LnaoXcB2@gmail.com>
References: <20261106-ena-rx-reuse-64k-page-v1-1-ac75b20c5de8@kernel.org>
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
In-Reply-To: <20261106-ena-rx-reuse-64k-page-v1-1-ac75b20c5de8@kernel.org>
X-Debian-User: leitao

On Fri, Nov 06, 2026 at 03:17:11AM +0000, Harry Yoo (Meta) wrote:
> Since commit ef5b0771d247 ("net: ena: fix driver when PAGE_SIZE ==
> 64kB"), the RX buffer given to the device is limited to ENA_PAGE_SIZE
> (16kB) because the buffer length field in the RX descriptor is 16 bits.
> However, the driver still allocates a full page for each RX buffer, so
> on a 64kB page kernel only the first 16kB of the page is handed to the
> device and the remaining 48kB is never used.
> 
> The dynamic RX buffer recycling added by commit f7d625adeb7b ("net: ena:
> Add dynamic recycling mechanism for rx buffers") does not fully utilize
> the page because ena_try_rx_buf_page_reuse() only reuses what is left
> in the current buffer and ignores unused memory in the page.
> 
> This shows up when RX data stays in socket receive queues, as each
> queued skb keeps the whole 64kB page alive while at most 16kB of it
> holds data. On an EC2 t4g.large instance (64kB pages, 8GB memory) with
> 519MB left unread across 64 TCP sockets, RX pages pinned 2869MB of
> memory while the socket layer accounted only 687MB.
> 
> Fix this by mapping the whole page and letting
> ena_try_rx_buf_page_reuse() size the next buffer from the room left in
> the page instead of from what is left of ena_buf->len. ena_buf->len is
> then only the length written to the RX descriptor and stays capped at
> ENA_PAGE_SIZE. With this fixed, a comparable workload pins only 497MB.
> 
> When PAGE_SIZE equals ENA_PAGE_SIZE, the room left in the page equals
> ena_buf->len, so nothing changes.
> 
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

Nice finding, this seems like a bug, no? Which means 'net' tree and
a Fix: tag.

Reviewed-by: Breno Leitao <leitao@debian.org>
