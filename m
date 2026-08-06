Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A477344D88
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785977450; cv=none; b=BIgLojT9xNqaosq2HlAX+1Flrjvecis9rvZzI5s33JFIYkxzebIN9bymtBhcuQ0obNbuDb9ByBdGw+yAL1NFxGvjf1MQ1wA/d3HHfb72ZhYSbqGXxNQ90mqbYx1xgVJKP6jJvCdZhi8MwMp6UQdqlLFv5iZwz8BGok9fOVfLreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785977450; c=relaxed/simple;
	bh=NvSxLA6MK92Y2d/qdLOnWIKP5yewhr1LuUixqGuZE48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EAYi2ob4bpwNUwEdC4VtAmXa70T9cWpl3OLRJDDC/A4W1KwZC4Cx3AVjXWjYczn6nb/BEmrpiMRkJRG00fjUerpOGSNECWuVSC6HrwXmKk1HbRWXUxz2mftqGRqY4s01DzTuaesXoW9T1yNbQW0dHhOxndeI6A43kB2mYVvPRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUOXj5X4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUOXj5X4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5BE1F000E9;
	Thu,  6 Aug 2026 00:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785977449;
	bh=B9MSv2em++mvhIGYbX31DJ6LfzkdUAVLA2fLeXnsVAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WUOXj5X4yARyMwYwPZDdBwkbf2U/xBZRbIjbBwilGyb6uRKXn7ELo7LlG5nYczoiG
	 hsDYof0zNiE97MtfVNrgFCd/Z1pZLfIrkXCRhKZJ5ms0JHd+ku8eXHLb4IhZ8T6Cx3
	 VD3YsOGpRhYwg+EcE9kjpfjiludE0c0jEhAxGOLXnj5Z7qPmLTM8ONfnVphh2+yE9v
	 nh3xTMVIus2uVmrYc+u8N6tGIEDO4lQhDpPI2/iFH4lK0+qqzX+/vfcFg2QEVSg8Km
	 d4AL8Id1WKXJ5EnnjpnPxJ9GjwvqcFhfX228LriLapzVLPmdKvNAfO+RGlW5WL71rf
	 ka3C9PHDC1hWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B18392FFEA;
	Thu,  6 Aug 2026 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/2] pfcp: Support per-netns device
 unregistration.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597740839.585030.3373939171698624212.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 00:50:08 +0000
References: <20260731224406.2444121-1-kuniyu@google.com>
In-Reply-To: <20260731224406.2444121-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 22:43:39 +0000 you wrote:
> Patch 1 adds a per-netns mutex for pfcp_net.pfcp_dev_list.
> 
> Patch 2 supports per-netns netdev unreg by using
> unregister_netdevice_queue_net().
> 
> 
> Kuniyuki Iwashima (2):
>   pfcp: Protect pfcp_net.pfcp_dev_list with mutex.
>   pfcp: Support per-netns netdev unregistration.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/2] pfcp: Protect pfcp_net.pfcp_dev_list with mutex.
    https://git.kernel.org/netdev/net-next/c/f4418e64e61a
  - [v1,net-next,2/2] pfcp: Support per-netns netdev unregistration.
    https://git.kernel.org/netdev/net-next/c/23aff4ed78c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


