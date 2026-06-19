Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6A2D7DFE;
	Fri, 19 Jun 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781833216; cv=none; b=d1ERyfIDnCQ++myuu3sOZacPAPnP/VmaUZ4d8wjafLzN/RK7qkWBViOMitZzkk6aGSgomA2rtw5goOgLY180kwCapdFuvIKdgnj4QEoAhuU/qSZg65b97haK2iiy4Pmwzt/LAeWDV3f3TeTBBFWQDEAgNzWGengOM2MuvMiyCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781833216; c=relaxed/simple;
	bh=tjrJsdIiHCYCLuGAc4YYeeH+4fv9InnIjprEQNO+zmU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rvEzdtVLmCZfyyAl7DhyZkcOv8LaR5ocukUrufZrPC44Vk6SQFdCmVHSTxDjhDQ7lhqLCddZXoHdn3Lq8Xbw5Zk87dNfBV8rEcg4HLlOW8YzV8Kczk0xElWJQtNmSgB39JtNes2n2saijbPI+86OC7OetTq0fSPpt70CJJraTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b75OFL6x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b75OFL6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1772C1F000E9;
	Fri, 19 Jun 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781833215;
	bh=dalQDSYP5jn89rgqcf5/uZT0A/dR08jUgd1Cghk6t9M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b75OFL6xe+b5ekbEeWHRibmKM1EsBaKKZoTFMiXNjsc72DtqbBQmG8QPaKzmReyYZ
	 Nhs/y9pn7RznylrAoyMjPQDIszeM7Vq9qm5Jfs3Vj0fhxkWU1SSjer9A4+DaOogkkf
	 H253LEv8zElD1hIzeXTbkKvka+Hmt6ZGmghEZgnnLDjzHIc+eVgM/yTzvpgRG8RytE
	 EvpbshVk9963EMQFHIyjf+ZQnV/Hm5at7SKaeAhlgN4va15MZraTzDVyp9yJToU0RW
	 3pP2Qbm2mwEh//INjDmNPS/OZwmH/KnSS+iMUuM2AF3pWJAJxq3IZfaYAH7RO4/T+G
	 1+Uu2VMVhPwag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397F3A78A7C;
	Fri, 19 Jun 2026 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: take netif_addr_lock_bh() around rx mode
 address programming
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183320839.3155315.16217960317472010329.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:40:08 +0000
References: <20260617-linux-fbnic-hwaddr-v1-1-3f9f5dee7f99@gmail.com>
In-Reply-To: <20260617-linux-fbnic-hwaddr-v1-1-3f9f5dee7f99@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, sanmanpradhan@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 03:39:49 -0700 you wrote:
> When __fbnic_set_rx_mode() is called from contexts other than
> .ndo_set_rx_mode_async(), the uc and mc addr lists are accessed
> without the addr lock that __hw_addr_sync_dev() and
> __hw_addr_unsync_dev() require. Wrap these unprotected accesses with
> netif_addr_lock_bh(). fbnic_clear_rx_mode() has similar issues.
> 
> Fixes: eb690ef8d1c2 ("eth: fbnic: Add L2 address programming")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: take netif_addr_lock_bh() around rx mode address programming
    https://git.kernel.org/netdev/net/c/96e7f9122aae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


