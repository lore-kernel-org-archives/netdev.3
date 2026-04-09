Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411C35DA6F;
	Thu,  9 Apr 2026 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699479; cv=none; b=W2dOz5YbaXmvrZ9lmjz1c7x6X5CuVs9YqlSJw2hkXrLOMPi7XskNX5uB0luch9R5R+0qJR+RqNiXZS3sllgC+uyMM9uOy5uNo+vaQHZrZEvHSSBA8GvSzk2jHTD8BR9i0Pvx881naW6UF0bWjTBsapLFhsaPkQLYNGxBoXerdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699479; c=relaxed/simple;
	bh=g8kM9obhYUhsvgUzgPX26/J9c7OD7ksgHWmYeRSruCg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sHSGcPNG6xk6k6EEQVu3QpgZIYW93ZC1AF+NKZG2Ng/dDFxshfIn3FQnlz7MvpT32aNcBuWe+Ix2sbG45vDgUCIlqq9WB+JCVlYoLY5z/5yLc5RrPUENbBFuFg1zLabwU8sVCEDQPDGw9KkKF4xS/YUwhLlRLu85G2QpRduSR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suQRx5v5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suQRx5v5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4D8C2BC9E;
	Thu,  9 Apr 2026 01:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775699478;
	bh=g8kM9obhYUhsvgUzgPX26/J9c7OD7ksgHWmYeRSruCg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=suQRx5v5hSguUXuVsM/aReZ6uG2S7Ma1r/nU8uucB5HwJNJBjnfEQhO94qxJHmvv3
	 M1Yf1uugKUUwuU+WnJEHPCzOKy/cGUqNMk/rCkeiZC8G5gatAMtlNPxFWvnH18CtfK
	 gmp5nr3sjxxT/ugI6lOAv+/p4+nAIu7Z7sJFlpP7ny1sb3TXohgX0oSzv51lwyK9HX
	 7Vp0hR+hbYzVQBV4rqILckl+u5CXot9yjHJFM+p1N1Yk8RtAH4h+3vr6bHyjUOhyaP
	 /3u2wR84783dccVq47Fl5MizlVtLRCZRNq0uGPom+laCJi+537GIQiqPCBnv14fh1Y
	 2VcBeNNprDCSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D063930793;
	Thu,  9 Apr 2026 01:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mdio: realtek-rtl9300: use scoped
 device_for_each_child_node loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177569945454.949482.8646117097386693287.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 01:50:54 +0000
References: <20260405-rtl9300-v1-1-08e4499cf944@gmail.com>
In-Reply-To: <20260405-rtl9300-v1-1-08e4499cf944@gmail.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 chris.packham@alliedtelesis.co.nz, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 05 Apr 2026 14:51:52 +0800 you wrote:
> Switch to device_for_each_child_node_scoped() to auto-release fwnode
> references on early exit.
> 
> Fixes: 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/net/mdio/mdio-realtek-rtl9300.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - net: mdio: realtek-rtl9300: use scoped device_for_each_child_node loop
    https://git.kernel.org/netdev/net/c/c09ea768bdb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


