Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1331B131
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786585264; cv=none; b=MWaOagVBRPLwm4EhEGSUam8qIT1LgZBgeKKKDI0dNogzpWvXYb+bsrOwoz6gmJF2Ub0HY8OY/kFoZKXOv3O7H4bF0KAw3cEvFk4tKIB1OMHCjEwTv9VgAuLDI4Pk2IiPUufLIJPQ1NoWcgpYELexUQSJO1LRL4rgy1MHPfUOIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786585264; c=relaxed/simple;
	bh=k/E3t/8eQRi/yfnidoZn+XFf2MZ028ixIpGDUMnvY3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FlTiCeeo++IYfPX+8sATasBNMFRf/p7bQV3FA9t7AYgwJhltEMEdecYyUsou/mU6gcZXvaHbLxEr7SUHT0KqiVJShChGJbOUBak7Dv7j/Gm0OQxxgojYBtCG+x70O8FiZqofzDvyoBuozz0YEpZ46hfqHUZQ0aK8TaFJ3uZEKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEg0eb66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEg0eb66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767C81F000E9;
	Thu, 13 Aug 2026 01:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786585262;
	bh=QjNhgYU2l9EFqvU8LUMVne/LCS5iGR0wbAlJ2O5+H9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NEg0eb66gT7FW9saXwCmQqd3YyHTWHrSa5PMejqSfTbFklj40pb0b2oU72jZZHahu
	 qO5zT9KE6LjRVZdxa/e7PxDKfwzHARoUGfAfk5cRjV8j2qx3ptstYvRwy4nH+rHdsB
	 tIMDqRuuW6tz1hHsnYBRbwmWeLZ4W00L7LSXJLz8iXJcocMKnGOu/7UgBm5UekthGs
	 LnJkSF1prUFltD7dSOsDSeg/2OtLKmC+W0SI/OcMui+tWXT8E2GHhWYCfyDhHQaYHM
	 nfHDWFrXyMIX3zSOJrlmDmD6Ppgs4SD2FZZ9qA+w+estaVowdFDrXLiobqGQsJ3ceV
	 +C9u3GbX5Xqpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C98380CED0;
	Thu, 13 Aug 2026 01:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] man/ip-ntable: fix app_probes typo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658521738.2182080.1409310892718266186.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 01:40:17 +0000
References: <20260812173856.1870300-1-ast@fiberby.net>
In-Reply-To: <20260812173856.1870300-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 12 Aug 2026 17:38:55 +0000 you wrote:
> "app_probs" should obviously have been "app_probes".
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  man/man8/ip-ntable.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2-next] man/ip-ntable: fix app_probes typo
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=da2ccdf862cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


