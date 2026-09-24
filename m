Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DBE4A5EC7
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265491; cv=none; b=HyTiCCEz88vsHqEUg4Xz1p6ZJj8f6BDMGS87KKNIE55pUNeoV5eHJCzDeXeN/1c8AMLgmOcfgyXKRYzcJi4fAEyJ0XIjJdIlX2/nMhYS5agvfyKfGadUOgi7WJRSRogea7wI4MxnGUN3yzE1TTm4ce0QFFYE9FeO/L9TA4jtCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265491; c=relaxed/simple;
	bh=AxDn+6oHUCM/PBX4vV0dEs2xGJjrOYVkVu95+m4OYKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unGfEUFZ0JWOtN7qUADPdu7w0fWADiX8OH9WmS02RLxLGBJw/Qqdj44Yzstp3zquOrXFgHDqeDtzAEc58rl9UCTMRlQACG0N/2LuYSi+3WQbiYTPufuboFzVsSA/r7Chostg1PPmB00NqaFetK5n/8p8GYPex6yUW5kUow4sgfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9wFOu1m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9wFOu1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1861F000FF;
	Thu, 24 Sep 2026 15:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265490;
	bh=+sddf25TAMWsek0oiN5AxWvw+9Mw/+ToiPHuEFGh6uU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N9wFOu1mUPCMBRwxcVZn1woHrA723O9KnBIzPUBW6TKwlgA9Wi9P2Owle6NHbn6TW
	 QXKYtYi1aUAyLDNJpqQEJNLLy4v78UB40AvWLC0SvVNDjWb9mqDmwRrxrNMmHm6vvy
	 /Mi/gDMRIZvvxYsY30KhGVRXcW47mdgmWNVYTd8mY5sf8wn2iyY94YAQvw83EBX8RF
	 HNYiaB9lG5R7Ma/01Wpk1P//Oxi28EcltGU9l3iLnFJch51Yf/CwyTVoYGdMmAZhJj
	 0Pw++hYXT/41/zytDuFbCA2COyWfjVpjnZ0CY3gEuhMCKLUso0UjV3VudKxyLKcxDF
	 5LTdYoO0gwjCQ==
Date: Thu, 24 Sep 2026 08:58:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Myeonghun
 Pak <mhun512@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: ethernet: cortina: Use page_pool for
 Gemini RX buffers
Message-ID: <20260924085809.7baae343@kernel.org>
In-Reply-To: <CAD++jLn_3CS92uSenowXOk+WidorPQKDHy6qQsG-z9xMOv_-og@mail.gmail.com>
References: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org>
	<20260923182830.4f9ddc2a@kernel.org>
	<CAD++jLn_3CS92uSenowXOk+WidorPQKDHy6qQsG-z9xMOv_-og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 09:40:24 +0200 Linus Walleij wrote:
> > > Move the Gemini RX buffer management to a parent-owned page_pool.  
> >
> > TBH sounds like weird piece of HW. IDK if we want to burden the generic
> > page pool code with weird, 20+ yo drivers+HW :/ Well, I know that
> > I definitely don't, I don't know if others agree :)  
> 
> The current AI reviews actively encourages people to go and fix
> really old bugs,  or code that hasn't seen a lot of love in recent
> years, pre-existing issues you know.
> 
> That's how the patch came about that this patch is a "let's do it
> properly in that case" reply to:
> https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/
> 
> We have had, for years, a debug print in this driver:
> 
>                 /* Freeq pointers are one page off */
>                 gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
>                 if (!gpage) {
>                         dev_err(geth->dev, "could not find page\n");
>                         continue;
> 
> and it seems this patch set actually finally fixes that bug that was
> bugging me (heh) for years and years.
> 
> So there is a bit of incentive to actually fix it.
> 
> (I also have actual users of the code, it's not therapeutic coding.)

Understood, but none of this really necessitate the page pool.
Supporting weird drivers makes it much harder for us to create
reasonable uAPI and protect these things with fine-granularity
locks.
