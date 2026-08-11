Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B736386C37;
	Tue, 11 Aug 2026 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441254; cv=none; b=MxmSQbUxbsC2dSTIdw4NuoDqybKx/CeATIa0IwL9QVWnpwGowiMbZ3bNao71lJgUjJzhWb917zW1Qje3tgrmbJjbsSLeCgGzQbLGrxkW4CiC1YHAYklLlQnbUiICe6GfVbRwmtv1+54k9rt11SBF1aOmomMvhkZbagPSEbKf/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441254; c=relaxed/simple;
	bh=q+29RmvT6pJbKyfVxMOa9GGLc0rod4KMB37X8tUyzoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MAPvR43d1M1b9OjjpOS3ArNry8104atBwBqzHNyqT4lhsQieWzI00DHbK+/DzThLhePNIFGKvx7FXuYsc2P9+7COwr0zm6ywD/CrRRVWu7cCJhfEI2PouGKXuPtoc8VvLZOIi6rDyCaqGcEymEUszXWYHgKAoEAFnQddyxni1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFLZWkpt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFLZWkpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFC81F000E9;
	Tue, 11 Aug 2026 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786441252;
	bh=mq9nngAjq/TgFj/gai+l2DSeGBHwJOHE/ZrHqC+0Ed4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dFLZWkptU4gH2CuawNzeECopfQHkzKGQavLHwv0CZtLgrCkO0F2TlC4RHNrTRLsj3
	 vQp2WW4vR7Pbr/PcjxpqExdZGxvMaR+hjeyC6TzUW2CmQPN+w/dRykQhlNtzojr4ok
	 s6rdliNGEiBeio4p0wNGg3DDZNxFEsKesXUaW+AmRyqrCL+HwKgnYVvbZPUuIXmKSP
	 ZPk+7WceE0Otn1FXp/QSq8eDKnbOYfoilZ4w1hJhU/AoF/MPJqelEkkCULQUOdVZjU
	 IboKQax66yxmgNg0ChuI/BvpmGMUU2OHV+6WSo+ImeVshEVeWHj4vyIE/sYiSI/y4f
	 cfS6gUrBv9FPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198A539263B0;
	Tue, 11 Aug 2026 09:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] dpll: use pin owner's dpll ref for
 pin-level
 set callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178644120889.442634.3282180900336189180.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 09:40:08 +0000
References: <20260807095926.386923-1-ivecera@redhat.com>
In-Reply-To: <20260807095926.386923-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com, kuba@kernel.org,
 jiri@resnulli.us, min.li@microchip.com, pabeni@redhat.com, poros@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Aug 2026 11:59:24 +0200 you wrote:
> Pin-level attributes (frequency, phase adjust, embedded sync, reference
> sync) are properties of the pin itself. The get callbacks already use
> only the pin owner's DPLL reference, but the set callbacks iterate over
> all registered DPLL devices, resulting in redundant HW writes for
> drivers that share a pin across multiple DPLLs.
> 
> This series simplifies the set side to match the get side: call the set
> callback only through the owner's reference.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dpll: zl3073x: update all DPLL channels on ref_sync_set
    https://git.kernel.org/netdev/net-next/c/346630e46b38
  - [net-next,v3,2/2] dpll: use pin owner's dpll ref for pin-level attribute setting
    https://git.kernel.org/netdev/net-next/c/84e85c325e5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


