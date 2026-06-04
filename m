Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C51305676;
	Thu,  4 Jun 2026 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585210; cv=none; b=j4e/9t/ZRMGwKVAEjTATOd4JpLRxPDpeABxG99tXBh27ETNYjdX1WDv+Y6ZmVWMCJbPR2JYfeqhQQBlroDDZcfL1vvgqrOHDU/O0j5p7LGgnwBljbt/ZP1K/IZgQI3jivZhAbV9upXNPjup6biaL3dgddj1Yg3NM7tNNnwUNl1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585210; c=relaxed/simple;
	bh=RE/gTS3gPFSKjAoTr7HHFA1sl61WI4T72/HIlzEGj+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlbgHBMmiH3IVZTyoco2S0FAwTl0ydW6n15pSMFnv4aoGfZc9KI1EKB2EvrOTG5R7TOQegqWj1KzrFYIbqXhS2rd5qPwugMiCYBVPnz8MwcFiJhK0uxxXP6Qcq08qOjBKadBVoIRFxrWLbMQC8Rx3ys9dDj8V7WzpWn0DA2kAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agxjkycs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agxjkycs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0A21F00893;
	Thu,  4 Jun 2026 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780585207;
	bh=naizJbNKOKvlG5/naBBmtjVaCJw02IrRto2ZScNSu/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Agxjkycsemoz6LwkxyQ5dtRrEcZyFw4MlttJx4sD7/ZC66OweTx37s6Yxrb4uG6Bo
	 hN+UlQ9aMZFM1hfVwdbeNI5S4Gqb2jXDyVSlNKr12gf17dC4bSehPbzznNbhzYca71
	 +tanI+t+6SGVARaKisjd71nopyFmyJlar3xireXWsmrsouZ/6yTVHXfe4O00cx1eVM
	 nAGz5hUf54gElKVoeF2Zh/aM9anTRO0Cc4d4bppMP+2FXxikEaUOeCDM6h8QwkGdyl
	 CEeoYb2iigIMoI0kcBBV21QLLY9CFwW9c6Qwb1zdbgAAeXElEhm9D0ZEfgiX1n1wt9
	 6f7H04lfE8cLA==
Date: Thu, 4 Jun 2026 08:00:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, Jose.Abreu@synopsys.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] net: stmmac: L3/L4 filter bug fixes
Message-ID: <20260604080006.5a01ce03@kernel.org>
In-Reply-To: <20260604083350.1701-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<20260604083350.1701-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 01:33:47 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> Changes in v2:
> - Split patch 4/4 (ethtool stats) out to net-next per Andrew Lunn's review

Now this posting has 2 cover letters, patchwork latched onto first one
which describes 4 patches, and it's going to wait for patch 4 before
kicking off the CI. Please wait a day and repost again with this fixed
:/
