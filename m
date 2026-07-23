Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086947425F;
	Thu, 23 Jul 2026 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830261; cv=none; b=PTo1cNRNHhFU4yTKo0Rf9EH56nfqihNvbEefy/t4FWfZ1xvcHA7RgmbGXyVNeFbKyyM/0uS4NcxaRA5NzusLgSb7jBuesFIAOj6a13HKum3mb28h7a4F/t86sYQbVv4wFn4ZME2eaHIAtCKB6CEpWWQswrmfX36ucX4T182crFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830261; c=relaxed/simple;
	bh=F4yaYKQjbx3/BpbzYLR1QHpuUyPVUd/ccX27+Rw0Q0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y0rIA2R/uWxbMyoEPsHywdjmLfrt7ugnLRofPieaTO5HwBMrJU3pOz3bvTeQNyBD1Ou1g2fkx0SH4mp2Kej4U+z+lP/CUwmNQO9Mzzc4f90q2a6p6lrujnqaZdtvkmPZo/Vhvbd3iowGDs+3rfwiLK6JBDFEXDBKi2HHwqJJ8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGETpyI4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGETpyI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760081F000E9;
	Thu, 23 Jul 2026 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784830260;
	bh=lXbM6sL/pAwlnNUhcfnEhcXecyL4Y2P/MvL9uG5wms4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VGETpyI40ecix3jcelpEUG/P1JfDGSjtRN3plkmRmb3rV+ZbfhEYBTdBIY53eKGrs
	 aGf1NygCNltwfIWxaaY7jozF3jJFhiFRVKr5ZYsl46jtE1z+n0F36jIOsgcFE4ruaP
	 CReudE6BSZu4TCvjnt0MxV0gpHiXOtPcio1ScumMoK04ZaQQ5RISXqsBZgKaabLd1G
	 duH4WiDddbJnFvpI3VapUFaI/nTHifnNA0oUfV3fC1F2BzOfyXpaLLMySmYMH49eua
	 rkdhNaLmSOoirCRWgMuNeI29te2BrvKn8UeRVFO/0+wE95H0weipCUrbOHlEtzCWAA
	 qe2AP4xIKA0ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B8439244D2;
	Thu, 23 Jul 2026 18:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: microchip: Fix log typo in error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178483022639.2811828.5219640225193484297.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 18:10:26 +0000
References: <20260722174853.2316333-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20260722174853.2316333-1-niklas.soderlund+renesas@ragnatech.se>
To: =?utf-8?q?Niklas_S=C3=B6derlund_=3Cniklas=2Esoderlund+renesas=40ragnatech=2E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?se=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 19:48:53 +0200 you wrote:
> All other log messages in the driver prefix hex values with 0x, add it
> in the one missing message. While at it also add the missing opening
> parenthesis in the same log message.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: dsa: microchip: Fix log typo in error path
    https://git.kernel.org/netdev/net-next/c/ed6dc972c19f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


