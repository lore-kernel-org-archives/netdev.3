Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9111D54FA;
	Wed, 10 Jun 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052025; cv=none; b=SLFqeLsaPl2iEW2Y+KpGYnIYJUBC3kQ35hSl9TWFGa2AIqeqq/LADRftWgsRPtSCuuDfVgFG3ulXrUU4UjqIdsfxs0LDqW0x2vnO2KbxIONAqJ67Z/xugusueNUqYIAjXa7D4d5GE/w5l+OHS0gfNo4FVx87P3t4kGLEYMFiuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052025; c=relaxed/simple;
	bh=Wec6zqrcBzOlACdwz/ACztWmBPO4nOjOVuG9YmQeQ3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kMGqM/go+NEkhtd6/BHMBr3JKGaps1isuj11jM97NsPURFl/tnMA053izSqvZf0J2nZFPK4wYvLREBaqR2i3k40ZytYQ2N+Lqk008JuUNs0un/Bw+LwZKrtqF8zCKNAoK0uC03xqOUavP4uUOROt7bJl/KK49eG16VAgVKK1meM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqcvWO0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqcvWO0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2391F00893;
	Wed, 10 Jun 2026 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781052024;
	bh=1rhzUE7UbGE4ED2dG3KiYD/nzMu92AjN5wrQhrXdVFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LqcvWO0dkQIb3iKt6xHkwPVf6Z9uw5iu9Q8A/fTbjtMddVAYaKxLtCNDNB7rkm4+p
	 DVqvYeiLvHetQTFeg0BXrcXYpCM4MxklM4bmGGCy/tSPcsH/Rnqszs7ylXwsnFAxI6
	 S1EGFeAjxBDBZ3Ykdav389xTbwe+CCBQfa6tEIa0sGoGV2vrg1JQ+crrWn5Lt+eNkM
	 BF4+Fi05SzxFaQtc1x0QDCb9wkUboTHZw2ftOP5adfTNQV7PHBzTdjt4t/5q7VaSN3
	 10ZhoEiXZf8i6tIKaRVb914zm67ixK6bo41buaTqN/QTvPBDoE7r5DIHew5wLDIZV5
	 JlQV52e7fosOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B053930A0F;
	Wed, 10 Jun 2026 00:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v1] net: ncsi: Set ncsi_stop_dev() to inline while
 NET_NCSI
 not enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105202285.2767403.11674487906246488361.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 00:40:22 +0000
References: <20260605033607.37630-1-minda.chen@starfivetech.com>
In-Reply-To: <20260605033607.37630-1-minda.chen@starfivetech.com>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jun 2026 11:36:07 +0800 you wrote:
> While NET_NCSI not enabled, ncsi_stop_dev() is not inline
> and call with it, casue compile waring:
> 
> linux/include/net/ncsi.h:63:13: warning: 'ncsi_stop_dev'
> defined but not used [-Wunused-function]
>    static void ncsi_stop_dev(struct ncsi_dev *nd)
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: ncsi: Set ncsi_stop_dev() to inline while NET_NCSI not enabled
    https://git.kernel.org/netdev/net-next/c/5c9a6a124afd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


