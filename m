Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDC321F2D;
	Thu,  1 Oct 2026 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853011; cv=none; b=X33tFxgiDkMU7hk/aOPQDSc7xda+XZ2vtR+FkEqzleiTdck8IxdPk6jUuyUfEayX2CQYbXKwjJkRsDYIg1P+zomkiweM+j8hrPKSVDKjEzTOdU5jRxz7dmIegBSv3rC5+OrJt/KRVNaFeyAtbMLTNAGIINe+89xdLBxvDsgHj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853011; c=relaxed/simple;
	bh=tRviDXIXLrTUx1JrNnHmdsgqg+5mpvk5JSI+NbX0joA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e5TboRYIt48LZI9Dwz8rgHioujOHIGVFrTqRtE7zJKBGqACAR4dCtLhgpJgH/8ailV1Kf7wGvhabWFn/INBXhA254L3UH/TO5x+9DBF808WIsNc5aLG0ZAT8t179Ak174BQrbJQmAxnoHnKVZETV4uaTgszU89dQRJjhNd0gEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMlq/PFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMlq/PFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822371F008A1;
	Thu,  1 Oct 2026 11:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790853009;
	bh=oa5yRYN9mSmiQ7rTcCXnTO6oKuuovkgW1gB0cUlPkTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mMlq/PFJkZvV+9cLuCSC2sW6TXA383ykBxkd0zuln7UqbpWf0GcKmcwi8d97RBg1I
	 TYVMCk9a1UhKehUlTDl/BMLkKLFYhfPZ2hx3SoloAdt50UIIXA5rkz/kkDkyUUqQg5
	 Ruj+PW6cBd5TryH5WoZSTklbu+C2zM9BLxSjKanH0R9L9WJsVYd3NtCELRob6LIuH+
	 R1oAcNsxfn2lp3gF2eMUJNdIbboqWXraLs31YcXNvmMohPwhYdJxpU1yYVWxeRZ7LT
	 8brCy5Kn3G68me5b+NGIA1IEOId9O+vG84IkgqOaeqBIuQPeQ5wMI2pSjw32fRt9k+
	 PnZ1SV7JeJVLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773C4380DBE7;
	Thu,  1 Oct 2026 11:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] seg6: fix HMAC validation when an extension header
 precedes the SRH
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179085300802.2398446.15616903843464042214.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 11:10:08 +0000
References: 
 <20260926-b4-seg6-hmac-transport-header-v2-1-8087b76f6375@gmail.com>
In-Reply-To: 
 <20260926-b4-seg6-hmac-transport-header-v2-1-8087b76f6375@gmail.com>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, david.lebrun@uclouvain.be, amsalam20@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 26 Sep 2026 20:19:27 +0900 you wrote:
> seg6_hmac_validate_skb() derived the SRH from skb_transport_header().
> That only holds while the two coincide, which is not true on the
> seg6_local input path.
> 
> ip6_rcv_core() leaves the transport header just past the IPv6 header.
> A Hop-by-Hop options header is consumed before the route lookup and
> advances it, but a Destination Options header is not: the seg6_local
> lwtunnel is entered through an input redirect from the route lookup,
> which bypasses the extension header handlers. The transport header
> then still points at the Destination Options header while
> seg6_get_srh() has located the real SRH further down the chain.
> 
> [...]

Here is the summary with links:
  - [net,v2] seg6: fix HMAC validation when an extension header precedes the SRH
    https://git.kernel.org/netdev/net-next/c/f9cb4d296d81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


