Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279287;
	b=CbQjN7l5mxfb4mGtRlt6UxMf+eVNYgWUu2WdP+caln+SEoyTWebZbxjFp8aRG315y9pl
	 2jhBWW7IrpSDppwKE0zdtG0EnjwqjIy+R8vKtdmbl7xpo9dXrHY+rLkevkwvP1EVQaWGo
	 XmdgUtpZeZ+4UyuXCcjJkH1z+wjOeTz2enxUmZkNE4mb3vcnr2lA6s1wu9qItauFhwpXd
	 3bNYJljkDcLuACB1smdit19IEX92VRTLyC346iM14EVGZ5ElBVG5Jvrt4U4yM8nUTDn7W
	 T7ivIv3K54ZZAYK16tJPvaAQhJIT9Nh5xS6oK1S8PHunJ/w5vWNJHuJtkHB2xojnKzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279287;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2tpI3qsXtaGip6xI0GQ5A1CwOBFwtG1+IBt4FLBh7Jc=;
	b=R07Tj/uUa6maKRQITev7TAupASdsyHYwn0cSpgaMz6EQHeDfSnqZtC6f6amFNFGSot/R
	 SQLtMTF+PZmoR+FujIfRZjQH5o//ML6m3+tIDCsuREZOiIghYfsKX9KfM837VzU9NC1Uu
	 OR+XOXbgiLAWTZ88WxOmaCm7XhGHQugD9VCypd0myEvaKxhNGyvOAb4yjVgZllHwp4YzE
	 Vh6D5nSYUgN8q7l46x9Ls5CQijNXzhavPTOLqsLAQGsDFDzT+I5hLc0c187FX466fln9o
	 Jue7ZSfEXmYgDd/706DCDzgOKn4rNxMC/sjoMfpScl0c5Yh2+wK5hyOTYT6vO8YiFAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gfFI/ex6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D360A262F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfFI/ex6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31541F008A1;
	Tue, 10 Nov 2026 02:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279286;
	bh=2tpI3qsXtaGip6xI0GQ5A1CwOBFwtG1+IBt4FLBh7Jc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gfFI/ex6PkJTB4x6itrTv3umT+Shw6kesZFyuebiEM899Q/b5wcq3AvTMYNdlbERt
	 Br7xxZ6+GaFBO57777a9qY1cE0AJDQAgsDZpaZdZKRL5qqiQEzLbw4CC32SR3OYkOe
	 jYdlMrs+oes4iKVpdwpwsUKOjCRQxwcgcklz1iEqH3EIrhcWo9iTUw34TCRbI4vbd4
	 YFax0Kk8nkxl1bt5P8FSJn0UDnMbN2VwynNCpng/b8TKOE0NmFS9Q4k25t4OchzfnR
	 Bf2QU5VX45C/zmumpmMI86mqgYRNgyYefW/mSGyLCH6Jk2G/JHz7yHDwSy0cKuLomn
	 2Mgx6kO3UOHQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B10A391AFCB;
	Tue, 10 Nov 2026 02:54:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net: gro: fix frag0 and remcsum handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427928516.3612825.13177875895185674997.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:45 +0000
References: <20261104151042.1157782-1-edumazet@kernel.org>
In-Reply-To: <20261104151042.1157782-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, willemb@google.com, steffen.klassert@secunet.com,
 tom@herbertland.com, cenzhang@linux.microsoft.com,
 AutonomousCodeSecurity@microsoft.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 16:10:40 +0100 you wrote:
> Two GRO fixes for paths using remote checksum offload (VXLAN, GUE)
> and for NAPI_GRO_CB(skb)->frag0 after a pull.
> 
> Patch 1 skips skb_gro_remcsum_cleanup() once the skb was merged,
> as grc->offset can no longer be trusted, and no longer builds
> fraglist packets with an adjusted inner checksum.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: gro: do not undo remote checksum offload on merged packets
    https://git.kernel.org/netdev/net/c/c817ec1b0687
  - [net,v4,2/2] net: gro: invalidate frag0 after a pull
    https://git.kernel.org/netdev/net/c/98d949a15ff9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


