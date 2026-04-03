Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055E36402C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253633; cv=none; b=sFb2Rm+FXWMq/s5SDAUlIjVYsEpguAVR60zWGpOLj6mlBpgXM3z9DF0y34lqYxjTRXGe9PWpsxUq04hXSQ1Avepa01Br+JYd0Kw8EQuIwSUWV6stFjai7upZPtQECsQvzN3kmUjimVgdoDmElNwwiiJiEYLsbtfehRum42K8xWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253633; c=relaxed/simple;
	bh=wqBcj2NMo48zn6on1bQ6OXkjU7pnXL1t6MDijusiVNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pr0wN3ZHaCisuuvvDd5awAQkNhB+nQVSRhBulkoJ3pcl69AzusuvEcCIj5sav2tVdglotHClbSlnJfInDITB8G2IsypIVHjdNlpY9yCHI/OXFCwCP/L7n9uxbxZjMx8xrw6AEReUYnlrJ0sxR1hcdQKObItmWNTNx4gz4HOIlpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU+rq/eX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU+rq/eX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC73EC19423;
	Fri,  3 Apr 2026 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775253633;
	bh=wqBcj2NMo48zn6on1bQ6OXkjU7pnXL1t6MDijusiVNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uU+rq/eXmgglHQcKCI1ywp0mU9Ob5B82DEnV7AxVsucTyM+qWQSYJFLTi6PfBXA8T
	 BOwEoCSqSvkg2w/D8EvzvqYvOPciwFY1Rouf4nFQy5UrWS6eTjLxm8PnBUwjPA0egY
	 3raCmCDRPekUQuylQZkuywCwwrCjV0QCI1IziHuxXHYxhE9sK/nSHCX6/aXbmm8q9W
	 fet8woaqtAUchELyI7t8Kg5ccBCMHhrm98unuIu5FaxcoZBLdjT3RE4Chr6hDcTWsn
	 fxh9QJS0ADpOS6edURs5Ktf15BHSHbzFsqV2jem4FEYNC3WQT12GmFurLLG7XBpVVY
	 /Z2yAEiHv8nJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F533809A14;
	Fri,  3 Apr 2026 22:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: sched: act_csum: validate nested VLAN
 headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525361453.1466030.17187869530232713242.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:00:14 +0000
References: 
 <22df2fcb49f410203eafa5d97963dd36089f4ecf.1774892775.git.caoruide123@gmail.com>
In-Reply-To: 
 <22df2fcb49f410203eafa5d97963dd36089f4ecf.1774892775.git.caoruide123@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, elibr@mellanox.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn,
 enjou1224z@gmail.com, caoruide123@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 22:46:20 +0800 you wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> tcf_csum_act() walks nested VLAN headers directly from skb->data when an
> skb still carries in-payload VLAN tags. The current code reads
> vlan->h_vlan_encapsulated_proto and then pulls VLAN_HLEN bytes without
> first ensuring that the full VLAN header is present in the linear area.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: sched: act_csum: validate nested VLAN headers
    https://git.kernel.org/netdev/net/c/c842743d073b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


