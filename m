Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167854CF60;
	Tue,  8 Sep 2026 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873668; cv=none; b=kRAnFJ1jB0mTVeL26RVCo5Milg7nvZoSaFjbf7PTvgYqe/dWYtWFKscHUhHnZRungazXs2/MjxSt4f7UwEfg/XYcX86AKcpvstqQNHxBJJ5mCbDc59ap2CAFY6OIL0Fa+cq3Nho5KAa6FA177BsrYGtdBnbJ63JeMCmA2BLkmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873668; c=relaxed/simple;
	bh=nlpG3jXpD2B5O8zqUYlkjDANFg1qAVW97kJN+iK8BII=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=juC3+OfQjbxfUoyaoUEzGyL8E4g9VZcH8rfmZnSKCF1ndJRtaUMbibLoFqpNiZGdfzNqX+aq7hVgG2/yi9np+3pvCJ/8D6mREjzf/zXACjTJlNihtjuk+KT8Huv4klCRnBIl1GOUmqlF2/CE3Fg4fGNu2YwM+SehHOmn6f9AZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqsSL0sR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqsSL0sR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136801F00A3E;
	Tue,  8 Sep 2026 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873667;
	bh=2+AFpF0lz/mRgbWLCVgOAk7ZCGi/cd3f4i4xqihKHA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kqsSL0sR5PbhfsrxaF56gWlVFYHSNAVOiPRoVdX5efubr4UFRadfcRzqgZBIpPFKl
	 ivU03CknoPYAYdwzmM+24eqrLcfzQaCbsVZqvvzNs3Kems179fEQuCe5zK878v8yCE
	 hbaB00uo/Ho7pVVx4iTKK+M+G70TwBaobzgIIdDs1ih7zOw0hPQ+AxVM31j4o3kwf3
	 sHAfsI0KvZSs9XKKonH80ruljJgafNcoJCxrN8KvZlmIHl0IGOYGLEoJF9CBe2RayD
	 ncpL7LCNvSdzIMoDXI/VrUZaSvouEMVx1G0ZYfiXoIb8JXZW2dy8Hv9drUCJq6eeE0
	 Ub7UKlrBSMteQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1989039EAF43;
	Tue,  8 Sep 2026 13:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mvpp2: simplify IRQ validity check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178887360465.3525489.2886983029806967499.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 13:20:04 +0000
References: <20260903075753.346647-1-phucduc.bui@gmail.com>
In-Reply-To: <20260903075753.346647-1-phucduc.bui@gmail.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, thomas.petazzoni@free-electrons.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  3 Sep 2026 14:57:53 +0700 you wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails.
> The current condition also checks for negative values, even though
> irq_of_parse_and_map() does not return negative error codes.
> 
> Check only for a zero return value to match the semantics of
> irq_of_parse_and_map().
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mvpp2: simplify IRQ validity check
    https://git.kernel.org/netdev/net-next/c/bf6f89ccd974

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


