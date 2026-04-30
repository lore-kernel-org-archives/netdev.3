Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6B35C1A0
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582252; cv=none; b=IWT65UgtCfBPyhNi5KA/KPMj9fpqdFwaXzJVjNwl2EPzO3iFN7ECq+iIBkDQkIM3lliHL1b4MVhikK++/MutnA3qgYe2EfUcL8MC4AYtDRAwW05cUEv0cF6rgN3lJYlmko9G7xtVim9/EnZqv7b60/yMMuzNaH0Gsr4dnAyBpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582252; c=relaxed/simple;
	bh=CFgfpR9D5FEp93q+wOjAvPsmxavUw22WMhsnYPtT4Ms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nh2vFmbU2SvzLgJqsVJHeyE9Bb4GPEos3gDG78yOTpDsAmfPRahQxZrFVNYP0lvXykWJfEq3CMoHH5dW5C94GrRv+mO1KTPJv2cAOk2fN4/Ug3kdmfnEAQxv7i0tOWqTQM3Jcpm9rCNqBw1qlnvlOaTmRE1ly1cxa0H5cPtAdCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzuADWQn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzuADWQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737C1C2BCB3;
	Thu, 30 Apr 2026 20:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777582252;
	bh=CFgfpR9D5FEp93q+wOjAvPsmxavUw22WMhsnYPtT4Ms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kzuADWQn3zoGqhLxtMCV8Q8Xe87zzXTF+/PbXUqa+Q4v3AGW+dNqRKgiBvSFjABQ8
	 kpCpBjh3AbPNHi4gYHb3GI2LPbGubIH/FBeAF3KYKJz7l9mK+JVghiFI/y82l9iuPj
	 4Xl0SOYfRtXHzU15kxKg/gmJ2L2Z+ckcId1vE2ci/+ZCrbONkZCIP3Ma/fv5ApafZH
	 XmoICNshS6D/NGb0tBPuOBv99Uf4uoQbvWYFwfbPm9nqe1wESJ53PLv7XApBHGTBwz
	 S+6dy41vGY6YRNC7fm+W+pfcL35TdBjpJAKBjPtqATd/bPxd5Uh50M1bdwKVF+O2yZ
	 m4aAclclpyfzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0317A380AA7D;
	Thu, 30 Apr 2026 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mctp: test: remove skb dumps from test
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177758220580.3198946.7586606245510104457.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 20:50:05 +0000
References: 
 <20260429-dev-mctp-test-skb-dump-v1-1-13fd5789ef71@codeconstruct.com.au>
In-Reply-To: 
 <20260429-dev-mctp-test-skb-dump-v1-1-13fd5789ef71@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 16:27:31 +0800 you wrote:
> We're currently dumping skb info in our fragment input test, which makes
> interpreting the TAP test output a bit awkward.
> 
> Remove the skb dumps.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> [...]

Here is the summary with links:
  - [net-next] net: mctp: test: remove skb dumps from test output
    https://git.kernel.org/netdev/net-next/c/8ca4bff2ff3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


