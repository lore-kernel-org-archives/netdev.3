Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608540BCB7;
	Thu,  9 Jul 2026 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591829; cv=none; b=Qbq5FZjrDF+tUoSii8c6CSgVGQdzYLAiAqVTLKIjrjPhGLsdeVmi9um5M6o2/IDES0tjvCc6XowmWtq7f0BvP6INj5QZF9t+zXjnuVUoYo6exakSiqZdD2+pcEnfREitYdxZhQobPoYJL2x/El2YyqeGaDnPkUX/1zALAuW0f3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591829; c=relaxed/simple;
	bh=i/FK8fPLitdoE553p1GwMvAyliy17XwACOghFp/tVrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YLqtKcaojBlxwuiGR2pnSvXSIJACknrKssjBaz7D6CO3fAiD8fNRQruLnfRotasgFNPLeheBHcQstLAhBwjF16t8b57gNveGz14XDLw5nlAZTW/mqvz2/WJESf/F6MEH1lrh00uo8PyqzWDdo7sGjlhz/EyVgsCvXpjkwoW7zJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KantdWfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KantdWfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B245F1F000E9;
	Thu,  9 Jul 2026 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783591827;
	bh=YK07+fqKaXgivIvgLDXYKgRiNA/xEteeQmg8DFg22/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KantdWfSmKx0mcOgjYanlcb7am2S1JWJhgh6WE/5/1PtEAkmQrC+9Nuswo8AAalHL
	 aqUXw6+jknU6ON1ffE8mZs6eMEFffdSuoktnKyAbfzdV5XLX4j3JcV4PMYmy5HGG0G
	 2F60SGHBubtsQT4ZiHCJzVkjsdlKpRbKPiZJYaW/iUl9CGWcR3u4u6BgBHb3R822xM
	 bi0B1+jCFaMpeuEyXINuzPt8M1VUM0j99+4pdxvcp73TIxaGFfazDJ8ursYUAHPKrW
	 6g2EVfMk6BxRSkgJ2LlD48v1yb07gix9G9XkcIR3M84sT4L30v/VCMgUWGytR/9ieZ
	 mtO51lyrre20Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93939393A964;
	Thu,  9 Jul 2026 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] octeontx2-af: Bug fixes for VF RX mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178359180614.3386943.3763503743823915105.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 10:10:06 +0000
References: <20260702045616.3002773-1-nshettyj@marvell.com>
In-Reply-To: <20260702045616.3002773-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 naveenm@marvell.com, rkannoth@marvell.com, kirankumark@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 2 Jul 2026 10:26:15 +0530 you wrote:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> Hello,
> 
> The patch resolves an issue where a VF changing its interface
> state could inadvertently delete the RX promiscuous and all-multicast
> MCAM rules belonging to the host PF.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] octeontx2-af: fix VF bringup affecting PF promiscuous state
    https://git.kernel.org/netdev/net/c/fabb881df322

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


