Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7725771;
	Tue, 29 Sep 2026 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646009; cv=none; b=Rkdj3TZEmCbjrg1DaCsDYGnfc1/PtJerbbeQ4ZjD3EYk8dP0CIthYmVS5RNPXVCAVN7emnr3LqQ+dJUsKgZnIcSb0JjEAnwSUCoZuaag9lDnmkg0ZhLABQsTtVVC8FUy+ZaopLQAISWpYeUpvX3ItCBL8VekgTK6FzLSG9uoc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646009; c=relaxed/simple;
	bh=P2+d3C0mfcLvngyYLp8dwpB0uVQd0bFz1v32+uGgFHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dSOx5dzdhyqalayzMciZb/oPjdcDFecHQk0XuYJs2r6fiVvb9K6m7A6HRLXkuaDqSBTezzTdapyU8+56/vbTND+hR30XPNZ5GyH0bpSt12D1Yup7AA9p1xQYq+yZqGBDz3N6+2VzzUcIWV1jkTtiVRU7hE/3LBExqbOSXOhDeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHdRe2YW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHdRe2YW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445E61F000FF;
	Tue, 29 Sep 2026 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790646008;
	bh=ynrF6uAD3nXHgp31yB3iKjXnb88LPiS2VEooJDC9oTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IHdRe2YWfhJv9UOgS3HE/uBqq70pjPXQ6s+tiWTOI0VZVjQeYsdeM36Nq/MvI1nAy
	 AM6WEIYpgrwV5skPc2Ra6XRJOFalxaVo8Ji1aU0L+PiENQOLXgQi/PtncOf4c7ADx1
	 93N76PSXLSebtP4xcw9B/4dLx2wApw+dh/lFsFGH5sy8A96ZQ2G8BanCgC9wLOmrJg
	 7pvhnvKxROtEX/sdFnTPqPu3OVNgw0QJ3kg6Mlq5J3Nwx9rZkchonuFoNiO6SMzCtK
	 hqSJ0VQRFDuRFfyAjo8GOZpZrW5HeP8cV7SWLFa8kezvn7U1uBtAWUT0KYG3klOLuR
	 k9ppwQU1HISEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4DD3924FED;
	Tue, 29 Sep 2026 01:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7 0/2] octeontx2: Misc fixes for RVU drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064600678.210624.13233942205571941938.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 01:40:06 +0000
References: <20260922102149.2078168-1-subratp@marvell.com>
In-Reply-To: <20260922102149.2078168-1-subratp@marvell.com>
To: Subrat Pandey <subratp@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, sbhatta@marvell.com, rkannoth@marvell.com,
 gakula@marvell.com, sgoutham@marvell.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 15:51:47 +0530 you wrote:
> A few independent fixes for the Marvell OcteonTX2 (RVU AF/PF) drivers:
> 
>  - Fix aura/CQ BPID assignment under CONFIG_DCB, which assumed
>    queue_to_pfc_map was always allocated (not true for SDP VFs).
>  - Fix the SC resource cleanup loop that iterated over secy.max
>    instead of sc.max.
> 
> [...]

Here is the summary with links:
  - [net,v7,1/2] octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled
    https://git.kernel.org/netdev/net/c/056994563935
  - [net,v7,2/2] octeontx2-af: mcs: Fix SC resource cleanup loop
    https://git.kernel.org/netdev/net/c/cdef07f3002f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


