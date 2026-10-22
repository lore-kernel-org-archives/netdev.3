Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693809;
	b=hnaK1Azql2hHMCmvQyKroUeFZT2Qr6kkkqkMq/WeUA0ZoxfSAcsKf2rJkKwQFE/jf/4g
	 7lUy1v2PkfRkqliutKu/CS8ja9UTUb5Pds/kPG7shqQqUSY34eVkPBKwtgfcOS6KYhyln
	 Ay3mezvD2zRpMv48zJMBULIqQzoWsJbgxxMRWCTwmtYkgqGO6C+wkoAB7C7Qbfg9WA8S7
	 bLWmDjHAdlDa7PucpEUb2n2w8g6cTgRP66HOrvN5L6wzAJrNSjyaZxO4z8JjuM3XcqKAp
	 B+8aYnQO8FkLbGqftsoNAuCtqpFcidux3RwkADM6yav72y5a668rBaAjCPfsqoSkMbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=V4uiAV9aQm/yT3YxAR1l2UWns8mGT1BtwiQhbF6onIE=;
	b=fuNBvk7ng7+JehD6wTPGoqHXmNMUXyzJ4vrEwC/YoGvhT9t5yIdhqhuM/fkPk3vCBgWK
	 8RSo3OzfrJak3S0Qx8/CD7oQmRDAbMfkd+MpxaZspTMXGFYlwns6dDU9doqgbEnYwo+iP
	 sNCe/XQ/aTLbi6sIBQrB/GuvzLCjm6/ghYWeyhPWqCDVSTdQNfu5rZGqRyW8k2JDOUhcs
	 pvRtS43/uRQfim6xEI1lb66F3fi3koyGs7/vMe2RMAvDj4I+01Bjwu8ULJMywtCV9cmq/
	 lZqOKUikQheZbRTmDIQ+XxgcyaBr8HI4bAmwtob0ulKQ1Aiw7gu4QRmCH3gOmgUNJVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y74wNOwv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA6606A31E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y74wNOwv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE0B1F01825;
	Thu, 22 Oct 2026 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693809;
	bh=V4uiAV9aQm/yT3YxAR1l2UWns8mGT1BtwiQhbF6onIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y74wNOwvtjZSI44QVSvXqZZtnrcOySYEE7V5lvzQhc/j8W8vUZufJDPAlp4aonbqM
	 sfP8zDg6hKu1Fb7IJjdc+mh95KvcvQRGpal0YiQTWF4SDYt2XGRuNzLclWH6iD8P0E
	 Z/Y3Fo3ThMThfpuSLbq5Y3H0Tmwk8JkLYLa+XNvcJpTILpQNSSXCAS1OK8EaguNCXM
	 UN5+DQz8ZeoZqic4p5W9Fdz6B929pMPnKM18ojD9wzFJwnCOMifmJ5TUEOE8r1gm5k
	 eJa+5ThHShgNmQwe3IhfH393prManh/r6weWip/O4NwMoYBTwBHYWdiXVJ31MEDwNL
	 ko1TrIXznmHew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073953808222;
	Thu, 22 Oct 2026 18:30:09 +0000 (UTC)
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
Subject: Re: [PATCH iproute2 0/2] use get_task_name in ss
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179269380756.87273.3721149238282164503.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 18:30:07 +0000
References: <20261021160020.3838946-1-stephen@networkplumber.org>
In-Reply-To: <20261021160020.3838946-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 21 Oct 2026 08:57:21 -0700 you wrote:
> Recent proposed patch by Prashanth showed that ss command parsing of
> proc with fscanf is fragile. Here is a pair of patches which allows
> reusing existing code in iproute2 lib/fs for that instead.
> 
> Stephen Hemminger (2):
>   lib: add root path argument to get_task_name
>   ss: use get_task_name instead of parsing stat
> 
> [...]

Here is the summary with links:
  - [iproute2,1/2] lib: add root path argument to get_task_name
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c92418663848
  - [iproute2,2/2] ss: use get_task_name instead of parsing stat
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=89d08bac1661

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


