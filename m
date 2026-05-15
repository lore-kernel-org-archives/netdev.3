Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425C7260D;
	Fri, 15 May 2026 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809861; cv=none; b=j0sSKqL4yqv2zjJzumIib+oh9IQhHSajLtpN9D8EG5CQdg+5H4q0PEi54BvoIUTdDXneDZ0XoJQ8YG7E6d+o+8z4EZXiWNo1X6HbTckojpnNdTA9Qrihl1jlrlAHt4xABqJHnFK+2ingL84nftfDmnH2S4pyLczWNo2PwrIFPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809861; c=relaxed/simple;
	bh=lwy+Je7UuTA684S7UnzKNOTYUpSoQbkD+J2jVuPa0RQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SUPELRC+WUVwooaUZK+2lwOBHLp+aThCBrh/IYWqTIR8Qpk4lAuI30yOHNyaF5cg3m7pIs/PTNPPP7WFaoQzZ2x5E6gUC1lodiDKDlWUMz5E8KXrYnSmL2LOX941vO0GUBkjQtlOhWjayBCD3fhLi0wrOjgMyfn63gFDqcv2OUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKNZd/Lh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKNZd/Lh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD5EC2BCB3;
	Fri, 15 May 2026 01:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778809861;
	bh=lwy+Je7UuTA684S7UnzKNOTYUpSoQbkD+J2jVuPa0RQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gKNZd/Lhtv113JvuLaSTOA0TzVxBI3lVahnh+OMj4KINz4AF+PrgopesuKn/aEakA
	 HTSzqDCWAa6LrsV/L1+VO7gZ0fhtmJ8dy7f0EWCxrMSHoenq0PW7hQGfl0KV0rSbq8
	 XflgBpAWmVZbquHXrwzmDmsOVjh7Gl7dEyaTJju0fyEplndr1c9GXJi4pTlB2KysZY
	 i7VqrryH7rOuNDiURZagN49R4gPn3EVSE2y8Z4681Zv4DaYv6c7Pd5zhYXl9NniAWF
	 2JijnRW4YG+r5Lr4rsAt2eZE6eAe6rQA6JhxG2gwlPY6VfXMX8/MzsS57WNIA7URT4
	 A6U6FaTuMZs6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F2239E4DB8;
	Fri, 15 May 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ifb: report ethtool stats over num_tx_queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880980555.159407.6852919739863639604.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:50:05 +0000
References: <20260514013739.3549624-1-michael.bommarito@gmail.com>
In-Reply-To: <20260514013739.3549624-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xiangxia.m.yue@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 21:37:39 -0400 you wrote:
> ifb_dev_init() allocates dp->tx_private to dev->num_tx_queues
> entries via kzalloc_objs(*txp, dev->num_tx_queues). Both IFB
> per-queue RX and TX stats live in those entries: ifb_xmit() updates
> txp->rx_stats using the skb queue mapping, ifb_ri_tasklet() updates
> txp->tx_stats, and ifb_stats64() aggregates both over
> dev->num_tx_queues.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ifb: report ethtool stats over num_tx_queues
    https://git.kernel.org/netdev/net/c/5db89c99566f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


