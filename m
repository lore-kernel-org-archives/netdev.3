Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD13A168C;
	Tue, 17 Mar 2026 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742214; cv=none; b=Ef/U7zEcg1AMHxX54TSr3HNppiyV5cLWQHLSqgtQh1MnY7+yPIq6Tyk1dx2XBI2n2yXjYmjCU8YDsC6af54DaPYQSFawYwt5e6s7RQJsPbDTXiWyGJEDWNw/zGOnLWj9gXx2xwD+qghhPs7srGN8ep2azWJdrmLJEvGa1rWySWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742214; c=relaxed/simple;
	bh=yCE9xDfVH5mlKvUnBe4JP0v1B215euVAbOFA6C65hVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DQqNeVHDwirm/+rUXmpsl+YMRrNL2k3X8wV2LZXkcUv4iPz+BicVXzsmHifS+jezcejBkxNnSwl5tNQk3XKfoKP+Hip/snrFKY7H2ArUl51NcGtuBS/o1qKcJZh3eWpdMo7AqQzCX0n8k9YFYLS/Je08YnUlzNbYQRLDknl5PHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0zKRmqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0zKRmqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B44C4CEF7;
	Tue, 17 Mar 2026 10:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773742213;
	bh=yCE9xDfVH5mlKvUnBe4JP0v1B215euVAbOFA6C65hVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s0zKRmqtZq0cdfjoQo6HkrW7a+FKXciJYTL6KlXPqe8t2omKXeVBgHdaOoBU+sbC2
	 Puu46FLmnJk6qT8/kKParU+Zd8exVhe1FuTPAk5XBGMWtrEkmmAmi22mVOLVDs7hrY
	 N1IMHYiXqttr6pa7rixgm90VFejAlZpScFW+vTpTHuw5i1924NdFCbC/NwNaNCem3q
	 eeaOzDNT1KHV9OXHs9HB/JcGviAwIbrbgbKPvn7ti7F4Ui8CeJh2tOMyU9mFMf89+w
	 32YiWZWkRnuwGVNg8W3/B6CnNxrIauEfZMJLVt+l1zHJ5Q4CNxrFA28hnV5322wpME
	 uZb1huvgRhaKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1F63808200;
	Tue, 17 Mar 2026 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] ppp: disconnect channel before nullifying
 pch->chan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177374220629.3541223.8549606798912448552.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 10:10:06 +0000
References: <20260312093732.277254-1-dqfext@gmail.com>
In-Reply-To: <20260312093732.277254-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@ozlabs.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Mar 2026 17:37:30 +0800 you wrote:
> In ppp_unregister_channel(), pch->chan is set to NULL before calling
> ppp_disconnect_channel(), which removes the channel from ppp->channels
> list using list_del_rcu() + synchronize_net(). This creates an
> intermediate state where the channel is still connected (on the list)
> but already unregistered (pch->chan == NULL).
> 
> Call ppp_disconnect_channel() before setting pch->chan to NULL. After
> the synchronize_net(), no new reader on the transmit path will hold a
> reference to the channel from the list.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ppp: disconnect channel before nullifying pch->chan
    https://git.kernel.org/netdev/net-next/c/6a196e83a1a7
  - [net-next,2/2] ppp: remove pch->chan NULL checks from tx path
    https://git.kernel.org/netdev/net-next/c/febe8012458f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


