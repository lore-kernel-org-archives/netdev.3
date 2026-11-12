Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510011;
	b=i1sq2G23BL7r0VIQPy57JGtUSNIpVm9UEtAxIoEytkePbm2fBIqI0lTOkydB+33TruUv
	 rJwi1i3lg+X3RZA+xz/egma8DR7DmauFOtbmb0FoDS88uShdHQp1ADXTRia7lHPaODdad
	 giDDJn440ii7qILW0z1mrJ53tTfySP4doqeIlpjSXOY3jnNuCAT/6+BBHmEKY+MNmYv7H
	 5M9xWLTFlDoBVxk0aI3d6RiGaNuIXIcY2mvBZqnprP81HBa/J/uwyqyFVwNQsO8pGkwyI
	 NTXw+Y8Q5uNJiS+PZPho0bM/AACBP+6Jb14SyfuJrAPQEOldlIxMJw5DcKu+u73PZlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nvFZZYtUBOqd+jvnlZAEmJCKEVELE6zc9NcNnjAhLMY=;
	b=L3goKuvu9MlMGchDY7mrgnYjn0fSUCAWMWDVlX2JCiEcreQVNvM5Sc1PDFI8bin/9b1b
	 Y1oRIj2IsiaX9dGlHCQF5hE65mPtND5SeQQ1eWKhqdR71lFgfVV3EUmyPc8Uq9PdwVlBw
	 Ne+jUIqmwBNE1wqfpnTZsJwG2EiGmidoCs0bjbNUpZBykneriHxunZcORKTXgiWpaDEUt
	 0JThfhDWODj5wkkYF42GL8DMLKdC2zxECkKzDM1J0iQ1GYdUiJRBNM3b+7SFtlJWMmYiN
	 2c1hrinn5nwjyuNb/A6znYc5uKUjsvLXkUahl2TE848vv1di4Pm9Urx1d65Isbv9Lxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBOLOGNZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4660A3836;
	Thu, 12 Nov 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBOLOGNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733BE1F000C4;
	Thu, 12 Nov 2026 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510010;
	bh=nvFZZYtUBOqd+jvnlZAEmJCKEVELE6zc9NcNnjAhLMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fBOLOGNZOav6TvOj/YtZJ7Uuxz4IH4SxqVvXpKwPvXaAnh/5YpSYR+N5uYB5UE/vX
	 FnPkIMQI9o/oY8fKCrqQ/XUu7DK4kwEbsrsF3GM95lAVzPzAOXzZqnqz7SFNDWcntR
	 MG5xfhxou6tUDC/GzWmZmOuMMZMbt3CJRQ7nCaAiQ9kXPXQ7K8skJb4l8US+zX3rcb
	 NqFNyFUxYadVPeKEhAF3GsuTypNS50TF0329Vwki45655fhCSWW6E9CQJQFSIIvFlO
	 sXreV3LUoHGZGPIvUjuCqi4j8pIi83zVI3U0IDSmuZFLJ/TUPv18e5Xs9vIe2phhZU
	 REcaK6C9NQEZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 657AC3924A5F;
	Thu, 12 Nov 2026 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: usb: cdc_ncm: don't underflow the NDP room
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451000897.594620.2574632461996033695.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 19:00:08 +0000
References: <20261111124156.637661-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <20261111124156.637661-1-xujiahao@cmss.chinamobile.com>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: oliver@neukum.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 12:41:56 +0800 you wrote:
> cdc_ncm_ndp16() and cdc_ncm_ndp32() verify that the new NDP and the
> datagram fit into the NTB with an unsigned subtraction:
> 
> 	if ((ctx->tx_curr_size - skb->len - reserve) < ctx->max_ndp_size)
> 		return NULL;
> 
> Nothing guarantees that skb->len plus the reserve stays below
> tx_curr_size, and when it does not the subtraction wraps around to a
> huge value, the check passes, and the skb_put_zero() of max_ndp_size
> bytes that follows overruns the NTB:
> 
> [...]

Here is the summary with links:
  - [net,v3] net: usb: cdc_ncm: don't underflow the NDP room check
    https://git.kernel.org/netdev/net/c/b507828c7b61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


