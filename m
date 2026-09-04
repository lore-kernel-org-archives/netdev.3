Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2D3AEF22;
	Fri,  4 Sep 2026 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562292; cv=none; b=DFJ6N7U8SqIUU7eNLCZUqEX7//5oPCocaCt83N26bX1fDc2HCnA6wTPQX6EDt+e6kCokIFJIfwOaRRgf1O1kx+lWkGpV/blaBh6qOKSdl5DCT1Kx24VuvTXpdAbaYFPNy9FJyx9jHoCZGbGztCNwiZYWjYYBA3zSz4vjBWf1QXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562292; c=relaxed/simple;
	bh=vs6z6dzraB+9bsrf9D7oao7+dyuM1tVLVViL0yIBT9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QKgJhcMNQchyS2rGUK0CEQiqZ6CaQLKi+SY3+b1G/QNRAJKRQUzdX0IibhdMK+aHDcXzhwSo+EtU0+u2IyCOdmXwBaOAuuSMQk+mm5NpnsDtx7a2uEdGuxE3nRKHmOu2JLrKXR7oxurgvq5jUnpVNBo66D6GCu6X3lTZUT5hXvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laUyS1ZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laUyS1ZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63301F00A3D;
	Fri,  4 Sep 2026 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788562290;
	bh=cgP0+R0NhpnOjql6LwfjowFkgx3URNsZyaguYcbR+x8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=laUyS1ZAVj65OCsOkl01wMyXlpVQF5EL8ETcFYkYfUON5lUi0fr+ZQ9K/U6xyfPWb
	 Gp+v9YeCkipeLVPiS0ubYdD6Z9f4m9Fx3+hnW9gPpsCOsSUx08PPthpK3ow8gnxKpm
	 rM+9oM3jfunliH/dJkGfT+7uokLtFcs/FiWeu/fM67MiOF5Qum7K+I09yuj9kKRAzx
	 qElF++k0p5eOj+LCSAT8D6KgMRY3X8MX4qacO6DCAWy/xgzwb+Rwql6z7094BsvwM8
	 lboenJDyCU2et7tTp8aLwRWTTGTXn1yySPyjLsXTCa2dYcwKawD/Mths0bqIn5FhTD
	 WD0WXftMXLLpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A2F3924A7F;
	Fri,  4 Sep 2026 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: mcs: Clear stale X2P calibration state
 before calibration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856223114.1003513.7113308179560566896.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 22:50:31 +0000
References: <20260901094318.1395356-1-nshettyj@marvell.com>
In-Reply-To: <20260901094318.1395356-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 viswajithm@marvell.com, sgoutham@marvell.com, rkannoth@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vattunuru@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Sep 2026 15:13:17 +0530 you wrote:
> From: Viswajith Murali <viswajithm@marvell.com>
> 
> Some firmware versions leave MCSX_MIL_GLOBAL bit 5 set on boot.
> If the bit is already set when the driver attempts X2P calibration,
> the hardware sees no rising edge and calibration never triggers.
> Clear the bit and wait briefly before starting calibration to ensure
> a clean rising edge.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: mcs: Clear stale X2P calibration state before calibration
    https://git.kernel.org/netdev/net/c/1f29543126dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


