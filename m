Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D546EF84;
	Tue, 18 Aug 2026 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058664; cv=none; b=kp4k3QfJFvaDXhYP/8LT8UI+2s56LOl74rhYCX4BAP4wkBXFMxzRQ1o0oJ31vkzWgz7uGLw9QMv08560xfqLDegXsOkGh5+o7k6LbHFcYrLMoSwz+510eljlEzun5MlJnMOEir+/Qwh09tz1Lbsux+BPc9Hu03UJrqZjD6fBPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058664; c=relaxed/simple;
	bh=uqQtUCupYGMVRJS9NKjgtFacb/uAfUJNkD7gR9gQ4hU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=syNoBVhj5H5T3K80CINo510et0EIAKTz+LSAoR5Wns7d2HgqfDV6TY5+bLOlXlfRiGZWBjOYwwacKNBfUaJP9sSGrKBuqxvgT6Pv3/hl7LhBj632IH875izNTqt/j/55h4pUCoxhIWargIee4+0fymUtjIi5K31F7atXN2/annE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQFht4oK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQFht4oK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5281F000E9;
	Tue, 18 Aug 2026 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058662;
	bh=VSiYwIGotnwNwFpHjW7RPv8wk8MFI1vPhOw103KsZLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EQFht4oKHYeIxhCqid8jSb+98ueue4N+cz9aHSQrd3XOoOiL9PvJQ2P45OMA4/Vex
	 jC2wUyNFEEmQcJKUegbQXQOITWHB3IFQX5O8sM4j/2FJKpgeRoHC7PJt1TJ8lI6L1c
	 Pwuxv8FmTLZwYG/MoMGGws2dDz2UVOEK2tfhV2K2wL0fEXEDb+tcyBaszOwQa/NVMs
	 YLF88QLhvbGKGiiKBjx/zj1s5e4HwwlRbaRmXD4og48/Kdf8QyteM0nuzsX2Whb+3h
	 zgqLs7gjpyv5PKdj9BnEmL/lN5yZVKWgRe5IKeqYhgCXyfPFwPu+wWwSESTLeQfLpF
	 jsDICTjALazQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938B53926661;
	Tue, 18 Aug 2026 13:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v14 0/4] net: pse-pd: add Realtek PSE MCU support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178705861416.2079194.11658601794072677702.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 13:10:14 +0000
References: <20260813222036.873930-1-jelonek.jonas@gmail.com>
In-Reply-To: <20260813222036.873930-1-jelonek.jonas@gmail.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, bjorn@mork.no,
 sander@svanheule.net

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Aug 2026 22:20:31 +0000 you wrote:
> This series adds a PSE-PD driver for the microcontroller (MCU) that
> fronts the PSE silicon on a range of managed switches, together with its
> DT binding.
> 
> Hardware model
> ==============
> 
> [...]

Here is the summary with links:
  - [net-next,v14,1/4] dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
    https://git.kernel.org/netdev/net-next/c/368990e9f6c6
  - [net-next,v14,2/4] net: pse-pd: add Realtek PSE MCU core
    https://git.kernel.org/netdev/net-next/c/44566e614d84
  - [net-next,v14,3/4] net: pse-pd: realtek-pse-mcu: add I2C transport
    https://git.kernel.org/netdev/net-next/c/4c088d9eb32f
  - [net-next,v14,4/4] net: pse-pd: realtek-pse-mcu: add UART transport
    https://git.kernel.org/netdev/net-next/c/5cc93d989749

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


