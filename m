Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C23905F5
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208091; cv=none; b=axiYXJR9s8BIuN0SscsnZpn2aQzvddqBhztcUk5jQeEh4yTzcw8wAJ8PdNq0POdmrrSFD9GOHYtwR8iHCFRVa1hg9NHFHQ0QrFWv6mOU6KpEx1VVff9l0YyUwkdCb93zGL7V6MCqLRqvLf9l2VpYQEqQGMZCTfyYdyJy4uZbPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208091; c=relaxed/simple;
	bh=GJSPPqZSgt6XosId/IPLZILd/Z5PkFYSYulZPiGoXKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GTQDU6G5cgQTylDpOo0nGEnDqtmhDKZGS3IMrW+e2UbiSh3KhVuFDsXOd1j6mgOOPD1qIRpPzaRlKRbV5OaUQ4/5jO52hHnqsPW3wIc9rlEXCmWlPXI17J4v76YYh17Sv7xDPbPD0oEfMQ+qeXsEdQO4GECKht5URBL+Mu6VNUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2PwGpy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2PwGpy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F331F00893;
	Thu, 24 Sep 2026 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790208081;
	bh=w5GRhdfo/RaZRTt7hFHRkwz61GNA1cjR41hO3+RNSiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K2PwGpy8w07OdYfMu5BQ/wdVxmWjQv/2kL/JbwQy9SB8153q2BRjIRM3r3RmI68sa
	 kaqZ5wWgKfsdXKgh7Lxg05IRK/Nno5StssS+ZtNgGiyjcPoqT2tt6RpmoVDVWXg0KD
	 TV9fUgH8OUA8yK3j3IVKFbQJ+gsOOfGyJ6jTVCHzBHFfm2bkUf6XMn/QvG2OK7EqYb
	 m+3NsxK5QfBYIucuHhH8OaquqCbYrHz7HcpsRYy2HzmspcUXC4qiivow18Gw0onTJt
	 RvKTXHlqLHenjjw4Un8mykHT15IGTIt+q62dVxqpZlBHQ+ZSdXfkwRziYKbtb9t5je
	 lAGKDGL2gLs9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D07C739E9602;
	Thu, 24 Sep 2026 00:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] veth: manage XDP program pointers during channel
 resize
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179020801040.1240300.14886400931573305282.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 00:00:10 +0000
References: <20260921231856.1798630-1-kuba@kernel.org>
In-Reply-To: <20260921231856.1798630-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bestswngs@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 16:18:56 -0700 you wrote:
> veth_set_channels() tears down XDP resources for removed RX queues
> without clearing rq->xdp_prog.  If the program is then detached or
> replaced, those queues keep the old pointer after bpf_prog_put().
> A later channel increase can re-enable NAPI and run the freed program.
> 
>   BUG: unable to handle page fault for address: ffffc90000256048
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
>                          include/net/xdp.h:696 drivers/net/veth.c:820)
>   Call Trace:
>    veth_xdp_rcv (drivers/net/veth.c:941)
>    veth_poll (drivers/net/veth.c:986)
>    __napi_poll (net/core/dev.c:7787)
>    net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
>    handle_softirqs (kernel/softirq.c:645)
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> [...]

Here is the summary with links:
  - [net,v2] veth: manage XDP program pointers during channel resize
    https://git.kernel.org/netdev/net/c/7104a3707143

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


