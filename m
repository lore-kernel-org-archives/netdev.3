Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A23E173B;
	Thu, 30 Jul 2026 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452838; cv=none; b=T2+/tHI+cFwUWKCeJQEiGRdIsOx2BvZrabNk7VwpVv2ZFC4KSJR2COwHILgVwjQB3O7Jouz9H8S2YKJboZViYwxBYF8CZKA2vXegaKJG4qYn1cFjTfqz9VomCEEG//iKNKGi6rP9EJIUOT6N+1Hnny48WM6Ji89y8uS/tx1Y0vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452838; c=relaxed/simple;
	bh=Yp4aj1pehzJr3gbl+dkJlMRUNPQ9M5p64nzY3/CVyFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4lARNeHQsY3ONadjNfTcGOnRxLKwtFMGFVscEAxJ4yNTOCsfd2lswgJ/IQSEJgXtguyR5QbZKdemPS6gho67c495rvf7jgktGrbkaBJYxjPlAWlTegR8JogaP64iqcUF/sHUVhrsyswABzJ9DL7j2ArdoHFqYIIcMJ9L7RhT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6DcTkaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6DcTkaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C0C1F000E9;
	Thu, 30 Jul 2026 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785452836;
	bh=Q95GYrZJFcrKcY1VkAcZ17z5yWQx4bw3VItykV2gTpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K6DcTkaSxNC3Mz//SHt/B6bK+8/dIYFonFz5hUDFt+cbWU8v8+L7HTM5TpBy8zQ6I
	 IGXYFiogBsfWPAH7rPrSfuCYP+qcGdS33hcIiq34IN/CoftAG9nZYlJ4l9WwsUqYZ4
	 nEF8z1xa9HoZvRPtqdxXBmtAOMldtBAXBOqtJmJJVRNy74Co3A2D7bn1DzQIKKbflm
	 yE4kgD1obSZpjqaCy15gmcRKjMtmm6nbSPr2EYmx9XHKPbSXsoVS72afJhtr1qXIWK
	 HS3XQdRT9ieCpop5Ba1owiPQbprlWMmHcS5vjxx4lAICCSmYl7k+50BIm9Gbpn2Q16
	 u0SGYs5khxi4A==
Date: Thu, 30 Jul 2026 16:07:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Abid Ali <dev.taqnialabs@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: enable MAC rx/tx after DMA start
Message-ID: <20260730160715.5ba5e272@kernel.org>
In-Reply-To: <8e9563ce-e103-4fda-80e7-5dffaca2a03a@bootlin.com>
References: <20260727-stmmac-rx-fifo-block-v2-1-4dc3457d31d0@gmail.com>
	<8e9563ce-e103-4fda-80e7-5dffaca2a03a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 10:23:13 +0200 Maxime Chevallier wrote:
> On 7/27/26 08:14, Abid Ali wrote:
> > When the MAC receiver is enabled before the DMA channels are started,
> > incoming frames fill the MTL FIFO with no DMA engine to drain it.
> > If the PHY/Switch is already up at this point, and there is inflow
> > of packets towards EMAC, the per-queue FIFO overflows within this window.
> > 
> > Once the FIFO is full, the MTL read controller goes idle and never
> > retries delivery even if the DMA comes alive later on.
> > This behaviour happens due to enabling the MAC RX path before
> > the DMA setup is ready, and any delay between these events increases
> > the chances of blocking the rx path permanently.
> > 
> > The EMAC should only accept packets after the DMAs are enabled.
> > Similarly, the teardown should ensure the MAC rx/tx is stopped before
> > DMA engine is stopped.
> > 
> > Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>  
> 
> Ah great ! This matches the programming model for the few ref manuals I
> have, e.g. cycloneV manual does state that the MAC must be enabled after the
> DMA has been configured.

Sorry, me+Sashiko again :S

Sashiko wrote a damn essay, IDK if it makes sense.

Looking at the patch - isn't it a bit awkward to handle Rx and Tx
together? We want to keep Rx blocked to prevent incoming frames,
but Tx should be allowed so that Tx can egress?

Grepping around I'm not seeing any flushing of Tx. Aren't there
issues with this driver if we stop the interface while it was
paused by link partner?
-- 
pw-bot: cr
