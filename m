Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817BA449ED6;
	Wed,  2 Sep 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348066; cv=none; b=deu7iT06ihxtVHAf7DTRpsdpLmn4oX7X8vAypHYIRU7V21k4EFrf5ii7Bk0GdUaR5zo1alX1a/nwLoLtoaIecvbjO8nwLR57s5hH2VzdFLHIImCAQeEz6KrQT60ewPYDPp6Nan1g2dOA4DYZSPP57/QqlURVph5Rxi4uTzZwHlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348066; c=relaxed/simple;
	bh=s7xYqAy3ZFjSVnT0kBmOnrk6RVsk6aK6ms110KhT6kU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VBqC+HWwbf7Iyu6k0slL0OY25OjoKXPclYRK4qNk+VbTkZG0WSrNn2Rjgc7fIwk63bHIElBzvdGA6Im8clLgDhMi+QZhNJ1EZy2AJaOAyUzbuELIY1yaiP/nK7SgKVC9g2U0/uLF4hR9ePPUc7l/eQXtToDa5NsISJtgA/QVPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I80I/0Gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I80I/0Gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE701F000E9;
	Wed,  2 Sep 2026 11:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788348064;
	bh=06uHjEdGjlka9O3O2CEnuNp9IBZez85uTdhxJut18PE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I80I/0GbmAe+lLr+bO/PfZs9ghaK1/Nhr1+VBvfTmsYzqS2GDdV+i1TCl/uWp3Eod
	 cBfirM+yfAMowFZgTTBhwvaG5xEzZ92ilkIFpcv7G+vY/9muFe1noD4sOQUXo21xFg
	 hguasL9CERd28LycdiYoEsiDM0+V3qv0UO+Fni2Fw2VEVlSHB0Hh6m1TszXZvbQxUR
	 k6guZ8WUKTFmvBnF1j2j47UDIE38w36i9OF0C0KCPQow2YBxl55XxvFuNKP71sWkE+
	 GnxvcKwt9EGVYEB2aqJaF0fpVl7S8LqgOZO1ewbaW62h31wiPQdUxEzypOhV7bRMWz
	 R8sfSZ6Y00mOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD0392639A;
	Wed,  2 Sep 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: qrtr: Send HELLO message on endpoint register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178834800590.2227623.9286012112224510355.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 11:20:05 +0000
References: 
 <20260827-qrtr-hello-on-ep-register-v3-1-ca289ff99abf@oss.qualcomm.com>
In-Reply-To: 
 <20260827-qrtr-hello-on-ep-register-v3-1-ca289ff99abf@oss.qualcomm.com>
To: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
 christopher.lew@oss.qualcomm.com, deepak.singh@oss.qualcomm.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Aug 2026 17:48:46 +0530 you wrote:
> From: Chris Lew <christopher.lew@oss.qualcomm.com>
> 
> HELLO is currently handled entirely by the name server (NS): it is
> sent once as a broadcast when the NS initializes, and again as a
> reply whenever the NS receives an inbound HELLO from a remote.
> 
> Some remote QRTR endpoints (e.g. an external WLAN chipset attached
> over MHI) operate in a slave role: they only ever send a HELLO in
> response to one they receive, and never initiate. Since the host cannot
> tell in advance which remotes behave this way, if the host also only
> replies, both sides wait on the other to speak first and no HELLO is
> ever exchanged, stalling further communication.
> 
> [...]

Here is the summary with links:
  - [v3] net: qrtr: Send HELLO message on endpoint register
    https://git.kernel.org/netdev/net/c/544d85de4dc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


