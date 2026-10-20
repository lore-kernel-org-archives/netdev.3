Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522813;
	b=PXTTId1vuXg4vgC8b5B8h+dfMrbkSX7r4Rpy528q8pspSfi8EaTpIwcej2T4CZP7ERMX
	 ME/SZbJ2iwXMfFvIehgjlV4gViQLmUIfHlDhgZVhKsQt0YllSJWZRCq6bUuHUrrtbKPj7
	 65IpqewmG4DWtR10I7GwgKybo2ABogZhrDtw0ypzQktDoNH1KSZZ1Krx/3b7kO1Sfef0N
	 xTnCpehpSA3fXqEFnhEM3U9Qy46+GL/iT5p2+I6pq1657iHUP7lMT3tojoo8ivNbjUEvo
	 6rhWMLMV7Ahh9P4Q7VWqmYut1AYrH2sdg9zhIYutmf+ZnKk+aQO8OxBpjipprkYIJuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522813;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xptzn6H+kY/U51+BBw86cHqhpxcCxol1LT8XKtGNVLI=;
	b=0bSLyBjiyMao8GZO2RDHKF4aBeO/fk/QfWuDPRWoRGYcItgXNvr4WbOw5pRI6+k5te1O
	 gaZgmNuHqm8TOEUo+spN2xJVKouLKomEIIlqCkz2C8GlP8veqVaTIMrOAw4f3Barj6qSF
	 jW5cOxushHLjIHsu7PTwHReVIY069kOyKldqTa+WK8LzpVzuV+Qu/KPu1B5ko0UK515HV
	 GmV4hrB+5xmmrW3/OEHJEW6slxvBeKeTpPyQSZQf32fGiA2xvC2903majApyPwzXq/Mhx
	 b+09CC1WN0u6lUwxxELJP5Pu1v3UwhNb2Aq2xOvM2c75KMJSahdRz54plGOzxcs8CYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGeZUb7y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70444606A31E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGeZUb7y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482021F000CA;
	Tue, 20 Oct 2026 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522813;
	bh=xptzn6H+kY/U51+BBw86cHqhpxcCxol1LT8XKtGNVLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WGeZUb7y9QlYIX3aZmaWOkNJwPuAZSQpZEhh/hJoEfstfZjkcPaiq2QHXrczTziD9
	 qS5UrwBOsDwfWZGI56HgXg9lrbdn+DlcTRghUEAHbde7c3J6957pnLfgzwR1x2c7KG
	 gaseCXtQy/2bTIysoyQvu1wxduhwWGTblDQ3TtbA6sr5QvYKVnYCvHQfjyAlsxJ34r
	 sXubEwWsDcOgmw6wFgqAh7OQpJUe/MS2De9uzJ1VTsJ4c5iaD6g2UyXJWpC4l6igVF
	 UsVuCyNn3k+XrvnqkDGixnVGd6xIWxcFRkkGbHePisHygXxtmqtiHBZ5nmoSDXb7F1
	 lytdSo2JfH1Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3AF5F380820D;
	Tue, 20 Oct 2026 19:00:13 +0000 (UTC)
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
Subject: Re: [PATCH net-next] veth: use peer attributes to set peer real
 number of
 queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252281203.159319.14985722680524433222.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:00:12 +0000
References: <20261016160351.3022939-1-edumazet@kernel.org>
In-Reply-To: <20261016160351.3022939-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, odys.yuan@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 18:03:51 +0200 you wrote:
> veth_newlink() creates the peer from its own attributes (tbp), which
> come from the nested VETH_INFO_PEER ifinfomsg when present, so the
> peer num_tx_queues/num_rx_queues follow the peer IFLA_NUM_TX_QUEUES
> and IFLA_NUM_RX_QUEUES.
> 
> veth_init_queues(peer, ...) is then called with the attributes of
> the first device (tb) instead, so the decision to reduce the peer to
> a single real queue is based on the wrong device:
> 
> [...]

Here is the summary with links:
  - [net-next] veth: use peer attributes to set peer real number of queues
    https://git.kernel.org/netdev/net-next/c/267bc3f113d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


