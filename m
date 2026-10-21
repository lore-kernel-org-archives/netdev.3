Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588207;
	b=DPQGGwXkqytimx/bF07NV6ne1Gbe+nBXF7BGc4bPriUgXvv3ft74gY57I/2ByJWN8e0w
	 JJgHEUN+1u48sZ4axXKGk61sDjDkGAXzcGCGi3+JmaGrK8kPVl6/GfY9TmeJrQxRShAH0
	 cLgUOHOGdaooxvoE4f+58YeVzOTuB5jH24kyJYZ6kKXMUE8AIg6qaqxxeD3pkexZfgniE
	 +NndFOGNXYtWQVYRxB9tXtX4Jve0PuQ7kw23QtW7IbVXLzpmCpfzT3id8r6vur2aRuaRf
	 gw951enU3cLP4WGN6tbhnMtliUghpvReC+pyV4kqV/EkRpAmNL40GW027ggxxxOXrJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=e/M4RZy2OdNxn73A8PqcHeuaHuPozWahux7+iZxdYuA=;
	b=VDdXyohHw84RaiGUhR+JAr2kLHBpgEoD7PFGXaFE6w/UK+guRgANKrsv3Ecr7LdIZXoj
	 zIZmr/xsyX68XI49gbqK2s34SUQ1vf3dNAdSyWVJTfg8xHwotMSASVqjAxpdli8sUi6Yb
	 YZjrAc7AVUQnP5RswkR0lroFFPfpyP0cdyc9Mh+GqGxsJumKMsdPD2oRvTu7AtlkGtYj1
	 fVL/bjrvwOmug00sFHPmZY/y/b8a/U631PGFcJ01EgA7qLlAhKHC4P33PmXUT13GaGfDj
	 XY6XLd9HFFL2T4XnityPmz3SlEF0PcoJa3uqJGiiQmSafL94HK7RMilmGGmlXEN+gow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZTxsRvk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E9606A319;
	Wed, 21 Oct 2026 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZTxsRvk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803C11F000C4;
	Wed, 21 Oct 2026 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588206;
	bh=e/M4RZy2OdNxn73A8PqcHeuaHuPozWahux7+iZxdYuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AZTxsRvk6YmrVs6kSayXodC4pYuJwzx1xQz4LXCyJ+V/ItY9oA8Ld0yjddIKkDoFq
	 WgYV+GfQ6InYDe6mjnfV77rx5oheeiUwsoNePSVyMWRnHRUelmsZ6NCTW8r5FZFED4
	 DV87WXuONR099Rh5vSqj0xgycnBCfgsCz/6pXT98J7ChZ5nQsJNMIHQYbk4ph7ytk/
	 EUq2FevGwQsw0NtAS5dwSujnorhYa+OsjzJ/WOsEahxdW6yHBE4pYUMtXxGqacgbpS
	 5a3gYT+kOJMxId/ZQoBhRuC1siPKMau1GX2FtLa1tIogrMqKlYe2p2zoISZLO8T0zY
	 uxa3OknFngwlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774113809A3C;
	Wed, 21 Oct 2026 13:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: dsa: motorcomm: Extend ACL with UDF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179258820503.614906.669501178257325412.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 13:10:05 +0000
References: <20261017023136.2961543-1-mmyangfl@gmail.com>
In-Reply-To: <20261017023136.2961543-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 17 Oct 2026 10:31:32 +0800 you wrote:
> The native ACL key set cannot express IP TTL or ICMP type/code. Use the
> User Defined Filter windows to match them in the tc flower offload.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/motorcomm/chip.h |   2 +-
>  drivers/net/dsa/motorcomm/tc.c   | 140 +++++++++++++++++++++++++++++--
>  drivers/net/dsa/motorcomm/tc.h   |  12 ++-
>  3 files changed, 144 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: motorcomm: Extend ACL with UDF
    https://git.kernel.org/netdev/net-next/c/279d5c8afcd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


