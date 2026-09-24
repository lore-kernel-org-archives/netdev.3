Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BC355055
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272880; cv=none; b=iSXEpdADkvAH3f8ifZdo4rNVM+gBTit1Swz54oiW1iLYMfZySPiBbuzIzvLO4XIE0lpzNd3cFbOiWIRWx0u2PPeeiHZ8Fid/xG3fq/q60XJ1recYBeJPWn60cAw8/FozgXCzlVQI/yg55msfsocKADRKl/QLqvroVaV5sydqcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272880; c=relaxed/simple;
	bh=zvsuoE4v2rfgJr2qiX+rDoO0Y5GckfmFQ5LLJ42D+CM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K0NDy64JhLNSwdqsda+4uO44TCgo15Fz6h98LEYZufKDgoRQDIup3EoR2VMW12cGh2zclxKCgBs1LieAihu+64Fka2rtvE6oZwDai1ak7fib8iuFOvT2G8AB+Tlae5uqBNjgsuLq0t566aHtJ9YbOW2HvYrb98YmMl3J/x3kaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq1SXG8x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq1SXG8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9331F000FF;
	Thu, 24 Sep 2026 18:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272878;
	bh=+SoME0A5wdeX16lZj6+W1v/gJQTb+yqwF4nh53Wfar8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Oq1SXG8xI0+2AhkxJWi5BoYnX+kNEK9BtVGreGYirGiUh3fawkXN9wpzu++ExFbw6
	 kJJ6+/SrMhSo21Nf8BOZhToWCK6BJ3k3C5OgRa5pn1HSCFe9xLFSDn5dKUN0X339Kw
	 d6E5M7ZcGMRPLkmiEUD181E5nPvGeO/bIkO54q2i+ONCiAoIuqzTnHN1ZklqxlpTb/
	 zEOmos7g/5gZq94pHz+sJXQCRAEvOWGIxGaqGEJ968UO+cfYvgf3To4udOY4eEoaKL
	 kTiWEg3kbUGI7i54biyqRJo7v3BB9cx6Of9aSxxX4ada2GGE9Vg3r3/A2xPIiXpVHd
	 U17S01Pit5XsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0FA13A566DD;
	Thu, 24 Sep 2026 18:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] gve: DQO: fix handling of out of range TSO MSS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027280738.1685480.3863257339813565809.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 18:00:07 +0000
References: <20260924004252.1196328-1-edumazet@google.com>
In-Reply-To: <20260924004252.1196328-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eddiephillips@google.com, nktgrg@google.com,
 hramamurthy@google.com, joshwash@google.com, willemb@google.com,
 edumazet@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 00:42:50 +0000 you wrote:
> The DQO TX path assumes that the MSS of a TSO packet is within the
> range supported by the device, [88, 9728].
> 
> This holds for locally generated traffic, but not for packets coming
> from a tap or from a packet socket: virtio_net_hdr_to_skb() takes
> gso_size from user space and only enforces a minimum, layer 2
> forwarding does not check the MTU of GSO packets, and
> gso_features_check() bounds skb->len and gso_segs but never gso_size.
> 
> [...]

Here is the summary with links:
  - [net,1/2] gve: fix TX drop when GSO MSS is too small for hw
    https://git.kernel.org/netdev/net/c/3b430ea62340
  - [net,2/2] gve: DQO: reject TSO packets with an out of range MSS
    https://git.kernel.org/netdev/net/c/296c83b5ccc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


