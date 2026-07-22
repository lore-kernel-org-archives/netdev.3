Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C17318ED2
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784685038; cv=none; b=XyGwk+ml4gcAuZZw1ivY5F7Jce1ULIjCi2FOyKQ4hDorKsuKrMn/BLgjN4zmcSiiDfHgZpUH2jko1pzg5rbze9AKUXLzbtMgIhe7/QqIMFyYQ64y/oHhX4XyaVvYOUledMg0b6BaDylNBEMZ/Xw3jJG8scxdOohyzv+8bzyHfAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784685038; c=relaxed/simple;
	bh=9AMWS53CN3EeqX9R8RGg9Xgxs/9BSWfDwroIWmO5LG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xq6jXb7g9s3uGrfz3NuoMQnMZTILBUN+F4mLetjy+ebFKqNeTcIMPL5qwmfiHCUeXny9IhVuPbJSz38h7s6b3usPP17rfKr8n253k6nO23SBeSvI615c6BUjpEKDMAKDYfSmZbua1+20kEW3hn4794sZiQCRb/1d04LxemJY9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc2Xhe5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc2Xhe5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9154B1F000E9;
	Wed, 22 Jul 2026 01:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784685036;
	bh=HCtR4XihEcl+x6G9VYfHR3/rN1FVa7I1j14IHltO1Qg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Pc2Xhe5OnF9vmZeCN8yb1Di5DmIZHsRM3OJAc49qeMAfMFnH9oDtkGtY169knlgVG
	 +iHC6KQaRjTNwEKhE+4Q4sLWOhegrqV2zD7Zy/yMKlWbcDEOrT25hC6NmXf+GVUZDr
	 hJoec4Kqb05dmU7t6ulIxDHIRyOFuXpGqmB7YHr2hNA6LWIHRo97DC10ce7qaHizre
	 x2oUT6Fo7+dbxhr5RrGJzGovnsAjY9xNGZbnSaWMkcLqH9jtEHQ8qbC7ztJVreBQUD
	 9m86Epfa3GnGWMJZPT0d37EWD4DZj97yFuUGiieBRSJWAfmU6pRzlVdNQxa3N5DN42
	 UUxHfuh4dcguQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A58380820D;
	Wed, 22 Jul 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ppp: annotate concurrent dev->stats accesses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178468500590.1198902.11410145449698638358.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 01:50:05 +0000
References: <20260715055541.1147542-1-edumazet@google.com>
In-Reply-To: <20260715055541.1147542-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jul 2026 05:55:41 +0000 you wrote:
> dev->stats fields can be updated concurrently from multiple CPUs
> without synchronization.
> 
> Use DEV_STATS_INC() for stats increments and DEV_STATS_READ()
> when reading dev->stats in ppp_get_stats64() and ppp_get_stats()
> to avoid data races.
> 
> [...]

Here is the summary with links:
  - [net] ppp: annotate concurrent dev->stats accesses
    https://git.kernel.org/netdev/net/c/ba712ecfd942

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


