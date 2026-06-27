Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6E3382C3;
	Sat, 27 Jun 2026 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600659; cv=none; b=czPDfsMT92ICMndk8oTqJSQI5D/v4gqeDwLi2bNy9qsl5bOAadYYsSQxK0TFLU5DfNusiXjgT3rGw/G2qXUmRTEZNlUsx5hUjPcfsN7Vsxr128/LHL3qdp9+Jy1xBTVKSyQfQChLLJUBRbJeo+qji+fsmXhcdG9hpPL0eaxkaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600659; c=relaxed/simple;
	bh=7pN58KAjqRzxmECDQFd/BlH0XKgQyoUo0/7Qd2x9vK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D+a+BJeQ1FcAA90yGVdbaZ1KFGO5V/lzrid/hzGNceYcvjyQTQ577Ace4d2H/czaxLJJng3FcIk3U1nwiKMnRShtP4RQoEsEJjyT3MynsbWU/gCNv7bMGk++YDn5syKxch1HNEmnHMhb8J3QqWnk9o0dsmdA3J5KlRseX5RquCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5JSPTbn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5JSPTbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB72D1F00A3A;
	Sat, 27 Jun 2026 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600647;
	bh=Wx5JmIrHjn2nOrnRlXE/MNwWt4FjR4DXRdY4uRTqoKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O5JSPTbnCXwnh7e6QnKmiG8/OMyBwflxQybl7dJONOKiOdMxbtijfMrR2hloC9LdB
	 mN5bsHQ1h5oy5BKOyhf25vJNO3dVaIfBJZNegocKWa+mMBSBCiHwrKLeRL/4lWRcli
	 1bT7Llbhr1SZOQ2O3WfvP7CS4qtkl3khS2EXTMqLxDkmNBxyciCrXZVLyVAx7aNJcl
	 mNEQDD3141PAJclL+3vetGcCJnjxWVwqBkimDCw/KEuiaduPCLzbJLsYumDTFZEw27
	 ns+Ele1D3G+qFfNZYYcOWrrrCKM1KMeEhUJLh3xw9rUjwZm1gZz7r+7r0VXitfo28y
	 i+vPJPvVm2REw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09773938452;
	Sat, 27 Jun 2026 22:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Update Marvell octeontx2 driver
 maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178260063332.1451849.10661256898846524415.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 22:50:33 +0000
References: <20260626044819.3004811-1-rkannoth@marvell.com>
In-Reply-To: <20260626044819.3004811-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jun 2026 10:18:19 +0530 you wrote:
> Update the maintainer entries for the Marvell OcteonTX (RVU) drivers to
> reflect recent organizational changes.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  MAINTAINERS | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net] MAINTAINERS: Update Marvell octeontx2 driver maintainers
    https://git.kernel.org/netdev/net/c/56114690ff3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


