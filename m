Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF23559EC
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963243; cv=none; b=hhJcSc5EqvfGDzXLcMlElzrakDww3x0dYY3CWwXFm2V8prH7BwmF7UKLxmz24Uznr5YSVk6339k3wAKAVEvzeVfloS+5DV48nJDM2gOc6wpXBkp35O4wcF+KhMJhf7aFg0ART8gM2b08YBHAIGhQ+flQJMlLLeaMfGDc7ldkv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963243; c=relaxed/simple;
	bh=snQAkAyHQVTE4HY2nNW7RPI/BYN6/uWJMrXAwg+TG5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NqHXJUyNdL33g2bbjd9IEwiJG1Llq+/4mzDJgmlSKpejfd0+hCpnbtaqS1Xg+z0OloWQGGtQHfChOe9lZTeNrqWl4zgDgJhpHTeXiB7rABz/fWpKDfCRA1BF6O8MCDGwTt+QQIU0a1kmH3Bck5EDn7+fnf8/sGmjFQbHYCg43dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNAGz1rl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNAGz1rl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8341C16AAE;
	Wed, 21 Jan 2026 02:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963242;
	bh=snQAkAyHQVTE4HY2nNW7RPI/BYN6/uWJMrXAwg+TG5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sNAGz1rle4H5YhImpKfhNEMreVJkcr4D7rqIUh8moTjuwwrp0vIU7SWB+XDmzQ+RW
	 sRScNLudsz5RKAzGfguZ4tLEc6WMsVKU2d6MrGvsxqvqn86r6Ndd7AsJjWN0Xe46BH
	 Bkx7rj0xsicRjFXjLNZHKeN1c8/3qro/Ch/LWrFkbgNiDaQdBFG9QtkfiEmSZvewWj
	 urHBxHckczC4pvCw74NRIc1XqshMzpSX1nP7IvPTsKZItxtfAwsEI1lQHGDatYi6kA
	 0IOD3KXjzk85zhZWcWx8VE7iwMoNisVAiFhbBZvT8FJ1MsqEX4GR+3Apv7VqnLxNlc
	 3B2Y7UJoGZNSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC9A380820D;
	Wed, 21 Jan 2026 02:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-pf: Remove unnecessary bounds check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896324035.699622.6044623078189456935.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:40 +0000
References: <20260119-oob-v1-1-a4147e75e770@kernel.org>
In-Reply-To: <20260119-oob-v1-1-a4147e75e770@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 16:39:37 +0000 you wrote:
> active_fec is a 2-bit unsigned field, and thus can only have the values
> 0-3. So checking that it is less than 4 is unnecessary.
> 
> Simplify the code by dropping this check.
> 
> As it no longer fits well where it is, move FEC_MAX_INDEX to towards the
> top of the file. And add the prefix OXT2.  I believe this is more
> idiomatic.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Remove unnecessary bounds check
    https://git.kernel.org/netdev/net-next/c/2ec113ee41b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


