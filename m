Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9B22A4E9
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337463; cv=none; b=maLOALZhgNUn8OnY8Rm3kUxDA4gsmMU3G/1rnm4G6HzkZIddexSd3ogJyn0vRw1qJFPNwSZaoBpf0k1OSjuGHcgRLFyy+dU825ZssDlY2LzQzxeer3rJM2bg5AgoO+QwDsq1fDkgMF/jn/BmQJKfUhW3cMBifzGPokoj2TLC4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337463; c=relaxed/simple;
	bh=VGh2L+COy3hGOTtTFrTSH55dIP8goJvnDbksuLcJVeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bdXfxF48Jwby51V/SSCiYQr5ve4eFRCOrI7HPE8pb2FvCXsJOi76e7Hc17ylHjnRhwdqIAodb2JMEcSkKVOR3KYc24rRR8QQnFSqJ9D9riVnonRVcm9y39dZtMI/6O1lpyGkZk26jnGDobQuFTZsEOMlH/ZAOluBmQjycP7sTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyXfe+J4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyXfe+J4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B84C2BCB7;
	Tue, 28 Apr 2026 00:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337462;
	bh=VGh2L+COy3hGOTtTFrTSH55dIP8goJvnDbksuLcJVeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gyXfe+J4lIazgN1Xp5kGiIFw4YwPi+6+vpIqrUT3CvdyTpbkMjw7GHgYzQ0hvrO6T
	 SQ1SCS7oG9FAW+948Mp0uc+f6HBNUat2HoJtaWLFK2ROW1Vh3C99xHmNzZm4uBsXjD
	 OPyr03wmve5YnUf3Ao0igIpCijsvi6ZGKweQNJpMTi+lkBYR/FCoZfIGxzim+Mkowb
	 d22EX2qGMBw+Y29lgS/jeXNFllg1bFW9/B4veG2zKWA16Q5yvB82Smm/PQmYwd7HAH
	 uHNWE4iBWX4aRDeo53P7uecv3Ohr1WrbKdW6MJJIIx262Jm5k9iPzvR0V4fe5pYcFc
	 IOR2OjOXUG63w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD3738119DB;
	Tue, 28 Apr 2026 00:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: fix BQL imbalance in TX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733741979.177472.4126211834690754531.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:50:19 +0000
References: <20260421-airoha-fix-bql-v1-1-f135afe4275b@kernel.org>
In-Reply-To: <20260421-airoha-fix-bql-v1-1-f135afe4275b@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkelam@marvell.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 08:35:11 +0200 you wrote:
> Fix a possible BQL imbalance in airoha_dev_xmit(), where inflight
> packets are accounted only for the AIROHA_NUM_TX_RING netdev TX
> queues. The queue index is computed as:
> 
>     qid = skb_get_queue_mapping(skb) % ARRAY_SIZE(qdma->q_tx)
>     txq = netdev_get_tx_queue(dev, qid);
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: fix BQL imbalance in TX path
    https://git.kernel.org/netdev/net/c/2d9f5a118205

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


