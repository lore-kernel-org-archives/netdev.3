Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462809;
	b=HVibfJvdBDwJdckJ2m0ulyXZxtPrqwPHSKKvcDvM8LGy1YvAV/ZxfY63BGmIgwFavgbp
	 CIVRHprY7N7I/nzcCy6sh7kEWMVUxp/N88sHCCq/t47KgQz6IaeVF4zbo4218EQExZ8C4
	 qLcEW2YAc0QX2w2j1gwcatVaxvJlaH01psygSqhOciLl45tOD1y6AM0TzAVDbCsk1dKU6
	 iiey7VO864qGaXwkMB2sl3Nm6urM4NewxgTDx2ai8pKTNK7Um5LIvfLivrncsrw7mDTrD
	 poakp0uIyTHk/0JGX/AM1UBfyMGGwdYTgn11z+BTi3zSbhUEcL83LnQBUpF6cvvyBTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+6D1iMcEiNp91wI9iV+LsIIjUJIqXv+F8ad2QlrDXZY=;
	b=Ks+uabrXETlPZkedPnmbjgguuk9hZqj44+u0z55yh0Ci+dcn0NRvYX/5wPV3WQqtHwmF
	 /jsLVcCVMLWy/fac/dGu962HKk8E/LgyroHvv4PH5YI73zEeuFjbHDKzU8hnwlm1IuTqp
	 VNUeFGAHgGVJtd0c12s8vm0mV7boN2QBsIhkHwpT2/SAH8hDTryOFStS5YhcW3xPdn/E1
	 KOHF/f8Q2mDIi5bwarL7x3ruFDY2LCcUQtBqZ4evmccwIB+cFYUfOcyFpQtgrUHGJqfAm
	 6WeMAFVeoXNwyO8UOib/tlmNJWHNr6w1xBI/FzMhUlOhcBqOgJku6vZCkpI8z6yxx5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P4eZN/UV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD7606A32C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4eZN/UV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E081F000C4;
	Tue, 20 Oct 2026 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792462809;
	bh=+6D1iMcEiNp91wI9iV+LsIIjUJIqXv+F8ad2QlrDXZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P4eZN/UV50g8methjG2c+Pbq7OsnCvV8vBu8wMy9fibe6uiioo5FY8ph9Q41VDVyW
	 21EotIQnnlsYCNWTZhajb5D9AMutAXmGY7wfFQkbCs44veVSH76O9r58GK7+cwiyGX
	 B4y3jDR3507RN4Rsj+7K+LX6e8CXPjePzx3OBf2OUQbDCYlD4Kzh7Ij+yv4zuGZTbt
	 rjjN6kAhJUaNAE1RBsyvWvIgc/elRYA3OKB7eD6fgcmw63qLvAdA+jdg4moQ49PJoM
	 cti5ybk+Q18+jok8B612jraH7Nw0671amz/NZZGgD0ryPnROv8TVLMpqtcCRtPHf5e
	 fX2cKcHFSvrNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2AC3924A6F;
	Tue, 20 Oct 2026 02:20:09 +0000 (UTC)
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
Subject: Re: [PATCH net] selftests: net: fix race condition in icmp.sh causing
 CKI
 sporadic failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179246280777.3441618.8223791550221195346.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 02:20:07 +0000
References: 
 <b15ee681a330f9b05a9076a3852c186017f59d83.1791804421.git.pmukherj@redhat.com>
In-Reply-To: 
 <b15ee681a330f9b05a9076a3852c186017f59d83.1791804421.git.pmukherj@redhat.com>
To: Prasenjit Mukherjee <pmukherj@redhat.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, dsahern@kernel.org,
 toke@redhat.com, netdev@vger.kernel.org, dcaratti@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Oct 2026 18:23:32 +0530 you wrote:
> CKI reports sporadic failures in icmp.sh, Davide suggests this might be
> caused by a race condition where tcpdump starts capturing after the last of
> expected ICMP unreachable packets have been sent.
> Fix this replacing tcpdump with a tc flower filter that
> matches ICMP Destination Unreachable (type 3, code 0),
> and match on act_gact counters instead.
> This will remove any race condition to appear.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: fix race condition in icmp.sh causing CKI sporadic failures
    https://git.kernel.org/netdev/net-next/c/c6b97e579ea3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


