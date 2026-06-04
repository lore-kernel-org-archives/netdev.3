Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CF2DECDF;
	Thu,  4 Jun 2026 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538416; cv=none; b=BKjw3KUR5lzEtKVYpPJ3ABEtZ9ks/SikX3SnbQRes29qp42BNmMO0yWiHAWsqDBtcBFtaARFQVeGV4rbqFOWb1nZpLkgod//w3UcaZUe85g2Mk66yVa8/lP1/yYKiObrEOYYtzlO2kJ/Gh5Oq2beDaZSzIhte8SgJDE9DeKSivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538416; c=relaxed/simple;
	bh=j5C9fCliWd49VtDuAMk+Ux8kmPBS/14ZGa6IY19k5gI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kv7+G0j/Ld97i0/E50x70ThyDmEgLvzqpKVrVA1ljKmO60sDqIAtmPCwTCIefgfng3/ttRNo7Dk1t2NCnb05MVPJ6QM0QcEbF2GFQLjbAqaFP/uauRl5OIDuaIeIwBTq4JDuFW+aHBUF0LVI84FLwy6Cr/3fvreZfg4B5B4Wtcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+zho631; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+zho631"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFC51F00893;
	Thu,  4 Jun 2026 02:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538415;
	bh=RdUSp4/k7vcFjxr4tpxGwAhNlKCf27nZcmnEILmB25k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J+zho631bm+qkeelPvqUR+kcRmhOl+qeN37/CejZPQfCQ8g8RgDel8fQGsbQNQITt
	 /ZfvmsIiIg66TYXIMLBB3vyjwXydMdrRkca3ZodXQ73esMeErgQQn33lcvW0UwD34E
	 uSxdM9FPW8W3yiChZbDfLx0e9AzWAluAywrgu6Rp9siiYm89yhRkdG3dsUwB5tdJgH
	 +tcd+9LcdKBoUw73vfd20uJciUaOvaNAKnMmO5p3AWsc2u+k3v8dGlqT07tIsVGwrj
	 ySwKW8VDUNGB7SVQh7B9aD9SSGq55jNleyCFPzYRYZ4W7I8K2lU3Hofd2KbZc5WmJi
	 3hJ45+zNAfsOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A1939308E0;
	Thu,  4 Jun 2026 02:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Fix NDC sync operation errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053841639.2201066.13935205117548909147.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:00:16 +0000
References: <1780054677-17249-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1780054677-17249-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 bbhushan2@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 17:07:57 +0530 you wrote:
> From: Geetha sowjanya <gakula@marvell.com>
> 
> On system reboot "rvu_nicpf 0002:03:00.0: NDC sync operation failed"
> error messages are shown, even if the operations is successful.
> This is due to wrong if error check in ndc_syc() function.
> 
> Fixes: 42c45ac1419c ("octeontx2-af: Sync NIX and NPA contexts from NDC to LLC/DRAM")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix NDC sync operation errors
    https://git.kernel.org/netdev/net/c/a910fb8f7b9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


