Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58293043CF;
	Tue, 22 Sep 2026 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037077; cv=none; b=iDywH6jPWOBnfT1dMOj/I1NMDdtyZr2lVYTARhBOdRAOHa9gjpXdip8ksil8yzxiI5oFbGCh7bkbLpEiQxh7vQR7CxDf5DHVfJE9NgPLpUPNYiEj+pVZqL5jaaj+exL7TfT5Zsk0hZIulIcxkJH/JmfeOJ3Ec8quiQtsScxKsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037077; c=relaxed/simple;
	bh=vEjdtWDFIepiv7o4npOYnx2EOSvwqePNVQrR6qNhAW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pIHM/t0LNKYrug+BiXTlWNKYIBpFqNL6ALA5MH55XPr5Mnq2aG5l84chYkeS60xDcml77lfVoSty0HvhHgycRp3Ey1a0fTzbY5DXRNAvGHcPBGRu8zCf3ONgXvnKN/ZT/WqN/PFY0MZVjoZMOUIS3JZ5CNStcrrGFrFWHREobgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qsz9RXhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qsz9RXhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8931F00898;
	Tue, 22 Sep 2026 00:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790037075;
	bh=jFy66myZhwyzhLafNjfuej6WGIAQykoxkKB/XoLNsNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qsz9RXheC5KHyehidjEVPlsiOxOkaJblpxMFePLAcf6lhdEPejfhakzjrANkpgMaX
	 Z1SMXwEyxDNPLIKW5VRiLwDX2PUFsLK/k73iHQQNvl16bN34W5pnc74jYXKaqSxjic
	 g18ohCzKtbauU1jpGm1ES87sCLW4VuLQ8KNpKBNbqIOxyNx3HxIyIAGh++Q5sl5xnf
	 b3xUvRHk65u61oATkBXoJQl92azPcvWRfF+gl5hKn/GwfrrEmrLVeXYgmLaLdGjYam
	 eEK3b3fK0pjbydtjxYGCKvQpRHzBlFJ2bMHmi/oDgD7/W1+sPeIxIe/BFB2BbbBg3P
	 nMsut0WMajHgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A213930203;
	Tue, 22 Sep 2026 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: sr9700: include receive overhead in the
 length check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003700639.3305732.13568325130499669966.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:30:06 +0000
References: <20260920034745.18468-1-hppiscas@163.com>
In-Reply-To: <20260920034745.18468-1-hppiscas@163.com>
To: Pengpeng Hou <hppiscas@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, enelsonmoore@gmail.com,
 peter@korsgaard.com, horms@kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 11:47:45 +0800 you wrote:
> The receive fixup subtracts the Ethernet CRC from the reported packet
> length, but compares that payload length against the whole remaining
> receive buffer. The following copy starts after the three-byte header,
> and the cursor advance consumes both that header and the four-byte CRC.
> 
> Require the payload to fit after SR_RX_OVERHEAD before copying it or
> advancing to the next packet. The loop already ensures that the
> remaining buffer is larger than the overhead, so the subtraction is
> safe.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: sr9700: include receive overhead in the length check
    https://git.kernel.org/netdev/net/c/c06bde80ae7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


