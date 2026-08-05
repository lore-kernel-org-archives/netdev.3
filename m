Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061DF32A3FF
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890710; cv=none; b=ZJyaKnDYVJ9qp1L1youpfwQQpIdsZZaF3feuBMyMP4KrC1WOUxEstSLO3mA3P+qTbC7HJXJSbnFaIkaYRrSU++QluFeG8m5lGsmGbk6cfXvKmOSy8aX/PIZYf63ota0QQWraQfvqyB8gm5KIQPlawQay1+U1ruy4xxwLDeGx6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890710; c=relaxed/simple;
	bh=e8zt5dTjEaHsdcOCDdIJdPeBobzWMJ12MOZR3WVs948=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6sPu5E+QqIyi7iOQBUbLSTZlvXe6wJtLJhly7P6Mo5h2LUnw9UI6D9Ep8tNO3kNVGPnJkOjhE6Qsv3WP+nacwWwHv4AcTXf68pFwnEUrnDN1pmUmMcpR1VfBcJz/U9zqgQ7O1AgIBgHZlMe9wcKvdGDQpLLSsEH0qrFYgzXPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPfFJguK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPfFJguK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AAA1F000E9;
	Wed,  5 Aug 2026 00:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890708;
	bh=ViCSls+ws9Js7Z1q2Xz0ExVrxCR+quT0HcqQ6c15cyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iPfFJguKkuDSYa7BL0+S3FjU7lTPTIWOwqnIWgDQz3x+RVi+d07ilaCFd8+Uufr1O
	 0J+zYc7bee+4I0qwh4qwMS4tTbPyXT1e1QezhJMi+WzaC8DlfQOonU1eaYNA/J7TyE
	 HQ3x4byCEb+HnCUFyiC3/hRBmoLB2xcZu+cqJ38OjYSzfD8yOyjmg/mtcV97Ju7jbv
	 S5HQbhLhjTvQmFkYWr8wA6NwFnzJlS54qxMUhvky85/vOYm7oSSXCn1TKieKb2PjJb
	 OQ6e2pqBlBR5neaUwI5lEWnZ4cG+Krz5DsTLl1sAMW6QM7DJmrEmnh2sqBF91uzDuc
	 ZCTa0zD4SCBDQ==
Date: Tue, 4 Aug 2026 17:45:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nebula Security <vega@nebusec.ai>
Cc: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, bronzed_45_vested@icloud.com
Subject: Re: [PATCH net v3] net: loopback: ensure Ethernet header is linear
 before eth_type_trans
Message-ID: <20260804174508.20c0e505@kernel.org>
In-Reply-To: <CAHYtud34rLPuGq6oSLem3VW8V+YrBBxdi+CRVbiQQZOrsRCOQA@mail.gmail.com>
References: <2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com>
	<20260731175022.18fd8744@kernel.org>
	<CAHYtud34rLPuGq6oSLem3VW8V+YrBBxdi+CRVbiQQZOrsRCOQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 17:08:10 -0700 Nebula Security wrote:
> Sorry for not including the cover letter in this version. Here is the
> root cause analysis and the reproducer. Let me know if this is enough
> or we need to send out a v4 with a complete cover letter.
> 
> The frame is not short in terms of its total skb length. The problem is
> that its linear area becomes shorter than ETH_HLEN before
> loopback_xmit() is invoked.
> 
> The reproducer sends a large non-linear AF_PACKET skb through loopback.
> The loopback egress tc action is executed before the driver's
> ndo_start_xmit callback. TCA_VLAN_ACT_POP_ETH calls skb_eth_pop() there
> and consumes the only ETH_HLEN bytes in the skb's linear area.
> 
> The skb state is approximately:
> 
>   before POP_ETH:
>     skb->len      = 8206
>     skb->data_len = 8192
>     skb_headlen() = 14
> 
>   after POP_ETH:
>     skb->len      = 8192
>     skb->data_len = 8192
>     skb_headlen() = 0
> 
> The skb then continues to loopback_xmit(). eth_type_trans() calls
> __skb_pull(skb, ETH_HLEN), but no bytes are linear at that point, which
> triggers the BUG.

Shouldn't TCA_VLAN_ACT_POP_ETH make sure another header is accessible
then? Are there other ways for something to strip L2 before the frame
reaches the driver?
