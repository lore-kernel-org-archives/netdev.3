Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95E40758E
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629841; cv=none; b=s1tqwX7XIbTIhk/t7TXduVwHxDPlf2XyP24297vkPeGXt7/XOcdFM/WL6dndK1EMM2AS1vm8aQ+HfdZdzJ7Mc/XUsMNuz94hq4fVNoXqTikoWwoIZW09/ALth2RN7rk5tvcNVK7uHcN6x9TZ/0w4KCtm+zETUZgwxMPvL6q1YFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629841; c=relaxed/simple;
	bh=HsWaxB/jVdTynqA6y9GTuychbG1GvttK63s1BptFS50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lrewI6yFDUvsgUjpx9k7Fyr9UlawmxMExeNVLOMcMKQWz48SVQJGrxktrNYi7H+orTonUOu/E0RxsRJ6135H/v4/dmqTZmQwR2dBt8Lp4ySFMbgvnK2OBCM6FuGJ7AmugNh+VCMB5F/qrEDgAeEumUcEqe8JG6lCkiAu3V1Sj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aERziS7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aERziS7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAD01F000E9;
	Tue, 21 Jul 2026 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629840;
	bh=d4cOLPLODyeaZekERL0OYLhTbgANEJqaz7Pl7+zSZ+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aERziS7sSsOVVje+jV7j5sXkBk6cESK9Fsy5mMg6OeeAWm0zcNIIro2Zj1Qf/Y0M5
	 q4nulIaT9U0bLR9Az+UES0tsuwHlty0s6PdUlWNFRswBDA+ocKTb0xsCdG6MVtCHuN
	 cBBoEcZT3WpbqwxhzIFZFSK5KCQDqQ+hPT6P0W+Lu1TzTf0uXjaFkyTcBoE1W9Pezj
	 lKIvNzIHaIKQHgdnq0EHGxm/n/TXFAXMO6tvdYag4+96906Pd+Gqn8kC8NMgNFtKN5
	 Y50vH8pUuig6wnpcQI6WIlTdNTA+c5F8QuZ9folB1qlGAgnZxoUaU/vblgHSH6lF0v
	 V+qvP5tcjeSow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A8C3924A64;
	Tue, 21 Jul 2026 10:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix potential use-after-free in
 airoha_ppe_deinit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462980990.215603.3787793287900751289.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 10:30:09 +0000
References: <178351022574.97989.6880403520276841703@gmail.com>
In-Reply-To: <178351022574.97989.6880403520276841703@gmail.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 8 Jul 2026 19:16:16 +0800 you wrote:
> airoha_ppe_deinit() replaces the NPU pointer with NULL via
> rcu_replace_pointer() but does not wait for existing RCU readers
> to exit before calling ppe_deinit() and airoha_npu_put(). This can
> cause a use-after-free if a reader in an RCU read-side critical
> section still holds a reference to the NPU when it is freed.
> 
> The init path (airoha_ppe_init) already calls synchronize_rcu()
> after rcu_assign_pointer(), but the deinit path introduced in
> commit 6abcf751bc08 ("net: airoha: Fix schedule while atomic in
> airoha_ppe_deinit()") omitted the matching barrier when switching
> from rcu_read_lock()/rcu_dereference() to rcu_replace_pointer().
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix potential use-after-free in airoha_ppe_deinit()
    https://git.kernel.org/netdev/net/c/2484568a335c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


