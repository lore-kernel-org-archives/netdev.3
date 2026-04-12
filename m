Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFB312807
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010853; cv=none; b=k0ngnIW9QPbmq+YHn+9uQjaKg067acwA2R484+Fo5GUGe4RTTW9OtDBVReWAZuh1m+iOLayRFx2zVksNtrgb7DuMPRpfPPYd63VyFuCCiQkarrrioJTUq2ckPI840h0BXrqWJI77Fuc20z93t0t82yJqRVJ1qIapBxfpcboylrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010853; c=relaxed/simple;
	bh=TyOr+Yi4ipPizfFnZbe4vBNs6nxmE8rl0PlOieBclGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZhV0wy7il/GjphKMqfH7WEFJYubPvucW8ODxplrV1bO8y2T9Hal1Da2Rcs4Dfu5H1fBGB44I1PbQrNE2ahXCoL0E4dP38Sh7RiXnYwH54ZNJUTjQqvGWz40vzGIDAM6LyV+ST8tMG0dYxokLODGlPe4w9PwWdcZdWX2euMQCIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqjiMrVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqjiMrVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2D6C19425;
	Sun, 12 Apr 2026 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010853;
	bh=TyOr+Yi4ipPizfFnZbe4vBNs6nxmE8rl0PlOieBclGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KqjiMrVLDk5HSzFAEqmRgwkXOWEolfCNyRfrV2X9Pf3V+Y1vufK90VTy4wdL955Or
	 AFX5gtT6jBZCT8E5sfpSRqHrSu2dbgLv1KtMua7ffckV7slRFysv5PKIk+YctMvwbw
	 zcrnoma5M1LBNuDje2whlKyDWu7/WOE2LYsDXt/H5bciT5TyDIILbG+YKYpNlHhnFK
	 G4Dz1pKRMgsurvCCXQD+NO/Sj1/VgB3I1kVqE9bQb1yTsYOLyjsihB0dSQC4779jW+
	 U6jKVzTdI++LJ9JBoQhzvewOmRnNNkgwqbRP6EsoovgNedXgB/Zo2O8Qnt836CEJ8l
	 xcf9H8xANlxiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD233809A8B;
	Sun, 12 Apr 2026 16:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fix reference tracker mismanagement in
 netdev_put_lock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601082604.3330556.9263984031259517889.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:20:26 +0000
References: <20260410153600.1984522-1-kuba@kernel.org>
In-Reply-To: <20260410153600.1984522-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
 skhawaja@google.com, bestswngs@gmail.com, razor@blackwall.org,
 daniel@iogearbox.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 08:36:00 -0700 you wrote:
> dev_put() releases a reference which didn't have a tracker.
> References without a tracker are accounted in the tracking
> code as "no_tracker". We can't free the tracker and then
> call dev_put(). The references themselves will be fine
> but the tracking code will think it's a double-release:
> 
>   refcount_t: decrement hit 0; leaking memory.
> 
> [...]

Here is the summary with links:
  - [net-next] net: fix reference tracker mismanagement in netdev_put_lock()
    https://git.kernel.org/netdev/net-next/c/0aa72fc37e15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


