Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530609;
	b=yts1ERZyRiasoukxPoMocgaJbwUGkWfLl51gtQnTFuZTa6kfdpExODtKYw9zcYWOZNjw
	 0F2C8Uz5VcZFbq2K+a7I3w0hJAIJaIlLYHbvS+MbwmsiMMs8M6hCYFpzX+bv10Xz4ExPH
	 EvSv+b8mVLVBij05FcYJzYuyWF50+qVr+6HbityrkcD6Pu3EzL9H2FWzQ9Dpvli6Ke0r/
	 cCCC6XwKAPv9aPD0HeEoHJWbBRV6XOjPjMZW46Fqc9l0q48eSbx2eVXOqxddKoBEL81N9
	 /gonypl0SZRYXQcTjl9j6JftibLSmIhcUyqAQXBALpYXVCqIO8td7D7rwSqlZ6DQ7HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=/ktSwLWQExy9PPjlqWAYb5B6X43q20aXbteYHOKd9Jw=;
	b=ErFHgvrHxd4Xrb/yO20dAG1RgSgRfD8Whmkfw10RWQymEB9b9FzzkAeTm36X26FM2C1j
	 pgSFnTLMUzGN3BR3ejj84jdPUvAx+ap+6pSmu4ZzFxLaxjoaythgziEjjGwwtjcEl8RLC
	 2z1JUGmPhGYAlpCXy7Qd8K09JIBGCHRJ6FMNx9ZrVRVp/T71hDC4RoYUXWVK8ZxljE3DN
	 O1JP8zuPQl8zRhPFAzIDJIILu/+szJzPGYeax+KnOmO8iynd4MQIy5bYPATmy+I3mS/9q
	 k4U5n6X+eZfuFnR1xyhOK+EBmpj0NTZ++5Vt09ZZ6xmWnS2duEbznmA30TPXc59pk0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMj6gi6n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736B606A329
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMj6gi6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807751F000CC;
	Tue, 20 Oct 2026 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530609;
	bh=/ktSwLWQExy9PPjlqWAYb5B6X43q20aXbteYHOKd9Jw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HMj6gi6nhFxbXXkYiYBBYW7Marj9e0K03H/RdA1BEVm+u7lP2a0zhowQswYRn15ol
	 acrNnMPRLqhdY6DpDmgI4MBPGY2ssycRTpF0kKjbSJO+uZ5PC22wPsgtH2PKNHrE+X
	 pGkHfQI1KMibpXqwVWHh2A3Jwdc8NtkkCMJcfQMe/aonqJauGfszqdmRweGvpu44YP
	 2uaY71Gs3Qit59KNUdIbCytE41d5VFB8Ya/oBRaIxu1on0ffPMi9ZM05P3FkOu/BvY
	 hemL8uDACpOFTW0GbqD7x1hxYqhbxQyshXYuybR9cOBig91ykGXwE+pLXkKuOY+MCK
	 uVRXdftQZZ9wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773243809A09;
	Tue, 20 Oct 2026 21:10:09 +0000 (UTC)
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
Subject: Re: [PATCH net-next] ip6mr: clear skb->cb[] in reg_vif_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253060802.212662.8966600542568977512.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:10:08 +0000
References: <20261017104228.3418775-1-edumazet@kernel.org>
In-Reply-To: <20261017104228.3418775-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Oct 2026 12:42:28 +0200 you wrote:
> reg_vif_xmit() hands the skb to ip6mr_cache_report() as an
> MRT6MSG_WHOLEPKT report. skb_realloc_headroom() copies skb->cb[]
> into the report, which is queued to the mroute socket, where
> rawv6_recvmsg() reads it as IP6CB.
> 
> By the time the pim6reg device transmits the packet, skb->cb[] is
> not IP6CB anymore: qdisc_pkt_len_init() overwrites iif and ra,
> and any qdisc installed on the device (fq, fq_codel, pie, cake...)
> or a tc BPF program writing skb->cb[] fills the area holding
> dst0, srcrt, dst1, lastopt and flags.
> 
> [...]

Here is the summary with links:
  - [net-next] ip6mr: clear skb->cb[] in reg_vif_xmit()
    https://git.kernel.org/netdev/net-next/c/238164201431

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


