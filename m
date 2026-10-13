Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1FE4C7546;
	Tue, 13 Oct 2026 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888608; cv=none; b=aTCDy6AJ/v+AvsknIlrKLcC6VF/Y6kDo91mKZcFAM6YMRoXGhYQSitbensQdirFTWZw5w9hTQ5vHSJjI/apj2JsyoyLiSsO4ZSJ1lMXsC9ZWU4n6if8iI6sfn7DUECuJVyud94bjsBtJoqY6JNJh5PO5tgZK1AzoDsk+R343Cls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888608; c=relaxed/simple;
	bh=6hZz0OPVgMsuxa1z0hscHgaebQpqhpYvtL1jg1ZfBDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uEAGUeQvnRYL7wqt/Nhexy7/U87oPv/WnVjQUEBqvOgaa0hAGNvFGKXPwDE+a0iDe79nCDaBK/1obn6yvwc8cC18xLYFAncqo3wzWynSe/FWzkaYJawjBIpS1/EO5xyQko8cacNRye/nTBhgTLMBsiK8uYllYT8WvGOZU+92AqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrLVXiie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrLVXiie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9271F000FF;
	Tue, 13 Oct 2026 10:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791888605;
	bh=6SwFEmyIpAzrHWXTE0rdlKL/TxZFvAc2qUOB5pJIvnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GrLVXiieMyfmV+feKF2MD7V0Gafa8n8B8KKSifehgt5a7WxXPxYrqXl7w+5L+bwGK
	 G2ssU/mWUtmW59RrLtROKCnFbBSE89wX8E16/1naWkcP+R2XjfmZX4oNtPuDrwBKzq
	 Y5TcKlBS0FVhGSGWSvd0HUAW0z7DzR9PFOgzsTd9elX6A4dNIK08GieTOgxt5edMCB
	 7kEEbIN5yWLUdFggnHj8qZ/gzsivbegXO3uWYROc90PeRx6+3aZ1yIvowvvOFRjRfQ
	 N85A9ReBbzbG3fu69YrIfaCrR3LlH8XPgJUsDStRRRxxFXGXAgHjEAH7Bxx2UqlDLc
	 1KEqE3QdyfN9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77491392704F;
	Tue, 13 Oct 2026 10:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] sfc: fix stale kernel-doc member names in
 net_driver.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179188860427.217011.7064100465923147742.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 10:50:04 +0000
References: <20261007175338.28683-1-kapoorarnav43@gmail.com>
In-Reply-To: <20261007175338.28683-1-kapoorarnav43@gmail.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  7 Oct 2026 23:23:34 +0530 you wrote:
> Several kernel-doc comments in net_driver.h describe struct members that
> have since been renamed or removed, and the EFX_MAX_FRAME_LEN() comment
> is separated from the macro by the EFX_FRAME_PAD define. kernel-doc
> reports:
> 
>   Excess struct member 'state' description in 'efx_channel'
>   Excess struct member 'state_lock' description in 'efx_channel'
>   Excess struct member 'indir_table' description in 'efx_rss_context'
>   Excess struct member 'irq_rx_mod_step_us' description in 'efx_nic'
>   Excess struct member 'tx_queue' description in 'efx_nic'
>   Excess struct member 'rx_queue' description in 'efx_nic'
>   Excess struct member 'extra_channel_types' description in 'efx_nic'
>   expecting prototype for EFX_MAX_FRAME_LEN(). Prototype was for
>   EFX_FRAME_PAD() instead
> 
> [...]

Here is the summary with links:
  - [net-next,v2] sfc: fix stale kernel-doc member names in net_driver.h
    https://git.kernel.org/netdev/net-next/c/32a8010d2c30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


