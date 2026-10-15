Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77E30274D;
	Thu, 15 Oct 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074007; cv=none; b=jegOaMVW+dXrIL8+cKN3DPjCxP5fofw/ZUB6gOOkiXfkC0XQK1rK3bXPvknFgh1k8YfLYtNmvocVJ1HbCpOP5suDW5fOWRvUyAa4rOQncrYriUQd5/RZlrSo+KqsRD28AULyUd1LdbQ/PK4m/mqHXLR3d1i+i7Xq60G6RwDKQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074007; c=relaxed/simple;
	bh=ZSuBiEONYE8OFhTAqWlSrgfR5n0f8OQWALvFpXlZZ9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QAIrZVDb2tBvi7oHYIvvhEwg6TTb5niUnxs6sL926S8tfk9LpH4+KssyXrwXasTfIHD7dzvya2k3tjYP6ydUP4+mzJwx+7MoRKpfKAxZ8UTOul7wdblqPqOTJn6mtrMlNk4UYikZ518r8HYBPRODhMiRMmgAFWEWqJU2sybqQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXlvSxQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXlvSxQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091951F000C4;
	Thu, 15 Oct 2026 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792074006;
	bh=VJS6hZuydnx4DmRBaO53y3BGLT926GazDCKb7odCu5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LXlvSxQKZooo4K9CIbwcAOur3SlzZFlRa1gTtp1/iTlOWTL0dpX6F+juqS0CcBIQJ
	 2icI/sSj3oRhWjFOosIRFK7nuDOiQVrgIlIASjGW5zFaVx7mf0nFKf/1GEgVcRnurV
	 13vuXxBjy9U6CovS7Ti/W9Y3HRubBvFToWnZNkQezcAAhE0cndHyCcF2BO02ciweIl
	 GOf8xuK5BligIN4FPcYEeC1goSWYqxGD23XiiG2PG53U2pH19Jjb6UcU1cycV1JbeT
	 5hxIjl0N6WTstuYeRexC3PLsJfvFUIL5xXnqayAZBxBM587XSWXLAT+q8xF6sbFEJq
	 TgJmv8P+jXr3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15A4392EB0C;
	Thu, 15 Oct 2026 14:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] bnxt_en: Fix SW USO padding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179207400477.3459929.16206928663915388110.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 14:20:04 +0000
References: <20261009215426.2377946-1-joe@dama.to>
In-Reply-To: <20261009215426.2377946-1-joe@dama.to>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 Oct 2026 14:54:22 -0700 you wrote:
> Greetings:
> 
> As a followup to Eric's fix a51d233ccd48 ("bnxt_en: fix DMA mapping length
> for padded small packets") which fixes padding for normal TX, this series
> fixes padding for SW USO.
> 
> There are two cases I try to address:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] bnxt_en: Add helper to fill SW USO payload BDs
    https://git.kernel.org/netdev/net-next/c/70f63dc60872
  - [net-next,v2,2/2] bnxt_en: Pad short SW USO segments to BNXT_MIN_PKT_SIZE
    https://git.kernel.org/netdev/net-next/c/b0f7f9c87817

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


