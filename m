Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089C3D6462;
	Tue,  2 Jun 2026 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404855; cv=none; b=QCR3MIxaGuIhqVgO/d0VA3YyIFYzvT7OX/sQ5SSGF3JNhI10yFrAaDEU3vISlqmEtLlSX5zSjBEtAuxCvKueEfjdmOAiT1E41w/tiOUOukVrcUjrFDpTfTkJduWx2wg8BkdOKe0FtZ/muqySmW8SKx6AI0RysEKMaITT1GharuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404855; c=relaxed/simple;
	bh=u2wLVQ8WtyL9BIvANjkAvt7NVhtukWU4INsLhHaY5bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeSS/FW6KOuhRA6yV/ARlX8FIShQeSYWHnGULLIy0MtE9pkbs2zPAVZTCWj0WGY4i79jD8VhS7Onjew4F24aPTjNvdljQ0022W9verlfdhy4Rb3z2VnlBSi2PnQB525XW9TipoJt6AWTuqmvJbhVMvrz3lhDpMQVkovWvVxinCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=REi3cfCU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="REi3cfCU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TuIVDcZuJzoCwT1ZOsuB5NzdjH1SzRB+pSXSxMDUWpE=; b=REi3cfCUof3hFc32AU98C+iOK5
	XWxDzR7/7hF0xQKcwc7gaOXz93TUpEGPV1N3ayF1rNA57Z5wxKVdyIO4btANOLG007QwEDaw4TrE9
	c2Dfu8hMQCC0K2vGWZDjfYYVyG0o9ppzstfi0l573+HXkciw5cIvh3jE8jYOF2Begvic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOd9-005goR-KX; Tue, 02 Jun 2026 14:54:03 +0200
Date: Tue, 2 Jun 2026 14:54:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: Improve Tx timer arm logic further
Message-ID: <9730021d-0d8e-4728-abd8-7e722349ea33@lunn.ch>
References: <20260529064659.32287-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529064659.32287-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Thu, May 28, 2026 at 11:46:59PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Calling hrtimer_start() on an already-active txtimer is unnecessary
> and expensive. Skip the restart if the timer is already active by
> adding an hrtimer_active() check before hrtimer_start().
> 
> Previously, each packet reset the timer to tx_coal_timer in the future,
> acting as a sliding window that delayed NAPI under burst traffic. With
> this change, an already-active timer is left to fire sooner, scheduling
> NAPI within tx_coal_timer of the first packet and freeing TX descriptors
> earlier.
> 
> There is no race concern: hrtimer_start() is internally serialized and
> safe to call on an active timer. In the event of a race between
> hrtimer_active() and hrtimer_start(), the worst case is calling
> hrtimer_start() on an already-active timer, which is identical to the
> pre-patch behaviour.
> 
> Performance on Cyclone V with dwmac-socfpga (iperf3 -u -b 0 -l 64):
>   Before: ~45200 pps
>   After:  ~52300 pps (~15% improvement)
> 
> Additionally, ~10% improvement in UDP throughput observed on Agilex5,
> with hrtimer CPU usage reduced from ~8% to ~0.6%.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
