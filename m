Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF117BED0;
	Wed, 20 May 2026 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243595; cv=none; b=T/KxNex8wBVUa15q/yqfYaUuXdYMhqZvHXe8ur6oJxXfIGlZdSwlMCRj3pVd+YLJsilgfYcPMGc/7XHwpzmqEUo1FCe2DKucF2H+hEu4EzO1zqGRKYu0qO3HghD4kFCaQrsOPi7dAu6JMzt1KIHmc9gNxJIxN6mRcvUVW5zvRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243595; c=relaxed/simple;
	bh=okPCJZDFOA+hZpRp/uWWkg8pW1ClQ6MBr+kNRzZSrEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NbSyt+rI23/LKw62EU6zHcKmGCa9XXmPU6ByHmwH2uvrwcO95/H0g1hFzI35FuKpbWzavowo4YP3TiKLsHISLqwXbyZ743wkdYqJdGx1i/LSQq8eMBLKgBJnEOZq48aIMEazNsgySPZGlQ5OpohfUK+wqGE5hWHljCz0pGgcT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCzwoCqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCzwoCqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD8A1F000E9;
	Wed, 20 May 2026 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779243594;
	bh=+uiilYgxo6bsmcQyug6l6SMDBxOKEtiJiP+RCh0Sj0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JCzwoCqy/EZuL5fSs6Xtt/R2LwObUZETnKC3vD+5iLCnahr2G5Z2OiGy3fSdz+zEC
	 nchdAFUnvA9NIqq6+AhOjU8U5ZbyAl5+u7eUh6eYJQ8zV0AVqyPiWXjEnr9oGZzUV/
	 dFF6rjJzIRPcE8ID/A6l2F3JsR996aiFWf4p0ZjyPQyZKhRIiqW3itmrkwU4W/+A84
	 aGmf5mSY3OosAmqbKV1MVPV9i0TLzEbhnP4ChH+JKwe755dFK5fuLdoWkHl2SiiVpm
	 NEAB6OkNFIFDWg0/q1KzwwqDGxGhK1UiF6yx10R78BSPe3PtZP6oMCRwVh44oAUQGE
	 ngPwiGQA3AskQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D3383BF53;
	Wed, 20 May 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net] net: airoha: Fix NPU RX DMA descriptor bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924360515.2953435.16053845694488333634.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 02:20:05 +0000
References: <20260518134530.3683-1-ansuelsmth@gmail.com>
In-Reply-To: <20260518134530.3683-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: lorenzo@kernel.org, kuba@kernel.org, nbd@nbd.name, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 15:44:57 +0200 you wrote:
> In an internal review from Airoha, it was notice that the RX DMA descriptor
> bits and mask are wrong. These values probably refer to an old NPU firmware
> never published. The previous value works correctly but it was reported
> that in some specific condition in mixed scenario with both Ethernet and
> WiFi offload it's possible that RX DMA descriptor signal wrong value with
> the problem to the RX ring or packets getting dropped.
> 
> [...]

Here is the summary with links:
  - [RESEND,net] net: airoha: Fix NPU RX DMA descriptor bits
    https://git.kernel.org/netdev/net/c/0cb5a74faa3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


