Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C92232395;
	Sun, 21 Jun 2026 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079285; cv=none; b=kSxrvoRr1DfZYawqJ0S4sFmISoUzZAi4HGaAfK5Vz5hFUEh/m87VeVxwEBdg+BIQCEieMpgJDpulgFIhWQ2QxgiJh1etbLgqluY5w5cgB924llEJuVs/i5eUhji/G3XhGACLbZj1+ydsvRI60Nsi/Xeozpa4Z3asXDH9mbC324o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079285; c=relaxed/simple;
	bh=tDqn9iSZiaZWCPqpD4eq2xxQGviIZbFQ5fmVD+F/0z8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vBRYL4DXdjKW+IroczfoPTmeTrabJTzkspo3DsHhwIlXpVjkU0hCtEBPlOUWnoKWGecWgDIEtg1lTNaMiAnlSqk3a/qkaemVKydscLSCL/wYIfG9423Ouh8k78jxLzD1Vre0a8m1QT8SMZsXw0b13gTbSq3rlcyzlbndE3U87U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXQOLWKk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXQOLWKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DA01F00AC4;
	Sun, 21 Jun 2026 22:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079272;
	bh=3BlpzMyBhSpluKhTievfvkXKBfJ0k8M6QzSAPwuH3DY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SXQOLWKk+6BVIqP/M4To1fOu7wF2pEKUu4iVVr9yGqCv9EXCUMfL5hO4c0Wbs+DGf
	 By2caDj4DohCgOj+kiLCBfjhFDzfRbYAMUeHtlYz1JDxj6SPU+4PHx+RC8qv3djhxe
	 ZypzePqVjUYteXBORJASJYpPZvMCuEJwRi2Hucw5K+OyfY+/AIX1Qhr9jqI1bHXwi2
	 aFTY1EqRrktRyUeU0YZAsW2RSzsy8UZrKqcHxsCTzttlLBXmlk49EYbBqdKUOc4+w2
	 JsuoKMDk/6fQCytl3wVF+zXbdqQf69G7clNwREc+jHVQ3PvcmpsjW0p5Hb6FtvyGS5
	 NJzhWaeDOnwsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08F03AAA6EA;
	Sun, 21 Jun 2026 22:01:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-pf: Clear stats of all resources when freeing
 resources
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207926350.516339.6540360928701267415.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:01:03 +0000
References: <1781636420-19816-2-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1781636420-19816-2-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 bbhushan2@marvell.com, rkannoth@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 00:30:19 +0530 you wrote:
> When all MCS resources mapped to a PF are being freed then clear
> stats of all those resources too.
> 
> Fixes: 815debbbf7b5 ("octeontx2-pf: mcs: Clear stats before freeing resource")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - octeontx2-pf: Clear stats of all resources when freeing resources
    https://git.kernel.org/netdev/net/c/fd4460721fb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


