Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBC26A0DD;
	Sat,  6 Jun 2026 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711828; cv=none; b=HK3XAJLyVh7as68iWNP/ITEl7al7FTnoj8nY3hcUapGsftmxvhrsrq+qs8zHaSwaWcKbcXuHVrxDtGYnJUclgsJH2IkVrF9GqPhfY3pyYdcI6+w/7No0bpm+Ldx1T+2ZGETgmjbi/f7Nwme9XOwS7QwMgqrNwciAG8gi5wS3NbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711828; c=relaxed/simple;
	bh=3oET53BtoKjeKejtdmFfbuVC8CFcPGGTFD5nOUfdbAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oZ4te+a3foh0Dt2R533CqaN+C/0gdpLXZR3HOJ6RtINgsw33EkQMu+EmQl399SmYXPdZMopbeJlLWZWIfwg+pHV7jHaFUacl8m67HR2fMlZ48yPekFtw49p+h8aFlHmqbkdI9bHwp8tEovcaXq3T6Z2fL0E2tQ6+KPwyaMQju7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfEVPsW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfEVPsW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B5F1F00893;
	Sat,  6 Jun 2026 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780711825;
	bh=kMLca7nfWY9RizQfqQEviPppjRfuz0UhEGaO/4cVevs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TfEVPsW2JDPmWdJxiQloAJKrWYcn3IRGJ6yfNo8yR35J7dWRDFDbOaS5l/Duu393s
	 r61sP4XE9OxzRF3L2TvMvtCPVtG0h5Ra9cTPqTrSsZLOyLQ0ml2m9dpVfmL0CfEFm2
	 ywl+PjirMHj7sUS/bAKuVauTatFDdExPcn7dEzpqCn8XPOTKQbnnPdnoy7pi5GDfOV
	 v8PZ01Lu+CQBfaf+Kgl0lmFfCpfTjvsYzFAwvAAqwLgVyALQXaEEnPk+QGNkWTqEzd
	 zk7o8yl41w5La+mgN8zQGebVZHqlF8dqKb2QvKyoPSPTablFn0J9XqamR5xjFK8duD
	 OnilhwFDZ9uWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E43930A9C;
	Sat,  6 Jun 2026 02:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/6] net: airoha: Support multiple net_devices
 connected to the same GDM port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071182563.3993660.16859528929943768907.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 02:10:25 +0000
References: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
In-Reply-To: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ansuelsmth@gmail.com, benjamin.larsson@genexis.eu,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, xuegang.lu@airoha.com,
 madhur.agrawal@airoha.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 03 Jun 2026 08:00:14 +0200 you wrote:
> EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
> manages the traffic in a TDM manner. As a result multiple net_devices can
> connect to the same GDM{3,4} port and there is a theoretical "1:n"
> relation between GDM ports and net_devices.
> 
>            ┌─────────────────────────────────┐
>            │                                 │    ┌──────┐
>            │                         P1 GDM1 ├────►MT7530│
>            │                                 │    └──────┘
>            │                                 │      ETH0 (DSA conduit)
>            │                                 │
>            │              PSE/FE             │
>            │                                 │
>            │                                 │
>            │                                 │    ┌─────┐
>            │                         P0 CDM1 ├────►QDMA0│
>            │  P4                     P9 GDM4 │    └─────┘
>            └──┬─────────────────────────┬────┘
>               │                         │
>            ┌──▼──┐                 ┌────▼────┐
>            │ PPE │                 │   ARB   │
>            └─────┘                 └─┬─────┬─┘
>                                      │     │
>                                   ┌──▼──┐┌─▼───┐
>                                   │ ETH ││ USB │
>                                   └─────┘└─────┘
>                                    ETH1   ETH2
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/6] dt-bindings: net: airoha: Add GDM port ethernet child node
    https://git.kernel.org/netdev/net-next/c/a4597204b681
  - [net-next,v9,2/6] net: airoha: Remove private net_device pointer in airoha_gdm_dev struct
    https://git.kernel.org/netdev/net-next/c/4408f5206809
  - [net-next,v9,3/6] net: airoha: Support multiple net_devices for a single FE GDM port
    https://git.kernel.org/netdev/net-next/c/a9c2ca61fec7
  - [net-next,v9,4/6] net: airoha: Do not stop GDM port if it is shared
    https://git.kernel.org/netdev/net-next/c/99b9d095d71e
  - [net-next,v9,5/6] net: airoha: Introduce WAN device flag
    https://git.kernel.org/netdev/net-next/c/7758cb462ff7
  - [net-next,v9,6/6] net: airoha: Support multiple LAN/WAN interfaces for hw MAC address configuration
    https://git.kernel.org/netdev/net-next/c/ef2aee987174

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


