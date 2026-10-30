Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399795;
	b=pGzMhermQVKCl5K+PvFI7epoq7vQ9QJm/PTysSlyl0J3DQQcLP7FmSjQL9XoSgfv9sVe
	 vAamb6181u0HaM/J++lw0ZHUw4uaLOz2lwLYov6NxOHIsq1E5ZOm4AOsEdnvuDmQwu7FN
	 +XufwzgH1uYTFvxz1GKJU44b/T+nvdcU+9zHbfEgJ38Ch1PoLwQPvhyXoBVDos64+jASB
	 9X4WKXUt4jygclMCRm6Mqtm89f9EplAWYKL0DaG7HNM0eVNAcNdI5wCL1pGk0zvQSfhsH
	 xdBYlfiP7sGrDJfxQ82suZ6J4g+tHOLAo1wMN0wvOuuQDJUV/GFCzxYQOAOhlx4z3NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399795;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YLaBLrq9vqUBBHrjdJ20lZM/hS2ppHBmmfX7lg9P4M0=;
	b=Ic/Pdy71g5dkeWMLOzh8IdaXgyV2+do9ybEkxP66xE+2lLyt3cn8nXkKOi7m90iuxe9I
	 ua/UpkrbwwVfSremAilDrYQ758wJ/LtBTJsddoHcps4hroamexfvBj4iIsqJMaQvFkltS
	 uXT/r44XfxEtFlNlnjQpG7alPaeToHO1A9kg8HfqrqS+2vOTx282ZDx/kipeRdWl0y6r6
	 xRfzET+Jy8bszGMW3O8xaKnx4slER0lIjWUxdLH5V36RY1PplmSixCFX9igDD1vfnG3bw
	 UAwDQz6RBAx8tKPzP4+1bdR4H5dvoUPglzjqyXgVgJ8a7GpCdvLOWKL0xTGk8zTBxwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onAC7pY2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34534606A31A;
	Fri, 30 Oct 2026 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onAC7pY2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8872D1F000C1;
	Fri, 30 Oct 2026 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399794;
	bh=YLaBLrq9vqUBBHrjdJ20lZM/hS2ppHBmmfX7lg9P4M0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=onAC7pY2WPg4c8N3OkVvgPRHjbOzc0Ngk9dcTpyjaBMM9SBFyWgaw5PDtQmvWR4s7
	 Qgis9DjB2r4k+FyS9aL3U7zLYq4nQjGyZ9lHEoUOBjjx2j5WtDptGBaoKro1W/+HOo
	 Rckj7u8kzMlyHeGbl/gvZWbSonPWVCoiD5gfMgUuyWfElZMu6Ff/zlpa11fvRQ2hQL
	 1+hLKANDa3lffxDg29X5Ex1T3djG5tMJb5c8efN+tX/J2e2Z6sK8pi7/lKaky2b3+R
	 mt3pUJ4zPfrBWHYO1tGhkgZY7sOOUFdm2QCsi5+zTXPlCW1RaJ8I1t7IhKBO99pCYJ
	 NEp1r6H1s9jZA==
Date: Fri, 30 Oct 2026 15:36:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: James Chapman <jchapman@katalix.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] l2tp: ppp: remove unused backlog callback
Message-ID: <20261030153633.062ba178@kernel.org>
In-Reply-To: <20261030070003.2590-1-qingfang.deng@linux.dev>
References: <20261030070003.2590-1-qingfang.deng@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 15:00:03 +0800 Qingfang Deng wrote:
> PPPoL2TP sessions receive packets through pppol2tp_recv(), which passes
> packets directly to PPP or queues them on sk_receive_queue. No receive
> path queues packets on the session socket backlog or calls
> sk_receive_skb() with that socket, so pppol2tp_backlog_recv() is unused.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

