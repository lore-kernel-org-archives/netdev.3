Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509410;
	b=VdHTPGf12sn0v2w70KebiTRW+KV0u76n1JDTNuOlKV7abERfRymi+VuPWXry9+GLc8Dv
	 PO6/5IPcHj9g6MoPtPwSEhOoERo2h470oBuLXDHKZTwrLdLS6D6aaJ16iy89Pzqb1iBK8
	 +TAeId8ByQkNEsb3QuMstx+B6DQ4SQNmXNJGdtLoTEg6v0NOlRn6L2aL/yRtMK7GYqUdH
	 Q8ZU+TktCSdxzhIVjJRtvOoXYk7U5cXbapqGKZHCLEKJ45POpU60m+zNkTK54A1JWUYc+
	 aLR5o+9wCMCpP/wRBH3K96evQ9mwLkXO/Hu/QqkDkZ8edBEX/QkoqWnMnXrgl1OiTWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=prAsKLUyV5jCB3LnAPunmvllF2csjIlI6moRKyR9wV4=;
	b=I3vkobUNTA4VUpUj2a4+QpXCxGLUnm0MvHGbk8LholYuatxO/TEp7DNwVf7fCNTMOsHO
	 HmjaEtm3/TQMKGU6recmKZnKpZiUkDJhBUtEarTNRMZzHbVF7oobl7iJG5qZYcT68gvtL
	 DtAlTsf0t3/Mpze5lFo3Lwk2ehUxbxWVpAS6ixJ6imH0XvSdlyRbbtUoBr9pmHp7Vl1Zq
	 fht780I5P636/UAUlue49K15fazk5G88XsJSeWWM8uBkbNDmZp6wmtgECgFNga5/N8xIs
	 Sp88MCoSJ/a5e8hffWawnGPravUXImc1Ib4BwehewCT4yA0awHhhXjaWXBnW5U2/tzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzV1O6HP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5D606A32E;
	Thu, 12 Nov 2026 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzV1O6HP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429491F000C6;
	Thu, 12 Nov 2026 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509410;
	bh=prAsKLUyV5jCB3LnAPunmvllF2csjIlI6moRKyR9wV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gzV1O6HPhrN34DAxZ1l193gopwAVL7AH5nlknjujsHgLGvGiVa0oUI7vJ4XvOC713
	 /pebdnDx2k6lv82kZfxL7qURDMGEMdU53g0f89STT3OiFYfzh1CTq1HEeXmZs4dK9+
	 FiHYcxK0/OcnxBf0xnmqYj/ZQ1K1Uw7jB+ySXcHA/P0W+gtBc0n2IRyjIw70szPp20
	 57E+jbgIVNCDjKAobHrpUslOLTcOmIimfO+WCxRSjQYk5mPrXKWUErmtrO6gUm/1oU
	 nDoyLjGzLpcqqkBYAqBGlbFdVBImzsB1PoWRfOO/bUHYzyUAiXjfxljPEPIfbCp1fr
	 wez1aiwa8w8MA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3F8391AF9C;
	Thu, 12 Nov 2026 18:50:10 +0000 (UTC)
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
Subject: Re: [PATCH net] amt: use ipv6_hdr() in amt_mldv1_leave_handler()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450940877.590019.1220237437365570850.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:50:08 +0000
References: <20261111031147.105834-1-sunwenbo@cmss.chinamobile.com>
In-Reply-To: <20261111031147.105834-1-sunwenbo@cmss.chinamobile.com>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 1342116488@qq.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 11:11:47 +0800 you wrote:
> In amt_mldv1_leave_handler(), which handles IPv6 MLDv1 Done
> (ICMPV6_MGM_REDUCTION) messages, the source address is mistakenly
> extracted via ip_hdr(skb)->saddr into host.ip4 instead of copying the
> IPv6 source address from ipv6_hdr(skb)->saddr into host.ip6 as
> amt_mldv1_report_handler() does.
> 
> Because amt_lookup_group() compares the full union amt_addr for v6
> groups, looking up the group with a 32-bit IPv4 header slice fails to
> match the group entry created by amt_mldv1_report_handler(). As a
> result, amt_del_group() is not called when an MLDv1 listener leaves,
> and the AMT relay continues forwarding multicast traffic until the
> group timer expires.
> 
> [...]

Here is the summary with links:
  - [net] amt: use ipv6_hdr() in amt_mldv1_leave_handler()
    https://git.kernel.org/netdev/net/c/6730fe495c35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


