Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630414;
	b=YgLJtPZIxCxKg1ebYrl1mbVwX20vVFOGWinnzMfJ04ylggy61a5R21Maoh+5NjF7bZuJ
	 WaYlut/7lTsweQlp+P/U6j8/ZtCZT//JU3lmRAlH6r591hAnDBwl4CuTdYNeZMLeLDMnJ
	 +fagnbROXhByv9FRaIOHnRFJGRztSfTTsZ7pie0uEq9p7VXK4qtoZWAEP0778Qq526hkI
	 JazHUdgX9A3U8Y6MrcDVrMiKXea+8EvgijUryP02qKMLnwNJFiLtnAgZ3t4NtNrFCssEu
	 XMPoC/awJbwhKTb1HOpF7skMROkjp73rktj3HcArkhYGgFH4pJdRAmHTPGjK0UtdnRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630414;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rQnZk0VZ7tBSErGjfV3N7YHWRigm1gxu9g9fBoGEz/I=;
	b=lYLptwyWcAqbb7HKYQ6TVcXSTpQ0P93oeaPIqwR0iui/5ybUr+00tVfmeqQWfafqhiUp
	 912GpLUNH4HxJBFZJzTU5oAQyQWMH7vMT2ub5KkuTnJQOEeBg05RS7aOxO+QKRVv49r/z
	 CFWQERNeArAvAZJPSKkTZEgkj7BECxJEvwTAi+wj/7ftFtg8UKXLBlEe7okHanYyheLeB
	 lpsxifcxhBaJ2TJLu1sdMApV6KK1wWqSoZlELWElRic6A0DFMIGhhwDLohjeAXnZLkhu2
	 bEcc8azSxong5Hu2bHZP2HMkg0dubkDO0dPZUAlZpAc0JlUkyrb1CQWL2enNMoDl75g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENFUc5T3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283C606EE9E;
	Mon,  2 Nov 2026 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENFUc5T3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8696B1F00A16;
	Mon,  2 Nov 2026 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630413;
	bh=rQnZk0VZ7tBSErGjfV3N7YHWRigm1gxu9g9fBoGEz/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ENFUc5T3oqtbWbwOPDsru93h+m3LkCW7hJztXMho9ZzJmdQsJZ+J9biZUW6x2/bgT
	 en62y8e6VFMjgo1kfiycgfxWfDDRxZVeWw38TlH3A016j8BwNUUWpOQIzkWIdwRQ6k
	 bqWLosUOkMBthgLILIUiH5qCwIzFTjOpK6Sb0cHeA3nuBCJGD3D2t99RVG2L6k8vSq
	 VYdMfGWv/26vDueQQ35GxMQasN4nsdeI1w606kHH6D98vAPLV7BTvo+mrb6IbJLOpw
	 eJdjZ/lghw6WoocWqCF3mhPahK57bSt+iMSoc1O67raKjGN4+HiqVvEGwUEtFwIFxk
	 rcBGzVMFMSkIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D244380821F;
	Mon,  2 Nov 2026 14:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sparx5/lan969x: release the in-flight slot of a
 stale TX skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179363041231.4096563.5352456270164745162.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 14:40:12 +0000
References: 
 <20261029-sparx5-ptp-stale-tx-slot-v1-1-ec15f391bbb7@microchip.com>
In-Reply-To: 
 <20261029-sparx5-ptp-stale-tx-slot-v1-1-ec15f391bbb7@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 12:48:10 +0100 you wrote:
> sparx5_ptp_txtstamp_request() counts every two step TX skb waiting for
> its timestamp in sparx5->ptp_skbs, and refuses new ones once
> SPARX5_MAX_PTP_ID are in flight. sparx5_ptp_txtstamp_old_release()
> frees the skbs that have waited longer than SPARX5_PTP_TIMEOUT.
> 
> Before this patch, old_release() does not decrement ptp_skbs, so every
> skb whose timestamp never arrives, for example because the switch
> discarded the frame, keeps its slot forever. Once SPARX5_MAX_PTP_ID
> slots are lost, two step frames fail to transmit on every port of the
> switch.
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5/lan969x: release the in-flight slot of a stale TX skb
    https://git.kernel.org/netdev/net/c/873363ac591a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


