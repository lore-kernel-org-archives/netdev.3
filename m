Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64EA39B96A
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760241; cv=none; b=tob6IZUEtcTmaO/Z6m+BdO6WzMftn/vRuKKlxfyhaY1b2Q0lFzcigG7AAKxkPBflIkkgz2aibq9ohCdU58SaHKV7V4qMjPhmufPMN0oBVq18UzjAQUNN1ppGsAiuc9/ymKPmwyOyv23RXZPX0ph85DL52srTBU2j3DvJ6wJROrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760241; c=relaxed/simple;
	bh=LHyNe1UojQJsoTPGa0ofphWK2EooUfa50XPcphq4Lew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bIXaSGE/7rrJ6nygAQ3CNsgVTwZ7k3TIa7/jSrXPCBLJFSVOxGiXMd48aWQCO+J2r3txCdygZ5yp/RqTMpkeq/RlR0u/EeP/igCIgZQE9ZWMVQ8vgbZI8fMZxLKC1fOG8U+OGlki7BemCNVtSpFpHoYDEJdInCY7otM3YJhNsVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIA9kOi7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIA9kOi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1299C2BCB5;
	Tue, 21 Apr 2026 08:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776760241;
	bh=LHyNe1UojQJsoTPGa0ofphWK2EooUfa50XPcphq4Lew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QIA9kOi7HOO1DjlqYnPzC6qsIiQyFsxVv8+7I7UVZrT29CnqWQ3pd6vs3hGbHGBDf
	 SL4Bp81JK0EV0hJ2lNF758zSY89G9zCTIrPF5tUMNZvTjNVksOmWAbUQKkU9vIYFfO
	 4sfJDcRxd2+ECJryoT87bCiAEtfdz8DPvFwdyaixS7WwolW4gEveBOhiGSi0NmumzY
	 jWMxViaW1MKVVWLa8KgBAirarHWIVtNK+KZFzNxScCuPqcMrYL+uM94Sz25LLqqnPz
	 JeV12cVJaSEWZMN2T6wbD7B2wJIz8TxEasb1GyQg67oeYtxeJ4NOiYZD/F2uOniAIa
	 Wyuj3siSiwf3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0C03930035;
	Tue, 21 Apr 2026 08:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] slip: bound decode() reads against the compressed
 packet
 length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177676020555.2288942.17256366610270578250.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 08:30:05 +0000
References: <20260416100147.531855-5-bestswngs@gmail.com>
In-Reply-To: <20260416100147.531855-5-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 16 Apr 2026 18:01:51 +0800 you wrote:
> slhc_uncompress() parses a VJ-compressed TCP header by advancing a
> pointer through the packet via decode() and pull16(). Neither helper
> bounds-checks against isize, and decode() masks its return with
> & 0xffff so it can never return the -1 that callers test for -- those
> error paths are dead code.
> 
> A short compressed frame whose change byte requests optional fields
> lets decode() read past the end of the packet. The over-read bytes
> are folded into the cached cstate and reflected into subsequent
> reconstructed packets.
> 
> [...]

Here is the summary with links:
  - [net] slip: bound decode() reads against the compressed packet length
    https://git.kernel.org/netdev/net/c/4c1367a2d7aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


