Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551591;
	b=IxZwFNq1QiQMQo6RXdwh6ASwghKJmxCsRZMlQexA164Y8j2WYLOJuF941Q5XQU/vPk1s
	 E8KIBNdbcSfYPpPlFk7IUR4Dw057RZhJupRSQ/2Qd9X+kI0+IQgbUhhwe06yqyTG0lN/U
	 xV5SRPXrauDF0MCFgTQAni7d79sQdBdO0zLFmTEnes3u8To5DFLWtFBTXxjoAdkhZfvt2
	 vU1pPfYkuCX6phqy41SHSv8eUVpr3obDla8hbkls7lEi2nvgvhCCr+b7FFB7OPPiGkoPv
	 Uw3INY5zecaKY1HIXCWUVIeWIlKzTytytrYLDF/ANVyqNZ98FKjCkbPa+mDoMG7yjXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551591;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3miW+UELaQXIIU1FExjNvxPdt80IkqVQtDA5m6KCekE=;
	b=VWLfa2srmyGApzwXvF4op/SlIxbRDysmn/u7N8h16zhq6lrbP90G1SoZ5rriaofx0vc2
	 7Jadoo1gN5JMdzs0pS5+9Hs7DRU/gXrtrVuF1kOBG5NL/o7k9hxcVp173e941bARS5cYR
	 plYWs5e7whW0O1f5HBXKKvJcmkyXhvUnKamvwFWKWnZSrPk4oQ46agAYPuypfW8LYEMjq
	 FLwC5CnMA/tnr6+g+bbRHWfyESHNjmXyupLt4N+KaXEL8aox+3Ni1u++inffmRaHPA3hX
	 i620iEWFXCkrsSgnhYUCq2E+no+yOyo18UyHYScp8ZayA+Y/1DUHkjr9iuthqxJXEBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FgpBC/ha";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE88606A319;
	Wed, 21 Oct 2026 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgpBC/ha
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5681F000CB;
	Wed, 21 Oct 2026 02:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551591;
	bh=3miW+UELaQXIIU1FExjNvxPdt80IkqVQtDA5m6KCekE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FgpBC/haNXrAVx6ArnTgIFQZMlJ31jhqBCn+1nUeqPpYbsRejydE4qHj8bBK8gH/p
	 cAw82wk3EmRwMrNwPZqKgyTILx8qTWJF9jlcW5vjATD28V0Kvax69QSxTSuc+ddS28
	 fVtqRWK4KiMswcsU9VO3dwjLV4kFLHP2pd9cgXskUj2tSFUrFItjDIicwWoBx1C2P9
	 Isb/OVvfSy26ZRNxSuAAaJxhrpz46RuNjcxQjGvw75DAZv4QBhtKAWeMFp7xT325eH
	 xeUaNY3gKVflIhVqveHvCOBnx/8oxIZy7UR8oPQxIkKCCwql2NSJIGcnGFtsoCLUqb
	 duh43LIvU0zFA==
Date: Tue, 20 Oct 2026 19:59:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Carlo Szelinsky <github@szelinsky.de>, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, broonie@kernel.org,
 lgirdwood@gmail.com, corey@leavitt.info, kyle.swenson@est.tech,
 horms@kernel.org, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: pse-pd: core fixes ahead of the
 controller notifier
Message-ID: <20261020195949.47d2e9da@kernel.org>
In-Reply-To: <179254921255.330607.5425473501621725490.git-patchwork-notify@kernel.org>
References: <20261018081853.47484-1-github@szelinsky.de>
	<179254921255.330607.5425473501621725490.git-patchwork-notify@kernel.org>
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

On Wed, 21 Oct 2026 02:20:12 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> Here is the summary with links:
>   - [net-next,1/4] net: pse-pd: unlink the controller before freeing its PI data
>     (no matching commit)
>   - [net-next,2/4] net: pse-pd: unwind allocations when controller registration fails
>     (no matching commit)
>   - [net-next,3/4] net: pse-pd: si3474: use dev_err_probe() for controller registration
>     https://git.kernel.org/netdev/net-next/c/569b57762694
>   - [net-next,4/4] net: pse-pd: check the PI vpwr supply before registering the controller
>     (no matching commit)

bot got confused, I applied v2
