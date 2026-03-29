Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2328371;
	Sun, 29 Mar 2026 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820441; cv=none; b=pSYtWLk63g1PLT969xVTjBetyMZWoPjCEd1U0HwiXaBOIq7PydTi7D0nCc1uR9rrPw/GW7OjUTHUM5QJ2b4BV9F8dWRxNXP6ceEAl7C0+GXasjG3cKliL3i3xrvFhodhfcMK30SkheywEjmfxH7pF5mU0100fVs3rgpIVRKUEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820441; c=relaxed/simple;
	bh=wA+EDlJ6JUvCxOllog4OoAGX0iRVxsyIxXS8mYHtD0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tX851TRjv5wf1qNHHWfKERYsWUabmyWmO+0vab9A5cWyNNQarg/l5k4eQV/TmrpfT6AF5qd3GGkyLmEO1DdhkuAsW2rpFDDFVyeHSC6hSHfYBlmU68jGb15A3pKMfh6saS9sJ1v4cDYOaqyS8t1UZZPPlII8rqc/iDLJ0Pge7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT8B6RYO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT8B6RYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02282C116C6;
	Sun, 29 Mar 2026 21:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774820441;
	bh=wA+EDlJ6JUvCxOllog4OoAGX0iRVxsyIxXS8mYHtD0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DT8B6RYOKmFQgr+jsyKNWNMcnqhT3ieWMDSL8fmwSEEHflxJQcKh3k0QuMLp9qPFt
	 WftpNt2ex0AJEj62cR+7/JHD9g0E8+g+ZQYkvDhmfg6L0U1hjbm6rNPc5e/E+UQ30q
	 7+6LFCum8zPnGzKlQXlt1ou7aoJthvEVrFPp1mH/W//sF9BfohqJTXBXM+Zv9CdYWK
	 1nvf7wEgmt5FB63DPOeTVpzN25G0tjYJAYe76/MkQR9raiHYb0P5Q5Ou7CHmpeZKZL
	 4kQpJ8pM0dj/qDDI2mIXOzH+Sn4O7j2J5XHbV/n4VqNAz39TmIQDLlIEyJlLT/nKBK
	 AtMxG07QPxR3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0113930012;
	Sun, 29 Mar 2026 21:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/14] macb usrio/tsu patches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177482042554.472023.12757157452690281696.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 21:40:25 +0000
References: <20260325-unsterile-flail-4c7729750dc4@spud>
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, conor.dooley@microchip.com,
 Valentina.FernandezAlanis@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 daire.mcnamara@microchip.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, richardcochran@gmail.com,
 samuel.holland@sifive.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 dave.stevenson@raspberrypi.com, sean.anderson@linux.dev,
 vineeth.karumanchi@amd.com, abin.joseph@amd.com, theo.lebrun@bootlin.com,
 Ryan.Wanner@microchip.com, haokexin@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Mar 2026 16:28:04 +0000 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey folks,
> 
> At the very least, it'd be good of the soc vendor folks could check
> their platforms and see if their usrio stuff actually lines up with what
> the driver currently calls "macb_default_usrio". Ours didn't and it was
> a nasty surprise.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/14] Revert "net: macb: Clean up the .usrio settings in macb_config instances"
    https://git.kernel.org/netdev/net-next/c/8ccf062c6770
  - [net-next,v5,02/14] net: macb: rename macb_default_usrio to at91_default_usrio as not all platforms have mii mode control in usrio
    https://git.kernel.org/netdev/net-next/c/a17871778ee2
  - [net-next,v5,03/14] net: macb: split USRIO_HAS_CLKEN capability in two
    https://git.kernel.org/netdev/net-next/c/039f185a0060
  - [net-next,v5,04/14] dt-bindings: net: cdns,macb: replace cdns,refclk-ext with cdns,refclk-source
    https://git.kernel.org/netdev/net-next/c/dfa36d7e860c
  - [net-next,v5,05/14] net: macb: rework usrio refclk selection code
    https://git.kernel.org/netdev/net-next/c/6c5b565d7d41
  - [net-next,v5,06/14] net: macb: np4 doesn't need a usrio pointer
    https://git.kernel.org/netdev/net-next/c/826cbe636e10
  - [net-next,v5,07/14] net: macb: add mpfs specific usrio configuration
    https://git.kernel.org/netdev/net-next/c/c711311d6ba3
  - [net-next,v5,08/14] net: macb: warn on pclk use as a tsu_clk fallback
    https://git.kernel.org/netdev/net-next/c/3fe13d858f83
  - [net-next,v5,09/14] net: macb: clean up tsu clk rate acquisition
    https://git.kernel.org/netdev/net-next/c/b698a1e397ab
  - [net-next,v5,10/14] dt-bindings: net: macb: add property indicating timer adjust mode
    https://git.kernel.org/netdev/net-next/c/09a6164a4f1d
  - [net-next,v5,11/14] net: macb: timer adjust mode is not supported
    https://git.kernel.org/netdev/net-next/c/41adda8764fd
  - [net-next,v5,12/14] net: macb: runtime detect MACB_CAPS_USRIO_DISABLED
    https://git.kernel.org/netdev/net-next/c/47c86c463612
  - [net-next,v5,13/14] net: macb: set MACB_CAPS_USRIO_DISABLED if no usrio config is provided
    https://git.kernel.org/netdev/net-next/c/32fc6a9f6e75
  - [net-next,v5,14/14] net: macb: drop usrio pointer on EyeQ5 config
    https://git.kernel.org/netdev/net-next/c/cd1082a96f9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


