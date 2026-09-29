Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C8547043;
	Tue, 29 Sep 2026 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640238; cv=none; b=h00jGn7M280dhdXfkvki0ZLJRkpnTvahSiqZsGO5EkNTImvBoNb9dDPi820T9t6ICTLBJetomaPLo5f2OKZJoK/MUKbKIhIFhoPU9B08UfyeAgeUdLWarefOgxXela/3a6QxKIUbTq6wP1OOgdbL43qoYP/UYvJVdbAqpTN5R7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640238; c=relaxed/simple;
	bh=GMY/980GNTG1x7RLqGkM7AwXdKgIOinuBg1AFppA5Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZfBaBmaWMQmKq53wrb2zWBbmS9zpY0wn3OTz8GmrgEqzZJeDddHAE04PuhwEATcDg+dmRImINzl8W+nc/SzGRWk1cLrsmo3w6tfRvt91Gn34bo7FAPx8rTu8kLHRUQQSoPK/ysplu3LHkt+IJQm8mQ9PB+1UsQx8ODEitfpcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POnpiKpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POnpiKpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C551F000FF;
	Tue, 29 Sep 2026 00:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640237;
	bh=eFh23lNDTV8z5iPbY7t5PTdAOrgzBPtFJ/YyjYpjsHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=POnpiKpGZdeIOJWuFnuAEsq/OG37e7uPjkRHE/lh96bzodCXRd4LmO1fjc7yCxS1M
	 jBz+2CWpqIy6AR8WF+2iWg97yyEOfsebdltQtwt0q1ZqR7yNooLvrFFVyYBH19bs/2
	 du2Cuc3LadX2s2nhdAFY7OzsJfDBGyx6rFBdVahp+9f6GKHw1VpnomIb1+F9JL75HT
	 qXhgtjtH+VISrSAGns4Z1Ky6j5DwGoSs5W1MRPPFCgApYPG5Jg7qtxYjpvEJZ/lF49
	 nc2ssLs64JSRx8WpKwU6yku8KnKNwPh1ZinoiDllb4uy5W0H089zTB3C3sVF32Ixzk
	 HDBvEg1srywOw==
Date: Mon, 28 Sep 2026 17:03:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Zak Kemble
 <zakkemble@gmail.com>, Simon Horman <horms@kernel.org>, Ryo Takakura
 <ryotkkr98@gmail.com>, linux-kernel@vger.kernel.org (open list), Nicolai
 Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net v2 06/10] net: systemport: Fix potential packet
 length underflow in bcm_sysport_desc_rx()
Message-ID: <20260928170356.439aedc8@kernel.org>
In-Reply-To: <20260922232440.598918-7-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
	<20260922232440.598918-7-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:24:36 -0700 Florian Fainelli wrote:
> In bcm_sysport_desc_rx(), the packet length 'len' extracted from the RSB
> is only validated against RX_BUF_LENGTH. If a malformed or corrupted
> frame is received with 'len' smaller than the prepended Receive Status
> Block (sizeof(*rsb)) plus 2 padding bytes (and optional FCS).
> 
> Furthermore, subtracting (sizeof(*rsb) + 2) from 'len' (u16) will
> underflow, resulting in corrupted packet stats and potential
> out-of-bounds operations.

I don't think we are required to protect from bad/malicious PCI or SoC
devices. If this is a LLM suggestion - up to you if it goes in but
net-next and no Fixes tag.
