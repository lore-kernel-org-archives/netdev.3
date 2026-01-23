Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E4279DC9;
	Fri, 23 Jan 2026 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197810; cv=none; b=LzeUbOHmGX7WbFBn2eiAqPCs0BnXP0mq6fjuvqzHS9SU62jzAqYzb1us/efEL02jUCUnPY+i+c5ofzOjL0hvV6At78kwaaEY/FykImyS/yLcJTta/Qz07msW30mG2rzg6IsJJVguUKAfqIG7MSArdnB4b07QjToHBFMZYApSHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197810; c=relaxed/simple;
	bh=UJm/U09viNPO6TADnsMkNXqoVa6K9mGF05X39w4ODXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4W//w97zWqELqHtY+CpPDqvsrlL2fm+9XNJ/aSmcSDsc4t6ptcfVgHBHQarat0KZFuBJn4Tk5lmEGjxTQxM80p7tJA+1FIwaVZgYFAQkF727TVO3VGLOWK0jMa2CkvC4QsOE54FhrBC/ABCT/zVYqSwElsEPReUkWd229yzr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcRuHqcr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcRuHqcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34500C4CEF1;
	Fri, 23 Jan 2026 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769197810;
	bh=UJm/U09viNPO6TADnsMkNXqoVa6K9mGF05X39w4ODXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YcRuHqcrzsNhoNWXhTQ7Pvmzpg6K+JXAhdymaBK79UexYNp6TTNxO82s474sA4Hq2
	 QFxNj4mtUzNnoK2JvhRp7781UdN45vPs9E+USewjSAIFO5a3PqTsMBdcYO/XXi9aEV
	 CM+/FsoD0BGfo2HVxR1SjCrXUPAS1KWgNqT+0unn35JpUDjxLyD4KctcA7+FcFxw9Z
	 M0s1aLGz7psmZrFGmlzm0JvJ62exiOzmfs0f/v4Smy5aomiySEzenhO9RflBv9ZyU6
	 +kcbnLN/hQP7Nhp+QReqpO2JaHgfIKANkB3is3pGxR6rt3k/TJ6Iv6i+JWovuEze22
	 LkuiKHsES4ZvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4E9003808200;
	Fri, 23 Jan 2026 19:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeon_ep: Fix memory leak in octep_device_setup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176919780485.2695110.15846411261421856680.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 19:50:04 +0000
References: <20260121130551.3717090-1-zilin@seu.edu.cn>
In-Reply-To: <20260121130551.3717090-1-zilin@seu.edu.cn>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: vburru@marvell.com, sedara@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 13:05:51 +0000 you wrote:
> In octep_device_setup(), if octep_ctrl_net_init() fails, the function
> returns directly without unmapping the mapped resources and freeing the
> allocated configuration memory.
> 
> Fix this by jumping to the unsupported_dev label, which performs the
> necessary cleanup. This aligns with the error handling logic of other
> paths in this function.
> 
> [...]

Here is the summary with links:
  - [net] octeon_ep: Fix memory leak in octep_device_setup()
    https://git.kernel.org/netdev/net/c/8016dc5ee19a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


