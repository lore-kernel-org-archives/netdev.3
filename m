Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54843ACA40
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967854; cv=none; b=G402sQqbOlQ+LIMDcbjCkKcQKHTUyM/NpNvQwC9LqRT0RxdAFgYzqOMYKzx+1RYakUUvep5HyvwfMg8SuoqXmBzPbWeVkVn9YiXX/d/mImI0jqaKpBVwFGBdLKgZZRbvmUgO85xgJtrqH2psn5y6R82O8NklOeX2H1TaRtfJa1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967854; c=relaxed/simple;
	bh=d6RAohBaTgK7JPJOXY14BxnLDZodMMZyPJHw9qjiUcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EAaRN6YvIogYXfyZmf1+soGZqYoCHBjXN4FgJ4kEd/5Qhlso3SbF2mvx3VXsIn1ApWVQ5Tz+gpIucyAMKOMaSsSAuiEO/WajWOIPZo7Oks8vF1C8JPD121r5yPqpU7/p1f2Xx0cKN8R+FQ8uaF7jJMmkJZwwrPaesZk6HQYXYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjeBN6sr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjeBN6sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A82C2BCAF;
	Thu, 23 Apr 2026 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967853;
	bh=d6RAohBaTgK7JPJOXY14BxnLDZodMMZyPJHw9qjiUcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TjeBN6srqQISfcAc2AYy93EZlZEew+bacLUP7+Bn4wghCPML13WDGzR40vdy/O4ek
	 gIaxxy+FYF3zYv3JjgzcKQdNkTr6ke2NL5qHZrsOuXp102+rOTSKXOAF6ykQsKxudT
	 NtndxqsV3Y3p/NEQ4cEpikki+S4Zcd3fFN8baE5OgpLs3Shq4WSWFJxE2jCollgmdd
	 bcKI0zA4cUkmsLr8DjWmQVxwsT6FGAvZp3A2QZdpNu9aWzbSooE1kavmpIoCPdXOD0
	 TZ0fVicXHhRUFzENWJUq4zVU4UNnvFd7HPPNI7j1Q+b4IKpoU5KyqVqpxpPAxjBrDf
	 Latu1ZqaKGazw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC8938111D6;
	Thu, 23 Apr 2026 18:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] virtio_net: sync rss_trailer.max_tx_vq on queue_pairs
 change via VQ_PAIRS_SET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177696781479.700507.13075492208354648659.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 18:10:14 +0000
References: <20260416212121.29073-1-brett.creeley@amd.com>
In-Reply-To: <20260416212121.29073-1-brett.creeley@amd.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Apr 2026 14:21:21 -0700 you wrote:
> When netif_is_rxfh_configured() is true (i.e., the user has explicitly
> configured the RSS indirection table), virtnet_set_queues() skips the
> RSS update path and falls through to the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> command to change the number of queue pairs. However, it does not update
> vi->rss_trailer.max_tx_vq to reflect the new queue_pairs value.
> 
> This causes a mismatch between vi->curr_queue_pairs and
> vi->rss_trailer.max_tx_vq. Any subsequent RSS reconfiguration (e.g.,
> via ethtool -X) calls virtnet_commit_rss_command(), which sends the
> stale max_tx_vq to the device, silently reverting the queue count.
> 
> [...]

Here is the summary with links:
  - [net] virtio_net: sync rss_trailer.max_tx_vq on queue_pairs change via VQ_PAIRS_SET
    https://git.kernel.org/netdev/net/c/3bc06da858ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


