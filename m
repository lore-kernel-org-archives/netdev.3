Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D83B585C
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623023; cv=none; b=WbYbtME+3MuZNpcZRCWmDcn3UXVzxKHiMFqqK/RR42uuRrcjx1Lu8rTT+vNnHVvOM0PDnSjU7ff2xNOJ5+wL8JDj8ubhVZex0lVO1KxOPz+C0K2vzkHs5yowGMObC3DNlf3GZw+8kVriH6s8J4NUGYhyOYjZZHgpUXQjMRePzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623023; c=relaxed/simple;
	bh=/D9rnWN5FoH6Lrm/mtxJTaI3MKf2JgD/1LpUrYGeVBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WRacnwphnhjenYcSXsh1WD4WlqzFAtwIIu8kwaQHeKsflJhsKpGJfOREcj2gdKqIsaqyuVOe/wYUhqrbCu35dKkFYs7odh0V2NXVd1/w0mgEq6c//kVdSPOcEuduF61u5K7A9C8/5cymdX7I9rqGYalUc5oWyWLco7YEPQ0sDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApcnCqD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApcnCqD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726DB1F0089A;
	Fri,  5 Jun 2026 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623015;
	bh=I67MZ0jDpVIqGI4OU3TfSQLCt7888lvanhFPX48QCn4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ApcnCqD9BAwzZzDqBu23mS5lTfGnSRoxgdoyw4Ie7p2sfhPybxJ+m80kSbkwJju28
	 MIs5Utthc4fngEEkJu4pLBTXpnvkRLL0pqSmyXf6/r/Bl6Pr9Wodr4HAvcLStp95Od
	 s1I5gG0Codvr1+PqUubIXqoiUCaVq0lu2ZDAHJbs7iZnUxNj28v6YynG3yDvJlj3M2
	 6fYlPbCjhUB2Qbw4iX5ZIlq6FqDQvtF3PXqcfdyHgotY9VmSkZnxZehQWNq3jNRH7u
	 wP3c8HByFQiouUoBArc7pbcm8yluo7tIUQYWZ1BT5/Sel+r9GIVxfJuzHgUW/m9GDp
	 Ahl4nOIpdSgcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568B03930A8A;
	Fri,  5 Jun 2026 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] rtnetlink: use dev_isalive() in
 rtnl_getlink()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062301588.3093327.8718383942742390878.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:30:15 +0000
References: <20260603180831.1024716-1-edumazet@google.com>
In-Reply-To: <20260603180831.1024716-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jiayuan.chen@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 18:08:31 +0000 you wrote:
> rtnl_getlink() uses an RCU lookup to get the netdevice pointer.
> 
> When/If rtnl_lock() is used, we should check if the netdevice is not
> being dismantled before potentially perform illegal actions.
> 
> Move dev_isalive() out of net/core/net-sysfs.c and make it available
> in net/core/dev.h.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] rtnetlink: use dev_isalive() in rtnl_getlink()
    https://git.kernel.org/netdev/net-next/c/f3c496105472

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


