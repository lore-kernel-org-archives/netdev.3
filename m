Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36D223DCE
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082209; cv=none; b=CPL6CkyWYhXllYrmtzT2T8f/H7wCSEjfvV6p1CTOnWJUwDINTqo6mRLH8X1ZPQlu8QtbL0BowNSi99ZswdDA3AMFDePEWOA1uf/GN3x42sDjCZNfKhLp02uUEEedfFQnWFP7lii/t8alIN66dRtyfOEZjNVDeKb7IbNX0+p68mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082209; c=relaxed/simple;
	bh=yJVIJ4YS6UmkxQKb9LKEdsSjjzw7jw9gGAX8FKtHuB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NLnN/OmNl8/K4syqz+BEk27oT0L1OhF1hYVGtvVSVzTErBVVDGzw++3Yh+zKDBpnKhzXp+APUGsfAE+A+y2Y3y6huJeDTs7jO9HUg+0+Py3urQZdF/eRUdnczDdyJ1p2Ip1eEsRKaRSmltr0fuWBITed5xFA/SKUxB26YT/PMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCnqQ2eK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCnqQ2eK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94099C116C6;
	Tue,  3 Feb 2026 01:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770082208;
	bh=yJVIJ4YS6UmkxQKb9LKEdsSjjzw7jw9gGAX8FKtHuB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YCnqQ2eKMf9a/XkL3EHXTt2NJqgAGI14BWymwVDVZELXzfEz5CGP7X+SZAjw+4Llu
	 bYaEEN7CkclcIkzZCWTF5i6kOaIL9UVKrliTsFlxEq7y91WcRJkARO4GKPokWYlXql
	 KDlWyWDZSskwGqxzp3fdq8+qozqcjuGWz1+2kuyBiq4Nj6lAwQtq9lbxnn1WWzK3It
	 MFAiju7vlGsXfd9BQYbXtll8X8tSkFkB3LI+038dEj9XRnfU579xVPEARLOw0nz6sf
	 UoqtA7PKlW3eigNs+jV72JJsKvUCHYPoFfCGW8yTy4qME0lkXx91b3iJ6JI5NZIxQu
	 ZBz/XzkMKhJ7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90F013808200;
	Tue,  3 Feb 2026 01:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix stm32 (and potentially others)
 resume
 regression
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008220538.1265245.15446704290450615368.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:30:05 +0000
References: <E1vlujh-00000007Hkw-2p6r@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vlujh-00000007Hkw-2p6r@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, marex@nabladev.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 20:04:57 +0000 you wrote:
> Marek reported that suspending stm32 causes the following errors when
> the interface is administratively down:
> 
> 	$ echo devices > /sys/power/pm_test
> 	$ echo mem > /sys/power/state
> 	...
> 	ck_ker_eth2stp already disabled
> 	...
> 	ck_ker_eth2stp already unprepared
> 	...
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix stm32 (and potentially others) resume regression
    https://git.kernel.org/netdev/net/c/dbbec8c5a79f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


