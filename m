Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACF27FD6D
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774819821; cv=none; b=EbjEh+NOMHmOEpz01E5/zVhtONBdwm/o4P/U7hGGCr1L0HajGdPyEv6ici/wb1SRnRzGDx8hqtH5Eik34x6qeNiamRC8S+bCX3qCnEDQ3TO3nl8nnO4bfniS/TkO1o75h3SLEQfFn/wR/GzN8k9pXdplOQzqVcC7fG61Q8+xV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774819821; c=relaxed/simple;
	bh=dT4RSInZIwtU5J3JPKDfHXxdBaPFiyi61n/u9jP9OUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XXuQqE60pj9/EADQ4+efSwIpj9szHPMCdCOMV1+MXQMHiqO9lfcsnrQjaBQbeaE+RJMFQKunfzJNFbCwab0cZSlPLdKEk7jS6M/OzektlO9gopqi5qGSzzBJ4TgcwJ/tuMU/I7Ap3ADy5T1y6TGvvRrA05NlTWI78GBO+4MgFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnGXHvHy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnGXHvHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3CEC116C6;
	Sun, 29 Mar 2026 21:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774819820;
	bh=dT4RSInZIwtU5J3JPKDfHXxdBaPFiyi61n/u9jP9OUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rnGXHvHyfdSMSf5XEHBkiT5fa60BTyY0HnEakPLPy9HOHQwTjXIuDQ6DAJznQ4iPh
	 4XUop4odcE//Os+yoiIdlQPrOchqaCgjzO4+h6tNtxZjomSGc805uGp3oAlq1NPL23
	 iVaSdk4E1GkqiehI3E8Jl9C5U61ce0AFt8osC6j6Sv4ngDSkj4BEwJZlKfsh3lMAwh
	 OH1hfl84INXaw7gJdsPbR7cUdt08aBzi3/1OiO776LWya9KuiC4fiRW0UMTxnIvjkW
	 BoIg11hIsoIVe8SgR9AZaLVcql8IvY/VB1faiEcsVkKyxygUZESJ6Skh2ZsIViEggG
	 oXR/XPJaJnQmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE463930012;
	Sun, 29 Mar 2026 21:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wan/fsl_ucc_hdlc: cleanup ucc_hdlc_poll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177481980529.469895.8262496906167852994.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 21:30:05 +0000
References: <20260326100232.904289-1-tomas.alvarez-vanoli@hitachienergy.com>
In-Reply-To: <20260326100232.904289-1-tomas.alvarez-vanoli@hitachienergy.com>
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, qiang.zhao@nxp.com,
 andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 11:02:32 +0100 you wrote:
> Immediately after setting to 0 we are adding to it, and subtracting 0
> from budget. Replace with just assignment and no subtraction.
> 
> Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
> ---
>  drivers/net/wan/fsl_ucc_hdlc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - net: wan/fsl_ucc_hdlc: cleanup ucc_hdlc_poll
    https://git.kernel.org/netdev/net-next/c/57ec1622b62a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


