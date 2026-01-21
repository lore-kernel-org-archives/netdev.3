Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F446348445;
	Wed, 21 Jan 2026 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963223; cv=none; b=VgGYAVTy2bf7M5GMYjgBLQgV1LlaYDbXZbPhZDePYyZGle5pLJFGbS2EgRem/LCma3ISC1on6k1R2CX5KJ74a3pLvq37f5+dK53e8BjhKZNqWDgwVxGVUToFvxT81I55AoUaWhClSAfSkcdB+x5iR1XMKwZY662SZr6KSEMUGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963223; c=relaxed/simple;
	bh=+kKuvKZBAVpGffavCyJG72uGSUe/JaL1MpWlhAU2I8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UhsIQwOjle2+BY4810Q1LiNpDhGCXwoGvzgXju48z4i8YTWsl1F9lflBlo2y9j/0zEu8+4cujWbo46KyJu0md57woX7FiQuY8rZXxvJMAAtlmxbfnbIcd1YOqByoFJgNHkrtSH4FUIgzVxgSJ4VRswg8BNWMnp+hZiRPjSEKhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkshXmvI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkshXmvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32492C16AAE;
	Wed, 21 Jan 2026 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963223;
	bh=+kKuvKZBAVpGffavCyJG72uGSUe/JaL1MpWlhAU2I8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JkshXmvIGEVVusGEnf9mIMBAaZVfNSVSqjnFNLH6cWUnNWIGKYim0c+KSlLAXF9KR
	 DBVKBzfAt1HJEHSM6qKfsrar+OFytHQPEaOefVTbMJqH7Nvvyvzv0AAAEmCaHrAUjG
	 mKU6JhDqeeVyUQzvzilKimtvVUQdfBP46S3SZjPmx/nHr2tfYdswwmsaS2Xee/3N7I
	 Ojj2gsA5rPNDcpCv4ZZLkWM+Su5R0YRLZ+cnNnsmNJgSs0vxYXb3MazCg4W1EPSzsC
	 88TqmJrti05ixwEQI4cp6t4wXCHYDZ+OaF7hRHsFDjYexHz6UzeAaF3n4eRxjIchGa
	 y3Bj0w8kR2xIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D1E380820D;
	Wed, 21 Jan 2026 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: remove the redundant data return in SW-FW
 mailbox
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896322035.699622.2790684243723717712.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:20 +0000
References: <2914AB0BC6158DDA+20260119065935.6015-1-jiawenwu@trustnetic.com>
In-Reply-To: <2914AB0BC6158DDA+20260119065935.6015-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 14:59:35 +0800 you wrote:
> For these two firmware mailbox commands, in txgbe_test_hostif() and
> txgbe_set_phy_link_hostif(), there is no need to read data from the
> buffer.
> 
> Under the current setting, OEM firmware will cause the driver to fail to
> probe. Because OEM firmware returns more link information, with a larger
> OEM structure txgbe_hic_ephy_getlink. However, the current driver does
> not support the OEM function. So just fix it in the way that does not
> involve reading the returned data.
> 
> [...]

Here is the summary with links:
  - [net] net: txgbe: remove the redundant data return in SW-FW mailbox
    https://git.kernel.org/netdev/net/c/3d778e65b4f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


