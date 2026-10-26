Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057411;
	b=yKwzp+eE3FSjsLmrGIyNM77uE369xkHPyl9NsRtCYCJkq0k9GvMnEVGZ93f1uXnZgvrD
	 nyC18G/8RxKa27dvQS83VkyQl0rx7DpSINODVGUqA6jvqT8kH95pg3Waje+6C23NpM9Ml
	 vNroMsKodTaHh45i1ueMKEfAgGnFUChUAvhkOIFn4zwH7L+m7efHU4pOk4uxKdHf6dAlk
	 YVKfWTaNy5bHbRfuA3mUugRKUX1exb9eZK/seCQQWKRyddaMBhzkf5dCMwPhcCJjltMww
	 Y2ZptZnhzwJuiIAGkMeCV8/xw5MdcdriYoBs7ZNR5gfCB36TfjzQftdazyaOn69quOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ELd/ELzNJjz0bIw2EWEPjJxgCZOcs5IP0CKCkXYBlCc=;
	b=Ectkz5mopcnXQyJmW1PkflAhyGHNXB+RP3wkkAdEf3tl62fdZCOkOfy0zoyMEQIV9CD7
	 m01wk+oQMCghje598pojx25zrNZIY9jsf92/qmkF2cU2QI7Z2B9GlRd1oYkoRpSLvB7ZE
	 wdcHUwUvirT/Er55JWKMfhxttJJDvgapzjG3DAWgVzk6UjOYJCY9T7b+eQqSz/gJhR/3c
	 DMvTr4J/buQSB1W88h9VZfHFwxIt+wJc3S1XpY2KkifRsNDBhPG5FlbXinxcEZvqa0ffO
	 ynJJB47s4LVTzLtXGbaHPl9YZfQ01xs/R2/Mpjky3rdO/kygQLk1NN8pNRhVJgYGXKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHnI3wrf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E2606A324
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHnI3wrf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AAD1F031E5;
	Mon, 26 Oct 2026 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057410;
	bh=ELd/ELzNJjz0bIw2EWEPjJxgCZOcs5IP0CKCkXYBlCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fHnI3wrfFBCOOs7pkQIUr7Ry7W7zwtMPpkWLXEygyCrix9Wc0SZ1P5yy4WzhqBref
	 kTGghX2ZJFVclZuKx1tlA9aYQNlQaw1lsJXuK8+X7msa7/U9n/LCizI1YYBQDvbscn
	 wYD4wh0EJEvbE5wvN5wLkUj+3ZIo52uitODCTDfuksBAgMAjVocfYL5BN5HfcL0rHC
	 WZx4Lara40/OVtiCV3JyvNWeuDlThZEdkOKMMpapoh3JbJxmyifeftlUJGXitQgi2i
	 t+AusSRPOQTv4/mPDGNjVXzfpu86Lsaj/NQUGm9wnki/GS/+Bw2290tdQXqxkxW7Ph
	 cVcahWm5fGDnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5A23AA80F0;
	Mon, 26 Oct 2026 23:30:10 +0000 (UTC)
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
Subject: Re: [PATCH net] net: harden qdisc_pkt_len_segs_init() against
 malicious
 GSO packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305740928.3456332.2890882737226798290.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 23:30:09 +0000
References: <20261022155436.117507-1-edumazet@kernel.org>
In-Reply-To: <20261022155436.117507-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 shawnq1@163.com, jhs@mojatatu.com, mst@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Oct 2026 17:54:36 +0200 you wrote:
> An SKB_GSO_DODGY packet can carry untrusted gso_size and headers.
> 
> For instance, gso_size=1 and hdr_len=65532 for a 524275-byte frame
> makes qdisc_pkt_len_segs_init() compute an accounted length of
> about 4,294,574,091 bytes (after gso_segs silently wrapped in a u16).
> 
> With DRR quantum 256, the dequeue path then needs ~16.8 million
> deficit refills before it can dequeue the skb, keeping the CPU in
> the qdisc path long enough to trigger the soft-lockup watchdog.
> 
> [...]

Here is the summary with links:
  - [net] net: harden qdisc_pkt_len_segs_init() against malicious GSO packets
    https://git.kernel.org/netdev/net/c/c6648c9f3b51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


