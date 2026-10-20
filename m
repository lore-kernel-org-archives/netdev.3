Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465212;
	b=wf/kEPZWy7azQhY7oopUuR8XGlkYOKl3sDKof7lKobpopXf3obnniLbvSGDjD47KKsj0
	 EMn1NyEUu7VI+sk9oRRz14U3FyMre0I3YNJQuNIum9UIozi75+3trY+vtAqYd7c/vpd4V
	 kpmL9kTJAhuR0mvf97wKEztdBkEwGLeS9QoQo2Hl7YTciz3cI1dSCE2a9oiJuea7ORONq
	 U016l31FjcOx7+mwDB/J7nlE+u6u3psI69KPPMVKYQiVzPYwGOcqatu2GrGIY2R/BEzEa
	 f0dA5qucwdqRo97tJX3/nuyq6XIoeQoBTcFP/ig/17hnQqdwei24EvKmCp5M6r25Wyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=IMJS6mXGGtY2FRrHHHGMcRbUHVmff4Nc8DOy2VGJQ30=;
	b=SEpzQOy/YtJ9FxKhLkUVovofP6hD6HmjeaTCLad1S9MaW/8Ihaq4nTX9zRdg3gezYN0K
	 HRaYcZEt0yLtC8uHhQoQTho9iRXBy8Tc4W7DpJVZ+rDILGJs2F3Pt5MwM+3X1g/UUpbLw
	 GO9g9VllIPmVnYofPMKTaZIQodVuhqncPuO6INTXh9UoHSjfeJCu4mlodIsM85YRYggm1
	 cD90IUv+7booFjdbaMvqU3CmBdvPGnH542jI/wPpHfQpVjK/N699acp9gqSwaHjxKdFVL
	 2/zCNgFUN8c+P0JpjgtOcUahZuKwjZyy9J67zsPjKFx1SDwnis0EJ/pcGZVAys4wO1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyVMbS7h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793C606A328;
	Tue, 20 Oct 2026 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyVMbS7h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEAF1F000C5;
	Tue, 20 Oct 2026 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465211;
	bh=IMJS6mXGGtY2FRrHHHGMcRbUHVmff4Nc8DOy2VGJQ30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QyVMbS7hmbNJQX3jnvTe2cFrO8yQqaajGdQJ68X4g98WHHJkclEY0YDTTC+fWm62r
	 VyEopVPbF6F9vCO77SwAfQGGnTKcuAm8qQoGqWXNLbT1260fW5F+t/Goqi18RW659m
	 vKAzOMAtQ6C53W6ga1E1PygtAmfZw473DB6WAv/BjZILEj1yFMP9dF7ZtXkONUh3sH
	 yLKEN7/0CZ3GoM4cFR3KHW2Us6R35Fdh1IL5WJTcorJkEHs4SrkSHN/aUKllgaJZrk
	 7W62SbDmmm4V3+St+dtlXWaVUEtlzLL9+kRiKpGQu8ELqIqtEnF2gXg7uNJQjXNPKc
	 /88LbT5XCb2eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44D23924A70;
	Tue, 20 Oct 2026 03:00:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next v16 0/5] net: rnpgbe: Add TX/RX and link status
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179246521027.3454580.12892078954545199148.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 03:00:10 +0000
References: <3B42BE25B3696EAE+20261013022920.63529-1-dong100@mucse.com>
In-Reply-To: <3B42BE25B3696EAE+20261013022920.63529-1-dong100@mucse.com>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 10:29:20 +0800 you wrote:
> Hi maintainers,
> 
> This patch series adds the packet transmission, reception, and link status
> management features to the RNPGBE driver, building upon the previously
> introduced mailbox communication and basic driver infrastructure.
> 
> The series introduces:
> - MSI-X interrupt handling with NAPI support
> - TX path with scatter-gather DMA and completion handling
> - RX path with page pool buffer management
> - Unicast/Multicast filter.
> - Firmware link-event processing and carrier management
> 
> [...]

Here is the summary with links:
  - [net-next,v16,1/5] net: rnpgbe: Add interrupt handling
    https://git.kernel.org/netdev/net-next/c/600efa8e598c
  - [net-next,v16,2/5] net: rnpgbe: Add basic TX packet transmission support
    https://git.kernel.org/netdev/net-next/c/02b5891a50c1
  - [net-next,v16,3/5] net: rnpgbe: Add basic RX data path support
    https://git.kernel.org/netdev/net-next/c/250a6edaea49
  - [net-next,v16,4/5] net: rnpgbe: Add receive mode support
    https://git.kernel.org/netdev/net-next/c/20c17178e192
  - [net-next,v16,5/5] net: rnpgbe: Add link status handling support
    https://git.kernel.org/netdev/net-next/c/92a671d510a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


