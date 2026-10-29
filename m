Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283606;
	b=dEUVd4X+v3b7ZYAps75AXSPcnVoP2D60js3FKmJJnQcecnTjY9TjEGsYCh+W03nMfvAJ
	 qFDIfrD11+biooX1m8ENtsR4Wzg10CUb2aFDpinLSvhXJN44ID2thTtGEyu2yjT3G+WwQ
	 fMbo9AT89faP0uNQJTQPk49UNC5kUbdBoXP7NgwznshJMtZ7D+a65PZ7ePPoK6z+55Mtq
	 Lg9bPbgQ/hZV4uJd+qyLFkhcp/O87QxgDZJntXHswW0kw2SEdY6G379Ybz0wduivQhrz6
	 CnMN0YhaXw6zspvaWahKJbiVT8cBS5vFvRjdnpF/g0/F4kz0XmqrNOwtVfKIdVBBnpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=azCfdFfEOpWAFKxP2UhkqMij/czNHd3aVHO/NXR1mqs=;
	b=1SM5iupZ8PkmSMnssoKqTLxIEqGySaCoaLYcR9t/9322BnLQfDVBrJcZfr13r23kz1BO
	 r7vBS3L9uJ7+iN39l4nEFfKUqQooJBTU+A0H+Knl+Z7WAkVhGPfp1GtMftdBvCDtVGjCw
	 dr9VZp4zhGjTfL2GVz8SOhrQJdj22ZXYu4Q4pStmBK7XT9/bL8/yl6NgGkZRHEyrZuyg7
	 MZk68eCM+mseu2ApYoOIpNlsv+QN25RT2Tu0fYoztOWxea5K7d2a5tc05eXSkfLgLKO9g
	 90KMjb/go8C1UwjhJcGKpgKDtTJNniAv/DWBitbF9+1FGb8+0iObzffmmfskLhKBrbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoSeCBJb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE6606A326;
	Thu, 29 Oct 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoSeCBJb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDEB1F01825;
	Thu, 29 Oct 2026 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793283606;
	bh=azCfdFfEOpWAFKxP2UhkqMij/czNHd3aVHO/NXR1mqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RoSeCBJbcSVuAxlABj89ifFTk9tPRttqpVSFpSARLjHKCO6Hd7msOuvl4ZHS5/DKh
	 6BBZUY2gjT3Zi78/As3dPfhynR6/jeCu7z7mRC7PDyEx4Cd3NlPmqzJKx0xD4RgB67
	 0iLvGW3U+s3LTAL7ZUoYVUTKJ+oazm3l3KlSvOAk3B6+9PqXYnNlhDaJMZDNjR67AW
	 tGrQJTTQE/UbwEyydbQXxesMeK2sNyA/OXq83Xwp8FxcTJ14nQF3HP3SZun7Q3v/tZ
	 sOj5uhdeTFwd1KmMKCU6YuY3JjGK7pOBfjMQoSHabR9YyNP+7H4Ta65701zrVxrHeA
	 kf8eMqj2qHUfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 031D5380821F;
	Thu, 29 Oct 2026 14:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3] gtp: Require 'CAP_NET_ADMIN' when joining the gtp
 multicast group
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179328360480.486939.11371255665997117082.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 14:20:04 +0000
References: <20261027130623.3136658-1-anilkaushikwireless@gmail.com>
In-Reply-To: <20261027130623.3136658-1-anilkaushikwireless@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, nicolas.dichtel@6wind.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Oct 2026 13:06:23 +0000 you wrote:
> The gtp generic netlink family sends notifications on its "gtp"
> multicast group when a PDP context is added or deleted, and for GTP-U
> echo responses. They carry the same attributes as a GETPDP reply: the
> MS and peer addresses, and the TEIDs, or the TID and the flow label.
> 
> GETPDP requires CAP_NET_ADMIN, but generic netlink lets any user join a
> multicast group by default, so an unprivileged user in the network
> namespace of the gtp device can read all of this. Found by code
> inspection.
> 
> [...]

Here is the summary with links:
  - [net,v3] gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group
    https://git.kernel.org/netdev/net/c/db627e71b6da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


