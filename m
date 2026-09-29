Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D137AA9F
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726001; cv=none; b=IgDHa+8x8U4Dx/+DotFKfIpZCgXTILPeeHcoBr9lXmp6EMxuy+L6urv0O3aKne5+s4P/kYw84u5FMrxV10WQDrqceqkR0fsQ0NHjMg7N5+2jVoXgOl/62uXG8KqNlHLkzR/+xLqQjFoJVYX3x9nnK+mPowtrBWsGIvJezD6JVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726001; c=relaxed/simple;
	bh=CAQrP7GSn9Xetm+sS4ieiiNIIP40DUIQmHvOiqCPGWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwCm28RUazsq1ja/3z/P1a6ufCOmU36QZlNKMUMrQR++TfZwtfOqsWexKk7vaoTfSlrWtCYbainZqpK7AsbGgLfi3UXpnqX3pM49mT6EphbaJ/iW796yC5ck3Uz2dXFpy/XdcPUpUu4NnftL6RItiU+5PAz0JdLkyARoQRjaWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5XSlwAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5XSlwAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF8C1F000FF;
	Tue, 29 Sep 2026 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790725999;
	bh=W6cc9jKzm8HirL1R1ZSHmbeUpUlSQiYiCy8XKvQvu3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S5XSlwAaP0SSZjjeieq9rlah78KQEOD/MjdVmyCWLYQdshY5Sq9RY2FIOUsN7eZH0
	 MIRwdJ0BYDTckQYEPaKwpsor7oFydv+6hvQ7RxM4bt7m1fyzcZrhILsniAB3nkye0q
	 JfKCfT8WECYDbac4oLaD7ZxcKNorZQYYhcRRVJjZpqtv7uaTLTdmwtvwGciH9W2mnS
	 AYneiJywtG4kdS2CsHpGL5V5egZjM6MQB8Xtk7IGBPIycCMdsKqua9taZv3MjtUQ8T
	 cKDrhqom+KHxWJhajzUYb9SeYcSBtxpLO40fGl3Sm7vpX+NCo74Bp9TbkxTOG5G4J2
	 9o62fgyTzTctg==
Date: Tue, 29 Sep 2026 16:53:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@kernel.org
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 net] tcp: preserve timestamps across receive queue
 collapse
Message-ID: <20260929165318.6690d427@kernel.org>
In-Reply-To: <20260924152529.5689-1-kerneljasonxing@gmail.com>
References: <20260924152529.5689-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 23:25:29 +0800 Jason Xing wrote:
> When tcp_collapse() rebuilds skbs under memory pressure, the copy
> process doesn't include the right tstamp and hwtstamp from the
> old skb. And memcpy(nskb->cb, skb->cb, ...) copies has_rxtstamp,
> but nskb->tstamp and hwtstamps are left at zero, so
> tcp_recv_timestamp() ends up emitting no cmsg at all.
> 
> In net timestamping case, if such an skb happens to be the last
> one consumed in a recvmsg() call, the application receives no RX
> timestamp for that call.
> 
> Fix this by copying both tstamp and hwtstamp of the last skb to
> the new skb, matching tcp_try_coalesce()/tcp_add_backlog().
> 
> Note that the has_rxtstamp flag can still be inherited through
> the cb memcpy from an skb that contributes no bytes (fully covered
> skb left in the ofo tree by the tcp_ooo_try_coalesce() ->
> coalesce_done path), so set TCP_SKB_CB(nskb)->has_rxtstamp to false
> which makes the new block the only place setting it.
> 
> Fixes: 98aaa913b4ed ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE to TCP recvmsg")
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
> V3
> Link: https://lore.kernel.org/all/20260917132742.87117-1-kerneljasonxing@gmail.com/
> 1. revise the commit message with more accurate description (Eric)
> 2. fix a corner case (where a skb can contribute no bytes if OOO happens)
>    spotted by AI and Eric

Looks good now, Eric?
https://lore.kernel.org/all/20260924152529.5689-1-kerneljasonxing@gmail.com/

(Jason, please see net for the up-to-date email addr for Eric)
