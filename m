Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE862C234B;
	Sat,  7 Mar 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847611; cv=none; b=ox8rh12bAlGkftSBaxsRZFmQ5iEGoEu35Ad/wSZvwjXKHtGIHHiFa7BwsUeDXJ0xZj9ObcIYl57by9j5tP0L5OrU0XFKrp3dn389NauXv8ojpkrFH4egNO8FwVikLQyUVq+oBAgjIaL8GOiCn9f7pjCfDPSOkd2W+Z9SQRVtTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847611; c=relaxed/simple;
	bh=mgMRBhHY0rQ04G43pB4XKXWyiH/QkT6t6BUb4NAq4T4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l8YwBdxpKmZxw7sKhWn1V2w63aha+RmEKvHqRQbULSIjkC+xzTO/jN3vnMvZSjtmHJwRpdCJAxT2Tov0oyefw9K8Zg4bGxcHnWoAvJJ1Y3ZdMCptuTSBJmd98QxCfFpkDFpL91hcQVb+rYbEo5oiSaNvo6f2jlyupNLvhIT4SwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEwJy3oA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEwJy3oA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33291C4CEF7;
	Sat,  7 Mar 2026 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772847611;
	bh=mgMRBhHY0rQ04G43pB4XKXWyiH/QkT6t6BUb4NAq4T4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZEwJy3oArxinktXVjvYFXp7h/PRX/nnavhqD6q7Ad120ICKM/mBI8H9Y4PGzCaItt
	 Z6iWe4jCl6z/P77ygJWhYTYxLzb/E9l54eui8bTZD7HKrEfdhEsN4z2jl1Bs2jhAV6
	 4kEIVhCAoDX+SvFI99GnzhC2mIkMb+GGyrJ2SMVNdondMuZmtFK2yqOSYWd52iQIT7
	 AWGXhv2koJ5rRV3bJb7LScCYaToclQeOSu1ZlwAkGUGDifBjaSXU1pCmuCqcWg9/XS
	 S7+p/6qVYpLLJh8r5fq3UO9BX97Ylj2dxmqk5r0t+nmbN1TcnpJAqd1WH5ngfQcZlI
	 xWs+ijGSHc2Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE4B3808200;
	Sat,  7 Mar 2026 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ncsi: fix skb leak in error paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284761030.119780.6748764252279562099.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 01:40:10 +0000
References: <20260305060656.3357250-1-zhangjian.3032@bytedance.com>
In-Reply-To: <20260305060656.3357250-1-zhangjian.3032@bytedance.com>
To: ByteDance <zhangjian.3032@bytedance.com>
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 joel@jms.id.au, gwshan@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 14:06:55 +0800 you wrote:
> Early return paths in NCSI RX and AEN handlers fail to release
> the received skb, resulting in a memory leak.
> 
> Specifically, ncsi_aen_handler() returns on invalid AEN packets
> without consuming the skb. Similarly, ncsi_rcv_rsp() exits early
> when failing to resolve the NCSI device, response handler, or
> request, leaving the skb unfreed.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ncsi: fix skb leak in error paths
    https://git.kernel.org/netdev/net/c/5c3398a54266

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


