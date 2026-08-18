Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA43A59A7;
	Tue, 18 Aug 2026 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072501; cv=none; b=mSDeuZS224xieD1o11vfM4fGsE+3xGIm/qY3lFnrpZZaMFjbIW2lZ14ComziW57SSlwY0Bk73iajaTnLsH0mtE6uXYi01OwUZkfbKwDGluOPJQFVi6JlWlD56cru1O6pSMnzfbFEaho10hbD94lBcJL/fpx8ODC8FbjsgGn2N+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072501; c=relaxed/simple;
	bh=8FOIHzMNlD8SWcfPjFZyKrjAur+bPMMNf1EdLanqlUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U7Kk2GzDGkcvq6PBR9Q5mHERQlI8djGtd4I2FrEW03LPRmR9NO+SF6BiWCQ8tDC252Ihn6ox9mFXnZSawwH/qPOo6WIAk2U8vlb2y03Ps3bFuPjDwP5Z3bqoAizXxJ3xoK4CfC0HKmIFjL1xxRmTybCxHQDc8SGs2ly8QOhozKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUekTmLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUekTmLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4DC1F000E9;
	Tue, 18 Aug 2026 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787072499;
	bh=uKUoglPT7SnlILf0jh1BJ+03RpCOLzhABIkwgj0CYCs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GUekTmLQbvy2pl0cfjtSOU8sTaiOGFZgb57KrxkSAOxO4n6bhbU2kURZTPrR27ALa
	 GqR3iBsxMeeG95q0GmtcNB95/Gzawo1Qw3BwI7cv7JxD5uEyA80wHtzmXFcjYugKKz
	 +UKA7DeFAtKKxhqgVVnPYOZ9x2wnV1ROSg6nsGYvZI8VskSitvs1ZRN+CX9m9yudIT
	 vBFK3dpcMoZSvN+OcPO79o7QEm8Ukr6o0uRpTEx9ZGDVKEZt+knKETKcnIyTh182Nb
	 txZ2T7ZvlgObFLhdRGHBBtTRxvRXeeqEy/t2o+ldspTkBoV8rpaURx+orY/7nh9UWr
	 lk4he7/WMwfoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A1F3927043;
	Tue, 18 Aug 2026 17:00:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/3] dpll: zl3073x: add PTP clock support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178707245117.2181073.13634928585472351428.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 17:00:51 +0000
References: <20260814082656.306534-1-ivecera@redhat.com>
In-Reply-To: <20260814082656.306534-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com, kuba@kernel.org,
 jiri@resnulli.us, min.li@microchip.com, pabeni@redhat.com, poros@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Aug 2026 10:26:53 +0200 you wrote:
> Add PTP hardware clock support to the zl3073x DPLL driver.
> 
> Patch 1 scales the poll sleep interval in zl3073x_poll_zero_u8()
> proportionally to the timeout to avoid excessive bus traffic for
> the longer PTP-related timeouts.
> 
> Patch 2 adds low-level channel operations for ToD read/write/adjust,
> output phase step, delta frequency offset write and TIE write as
> building blocks for PTP callbacks.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] dpll: zl3073x: scale poll interval proportionally to timeout
    https://git.kernel.org/netdev/net-next/c/c36461825469
  - [net-next,v8,2/3] dpll: zl3073x: add channel ToD, phase step and TIE operations
    https://git.kernel.org/netdev/net-next/c/2dbf9b756279
  - [net-next,v8,3/3] dpll: zl3073x: add PTP clock support
    https://git.kernel.org/netdev/net-next/c/1db73ce01856

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


