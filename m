Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D02285CBA;
	Wed,  1 Apr 2026 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010629; cv=none; b=aDptdBaioG5+qTZczEgvjdWWsVJHaDUHg8L1iqK38n5ypf1jLN2PcCisNahHuxvAgXnaTlggpEVUarzeG7hiEhJFrlW/N67AtP57/cMihDJzLIxCi5uCNTWzwvxck0SotHrlMB7HhbqKuNhNSRKZF4ioH+C3C23VRzub73gi+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010629; c=relaxed/simple;
	bh=psovTAh58mOl13SC+3CDeoTT+Bt/Qq15lZdsj3JtfDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g4CxuGuEI87KxWTbsQMtjr39/lebtoBfYM28Z8npzTZ0AvYlUaD171JUTDamWalNuHsIkWG0fzpRD05t6gUbBvem61LN7Sl50DJhZ2gm09uub7VHaZaNUZNbktgXquvWPS5DkSgQidNNdshxvVJbpBPptlnqgPiC3ad5mtbVWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/lHt+3p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/lHt+3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A22C19423;
	Wed,  1 Apr 2026 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775010629;
	bh=psovTAh58mOl13SC+3CDeoTT+Bt/Qq15lZdsj3JtfDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T/lHt+3p02bH6/NaKcwiVWvD/gxUTgF4jyVyTm0Bly8NxebQ8lx4TxZ86pTc8emCG
	 8eZL280SK8/uHYjv0OM/0RQXOXl2j/lKH/FPNsb3j79zQJVkxwueCnEScLrkog0vCO
	 BePXI4r/THBeVZZwjD0Yg/pytwr53OMN88wUbPoBVkOg2UpvTQZQ6i2xmvEcnj9xEK
	 H64/pEmIihxSNK+uoYNksxNM8Ybib/UKjWljtjH0yEmyV/zuHS+dh1zZB7BVsP19Ys
	 UR3kGyLU5cjdws5HqAOgjU+QCCtNWJvdLvqupIkx+fmZj/ExO1WAIBmGZirkRF55fk
	 A1dy3NihZdg1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF7C3808203;
	Wed,  1 Apr 2026 02:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] nfc: refactor USB endpoint lookups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501061229.3039405.10122971974982249905.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:30:12 +0000
References: <20260330103655.1672331-1-johan@kernel.org>
In-Reply-To: <20260330103655.1672331-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 12:36:52 +0200 you wrote:
> Use the common USB helper for looking up bulk and interrupt endpoints
> instead of open coding.
> 
> Johan
> 
> 
> Johan Hovold (3):
>   nfc: nfcmrvl: refactor endpoint lookup
>   nfc: pn533: refactor endpoint lookup
>   nfc: port100: refactor endpoint lookup
> 
> [...]

Here is the summary with links:
  - [1/3] nfc: nfcmrvl: refactor endpoint lookup
    https://git.kernel.org/netdev/net-next/c/dba69cba4a5d
  - [2/3] nfc: pn533: refactor endpoint lookup
    https://git.kernel.org/netdev/net-next/c/13f2e141b944
  - [3/3] nfc: port100: refactor endpoint lookup
    https://git.kernel.org/netdev/net-next/c/771a627ddd3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


