Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782206;
	b=bswj9y0IOQkY3CYQUGRhp10DKQTFAu9Q1RKs8gRF0yj2FU7zxws39oknfsZMXQra36/D
	 UL3vSx72ChFFVGedV9SB+nv1cH3HHX0jylZoFiVBKs/xxyLCKAo3hqvyAQOMyqFeA+2pu
	 Wl849avflI82uG/JXAhOMrZFutPgz8Cehi2hkuoFFqLNiFG9doYim0kICGRENN40fiJY8
	 3NMggfUR+mTr+1PHnHEI8+R+/u03afMuQXzpr1DPOj6nYu+6OkVEQeshGemTp4+BRSGB5
	 OjmWkTPdJOqMcie6NzJfzuovoZZbwVkVHDMbFYsGsCgu4dlB4VtPxEvUjXtiD2u54vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xKIT5AnHvOC2Lq1rnaaDNMEiSnphfcClcEUHVht/kc4=;
	b=NRmdDf9oKAYSAKC0fv/PYK+1m1uniHQjX+SHREfe1ZmDfiqjwZlsuLLJKAhu5siDhs0V
	 P5MnZ0AM7Go4ebd7Zd1BKDz5gcL4MPBMWx1ckj1V6ZsKf4JUpFR5Oflqpe/UxRb6MtVe4
	 5Ds6Pr30AqWnwiBk1eEY+RPS0bIkSqg2g8Xv/1GE8fh6GEPuv8v3FmrVK+ETNahb0Mua0
	 f1+6COdF/Vo5G7H5HThq5S5GG5fZe+MP2O/dR7Xci4uGOjvWPhc7m/LOTEFCRC9sUUZ2s
	 tnBbq6YRbps93fTaXU55Ev0aBaFgVsneLYw8zNymjN/Yn6JZJFj7d5FNm2FZkv56waA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyVB+fdu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA9606A32F;
	Wed,  4 Nov 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyVB+fdu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125611F00A02;
	Wed,  4 Nov 2026 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793782206;
	bh=xKIT5AnHvOC2Lq1rnaaDNMEiSnphfcClcEUHVht/kc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PyVB+fduDkjM0JbBw4bbd+hjQIl1IrL+3xsARvUt2XgCUx9uqVZhSAbLvZYvBp5Ho
	 ULIeC3p3GisANv3QFIoZ1cZdzlN8JFs5b7i5tE+TNkjC3WhnmTDVN2V4QfAYJJSK/3
	 PA55L3tx3C06yrOT0nJzWVbGqUK6O7EBVwp7/8KncsG57DRYj8vgy1FM4uaz65YAdk
	 KVZ+VoV3dFZdbN10fzW7kfLnGuh0fePQbkyAttwJTZIk9DsT5P2hpU3xxA7Tgk2BPO
	 pn7zk2GHWlrQSI+rh+BVeGi8mGujjKFmNv7nCl8YP6hN/218SCZhzJfgcgMQuYulrr
	 P84fjKrEmFaSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0347139D5FF1;
	Wed,  4 Nov 2026 08:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net v7] net: stop defer_count outliving the deferred-free
 list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179378220480.2190307.9887596616909426835.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 08:50:04 +0000
References: <20261029211101.2089535-1-jkain@nuro.ai>
In-Reply-To: <20261029211101.2089535-1-jkain@nuro.ai>
To: Joseph Kain <jkain@nuro.ai>
Cc: edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org,
 kuniyu@google.com, sdf.kernel@gmail.com, kerneljasonxing@gmail.com,
 willemb@google.com, almasrymina@google.com, mkarsten@uwaterloo.ca,
 jiayuan.chen@linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Thu, 29 Oct 2026 14:11:01 -0700 you wrote:
> After the llist conversion, rejected frees retain their counter
> increments. A producer racing the counter reset and list detach can
> also leave a count for an skb already drained. Deferred freeing can
> then remain disabled while the list is empty.
> 
> Undo rejected reservations and subtract only the number of skbs
> drained. Allow admission up to the configured limit. Retain the
> halfway notification and also notify when the reserved count reaches
> the limit, covering reservations published after an earlier purge.
> 
> [...]

Here is the summary with links:
  - [net,v7] net: stop defer_count outliving the deferred-free list
    https://git.kernel.org/netdev/net/c/241dec6f9ab7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


