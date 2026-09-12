Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86861EB5CE
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789173069; cv=none; b=VaDq2t6cxU/LCPgImPpEaY/0N5XUeSUeHudGHBD/atJRksuIaxcJ9QBqSZiVPI/g3rytkLKezw/kyjepYlJk49dlHvdG9ZFbKJyM9c2Nl993LjX1OGaVNlU8mQfh485x6HZ6OOOlCmV3oqGtGrBSEPVYJGOnqJIeW3kHrEXjIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789173069; c=relaxed/simple;
	bh=CQb38CNuw/SnzAUc0GipKCXwPA/bNbXSp1QhHOVPWrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tj5k/uUjtBSzPZGkAyYk+TljRrxvNBS4npIFxIColJ8l8zp3/wkjCMn/HwEB8ZS8OQwm+Ux7PQfVdqWrfkf9fxNktMpVEj42OkphkVpStipPPL/aAVu5SieSYOLnYFBfqqPm4o/P39znADAYI0Un3g3H2kFHIO6JZzOxzt9tQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYb9fTbO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYb9fTbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B551F000FF;
	Sat, 12 Sep 2026 00:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789173068;
	bh=NPzpU8NJogbUZWwVHnzejW3YDORwDb0bUPKTqcLiFjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KYb9fTbOguzbeLg8uHtqiBKNwRdkapQDNlt47WRM1Mh7Ys3sxsqGJLMwsiEg1suBG
	 jWdrvL175SN1L8YvvU532Yi5RTx4aW0GK9vpRCTGfu+efusxGFWdOMmxZ6hHWrdPuM
	 9RF1fliadlTYJD1J1cMbrzEAnzRmxwaGh30av2eU38vCDRNDLCU0A96WNq3BYyYty/
	 Eo3ct4FLcnQ8vebIqgbzJqZuvlfGc1+ydHYWP6ocmJSDWeNA8r62kQ6ARJpgLgRG4q
	 vXU0e58HwvTkTBMQ2o0WVqLES10tmzeW78VcUIpW92dvb5a3r7+DWT2iKAVzj1elmd
	 clGlfVDnmhGeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A8392445B;
	Sat, 12 Sep 2026 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 0/4] neighbour: Small fixes for
 RTM_{GET,SET}NEIGHTBL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178917300504.3175777.8958130274302627351.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 00:30:05 +0000
References: <20260909233143.2401847-1-kuniyu@google.com>
In-Reply-To: <20260909233143.2401847-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Sep 2026 23:31:22 +0000 you wrote:
> While working on the follow-up suggested here,
> 
>   https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
> 
> I found a few bugs in RTM_GETNEIGHTBL and RTM_SETNEIGHTBL,
> which this series fixes.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/4] neighbour: Add missing RCU annotation for neightbl_dump_info().
    https://git.kernel.org/netdev/net/c/764dcebb0337
  - [v3,net,2/4] neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
    https://git.kernel.org/netdev/net/c/6d79b223ec44
  - [v3,net,3/4] neighbour: Don't render blackhole_netdev via RTM_GETNEIGHTBL.
    https://git.kernel.org/netdev/net/c/7b430fcfc972
  - [v3,net,4/4] neighbour: Skip default parms when resumed in neightbl_dump_info().
    https://git.kernel.org/netdev/net/c/979aabdad8dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


