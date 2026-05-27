Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A35282F05
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845412; cv=none; b=Yd/2atGs+blmAxnYEXcSdbTTwhS2Y0LK1e6Kzx8WbxKKBBC6njjmSTSTroepp4EAmXYkR51XX4CWibcU/D+5mIWrXH+uN+o+bxvjLzF5RSXskqZ4B7QkU7r3jFTDKT5jlD84nsmxubbihOfgpEb7nfd8ZCvBmqb4rR2TmW4HbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845412; c=relaxed/simple;
	bh=vP7C3iIO5/7V7KmA0+/jvloki/rfYjQ5on120Ahskcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QqhL5pCTyLWnyr4d0dHEN3ytJVCkz9lyJQTwBledU8DxEZ0l4THW9cuNXLKldcWjDP6X9SAUPc0LRhVnOIsWijm9du9QKy6rQXNhV0bzt9QoNuTcjRlwzAntSkUqAd03/GagjCEkTgXOclmuJFxWb+uqVv7IQeIG+L3xBgXWnys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR/ZKIqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR/ZKIqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02831F000E9;
	Wed, 27 May 2026 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779845410;
	bh=RQlcrnqB+/73jKpFT+qgG9dofR+WPlo6NDazTcBpX/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JR/ZKIqSR1U2Dp3LVtqlVU++TxFdUR9zVAyxXzF4QW2V1rHjQeDIcAVefSHBibtH/
	 OmCn1xIx4yy9CHbjh+YC3isdcZwnh+KafHHdJAELaoBuJm0sAO4zcSL8Oa7aPnqH2P
	 q1Uhl2MyTOxnDa8m3wCWQmz3HbhsiFqndAGc+oRYedM4dtKmxcsPHmoKQRrnyQDA3V
	 YssoBY/GjQ1AHDAySsQa3aUWZ+BumCZ9jhtDZV5jhd85O3y4RB0Epfm3E7HByMCJle
	 fp08fRpc5dUp1hJxOhcwUZtOIw0tnP+SVlImB9HX3vg+UiA7g0+/cbjYzZwOuRcqtV
	 1EP98m1rcoV0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0F87380CEED;
	Wed, 27 May 2026 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tunnels: do not assume transport header in
 iptunnel_pmtud_check_icmp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984541639.4041297.15456776118551433178.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:30:16 +0000
References: <20260522115512.1519110-1-edumazet@google.com>
In-Reply-To: <20260522115512.1519110-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, melotti@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 11:55:12 +0000 you wrote:
> In some cases, iptunnel_pmtud_check_icmp() can be called while
> skb transport header is not set.
> 
> This triggers an out-of-bound access, because
> (typeof(skb->transport_header))~0U is 65535.
> 
> Access the icmp header based on IPv4 network header,
> after making sure icmp->type is present in skb linear part.
> 
> [...]

Here is the summary with links:
  - [net] tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()
    https://git.kernel.org/netdev/net/c/509323077ef7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


