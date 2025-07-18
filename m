Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23502171CD;
	Fri, 18 Jul 2025 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752801603; cv=none; b=b0sByTxV62kAjrSgwHkusnN1dxdFDkybwQPQUazBUA3GnMCM3l5+rbmbQePgldzg63JDFYqMefMYpIQqTu82YGW30Kk7018R9aHwuECldgCJjQY0gdxbZiYNHS5rXRa67fkxdqmJiD8R4dNqrCIPQtPSZ93r2PPvqsqetzPskA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752801603; c=relaxed/simple;
	bh=JfbB2+cSY1PeLXd5QIYBen5h+0B0MoZdFJVwlBP+6MA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VkiBJOZlGLTCcgSYFYFsDUISqp/z3r+xHnzeLgU6dKqSm1GhQUD7YiQrDxhbxWsebC/4uGWuew2ww6ZepPTw/jE/7MTP0j/SKZQiNCRCGNTWH4OxS9qe2Xrjhu6Y7dZ9+zmKLvve9O64DGQoHaCM1hXryYqNrqXcRWEkgc5h35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUwNLgbz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUwNLgbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C3AC4CEE3;
	Fri, 18 Jul 2025 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752801602;
	bh=JfbB2+cSY1PeLXd5QIYBen5h+0B0MoZdFJVwlBP+6MA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TUwNLgbzaOzymV/x/zSEHE4dtwp5k6FjXTqM1jtN5B/4R9ti0q6nWHKve1S/9vESm
	 WZfSAWDSfmpiDy0gdcZqFRXMWSoO8+XJ1ozSKoN0EOkpp/LpNWt1UeZndGblkdIPp2
	 8+DBfVuxQpL6FAjcrCQY3vusOsXH0hwWEUTwOw1OKJYiQjhnpDbMT+ODQi20zov0DO
	 TwJzx0gA7+pGdM/gjhc9omkplQs14Z1tPI4bdXVbbSmimr+tWj2YaKnG9tKNEHHZ20
	 uaTjufmJ4gLfOCikMffWZzzdwK8gHzMtfu6wgGmj485sGam4XtDVQ8+5N5LTwgO4eF
	 5w1GXEki6SnIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD45383BA3C;
	Fri, 18 Jul 2025 01:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netdevsim: remove redundant branch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280162251.2132065.12375823552715638665.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 01:20:22 +0000
References: <20250716165750.561175-1-dechen@redhat.com>
In-Reply-To: <20250716165750.561175-1-dechen@redhat.com>
To: Dennis Chen <dechen@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 12:57:50 -0400 you wrote:
> bool notify is referenced nowhere else in the function except to check
> whether or not to call rtnl_offload_xstats_notify(). Remove it and move
> the call to the previous branch.
> 
> Signed-off-by: Dennis Chen <dechen@redhat.com>
> ---
>  drivers/net/netdevsim/hwstats.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Here is the summary with links:
  - netdevsim: remove redundant branch
    https://git.kernel.org/netdev/net-next/c/a93f38ebff57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


