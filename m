Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC31343D86
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767983; cv=none; b=cUOlF9X+KrVbE+KrkycvS1iY105Qzn35kV+DlsvblzZhI4Ii8SrtBkDduFp3TSeYNn/aEUr4Ko9G0b7wLO0cl7ndnCs1zik9905Kny/ykaKFC84b7jruTAan4ErEhos2YUV+u0vGBbEqDAfPCex5dDAaXfRJxSa2BQZw9hpE5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767983; c=relaxed/simple;
	bh=WrF08txdHaJmmstO/9T+c3qXBzUTg3SEyoVGjAx7GB8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VyeN4NjD+1Pwc4qo7mwkCeZtGjxBxJg3u0nrzTD2kDLgNtIQ3brmIkqjaw0ZyD3C+7uyu9PJm8tpkKUuHSfUUA6uE8Ltg3tqAwH8xuNhD15v+jjecfpeQCq4Tcupmqb5dpaGZ86Z69SrOo9eOYviLXUFXr31B6cvf0bz2/ZLWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1O1uRPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1O1uRPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDB0C2BC87;
	Fri,  6 Mar 2026 03:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772767983;
	bh=WrF08txdHaJmmstO/9T+c3qXBzUTg3SEyoVGjAx7GB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J1O1uRPiKdWZ9oKdUZ5ImWsdmIYyPQ1HBrEn7U/oTLJIewFGwCvk+rl1Vo5bQgfT8
	 KeAqenre8AWEZf0cWhIkgkprR+ugmU5RgebNpjppVBbk69rrUwwt7xL8IWdrwlORAJ
	 07lziR4W3MJOmHdSQBm4DTo/Yut9HTSSKybIp+g0qwyXNP+rE4PpM3EV0bRiCA8jW7
	 OxvOuaaIOKyYRsCP36ctelTUn/vq1Pgd/B+7X0DrjQMdwVXZYYPFiZ9+x6jPCqNm7I
	 4PNd8eQFt9wYqZirfAXSmFJJvvd0HdyHN/CQrx0NR0JTlL6hjIcmgza/8Dxyc1SROC
	 /VEzhU69AUvYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE8A3808200;
	Fri,  6 Mar 2026 03:33:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af:  make PF_FUNC comparison
 consistent in
 NIX XOFF handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177276798304.3348267.12480565302628692815.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 03:33:03 +0000
References: <20260304193950.2467391-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260304193950.2467391-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sbhatta@marvell.com, hkelam@marvell.com, jerinj@marvell.com,
 gakula@marvell.com, lcherian@marvell.com, sgoutham@marvell.com,
 andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 11:39:48 -0800 you wrote:
> nix_smq_flush_enadis_xoff() compares PF_FUNC values with the FUNC bits
> masked off, but one operand applied the mask before extracting PF_FUNC
> via TXSCH_MAP_FUNC().
> 
> Apply RVU_PFVF_FUNC_MASK after TXSCH_MAP_FUNC() for the TL2 scheduler
> queue operand, matching the existing handling of the other operand and
> making the comparison consistent and clearer.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: make PF_FUNC comparison consistent in NIX XOFF handling
    https://git.kernel.org/netdev/net-next/c/58a4c3e80065

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


