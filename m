Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17DF3C062F;
	Mon, 20 Jul 2026 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533237; cv=none; b=rrCFKmHS18uPJN1XI+ibT24VKaW+5VCNKD6Evz7c3iZ5HBAKxVP9nIzTPM7u2F0G1OvN60n/3DzEL3ROqw/jdg+2vBW45Tbk0mZtzhGMNE8kICOEcsYnHDmRtFgyIufYGACgxfavAjHiZ5BsmDuwgLremp08R4IwJ9yjUWqD0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533237; c=relaxed/simple;
	bh=XXv594fIuUQM4N4wFMBfCOnjc9yu3vYBSjxO8f6Si74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ieEYs5MyDnKdoJUwz05jKdiggND7IC0CnJ/YRr1F+YgpS3MTNWGh0BWPB5o3txA/ZF1OkvRHA9Vk3skVzlkc/EeNys+ic71YR6RK0XPBqNUaLmlo9KIO9N8YYS6vzDkXBL9rLA+CHDI4h1tb92jMNfICIh7AXH7zmIVKuiIrgUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFK7fOwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFK7fOwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D971F000E9;
	Mon, 20 Jul 2026 07:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784533234;
	bh=vTIADCR7j2MklTbBN5FLnH/r6v+/v6/4VwEQbeqoWfs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BFK7fOwvKcUdaInaSVsBA5yCOYorESxyQNPAykCm+webmAP/jvy6wXbgwZclPrxNV
	 yFGrrSmNgtCMdZwasQHJINeH9pwPP9lhUI69/eNoWoZcM9coJGJu/3RJMgLBvPVKES
	 00xwEYOpfFTLUJDOCH9Rzt8065wQD9pzbHedKAsIp1gHXp6RIBQfFk0Kc84gxmO/Lr
	 IatqqmPRvOa7HEopiSknm9z1eYbi0NRmA84KZMbmMpEFpqt4xHhwJhZLM5y7TkimrS
	 Td18VBFwx7dLlYea1a8RAt83/ppRlrejy7hwyEFsBGRGNjjGpNZ1kbmIes2x10+uos
	 MmNoxmNHqeHyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ADD3811A43;
	Mon, 20 Jul 2026 07:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: at803x: Use a helper to check for phy
 reset existence
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178453320539.3394436.16798178808296677838.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 07:40:05 +0000
References: <20260715101355.88536-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260715101355.88536-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-msm@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 15 Jul 2026 12:13:54 +0200 you wrote:
> The at803x family of devices are subjected to an errata that requires
> hard-reseting the PHY upon link change.
> 
> That can only work if there's a physical reset line wired to the PHY,
> which the driver checks by looking if there's a reset GPIO configured
> for the MDIO device.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: at803x: Use a helper to check for phy reset existence
    https://git.kernel.org/netdev/net-next/c/285fd588859f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


