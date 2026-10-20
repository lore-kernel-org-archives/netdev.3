Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527019;
	b=SZ/3JcSgfr1qN56Y8SSmi3tajSMXKiRwgXybyMl6cZ7snqEtV4TBsTbZ6txoHxq2OFcf
	 O6AKewjBT4ez3frkup5tIfZb+Y2wHqA3psxAI/APJhMaqqVyE8Zhe9xk0A7QKSqqaOPA1
	 UE+OnuABs3D62BvZRpvd16khqQY1XQCjHPO9pog2UR/bqjLHqQD1D4jhTO3tSlsHQ3b2z
	 lPPBrBGs5zx067OX08rFnon7QYdcFJRzV9TZevmlp4+GoN/wW/4mMRbnOvrMf8GAvEq41
	 z7KNajJHxZ/L8gLl8h0hL8L/nBrZ/DYu8y3SIKgAIX9aOPvlVI8uqX/cO+bSZlCBlpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527019;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=J3GZrWN/skKkFItCr+vLZpAakLmzUQqC7xctG3rMm+U=;
	b=qlwpG7mmQo+Ai0g+qntQqyvuY2XXa1cH7n7JHgXVGAjU4pd4semGMX0VPa+Q7Oy1qxMZ
	 kjvL5QlGOEzQiPRnmSTG11tD/k1wDujFL3r3YRdmF8ps+kL7y2875AVcTxOQwza9vKH1Q
	 BWGCQpmWuGDYyykXOh+2qBS1hKpcn4o/+Q38PDI+nMmuIA3mlKC/bSuB95enHkAlFe1yA
	 EcCzvyvjtEuP9GX2low9AK/zU0LbbNgngCjyGD/bEr5O+KsyZHahjy/neaK9mPM5QQ58c
	 NIuHjIQxjBZa7s9SCwzyqTlPr70u50Y88LD+KcQ6DKlyOSBQQDOzNSiSCm1GEUeT5Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEhIxgUQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60728606A319;
	Tue, 20 Oct 2026 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEhIxgUQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D2B1F000D0;
	Tue, 20 Oct 2026 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527019;
	bh=J3GZrWN/skKkFItCr+vLZpAakLmzUQqC7xctG3rMm+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HEhIxgUQI8fl18vVaVhEbNyISHP5R2NLcxDWYxKNRRnuprspFqiKglBnqg0a2hsxL
	 8a0T1u5Xn9bG7hQIOh4Q/xQCj1QmiYfZ9PDskfKPD0125rqQsw49mfiXQoPALnmSfI
	 8srs29NTJisNj1J+uFrm0DyyCMRLO1ioTAG/2LYujbL+vFg4q0zFR6L/COKiqDHe+l
	 iuY2V6t7GrOa9rNJVzaoFlnzB7IH3LV/4SsoWt+7lJuGrYoDbOyawcxJaQ+DBONE6Y
	 o8h6wyoZrXCGiX+lYsYxBlUv6okWGCq8mEIzrhKaQznYz+JVhgiU0jYiHF2xTpl1SO
	 OatNkzb/HKO+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15343809A09;
	Tue, 20 Oct 2026 20:10:18 +0000 (UTC)
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
Subject: Re: [PATCH net] net: hix5hd2: serialize timeout recovery with
 interface
 teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252701752.186787.4792188707479278669.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:10:17 +0000
References: <179203116093.2621539.3718842986255459438.G202@gmail.com>
In-Reply-To: <179203116093.2621539.3718842986255459438.G202@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: shenjian15@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ae878000@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 22:26:35 -0400 you wrote:
> The timeout worker calls the driver's close and open methods without
> RTNL or a running-state check. A timeout queued before an interface is
> closed can call close again after ndo_stop has disabled NAPI. The second
> napi_disable() can then wait indefinitely. The worker can also race with
> an ongoing close.
> 
> Take RTNL and skip recovery when the interface is no longer running.
> Use the netdev core close and open helpers so a failed reopen leaves the
> interface down, rather than leaving it marked running with NAPI disabled.
> 
> [...]

Here is the summary with links:
  - [net] net: hix5hd2: serialize timeout recovery with interface teardown
    https://git.kernel.org/netdev/net-next/c/87cce46329a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


