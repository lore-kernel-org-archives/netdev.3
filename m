Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80D385D72;
	Mon, 24 Aug 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598075; cv=none; b=ppQiACLWogQuDKbsoagNQr6ZSVf/DrNRXmLS8gzZxwEjthVU2ux1ETVdS2qUX+Spp8Ivc1UasHXVa1jcxsDduP1T7MI5c3gETtHtfaAx07fA8dUuktVhFyijCdO54XwtUxpKgYBoR5W2WXkga7Tao3ts+zp90h8fzFKzA6VGogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598075; c=relaxed/simple;
	bh=CIIhDx4Qh5CUHCZ6RoA1yRbZyrzZvRZhxcsjGTQrKqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O27Ivdsiqrrxhn0wZoM04DVkg4m6ffGYL1t/56LDn+SnCMaW3wj3u0u3O1M40plggFcwhJDYgWkxh6+WMnaa04W8D5DXEBeGxB3trv2JtA6kOf+w8ix3Yy2D/Pm49TtZHYyN4hjHIhOzNKAQ7nJGglMrhYMf/+RHw9W+wkMGtpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEE76UKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEE76UKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ED81F00A3A;
	Mon, 24 Aug 2026 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787598071;
	bh=dMgQVR2MUg/7z09hc0v2yKca19wEvL0Ux3d2Aed3e58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DEE76UKs49SyDYUovj24oDD/diheqAf9m5/4LFA2LY7f2C3l7JNDdrfTcVVCLO6EN
	 pnYAunnvBrN2Rp0cavrr0Pf6aCNYJpRUVBuCwm6pFf05QYzyoylETWV/CLGUNSw0Gt
	 JWPVRctHTUBL5QQcKJJT2aCMSNPD2jJd609Ea7PA/UpItSuJfjykhas4qSMBffJaWK
	 Yh4eQVwqSWDekG+eE58vrelXrwieYL2oNqX1YFFPCFbtynXeBBeEUqcKt+X96ArD9c
	 Wj7XooklIrZ80ZfkRVQjpbgbeiC9CoNaZpM+qlN8nw41RYec2GBK58KMzmJvUQE3LE
	 z0LSm0OrFzlnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9399F3924A4C;
	Mon, 24 Aug 2026 19:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: Fix TL3/TL2 link config ENA clearing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759801913.3065827.2275828043735949673.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 19:00:19 +0000
References: <20260821055445.2517568-1-nshettyj@marvell.com>
In-Reply-To: <20260821055445.2517568-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, naveenm@marvell.com,
 sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Aug 2026 11:24:45 +0530 you wrote:
> From: Naveen Mamindlapalli <naveenm@marvell.com>
> 
> Clear and restore the ENA bit for each TL3/TL2 link entry during
> SMQ flush instead of repeatedly using the same link index.
> 
> Fixes: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix TL3/TL2 link config ENA clearing
    https://git.kernel.org/netdev/net/c/9edf8d4876e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


