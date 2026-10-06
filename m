Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CC31578E;
	Tue,  6 Oct 2026 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244814; cv=none; b=rayE75PPq2xv5RIpEhmVOAhqzmvb9w/DIh+MTQdNVbU4xk1PIf2cmmYOf5UZ+pDIwroGdUv7WvSc0jUUS2ReOQs2u7eGMUjnoN1QIfuQ7bPPFn8Ms8undl1Z3JBXA99RiYu3jya4x8/TcIji2JFA2YTREDb98g2WaWF72ydOynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244814; c=relaxed/simple;
	bh=yak6EVzq52uU7zbwEFX/skdZWcJVCjBCC1OJjvZN+wc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ow6qHujJ2oZ+aPsAE1+L9w1u0YxszP5WfTa0pt4CO/wu3gRsaiW1D5beloYIq5oUs0Wm6I6a2rdLCp2D/TMGs6fuJErHU8NA6XR9gUAiZEIcmLU7POvQQS2FFrSGFa1HnOOXFAKnBDztoJKPwH3wX5KkdsuaA8YUgUpaR4kAPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0N2/yAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0N2/yAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C269D1F00899;
	Tue,  6 Oct 2026 00:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791244812;
	bh=eFJIjseEChRYkdU5UsgLbWci7k6BJdIiTyvVcRmXFaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K0N2/yAY3tkMcOIDs6+kF/UfYkrc1WAj7TpFUzRxNNBJvBUwmNAPJaG3MjM4iQqzN
	 PPfOBLdSdnT0d7IdnTzH7f1pKWGb9OKmIOnGwde45P0XknxnDaEroLD7d3nv3HnzS/
	 1I/urJxsUd5f1Jkm64BxY84BZTbCwSgTi7/4c8TV8oSSss+MKElmNyGSg+yb6yDByG
	 resBulmcxXZLWEFSKUAz5FRVI5NnA5GN4h75Kb6pzlDfZgtUgou8os21GsmE/traeV
	 Azj2N1GD/cnVVO8Lm4zD8h1XFttXiuISJj8tCeQrts4UAatgxZemnO7WctuYLS2/7o
	 7Rncl+moDbshg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4410392667F;
	Tue,  6 Oct 2026 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mpnic: add NAPI buffer depletion check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124481127.1944959.8347251870920049809.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:00:11 +0000
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
In-Reply-To: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 01 Oct 2026 09:38:57 -0700 you wrote:
> This series provides a buffer depletion check to unwedge Rx processing
> when page pool allocations have failed. Patch 4 has a more detailed
> description of the events that lead to the wedge, but the high level
> idea is that when page pool allocations fail, the buffer descriptor ring
> can run low, and when that happens the device will drop Rx packets and
> not raise interrupts, which causes the NAPI event loop not to be
> scheduled, so new buffers are not posted.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] eth: mpnic: use WRITE_ONCE() for BDQ head and tail updates
    https://git.kernel.org/netdev/net-next/c/0de04d82b63c
  - [net-next,2/4] eth: mpnic: add a service task
    https://git.kernel.org/netdev/net-next/c/d990f86c796b
  - [net-next,3/4] eth: mpnic: set Rx buffer minimums using page size and mtu
    https://git.kernel.org/netdev/net-next/c/9e072eda51ca
  - [net-next,4/4] eth: mpnic: add a NAPI depletion check
    https://git.kernel.org/netdev/net-next/c/56f2178ff7f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


