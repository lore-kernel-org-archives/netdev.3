Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709832;
	b=wBlKsKibpyjwqVwAas0pmG+1n61Lx7nIA45BllyxichB0lTQYC43Ob/iJUDOSBkmWup9
	 hbga/c1jRCC1kbPS23e72zhPrJRB/o77WUpTzrB/A6BL1hsF1abs5TSSOraklaXyg/noe
	 jh8ZEgUdnZaSfiZB2o3cY+giHr4fV7d2QW1INY4kIQXxy/0BlnLx+/+kT6CTabRikB0+e
	 W+9NTEOjoQAGz9jHTyQvSym2wfPzjL9unf1RLrmY2yatoso9/qn1SZUVcsz5I5xAu7QF4
	 sj8Zy+QLI/Gl1Fre3hE53ld6KC3XMToR80wa9WPA0SuKfb2ROxtj6ALSSFIAzQ9L2ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709832;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NsgSbkB27Pf5TMWO9sdStQcnc7NhggjeuaxefOi9tnA=;
	b=wHHBDHgpPO4pjXb4X2ZOON0DI5Z4gPLHG1/nMHBTZwLNLLi6aWXFhC11Fv7XQV3pw5bN
	 s06gb+pHSJ2zFYdnBW/9Kbt+g625XfxhgPx/yC5OhMGFyn+obm5r9iRQqZcZzqtXZSndb
	 OoOMtH56iqUcqWaO/BqWcFW2jjo45Kw2qS8iWfED/cZAT7MRQLX2WANzfR11G6QlsGrbS
	 3pSnlTyG4OoDPLDuxoGeMh8TW2+mH1ZyZvCX7UtJNnPRSpbGsfKNyawq27d0Pn3ix0MZn
	 to0GDH+iKHUzRDIP6Qn6+oXvzPBIUv9YIUAI86mEOO3XoaXKrdVeNIwcGX0qYs3RZoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ccauj+4A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5F606EE8C;
	Tue,  3 Nov 2026 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ccauj+4A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD57E1F000C1;
	Tue,  3 Nov 2026 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709831;
	bh=NsgSbkB27Pf5TMWO9sdStQcnc7NhggjeuaxefOi9tnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ccauj+4AmTSvdQOJtK7q4KyI8yqvwQbSxQUW3MzkqSWtdHrc57N0rPFma3J6chcFt
	 pVVVG7/NrPWQV1z9gn5wpBtcHzPl9feAGYiG1LCFqWgRBFMwvsah5A5GJn7XUwIoJo
	 rCDnaVM8AwLmmFDywx7OyC05qqSQl7nblT7u5MQXv836o6DQF3FyBWfm02gMtOMcNE
	 icUfnOIgHAPhPJGz1RDYk98NBhmB+CUQ8Evh/5QUZAHXzUIPF1lILnW315ImixEq63
	 0HgLaM4JwQYzszN8poQczWvARLs51tXtfEgpqBZ5e3LByPKh0hlkxgbhiMEVBgGBl3
	 NUekNCIU1Ky8w==
Date: Tue, 3 Nov 2026 12:43:46 +0000
From: Simon Horman <horms@kernel.org>
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com, willemb@google.com,
	jiayuan.chen@linux.dev, mfleming@cloudflare.com,
	almasrymina@google.com, bigeasy@linutronix.de,
	richardbgobert@gmail.com, ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/4] net: make room for the tunnel header in
 skb_segment_list()
Message-ID: <20261103124346.GJ865646@horms.kernel.org>
References: <cover.1792838740.git.julius@bairaktaris.de>
 <b27640960edcb8e072fdd2e8d282c1deee747b8a.1792838740.git.julius@bairaktaris.de>
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
In-Reply-To: <b27640960edcb8e072fdd2e8d282c1deee747b8a.1792838740.git.julius@bairaktaris.de>

On Sun, Nov 01, 2026 at 05:42:29PM +0100, Julius Bairaktaris wrote:
> skb_segment_list() pushes each frag_list member back to the outer MAC
> header and copies the tunnel headers in front of it, but never checks
> that the member has the headroom. A fraglist GRO packet forwarded into
> a tunnel and segmented in software then hits skb_under_panic() on IPIP,
> and on VXLAN the copy writes before the member's head (KASAN:
> slab-out-of-bounds write in skb_segment_list()).
> 
> Call skb_cow_head() on each member before pushing it.
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>

Reviewed-by: Simon Horman <horms@kernel.org>

