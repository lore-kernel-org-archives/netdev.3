Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB08625;
	Thu, 24 Sep 2026 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211080; cv=none; b=SXSsOO8BKQA3TOR81UWlUc3C0bAWppImgCw9HtXMuiNVm0SLx5KFvhjtUR+7wiSa9HpA6GsRiOfcKA73CL/zY+ibZcPuPbhyXzvV1uClhKh/R8oy/Ox6KKj/J8sQM69V2XmcCQqhTBVtwrXOh6pkILWSP497jn6/85GTb2MV63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211080; c=relaxed/simple;
	bh=thh8YnF5dnioS0hgc7mD1Zx+c5GgWCPSNz6um9O4ROM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SrlJMw63nZMDXhGk3izyINM1S/wvSUYB/TM9L6NSoLLHoKVuj5syoxPAxOCszMkyMy8xSKUbCZU1zZ9zl8kDxfmvrbXIdx1ZqlzGgVD6nggt+x1Wo80fRTu8KERTPzluGRiVyojzxHHinLcKrKov2O6hyFHmSnq/LiC4O7jLcDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA0E6mxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA0E6mxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA2C1F000FF;
	Thu, 24 Sep 2026 00:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790211079;
	bh=J2k6ofrEG93zYF/58l1TzkQWce+SVpNKYWqAbK4Dgq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hA0E6mxeIpzwbWbiKlkqntJtOHOOV1bF3H9jv2CU+jAIFJBFPLgGctNBo7ygIgkP3
	 7wWl0ObwzH28oZWf1/Fo/BnFvFEWUTtbBBhZB3EfzTAAkEw2jeApJk2TCXNRW3LDVn
	 +T8cMhQy/HvKnndLh4GP6iXTfEU84lo5sEZpQqvbFnUuqIFOC0VCCbBNMF+4T78qTB
	 VaCV8wkmtDF4BMzbpW6qpQNxy62WCu7G0d02ZkTzfAh2dwU9fLB42P7CVkPcgwQnbe
	 STqpOrpua9hAUwRnh05+sfty5mvRm1QXmYuLF1rMZu+dP0U6Z5pHSfEPjMzYM9EtOq
	 u1ppfpLfYmEHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEE9B39E9607;
	Thu, 24 Sep 2026 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] octeontx2-af: remove duplicate SCTP port
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021100863.1255052.2113938031683666920.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 00:50:08 +0000
References: <20260920122803.6277-1-sinha.aryan03@gmail.com>
In-Reply-To: <20260920122803.6277-1-sinha.aryan03@gmail.com>
To: Aryan Sinha <sinha.aryan03@gmail.com>
Cc: rkannoth@marvell.com, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 17:58:02 +0530 you wrote:
> proto_flags ORs BIT_ULL(NPC_SPORT_SCTP) and BIT_ULL(NPC_DPORT_SCTP)
> twice. The second pair is redundant and does not change the mask.
> 
> Drop it.
> 
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
> Reviewed-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2-af: remove duplicate SCTP port flags
    https://git.kernel.org/netdev/net-next/c/6f5021d32914

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


