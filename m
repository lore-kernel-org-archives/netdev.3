Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF370476CC3;
	Thu, 30 Jul 2026 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453655; cv=none; b=qW/Acg1Vb8/kxhxkwKbuftOfp24hdOQn/y3Q0r6iTXs9YC1YE2cTaiX8PQL4JF9l5mpEe44Xtlp9X9Y3I/QSmUBqdNXSZ0Yt0+hE9khE9LZrIzF47xq0upvoXZpc2rqGJ1knr6h0Bw5UgwOgL9BJKgP+u0vOglMxxbdfHm0J+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453655; c=relaxed/simple;
	bh=sgp70WKMB4REvr2si5zLE6hyNItK0Ra6nOfDBvi0cE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cQ5p9A2mUowjJmOwsE+/4iDoJ1QJS5ecuaYcXZxW+pVW3LakPhNaKCvdmQ825qS7E6z7vZ0on/U35XMt4D4gu92jt5Bbq2SmG95qZZuZjRG6qAJlH4R9AccFhcKhxdzzwt+VhkkGv7//NdcI1JFit50Z/fBT4dJzbMk3w16HpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYq/m9AM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYq/m9AM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8167D1F000E9;
	Thu, 30 Jul 2026 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785453654;
	bh=HOZ17I4OZ7Cq6EbQ4I0heWJOiN5aZPWDgvCUS2jyYrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kYq/m9AMy6jufqW7WyVy8Jyb03eRkH1yUkAKSgzc/oMlOcfUmQM53MD5bUTofNdr+
	 UcvOVXW4Pj/9RpiSorvhiYyu54Ox/p4VUZchnfmiTupcU43wfmeRhHeAtdqzbOdiO9
	 4G4QmyDgkCwZyTJdZVm8zFKLp+jsua4bcKudMFeQaLpaYw5d0VN0W91WvRPnypGIDU
	 x92tyNyTUHCEAZ6QypFoEB0wS/80/APzgRXGpDXU8f5A5pdIwh9KBfaMPNuh3Xg8Ur
	 Y/f8K/ND0ZVOzLlpu0TD6rhn54cZQ9cCWCOYsZWGovZGCffUsHwskJnMius3pBicaG
	 /uy0AGQcqGETA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B1392445F;
	Thu, 30 Jul 2026 23:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] wanxl: Remove pci_map_single_debug()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545361763.33420.1984323195600172666.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 23:20:17 +0000
References: <20260727-wanxl-cleanup-v2-1-3826430829c9@arm.com>
In-Reply-To: <20260727-wanxl-cleanup-v2-1-3826430829c9@arm.com>
To: Bence Csokas <bence.csokas@arm.com>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 16:02:07 +0200 you wrote:
> Since commit 24dd377a76b0 ("wan: wanxl: switch from 'pci_' to 'dma_' API")
> this has been dead code anyways. The pci_map_single() function it attempts
> to redefine has been removed in commit 7968778914e5 ("PCI: Remove the
> deprecated "pci-dma-compat.h" API").
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/all/20260709151401.GO1364329@horms.kernel.org
> Signed-off-by: Bence Csokas <bence.csokas@arm.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] wanxl: Remove pci_map_single_debug()
    https://git.kernel.org/netdev/net-next/c/8e4d7d120734

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


