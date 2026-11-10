Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279291;
	b=MH57ZqLR6RjFvpEN71AVoVKlFk/rAO9XG6n2tNqrT0UAnaSL68EFIKg4iNyfesU08Iwj
	 MFui1SoTt0nUoa1/MSOWaFaw6IUu6eBnfs4v8ubzWmC/FMf//BUX6JCwqTsS7R2e7D/OA
	 spkWMptLJD5ohkTUx/80psK9TDfNEkqn/b9IwIrwdsLYVdC3FLF1kHY5Mz4Fd8IR68oYY
	 tYI7FwOCSSGk560Eb5i7EebG+sTKeFzfTexGHuTdlqo4c8G+ZJwIMLJAICDiciG5WjPDJ
	 qHnCCTUQNr6DZSk9fMFnqhras5fiRif3XXasT8fp/2NjO8R8RbjCbFzWM8yaf2hfVSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279291;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Mp9JywJ7RGBZoOqCJC8KPg1sGMlk56yOuRg/jLsNvjY=;
	b=Y04n2lKxa0W+ruvv1IAY9LW1NbBoqfmzGmrv1MoCccxLtReoGmif8n0jJMpQx/EicKpD
	 Ihq8xt74zB2vGeDoRbliyYu0KkfaCqNRu4nri/EE5wFd3PNM02YybFAHOwwHoDT2q8UNp
	 mpg45x6BNMbfPepDIBx4Xn9D3j9ZuUki1IcrZke0f+NbicJY1dh9TbXK5h/CJSBNaCOOn
	 Zo03BUAuVthFh8mJQIWN1s3YCY/Jz1ITnpNuem3z+pI+CrgeF1HC4Gto7ceZPP+EiZgE5
	 wgpGzOSJzazIUNc4RllmR+/evdO56vCrriIiBZm4h121SEBRzBlI/eF0tQzpMWXr0Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpECLEHK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455160A382F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpECLEHK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD7D1F008BD;
	Tue, 10 Nov 2026 02:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279291;
	bh=Mp9JywJ7RGBZoOqCJC8KPg1sGMlk56yOuRg/jLsNvjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OpECLEHK9M2570zrXfj5weMxRADAkHETMaN8F8xV+FvYZJZmjDASOxA1hzlrIqBji
	 BH6JFA5INl7EkrCbAAkfXj9lGjfkg4avVGNpughmnKT2NQja/JSjFZ13rTCJ8MQTmK
	 NaD+qyD9ah53mD+5++NYwqtSUg/Ci8Z0oRZZbMWvINTnPKMi2X0pyIyjRFeXjxLvuO
	 QX+BnST38kiFsCMZei9y8KpxUn6L7UVBf2BATL5+koBNF94L8Y41iccXP3bEZCGF56
	 B+QozD3cjhqAmnWB+dP8AM+z6FYmgF/1kij+oY8x0xNWeXlhk5JRziRD+Wijk2B5aR
	 I1T841dYHvckg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20F03391AFCB;
	Tue, 10 Nov 2026 02:54:51 +0000 (UTC)
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
Subject: Re: [PATCH net] net: require a full socket in sock_confirm_neigh()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427928967.3612825.9649227455794286516.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:49 +0000
References: <20261104132900.1071940-1-edumazet@kernel.org>
In-Reply-To: <20261104132900.1071940-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, willemb@google.com, horms@kernel.org,
 netdev@vger.kernel.org, kylebot@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 14:29:00 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> An skb can retain dst_pending_confirm after its original output and
> socket owner have changed. For example, a raw MSG_CONFIRM packet can
> cross veth, have a TCP request socket assigned by TPROXY, and be bridged
> into gretap. Neighbor output for the outer packet then calls
> sock_confirm_neigh() with the request socket in skb->sk.
> 
> [...]

Here is the summary with links:
  - [net] net: require a full socket in sock_confirm_neigh()
    https://git.kernel.org/netdev/net/c/c78b47704934

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


