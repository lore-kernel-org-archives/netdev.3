Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C23248893;
	Fri, 16 Oct 2026 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113607; cv=none; b=onpBVWrIt8q4I6muk5N6T2IEtVj1I5xCwfnv+Q0YCY4fQtZuZxkNcmIAXewiaXVKjlSBTbpqSCspJgPHsZZNQ5inqq7LW7AKCe9LshOi1Zn6DEtDxHRN6vjxBk6jxDwdbxqKODh3pNuDjKRtXufF1V22SHNosUmw6BPQ3Ys07FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113607; c=relaxed/simple;
	bh=F/FpGGk1c8Njgax8WatdW1t4F5Y4bKv4AJ3zJgQaY1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=do5KzFJY0irzD6YTSpslNgwalxG//1r//viX4TT6JhdG+CyRuep2P7cyBJBo6knGXM1MM4aAm+iTi/W59ymE+9ysfmkV/I2ENT70tfzeNqVjQOCdcs/jTGmixe8mpLMV/yu5St27uLoxl7joWL25cY4mlRjcsM12VznvoazBac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/lLfeD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/lLfeD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8EC1F000C4;
	Fri, 16 Oct 2026 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792113605;
	bh=PyCVItRzs2XDe0jGFa4+KC+tsAIz0jT+ejacaK3FGFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D/lLfeD9OZ44mT2tp2dMd4CHe1FyxcJmuosDUaZ2ZyZN3avaM9CKXKZNPlOeAybMD
	 oZk4m0K7Sd1NoB1nfUTwCXDnD3Klnc6n0+HIp7nEhEBHPgEhCbWfQ/0LDK2o1IF3gJ
	 U3/xU3TbKJ6/6KS1hk7Rvdo3GtTszMitSW9+BrqGjiZ6moiG/NowHBrH8J/yCiYUAQ
	 v6Qg/CIT+wNxGZ2KWxnTt6zDksvhlG49iWP0+LaJU5Nxi8q00rT18I2IrHFZrHGeky
	 Ux7rD7BHv8nIbExmqEi7nHx+wxiMBUKMTAve7uj802qoRnkT30n8xJwlHdKu43XPC9
	 u/yDTq6MRUU/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B495C3808209;
	Fri, 16 Oct 2026 01:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: marvell: add LED support for
 88E1116R
 PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211360427.4193708.3061340075824746062.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:20:04 +0000
References: <179165733751.2921261.13784246298385245617@mail.ru>
In-Reply-To: <179165733751.2921261.13784246298385245617@mail.ru>
To: Konstantin Meshkov <skyline@mail.ru>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, olek2@wp.pl, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 21:35:37 +0300 you wrote:
> The Marvell 88E1116R PHY (used on the D-Link DNS-325) exposes its LEDs
> through the same page 3 register 0x10 LED control layout as the 88E1318S.
> Wire up the existing 88E1318S LED handlers in the 88E1116R driver entry
> so the PHY LEDs can be described in the device tree and driven through
> the LED trigger API with hardware offload.
> 
> Tested on a D-Link DNS-325 (88E1116R): both PHY LEDs are registered and
> hardware-offloaded.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: marvell: add LED support for 88E1116R PHY
    https://git.kernel.org/netdev/net-next/c/ce7db1caaa68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


