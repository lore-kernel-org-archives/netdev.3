Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1D316199;
	Thu, 24 Sep 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215877; cv=none; b=PRCs6odXLEYvKsmRt8CiukrvkfTkZuXwGw2n3lBY6izPw4B1BS66N5TxUIbZHgdPIELH+pU/jR9vGr0gPUeDSuArJxUj/7EiSnLnMOKA3a6eSJWl+IslBLHLJga6wRk0Q0u2S4i3aUIUqbZNZrSzqudnRVIUO9J8FBlZbGftZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215877; c=relaxed/simple;
	bh=vayVn6c/yWEKOLz59uEGF/s5I9V9bUCYI9/xvaCEo/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lbNblOIYXh8Cx6RHu46b1cFOlmpWDC18aHEtor3XaOLdv/hU1iGngYhVSZlMgunuLipSJf5NxQszPm36MclNwH68FvMnBlbIvwpcQzZcSop+WEfwM+1ZIKdalOuD/DSd2gptcpJSSA2wGN6NKGqZs9wJ+QJ6zgGvJpXbANKrZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgTORWnP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgTORWnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFDE1F000FF;
	Thu, 24 Sep 2026 02:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215876;
	bh=5pfHF4Ky0g0kp6Jy1hmPvbQm+o2fdcPOh72dXSPEtS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WgTORWnPXY1pQICJgbi1j1Jdj8kDy3O+pJ8Alwbss1czwW6RtcXiP/NNVfAKqR2en
	 iSfHLieWU6ToH7QtSIZXFxlllIVKvU801KppVIk7qavjecRQEg6WOg1DE4F6H3CGDx
	 BkwgevsOL2Q8OkXy2XbMsdmMfpQ9X6zbqbLiSOoMlHqwz4fBAUH7MnL+5OaGesdhJ5
	 wL6v52sAHGgMzbKBiBNwyNk5NOgA7S14UVcnSigeOwhSr5b6Fh0xEvkFRAsoS8At0c
	 w+Arwe1sXfTPOHB2VB35hd/JU7tlBD3p6npLhXJLOFzZ7KZGCMHZbB98xFlLppVF1c
	 vZvEDXsztDFkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19C0239E9611;
	Thu, 24 Sep 2026 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: realtek-rtl9300: fix RTL931x C22 extended
 page
 selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021580565.1277764.5809608576893655818.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:10:05 +0000
References: <20260918211955.3955777-1-jonas@jonasjelonek.de>
In-Reply-To: <20260918211955.3955777-1-jonas@jonasjelonek.de>
To: Jonas Jelonek <jonas@jonasjelonek.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 markus.stockhausen@gmx.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 21:19:55 +0000 you wrote:
> The RTL931x indirect access engine has a separate nine-bit extended page
> field. The driver leaves it at zero, and otto_emdio_run_cmd() therefore
> programs extended page zero for every Clause 22 transaction. This
> overrides page selection made through PHY register 30, causing accesses
> to private PHY pages to hit extended page zero instead.
> 
> Set the field to its 0x1ff "do not change" value for RTL931x Clause 22
> reads and writes. This preserves extended page selection made through
> PHY register 30 and restores access to its private register pages.
> 
> [...]

Here is the summary with links:
  - [net] net: mdio: realtek-rtl9300: fix RTL931x C22 extended page selection
    https://git.kernel.org/netdev/net/c/89a8a1eef2d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


