Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178007;
	b=4km9ff3P9xqZVtjael9PpANtcMuv6N/9AyoItknFhZ4ZCkyEtam8wdV52sZS2g24zfjA
	 WjnHhU15djjuKcBrfOzt+Za94SWLClzZrf/PxeRTO8avlDTdooqYFW61ptYXgiBsXyFA2
	 cMKpT3O3i2sLJZ4mIPYh19PfPuJsCZH5i811ibiZiJ2NePD18FHgu66jLldPdhJTVSARe
	 nshmh7B61PNo7AqkLdHpQAhQ2dq6T7te9U4N4zwf6JPv/rxr4dzSfmfnb7Ao51lmhiDXQ
	 vcBOP6tyGmLZcOLqLTizCHrybNFmPFQSLy/VWJRKYFAMFejN8K07ZRHQZpxVpQrYySg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+1ahtmf8jmaZDIEYKrZgwgYWi6qTcrWehZnEqe+27/k=;
	b=XZzRUUjw6xmxURD99zLx4Bt6nBGeoGTtd94qJY8EUpHJKVhiKmbT9NyX/jp5vkge2XYF
	 jgEwI4a6JzN4bXx0neiHCveacn0U8j/+f0op3Foopwf/X2Lk9/JQrzqb8+gVGTxzQPoz6
	 xYoSjs0mbWXsyq1VNMGXRp6O98vekYdkM5ULfnHHzUptmejz6lNZd2Cx2bXyw/fGpHxP+
	 XauLjMG9PFZpILIMdcucjgg0e0NqoXjUJbDTLABh+1CN9ZuOoQozpOH75pKzQEq+ic9Y9
	 oVHJ/N7JanqSXIkOiPzzyuxWOpcvJ0JJUub3rZXLIvrSEtqEhZiLO1PDIsnBp4sQVqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oymvPZ39;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48EB606A31A;
	Wed, 28 Oct 2026 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oymvPZ39
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D941F01825;
	Wed, 28 Oct 2026 09:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793178006;
	bh=+1ahtmf8jmaZDIEYKrZgwgYWi6qTcrWehZnEqe+27/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oymvPZ39oxczXOo1blhDgMv33rzBIhAqTfW+g1b1++OsnfCFUTicXJFcIqo0lKQfG
	 jdpbkoyIrQg4U4p0nGUwY7FHdpqL7nY7nASOi/ZzTfNlQbVzcF2H5060sNpr2o41A3
	 XQxd6E181aoGn3GaWpMj7NOoaAvbpSXfW+xFsHYFePlVSkofeG04VCsYje9WZrbeAV
	 8UcEZwVgtvNY/pMPrcd6vcyqIx2gm+/tl72M6exEM7mVt9Ttmh9rD36EK2sYiGsKfe
	 4DGjp3ffarnm12BUiH8S+yzt4KJff5j4iGGpxhRopvfRE8L+llGOURJdXVsoN5dQUF
	 rdxZjL/q8xFuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 443FE3AA9F7B;
	Wed, 28 Oct 2026 09:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net] octeontx2-af: fix inner LC ltype match for RSS
 flowkey
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179317800484.591477.12027096474618287869.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 09:00:04 +0000
References: <20261023071905.2922825-1-kmahammadraf@marvell.com>
In-Reply-To: <20261023071905.2922825-1-kmahammadraf@marvell.com>
To: kmahammadraf <kmahammadraf@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 kirankumark@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri, 23 Oct 2026 07:19:05 +0000 you wrote:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> Inner LC ltypes differ from outer LC ltypes, but RSS flowkey programming
> was using outer LC IP/IP6 ltype masks for inner IP keys.
> 
> For inner IPv4/IPv6, match only the base IP ltype and do not include
> extension-header matches. Keep existing outer LC masks unchanged.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: fix inner LC ltype match for RSS flowkey
    https://git.kernel.org/netdev/net/c/22dd6bb2bafd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


