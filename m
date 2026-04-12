Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C24A25F988;
	Sun, 12 Apr 2026 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776027640; cv=none; b=ohN9mQoYlZqnrNuv4TXlVOXe1LOmR6gedewHjLyHoj74aswP/KBpNHhigdghAvz5MFWqqUGl6yqVZ4wkOu/it0IIbpPV3GD/SUtXjT6/+qvcmnyDFpGebyO4WwnCVMLl9NZ/8yAuzGk7nAYG6RPGVmhc736W93Xp2e8WOlvfvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776027640; c=relaxed/simple;
	bh=w8P3oWsKjXqj+PHuBv3r3XUZwhjR55YCyirJfscCyd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=St12zBBnNDIGOyRWmhdUK5H68uGZxcspnHtBuDQ5QR4lrtE6nxWlmh0bQuOOgKPz3FjfU/wEQTOXvgitAFeDgPZLqodhL7olV6dzRMQwXnZApnx/rSU2iyhdIHGdrhBWrNjq+YIywRSM9+SfpxQ5llpa9bb6Kz8i2gZ5cPIy5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+fMG9D4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+fMG9D4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7C9C19424;
	Sun, 12 Apr 2026 21:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776027640;
	bh=w8P3oWsKjXqj+PHuBv3r3XUZwhjR55YCyirJfscCyd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U+fMG9D4PjCqbHdvlweRpiwceCHwI47c4gR+jT4s3MWHFZWx91F49u3/J5dK1Cj0X
	 b+E46leNKhlvvqN129NsF2qgfb3sXEElkB4Bl5yJa6RAIX+JgLxmLL/9ah6DC3W3yO
	 6DB7ycjod3V0yvNyeiXVHjTgAiggf3hrtLzt217a//g0TCBR+xIzUuLW3/3ry78v7i
	 uJE+FylqcMBCMzcMpFk58WwVB8tc1/aMnWu3O2auT4XxkDCmz8n1tvDf7Y7ngcIyOO
	 VA+dapISn7BwK62nrBuodsz3kGFBQdyPJPHRbqWZg05Ne0RJtrjEUeK5lBxxE5zgTq
	 Fem/ft9PuWeXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD403809A8C;
	Sun, 12 Apr 2026 21:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] More fixes for the IPA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602761230.3408407.17983223165088900536.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 21:00:12 +0000
References: <20260409-ipa-fixes-v1-0-a817c30678ac@fairphone.com>
In-Reply-To: <20260409-ipa-fixes-v1-0-a817c30678ac@fairphone.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 09 Apr 2026 10:13:30 +0200 you wrote:
> Two more fixes for the Qualcomm IPA driver.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Luca Weiss (2):
>       net: ipa: Fix programming of QTIME_TIMESTAMP_CFG
>       net: ipa: Fix decoding EV_PER_EE for IPA v5.0+
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: ipa: Fix programming of QTIME_TIMESTAMP_CFG
    https://git.kernel.org/netdev/net/c/de08f9585692
  - [net,2/2] net: ipa: Fix decoding EV_PER_EE for IPA v5.0+
    https://git.kernel.org/netdev/net/c/1335b903cf2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


