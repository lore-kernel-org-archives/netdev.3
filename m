Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444472;
	b=W4rO/CG3wLr8k0w0m/FrNN3MpPDZbfsPM+WMftMq5QB/0x4AgHAQJ+6hwkQ+1FM46g3Z
	 iMMeWlH8i0wdiJIkOacOHsRsliYtC1pvvBZrrNrnEd+OyK8a5+QDpv6SrPb2QvCB2wY+0
	 UMkVZuCUaJV8sw5fZxuLZVXLx7bsxTZj276IZbJljgogVcu13ULZZcHPPsUvuCleLHEYQ
	 PBxuLgcGmtvWBdzgf8Y4gD+ZY0sHlLBAIZIJDSrtbDa3v7JCTWUIfb1CdINj0CzCYCEbr
	 RnzkIbM/n2xjp13q7sXmcEXT2XnAhmqs9dJZ/jk+HQYWX1/PI96aQlLLqKTQ442LmTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444472;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uTKOSeg4aAvBBM1vll13yP+n+RppAFS5rFjbzOj7VD8=;
	b=tlyUxlHr8bApK5X5XXUY2M+PsTqWn+AMzcknE5sX+D+TdEXijiJTJUefWokmpKRlhrfO
	 pobGHTXW2w4s4jLA6SEBy4fg7f+HntOrm5uTQpVBgI1JWOWgPrtaXr9FsFiLSduCkO/Fa
	 2gN16YOq9+6Q08EJXqKc9CBbG9wUtL+V4Un2wALTsvaNHx6kwQgLeyWsFbrvYKuk466OS
	 3HjKrhmdy4tNqiUGTz261CzAd9uQtmwjLOEp+r0JX262OIECMF1eFOAt+JbZvalYhEtlY
	 Mw3Q5NKwUYqdHVRfW3jPXFDCfYlMx3f+z3rq5gfB86Cwp5CsofRaF/E9vffQjIBwbKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+jfCoPk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84E606BB54;
	Thu, 12 Nov 2026 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+jfCoPk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16CB1F00A05;
	Thu, 12 Nov 2026 00:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444472;
	bh=uTKOSeg4aAvBBM1vll13yP+n+RppAFS5rFjbzOj7VD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q+jfCoPkjYjUKDJnGYffEq0JBEUMsBQoZ33/AnsaDxLopny9QwL4403rcfX1l91/R
	 urDyObVp4tp3dh+aWK+zLvE3/9+75OJXOKjYwlhkKoEhsBjkhGkiToh159/OPKkEre
	 TTFnWgsBXBlq6xxeozFZamCJC1xTjPvaI5qjq30i3ifMpE2VrqxX7IJ9OX3ddOPrUE
	 2Ka29TPCVvcD2ymv4eflHezA4EF1MKHXwFP4VlbebTpM6BFyQrACiZGn/vHNPOXGN2
	 zRZKUTCpFwRx0ibqvNrsei2zJN6Hm2Hy9XtuftrLdnypQjBMLjoc/5rc8avSvoceYh
	 gJ7pu1/Eor8rQ==
Date: Wed, 11 Nov 2026 16:47:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Harry Yoo (Meta)" <harry@kernel.org>
Cc: Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
 <darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>,
 kernel-team@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ena: reuse the whole RX page on 64kB page
 kernels
Message-ID: <20261111164751.5ac643fa@kernel.org>
In-Reply-To: <20261106-ena-rx-reuse-64k-page-v1-1-ac75b20c5de8@kernel.org>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Nov 2026 03:17:11 +0000 Harry Yoo (Meta) wrote:
> This shows up when RX data stays in socket receive queues, as each
> queued skb keeps the whole 64kB page alive while at most 16kB of it
> holds data. On an EC2 t4g.large instance (64kB pages, 8GB memory) with
> 519MB left unread across 64 TCP sockets, RX pages pinned 2869MB of
> memory while the socket layer accounted only 687MB.

I'm not sure you're actually fixing the problem you're describing?
You optimize the memory use but the (unused) tail of the buffer is
still not charged to any skb, is it? Or does it now fit perfectly?

Normally when the page can no longer be chunked up we should charge
the tail to whoever happened to use it last (see the page pool code
which does that).

Either way, you have to respin this on top of Breno's fix which
was applied earlier today.
