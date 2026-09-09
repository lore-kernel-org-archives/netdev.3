Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850446F489;
	Wed,  9 Sep 2026 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987673; cv=none; b=RcWmyhXF/X6CAzVAnP9Shw0E1pI4Xf7QceTjZcTnkz1qYorRuynkqZLGKdZyRkX0j+5rxglT4KLLVqgD8Zzjfx0itGwvS7qOJndmLz+r2LNmyJ8fClQS11dkrEkedQt8JlTCvnPTo88sE0AoqPzgeNy6MR/k5tkM3JGQm523rPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987673; c=relaxed/simple;
	bh=YJZkngSJwA3XSWiSUYd3HWD0POrdr8a8fO1ozODAte0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aeut0BvjchXzAF1Ju/ag6RQTsuC0Xcx/eq/OL9YVMI0PQnyzbsn9YBKeLLooinClIk4EkP7ibR2FRsYPwVZ3SryoIsZ4l+4Pct4dbWe4256eYIUIwD1iG/F3t6/XoS+TRX78FzUDdsvb48PSNxBDVM2pt1+CKJZyCDSLs7FPYVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7rE3TIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7rE3TIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA751F000FF;
	Wed,  9 Sep 2026 21:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987671;
	bh=Xaa8F9QgYol3L3nFiOABOPnDusa67cTjR5QCXfCrlaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X7rE3TISk9AiSoX/8OmuvGPRdnM8UsENGY+O2R7WPZbMQIUa6Sy6qwyVrq/06xGCM
	 o8OuFtBdIHlPexYVAmjs5685fmOJ8YtdfY/2Y4VrrT6Y22dEuDgGFdtvoqoE51vcRx
	 4cXp5r0nsw8mw5GFEUw0VnXxHDEq7Dq/6Lwp46L//tyYn1lrf/LY5RI2vykMb2Nl2B
	 yN2RdYDQu0Nf/gOEHYsQ/lr+pF6RFgqIjaTHMErfw2WhZs7d3yyLOcugJ2bt77ZdZp
	 0U4LQTdiw1fhcl1d/gtaXie5af/nUbt4VvYizZPry6hAPjBAgvJZcNinR/p50PE4th
	 32MwvdpqiP1/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A72380AAFF;
	Wed,  9 Sep 2026 21:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fix repeated word 'to' in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178898760941.1057294.6703032373957315920.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 21:00:09 +0000
References: <20260907063804.26581-1-hemanth.selam@gmail.com>
In-Reply-To: <20260907063804.26581-1-hemanth.selam@gmail.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Sep 2026 12:08:04 +0530 you wrote:
> Drop the second 'to', reported by checkpatch.pl as a possible repeated
> word.  Only touches a comment, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/net/gtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: fix repeated word 'to' in comment
    https://git.kernel.org/netdev/net-next/c/1c9c07d0ad69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


