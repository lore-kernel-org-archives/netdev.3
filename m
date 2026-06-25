Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85B9291864;
	Thu, 25 Jun 2026 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354631; cv=none; b=OltZKjAOjLPRHCJLZaqYjZEImAtgI8aU3wBLK3rxYSALiGYBY1VomXNDBgaR+MpMzrXBBQD4K9UJ+4myAp3p5NlkAoJbaizkujhRLVwbfjjeSlWj3FYPNGmYiX4LS/1HgqcysLNOl/hSLV2Tefrvuqz4NaFWxuet659/KtZhUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354631; c=relaxed/simple;
	bh=36od0SAxV4us8YLYfcAlR821hybrM+Wv8rkrvO45jWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DURaxOQHq7tJlUVNhdHZ6ktCDku/IR4EAdhUge/PUv5PLSo9A9U0jodN1EgFbZ/+9F31H3TMJVV0XAG8fDGnkayLpUmfmcZ9mwOzlqqj4Yipyo8xPQXk9qVbMcR7+ZQPn+YyW/twSwGWV8GBqUMaCiW6qojx8nszX2KvDtDzjcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3PMyMTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3PMyMTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F49C1F000E9;
	Thu, 25 Jun 2026 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782354629;
	bh=N+W7hFclKgSoE9HGay0SP9eQ+4IK+3tCoc5LaiHoVnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c3PMyMTN09oWqOkZ5A2Qt/hA0DFrdlG0kDXBzH8xAJ7UbeP+56Qp6pift9JelrkBv
	 N9s9ZnVDYhip+/pUTv07uAy2xp1EwtbCTl56MYfNTEmFqsoU2GbBil1eH53z7Bl/xd
	 xEIYYx+PHzoGz1nYfilkceWoEJi1XVBoqARB9PFYyq3JwhcETd4tR+sfk+YsyISo64
	 7TpC88opMvArYzAAGYFhi6j6RXlAtw1W9hAPbuZCAYN3SO2Ptyw9VbaG8jpT66P1Ss
	 yfcmkb/eHpcXLEKItEo8H1r42y1+YSJEWZ4Xw4x1F7/WieG9KLiUVBk3QVG8w/Ut20
	 C4+qJ+bnHPfcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197BF3AAA6DE;
	Thu, 25 Jun 2026 02:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools: ynl: build archives with $(AR)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235461758.3088510.9019938492686667838.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:30:17 +0000
References: <20260622161659.145047-1-gthelen@google.com>
In-Reply-To: <20260622161659.145047-1-gthelen@google.com>
To: Greg Thelen <gthelen@google.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 09:16:59 -0700 you wrote:
> Use $(AR) to allow build system to override the archiver tool (e.g.,
> when cross-compiling for a different architecture) by setting the AR
> environment variable.
> 
> GNU Make defaults AR to ar, so this change will not break existing build
> environments that do not explicitly set AR.
> 
> [...]

Here is the summary with links:
  - tools: ynl: build archives with $(AR)
    https://git.kernel.org/netdev/net/c/8c37e76f960b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


