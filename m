Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336014;
	b=l+Bv5cnTKcx5k819+2Z0aYV4ntDl5u8EVpR5sdGAjrH3tfQCiJNPk6rUQF6qakJJEQLA
	 TK/RPV49o7/kz+u6Q1t2HEbsmPahRm3n/9fuRf2+DYHQwUDN/A3cCcgS+8c1micoaNe4J
	 zd8eUsm2k7jrTWiovKQBYEvkIVSUCxVDKrd45D4QKLA6UHdDjOaGFxhP6ob0ReT2unR25
	 zKshhKShdc4HaStwIuz2yqy/n7SZVOGEst7mzHnDYtDKI5t7M19M4uKR8c2JXTYeZEigu
	 3U9Ke/82tryXprPBOoB3nhd6hdfRsOM+DGKBnoxNi4ZZt+0ISSGq/ge9/LTsSOoBwJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336014;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=vQCGg872mNbU0rr+UHtOs4AvhVLRIenklCxcuQOe8TQ=;
	b=aERKzgtexI8u4DSGedTzJa6PhN4yWieC767epphvNz8rOZs4nD8ye/gdBJ5d7g2FKUKp
	 SHBNnxk2dSyR1m82Qj6YtXNnC5f9p6Vw0R6qhGprisBCK+OWyH+8pK4Vb92DISLBbR+ES
	 4pIOFhgcMgiJB5ocOolQ+bpuupVj91tIayPSZszKOSKt3+rapKotskJVdE1TX+Lpbbmok
	 zMnoXELVpvSfwwgoAnM0aSlDvv2S0XrGX2ImQnTeAc9CZezfS+PziGRmDm+hCfsCKD8g6
	 MMWOiSzKZpgt0oc2j56GcFvASZHVnTyqfI9A8fYbDgppnLey1KkKEKe5HaIUjJ/2vRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGJuheii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E7606C6C6;
	Tue, 10 Nov 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGJuheii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD281F008A5;
	Tue, 10 Nov 2026 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336013;
	bh=vQCGg872mNbU0rr+UHtOs4AvhVLRIenklCxcuQOe8TQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OGJuheii0DDC/zxwu1+1pCzPOyzLFPpwpdZ2tRN0l14cRmbPnbONymWsP/zyyzOzg
	 BsxN5PJVaQFV4blBSwRA3U558/YX3XJbUx9/SHS2R4Eoyl4E9q/2LiFuUZ3AtXEfSi
	 6PK6gdJJ65/DbCg8h2kwwz6gJBFsTggOgf16T8Kw/yqbnDVW9mgLXiVZ1daFjJUj4k
	 qeJE6CnIKzZOZULFNh+EgdItearg3v49m+r8/xy/Cr7GSTkMXj3wui/NuMMrSUhoGT
	 QlapycOIh2YDWhsveuWDSukzcOG8XnQfYZYT6oRs9ce58ofu3B6j/zSVWwrDA3Fz7m
	 wXrqYVP8jebXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D822B39D6091;
	Tue, 10 Nov 2026 18:40:13 +0000 (UTC)
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
Subject: Re: [PATCH net-next v6] net: phy: aquantia: add get_features() for
 AQR113C
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433601242.4186528.3793631782587029342.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:40:12 +0000
References: 
 <20261104-net-phy-aqr113c-fix-pma-capability-v6-1-d6d4718e45e3@oss.qualcomm.com>
In-Reply-To: 
 <20261104-net-phy-aqr113c-fix-pma-capability-v6-1-d6d4718e45e3@oss.qualcomm.com>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Nov 2026 17:59:13 +0800 you wrote:
> AQR113C does not correctly report its supported speeds in the PMA
> extended abilities registers. Without a get_features callback,
> phy_probe() uses genphy_c45_pma_read_abilities() directly, which
> produces an incorrect supported mask.
> 
> Add aqr113c_get_features() that calls aqr111_get_features() as a base
> (which uses phy_gbit_features as base and forces 2.5G/5G that the PHY
> misreports) and sets 10000baseT_Full explicitly since the PHY also
> misreports 10G.
> 
> [...]

Here is the summary with links:
  - [net-next,v6] net: phy: aquantia: add get_features() for AQR113C
    https://git.kernel.org/netdev/net-next/c/184ee52965c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


