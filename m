Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234411;
	b=uE1e9EJe5tC8OvDm2ns+L0dPQYFKZAtLQnF0qNegZeLNNVr1WibmQF1RGGQOL8puCOvw
	 aB6g8cdWP5KISPzi2w7S+QZxiBzSkFzsQhR55gCEml8UtGF7Pq3X1P5Pu0wF+5DOsC18Q
	 yuC6aeWL/1CwETXMerBeyoRYn6gis0rTxYotyONCwEi1EbeOtsZinksJ+0Y/r8Cd/0v4g
	 Sq3xPPkm6LYCFY5ayx+I9yvncJObqu8a7D+RDCnbXsAEEjg+gadxLqtJaD/vRd8B1dm2n
	 dMgwzX7dbCZZtQsf9CdfQEqrf5RYcRkmt0NlX/wqgO10rDNn99lOSLJxuQquPpGXD7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BxYehSGB4nYEl0EpZxvRehODttHkM705AEXj14ilP+8=;
	b=g9MBfzGTfeXvDr6b34xI6bzvYIqaxJn9kOEr3I2bofz0CSwMCun8UehvG+2Pkwz7aNP8
	 augq9dWowIH6WT2qF9ZFsHGfCjQRajmvu7hmKQ3ztjvn8r/grvpRG0joxAH0AKtKJUie4
	 9EQRF3SLDm6N+MoKgAccbFmBRmLAikybvHDHDQIsPTegJ/KQe4o2vgHGKufj1RrhxWora
	 Scj8bL/u4XXl90+gZWGu+nNhyedBasWqfaOOnrJiYB/Ch6iLnXRka94OKEnEwErmG+HLJ
	 VCwrGDZNbkCen9WIsUaLeePdxEtFwmz3WsPRUqwIiLPEiPV2w/G6D22GS7Vo9yGdJ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZzAch5n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF6606A33E;
	Thu, 29 Oct 2026 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZzAch5n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110CF1F01825;
	Thu, 29 Oct 2026 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793234411;
	bh=BxYehSGB4nYEl0EpZxvRehODttHkM705AEXj14ilP+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RZzAch5n308zjdI4AHqz3Xw5Shk47z8WVwNXptmOgyuwCOGRugSDuOl+1WnI0NMN1
	 2wg5/EtVw+WGRlxtgHsC27FX9H65bn9gSYizuAZgTBapAjwQg4M1Afdw9EmNiaCHM0
	 CFrwUnRy8+47F+JkEoZqUYuTmpa+t1lWa4WOIkJi7xstPJwT7ghTCcdMTgV75WJKQZ
	 ZseFp4coX+DcIsXn8+kWQLwsEeuEuF/KMest9teibpR2Tir7wxlJKJuqlSM3qskTHk
	 oDsLYNgjSjGUEUD8U2xBBx2cPmvYxrDaunoLUOo//Zb7Ib+vu4WeyhLVoX6lKuZNnC
	 u0G0J1FL+vG/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073B13AAFC4C;
	Thu, 29 Oct 2026 00:40:11 +0000 (UTC)
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
Subject: Re: [PATCH v2 net] ppp: linearize and segment bridged packets when
 required
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323440956.1500896.15333637748858681372.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 00:40:09 +0000
References: <20261026155927.707655-1-edumazet@kernel.org>
In-Reply-To: <20261026155927.707655-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, willemb@google.com, linux-ppp@vger.kernel.org,
 sashiko-bot@kernel.org, qingfang.deng@linux.dev, nbd@nbd.name,
 pablo@netfilter.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 16:59:27 +0100 you wrote:
> PPP channel bridging hands packets received on one channel directly to
> the start_xmit() of another. Packets received by PPPoE can be
> non-linear, GSO since commit 55a5d8fca836 ("net: pppoe: implement
> GRO/GSO support"), or CHECKSUM_PARTIAL when injected with a
> virtio_net_hdr. The regular transmit path never sees such packets, and
> only PPPoE, which uses dev_queue_xmit(), handles them:
> 
> [...]

Here is the summary with links:
  - [v2,net] ppp: linearize and segment bridged packets when required
    https://git.kernel.org/netdev/net/c/0de4e69cd021

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


