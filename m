Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE015B135
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290454; cv=none; b=j2DknyuZ83dDvkVygCrC5SZuQ48ZA9us+oY4EBIiiMiUH+ff9vaFbYFfpKnA2lBxhUKnFkRPAbaJKAd/VH+GS8uVQTHoxwdZ3zlZus0qBR8L3Ru6nfN8atycjqRnmRa549tMS/g+t4V8vD795OOnPXaxonuFKk6MDcR4m+rG+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290454; c=relaxed/simple;
	bh=icd3UzisFSAyoYdd182VAcDPlawL24HcPoOOyXw2GJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fXXRy3sgkW3mFWYQOLbNLGyE1Jg5SDx4v6lIbzvenxME9gW17hVhIx4Is+hAgtW8YajrEwgF/IMOgHK3UZTxMXVmg9KMAFoVXdpqeJBs3SKpvwxJfTBCz9PoaOT1OQkIzMbCk0F6GaHmPl0uy/r8CO2KauTz4jd5yJ4+JbdY8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2Zocp7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2Zocp7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901BE1F000E9;
	Wed, 29 Jul 2026 02:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290453;
	bh=7Mi7xfzjW05+qpu1orYlINpbNwPugNentb+SWctKldg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h2Zocp7LuTsBPJa2yAgy93V6VDcyu6CWk6Tzuf3NQjy44nCaLx0tAeZI6YoodKuon
	 HGAcfBjC78T3FLof0ZHl6CQeBBrTOGjL9WGgbnkO2Q+ZrEGkjJ6qt8zCagMJmahGeR
	 jsu/tYb/1MPVYbI1ACdsTTjwAT9q2BHNAGVerKg9SxbmnBa+zIlUcvv/o+uv/OtJBx
	 nRnjqIl1ctlnoKcQVc/mp/4tRlpZ17MFXGJu6hKfuYCog1TMyRIKQuhVmYqprtrJpf
	 YSkO1vdO0NScuhONmBST+d2jO8gtiHGne8gFEZ1vPyqcVT7x660tXRA6K/w1X/LSH3
	 K6VbOgoBr4TIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5682C3924A60;
	Wed, 29 Jul 2026 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net_shaper: clarify kernel API docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178529041788.2407687.8522877289989396527.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jul 2026 02:00:17 +0000
References: <20260724210756.1553565-1-kuba@kernel.org>
In-Reply-To: <20260724210756.1553565-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 14:07:53 -0700 you wrote:
> A handful of improvements to struct net_shaper_ops kdoc.
> Today driver authors have to dig thru the shaper.c code
> to understand the behavior. I'm covering things I wish
> were explained already during recent reviews (within Meta).
> There may be more things that need to be explained, incrementally.
> 
> Jakub Kicinski (3):
>   net_shaper: remove incorrect comment about group leaves
>   net_shaper: clarify the kernel API / comments
>   net_shaper: add some notes on re-parenting
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net_shaper: remove incorrect comment about group leaves
    https://git.kernel.org/netdev/net-next/c/16812d9674d4
  - [net-next,2/3] net_shaper: clarify the kernel API / comments
    https://git.kernel.org/netdev/net-next/c/26bc4cfb1737
  - [net-next,3/3] net_shaper: add some notes on re-parenting
    https://git.kernel.org/netdev/net-next/c/ff6461c14834

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


