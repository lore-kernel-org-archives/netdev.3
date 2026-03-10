Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35F3A5E92
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111642; cv=none; b=TgWf4S8FLD8rFbC909fr2YyNPsA8VB4nludyISOP0E9gMnCTnYO52L5S6MB2b0M8o6v8fQ76FFC37wQ8tFISDzbGO0/7FK/qtpjCYVfyAGfv7+WK6aCeRJ+D0ts6jDeSjjG77PII5soX9zKHY6T5FaL/YJpeyLvyRlCtlvGxNg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111642; c=relaxed/simple;
	bh=Ev2jt795SSlyT2bwyc6t8MpaKfoP6MYpfECOpM0eHdI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T+2NfomKNhWomA2Bq6XPKyv+UzWl2EYAji9PtDHI6qQqYwTHWfD1c4fXfrHU5mHrAJJWbw8gYfqnrUAP8aDIPawL/+dPlDcryi8nXzEODZRYWBBZR4KjQqQZPv/dCosZ9fNHqCdtQZOPbdUsOr7i62Uou7/f7NUKO5OqmIx89d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njRW7VV0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njRW7VV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BFCC4CEF7;
	Tue, 10 Mar 2026 03:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111642;
	bh=Ev2jt795SSlyT2bwyc6t8MpaKfoP6MYpfECOpM0eHdI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=njRW7VV09f1tUZPMmLPFShsgB79U+Oy5CvWncJYyj3f3JBlG/+XdgAuSSZkGO4JFZ
	 tUmiOIvXMB6xSDzSn4rfgVbrK1SIasI7ofhsYmHe8aP0/YxUz81+5USy3HwgWdMj9m
	 gThxp33TIsL9d861hGXhMInRYvV1g/DzUGmKtonFhr4unoE4SBSXhDQnQN57k0IdZ2
	 +kafRqPySh14e5G6ERnsDiTdhKxDIaukmmuEdydxIjIHFW7FcfHa7WS+DrJpJGhFJ0
	 jie1A+QSf0QePs7uzcni/7uHYXU80om1rnPp/55qDLgcXdTLe93+JTOc/xEzdgud4B
	 QQLRmudMuDTvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1C93808200;
	Tue, 10 Mar 2026 03:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: inline tcp_chrono_start()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311163929.2039470.17479343423830760610.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:39 +0000
References: <20260308123549.2924460-1-edumazet@google.com>
In-Reply-To: <20260308123549.2924460-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Mar 2026 12:35:49 +0000 you wrote:
> tcp_chrono_start() is small enough, and used in TCP sendmsg()
> fast path (from tcp_skb_entail()).
> 
> Note clang is already inlining it from functions in tcp_output.c.
> 
> Inlining it improves performance and reduces bloat :
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: inline tcp_chrono_start()
    https://git.kernel.org/netdev/net-next/c/d6d4ff335db2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


