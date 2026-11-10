Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343210;
	b=vR3FDiK0KinIPCXOM1TekuWmvFahvGf69DIhVkb5nrY0XwXPbirNs3cn0VOg9/VcEg62
	 DIew56X5hcvs8Zk3F1tv+OOus41iCdPwbpgfrkvQ+okOAkJqbBUCYMpLUXB9clFi61w6x
	 Kq36SwU7yOw0LaR/4JyHoS2tbOQ1oSKLScb5ygZUwKhQ4dgRoCOPiSXJ5/CS2g9QOeeAo
	 h4PhZEBIO5NASlKbfcE2zkVuq5SZtCyHoEZEghHLbZrh32N+OhVCdt8iJMKYg8xt/daZH
	 rJWZhHcshxuM0UR6zH30eIU2ao0gunXB/KWcpEAXzl3ZBC6cstjp0A++aTaBNElizOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=tH7VEUdf+F5G4QVeqrk092cc8aMIfb8V1vO/1TFqi0s=;
	b=E2TOK1Rl5c+t4J/kL4cJESEXk1WutG47MoEr2uan/jzLyXhaTGEZ7eV5w8HlumP3oa2L
	 63biIt1X+yRhO007BotnUI+aDddNikLgmfKHHDJuMs8lO1tRr6two+ZT5enLHFpgDe9aA
	 fz99HqtZygHaVNCkivwWXFbCU0hXYxZz668phEJxS6JZvKUWmCmrKuyF1hHtQfFBXoLop
	 0/4tEXWD7QZBLay5Mws9qHBjcZdxH3lVLcXyPdrAGllbn6rP1AHo8ief67ATXIMHI3d9t
	 pf0tntH7dpMsDTU6bVZHeAc+ZXTfojjkJOQKamSt2D3AmwzjgMZTYxxhuyDZz+tfeIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwnCAze0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10D60A3812;
	Tue, 10 Nov 2026 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwnCAze0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B14B1F0089F;
	Tue, 10 Nov 2026 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343210;
	bh=tH7VEUdf+F5G4QVeqrk092cc8aMIfb8V1vO/1TFqi0s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DwnCAze0sSTut+Dgb4VfT/uuQuZyOMhw5X6/Xejt/ODP6tUm1/nJt4qclP0LUD45/
	 WsuHhJRkg+BJ3purSl/wxLt/Q9utnuZehp1mB9+auMaV6eTZgJDv6US3M0MVqa76N2
	 yUr4wKX2zMvsKcgGfO4HYjh5wuYrHkbXc8FGbmKgLfClP7xeKFAv98EQ68O/NFeTb/
	 W/AlTYq22g9dpsE5393qqFFgNRfsJvUzpDbADHZRbLq9ZiYGy/K6MOQcFGzICxYFWr
	 glfSJdhX6Cvu+qSfFwKCJC0LnYjRg7h0rkzpdhgNuzvR1xjeAJR4KPpowtif9lJLfR
	 naYGrHFXdynqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2110239D6577;
	Tue, 10 Nov 2026 20:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tun: delete the flow entries of the moved queue on
 detach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434320867.48129.7633247531885586539.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 20:40:08 +0000
References: <20261104174240.138491-1-umangpokhriyall@gmail.com>
In-Reply-To: <20261104174240.138491-1-umangpokhriyall@gmail.com>
To: Umang Pokhriyal <umangpokhriyall@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 23:12:40 +0530 you wrote:
> When a queue is detached, __tun_detach() moves the last queue into the
> freed slot and decrements tun->numqueues. The flow entries that point at
> the old index of the moved queue, now tun->numqueues, are meant to be
> deleted, but the call passes tun->numqueues + 1, an index that never
> exists, so nothing is deleted.
> 
> Until those entries are refreshed by a write on their flow or age out,
> tun_automq_select_queue() returns an index past the last queue, and
> netdev_core_pick_tx() sends every such flow to queue 0 and warns:
> 
> [...]

Here is the summary with links:
  - [net] tun: delete the flow entries of the moved queue on detach
    https://git.kernel.org/netdev/net/c/4cc0a3f89707

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


