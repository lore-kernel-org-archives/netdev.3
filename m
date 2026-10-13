Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A73F58E0;
	Tue, 13 Oct 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899416; cv=none; b=n38vdRA/PKLI7e+vr6hfSK9Kc6gjv+u0KqQBxDwNqUP40vPbue/Yago603i7+mtqm+WY9W+NqQoNmJ47WEQpG42+WJXxj/JnPqzOOaiae4Bua4l16s1MmrzBPrA1kg/WqfzfnE1lbK77rP+1lUUi2iwKAsd+kGFNXvV1ll6Sddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899416; c=relaxed/simple;
	bh=qLDGXnRZf1to5C6XBGplcIrXzZ1N9dQpaUntYxnJVGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J4UzKnMGHHMHVZY3WB18y3Pd1vhAVTfTaTB2yHGm32Q+sdIqdCGCKaG1lHTT+60VNSXfr2Ly7N1gIQuGPoxt7a2QJimRLfLbRpSBgEGCCCMKM2jQojf1NbfdYvM5NeXadyqPRov8a0AqXJUIFrVFsyJSTC6uCOnvdine+3cSdao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgGv+L6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgGv+L6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854B01F000FF;
	Tue, 13 Oct 2026 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899415;
	bh=iSAPKbtZtGXfQtoZlKM+xng1+JxCq5i9PSUvmzWjhgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VgGv+L6llbhvPAf260XWy93c/9Hljccf3QygrMuZne/a7DVPX1ia4fs9OpqoZAbmd
	 DfcYfRmUGoRGT9brxtaHMV7rZ/n5fEVzZgl8ohAVyQV1YQM9B66ZgDKAQKrR/dn1h/
	 OtNm7UrX2CNu42tE2k7CWewx0QT+p1PnvmQlBoeq1aiQlY85T+WOsN93uKSkchYK60
	 YpyBa8+cmL1rSF1g2kcRiIv6qfA1G1kO/bR7ZwLl6y5fjmF246re0Db17yIONAox9p
	 FfNSk7q23IScTSq9jbu03ir8i1qnFxN/9zF2eyHUWoTf/40agHXC9b3x7lKRwrfapD
	 fXuT3pXuMPjrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 776BD392720A;
	Tue, 13 Oct 2026 13:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: sparx5: add TAS offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179189941412.316800.3089699035347557018.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 13:50:14 +0000
References: <20261006-sparx5-tas-v1-0-5eef1126dfd5@microchip.com>
In-Reply-To: <20261006-sparx5-tas-v1-0-5eef1126dfd5@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robert.marko@sartura.hr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 6 Oct 2026 15:51:05 +0200 you wrote:
> This series adds offload of the Time Aware Shaper (IEEE 802.1Qbv),
> configured through tc-taprio, on Sparx5 and lan969x, which are both
> served by the sparx5 driver.
> 
> In hardware, a TAS schedule is run by a TAS list, which steps through
> gate control list (GCL) entries taken from a pool shared by all ports.
> Sparx5 has 128 lists and 10000 GCL entries, lan969x has 60 lists and
> 3000 entries. An idle list is in the ADMIN state. Once started, it is
> PENDING until its base time, then OPERATING. A stopped list is
> TERMINATING until the end of its cycle, and then goes back to ADMIN.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: sparx5: Add registers used by TAS
    https://git.kernel.org/netdev/net-next/c/48b7611964e1
  - [net-next,2/3] net: sparx5: Move TAS link speed configuration to sparx5_tas.c
    https://git.kernel.org/netdev/net-next/c/966285085456
  - [net-next,3/3] net: sparx5: Add TAS offload support
    https://git.kernel.org/netdev/net-next/c/a52629f85a3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


