Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522818;
	b=rKYffXzEOBghWWJUTedFGuix5xiQXftoQFcXI3wEpCAWpn3o+qZrIAmD0XjjSkXzXj1Q
	 /K3fRvSWmLpMlXW76b4lYXRZm9+Zz6qIyJP4OyzwbC3g68nrjxlXSPfGTF1IxpuwuVvqn
	 n3jey8R7MacwJkkl+Kpat5jts0k1wI1cWz89+pz5ZaQTf/g9MJEZW/qq3dxy4V9RDieRW
	 UuvbxDqqwQiJdzUMav26r/yOTjpw1NY7jdqxR0L9U4fISkF0kF6loth2AQQy/ac9sBg4T
	 qJQNbOl1G7Zr1GsBcIiiuy8TZIFkttHHbj4h1uza9AGmy6CvAie9+39UyhPBqoDgHIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522818;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xo2KMPb3IFavFSX9QXtVYhow5+1rmFGu5VXifm+elYw=;
	b=Jvec6la1q2WRKVe8euJjZFNZzPt9buihCUvNRs9zqDo5ejWfOk1NZjgw5zpJ4z7OwCEq
	 pf79opTFsvFmMFaEPaFXCiA3YCPqYZT77/+HRcKtAZb8QyLoD8M8nbSHOajDtljStt0DP
	 vuChGiEu+r0IKSRfl3eCy4pH0gSkzssg+goawkkFyhcm5d0WAROx93Fi4d2A0RHdx/guK
	 84a5kLWkJ5BzW/x7OXFN0g+k3A8qZCywNeH7HdVBPi56D6S6QUjTVA//Z3lnw1Z9c3K0s
	 D76TKMIFR2EHOe/nNBogsg4f2VRkSPWBbu+s6d/xXotHPLzPoxybp+6+OtqP7OnTtdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iuhxml31;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DEE606A325;
	Tue, 20 Oct 2026 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iuhxml31
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE38C1F000CD;
	Tue, 20 Oct 2026 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522817;
	bh=xo2KMPb3IFavFSX9QXtVYhow5+1rmFGu5VXifm+elYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Iuhxml311x/1wuqNIkoEEgL7iFiSh1R9xj4aaeGndZTGlgdH95huaiMInmxG76hEn
	 xWNpWEkSVcYDRLoK5/1CoQKk3UJwg+KcbXD3Xu506okd0jfGBSfUv3iifw5HOLGFly
	 Yt5VM2cn1m6cASF2PpyMyJJeG+Y6e21qrQnwb3OsNfqphQ21W4ZkXFMyqImTLJQxMA
	 0F7vdTbhGPwhnJNckM6Qn58XMaEl4JdpLSYzi41C3TGRWFYiT1Hry6Uy3nKEI+WEkk
	 tsouCNT2na0MJIN5UdT1++Q8gbdp0SLF/bP/hFiBC9DfH5q6ZvZzKk/CNn3sLUiy1L
	 wjRUTsY5oV70w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44093808209;
	Tue, 20 Oct 2026 19:00:17 +0000 (UTC)
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
Subject: Re: [PATCH net] sfc: fix NULL pointer dereference in
 efx_tc_flower_replace_foreign()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252281628.159319.1996448666311280781.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:00:16 +0000
References: <20261014145800.726-1-rand.sec96@gmail.com>
In-Reply-To: <20261014145800.726-1-rand.sec96@gmail.com>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: ecree.xilinx@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, deeb.rand@confident.ru,
 lvc-project@linuxtesting.org, shda@confident.ru

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 17:58:00 +0300 you wrote:
> efx_tc_flower_replace_foreign() walks the rule's actions with an 'act'
> cursor. After a redirect action it adds the action set to the rule and
> sets the cursor to NULL:
> 
> 	list_add_tail(&act->list, &rule->acts.list);
> 	act = NULL;
> 	if (fa->id == FLOW_ACTION_REDIRECT)
> 		break; /* end of the line */
> 
> [...]

Here is the summary with links:
  - [net] sfc: fix NULL pointer dereference in efx_tc_flower_replace_foreign()
    https://git.kernel.org/netdev/net-next/c/b20b1db7e3f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


