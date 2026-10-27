Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140827;
	b=PquXO85xHXB++DUjyNprstGBkl3+r7VEE6+OxwxB0TIXOF1Lhmwv5ouzWQcJDO0tWDY8
	 PnzC9EfV8Z81syrvIU2cZ/ogaOKaQFpccZax85ruuTPWfC7ZrKTkef4gSgTFgpK4foA69
	 WbIHsnnbtONf9i676ua0mfh2famRRNE/gYJr+GBWT0EUUY5YfxCYzTywvmfeOqKT0wlB+
	 sVwfiugnV4z7YAwRRnMA6dd3uPFgj+hhULHtO1lybWDlXl/1olP+4D79k61C7nDr2OVBm
	 /MkLwGoetddCQHMKvuPruIniYEqqxtA1hOcjnL0D2Lgyuvq3No/mdwacuY0NVvosZYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140827;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yDDXDdTksahjrevZXicQEYxdvExKZLj2RyNMKHVmqso=;
	b=umCb0adMwRomBytK2K+z3ztl9g5ZhXPB9HxFEkV28wMar/NHf72Ni7Zi7x/Injz/RPv9
	 xTBl3xJg02wO8zvH3VUzv5pcZ0LFw0pB/0MK5iyPbfV04JwXVSMYHJmTCI/BULkwEK/fF
	 dFR4DfxdrTBQ9RI63pUoMnrXDwxwqTbZt+P1ssefXfAZPSgem1Bjf2m/VTlY5aQpF4kVH
	 mWPAwlk46Ig6tnrGIQRxD+njaJfgZ8bvwS2Zw18MKxQK6nmRoPo2SWphkCJHPyMolNBg9
	 BwUdq5DsFOYg7zUso+wpWpdL58uRg3Wk6Ps2H1313vQu7IZnu98UmWaZ3p9VwoFHFig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdUsGMrA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB464606A32F
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdUsGMrA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F321F031E8;
	Tue, 27 Oct 2026 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140826;
	bh=yDDXDdTksahjrevZXicQEYxdvExKZLj2RyNMKHVmqso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CdUsGMrAqm9PDXQ70MEsthLNUygdmjvqByP8Gh3leQ+rBc0crf+TcGMgU8QCTxjFm
	 ZLEy+06mpU02mBIR/qaeJW7rSLCxSrfYdEhINQ1nUR/x/ITKLzPXO0BbbabsSFyMuW
	 9fN3IhHqs9UH2BGuW/6N6O9Op66ZZA8psb0mY7HKxwKajrZfGhqLplewyB3nlH5KzK
	 rKZeVcdK3WbpxFNTO5Vi8qFTAkQpxlrgqRNO8nJZUnF42YUznANMdYKXgsLqUKZ7mY
	 ZBVcd5UER6V5FD2H/NudC5+Y7/Cer1Qq95z2tRc4nrP31/FMRCcXbAnYcQSW+UwaTk
	 CGsILlP/y05Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815163AA940B;
	Tue, 27 Oct 2026 22:40:26 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: limit priority VLAN untag depth
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314082509.370091.14688479327825567155.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 22:40:25 +0000
References: <20261024004835.17862-1-user148783812897@gmail.com>
In-Reply-To: <20261024004835.17862-1-user148783812897@gmail.com>
To: Kamil Sawicki <user148783812897@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Oct 2026 20:48:35 -0400 you wrote:
> The priority VLAN receive path can repeatedly remove VID 0 tags and retry
> packet processing. Unlike the read-only VLAN protocol parser, this path has
> no limit on the number of nested tags it consumes.
> 
> Each skb_vlan_untag() advances skb->data and resets header offsets. The
> offsets are stored in 16-bit fields. With enough nested tags, the network
> or transport offset can wrap. A later protocol handler can then derive a
> large pull length from the wrapped offsets and access memory outside the
> skb allocation.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: limit priority VLAN untag depth
    https://git.kernel.org/netdev/net/c/d3ff07f5acc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


