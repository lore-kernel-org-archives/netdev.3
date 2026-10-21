Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597152;
	b=eJs0jNFt/NyfNTnGqcCUPab3ZQbVH039GBBL5ExOTJIZYVkRwkrUb0XRl6PH0FUoYEqE
	 Uv2LDfcsVsJaIk72C+4zaVCiSHwyJH1JvZfg+NRgkXU2KqVRkPkPHLqC7GdjJZV2EFYCG
	 bb2wFPTP5JLnXsJ6Qvi6TF2h3X/B+41wyZUN35dRY0SgtIA6B56l9FsNSnSatWWRYcC6J
	 rIhkDJFKTT+mmOllaPkctNN2sQOazBXYCdq3MjautyZxqnP+2BUDqabuYWIU3d1n0ibXO
	 MEzC+X8q12Gl3o3BPMmd1eCR2UJWB9QH3Pl7oZiRVQcyRhmzk8AxKZFvsKF1VB0oO2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597152;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=MBvUCZd8bqreVqsBZdyTrFLIsUWjtGvD3lWIOh8evsg=;
	b=H8WRHuBXZIvFc/yyrLr6/enakMsyqhpW3e9LfQfLWlksOxtzeXnIP1zn9RyyWUpcfBWo
	 HxzUMS81+LuhXO9Vjxw6X3TuK4MXfasJdgsL/vZQi5w1JJ51/u4FD+u4qcUcvf95ydtFb
	 c88WfNLN6dNtw5HvcaJP+bP4vkXcOQNYeKUUS8deVWBGKl8aJAVOgyrH4lyR/xWndhiNS
	 KrICAm5T5vmLZyo2AFp+iXmMB4kZcz2NtZA3Pu18Sijb6K1I7GVO7iVzhjJ+8Uv4FXCY1
	 wo/kJcNbEzI9BT1HVBpcZCbPvgxGM9lbFiX94VD8iMQzx+9IBP905lHpaTZasdkq5sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btT4gfBm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D26606A319;
	Wed, 21 Oct 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btT4gfBm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC7C1F000C1;
	Wed, 21 Oct 2026 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792597151;
	bh=MBvUCZd8bqreVqsBZdyTrFLIsUWjtGvD3lWIOh8evsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=btT4gfBmyBDxfrzjx2a0efMfGhFt8VANa7K1hwYjqI8464c4RwmAvv4XDhfoH9eOD
	 7gZVLDBqKxvPk4tWbifA963rlq+1NT9gS/Pk232WwIk3dOKCLGznnMn30icxJ0wHiT
	 ZRveYaBOrCy0H4NqWQzHr7diZU1l0bZHLyMXTrLgUGVvR7bMWDx+i5w5LtHg0nIj24
	 vVbTNQBNttvT4wdBEfe2jloNx1tWby2YosMRY4uuVTtc3S/D6OODprCtoWr9+Vw+w/
	 PWF002r8RwaOhNQc0OIu+uHGaZUf3VgiEI86rdT/8DInQYQT2E0id/dS/+6i5lCga3
	 uiBaQL31ZdLrw==
Date: Wed, 21 Oct 2026 16:39:06 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@openwrt.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bgmac: fix TX DMA unmapping on fragment mapping
 failure
Message-ID: <20261021153906.GB708417@horms.kernel.org>
References: <20261018231348.36884-1-rosenp@gmail.com>
 <179236550812.3290.9443229332836486177@kernel.org>
 <CAKxU2N8rq4bhk-5zAKd3hEWvUh-bfJtntQb9iJ-niZvXgT8rUg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8rq4bhk-5zAKd3hEWvUh-bfJtntQb9iJ-niZvXgT8rUg@mail.gmail.com>

On Sun, Oct 18, 2026 at 04:23:48PM -0700, Rosen Penev wrote:
> On Sun, Oct 18, 2026 at 4:18 PM <netdev-bot+sinfo@kernel.org> wrote:
> >
> > Hi!
> >
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> >
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
> This was found by an AI review of a related bgmac patch and confirmed by
> code inspection. It has not been observed in practice; it requires a
> fragment DMA mapping failure. Compile tested only; not tested on
> hardware.

Although this has not been exercised on hardware, the logic does
look correct to me (now, not before!). And it does seem realistic
to expect DMA mapping failures can occur on systems under pressure.

So I lean towards this being net material.

Reviewed-by: Simon Horman <horms@kernel.org>

...
