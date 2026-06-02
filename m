Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31B3A5431
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427444; cv=none; b=QXlWB9S6yRLm/iJrWbn9YNWf0qYJxX7ybvy5QcwzgugtFBwz5KYecKre/XZeo39ShyC+m2zbkC4mNdIFpcx6quM5u6ocuYTFKAg8SlNd1sReHXnLl7X4SvDbFXKDQbEybcmhFqxDB08hRoogcw49LuV9mxovOc5VPBnnrIdHGMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427444; c=relaxed/simple;
	bh=hSAr0Gix1PSh9fDg+0Bh9uVtnEt1iXB9VstNymjQ714=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iQJrbqATm4fPnJ04ZhwulSU/gTsRioYrYf6UXOA1e9TueOWyC8UjP7LBIe0Z1D1AcmSNZfmZpF+sj0K2Lbc4qbNxt84dl622v5cNLl0b+zPlTRH4jRi9x2Cx1GqmY7mkusHTuDUZylutYcAA8Zc/qNu/LYug3S/8ge19MKikNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4aWfJ0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4aWfJ0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC5F1F00893;
	Tue,  2 Jun 2026 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780427443;
	bh=/qDg78ixEj2MH/tGiTu0JsKHtgfhzCK3Z95O0mqgqiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M4aWfJ0d/k0caXpXHIqgJKr0AU1teEKFvLBu9TnK9IkxB695SPtPUgMNx4SbCpt1M
	 lPXgLBW3Cxji9S5VI9jGXbwRkKNBebQCf+NX/VnCUso7gshFP+Pio+DJRS4FPd0AXZ
	 ZXWH1YxY7GYYW1y+Gzm1NFMDB5z7vzgW1QKmS198F7C3YTr3jIfiDgX74zBvAsrfkn
	 t2+A7aftMNe3l3UEpV//bS5q0wHOZ2It89JxiA415kjIUf8JlbskhR5W/CGAodbgi7
	 wqvDo7ep2/1BKNBmssbdo6TiS7qXS3owfYE9srwbVSzcd8IOqq9La4BKnDYOepHM+4
	 VB4kBMJWIUMaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569463811A6C;
	Tue,  2 Jun 2026 19:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 01/15] batman-adv: drop batman-adv specific
 version
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042744488.1010994.13027563047282027332.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:10:44 +0000
References: <20260601123629.707089-2-sw@simonwunderlich.de>
In-Reply-To: <20260601123629.707089-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Mon,  1 Jun 2026 14:36:15 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> Bumping the version number on the first pull request after each merge
> window was deemed inappropriate for an in-tree component. The version
> number carries little meaningful information in the context of the Linux
> kernel release model, where stable and distribution might all carry
> slightly different patches (without any change to the batman-adv version).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] batman-adv: drop batman-adv specific version
    https://git.kernel.org/netdev/net-next/c/6f864eb5cfd8
  - [net-next,02/15] MAINTAINERS: Rename batman-adv T(ree)
    https://git.kernel.org/netdev/net-next/c/1e323d0e7d22
  - [net-next,03/15] MAINTAINERS: Don't send batman-adv patches to netdev
    https://git.kernel.org/netdev/net-next/c/6dbf9f76a692
  - [net-next,04/15] batman-adv: add missing includes
    https://git.kernel.org/netdev/net-next/c/b8fbbfe81d3e
  - [net-next,05/15] batman-adv: use atomic_xchg() for gw.reselect check
    https://git.kernel.org/netdev/net-next/c/9550dd11e360
  - [net-next,v2,06/15] batman-adv: extract netdev wifi detection information object
    https://git.kernel.org/netdev/net-next/c/c0559465842c
  - [net-next,07/15] batman-adv: replace non-atomic meshif config fields with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/6a4f30e6e34c
  - [net-next,08/15] batman-adv: replace non-atomic hardif config fields with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/dbb48d9089bd
  - [net-next,09/15] batman-adv: replace non-atomic vlan config fields with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/26f8f9f9379b
  - [net-next,10/15] batman-adv: replace non-atomic mesh state with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/2b2450e3266a
  - [net-next,v2,11/15] batman-adv: replace non-atomic packet_size_max with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/58020571b54f
  - [net-next,12/15] batman-adv: replace non-atomic last_ttvn with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/4dd2055046c4
  - [net-next,13/15] batman-adv: tt: replace open-coded overflow check with helper
    https://git.kernel.org/netdev/net-next/c/5ffd4dd87425
  - [net-next,14/15] batman-adv: tvlv: avoid unnecessary OGM buffer reallocations
    https://git.kernel.org/netdev/net-next/c/735522e7ca3f
  - [net-next,15/15] batman-adv: use neigh_node's orig_node only as id
    https://git.kernel.org/netdev/net-next/c/3bd64ca11d9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


