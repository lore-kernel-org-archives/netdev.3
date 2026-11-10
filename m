Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336016;
	b=m1/OrJyOpA6uc8fWaAdt61fMMsalBZs2yR7vvJY23sjl6kXPL0w3RlxUHRhpVDPu2NhU
	 vCRFH+SaRov7xSEkBStgqK3WuyE2qsuIcvjlPAE0qX0LCwt/4ZQH7zy1sjJ1h8JW7n0+U
	 DGhQX/gFk7N0P4WU/cTK1lwElTRHsyRY12htojVn/F6vVn1citVE+wy8WAUtX2Kb7h8gP
	 w0rN88XP+1j5Sa07xjEUNcMHaOsI3v94MAsbp8GgvGfdtYBSNwjDSS0cGBwlBMf6fRqCu
	 AOTcDs25ISSKTqIwLcjHD6Rz8kkQ5iacfyHSh0tE2rYsftAq+5mdZQfFV5NFHauWz8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336016;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=h6tU1rtvxqhJV8q8HMw5UH1cjfxlZR5POx8WdQtd0s4=;
	b=gM5B3bvQiLDzo1HafY6w2uRERljuFuju1GFaNujZlYTVcMrbBFnxiM1LhdPKBMg9S2cg
	 ayQJevON33Q4SqANN4r3mzLxnovfUjJRfn+nsqynVopHbxjWq/ms20ZAj9beay4lSJhgJ
	 t5lW/E8pRe5c+tAiaDA1DNRflmrSUKwsj734oL982E2JO2lRS37VtS6vMEUgDsgyuBsBg
	 tSxHBYq7m5BfLSyL4R0PLbwgni+T6ArgpdWafdFD2fbgG2IbDom3pCRNTgiFikkfPgWm4
	 dIyaGcrhAPwgVhYC0QMwppUhr2I44Z/FDUsBK7w65rfpmAMirJtjniQzBiiHFLqqyhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in8DSHUR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D9606C6DD;
	Tue, 10 Nov 2026 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in8DSHUR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669A91F00906;
	Tue, 10 Nov 2026 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336015;
	bh=h6tU1rtvxqhJV8q8HMw5UH1cjfxlZR5POx8WdQtd0s4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=in8DSHURqckzGNb7TgOs2kJ2/VDsdqCm5ZnncWYusczOoM0EoKieZn9zoNfY8Ad9l
	 pmJkSk5qk/4kgVtSy2dkYBNpS4RF2Fm44W2qNnIPyxjef5hg/ijlSrN0vtH3AezkOA
	 clgeV+liUYF5EbY/XFhR4XwNdnw3sHgojbh7BwP2w4lvC/ftnXUn21dQAIEn84Z2QX
	 Jpr556jryLt5abprXVfv8jxUjuvjoDZGlBFuVguKz3IUk/+7PWKo2KE5wF9KbrSkyM
	 n7QRHccsaU5ZvHeVpZfxyN4QaW2foBPIQH9uOVXqmwudh0sSJ4m9ZWufkFYZEgU29u
	 QWRXuL49Fmf7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5DFC539D6091;
	Tue, 10 Nov 2026 18:40:15 +0000 (UTC)
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
Subject: Re: [PATCH net-next v5] net: phy: aquantia: Add support for 5GbaseR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433601392.4186528.2895519979056082863.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:40:13 +0000
References: 
 <20261104-aquantia-support-5gbaser-v5-1-9adc0f538d66@oss.qualcomm.com>
In-Reply-To: 
 <20261104-aquantia-support-5gbaser-v5-1-9adc0f538d66@oss.qualcomm.com>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sagar.cheluvegowda@oss.qualcomm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Nov 2026 17:57:52 +0800 you wrote:
> Aquantia PHYs can operate with a 5G USX interface between the PHY
> and MAC, reported as interface type 12 in the PHYXS vendor interface
> status register (MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G).
> 
> Without this change, aqr_gen1_read_status() falls through to the
> default case and sets phydev->link = false when the interface type
> is USX 5G, preventing 5G links from coming up.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: phy: aquantia: Add support for 5GbaseR
    https://git.kernel.org/netdev/net-next/c/4e56f129ba3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


