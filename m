Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896F46D547
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255465; cv=none; b=jLI9zinmDlQjPn2gvmELyRcuvCH+2XLikEZhksQaDmN0Kp2YGsfP+hG4iBUXogREu/HGCheopVrrL5rLjBrxEXjdJdvBj5HFU1ZX+x+fMHhQ8bwKrvhYP1GSA/EUXInNKqx7vnSWXAku5y8quLAT2IQn10jKE6ToJ5uhbPWYxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255465; c=relaxed/simple;
	bh=FbO4rE6IQJlnM5MLsxadARAVRK1jIZ8J7aIqm29X8rE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y7Mg5wb689lGZ/A17arX5/CRJxpNdhdcXAvz2cPpRTmVKAjhyizdkayKmSbmaRtIgyYQM0Sc89ir3u25CEnQrxAcEDpcNvr4KIisSZB4QyMnkGLZqqVol1AaaKnJkIJtIr1JKfeiPhUoLQs5vhjAwbVWL94YQkPtMzAJRO8B4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxlSeG7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxlSeG7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12A81F00A3A;
	Thu, 20 Aug 2026 19:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787255463;
	bh=ZmzURh3e104jMEf2GL3KuXhFzoYXoBDb4fHpP8hvXvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IxlSeG7gMfb4kzqnC4F65rdt0ySEl9f7U7p6OmP4vhe3Cb4PLORzLGF4bXZcu9NJ4
	 LJge+l5BW4tYHAWFWxv5WadVenhBMng9QPDg4lFEt1msIQk2X0T/SAqlnssVocUfJH
	 NDzGKNs/q9lQnV9zXH7qMNdCd059gO1uLvmw4aQtylvBLS7/KPj1VwXYoC9+1qR0OZ
	 YsSi1uCh/JHF/LqBdHS1Js+/ZgTabfvg1nzpUV0EsHjHFSURQrlC/3YCP1P9JAcoVd
	 7IZmmA+oZggM2JEctByPtp2Qpy8fzWt6LHTCZ2FG9AZ2gp7dkgQXDYP+mq1/kvvRVu
	 NBmpFd+nBOtjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568CF392445B;
	Thu, 20 Aug 2026 19:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdevsim: update queue NAPI association on queue
 reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725541388.453960.9872212090120825046.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:50:13 +0000
References: <20260817082511.2300402-1-edumazet@google.com>
In-Reply-To: <20260817082511.2300402-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+483a6efbc4882c1201ee@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Aug 2026 08:25:11 +0000 you wrote:
> In netdevsim, receive queues (struct nsim_rq) embed their own struct
> napi_struct. When queue reset is performed (e.g. via queue_reset
> debugfs), nsim_queue_start() swaps in a newly allocated struct nsim_rq,
> and nsim_queue_mem_free() later deletes and frees the old one.
> 
> However, nsim_queue_start() failed to update the queue-to-NAPI mapping
> via netif_queue_set_napi(). As a result, dev->_rx[idx].napi continued to
> point to the old NAPI struct. After the old queue was freed, a subsequent
> queue dump via Netlink (NETDEV_CMD_QUEUE_GET) triggered a KASAN
> slab-use-after-free read in nla_put_napi_id() when accessing
> rxq->napi->napi_id.
> 
> [...]

Here is the summary with links:
  - [net] netdevsim: update queue NAPI association on queue reset
    https://git.kernel.org/netdev/net/c/07e98a4d5e9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


