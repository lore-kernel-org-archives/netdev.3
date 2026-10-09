Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF33AFD17;
	Fri,  9 Oct 2026 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791504007; cv=none; b=gyM/QbOFUJOHBhxauUydVmT83zjyltHXo9WUL0KumNXdpJ9P0sF2ckve36xn0GJNrQReXPHzX5vtMAcOXJcxtbcw47a3wTzoja5AWEobYHbknplHO9VGwcaKiq54NnbVTqPxd9utVhm6e2a91XiaaLK+3+luPhU2E/7J4d5nqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791504007; c=relaxed/simple;
	bh=s1H60i9Qvk+ggMMNxCfsNPfP3stKfum2xj3JfYng3vk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZVUEd7BXXoyLB4DlCNxUznsEQuc0CTXX44cGiemBbADY5XpCTNxaMEKRP673FGbIbiuAfgulN6UG68EHSmMflUZvo5duU/FeF+cd4WBtTtN0ltuBj+PGzmrQu37tQ86u4mxr5NJT4DUBtsbk1CbEol+JbXpZO40czEb4R/tEitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzMSzywK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzMSzywK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDE71F000FF;
	Fri,  9 Oct 2026 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791504006;
	bh=P6di03+4xELN2QIOrq+pZCLUwqA8jCrKtCnDPoq7fe4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XzMSzywKv7CFD133+Q+Bmos5IfHEzH3O0JyWRBcItlaa5JpFJVadfrnLl3VoijtPO
	 CVhTvphzKIP9ATw9y8at2BUF4nX00XW6p0vle/30OkxYphoIKkdGF8W/hcRPoR9y++
	 839cMpVJFS9Ogf/bQX8EXwZ2HuaO2AHXqvPVARN6Jz8iP4NBxB/h+l8WDwgLwqNlSq
	 KonxGBIOzPW8OrOGou1v7m7/8ar4lTzQqzW18haOwWKHd0ejLDX/sWjp4LbsoYyvT0
	 E/Qjg2iExhIh04ktpSF2w8qqjCsJf61nPhBPUC+zdv/wxsc10LU5k7DxcInKkUOPMp
	 BGIhWh3jENimA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15E3380AA60;
	Fri,  9 Oct 2026 00:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: 3ad: remove unused TX state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179150400477.486235.219670306765871289.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 00:00:04 +0000
References: <20261006103207.68974-1-timur.stukan.linux@gmail.com>
In-Reply-To: <20261006103207.68974-1-timur.stukan.linux@gmail.com>
To: Timur Stukan <timur.stukan.linux@gmail.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, fmancera@suse.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Oct 2026 13:32:07 +0300 you wrote:
> The sm_tx_state field of struct port and tx_states_t enum
> were introduced in the initial 802.3ad implementation but
> have never had any users.
> The TX machine uses ntt and sm_tx_timer_counter instead.
> 
> Remove them.
> 
> [...]

Here is the summary with links:
  - [net-next] bonding: 3ad: remove unused TX state
    https://git.kernel.org/netdev/net-next/c/9823271dbe1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


