Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F531295DB2
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928380; cv=none; b=oGHpyTSh4KaRKbvf0BEFAPUeh9954xPYHONeZQ9crcaaiDd57bSvNx6p4Ybig31SnZjaUOUPXD6C8u9H6iJThzimv4vIPVzFC9ORZZ7pOhSKCNXaVlxezJ3UsKV9+GXNOz7Hm7YZMXRWjrHm/+YgYrDD3VD+qfIt/JBYMk2W5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928380; c=relaxed/simple;
	bh=rO3T6Bj4zsRu72CBNYRH+PyIwOYHWrUgkR8O9BIrFZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lj6YEMEnSoD/gWefom14h2jn2KxYg5W0zqONcwOqg3OMma+iUDVmvTedBweaYUyj1jC9SAYweiG8XW1aJ7f4D+P+Lzr30RgGj2Tax2/OYn361FiOAawigznWhSWqQS34vaLUqL6ZKemvte3yWuA6rL1m8Xnc460wph75w9XlIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV+f4SBo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV+f4SBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6504C4CEEB;
	Thu, 26 Jun 2025 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750928379;
	bh=rO3T6Bj4zsRu72CBNYRH+PyIwOYHWrUgkR8O9BIrFZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FV+f4SBozsbxhtnlnxAsk36BaQibfZ5H7ul67/erqmQtN2Ka14/NID2PuBd8SH7M2
	 x4TZDzqGv/OLqPufZX3acIUxcTJ81qfys2cBXEAfWhxMhHDzO99K/Vf/7IRuZAb6ee
	 ovsw8mWM6eypQDm7ScUZL5NHCj/rDxO7XNEklFTG9QZ2yJ7v3MQ93D9dB4qawM0tGc
	 oZKRBSrhxX33vb020ksdLUVL96cwFdCa+p43t9FJEdIA9FjkDiXMbbtO4L7bTT9I2i
	 fnvaRAOim1Fh63JdHxKefVuPm6GPctnw38g6h3k8Z+Gg/LOeQB7l9HYHMi7GpoOVjP
	 2XyPodEKJlDpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C543A40FCB;
	Thu, 26 Jun 2025 09:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: selftests: fix TCP packet checksum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175092840625.1129579.1703827671352728388.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 09:00:06 +0000
References: <20250624183258.3377740-1-kuba@kernel.org>
In-Reply-To: <20250624183258.3377740-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 o.rempel@pengutronix.de, gerhard@engleder-embedded.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Jun 2025 11:32:58 -0700 you wrote:
> The length in the pseudo header should be the length of the L3 payload
> AKA the L4 header+payload. The selftest code builds the packet from
> the lower layers up, so all the headers are pushed already when it
> constructs L4. We need to subtract the lower layer headers from skb->len.
> 
> Fixes: 3e1e58d64c3d ("net: add generic selftest support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: selftests: fix TCP packet checksum
    https://git.kernel.org/netdev/net/c/8d89661a36dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


