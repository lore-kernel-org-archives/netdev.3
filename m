Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F88233D9E;
	Tue, 28 Apr 2026 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341054; cv=none; b=ajJgXe7AaQo+v9SEa4VR8KLXQgqg1ZAGbSrfa60wlM74p4UaYQs7L/9lIzsqz25d0COfYFONxFzapbBgdgPS6LbwCV0eZ5oZTVja9zlE8+WXkbBjKlkOx5ft5IgHvxMLp1vbijzgFVjVFyBDmEsWrhxJ9FD9FFShf9Q/Qcfk8ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341054; c=relaxed/simple;
	bh=dDm56LrY1wnMkVZXn1HuuqbwzFQXkvyAteKdtIHrhko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZbJHCmdU7byNSyOegvYXTD/lBohuhEXjPUi2+KyYMOPwtL8jNfKlvLIIi8U4rrpXDAlx59wA7etM79b65HRA9BeseLq1lqRkSdvrYRHoyE0Rj1m+Z511Va/MvB/GqhwboeNdw4HW0xCRVH+5zQFNfVburtX2TMUfkQcdfWRID3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY5hc1jt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY5hc1jt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C5C19425;
	Tue, 28 Apr 2026 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777341054;
	bh=dDm56LrY1wnMkVZXn1HuuqbwzFQXkvyAteKdtIHrhko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MY5hc1jtmcqYxsu2f/msV3fGJe/WR2rmPew4V80As56oxxj3LgjaN3UeRS06Gbu7E
	 NmkGfOkkkJXITUpgUAG7NypmVh84REfNm2aqLd5we/2+QlAAJ62m6+nBplA5QtqXba
	 jayMnYXynOGFRL90CiA+ctD7+lFZ9hqfORociWBdBaHp5+t3l1ft5uHDfWkfGkAbPW
	 aVcpZbT6FR/P2L6xs5m7PclZRbAkNfrOG79E462/+uYZZtnVP2UGjLrK0ywuJivnSL
	 4rGY13WEia523KxhUfPAYosbNRwRnfe8LIExuZMMSUpTwIHiSaxE+M/FtFqFeNI2zK
	 uX/z/TnTnaYbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B55CE392FFDF;
	Tue, 28 Apr 2026 01:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phonet: do not BUG_ON() in
 pn_socket_autobind()
 on failed bind
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177734101155.196918.12322132819040532011.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 01:50:11 +0000
References: 
 <87A8960A2045AF3C+20260423010557.138124-1-zhangdandan@uniontech.com>
In-Reply-To: 
 <87A8960A2045AF3C+20260423010557.138124-1-zhangdandan@uniontech.com>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com, zhanjun@uniontech.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 09:05:57 +0800 you wrote:
> syzbot reported a kernel BUG triggered from pn_socket_sendmsg() via
> pn_socket_autobind():
> 
>   kernel BUG at net/phonet/socket.c:213!
>   RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
>   RIP: 0010:pn_socket_sendmsg+0x240/0x250 net/phonet/socket.c:421
>   Call Trace:
>    sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
>    __sock_sendmsg net/socket.c:812 [inline]
>    __sys_sendto+0x402/0x590 net/socket.c:2280
>    ...
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind
    https://git.kernel.org/netdev/net/c/5b0c911bcdbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


