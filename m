Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8BA3D73;
	Fri, 21 Aug 2026 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271062; cv=none; b=UU8Dsp+3jHA9pvpXuLL58odpyshDTTCmC9gSrtstSTGosVJj4vhFQYKVz/3C1KrFZlRJR/tQ3jE+v9zxS7zf0RdLLK00Hw6OIS3FqsdXcyz+lz9X9TXf2d08tbhsjPCZrgh+bU3sfqREzLWH9+NB89owUlhDFQ6sOyLUwJWdVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271062; c=relaxed/simple;
	bh=eZUt8fPjYa1+DVmXshZcLojC+m0a0P2PjBRc5ew1EuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OMVsiDA3YQuAoShPMldAjlpDmRZnqUAzbv3CKESmZDCOghK4RQZwSQvkgQFXFUarmALCQCjJVpGRrDFENAR7x+z651Is8YWP4V5gOnsGtWCB29lvxzYHGbmkvZeMImSAj7wCW8M1QaAMF2aA1bicA+tQFwQjFDeNUW2wQtu5ASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJJ3HaHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJJ3HaHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ACD1F000E9;
	Fri, 21 Aug 2026 00:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787271060;
	bh=t760hyY492cbUB8YsdFB9IQdPK8aCKhgkoFldCVEzfw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cJJ3HaHTWtqX7DK/XgH1EYmv9t7SmWsVcZaVg04NPuMx63lLjQek8GPyb2JE+K2AO
	 DstdhMKeny2LRWSEBEO/BgIyyl9SsZVrtIUalY/IfXjm4YMfP9fN3adxhTKpIOviyX
	 YxWZ6aT+ex6BdHhRg0mARvHCD6jGchIcGuCO9Sv+GIVKQhhHSM8KCUaE666YHhsflE
	 boAd/R9Zn1OZBNuwlYHMwZWp9k8wvds9qQtFVPvYqdXKl42yPo4udrWpp/z41QlCq7
	 LQP6IuXRmICFEnd4y+x1ib1PRYNQ9LgLvOpz402gdB0wHh+BEV6hjw02+GlJ+27aAa
	 e632Gnqq/lYag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1985D3924472;
	Fri, 21 Aug 2026 00:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: cdc_ncm: add Apple MacBook Pro USB product ID
 0x1902
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178727101062.546801.1501934338708694048.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 00:10:10 +0000
References: <20260816040426.57132-1-mehrdad@signeen.com>
In-Reply-To: <20260816040426.57132-1-mehrdad@signeen.com>
To: Mehrdad Afshari <mehrdad@signeen.com>
Cc: oliver@neukum.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 21:04:26 -0700 you wrote:
> The cdc_devs[] quirk table special-cases the Mac CDC-NCM private
> interface personality only for USB product ID 0x1905.
> Some MacBook Pro models (e.g. M1 Max) connected over a
> USB4/Thunderbolt 3/4 cable to a host whose Thunderbolt controller
> lacks PCIe tunneling support (no NHI function, USB4-only mode)
> present themselves with product ID 0x1902 instead,
> using the same descriptor layout as 0x1905: a Communications
> control interface with zero endpoints (no interrupt/status endpoint)
> paired with a CDC Data interface, at
> interface numbers 0 and 2.
> 
> [...]

Here is the summary with links:
  - net: usb: cdc_ncm: add Apple MacBook Pro USB product ID 0x1902
    https://git.kernel.org/netdev/net/c/746fc0787f61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


