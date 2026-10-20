Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529407;
	b=0ZwqzuwVdVh0mP2FpV0YKlqRZyzbIGVjBJks3SdGmn/6i7vvewFZHkQGwU9jyXL9Q03b
	 f6FiBphVxTlrWy5PIqACR97qjz36cYv/S3L9EwPT2f9c2Lwua5nePt2grNcz7enkL9RxN
	 fcrpZ4iNQm0slQxB9O0BKjmmaasZ0OWAo5G6wTI7mtyzM9kG6Vur9T4mYHwtb69a9M+rI
	 mSd4M9Bf8yRKVxtvJotoLpXQITXFOqZQae8FXnrFutqI4RpW750IlWpkuKVuvo5cBesAJ
	 zrbXIEawMofd8lVaoar6pHQrO2yNRSwR51Od/2z/Iz/Pc54VqomWOMDHWGTej3+kRMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=HOr2sSGtDvuyubDx7gjU8mlKWmyyBpjlV++4gXMLlq0=;
	b=bCr30r3MnpAjaHof0vCJUdfVPJC/z0Oa+nq9lqtCwV+O/+mm5GQeFaebSJWzmTHkcmTo
	 0933e84jO0jHeO91zXKo2Wwkp94mqOMYmOdqzfsPOR0VQkLWZcQOj305afe6coLkwpakB
	 /ErVS2QCH02nYHMTqZCaX6cMMi6WtfmHJOTnglIZGvWud7OjEd+KhPSPHFBaIvhWzXAPJ
	 6VQOA+ZxCIRj8Dosqn5D9VyPqr8d7eNpKW9LY1W8uLRjEAzFDWcF88i+w8/5qh0pKMVXP
	 bObs6j1XSrTke7TCkaYfrjVR7/QK+k/Y+7xkaMl5qyhwcpUU++4JdjetP+6k83Kw3Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IX+0D+f/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D3606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IX+0D+f/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0874A1F000C9;
	Tue, 20 Oct 2026 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792529407;
	bh=HOr2sSGtDvuyubDx7gjU8mlKWmyyBpjlV++4gXMLlq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IX+0D+f/3ZqjQUJr92W71AVTzLdGNs+Y/FY1pLICv/I4eYZDffZqOkZGumZNZQE/1
	 MVG/pschgXTc04No6m3NjJ9eN48nBWb6esfTDPiexhBoTEYqMux7gfokYFX+PraqjB
	 ZLaJb9az/0EMD+C2vAw4WrZFocu3OkXomq17oZtcB/1SVgs0pFVVNySWQcdGMv0xpF
	 3qZzGL12naBtzHR/Zk60fp510ri2pTnc0dSXMg2J3ZP8VHTBpMdEQgw1Kks9dlmg/B
	 H+WnY4l91wQiIuCeSM3j94RDPESX58VtJ68/4i54k+Hb+nEVFje8mlfi+JRsZ4a14/
	 rqZ8+1oPj3nmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F180C3809A09;
	Tue, 20 Oct 2026 20:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net] ipv6: account route exceptions to the netns of their
 dst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252940578.202014.14262102316114186364.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:50:05 +0000
References: <20261016091556.2750902-1-edumazet@kernel.org>
In-Reply-To: <20261016091556.2750902-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 odys.yuan@gmail.com, kuniyu@google.com, dsahern@kernel.org,
 idosch@nvidia.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 11:15:56 +0200 you wrote:
> rt6_insert_exception() and rt6_remove_exception() update
> rt6_stats->fib_rt_cache of dev_net(rt6i->dst.dev), but the device of an
> exception dst can move to another netns while the exception is still in
> its bucket.
> 
> This happens when the bucket is flushed from an RCU callback, for
> instance from nexthop_free_rcu() for the nh_info of a replaced nexthop,
> whose exceptions still point to live routes. If the device moves to
> another netns before that callback runs, the decrement hits the other
> netns, whose u32 counter underflows in /proc/net/rt6_stats, while the
> counter of the original netns never goes back down.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: account route exceptions to the netns of their dst
    https://git.kernel.org/netdev/net/c/8ff017b891e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


