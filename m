Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49833A256B
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644002; cv=none; b=WcAZItjHYj65qDSnakn9mpwhTRyafHkV5Nqgpl1EBLMysEP0pVY2j6nxKQp3IxWuJumletlGZuLGn/LaQFDRr5MQQFBm5oBSGs5zNw4ol0eXB0BI3gUXHnfr+SC4a2EPRTQr7+PCh8Eo7+SQz5nnXGfa8m7ebtskCLjBOrsyh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644002; c=relaxed/simple;
	bh=lLLV4GZVdWHB+PFC7+PErUWf6Jr4HoHhUNv1lODe+aA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hmKOdtEh8sZE+/Wn1TCDSTWGBII9bEz6VKF7oWoIO8TpW2MBHjy9conRolGTSim73ikbaODxsR0LqyIxBD5+jVwBFdkIXz75LW5iqukt3ssV+2J7IoXTHn2eGkT/zbchtBwh2rjJFsN9Quergj/8XYDgvuGABWszILSZhRf/2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLi8MPMM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLi8MPMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C55DC2BCC7;
	Wed, 13 May 2026 03:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778644002;
	bh=lLLV4GZVdWHB+PFC7+PErUWf6Jr4HoHhUNv1lODe+aA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DLi8MPMMhLxIfGUhbQ7vUcQxCCUNVDhNgetIp9QfhzCyeYxciw4koZCPGQaKsQWBm
	 FdcTraWZ3Ijt744rkpE+zP144lkDoWEdRvBf/Dxk23xEiRvaQmWZr4M82brRmZJAuF
	 jj4FgdgOjGz92hC6BpM8HCMW8Q89FDlJU6FeEeofDqSpHX+uLefb97OZzsUrTsuncY
	 vLhiR0Gy+hAG59Ro0Ww22QxeZE1BxrGvwbv73NrTEFL9JkGA1NhhOGMuTrn6ovArox
	 kNL1rDd0R66A7yYPFEgK0B6KXHTw7KwI9W9dS5Z/6WV6WXp15RETzNspz7Fxg0uov/
	 ho8HUck2MCMuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD103822D60;
	Wed, 13 May 2026 03:45:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: use IP_OUTNOROUTES drop reason
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864394798.3173643.8934700558237549763.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:47 +0000
References: <20260511072310.1094859-1-edumazet@google.com>
In-Reply-To: <20260511072310.1094859-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 May 2026 07:23:07 +0000 you wrote:
> First patch changes sk_skb_reason_drop() sock to be const.
> 
> Second and last patch add SKB_DROP_REASON_IP_OUTNOROUTES
> to both tcp_v6_send_response() and inet6_csk_xmit().
> 
> Eric Dumazet (3):
>   net: constify sk_skb_reason_drop() sock parameter
>   tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
>   ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] net: constify sk_skb_reason_drop() sock parameter
    https://git.kernel.org/netdev/net-next/c/5c4b709b5fc1
  - [v2,net-next,2/3] tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
    https://git.kernel.org/netdev/net-next/c/254084223f93
  - [v2,net-next,3/3] ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()
    https://git.kernel.org/netdev/net-next/c/4a64f9732577

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


