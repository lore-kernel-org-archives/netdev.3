Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549213;
	b=nD7LRjwEPVsyZLmXOlWdtldSz9gPtxlBDtVLHiDJ62h/nno7z1E4qVLE04FtAUArBPK8
	 Pgp3//DmDr06qMYuFOsQCmW3WR11Bvsuiq4z4OpdI5DgcgL1kkYcqj+YJofDTNRetxTzl
	 gpcUaUZzgj3eDKGGcK+FEiH6ZXBZ+EuFK9zHoH3j33SyBTPRZirEskp+LmBztwM8DL9HT
	 6IerEd5LZ0GFXiqFrEDp4qtZjPCIoBVM+axGtruFCIKDftU+ta8+VD4oPY7fdOoqQcMGT
	 ujsNYp4uUWy6a8qAv9nOZtn1QLkhS3jPr9Fcu6bSXGRqdHvpbL7nvsQ648aelAIEQ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549213;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xg9yaH8H8xLZd1UKEcsO65gQJWPuXeJQrjJyXmLGCL8=;
	b=wLbB1NqhgvOfJw47MxQrgln7Waiv2x3exejCnJeOuidTxsex5K/f3Hi4DjYHdfympRo8
	 HP+WAmPBnuFOoWmLhNTNoDcGH4UTANv1lDG8KcCwvurrCHyE3u1ND7QXlYNKzpbHb9NNP
	 aMrInei1nkzGJIbPvHyQfv6Vd0j/mMM9q2tYC1JgndrKjQf4dEwkokMiYo69x9ge+LHec
	 0IRN6kJ0IqTP3oheFkLNxBufuqCNQiqdJVM43inSuTGmYygSTkuhK+wE6PJYz3SwjkQuN
	 +o90UbAVUPnAL6gpZ1k3u93/uxS+sw6F+TeN+2HM/xX5JKi9o1nrtEsM3ZKC018MoFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkVu3xqk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4075606A33C;
	Wed, 21 Oct 2026 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkVu3xqk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810CC1F000CB;
	Wed, 21 Oct 2026 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792549212;
	bh=xg9yaH8H8xLZd1UKEcsO65gQJWPuXeJQrjJyXmLGCL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gkVu3xqkhp6Iz8zzZEX+CIklkpmCUsBhbetpvC/ak+vJaSOJG6riyVp8vKWUlbCIk
	 /oDetgEz9UUBJW/U9bSiYLn+OOny5L6ZcJeLUGdJ0p0bSOPUglKMrgyTe7sNoyEufH
	 1eo5x+1DOPJ0vWnGYCYx0UgDvtOP3aUGbxmYcXDqb0CzwsT82MDO2sJhX5O0KgWUM2
	 A5sCPz0Fx1xX/+sBGHZlBHmd8WYwhbIB9vowDBw6GgbUdY8m1KCE+GVvYnbWzu8+ej
	 Oe+diNKomtx1qPYZVDEHBQILI4xLIjILZVjE+c0mrAP/4ECyc2SuXlN01V++dsmETF
	 ASQv2m6/SnyRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773C13809A0D;
	Wed, 21 Oct 2026 02:20:12 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2 0/2] net: pse-pd: si3474: probe error path
 cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179254921103.330607.15303788784612434882.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 02:20:11 +0000
References: <20261020171134.852878-1-github@szelinsky.de>
In-Reply-To: <20261020171134.852878-1-github@szelinsky.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 piotr.kubik@adtran.com, saikrishnag@marvell.com, horms@kernel.org,
 kyle.swenson@est.tech, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 19:11:31 +0200 you wrote:
> Two small changes to the error paths in si3474 probe. They do not
> depend on the PSE fixes for net ("net: pse-pd: assorted lifetime and
> error-path fixes" v2) and apply to net-next as they are.
> 
>  1  The error message after a failed devm_add_action_or_reset() reads
>     the ancillary I2C client, which was just unregistered.
>  2  Use dev_err_probe() for a failed controller registration, as
>     pd692x0 and tps23881 do.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: pse-pd: si3474: fix use-after-free in ancillary client error path
    https://git.kernel.org/netdev/net-next/c/70c29b35fd87
  - [net-next,v2,2/2] net: pse-pd: si3474: use dev_err_probe() for controller registration
    https://git.kernel.org/netdev/net-next/c/569b57762694

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


