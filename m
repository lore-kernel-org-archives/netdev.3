Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD723D4131;
	Thu,  8 Oct 2026 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445461; cv=none; b=gsuy5XZtr8P3cEjV6c6rCPd60YT3mSsxvmE2IFF3NUSUN+cvP0kHr4wSWHCMfsjWcPtD04cr7dZLhQzWWWPd4iJtcxXkoKoSFAih/GPfRf86wS0G7WCoMox5PO2rUoIX5185YBe2+nr+mDoRDeRveAUGlSfyzQpaidfZssPcKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445461; c=relaxed/simple;
	bh=/4CE+f3S935dZxQ3VOS3xjbg/ipYBnuacdoGnN5pBV8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=o4aupyt2Ju2tbAWSgKXNZO3JdRUewflxO/QDdG4wUsdHdl6BsQID/5mXUY2SBdHuaF2jj0EKipDXL871yvzcq73ZVkQxLsxPFpaQKeLA9NPjezzloCfgDlT5X9Bky5KJo3e2Is+8mzK30fQtAaHhyaXbCeypbgJkRQqqeLXQAE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=1/MMmLmA; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="1/MMmLmA"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F233A1418;
	Thu,  8 Oct 2026 09:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791445446; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/jTRzZld+L3TVjWQHhoQ9AM2EZ0IICu5bCyhuVoUrj8=;
	b=1/MMmLmALJZD+WS3tBRbEf0yJDQPDUcz7/mfaWcur61dQI7LIViZlr5GoLtWOZ6sex3OS2
	pzKpBgppNv4nMRBwwwYuFN8G4MCI+MKiemvqEEVN4ieWYNB8O6K7AUjQUg60+vKlLNzBch
	rtppaiuhLHO24m2ysY+zpHfQFi/2dn73aei24Vz+oX3828j3BVbXa0gkgMKHLWOfJZ6ci3
	NUxjAnbtoG0fpUEMT4EL+bGYyQ6qXdq5cSM2HYgPzuD+x19kHQNr3uJgB4uUcum4k8IyaR
	9rklWYT3nlKJkfuIFqh3JniUnNP1rvoIcKwrOx6dpgB3gRHlhhMR+llcFk6NeQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 09:44:03 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: James Clark <jjc@jclark.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Miroslav Lichvar <mlichvar@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: ptp: switch to gettimex64()
 interface
In-Reply-To: <20261006103610.98277-1-jjc@jclark.com>
References: <20261006103610.98277-1-jjc@jclark.com>
Message-ID: <573ab838519f1fcfc19b5c03c23aa72f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James

On 6.10.2026 12:36, James Clark wrote:
> The stmmac PTP support currently implements the gettime64 callback to
> retrieve the hardware clock time. Update the implementation to provide
> the gettimex64 callback instead, adding support for the
> PTP_SYS_OFFSET_EXTENDED ioctl.
> 
> The system clock readings are taken around the read of the nanoseconds
> register in get_systime(), so get_systime() gains a 
> ptp_system_timestamp
> argument. rmb() is used to ensure proper ordering on weakly ordered
> architectures.
> 
> Assisted-by: LLM
> Signed-off-by: James Clark <jjc@jclark.com>
> ---
> Tested on a Radxa ZERO 3E (RK3566, DWMAC 4/5) running net-next.
> Width of the interval between the two system clock readings
> bracketing each PHC read (2000 calls of 25 samples each):
> 
>                                          min      median
> Before patch (PTP_SYS_OFFSET):           875 ns   1167 ns
> After patch (PTP_SYS_OFFSET_EXTENDED):   291 ns    584 ns
> 
> On this board the 24 MHz arch timer counter advances in steps of 7
> (~292 ns), so all intervals are multiples of that.

> [...]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c

> [...]

> @@ -191,8 +192,14 @@ static void get_systime(void __iomem *ioaddr, u64 
> *systime)
>  	sec1 = readl_relaxed(ioaddr + PTP_STSR);
>  	do {
>  		sec0 = sec1;
> +		ptp_read_system_prets(sts);
> +		if (sts)
> +			rmb();
>  		/* Get the TSSS value */
>  		ns = readl_relaxed(ioaddr + PTP_STNSR);
> +		if (sts)
> +			rmb();
> +		ptp_read_system_postts(sts);

Additional thought while testing on my stm32mp2:

Would a plain readl() for PTP_STNSR be enough? readl() completes before
a following delay loop, which is the counter read postts does. That 
would
drop both barriers, like igb/ice/bnxt. Fine either way though, macb has
the same rmb() pattern.

Maxime (Chevallier), what do you think?

> [...]

Thanks,
Nicolai
