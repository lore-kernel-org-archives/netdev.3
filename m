Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE9322B96
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103601; cv=none; b=LbdxDVZQwDx9H9YyRYPZkYP+4WvbjUPL56LHMsjAXLTRS6XrJQCnRt5NUinsyqR9sYSyYXyu/XOVjGOcm3qkAFXW/D+AqHV1ZLwzfYWPdTNSjHqthqAX6pbWeNnKVzRlV/2q0HZHJJ6V13XqgNq5R2hrgQA9DDXSYqsKTPrW1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103601; c=relaxed/simple;
	bh=Z2yrPblRi/uSTrazTPHr/Uyx1ilvyXfOxmmgPtVNJO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pFfHVCa1yvgpf+29ISsqWkLS+c6Ar5A+1hIlSjGxQpPBSdD36ueA+i06hu1y27k5+WV5z0dvypxH/syVGI7PWMhOcu4RCgBHJbfF6Dig8Tojop6/JTbdvBT1GcTuGwJ1zCUQWD31jGzq65gHqqhyh+ofRUxtubjAPKIm2imee6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRIDy56/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRIDy56/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD4DC116C6;
	Thu, 26 Feb 2026 11:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772103601;
	bh=Z2yrPblRi/uSTrazTPHr/Uyx1ilvyXfOxmmgPtVNJO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iRIDy56/ak/Dpa8LdfmeAH3YGtt7LFX25g9rIKoDnYhzc5eDilvJADp6fNHRRvWvQ
	 ZLIF4SQy2qqK/e21Yuq0ggPH0QhVQqq/G/f4Vs9BYlwRWhgWau8MrRTld+wmpnNaN6
	 guLeuz1KxIoA41jE/MGNPsrX0yxpz0vtSknOpRD/PMbZtXCXSmIizxHGr8WqJ5Y86q
	 6f6ePT8Ww1tD7KaLAEXQfTxMNop4RWiABTjR/w8Hg5p3W6C1ANiaxy3OW2sWqTSstL
	 dn/ht+pip+G65qJmqlt9A/SwbSwHIz+XlqIT1XMaiKH3yaahCWpgEX79qMjYw5hPrT
	 HbvtOHvIH8TIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFC93930905;
	Thu, 26 Feb 2026 11:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: print churn state via netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177210360505.1162814.1807095523966101939.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 11:00:05 +0000
References: <20260224020215.6012-1-liuhangbin@gmail.com>
In-Reply-To: <20260224020215.6012-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Feb 2026 02:02:14 +0000 you wrote:
> Currently, the churn state is printed only in sysfs. Add netlink support
> so users could get the state via netlink.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_netlink.c | 9 +++++++++
>  include/uapi/linux/if_link.h       | 2 ++
>  2 files changed, 11 insertions(+)

Here is the summary with links:
  - [net-next] bonding: print churn state via netlink
    https://git.kernel.org/netdev/net-next/c/4916f2e2f3fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


