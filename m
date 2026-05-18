Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE8288C2F
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147612; cv=none; b=PYGeOzodfaQD2qPSXPxD2s1Kfew+I4BfDkowR9VvxMmMrXop/IOcz7+ajDkq7dcKcIavbKu+f/TzBpWhpb2RbNsc07bzTwJjR+YwqInQKFLqVnz+syVLdrC/hiYhs9o2QR4IH2Hm/+oRpIlUlmCpb1R67r0FIopQPz2ehIGYgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147612; c=relaxed/simple;
	bh=ZUcdPgcixFOAKhT3lijqWeNjPrGYtWJZJMNizMoeJ7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FkGHGQpnKu8eoaLK4lVTHUlAvU1BlSLhWwjgBkLHm7VVE0YJAv7A79SFCWJhIaTtbraMjBKpUOJdRdsiBJpjjOwgoHWpB9PBMsHOJGf/F1OZjiKRHC932KUXh/qUvK2Zr66JU5owqYZ0+8vuJYluDU0VBVsSoo88vqDdO0lRtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dmp/bm07; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dmp/bm07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38880C2BCB7;
	Mon, 18 May 2026 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147612;
	bh=ZUcdPgcixFOAKhT3lijqWeNjPrGYtWJZJMNizMoeJ7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dmp/bm07YRLhTqAxRAj+Uh1WUGzuI3e11R2zXlCSVp/xJb1nuWkjnGAQFDSl7cxqW
	 FEQpCy1gVlJyOiIMcVuRdjnl3IX4cJ+14TVj1Npjbjr8z5OdKf7uSo9yEvIDyZhlnH
	 MXlO/NGAV+FtzZRv0O5eD5sbCdr6BIRmV07SKIX5D8hpnJmkfNC+Tl2CJjLazxQs9P
	 4jsoGnD6muvxJHlxFoc0O/1DlB+M43tDKejGkdmWFUWARzxBpQGHXIKV/O/AS7/9mh
	 vHuUKwkbMVnceTRlo2PmFMPuA3Vln0gZmTeW2Yx4aQIBOoSabvVk/5nfqoTx5f3Y4t
	 3Pc3wGPBeP8Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B2D3930CBF;
	Mon, 18 May 2026 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: appletalk: fix NULL pointer dereference in
 aarp_send_ddp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177914762338.2012201.13609103218137112848.git-patchwork-notify@kernel.org>
Date: Mon, 18 May 2026 23:40:23 +0000
References: <20260514123806.3085961-3-bestswngs@gmail.com>
In-Reply-To: <20260514123806.3085961-3-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kees@kernel.org, netdev@vger.kernel.org,
 xmei5@asu.edu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 05:38:08 -0700 you wrote:
> aarp_send_ddp() calls atalk_find_dev_addr(dev) in the LocalTalk fast
> path without checking for NULL. When the device has no AppleTalk
> interface configured (dev->atalk_ptr == NULL), this leads to a NULL
> pointer dereference at the at->s_net access.
> 
>  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>  RIP: 0010:aarp_send_ddp (net/appletalk/aarp.c:552 (discriminator 2))
>  Call Trace:
>   <TASK>
>   atalk_sendmsg (net/appletalk/ddp.c:1715)
>   __sys_sendto (net/socket.c:2265 (discriminator 1))
>   __x64_sys_sendto (net/socket.c:2272)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
> [...]

Here is the summary with links:
  - [net] net: appletalk: fix NULL pointer dereference in aarp_send_ddp()
    https://git.kernel.org/netdev/net/c/9e7f36ab5b7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


