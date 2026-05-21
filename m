Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA7367282
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330025; cv=none; b=Lzp8Yg6OGbw/aNc41+Qws510TWAquWhdo1hkzmlfauHdAri9Rri4WYI365fiIEkXDnVQIHRa9ZClxQVbck9t7DfyYu/Em6vDGshDJbcCXXM1hU5NBa5n9k6wS3rGDaJHqDWeKkW9GvzNzcbCemgh6zVUE9844zolkTk8Pqc93Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330025; c=relaxed/simple;
	bh=z3sH30KG6eD/dCmA/2ZxQ9DZidHPWQ6ib3wLWvjxgks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L/M2dWVTV72QB80wo4ikoD8yiZrW4wRk24q6Q1K9f6fEvTidOx+IyGw7En9gPt2qgCDO051A+8zUQ3mLQfUojaPBIK5Ca2rpgGkt9Zq95i1M/Pcp77TfVGkXYm70CmMFzSpEXh8zpheV+1fnhp/3nxmUUtilUEjM9qaw/OwTS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C286ktbC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C286ktbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77E21F00A3E;
	Thu, 21 May 2026 02:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779330017;
	bh=BGRI5Ro+56q0pCye1gtru3pqshQmgqKpfgkWeXPNvjE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C286ktbCtXIj0PJcldrVg/I/tJtsXDffPaDbcGYZFOV1ls+Kh7fERLwUHAycS7TAN
	 yDILRPEe4mAi6/PMf0/mb3eMrVBO+vauW+sXy3ofRt9wpno3NSFEJ5CaX6+4reZnxZ
	 s8zD9gB5wH0r72thIeZjo7CWma3f7KwcB0EwZG9vwxNQRU8jt3K7aBu3raMe5P7wqs
	 LypOlXBtN6Fb5xpsz1h2FoPbYeLB7iuxm6MyhGk1W0L6szDH3NqkM5iON93svnPCsn
	 GMov/+hfOIEsMxSKvzluT//f775Cle0/XJ8bogXA1sKJPTvtRSxval6eZx8UpjnEnJ
	 ltIC5R48nx86g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1976A3930C38;
	Thu, 21 May 2026 02:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bridge: remove stale rcu_barrier() in
 br_multicast_dev_del()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177933002764.3834961.11698606086995974842.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:20:27 +0000
References: <20260519095540.2643318-1-edumazet@google.com>
In-Reply-To: <20260519095540.2643318-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, razor@blackwall.org,
 idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 09:55:40 +0000 you wrote:
> This rcu_barrier() came from a time call_rcu() calls were used in
> net/bridge/br_multicast.c.
> 
> Now kfree_rcu() is there, we can remove this problematic rcu_barrier()
> which causes extreme RTNL pressure in many syzbot reports.
> 
> INFO: task syz-executor:77945 is blocked on a mutex likely owned by task kworker/u1024:5:36537.
> task:kworker/u1024:5 state:D stack:24616 pid:36537 tgid:36537 ppid:2      task_flags:0x4208060 flags:0x00080000 last_sleep:612797637337
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>   [<ffffffff81914eaa>] context_switch+0xf2a/0x1730 kernel/sched/core.c:6483
>   [<ffffffff81201143>] __schedule+0x1133/0x43a0 kernel/sched/core.c:8411
>   [<ffffffff8120446b>] __schedule_loop kernel/sched/core.c:8514 [inline]
>   [<ffffffff8120446b>] schedule+0xab/0x260 kernel/sched/core.c:8529
>   [<ffffffff8121a093>] schedule_timeout+0xc3/0x2b0 kernel/time/sleep_timeout.c:75
>   [<ffffffff81205347>] do_wait_for_common kernel/sched/completion.c:100 [inline]
>   [<ffffffff81205347>] __wait_for_common kernel/sched/completion.c:121 [inline]
>   [<ffffffff81205347>] wait_for_common kernel/sched/completion.c:132 [inline]
>   [<ffffffff81205347>] wait_for_completion+0x2c7/0x5d0 kernel/sched/completion.c:153
>   [<ffffffff81b8f27f>] rcu_barrier+0x49f/0x620 kernel/rcu/tree.c:3888
>   [<ffffffff860091b3>] br_multicast_dev_del+0x303/0x350 net/bridge/br_multicast.c:4459
>   [<ffffffff85fb5dbc>] br_dev_uninit+0x1c/0x40 net/bridge/br_device.c:157
>   [<ffffffff8568058c>] unregister_netdevice_many_notify+0x1c1c/0x2300 net/core/dev.c:12599
>   [<ffffffff8562be43>] ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
>   [<ffffffff8562be43>] ops_undo_list+0x3d3/0x940 net/core/net_namespace.c:248
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: remove stale rcu_barrier() in br_multicast_dev_del()
    https://git.kernel.org/netdev/net-next/c/25ae123db10b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


