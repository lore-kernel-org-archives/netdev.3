Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051DF4BE42B;
	Wed, 30 Sep 2026 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812208; cv=none; b=W9BwvAbbLoFiyev0JnGSfFh8a7WYSZPQLV0CJzbTkdMC+oeuZbLp2P9QyL3P8HR8eOVckUb8AGBeJpl53PTu67ccM4hQT5JRsvMQBsZfTNwJvp9y++tsO1tP3Jry8yeJEf1+hgEuK5mzjq8+VXhH2WHGu3K/C9dptfrmxTdFTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812208; c=relaxed/simple;
	bh=YABDT/G7AnIOX6XwPSRY6sGHjPV589ArQxPiYk5Wfew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D4YFKj5L8ZsJLbaK8DWbzj+6uLL2hVHkertrqwgoJyLdDQMwEnKsbWeycpwKJOeX0UGlMh8yPbQnZpd1lhdCcixnyx+08AaAtZ6ANyxeSUHDlS2FnRm6wHTLLByU90RuhzN4NHolYegs4qblrsnzMc1e4uOQ7aH/OQjUlOkkAuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbk+/I2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbk+/I2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0351F000FF;
	Wed, 30 Sep 2026 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812206;
	bh=w92JaGFf4uzZvmbvWJJ78hy65nXwiRlSFSC0FaeP7Ps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Wbk+/I2QBo6SNZmt0QhpjCXoI7cyNp59C7twTiOtr5EUNUh3M1TA2XbXX8fXEqNZf
	 ht2cP8UzcRnYF1gf/ZYFUaHcUGchstn60y5i9l0+98GtZBfUadCKae4wDvk6c0qcnX
	 HgrpAVeBdAjxU6cG+a8EIFK9NJX3a7c4G7LumdK4777GJlMNaiEhJkMlqOdNLnSJiH
	 XThgpnd5khj4MGsQfPplzaYXdcM/KDP+zNgX+hcq1WcJqYCkpg7S5TdPWTpwh6KjOC
	 Rjh8Zy42LdYI2Q6o2OY3CsGbfWtFa4abhce5YIv8PiuzHyOik7JtMndJ3ViLzKltCK
	 ANc9BcHlbjBDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773A23AA6A68;
	Wed, 30 Sep 2026 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] netpoll: bound the deferred transmit queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081220504.2179181.2494387832805771727.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 23:50:05 +0000
References: <20260925204537.2664119-1-zack.gomez@gmail.com>
In-Reply-To: <20260925204537.2664119-1-zack.gomez@gmail.com>
To: Zack Gomez <zack.gomez@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, leitao@debian.org,
 stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 16:45:37 -0400 you wrote:
> __netpoll_send_skb() parks an skb on npinfo->txq whenever the device
> cannot take it at once, and once the queue is non-empty every later skb
> goes straight there to keep ordering. queue_process() drains it from a
> workqueue and, unlike the direct path, never polls the device for
> completions: when the ring is stopped it backs off HZ/10. Nothing limits
> the queue length.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] netpoll: bound the deferred transmit queue
    https://git.kernel.org/netdev/net-next/c/9433d2f334ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


