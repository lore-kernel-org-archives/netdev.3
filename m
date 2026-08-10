Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECC3B38B5;
	Mon, 10 Aug 2026 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403458; cv=none; b=CHF0ZVTKAIU6wTP4xv3ZhUNU/MItTqCdO1jzVIAPlVw33cod0CcljGfWazf58RMI4y4nnWrQwtXlWr4tUlnIv6XTznbbjK2QmZQ9Qxd32pKrk01/Dv/BkM+7/mXadq3Hc7TqjtYidN3wRCxKYgtea4ot1PnBFNG30sbLYDDAWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403458; c=relaxed/simple;
	bh=yIMjyW2T6ozpUqDPLad3cUn6IHYTcUuwgdTF1hEPHGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t7e8ieJSOuZV2PvtqASEv8OzByFa194R44HvWN5QfHMeUERKHamJL20v9mv9Icogke+Gj1ZaPy3r2UK4GQlWuJ09WSvZ0kP9xjhTw/mpYTPW5SPrQ46erCyBFfskkLrCeWBbKA0nwur2A+DqBb0JUjnZ9EX3CG/leuDoRcJ/J04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJpkY9Pm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJpkY9Pm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E79E1F000E9;
	Mon, 10 Aug 2026 23:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786403456;
	bh=aPIC8I5JVXxEpd+fU/fI2HV6kBHj2EEsDQDD5amz98Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MJpkY9PmgBQIniKnN4pTyGatBGpN2PP80WarqC8ekL8rdb+7K9tPONJGrHwUU7qBB
	 A6b8dZF/vdWsRMliwJar0txa1ydYzi6T6WH5Y8FG5RBas9dqL2PjCEoeqM4h8wmg15
	 JIcF3x/w+QyiHGWAZMV3W6eTc1aq3JIZovhp01pjjdA1LgUkdKm1i/mqUKq3y8MgMX
	 aRUH/lJaEs5/rXUZd9L0YMxOc4/5+4vCOQUxPKBJvbaIsm5PksZWQkJ5bDrzzlIXHB
	 IOxteLRU77ER1ZeOfgTA//2RO/BUEysgehVJ0eXQov7hJSjSBPbHX9RffbwVcfLanA
	 uay3nNgeR+VFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568A03926265;
	Mon, 10 Aug 2026 23:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet
 PHY driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640341314.247552.8840471155139826338.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:10:13 +0000
References: <20260805085540.452260-1-a.shimko.dev@gmail.com>
In-Reply-To: <20260805085540.452260-1-a.shimko.dev@gmail.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, maxime.chevallier@bootlin.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 11:55:37 +0300 you wrote:
> Hello,
> 
> This series adds support for the DAPU Telecom DAP8211R(I) Gigabit
> Ethernet PHY, commonly used in enterprise and industrial networking
> applications. The PHY supports 10/100/1000 Mbps operation with RGMII
> interface and includes features such as IEEE 802.3az Energy Efficient
> Ethernet, IEEE 1588 SyncE.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] dt-bindings: vendor-prefixes: add Guangdong Dapu Telecom Co., Ltd.
    https://git.kernel.org/netdev/net-next/c/9e0cd2906c90
  - [net-next,v6,2/3] dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
    https://git.kernel.org/netdev/net-next/c/0a5a6487aecf
  - [net-next,v6,3/3] net: phy: add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
    https://git.kernel.org/netdev/net-next/c/d90265e75584

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


