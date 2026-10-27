Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793143208;
	b=MQJvj3UdXRfltSqaPAKOsg6zodL77rQiLI4+R6kcp8o+vU7TQ5EAlx20gAQIQ42ZfCuJ
	 oZYEHCdbubwt68DBhNgpbWZLJ/ncs705u8JasLh17bH8z0+msmRLorz95f7AtcWY2/3ui
	 08QrGXrzHHL4QKWIUTcNJTjp/FLC1s3wWlWHxLxJ4mg3+jlNeHRIpsp3ZSa9R2pqdc17C
	 +wJKFz0E84Ci1fevXMP2d/Mb3qdSTM3Ys9dPszV9rqEPh/7O5+Rb077GtISROJAaqMAux
	 sOjfHdlbvMmt8J+8sUsFacxNUU3zmlQ5/tiQyjRHEg8ANjU/hXGwYAryPngBeUrEVgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=C1YzYxWQLlY0bleKlsvWkmwPfmAxiSghc2kv9ELLlIg=;
	b=2R6HcNPgLhE+vPAp239xXTjtvCSIRMOUqfTxkIxK2p0kHhlWDXvr6RJUt/FtzMJ7FKI6
	 6NPNSNdOvQ01CuE7b33riXYDVdcHCUImJop8o52L/y7Tk/56fQPSONNLTOsF+M+QXQtCw
	 R6C6zUye8kPSVbhLcpY9MNOESAUNPDNBel6zGvDqnJWa9eZrmytNnz8ontD1XiuqB1dWd
	 Vi0dV2eBh8bow/YByrLrLbResudiMQE4IjPUzpOmtaWmFZfT3vVhj7L4tiuZwksHqjguj
	 /i/V1BOlbhEr8W+g0BrjXpB/jlHyHVONWfPKp1zP0pzT1G3N1Vj2G97vXo6V5noDJvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpnF4ims;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063E606A31A;
	Tue, 27 Oct 2026 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpnF4ims
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7641F01825;
	Tue, 27 Oct 2026 23:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793143207;
	bh=C1YzYxWQLlY0bleKlsvWkmwPfmAxiSghc2kv9ELLlIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KpnF4imsBD0T6IoQiPgmxaGepdupRSon4aahO4eWlEZs5aGsVNiRzPO8+365wWBMD
	 kOKSNxWf02IlCKUsYMxbC1WrOdcyYNno9LzWYRnmo0F+QqlUbuwQ2xFCBE+ZLGc9lX
	 x7iC7/cMtmmO3FVY+4JAumNwUA5jERFt5vvm2CpfvhUUxIY/QMBgnkpWjKcBYbmJgj
	 zaTfqpM1TGXjBQr5afGTAWrP1pU9uT5zohdE3tM2P8HtxKvHI6RczMUvn7E+kyw0WD
	 NZZlOwegWYLcvAjv3P5AF9oOFDf+7tU7bOAuDSxBKIXr8sgDb/27im7yb6v3PNCC/h
	 Cptp46wlUx56Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815AB3AA9413;
	Tue, 27 Oct 2026 23:20:07 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/2] net: dsa: mv88e6xxx: 88E6171 stats fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314320632.387971.15732408988094892405.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 23:20:06 +0000
References: <20261026164733.737299-1-f.fainelli@gmail.com>
In-Reply-To: <20261026164733.737299-1-f.fainelli@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 09:47:31 -0700 you wrote:
> These two patches fixes statistics on the 88E6171 present on the Linksys
> EA4500 router. These changes were found during testing using a
> resurrected version of Andrew's dsa-tests:
> 
> https://github.com/lunn/dsa-tests
> 
> Changes in v2:
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: dsa: mv88e6xxx: fix 6351 family statistics snapshot
    https://git.kernel.org/netdev/net/c/9663edfa71e8
  - [net,v2,2/2] net: dsa: mv88e6xxx: fix 88E6171 statistics type
    https://git.kernel.org/netdev/net/c/df66431f3942

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


