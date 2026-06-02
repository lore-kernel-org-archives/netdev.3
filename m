Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFAE2222CC;
	Tue,  2 Jun 2026 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437010; cv=none; b=OAXNCkwq5f1tAhzcU/KjU86BbuU/Zv0GhNLcJS+MbRLGc/xWoHsfu4XidAhyn7a0/ffUD1rpQycdZXjNRbKp7zkoU+gGPjVe55cF0s3/GGcz6NenhGQW44ZaqzawNpXk1oxisogJ7XYIsI6Esvvn178dSrD7sjUhDJu0yhstWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437010; c=relaxed/simple;
	bh=FBZhZmLxTjrMjjUuWOuz+bKhBm2MSkUwZ5nqPDJYB08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZKx5N8KQ8T9pKPAOOsvrnw5kBrm2zYG7pnnYuQB5x1faC8ZHI4OOk05HmLNfdjA4wc3O8km8OigoilZoBvUO3781XnhKnH1dt8yKssLr7jMPgi5Evd5KmaeFAdADStr/lPhCsFHZANWkfRxHKg9x4KS1j4Zz1gPBrTJVQC1kKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGltOLlR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGltOLlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3EC1F00893;
	Tue,  2 Jun 2026 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780437009;
	bh=nQcaYffoG62yu2kpKoyjolTo7IWPDiKhOghR01NmikU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YGltOLlRWhEnPAZrJu98u5Tmm/UFrgWXQ8fxBqWY2p19w610/aspC5J59rnxpzioi
	 xALGqR5/sPR7CeH6zulybPCXntG8HhqnE8qEzPXZ3g2IWGG1rrTLbTFYcYfSzgUlEw
	 NwZDnuY/9SRzWNDPW6P7zonUyIFYR25UmWbBmeT/lM9rgK7BDyhoV0EKYn7D7Iifx0
	 8J3wIoUxWVasMU71mHZdH9yoHTM2P4zuB0GbCPCBnOCzgHUOGarb4SzwUjPtVa28kb
	 cb7tHrTd3U36Duzc10TWILzjCbcQ+uslpT9Fe4kejg8ds0C6thMXsTey1Hq8W9Ub80
	 KsMIrfL0mYtdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A5E3811A76;
	Tue,  2 Jun 2026 21:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dsa: sja1105: flower: reject cross-chip
 redirect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043701113.1064960.6026298400485604786.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 21:50:11 +0000
References: <20260530003940.2000994-1-mmyangfl@gmail.com>
In-Reply-To: <20260530003940.2000994-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 May 2026 08:39:14 +0800 you wrote:
> dsa_port_from_netdev() may return a valid port from a different switch
> chip. Programming another chip's port index into the local hardware
> causes redirection to the wrong port, or an out-of-bounds access if the
> index exceeds the local chip's port count.
> 
> Apply a minimal fix that adds a check to catch this case and adjusts the
> extack message. When cls->common.skip_sw is not set, the operation could
> instead redirect to the upstream port and let the software or upstream
> switch(es) handle the forward, but that is not addressed here.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: sja1105: flower: reject cross-chip redirect
    https://git.kernel.org/netdev/net-next/c/cfa5274a5dc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


