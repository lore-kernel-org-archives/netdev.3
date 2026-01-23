Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452B3EBF1B
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194209; cv=none; b=ZXmO8dXXJB24hRTbd2dbBgp4nOvp7c/cEnCJ4luFp4b9mjDX3cWd/gO79dneJ2EfV7WNxNFVJyvcQhL1v8Q8Qkiw89mkShnLPJINIK7b/sagyV5qwfva0BtbZyt4+dC+oBuAqJBMbk6hSyhFPLO/ilVuHRGjbNIldKHdFFoMj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194209; c=relaxed/simple;
	bh=wtaytliH2BFA0wxYGMWIiRLYtsgX9fWKQ77gYHwn3A4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S4HffbkXnCCLNLT/y4LnRhhMN8mekdPVLe9JgOdk3UmYJ4jigOoT4i4KkCa6p5Y2ZC2Ybl39k8XDshSI43wsGElF83CdqI/lPAA/mO8WKeb5FF+sbQ2ce6IH2Vy378t9E3D97fwv+X+wHG7I0RTD/i+JxZomEbAxbe+Yg99tn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrN/IWco; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrN/IWco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08D3C4CEF1;
	Fri, 23 Jan 2026 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194209;
	bh=wtaytliH2BFA0wxYGMWIiRLYtsgX9fWKQ77gYHwn3A4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WrN/IWco+JKgAcM2XI8Dgy8O9C3eUTPZdSBpocrPvlCXzHUvvyp5J6pV4xa4b92uM
	 q5BiZv1f5Aj8QNiRu9v6lJrzV05cDS5rewD4o++LGbKAtEBRICt9XMKO/kcPkadK1x
	 rYo3408By2SeQPrUxxt3u3b3fC4VeYgkpSQvAEYdma4qYhz08hsfkZZVqrcMj+R8pm
	 ZPgJtQimUpFZ/shkybaUO+Qk6dEsjA3xuoLx+bsduNhjPYbubpBEN6UMlYJi5BPI6a
	 XXDHDCjqZhhduKj3FBv7zvfHLkZrnslueXazApqkrtN36qbw3VAwux2ZIs92Pj/ECN
	 n/PS5AhEEZTlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 117E03808200;
	Fri, 23 Jan 2026 18:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Update be2net maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176919420485.2677151.1051948052498284021.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 18:50:04 +0000
References: <20260122205020.26743-1-ajit.khaparde@broadcom.com>
In-Reply-To: <20260122205020.26743-1-ajit.khaparde@broadcom.com>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 12:50:20 -0800 you wrote:
> Remove Somnath Kotur from maintainers for be2net driver.
> 
> Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - MAINTAINERS: Update be2net maintainers
    https://git.kernel.org/netdev/net/c/deb5c201aa4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


