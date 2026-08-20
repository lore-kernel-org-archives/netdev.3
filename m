Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3FC463B74
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262330; cv=none; b=jrVmJBUqnWag8D84Zuk5P9QQAO6OfcGJW+Ek7JSBfapBOd59yvO025osU3kb0k6eduCIeGDLoJHRKa3p72T7cm8Jb2vlTWuhotnrBTTco67WAAUfH2LHJUuLlYl7qdiu3OSRNRDu8hLl2HqvtvM2x9sFUD+b5GO72SkMnh01mk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262330; c=relaxed/simple;
	bh=/f/BIBzUVAqxgggnbQPUPpyfJISD/3XWOfGX2blkEtg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCUaQTU54TyRfFMi4O4gP0Hf0OrFtiOMm93MCHULhxCRDkA/cyeslYr3TsZLQF3UkiW3YrEbM24xFgwQJAoliV3T5fBpYOEMjFMX2Fw/aTau6yDyAkyVt54nlMUaMRL+V3oNN/dqkbQNZm3w4wVwCcS7Ii6+f2Jtws9Lx+9Mmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfPjX6h3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfPjX6h3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2E31F000E9;
	Thu, 20 Aug 2026 21:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787262329;
	bh=4eAkh+9MDHG9RqYKYJgFw2VrMIEyWF85IrttsVxYYoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PfPjX6h3ZieTA0J/Nb9kfqZSr17Gezj08YfSg1S5PcaqPIB6KU/GaG4isyu8tX0Me
	 fkmYE/sV8fVlvutWgMgUEGIl97m0RAvq43SVvWz8wPX3BhjEJ2C394sfwr3256zkgs
	 dxcm383xc+QmJaCOBj5SeljaQZXTUj50HMJBaVRmYGB1TrXZEJNqnlQKgwNyCcbU4b
	 8qMqapQFSZ7ulaEu3KpfJHdGRkxCIDGT7qv0oEZEuWNgGRex2jvmvIL3sSrpZRqMFZ
	 SaAKmLVQXoWjehV1sImf5pLil1H7pd1QLC5YTzNX18FJEWx75BcsOL2REzCc38vwhM
	 KLyyI31DPDqKA==
Date: Thu, 20 Aug 2026 14:45:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH net-next] net: stmmac: stm32: Set TSO/TBS Tx queues
 default settings
Message-ID: <20260820144528.7107ba90@kernel.org>
In-Reply-To: <87h5kq1s1f.fsf@jax.kurt.home>
References: <20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de>
	<20260817103337.74c30adc@kernel.org>
	<87mrujzzjv.fsf@jax.kurt.home>
	<20260818075335.48936b08@kernel.org>
	<87h5kq1s1f.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 09:35:40 +0200 Kurt Kanzenbach wrote:
> >> I want to use ETF Qdisc with hardware offload, which is currently not
> >> possible on the stm32mp2.  
> >
> > Do you need multiple queues for ETF/normal traffic?
> > Or one ETF and one "normal"?
> >
> > How do you sort the traffic between the queues?  
> 
> So the stm32mp2 has two CPU cores. I've isolated CPU1 for Profinet. That
> one uses Tx/Rx queue 1 with ETF to reduce the Tx jitter. Everything else
> is routed to Tx/Rx queue 0.
> 
> Config looks like this:
> 
> #
> # Tx Assignment with SP.
> #
> # Tx Q 0 - Everything else
> # Tx Q 1 - RTC
> #
> tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 2 \
>   map 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 \
>   queues 1@0 1@1 \
>   hw 1
> 
> #
> # Enable Tx launch time support for TC 1.
> #
> tc qdisc replace dev ${INTERFACE} parent 100:2 etf \
>   clockid CLOCK_TAI \
>   delta 500000 \
>   offload
> 
> On Rx incoming frames are steered via PCP field (vlan tagged).

Thanks for explaining!

> >> It seems like a static configuration in the driver today. I basically
> >> followed the same convention as dwmac-imx, dwmac-intel, dwmac-mediatek
> >> and dwmac-qcom-ethqos. Only dwmac-socfpga does it differently.
> >> 
> >> Tx Launch Time requires a different DMA descriptor layout. Currently
> >> tc_setup_etf() just returns -EINVAL if the DMA configuration is not
> >> setup appropriately. I guess a dynamic configuration requires to change
> >> the DMA config and perform a full release/open cycle.  
> >
> > release/open is not ideal but still better than hardcoding?  
> 
> For sure it's better than hardcoding :). But, again the driver does it
> statically. Maybe there's a good reason for it. Maybe not. I'm not that
> familiar with the stmmac driver. I'll prototype something to see whether
> we can enable TBS at run time using the ETF Qdisc callback. It may take
> some time though.

I think the m in stmmac stand for 'mistake'. 
We need to start cleaning it up.
