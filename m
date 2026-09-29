Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE03AE6FC
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677218; cv=none; b=dbKS5NDfOopfFfRu4i+fWmvyQVmeAHZXSQebKUt+LzllUFJYlxRvbxZCYbljanti9qCW4d53ljvliOXLzufnIry2TlFjO7xZq6Pjy+vw3Fgliyzgg5Bf58X7POBcg7wIbe1QjyqetwkqOt8bLRplOm4OVmWd0odejFQ6aPhLDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677218; c=relaxed/simple;
	bh=hD5LUt6njxwMB38/hWkelFy4YaxUugtHJB1D3rB0KKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BMiEH9m7Vn1yqNqXb1B4F+dTxrQNvcxOfkxOTe2j8WklUEWaieNqw6quERasZ9CygkaIpAaLDUta0J3A9nYCdamAT4YMfYT7+V7M4gBdFL/V9CH7bqjBS+DvRs9W+Ni7L7YnLXCtcnEdnpsLMWOW15lgDND4u8Z1fZ+0XdFFwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUwDYxn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUwDYxn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCAF1F000FF;
	Tue, 29 Sep 2026 10:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790677212;
	bh=lkCexcVYx3hFBwNsHTthvU0NREeHN37g7RTPF9ik6vA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NUwDYxn4FJMDKdozeESWsfsmr1ZzQSvzs9jN31Di7ERap8QhwJu7F4rSEaSR8IrLR
	 nLvsuKX+qUBDi06qIskH3/r++3w7Kdx9oDett4XFToTHXIVhypAo7OjO5AnXD1qC5X
	 5T7Eo3UF0UDZetJ3g1p9+4RKidNyrPM1IYJqM5X0e3gptWG9iu9zfmKvGCLl7EKm4m
	 Yto0q/0RBildKD9yAa8b6i1z6lJRzyQuIkQ3SY1qpBXD3vw+Ah0n0EMjIddNqLtRuU
	 nfJG+VW8O3tK3He+rqWcA/cV3WV+dZSbvZ8e4JCPW1cE52lldWFTurkuT7lvG3sAKa
	 bzxM1bPe2NB6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F151E39263A9;
	Tue, 29 Sep 2026 10:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] gve: DQO: accept TSO packets with non-protocol
 gso_type bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179067721058.405469.9511514569119396750.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 10:20:10 +0000
References: <20260925115237.56465-1-hannu@varjosoft.com>
In-Reply-To: <20260925115237.56465-1-hannu@varjosoft.com>
To: Hannu Varjoranta <hannu@varjosoft.com>
Cc: joshwash@google.com, hramamurthy@google.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, nktgrg@google.com, willemb@google.com,
 pkaligineedi@google.com, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 25 Sep 2026 14:52:37 +0300 you wrote:
> Since commit 014c607f86ab ("gve: add support for UDP GSO for DQO
> format"), gve_prep_tso() matches shinfo->gso_type exactly. gso_type is
> a bitmask, though: SKB_GSO_DODGY is set on every GSO packet that comes
> from tun/tap, packet sockets or other untrusted sources, and
> SKB_GSO_TCP_ECN and SKB_GSO_TCP_FIXEDID can be set as well. Such packets
> hit the default case, gve_tx_add_skb_dqo() fails and gve_try_tx_skb()
> drops them, counting them in tx_dropped.
> 
> [...]

Here is the summary with links:
  - [net,v2] gve: DQO: accept TSO packets with non-protocol gso_type bits
    https://git.kernel.org/netdev/net/c/f8932b2c0c9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


