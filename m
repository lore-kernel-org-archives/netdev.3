Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531809;
	b=ArfkIOi51BJN05wWid5MJ+YIZIB7aaBjrN+r8U+19vVmXmObQvyfmswvSWaHwhnjes3M
	 6lPbpZsQJK1RvAYvw4k5RwUtoRLL+qAL0yhDGj19lgYAb9Rsi3qpdhO2UIZ9M7ShAGQVx
	 if9fzlIaphdCKjNU5F6ps6qN4wNn5b+T09TUQ3k1n8xT3qAnvHVmWqks8B54RZooE2VoY
	 xFcHMOpl96UWn3VzOGCJHj2WpNhLUaojs2ENlA0wjGc0BgfpXPQT2fNgiYCxlcuKCYx+z
	 4vqaBKM5qC4VVSj+oSCt4HvL21hm3WcjsNvt+3/k9mBH8PpAr9/2cWi7nBGUbyUBtvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OmQFMPtyYLageSxmOmtp+On6Tp/ZOy20MqMy9uHf/Ng=;
	b=3idW/xkR9TKxQOepU6vz0tnUe5wlJ4hT7z5gaL1BzJ1AN3JC1pAyKzICN60vBnkuLVHi
	 VG83R5xoTPIZ8PDj/DGrO4vgho0YdveY5rfT4S5/1UlF6kx4KYc7jH+Mfg9a1BVypjT8I
	 OGlq7/X1CFtNnN/jl5ly2vJQeQx4PZy9C6wmWLWH2qsrFKwOY53b+/oqmb89OLJ/MMgmg
	 Y/dauSoRZq4DOoouU7Kkh5Vp2iWUkwHfkoecvGpqQvAjKP8Kkzy9OeqQuHzdMHmfNVmMz
	 Sp4xfjVp6BfHUYe9JeLifi1fvdyHbErU6yhPyfen7zS+e9SUFLflMknsDdBVuI1L9rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpRe5f7T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE963606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpRe5f7T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A06F1F000C9;
	Tue, 20 Oct 2026 21:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792531808;
	bh=OmQFMPtyYLageSxmOmtp+On6Tp/ZOy20MqMy9uHf/Ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kpRe5f7Twc4d1uTLlteL7gg3nduW3S/teD54VkiTgTkbM00MQrdOuJ58PiEC/ax0a
	 169VRQ3tiNF/GOPUlKfHXWoo9zjo6xp+j8jO0v9+YQ+qV+nbJUY3AQln6BdeCd+dp7
	 2F5Jx9fHj0aIaNZApRbmWVZId6gnFRT0E+CDt5SQVdal1KbqzCKGmEoCEMcZ1LE12I
	 dvw4RBBlhJ1Diq2QEgeR3nW1Jmaz7RI/ysIV1J8r/iFT2Y3d7SUPlZuVPigqZjf86U
	 XNJD1LSpeqs1QF2DT7+fmAE8jNKLpGofs+Fbv/R9NS04kYIL08Z5pKELJiaj00xo2c
	 9x9nSCaJBZiLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4033809A09;
	Tue, 20 Oct 2026 21:30:08 +0000 (UTC)
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
Subject: Re: [PATCH net v5] team: reject CAN,
 IEEE 802.15.4 and 6LoWPAN devices in team_port_add
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253180704.220085.9993391551263232931.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:30:07 +0000
References: <20261019155407.61487-1-socketcan@hartkopp.net>
In-Reply-To: <20261019155407.61487-1-socketcan@hartkopp.net>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: jiri@resnulli.us, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 yaojiale02@163.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 17:54:07 +0200 you wrote:
> From: Jiale Yao <yaojiale02@163.com>
> 
> When the first port has a non-Ethernet type, team_setup_by_port()
> copies port_dev->type to the team device while netdev_priv() of the
> team device still holds a struct team. Several L2 stacks identify their
> devices by dev->type alone and then access type specific data that the
> team driver never sets up:
> 
> [...]

Here is the summary with links:
  - [net,v5] team: reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add
    https://git.kernel.org/netdev/net/c/9043be310c6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


