Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034644;
	b=BwH/4nyo2rYeUd8lptdypgTS50vWy6u1NwJrQ0aB1PyNvWKdRlXkaugVZwp6ga1aAZpp
	 2yUhnAZcS7sDCq0s8KFa4saM8FQlydxg/x2M2XXHjSWD3IQXGZDnXb+1FirfTZEis9b46
	 yedcd0wb8GHDSeSrTPSxsyCWJf2U1wY+oU0KC8WQt2Aah4L8AcVJnaSVtjTyzGaoVb4ND
	 2S4aQW9S7XGeYKMlnMglaZ25Yg4wjOqoWbbWt2hoScTytM7S4GLtNfuMBZNTTQML3Isuy
	 oizRpt/SbYfnaUjBq0g+hlpKzxc4l/jiTIMkWHaY7ezyXfzDK853IPb9zLsgV1O8mng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034644;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=epdRLgbapYMRA4ir25N+P6Qr0N6BbX3gxt7GqKIcd6c=;
	b=2ip8tneiKTzYavTmUSWP/KOb+wHR18dleWKiCCLOqgeipcMNcNHHJOQSwaC+HGBRu72N
	 c4K48dQIPH+WxEAe+4D4BXfDIeVP1M/gjjyPsDZ79/L1cUW4I1n9iF6jp7gTggbxN+L/q
	 X+iCwJLnP3yAwccGfawlgjMsPCDvZ6GcsgdjPrvaE1GFMecrPaYQL9hHGSsxQfzJEoJVE
	 BYcXjncAlk/P0c5WTG8/Sg6dqLoxAdY5cTM5XeT2isAOQOCuWbtnLg4c4ey6nutxOJmzB
	 t6DYdRhtevukfKqccwsIkwBLw2xcAtxrEc8+s56jt3euw011JEFLdEdUO2Q6sFvJPFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dpu3tG7S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14596606A31A;
	Mon, 26 Oct 2026 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dpu3tG7S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD6B1F01825;
	Mon, 26 Oct 2026 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793034643;
	bh=epdRLgbapYMRA4ir25N+P6Qr0N6BbX3gxt7GqKIcd6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dpu3tG7ShVanJ39uB4XgafwFk5q1QNmxSM6CmjXEHU6TTw3lnif1eUv5qzrZmFUKS
	 a9SQmMKkPIin/v0K/+GF93LuMI9ylV2D5wFE1jhqimEMZyBfUmmadRo4yfvsLA9tx5
	 FUYBakHibnwc3c23g0IKGtg1yjTGma9oPcM98/S4gKJkjzoet/CcXMsIY1C58vwQVo
	 ok+jnxaFl6dbGjILM+9x3MyxIDYRnTHCob1oZUU8AgA74rWSeezzoB7xmbU7rZJw/3
	 uJTdfDzZDJ3bQ7KmDWv264at3MHd/1u5D2WJQzGaCPv0Ok2k4BzbVN6vS62B9+QQ7t
	 Ag7mZU+reI+vg==
Date: Mon, 26 Oct 2026 17:10:39 +0000
From: Simon Horman <horms@kernel.org>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 8390: fix kernel-doc warning for __ei_tx_timeout
Message-ID: <20261026171039.GG257209@horms.kernel.org>
References: <20261022084046.214725-1-ayush37735@gmail.com>
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
In-Reply-To: <20261022084046.214725-1-ayush37735@gmail.com>

On Thu, Oct 22, 2026 at 02:10:46PM +0530, Ayush Yaduvanshi wrote:

A description and your Signed-off-by needs to go here.

> ---
>  drivers/net/ethernet/8390/lib8390.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

But, more importantly, this is an orphaned driver, and:

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject
