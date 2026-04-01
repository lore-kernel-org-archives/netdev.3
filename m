Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A701D33F5AB;
	Wed,  1 Apr 2026 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011226; cv=none; b=Kp0k/Xmhf3TpPuisNEhkQxMo97Fwd1J2D6QMQ3O1Q+QmlUd8g6K9EXOXtSS2C68O8TOjovOAe5JKUNEbwDFnYoZVN7whHyJtr7SP0iHY9ioop6aQU1axPrW4taPtwY18gGm6TGUtg210lQDpTrNPhpm4eePwMIom50PL8nuckj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011226; c=relaxed/simple;
	bh=xQWxTzsJVt2DIMw6LB9eudekO/bx1GkyFvqOIjPUccQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K56GfzpvuXg5Ltsyi4nuEaf/cXD1fG1rmUGTDUGpdrTOTN4aR3jYPk34HE7xZhI68rqnZV109dkvPdp40KcoHAzDy7BcFwmxUee54ryAo00WRrNNNxu3z+Uj+KFpn3FRTK246wCdJXjfBAQ3TrYiNM8ND10WdkaC8Amby2FnQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwJPYGWJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwJPYGWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE16CC19423;
	Wed,  1 Apr 2026 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775011226;
	bh=xQWxTzsJVt2DIMw6LB9eudekO/bx1GkyFvqOIjPUccQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jwJPYGWJ0dnYWgVA+7+2g+WTVk9+QPYdw/vPhE/5xe41nBv8jXKKiIRrPHnCwRWOV
	 8IyWBRYyeEdtIaqdBuue9+plvKlHqmWHoWuqiaJoViqCVRIOw1str3lXMiEui+wX5m
	 mxw/abu/hCBviIqBiMsJj/22Oh9nm7Kd2ZdRRttg2BTFUu5kZsvMM4wpWVTYEXJWhR
	 jkfm9cq3xz9VeqEf0QI2KdJ4jHLgD7bkWbpALq90eDxRH9kK1SDE2hZmM/G8Ihq2Bp
	 5Lp6gWHFz2UpyQbl5cvT/EGpAaWHShgbE77ngvAlUXaiKMhBVzWBpFHUix5TvMI13+
	 g3tKmbw30JjRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE2D3808203;
	Wed,  1 Apr 2026 02:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] declance: Improve DMA error reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501120929.3042140.7144845991669708956.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:40:09 +0000
References: <alpine.DEB.2.21.2603291835550.60268@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2603291835550.60268@angie.orcam.me.uk>
To: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Mar 2026 19:07:18 +0100 (BST) you wrote:
> Hi,
> 
>  D'oh, this v2 fixes a silly thinko in the commit description of 2/2.
> 
>  Inspired by a recent discussion[1] I have come up with this pair of
> small improvements to DMA error reporting with declance.  Please apply.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] declance: Rate-limit DMA errors
    https://git.kernel.org/netdev/net-next/c/ee769323b1bf
  - [net-next,v2,2/2] declance: Include the offending address with DMA errors
    https://git.kernel.org/netdev/net-next/c/aae5efaeb8aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


