Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34D1CCEC7
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671534; cv=none; b=JHLVjmbrY23UJPCLMmbXT/JQ4iVnubFtSAU2ZFcxg+SybsipjYaCgiCHi6qo08rO0uln7F6HEixDcoJfXfxGT3RGsiwJWmkqmryQ5Tw4h+y2WucVPzDbUOR4xW9NzJSqCh6kVdVVQjSJPHYCCi/86A3Kuqtol9KyfAzmBs19H2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671534; c=relaxed/simple;
	bh=Uiv4aIWpZ/IJUSCv1VnneEQlSCmUogljmQT744X0HU8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B10jiglmJambclSm/TX/3BCw56RxHVJabced5KWoPKtdg3f+D4OX25JNzXvdWHIS6flM/q3C+Cr+nWXiTKaQVW7nGjjbvtWikg/HVFqpQp0rioegfiyP9M9SpWz1KDvhVhxVgJqLLYYyTFYWnkRRBWdCvP9KgfSVdkoX+IMH/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7wp1Vbv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7wp1Vbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDE6C4CECF;
	Fri, 11 Oct 2024 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728671533;
	bh=Uiv4aIWpZ/IJUSCv1VnneEQlSCmUogljmQT744X0HU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J7wp1Vbv41AMBBrb54nEhUoYkvssuD5pcGkuNGGUKU2ATT05vSo/o6sn3rChYurcX
	 K7nJcd8cUyidOnfkQQJ7DOn0zvUS9dadwx/qhWFjSyhilbA/oeSjQi1vY3QR6qH59u
	 WN/7un93mEmZ3i0P2AUtF4eGi+rHJFbSfhWNn8zt6XRhh351L7vVhFDN+dtk0fTRPk
	 94WtqybI/k/QGtwQ7Yhg8pm/4Hs5BfYNsbNUq/KDOHt4Mu0igFF12qv3zmQ6u7U4Wp
	 1fJX0hsAWIwAavZocmbQoIIXSjJkWG9qmFQ6lKS32Xi8c68HAE81+eorvSQjJ20WJy
	 04NaSxGIEaJOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AFC380DBC0;
	Fri, 11 Oct 2024 18:32:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ip: netconf: fix overzealous error checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172867153798.2893426.17357382276165605918.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 18:32:17 +0000
References: <20241009182154.1784675-1-kuba@kernel.org>
In-Reply-To: <20241009182154.1784675-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: stephen@networkplumber.org, dsahern@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed,  9 Oct 2024 11:21:54 -0700 you wrote:
> The rtnetlink.sh kernel test started reporting errors after
> iproute2 update. The error checking introduced by commit
> under fixes is incorrect. rtnl_listen() always returns
> an error, because the only way to break the loop is to
> return an error from the handler, it seems.
> 
> Switch this code to using normal rtnl_talk(), instead of
> the rtnl_listen() abuse. As far as I can tell the use of
> rtnl_listen() was to make get and dump use common handling
> but that's no longer the case, anyway.
> 
> [...]

Here is the summary with links:
  - [iproute2] ip: netconf: fix overzealous error checking
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=6887a0656dad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


