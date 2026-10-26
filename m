Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058608;
	b=nXX8dnYb4kjKJydPB64nUax11OL6yKND5Fk7y+Y+I8tc2w6yRdysbAV6XD4EX7uZBePW
	 lVJbsxMwC4j70AkXhq4mTZvdkNlCOY3mVcXBCagkuRki8a7xnzy4szWqw0sY1/NAEdIUN
	 WgFZBiqkr46M3AnSV1/QfPZXSFjAsyT9WNzzsMMID/oiCkrkVdaREnkuyPKGIesT9ZtW4
	 yfl3stavHaR5icFgJh0T3Grd9qtOw67dzgiTmhdZYMD700Z7zVkIemjB7NrMGkv0LAS+u
	 IWAuwcVvGShxBQmui3IImbWF5G0iTrLqInFMu4D1HnHr5La0K/gbmHRc9bm5Um6RLaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=j+tQUJNC3pxOYVfCPj/snN9rATcq8LweVo7HPYOvhcM=;
	b=FLp/KUjinMnD9ezg5WZoWV6vBBLvlIdJtkxcZzkcpHXroaK5DRy5XM73Xy2u0te13q6/
	 DqgLSRVgnavvcx3zME3xtLBxIEqttMQSzp8OR00OZzOgmFjXSwJjWp4A2obt6HD24Y6/O
	 Jg2PLa72dzCp88SS6msEy/ovfpQP9gBD+fPNXb7lagH/yLkhm2L55uL5JYe9dRsZnOBSg
	 +/i9DUWiWUNVDU9Z9vkkIDrjfBWbNTM5DB1TfA2HptKCtCRKTBCcDxWqLsSs2zsc60lCi
	 8CjXJqyoIDP5V6PsRnq2/+HqkJ9LUdrmJUUbP3mqmad2Aojeqll40OSgNzhVxxt5nBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1gCLwsG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8823606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1gCLwsG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0181F01825;
	Mon, 26 Oct 2026 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058607;
	bh=j+tQUJNC3pxOYVfCPj/snN9rATcq8LweVo7HPYOvhcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g1gCLwsG2dtn4mTAg9x1IbswCbISwzSgXkE3MwenRVe05wO6CjS033hSk7YkEIEv9
	 hj1SpE9f/I+iNXnP+onWbMQP6wlksnve4Xp37EIt/uTv9Bb4inX0Sqn7P2trkRkltg
	 bzujNJH1eoBnMILzGobfGG8ki/Hx38xrDZMLQqdFf2MQuL0ao6yJDr9tR3GvcAjufR
	 kx48YQMQenQcMTkVgN/RPny2n3/OldCbiPHAOlKSLRUAyi3anHkVXv4bnLpq6p8KvY
	 W0gf4V9HbLRWERo90X+bj8pMbklfjp4pzq6NkVYUx2OKADcxcX+BbBUZbheFD6zW5p
	 hhT/D2cF112SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 443673AA80F1;
	Mon, 26 Oct 2026 23:50:07 +0000 (UTC)
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
Subject: Re: [PATCH net] ipmr: clear skb->cb[] in reg_vif_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305860607.3465814.14170093135033685897.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 23:50:06 +0000
References: <20261025111337.142787-1-edumazet@kernel.org>
In-Reply-To: <20261025111337.142787-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 Oct 2026 12:13:37 +0100 you wrote:
> reg_vif_xmit() hands the skb to ipmr_cache_report() as an
> IGMPMSG_WHOLEPKT report. When the mroute socket has IP_PKTINFO
> enabled, ipmr_cache_report() calls ipv4_pktinfo_prepare() on the
> original skb, which reads skb->cb[] as IPCB.
> 
> By the time the pimreg device transmits the packet, skb->cb[] is not
> IPCB anymore: qdisc_pkt_len_init() overwrites IPCB(skb)->iif with
> qdisc_skb_cb(skb)->pkt_len, and any qdisc installed on the device or a
> tc BPF program writing skb->cb[] fills the area holding the IP options
> and IPCB(skb)->flags.
> 
> [...]

Here is the summary with links:
  - [net] ipmr: clear skb->cb[] in reg_vif_xmit()
    https://git.kernel.org/netdev/net/c/389952e8776a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


