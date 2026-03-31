Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69432690EC
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917622; cv=none; b=NS0BcAevFlvBz1vCOB87eImhtwUTH5W2+R3wXZotTC/l/oxckJUx4Gct/XzymfFZIN6tx/wvoQ/rhEzGo8wjETaGblUyUn4llSpj+Bi9m2gJxWJoPJysJp40eHNssXxgywTcXqESHoEoIzUBmbbk/HH34e8eset4uEHHto/JMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917622; c=relaxed/simple;
	bh=SnqxddBoXoBmehVOiUBc8GVDbNOokz/IBaub1S9sjsU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R13O46hCLec0V/l4iXCMpUXZRYaE0Mi375nlvC5JORIrr0WDqDrHA1hDDcAnuMbaBAC1ZmiYVkwOU7dMPBg9mflDnpJFyjpbFYJ+MGIF/nN5pq67WDYdyJU/J7nkXAx58FLcWTnBwE6FkdyRSrS5hxgxzJGa0msWJll7OiM865w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhhIe0w2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhhIe0w2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701DDC4CEF7;
	Tue, 31 Mar 2026 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774917622;
	bh=SnqxddBoXoBmehVOiUBc8GVDbNOokz/IBaub1S9sjsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nhhIe0w26OgsypzfTdlJhEilu4hpMx0S0nXbBfRLf2LmfwzkRH0+yQAcAtRzaYzZz
	 SIwaO8FghCVnLLpInORMwC/5vhKjhO4FpqCfH3nZLXI59hR4RqRM5KtXdsKJVLUuAb
	 P4VPg7MDlJNsh6jUPCwDt9sRt70V2zngYFMHIDqRrCwM/C+j0xf8VYNiB84pV48ZSU
	 CELINMw+jkmVhpwV5C6SYZnLgEkZY6XX71QTTkdpm8Vzm3u+al285rrfl08zF/2A2c
	 9xb0/XdQ6XK8UIYQ00rBBjEoRvw1e1g/2TZVbYCgM85pbXUkKdH9G2D9rydfgZqfTa
	 RHLJ4c0bvjuew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDAA392FF85;
	Tue, 31 Mar 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Add missing cleanup bits in
 airoha_qdma_cleanup_rx_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177491760629.2032642.16020894977460400063.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 00:40:06 +0000
References: 
 <20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org>
In-Reply-To: 
 <20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Madhur.Agrawal@airoha.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Mar 2026 10:48:21 +0100 you wrote:
> In order to properly cleanup hw rx QDMA queues and bring the device to
> the initial state, reset rx DMA queue head/tail index. Moreover, reset
> queued DMA descriptor fields.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Tested-by: Madhur Agrawal <Madhur.Agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Add missing cleanup bits in airoha_qdma_cleanup_rx_queue()
    https://git.kernel.org/netdev/net/c/514aac359987

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


