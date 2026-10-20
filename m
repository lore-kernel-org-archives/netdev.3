Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528209;
	b=JKFUUQBtziL1VMmBkZO4EIVBvx0B3lm9BDBm+A2LNiTId2OXjKNZGkZdya9celqHPWxz
	 mOH1L9uDgED3Im/xdmJ6zzTtb6lWiyB6w/nhjJl9UYLc97uXwrbElwSHHEAx8C/2MRT5a
	 KNUmzfqiYWvDvc2WMegZxZconJ3codfoOP6PA0ShqFXImRwIRVeVWUxDF+qDG1XrjLtre
	 jzzvGKo79lOFQLjq23ZQ/nPYrx3Klb/6HI9YrsdQA5WXLrf8t2uZOJBMOFJwn/rIohl3h
	 /7WKJYThxMdsTiykyNmvNDaOEywjccKTg1nhrCgRljRjIzr89KM0Up/4/D183RER2PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9ubEqgYTAw5blqbtxZ79KB9ohOGhuAAgloDChw1k3AQ=;
	b=hHexYFXXVk9+3hkbEC2kjtmm1xGsuBa4Z18jEPsvd+jVx+x754OGKmN1F7KRANH4z1e6
	 NUwl5O/ejdiXg/sLJDhT9ALtqeDyAEKJ+ZaXIg+NDlg+2Ub84EpP45gRG8OGrArSW4o3Y
	 NHHTIWdOc6wOIEZ1uQK/25LTE2IHsdtUQHctBhVezBs92ZgUc/08Rtiz1jyeA8dasSwMU
	 WPOB43k3l90dgYfr2LPZBDzJIpG4lQHre0GqLWKmJi1EXsIQqAeZF8/aUYiSvhLayAsht
	 +v6M4pBjqB5Pp40NPqbcXdcjSbM3fFne16td0mnRdD683YaoHbjf4/WB1Ks/gmC9gMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiQfYbmD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894E606A330
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiQfYbmD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432941F000C9;
	Tue, 20 Oct 2026 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528208;
	bh=9ubEqgYTAw5blqbtxZ79KB9ohOGhuAAgloDChw1k3AQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OiQfYbmDvIMYFXfGswfDRvU4/nvU6iUEOLQ5xRB5FsmcKLCOs0NpOMnjOHBiQKY3F
	 CB+lYaS7sku4xUpf0/gteqr3ewt/VSEZFWB/gdhaAZd73zNm7Zi7cfQj8O0BNIl7xw
	 8EBnhBHEsdy3QbrAnonVjVUSzakzMb4OAGNkv2Xc3VsCZH/kaGhN/yZA3vf3Euw+CO
	 THGoZpvZtJd51LCZ0PG6oskfIOo6logmPsbPNACvY6Jj52XhsdZn8xwiZQGCVvYrLT
	 xnQCKKO/6+bajcFZsWhwnlxt6klHo5C/FuV1gOc6HvjiSnU7HdsQ2500NLbc10EKQO
	 2OdIOH1UOR0nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3833809A09;
	Tue, 20 Oct 2026 20:30:08 +0000 (UTC)
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
Subject: Re: [PATCH net-next] hinic: use skb_put_padto()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252820677.194567.12226367741443334870.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:30:06 +0000
References: <20261016093518.2756935-1-edumazet@kernel.org>
In-Reply-To: <20261016093518.2756935-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, cai.huoqing@linux.dev, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 11:35:18 +0200 you wrote:
> hinic_xmit_frame() pads short frames with skb_pad(), then
> sets skb->len directly, leaving skb->tail stale.
> 
> Use skb_put_padto(), which updates both and is a litle less confusing.
> 
> Also remove one pointless netdev_err() call.
> 
> [...]

Here is the summary with links:
  - [net-next] hinic: use skb_put_padto()
    https://git.kernel.org/netdev/net-next/c/42ee6e77ab45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


