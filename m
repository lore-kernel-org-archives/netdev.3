Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAF2FB612;
	Thu,  5 Feb 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313216; cv=none; b=oZR7iYLyCttXrY4SOn3oVeYGsWkb8d6ig+dw5pEoVqyFY3dqo5oTdUxCBXjY/BlGXsco1oMMtmPX0nG6cK1rS0yMLGZfKFJx2RPMGFI12zAAHujlJYCStJdXbWvuXubQMrGZpVe3gHiqT743yVywUdXOaz+pYvyY6pgbzF/h0Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313216; c=relaxed/simple;
	bh=PlcHdDqlGOyoVV/PwNUW7cRCJ2IJFzAj92C8MJ6HqrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KlhxOOnOBSF/+7yOGPnFcFtm9Yltr4//9pIj7LnucLHDES1JEYwzhJO9lLxCCOHZVvbtolCJDp9z8x78FZtiTZHJi6G3VZ7hGQmpNdxcVXEk1xPP93QoZ5AMZZq8zIbJTHkbXHq0YnQc2CYJCoo6VnckF87RCdTrrnhOfY0hagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhIK2MM/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhIK2MM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D56C116D0;
	Thu,  5 Feb 2026 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770313216;
	bh=PlcHdDqlGOyoVV/PwNUW7cRCJ2IJFzAj92C8MJ6HqrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NhIK2MM/FKJsRSf1wVPRCASRwziq9qpHvgaRa7SmsXH9VjtuwPwt5gUlV5TUXm+Xz
	 XkslV/OC7bOdgcdu5XnNDhLnN1zusH261fVj9jivft7BFPwHw6GAvRmxnBvZiCMWoS
	 +/r90Q6CoUCXAHM5APn68uTzZC+BlE5J4QEbtmpGPfmMrK6S6wAisEY7FvbwIV+KBa
	 8CHtvOKErI+swfHIpywk0Bvau1Y+/T8PZDUIHwJ/yMGWd9iJL8ngU/hWcuerhaMG1y
	 IhjbkBAqVmxF5rw/5ZgB8J6SzFNguadKPF/9EnsBxOldLurmdbxMCAQ8Ip9SCFb4lq
	 Oi5ocOrUzolNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8524B3808200;
	Thu,  5 Feb 2026 17:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: imx: fix iMX93 register definitions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177031321407.505259.5073683709420571661.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 17:40:14 +0000
References: <E1vnaGl-00000007i9f-0ZMw@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vnaGl-00000007i9f-0ZMw@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, imx@lists.linux.dev,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com, kernel@pengutronix.de, s.hauer@pengutronix.de,
 shawnguo@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Feb 2026 10:37:59 +0000 you wrote:
> When looking at the iMX93 documentation, the definitions in the driver
> do not correspond with the documentation, which makes the driver
> confusing.
> 
> The driver, for example, re-uses a definition for bit 0 for two
> different registers, where this bit have completely different purposes.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: imx: fix iMX93 register definitions
    https://git.kernel.org/netdev/net-next/c/7e7fcfb0798a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


