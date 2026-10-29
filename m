Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271607;
	b=BpFHybAXwu5fiHcq1xeVDKEH10xgQ4l1RwN+vrc1v7c4sCHPzmJg91yYoE8t2aBJbBOh
	 OV/ARtg3qHQ6ALDBO3HqLwNXkdKZzTujRru2rdnd7iECrIIfVbyue8WtvKTXmBgxMBqjR
	 Ao/eEZ5g+TxywvN6nkBi6q3gZ0rno7XinQcyREAfON5bcjCptgzk+G7dSLixq2YrHco2x
	 HR0uAJ6dAgjzuZ9uqs+531LcmSY0SM/tp+nVS5sKxITXbGxNcqxaw2plL66K7Wdwel76U
	 9elzZUSBuSOr8NZpomuntyWOpZ2vsdch9gT00ah8JquAe4reasQq1BJ01wtgjCUjjpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ll9zN0Wy1PEA6OGnDGFZM6iVLnvbuI/K0NUCUF8GsKE=;
	b=cpQiB+Qsg9TKDJZhob5SnxWuoiPTprNWSeABVdiTd8duVVlj0/3Udwu+hOxmNMFZRLzs
	 oEn6s+G9SNVQhOnpA5WRvUeyhByqdmdFC5E8LzORSuNXuzbO0AlBRBh9VNHIKNKeg5rnR
	 F01jAKJXpF+oEEqZfMpZubHWOrpornok/pnWLTroZZdRbWKPnGq9Sw7kCbBbQPUX5KL4R
	 8qT7ajqEoLQDFsCkxcA9dbudIDtO3pP+3VSZ/1D7BCEad0LRNzrHE123YALv7lNkTpfAi
	 lLuqh1pYN66gj+FUabIlYCg1SJ+W3jJu+MIjTWeh67Gs2PmZ+I/5yT2AMCBvKdolKng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCRhEWfI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB654606A31C;
	Thu, 29 Oct 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCRhEWfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5923E1F01825;
	Thu, 29 Oct 2026 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793271606;
	bh=ll9zN0Wy1PEA6OGnDGFZM6iVLnvbuI/K0NUCUF8GsKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TCRhEWfIXRkxK4wiHcoOAI4lL4q3+G/xlM+Hm6Aj81pJz+qGzemcJ8+4maym+Ucro
	 2HVh8oFLbYvJE6fAkPjUGQy6E9t3sfgyPIOWlC1a9jy0LHBQxvdncKNRjBlbHi8RQr
	 r0d/A/gXeQkeccfF51/DjTiLGCw/PnKIWf+PjZb4G7+ebFo+RasuGOmk39dlhvSfiz
	 rZw6lRGkpZ0QIVUJYEFR2R5rhvi0S7UvatR/6aCna8HHmLQ+zP+/+gl07Sa6tTBMll
	 HO+SobBl0da6qRuDzpRXgnKrrAFTGGOtmWpR4W0DfGbft0kZm9PyD1kqCC9RO6jV/l
	 e+u3oupeVLP/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 445073ABD290;
	Thu, 29 Oct 2026 11:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3] octeontx2-pf: fix skb use-after-free with ipsec
 crypto offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179327160481.1758306.11637453865545839129.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 11:00:04 +0000
References: <20261027-nb-otx2-xfrm-unshare-net-v3-1-31dc9d79d11d@tipi-net.de>
In-Reply-To: <20261027-nb-otx2-xfrm-unshare-net-v3-1-31dc9d79d11d@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Oct 2026 19:44:09 +0100 you wrote:
> otx2_dma_map_skb_frag() calls skb_unclone_full() on its own copy of the
> skb pointer. For a cloned skb, for example with tcpdump running on the
> interface, this frees the skb and the new copy is lost on return. The
> transmit path then uses the freed skb and the copy leaks.
> 
> Make the skb writable in place in otx2_sq_append_skb() instead, so the
> pointer stays valid. Also do this for nonlinear skbs, as the hardware
> writes the encrypted data back into the frags, which may be shared,
> for example with the TCP retransmit queue.
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-pf: fix skb use-after-free with ipsec crypto offload
    https://git.kernel.org/netdev/net/c/829a09df899d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


