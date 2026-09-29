Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F10229CE9;
	Tue, 29 Sep 2026 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640089; cv=none; b=jvgHOzmdGV2S0iHpXXeiDNpvT04REaSqKbQK85D02Q5RSPh/xl/4J9/JWqwjqz6Bb71YegojT66hjFOuH+7KqhTkFxfE912+pdG0fToe1Jmrx0R5lQohsRWV8WMHzM1VGYxt7vuyYLb+OjVe/5a+c/mdGVNfolVvoMv77tOqn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640089; c=relaxed/simple;
	bh=e/xgFaenQnWSKQoguTiKDz/FBKjh/BR421qowvLfL48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RCSlkKH+q3orQ4gU/k1weYVRmVKUNIS/SkicT1P34hmatcFRqdUHdVLz7EnX0wB+dl6gdWuv0/a68cJ5XEshSvSSBxbtlQqnAV4lC8OGalXb6BgbJsGB79AsKXs+pUCQFFo8bEz6fu5v2jbXFp13LXF+JiFNGpLuPsbm7RPSR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PALq4FMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PALq4FMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0F51F000FF;
	Tue, 29 Sep 2026 00:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640088;
	bh=mUvKujSeBTuGDWuLxfPM4RRXqVA2zzdGSNqciw3nWG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PALq4FMAm9EpwouJGcyk5uNDzOadQtKFXttpmeuZ1yyBhAcQdqfGsjfUlaBAh5Yyt
	 YZCz8DoGi0MNimJkZjEN4xkhczDG0czkdh57A68PSN/h7iVH3KjPvXGVek7ZAgTlrM
	 BpFXEofDTsLN2GXaO9ZfEZIKdP/l0upCmbLAGiZZaToSINOny27aWCt0SQ00oM8zIZ
	 BBsCgLzwn5iJISpCZ7yha2Ym278SEBDVcZbuOV4ju7wiPGY8EEhUYGe99RNMV4Bfg4
	 TkkV4tRM4dZPR36Gj2KHZRuGekmZlVNWBuQoStVvTNJjh8pfrK1NSHp5dMaYy3x7AM
	 YSz6FlMhDto9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09FF3924FE4;
	Tue, 29 Sep 2026 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: broadcom: Couple of minor changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064001238.182825.15168110483572588045.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 00:00:12 +0000
References: <20260922222525.3992167-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260922222525.3992167-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 15:25:23 -0700 you wrote:
> The first change makes sure there is proper reference counting handling
> in case of error/removal for the bcmsysport driver.
> 
> The second change removes duplicates definitions in the ASP2 driver.
> 
> Florian Fainelli (2):
>   net: systemport: Fix missing phy-handle parsing for non-fixed PHYs
>   net: bcmasp: remove duplicate MDA filter register definitions
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: systemport: Fix missing phy-handle parsing for non-fixed PHYs
    https://git.kernel.org/netdev/net-next/c/5277d2c55286
  - [net-next,2/2] net: bcmasp: remove duplicate MDA filter register definitions
    https://git.kernel.org/netdev/net-next/c/78cccb00ec16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


