Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E63859FD;
	Thu,  6 Aug 2026 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976871; cv=none; b=s7rPQS/4cHYKFDKS4+dd1CPAlyiA2bcebQxUDKZnVCldzZWJYJcJXgnTxcb70PxxxeeLoIn0XpsvAgXuBUT1xFq+Y0DskIIKTXtbhME+awYDYA+4g7e9NRNk06iIbjR3Cb01g1blrpEoN2DkQX1dXO7XDJ26aQ52JOfMaYzaAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976871; c=relaxed/simple;
	bh=vVHc/vI+bpflqJQBpiKXm035r5E6F78LNY9owQOSVBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jODUw1aU2hAMEbHAusCAOr4PlO7I73qKK4UChDSQ3NyGy+QPJyf0UcjCHVMCY90IX2oFI0c0TU1Ktc0BAxrvZ3QjTbFGLl6xYozBEFmBNO6eqm87Vodaaa/wtv4Ss9bU6eiVB4GAoCqVcmsSr8b0mQRQ6QzDfbam8Y/E91i/OZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL7pmye8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL7pmye8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A0F1F00A3A;
	Thu,  6 Aug 2026 00:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976869;
	bh=fDCt9s7P7zPiK5eyHVu01RjLnquRgErqeZS26UoP2dA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KL7pmye8BGinRB/AO4XK0yUuP1au8zLE/o3unL9Ql+8XMQI/gGaNrQkp49N4ywsxr
	 pTXbFYRV+S5TLxbwsDnEfolKO0IViMyb38VhbgmCcUXHWNCsdCmstlKKpj0imxb02j
	 6r2tXYoh0R+sBHGFIyl3wl0HHWK2haI3zkzCXfTBLS1yAYIKu0/yEXoCyf/H7LAn4K
	 NtI8aHbeeWKxUTKl9hMAhL0xN71HktPLxH7YWDlEZnkZljj4HhMY25LH9Ko59qK8W3
	 1OTnm+ru366WBYq61RnntPz1LLXGkjesWKT6Z2b/xYCFEzXXx8leJNimFwcvxkIXdn
	 xRnIUktcoOklA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A2D392FFD8;
	Thu,  6 Aug 2026 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: macb: remove unused ENST Q0/Q1 time
 register
 defines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597682914.580024.17367422478001898853.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 00:40:29 +0000
References: <20260803062834.3865755-1-vineeth.karumanchi@amd.com>
In-Reply-To: <20260803062834.3865755-1-vineeth.karumanchi@amd.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Aug 2026 11:58:34 +0530 you wrote:
> The ENST start/on/off time register definitions for Q0 and Q1 are not
> referenced anywhere in the driver. The driver calculates these register
> addresses from the ENST base offset and the queue index instead of using
> fixed defines, removing the unused macros.
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: macb: remove unused ENST Q0/Q1 time register defines
    https://git.kernel.org/netdev/net-next/c/8980f3363128

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


