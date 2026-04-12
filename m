Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EDD201113;
	Sun, 12 Apr 2026 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017447; cv=none; b=oaAm27987dcmtOT+CiDUW8A2nc8D4jFcOJ9UCyNqcRtn78YISPwicxUizDSfjpJwHV3+L1zx5SYnglbq99D6hsszVsP6/r8gQHpCH2QdviBAcvfwmPDPhHrSmU0yXn4XkqcqeXE6DJTMw79HFnIWQ0dz246FapjicYZjge13aPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017447; c=relaxed/simple;
	bh=ySVxS9j5Wv+G502QHwUBlQViCzpP+9Gtv2BCilonuWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YDInXrlmsrKh7afqFY4N+YDzRIUonSlM2Sr9Mn5WUfjlHgERoOpTpv8q43/0mXC/OQ0HSLYOmNqxVIgljRMW1DhWYNTZEyaHN5O1K96LNWa6d/OqE2Od+gREmzNloGw/S01xZ3rF0s783tCFOgTSO+L3sM36kWsDzGc799KEyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/ckZr/X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/ckZr/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B96C19424;
	Sun, 12 Apr 2026 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776017447;
	bh=ySVxS9j5Wv+G502QHwUBlQViCzpP+9Gtv2BCilonuWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E/ckZr/XwBfqVVPycEq7VWDDkk1GqCN8X3oqhqDvBVXbOEMXVW52y20yD3qS9h+gy
	 j6tTg/CD2rzrwUS3z0dL6o0eJIulPw5hTZrS4EbWnK79tUjbsq2N8QlVZuqvEpk6HX
	 U+sA7ROGKv+DUMhszhPyri1EOfwzWptecVv4Sksh+0tzMJU5jgc+fB31iDB0mpwF6h
	 de61/awnnWacb4sYGQCI9YfNTWNgfGoeBkDigqPvsLEH2uoISCRA4syS0xOsRFUqWj
	 KShJ7GIR6h2pgAZVnN01Z0st9h1bjDOBCigrFCSuUoPPHmXozwAQnn5JeWNrXeBlzD
	 uvwStwLxF+mQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F2F3809A8C;
	Sun, 12 Apr 2026 18:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v10 00/10] Add TSO map-once DMA helpers and bnxt SW USO
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601741954.3362600.9685441999214600166.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:10:19 +0000
References: <20260408230607.2019402-1-joe@dama.to>
In-Reply-To: <20260408230607.2019402-1-joe@dama.to>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 linux-kernel@vger.kernel.org, leon@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 16:05:49 -0700 you wrote:
> Greetings:
> 
> This series extends net/tso to add a data structure and some helpers allowing
> drivers to DMA map headers and packet payloads a single time. The helpers can
> then be used to reference slices of shared mapping for each segment. This
> helps to avoid the cost of repeated DMA mappings, especially on systems which
> use an IOMMU. N per-packet DMA maps are replaced with a single map for the
> entire GSO skb. As of v3, the series uses the DMA IOVA API (as suggested by
> Leon [1]) and provides a fallback path when an IOMMU is not in use. The DMA
> IOVA API provides even better efficiency than the v2; see below.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,01/10] net: tso: Introduce tso_dma_map and helpers
    https://git.kernel.org/netdev/net-next/c/82db77f6fb16
  - [net-next,v10,02/10] net: bnxt: Export bnxt_xmit_get_cfa_action
    https://git.kernel.org/netdev/net-next/c/268c63f2c6b2
  - [net-next,v10,03/10] net: bnxt: Add a helper for tx_bd_ext
    https://git.kernel.org/netdev/net-next/c/637237d3d93c
  - [net-next,v10,04/10] net: bnxt: Use dma_unmap_len for TX completion unmapping
    https://git.kernel.org/netdev/net-next/c/3cb430e62c83
  - [net-next,v10,05/10] net: bnxt: Add TX inline buffer infrastructure
    https://git.kernel.org/netdev/net-next/c/0c26a0e765e7
  - [net-next,v10,06/10] net: bnxt: Add boilerplate GSO code
    https://git.kernel.org/netdev/net-next/c/0440e27eedac
  - [net-next,v10,07/10] net: bnxt: Implement software USO
    https://git.kernel.org/netdev/net-next/c/cc5d90667db8
  - [net-next,v10,08/10] net: bnxt: Add SW GSO completion and teardown support
    https://git.kernel.org/netdev/net-next/c/87550ba2dc39
  - [net-next,v10,09/10] net: bnxt: Dispatch to SW USO
    https://git.kernel.org/netdev/net-next/c/28f2c22398fb
  - [net-next,v10,10/10] selftests: drv-net: Add USO test
    https://git.kernel.org/netdev/net-next/c/5d3b12d1a24b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


