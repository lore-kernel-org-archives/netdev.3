Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4D31E831;
	Sat, 17 Oct 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200311; cv=none; b=AIr6hjDF3Mxp0Wlu17Ijoq2yNNu1ExPWXQmo1uLodYet586OYeCNYdQN1c+y4KMiED2Vcs0ypJBr5E1h4r7vSxST9H2d4kK2bNW0Vi5ufFVPop0qEDSdQUzfIKgTQGhdNJR3K4VRE0IyQxc+kwH8teP6tDf+SmOoPNP8KMEN1qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200311; c=relaxed/simple;
	bh=+R0DzIC8NQiSlyOYZEpPxOcdRGRUQRil3l7tb4q+fFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRqjylfJ9k9lcQZbI+VM+KYicBZ3x/Rkbn+QOIORh25jqtAVX9k+KnxZMop377AMFnJljQxOivqdhc0SBTPAIpk26cmiTCNC4FTGQibXP9GD1LgezzH4DcaPdAI8GXlE1q0+TXrR3Vbzy945OI6r7WiJHCEMjzSg1fAaOsFIqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBB202bl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBB202bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261851F000C5;
	Sat, 17 Oct 2026 01:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792200310;
	bh=+R0DzIC8NQiSlyOYZEpPxOcdRGRUQRil3l7tb4q+fFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eBB202bls8hB7cJV+QMc0rqPEXCbbSVkMTGmOK5jwZ2KQEsxfVMozPAVXFPOOzE2g
	 XDxgeDk8h1DStYTCjH3mgGv/JqMuLu9zDflgHI+t2pcxhVhG5VzVyk0W8ddBSqxEYx
	 LEjrnOxUCoUWHCPjdlOi7BstqA6MoGQhJC3X69LipAGe1OrYATfMSnSyB3Hbw4w1sh
	 Tv+VsYrCdvhneGGBbYIWTK/ryW6sS+cxBvZawTHB5XnHj1L0xg1kxPp3iYTAJ1Aeex
	 pkmgXta0VxsH4sb+s++YV/1CTwS6JIPjxiGc4ufmgGuaAEpp5C9Nm+4eMcnL93+1Rs
	 qBoAW4bZSrQwA==
Date: Fri, 16 Oct 2026 18:25:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Justin Chen <justin.chen@broadcom.com>,
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v5 6/8] net: bcmgenet: pad transmit frames out
 of the packet ready window
Message-ID: <20261016182508.1100f391@kernel.org>
In-Reply-To: <20261013-nb-genet-mtu-nn-v2-v5-6-076b6fc240be@tipi-net.de>
References: <20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de>
	<20261013-nb-genet-mtu-nn-v2-v5-6-076b6fc240be@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 16:20:35 +0200 Nicolai Buchwitz wrote:
> A frame that ends a few bytes past the transmit packet ready threshold
> stops the transmitter as soon as a shorter frame follows. Tx DMA then
> refuses to halt, so every later bcmgenet_init_dma() fails and the interface
> cannot be opened again. IP fragmentation generates that pattern on every
> datagram, full frames and a short tail.

This is really odd. Sounds like the IP can't really support high MTU
properly. Should the user be somehow informed that the driver will
append out-of-spec bytes to their frames or better still opt into
this hack?
