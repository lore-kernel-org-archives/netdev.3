Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93C47A871;
	Tue,  1 Sep 2026 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268871; cv=none; b=oPdQerFmv0Uyq50XRnRtQn9WeMTrQbTupujm2EVkISmhH3Tf/xhhd/egPRr7U/hBxZ4/StzjpcqzefDzxa1mQcavEnRpSzXon83BJo33s2bzMe4gri2TBt0F8ShGEoCceE6KsclUdHalSV13aPuDmQJVJ9sQkl6O5z/rNW046yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268871; c=relaxed/simple;
	bh=bBHW0NCtDTc+4iKiSArcfC4GKdYfpTcvuUPpwcL8RKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r566se9NT35v6vM/zDRF4I+lE6ycSGkhVeESjJ+j1+ZOIDVxcKAbkp6UCTnUtCpvSMNKX1CKV81h1wh77VJsTrnVQiTpfNw96NcXCHDDVcR70GumCj7/rQR1udobkFoupF/Jph5lu+zI8nGC+v3+HZGYsxzJrk5HtUudrjJxaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir1xqYju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir1xqYju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C641F000E9;
	Tue,  1 Sep 2026 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268869;
	bh=MHbAXfae0IY9596f9/1TBypJEdS03DWoNPAgF4GBxsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ir1xqYjupi2IvXdgBSrk33drSkkqvDGpbeS5MM4FDrIvEKRDr9BSllIKonCkGrF1N
	 reFfT/njNraeFzeXIpbe5Pj5vTbMgWZmyUb2iwo3jjJ0ZuhutRGTbxk9kLhA3zJDgC
	 t6mrKymMb4vk8ZBl803Yi7eqdiZ9nKEG39HrI2k47FjbROnbnbtkKIINHY7rNV1y4r
	 7tlYF8Gk3W+JzGrwIR/HFJV7F6YYc6BGSXF2xvNTYX32ExZHk35iq+0A0YTezxKLZ5
	 mQd8wHXVMPcJW0oXYvRHobWAJwL0BUpG7DyjM55IXylB7bE6QfNc9w4OpuxRGtwBwU
	 4HcDndBnkORQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569453924FEF;
	Tue,  1 Sep 2026 13:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: Remove ARP offload code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178826881193.1174044.12160983478989451764.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 13:20:11 +0000
References: <20260831071351.354255-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260831071351.354255-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 31 Aug 2026 09:13:50 +0200 you wrote:
> dwmac can do ARP offloading, where the HW replies to incoming ARP
> requests. This requires multiple steps to work well :
>  - Program the local IP address in a dedicated register
>  - Enable ARP offloading
> 
> This is halfway implemented in stmmac, as it's only ever used by
> selftests, and these selftests are failing on at least 2 platforms :
> stm32mp1, and jh7110.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: Remove ARP offload code
    https://git.kernel.org/netdev/net-next/c/85ca3292d7a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


