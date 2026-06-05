Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F433557D;
	Fri,  5 Jun 2026 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624214; cv=none; b=AS/yM0XxsJOtWR6y6H+65zYX+2i5vq06y8iRZ/wsspB1PUhJIe6w9ordGj5N1nkCkeLiugJXzThdjCQdEb/0cO/MDlnsGSPsh7IFMUEu2dPBei8kyo/ScBGEznMP9d1QwtJ29objNqTr6k8K6prMePTw5FUFdjid5kVFmZjoE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624214; c=relaxed/simple;
	bh=uILYhWaXsIqkSmfjHAXT2LKi09l2xBmY1Td7iK2bp9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ROVClE0NmFU6R3ZYdM08+snoN7gkryg2ArEu52uzTF19EPt7fdGffIQzmQKHvLWrAdSC59sYRER6bTGwRj/uk9KJNy7eznJlt6YuFbxQXK1q+Z2aGPUH5lzGCBF4b9hzlHntig9sbRbcW3W45vEsOOc6zFo0uGAc+4/Iwzm8D+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpY4yLmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpY4yLmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3321F00898;
	Fri,  5 Jun 2026 01:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780624209;
	bh=npzZuIrahPpXIMyh0d4mEOB5RFINgqbaV8Faq6AJrpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WpY4yLmk4RsKOjfVYkoANaDLaYamqMfyJAvycgatxMVG9QKMUoSNqtmhz+JmYfYZQ
	 ZBWksaRZoWSiZ7lN5fWdMS5jcOYzTVXX6zHHIlaySJG7MHV++pdMceNPWAP9l3FLLO
	 phXgIRD5hlfzYRfl+hbW5uOU25k6Ft7LMO3VVz8iHW47lpIz6eMNEjYJXSWZViyvi8
	 MtA2MofdHE7jceiNqZRMw2B0qV67kumnZ4zAp+c0v6KxBuUEKVpCXJXAUMaJnHzrh5
	 7UDXWFNClErL/zF0tQIqnFHIg2/BpF5Hgvxbzh3GobOPO+VBHRqzwFmH4YCQSKyCtd
	 w8pBUy8yDTApg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5EE573930A8B;
	Fri,  5 Jun 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/dns_resolver: use kasprintf + kmemdup_nul
 to
 simplify dns_query
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062421007.3099818.3448654067097447224.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:50:10 +0000
References: <20260602071343.962830-2-thorsten.blum@linux.dev>
In-Reply-To: <20260602071343.962830-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, brauner@kernel.org, tim.bird@sony.com,
 amir73il@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 09:13:41 +0200 you wrote:
> Use kasprintf() for descriptions with a query type and kmemdup_nul()
> otherwise to simplify dns_query().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Reverse xmas tree (Jakub)
> - v1: https://lore.kernel.org/lkml/20260528222030.1655010-2-thorsten.blum@linux.dev/
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/dns_resolver: use kasprintf + kmemdup_nul to simplify dns_query
    https://git.kernel.org/netdev/net-next/c/6ce66868d1a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


