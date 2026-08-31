Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D137DEB6;
	Mon, 31 Aug 2026 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788219359; cv=none; b=TbvHjm/myT09TMx8y7aiI4xEqJKQt4J5LmFUTuDBDjY2uog/qXKrigZCVtqJ1vzD1qsCGcOBE7fAzDlGmcyZ9KKPo0XMlhW/FH3GLVUrtYjWseQ7q6ZZRXT27Eyfk5i8IaTOwmpw2R7Vuva0mwb0kMi5oycLrlIQ1leQtoEaj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788219359; c=relaxed/simple;
	bh=5Kh15TIQ4q2oO9fggjqmUmr9jrHg5Tvqycn+erZTbTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMaMT8KmaHyWKKAz/a5MZn37SaI7/X0WrFU8WxoWxX8VmAMY3DXXorUAYzAOTdMhjSzqZcTrRtUhgVorvwpGQigblFGEYOHvfBbppCofgpJdsETziWIFNndH8clwKw9pfFpI9tU+x89ZB6K/BJPHujXnSkU6HwNyGQmNDoej7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Suzkvii6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Suzkvii6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1F21F000E9;
	Mon, 31 Aug 2026 23:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788219358;
	bh=ELc74BelTUW/4ZB4DxoWxenDsLGFXeMjBoTFPOu58ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Suzkvii6euSCJ2Z2TCWN+D/3JUDEzDn0VNpWK9ERnkeQrdH3psLlUawGjTKx0Qm9R
	 Kz6FuxSlHA3yjvZxpMYutQVHr8XVTYfX+yHl9NeFD4rAFH88I6YfkICI/80U0eGxnP
	 7H2yxWCBDXPrQJNBcKyIm7x6GDzvwu6c9asO6vN+TWw4j72yBkF7RZm8JJPaRFOWSE
	 bTkcBg6o/QfWEs7XAoLdj7YDoL6WX0RPPEaAI89X+4EkOJbskwiroGBzcT7Hyv1MEP
	 qMYbOVuG1xw8X4210rMVhslBItBJSUm/teSX4Su2HRxFowarDwbuLaRgDHtIPPHu03
	 jn9po3nQ3o2Yw==
Date: Mon, 31 Aug 2026 16:35:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>, edumazet@google.com, kuniyu@google.com
Cc: davem@davemloft.net, pabeni@redhat.com, ncardwell@google.com,
 dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 willemb@google.com, andrew+netdev@lunn.ch, kees@kernel.org,
 jiayuan.chen@linux.dev, kerneljasonxing@gmail.com, ij@kernel.org,
 martin.lau@kernel.org, shakeel.butt@linux.dev, matttbe@kernel.org,
 martineau@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/8] net: fixes for requests completing on a
 socket that no longer listens
Message-ID: <20260831163556.54f89805@kernel.org>
In-Reply-To: <20260824033331.1084971-1-imv4bel@gmail.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 12:32:44 +0900 Hyunwoo Kim wrote:
> connect(AF_UNSPEC) and listen() move a socket back and forth between
> listener and active session. IPV6_ADDRFORM on top of that turns an
> AF_INET6 socket into an AF_INET one.
> 
> Two things follow. One is that what the socket had before the change is
> left behind: requests still in the ehash, and parent fields a child
> inherits. The other is that the socket is used while it is changing.
> tcp_check_req() does not hold the listener lock, and tcp_v{4,6}_rcv()
> reads sk_state twice without it on the listener path.
> 
> Patch 2 is neither. After a reuseport migration the listener that counted
> a request and the listener the count is decremented on are not the same.
> It goes with patch 3 because patch 3 needs it. Nothing ever resets that
> count, so patch 3 on its own has a check that can be bypassed.

No reviews? Are people getting tired of the disconnect bugs?

Hyunwoo Kim, can any of the fixes be simplified if we move more
cleanup / responsibility to the disconnect path? Patch 6 perhaps?
