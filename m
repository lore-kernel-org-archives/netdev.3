Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF923AB9D
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770949218; cv=none; b=fg2PDoI1Dcd6RsmesIUDIBIMPmdC/Q+C8UloYNuDUzmGsgo9dYIHbHiagplWjBbvq4Mkz+qk0SdmOnNEVXfevNzAk8CFufp3coNFAfdboZOaYSRbDawulfbwn/Zba6vIsBeuvV/vhBVsZNUTWLm/o5/tcNy/hLF7+6NO81UHz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770949218; c=relaxed/simple;
	bh=WIKJ2LP+y8vitZiGH7ZU2GldWWA6i4qo9q921Hh0bvw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A3matx4cxFVM2Ca8+Kf+VqSFihFoiSFTXPKUBImSvTZoWd/btW7JgfL4T0o3Ppbib+3MveyhHe34RiqR7f8jwcV+zE1lbZsQj+MxNZmlNWyhMjGP6HOTs0Jtszuo4PtjPQeNe/38x/GRDN9FfwVVf4tTkhaPWedrJa/2oAX6Z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEI3WzB7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEI3WzB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B02C4CEF7;
	Fri, 13 Feb 2026 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770949218;
	bh=WIKJ2LP+y8vitZiGH7ZU2GldWWA6i4qo9q921Hh0bvw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uEI3WzB7XLd1fcclPXGMhJQXLNyyAfu6B3xTvI7VwrXlSlRUsWJPokjvkdzdG8UYw
	 kzvu6N87NPpQYNvhlm/kRwvFhANKWeSUEKLw/iu+3XBMZeH3eNi+QUbuIvdryycnCg
	 iq6LRbditbjSN5FnOzV/VpWRbeHXl66fQd1Oed50qYaUZvG24DVbSffZoHpi0sLCzq
	 QKlf0ST6szdISZsVFN1LUmTjuHrv83ArbpR00P4GByf4qqh8cdliV2giM96w226Agg
	 2F+2RcLljxZVAW4TvgPIOrYeSPVLBcXzroJNckKXc8VcKLD8QgRVcnk8+uQSsunPQ9
	 tLWDLdst8BRpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85266393108D;
	Fri, 13 Feb 2026 02:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] myri10ge: replace comma with semicolon to fix
 regression
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177094921207.1813136.14656090554617621428.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 02:20:12 +0000
References: <20260212055028.3248491-1-nichen@iscas.ac.cn>
In-Reply-To: <20260212055028.3248491-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, arnd@arndb.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Feb 2026 13:50:28 +0800 you wrote:
> This fixes a regression introduced by commit fd24173439c0
> ("myri10ge: avoid uninitialized variable use"), where a comma was
> mistakenly used instead of a semicolon.
> 
> Fixes: fd24173439c0 ("myri10ge: avoid uninitialized variable use")
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - [net,v2] myri10ge: replace comma with semicolon to fix regression
    https://git.kernel.org/netdev/net/c/7c375811b511

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


